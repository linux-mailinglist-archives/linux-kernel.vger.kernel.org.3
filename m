Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BBC4FF82C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbiDMNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiDMNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:52:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEA91FCFB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 181A6B824C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09E9C385A3;
        Wed, 13 Apr 2022 13:49:48 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net
Subject: [PATCH RFC 0/4] mm, arm64: In-kernel support for memory-deny-write-execute (MDWE)
Date:   Wed, 13 Apr 2022 14:49:42 +0100
Message-Id: <20220413134946.2732468-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The background to this is that systemd has a configuration option called
MemoryDenyWriteExecute [1], implemented as a SECCOMP BPF filter. Its aim
is to prevent a user task from inadvertently creating an executable
mapping that is (or was) writeable. Since such BPF filter is stateless,
it cannot detect mappings that were previously writeable but
subsequently changed to read-only. Therefore the filter simply rejects
any mprotect(PROT_EXEC). The side-effect is that on arm64 with BTI
support (Branch Target Identification), the dynamic loader cannot change
an ELF section from PROT_EXEC to PROT_EXEC|PROT_BTI using mprotect().
For libraries, it can resort to unmapping and re-mapping but for the
main executable it does not have a file descriptor. The original bug
report in the Red Hat bugzilla - [2] - and subsequent glibc workaround
for libraries - [3].

Add in-kernel support for such feature as a DENY_WRITE_EXEC personality
flag, inherited on fork() and execve(). The kernel tracks a previously
writeable mapping via a new VM_WAS_WRITE flag (64-bit only
architectures). I went for a personality flag by analogy with the
READ_IMPLIES_EXEC one. However, I'm happy to change it to a prctl() if
we don't want more personality flags. A minor downside with the
personality flag is that there is no way for the user to query which
flags are supported, so in patch 3 I added an AT_FLAGS bit to advertise
this.

Posting this as an RFC to start a discussion and cc'ing some of the
systemd guys and those involved in the earlier thread around the glibc
workaround for dynamic libraries [4]. Before thinking of upstreaming
this we'd need the systemd folk to buy into replacing the MDWE SECCOMP
BPF filter with the in-kernel one.

Thanks,

Catalin

[1] https://www.freedesktop.org/software/systemd/man/systemd.exec.html#MemoryDenyWriteExecute=
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1888842
[3] https://sourceware.org/bugzilla/show_bug.cgi?id=26831
[3] https://lore.kernel.org/r/cover.1604393169.git.szabolcs.nagy@arm.com

Catalin Marinas (4):
  mm: Track previously writeable vma permission
  mm, personality: Implement memory-deny-write-execute as a personality
    flag
  fs/binfmt_elf: Tell user-space about the DENY_WRITE_EXEC personality
    flag
  arm64: Select ARCH_ENABLE_DENY_WRITE_EXEC

 arch/arm64/Kconfig               |  1 +
 fs/binfmt_elf.c                  |  2 ++
 include/linux/mm.h               |  6 ++++++
 include/linux/mman.h             | 18 +++++++++++++++++-
 include/uapi/linux/binfmts.h     |  4 ++++
 include/uapi/linux/personality.h |  1 +
 mm/Kconfig                       |  4 ++++
 mm/mmap.c                        |  3 +++
 mm/mprotect.c                    |  5 +++++
 9 files changed, 43 insertions(+), 1 deletion(-)


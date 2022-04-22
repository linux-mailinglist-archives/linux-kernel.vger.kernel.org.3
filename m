Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FC750B509
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446456AbiDVKb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350582AbiDVKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:31:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35954F83
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 542CF61E0B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F27C385A0;
        Fri, 22 Apr 2022 10:28:59 +0000 (UTC)
Date:   Fri, 22 Apr 2022 11:28:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-abi-devel@lists.sourceforge.net" 
        <linux-abi-devel@lists.sourceforge.net>
Subject: Re: [PATCH RFC 2/4] mm, personality: Implement
 memory-deny-write-execute as a personality flag
Message-ID: <YmKDaEaOpOaKl7m9@arm.com>
References: <20220413134946.2732468-1-catalin.marinas@arm.com>
 <20220413134946.2732468-3-catalin.marinas@arm.com>
 <443d978a-7092-b5b1-22f3-ae3a997080ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <443d978a-7092-b5b1-22f3-ae3a997080ad@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 06:37:49PM +0100, David Hildenbrand wrote:
> On 13.04.22 15:49, Catalin Marinas wrote:
> > The aim of such policy is to prevent a user task from inadvertently
> > creating an executable mapping that is or was writeable (and
> > subsequently made read-only).
> > 
> > An example of mmap() returning -EACCESS if the policy is enabled:
> > 
> > 	mmap(0, size, PROT_READ | PROT_WRITE | PROT_EXEC, flags, 0, 0);
> > 
> > Similarly, mprotect() would return -EACCESS below:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_WRITE | PROT_EXEC);
> > 
> > With the past vma writeable permission tracking, mprotect() below would
> > also fail with -EACCESS:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_WRITE, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_EXEC);
> > 
> > While the above could be achieved by checking PROT_WRITE & PROT_EXEC on
> > mmap/mprotect and denying mprotect(PROT_EXEC) altogether (current
> > systemd MDWE approach via SECCOMP BPF filters), we want the following
> > scenario to succeed:
> > 
> > 	addr = mmap(0, size, PROT_READ | PROT_EXEC, flags, 0, 0);
> > 	mprotect(addr, size, PROT_READ | PROT_EXEC | PROT_BTI);
> > 
> > where PROT_BTI enables branch tracking identification on arm64.
> > 
> > The choice for a DENY_WRITE_EXEC personality flag, inherited on fork()
> > and execve(), was made by analogy to READ_IMPLIES_EXEC.
> > 
> > Note that it is sufficient to check for VM_WAS_WRITE in
> > map_deny_write_exec() as this flag is always set on VM_WRITE mappings.
> > 
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> How does this interact with get_user_pages(FOLL_WRITE|FOLL_FORCE) on a
> VMA that is VM_MAYWRITE but not VM_WRITE? Is it handled accordingly?

For now, that's just about VM_WRITE. Most vmas are VM_MAYWRITE, so we
can't really have MAYWRITE^EXEC. The basic feature aims to avoid user
vulnerabilities where a buffer is mapped both writeable and executable.
Of course, it can be expanded with additional prctl() flags to cover
other cases.

> Note that in the (FOLL_WRITE|FOLL_FORCE) we only require VM_MAYWRITE on
> the vma and trigger a write fault. As the VMA is not VM_WRITE, we won't
> actually map the PTE writable, but set it dirty. GUP will retry, find a
> R/O pte that is dirty and where it knows that it broke COW and will
> allow the read access, although the PTE is R/O.
> 
> That mechanism is required to e.g., set breakpoints in R/O MAP_PRIVATE
> kernel sections, but it's used elsewhere for page pinning as well.
> 
> My gut feeling is that GUP(FOLL_WRITE|FOLL_FORCE) could be used right
> now to bypass that mechanism, I might be wrong.

GUP can be used to bypass this. But if an attacker can trigger such GUP
paths via a syscall (e.g. ptrace(PTRACE_POKEDATA)), I think we need the
checks on those paths (and reject the syscall) rather than on
mmap/mprotect(). This would be covered by something like CAP_SYS_PTRACE.

Not sure what would break if we prevent GUP(FOLL_WRITE|FOLL_FORCE) when
the vma is !VM_WRITE, basically removing FOLL_FORCE. I guess for
ptrace() and uprobes that's fine. We could also make this only about
VM_EXEC rather than VM_WRITE, though  we'd probably need to set
VM_WAS_WRITE if we ever had a GUP(FOLL_WRITE|FOLL_FORCE) in order to
prevent a subsequent mprotect(PROT_EXEC).

Anyway, this can be a new flag. My first aim is to get the basics
working similarly to systemd's MDWE.

-- 
Catalin

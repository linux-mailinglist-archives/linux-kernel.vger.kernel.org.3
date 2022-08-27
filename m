Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BD5A33B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbiH0CIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiH0CIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:08:13 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F07C0B5E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:08:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 5BDEF40D403D;
        Sat, 27 Aug 2022 02:08:11 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v6 0/5] Parse CONFIG_CMDLINE in compressed kernel
Date:   Sat, 27 Aug 2022 05:08:05 +0300
Message-Id: <cover.1661565218.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE were ignored during
options lookup in compressed kernel, including earlyprintk option,
so it was impossible to get earlyprintk messages from that stage
of boot process via command line provided at compile time.
Being able to enable earlyprintk via compile-time option might
be desirable for booting on systems with broken UEFI command line
arguments via EFISTUB.

Changes in v2:

* Compute resulting cmdline string once if needed and then reuse it.
  Store concatenation result in a static buffer.
* Add strlcat() to compressed kernel to simplify the code.

Changes in v3:

v2 had a bug: cmd_line_ptr was set to a pointer to a buffer inside
a kernel before kernel relocation, that makes this pointer invalid.

* Replace the pointer by a boolean variable to avoid storing a pointer,
  since it becomes invalid during kernel relocation.

Changes in v4:

* Use better wording for commit messages.
* Add buffer overflow check to strlcat().
* Factor out common logic of cmdline resolving into helper function.

Changes in v5:

* Use strscpy() instead of strlcpy().

Changes in v6:

* Remove superfluous new line.
* Rename resolve_cmdline() to cmdline_prepare().
* Move shared/setup-cmdline.h to shared/cmdline.h

Evgeniy Baskov (5):
  x86/boot: Add strlcat() and strscpy() to compressed kernel
  x86: Add cmdline_prepare() helper
  x86/setup: Use cmdline_prepare() in setup.c
  x86/boot: Use cmdline_prapare() in compressed kernel
  x86/boot: Remove no longer needed includes

 arch/x86/boot/compressed/cmdline.c      | 24 +++++++++++-
 arch/x86/boot/compressed/ident_map_64.c |  4 --
 arch/x86/boot/compressed/kaslr.c        |  4 --
 arch/x86/boot/compressed/misc.h         |  1 +
 arch/x86/boot/compressed/string.c       | 50 +++++++++++++++++++++++++
 arch/x86/include/asm/shared/cmdline.h   | 37 ++++++++++++++++++
 arch/x86/kernel/setup.c                 | 22 ++---------
 arch/x86/purgatory/purgatory.c          |  1 +
 8 files changed, 115 insertions(+), 28 deletions(-)
 create mode 100644 arch/x86/include/asm/shared/cmdline.h

-- 
2.37.2


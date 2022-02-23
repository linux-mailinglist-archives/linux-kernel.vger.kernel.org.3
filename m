Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F54C1BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243072AbiBWTRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbiBWTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:17:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB934348B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:17:17 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71F331EC053C;
        Wed, 23 Feb 2022 20:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645643836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hjw2+2xG+PUcp2i36O6tpmMB/c2b3gqlzwFwf3He0pk=;
        b=F6jbelnTV1fi6Oil86/SNIfHhFvHrvdLzEzVte1TwPs9CDt7co3NiKFXk1Xn63LKGIDuWa
        YG9WG6MmaL9AdAi3YKMTXSI0oDFXz8jJ49cMnz5vP2a1Lfy/DiyLFbgCEbC1tFZgk5att5
        YR4khzghPyK+NCB7Ictor99SKxAimDY=
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brijesh Singh <brijesh.singh@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com
Subject: [PATCH 1/4] x86/cc: Move arch/x86/{kernel/cc_platform.c => coco/core.c}
Date:   Wed, 23 Feb 2022 20:17:20 +0100
Message-Id: <20220223191723.22937-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <YhaGuEgG9+UlGwIU@zn.tnic>
References: <YhaGuEgG9+UlGwIU@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Move cc_platform.c to arch/x86/coco/. The directory is going to be the
home space for code related to confidential computing.

Intel TDX code will land here. AMD SEV code will also eventually be
moved there.

No functional changes.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20220222185740.26228-3-kirill.shutemov@linux.intel.com
---
 arch/x86/Kbuild                                | 2 ++
 arch/x86/coco/Makefile                         | 6 ++++++
 arch/x86/{kernel/cc_platform.c => coco/core.c} | 0
 arch/x86/kernel/Makefile                       | 5 -----
 4 files changed, 8 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/coco/Makefile
 rename arch/x86/{kernel/cc_platform.c => coco/core.c} (100%)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index f384cb1a4f7a..5a83da703e87 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
+
 obj-y += entry/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
new file mode 100644
index 000000000000..c1ead00017a7
--- /dev/null
+++ b/arch/x86/coco/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS_REMOVE_core.o	= -pg
+KASAN_SANITIZE_core.o	:= n
+CFLAGS_core.o		+= -fno-stack-protector
+
+obj-y += core.o
diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/coco/core.c
similarity index 100%
rename from arch/x86/kernel/cc_platform.c
rename to arch/x86/coco/core.c
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 6aef9ee28a39..6462e3dd98f4 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,7 +21,6 @@ CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
-CFLAGS_REMOVE_cc_platform.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -30,7 +29,6 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 KASAN_SANITIZE_sev.o					:= n
-KASAN_SANITIZE_cc_platform.o				:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -49,7 +47,6 @@ endif
 KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
-CFLAGS_cc_platform.o	+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
@@ -151,8 +148,6 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
-obj-$(CONFIG_ARCH_HAS_CC_PLATFORM)	+= cc_platform.o
-
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D56509E35
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388697AbiDULGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbiDULGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:06:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C672826120
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:03:53 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id s14so4502094plk.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU52MclEwC/JClFIoqUATh//8GyTS/C682uiQ12oigw=;
        b=kSQO15fZEWQz5yBDxaU+/HJM8UdGlHhWl+TDYudl+j5cxrxjS+j1QGtpNBIC1vB+Pg
         WsyQUflR0QW31giD9dmYhTRkIxgkQBrEMPGfRbN7G+50gY/tDcY4gEDHNKoUpbd4Ezt9
         Ym6r7kxi+ed53R3K4RoWAYHf/dSGkaDnCBcwoJYIAgi+qn34ti/Jw6+RG9ZkJdMKRMAQ
         SP//n53t0s0+xvM/iQADLs63gKAvUw6+3rrdcdZ0bwcJoRV+jNQ0v5UKrpobFq7/VcD9
         zIoj6Polt5limwKqhA5Z/EuX1OK2FYexYyL3uS1TGJe0tm5+av7bDyrlAVpQufR/bMK6
         98IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fU52MclEwC/JClFIoqUATh//8GyTS/C682uiQ12oigw=;
        b=xT7uSimL+L5bIGuNYLK57DJPl7MmQqg+gc/4pAyI0MBo1iy6b6axPYnXeaT7JtKCT6
         hcGxo07ECVmiW1YGcQyOzYyisULQdzEA0K4vC8yF5JpDTnwX0NpMWpZzy1UuQpirNift
         KTDvm3BJ1EMhjITtIFRXbO+N/mH4MPcrVL+jTAFnsYkf57F045vOmbmBdGMe4FPaLWHH
         DmUA+W60tgovn+YrSKf7TgseEpIGn0Lf0mU1ev26f6IY6xSe9/VqyucmxnJ2wWXaZF47
         QAlFW1EU+5CdRTjIqI2WrdkP2cht25qbBs1RLa4PCS4CYyzlprpKgNxIwYMgjaWpR9t6
         Nf/A==
X-Gm-Message-State: AOAM532/mXmS85LNlNM/1aWYu6z9azLa1/71epvVV1Ox2jVWss9Q5TTC
        0g7vXaD972AhgYqw+WgkyOU=
X-Google-Smtp-Source: ABdhPJzF6LZY0szl/e/slrmwKEY/oUA4wOH7TXp6E8KA/mPE/XED0U5JNkokpKVHDAABDjPq7FEp+w==
X-Received: by 2002:a17:90b:1809:b0:1d2:6345:b000 with SMTP id lw9-20020a17090b180900b001d26345b000mr9971420pjb.98.1650539033236;
        Thu, 21 Apr 2022 04:03:53 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id g15-20020a63be4f000000b0039934531e95sm22461750pgo.18.2022.04.21.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 04:03:51 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add hibernation support
Date:   Thu, 21 Apr 2022 04:03:42 -0700
Message-Id: <20220421110342.266853-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define ARCH_HIBERNATION_POSSIBLE in Kconfig and implement hibernation
callbacks.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig              |  3 ++
 arch/xtensa/kernel/Makefile      |  1 +
 arch/xtensa/kernel/asm-offsets.c |  8 +++
 arch/xtensa/kernel/entry.S       | 92 ++++++++++++++++++++++++++++++++
 arch/xtensa/kernel/hibernate.c   | 25 +++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 arch/xtensa/kernel/hibernate.c

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index c87f5ab493d9..2cc8941e5f03 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -788,6 +788,9 @@ endmenu
 
 menu "Power management options"
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+
 source "kernel/power/Kconfig"
 
 endmenu
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index 5fd6cd15e0fb..897c1c741058 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_XTENSA_VARIANT_HAVE_PERF_EVENTS) += perf_event.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
 obj-$(CONFIG_S32C1I_SELFTEST) += s32c1i_selftest.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
+obj-$(CONFIG_HIBERNATION) += hibernate.o
 
 # In the Xtensa architecture, assembly generates literals which must always
 # precede the L32R instruction with a relative offset less than 256 kB.
diff --git a/arch/xtensa/kernel/asm-offsets.c b/arch/xtensa/kernel/asm-offsets.c
index e3b9cf4c2289..9a1db6ffcbf4 100644
--- a/arch/xtensa/kernel/asm-offsets.c
+++ b/arch/xtensa/kernel/asm-offsets.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/mm.h>
 #include <linux/kbuild.h>
+#include <linux/suspend.h>
 
 #include <asm/ptrace.h>
 #include <asm/traps.h>
@@ -149,5 +150,12 @@ int main(void)
 	       offsetof(struct exc_table, fast_kernel_handler));
 	DEFINE(EXC_TABLE_DEFAULT, offsetof(struct exc_table, default_handler));
 
+#ifdef CONFIG_HIBERNATION
+	DEFINE(PBE_ADDRESS, offsetof(struct pbe, address));
+	DEFINE(PBE_ORIG_ADDRESS, offsetof(struct pbe, orig_address));
+	DEFINE(PBE_NEXT, offsetof(struct pbe, next));
+	DEFINE(PBE_SIZE, sizeof(struct pbe));
+#endif
+
 	return 0;
 }
diff --git a/arch/xtensa/kernel/entry.S b/arch/xtensa/kernel/entry.S
index 3255d4f61844..d703ed31254a 100644
--- a/arch/xtensa/kernel/entry.S
+++ b/arch/xtensa/kernel/entry.S
@@ -2155,3 +2155,95 @@ ENTRY(ret_from_kernel_thread)
 	j		common_exception_return
 
 ENDPROC(ret_from_kernel_thread)
+
+#ifdef CONFIG_HIBERNATION
+
+	.bss
+	.align	4
+.Lsaved_regs:
+#if defined(__XTENSA_WINDOWED_ABI__)
+	.fill	2, 4
+#elif defined(__XTENSA_CALL0_ABI__)
+	.fill	6, 4
+#else
+#error Unsupported Xtensa ABI
+#endif
+	.align	XCHAL_NCP_SA_ALIGN
+.Lsaved_user_regs:
+	.fill	XTREGS_USER_SIZE, 1
+
+	.previous
+
+ENTRY(swsusp_arch_suspend)
+
+	abi_entry_default
+
+	movi		a2, .Lsaved_regs
+	movi		a3, .Lsaved_user_regs
+	s32i		a0, a2, 0
+	s32i		a1, a2, 4
+	save_xtregs_user a3 a4 a5 a6 a7 a8 0
+#if defined(__XTENSA_WINDOWED_ABI__)
+	spill_registers_kernel
+#elif defined(__XTENSA_CALL0_ABI__)
+	s32i		a12, a2, 8
+	s32i		a13, a2, 12
+	s32i		a14, a2, 16
+	s32i		a15, a2, 20
+#else
+#error Unsupported Xtensa ABI
+#endif
+	abi_call	swsusp_save
+	mov		a2, abi_rv
+	abi_ret_default
+
+ENDPROC(swsusp_arch_suspend)
+
+ENTRY(swsusp_arch_resume)
+
+	abi_entry_default
+
+#if defined(__XTENSA_WINDOWED_ABI__)
+	spill_registers_kernel
+#endif
+
+	movi		a2, restore_pblist
+	l32i		a2, a2, 0
+
+.Lcopy_pbe:
+	l32i		a3, a2, PBE_ADDRESS
+	l32i		a4, a2, PBE_ORIG_ADDRESS
+
+	__loopi		a3, a9, PAGE_SIZE, 16
+	l32i		a5, a3, 0
+	l32i		a6, a3, 4
+	l32i		a7, a3, 8
+	l32i		a8, a3, 12
+	addi		a3, a3, 16
+	s32i		a5, a4, 0
+	s32i		a6, a4, 4
+	s32i		a7, a4, 8
+	s32i		a8, a4, 12
+	addi		a4, a4, 16
+	__endl		a3, a9
+
+	l32i		a2, a2, PBE_NEXT
+	bnez		a2, .Lcopy_pbe
+
+	movi		a2, .Lsaved_regs
+	movi		a3, .Lsaved_user_regs
+	l32i		a0, a2, 0
+	l32i		a1, a2, 4
+	load_xtregs_user a3 a4 a5 a6 a7 a8 0
+#if defined(__XTENSA_CALL0_ABI__)
+	l32i		a12, a2, 8
+	l32i		a13, a2, 12
+	l32i		a14, a2, 16
+	l32i		a15, a2, 20
+#endif
+	movi		a2, 0
+	abi_ret_default
+
+ENDPROC(swsusp_arch_resume)
+
+#endif
diff --git a/arch/xtensa/kernel/hibernate.c b/arch/xtensa/kernel/hibernate.c
new file mode 100644
index 000000000000..06984327d6e2
--- /dev/null
+++ b/arch/xtensa/kernel/hibernate.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/coprocessor.h>
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = PFN_DOWN(__pa(&__nosave_begin));
+	unsigned long nosave_end_pfn = PFN_UP(__pa(&__nosave_end));
+
+	return	(pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+void notrace save_processor_state(void)
+{
+	WARN_ON(num_online_cpus() != 1);
+#if XTENSA_HAVE_COPROCESSORS
+	local_coprocessors_flush_release_all();
+#endif
+}
+
+void notrace restore_processor_state(void)
+{
+}
-- 
2.30.2


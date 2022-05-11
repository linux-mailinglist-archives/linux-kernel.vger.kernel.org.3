Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B26E5233E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243591AbiEKNSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243317AbiEKNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:18:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADC5DA0D01
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:17:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D2381042;
        Wed, 11 May 2022 06:17:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 562763F66F;
        Wed, 11 May 2022 06:17:47 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH 1/2] arch: make TRACE_IRQFLAGS_NMI_SUPPORT generic
Date:   Wed, 11 May 2022 14:17:32 +0100
Message-Id: <20220511131733.4074499-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511131733.4074499-1-mark.rutland@arm.com>
References: <20220511131733.4074499-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On most architectures, IRQ flag tracing is disabled in NMI context, and
architectures need to define and select TRACE_IRQFLAGS_NMI_SUPPORT in
order to enable this.

Commit:

  859d069ee1ddd878 ("lockdep: Prepare for NMI IRQ state tracking")

Permitted IRQ flag tracing in NMI context, allowing lockdep to work in
NMI context where an architecture had suitable entry logic. At the time,
most architectures did not have such suitable entry logic, and this broke
lockdep on such architectures. Thus, this was partially disabled in
commit:

  ed00495333ccc80f ("locking/lockdep: Fix TRACE_IRQFLAGS vs. NMIs")

... with architectures needing to select TRACE_IRQFLAGS_NMI_SUPPORT to
enable IRQ flag tracing in NMI context.

Currently TRACE_IRQFLAGS_NMI_SUPPORT is defined under
arch/x86/Kconfig.debug. Move it to arch/Kconfig so architectures can
select it without having to provide their own definition.

Since the regular TRACE_IRQFLAGS_SUPPORT is selected by
arch/x86/Kconfig, the select of TRACE_IRQFLAGS_NMI_SUPPORT is moved
there too.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/Kconfig           | 3 +++
 arch/x86/Kconfig       | 1 +
 arch/x86/Kconfig.debug | 3 ---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 31c4fdc4a4baa..ab45e0f6c21bf 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -214,6 +214,9 @@ config HAVE_FUNCTION_DESCRIPTORS
 config TRACE_IRQFLAGS_SUPPORT
 	bool
 
+config TRACE_IRQFLAGS_NMI_SUPPORT
+	bool
+
 #
 # An arch should select this if it provides all these things:
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d1..9b4559a1c65d4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -272,6 +272,7 @@ config X86
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
 	select TRACE_IRQFLAGS_SUPPORT
+	select TRACE_IRQFLAGS_NMI_SUPPORT
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select HAVE_ARCH_KCSAN			if X86_64
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d3a6f74a94bdf..d4d6db4dde220 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config TRACE_IRQFLAGS_NMI_SUPPORT
-	def_bool y
-
 config EARLY_PRINTK_USB
 	bool
 
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2095480575
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 02:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhL1BGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 20:06:15 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39094 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234281AbhL1BGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 20:06:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=ashimida@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0V0.tzGd_1640653565;
Received: from localhost(mailfrom:ashimida@linux.alibaba.com fp:SMTPD_---0V0.tzGd_1640653565)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 09:06:11 +0800
From:   Dan Li <ashimida@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        samitolvanen@google.com, maz@kernel.org, joey.gouly@arm.com,
        pcc@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Dan Li <ashimida@linux.alibaba.com>
Subject: [PATCH] [RFC] aarch64: scs: reload shadow call stack in user exception entry
Date:   Mon, 27 Dec 2021 17:06:04 -0800
Message-Id: <20211228010604.109572-1-ashimida@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When el0 exception occurs, kernel_entry/exit will load/save tsk->scs_sp
to ensure scs working properly. AFAIK, the SCS offset should always be
0 at this time.

Is it reasonable to reload x18 to scs_base directly in kernel_entry
here, or am I missing something?

Signed-off-by: Dan Li <ashimida@linux.alibaba.com>
---
 arch/arm64/include/asm/scs.h | 7 +++++++
 arch/arm64/kernel/entry.S    | 3 +--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
index 8297bccf0784..2bc0d0575e75 100644
--- a/arch/arm64/include/asm/scs.h
+++ b/arch/arm64/include/asm/scs.h
@@ -9,6 +9,10 @@
 #ifdef CONFIG_SHADOW_CALL_STACK
 	scs_sp	.req	x18
 
+	.macro scs_reload tsk
+	ldr	scs_sp, [\tsk, #TSK_TI_SCS_BASE]
+	.endm
+
 	.macro scs_load tsk
 	ldr	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
@@ -17,6 +21,9 @@
 	str	scs_sp, [\tsk, #TSK_TI_SCS_SP]
 	.endm
 #else
+	.macro scs_reload tsk
+	.endm
+
 	.macro scs_load tsk
 	.endm
 
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index bc6d5a970a13..57547a3e4f7c 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -265,7 +265,7 @@ alternative_if ARM64_HAS_ADDRESS_AUTH
 alternative_else_nop_endif
 1:
 
-	scs_load tsk
+	scs_reload tsk
 	.else
 	add	x21, sp, #PT_REGS_SIZE
 	get_current_task tsk
@@ -365,7 +365,6 @@ alternative_if ARM64_WORKAROUND_845719
 alternative_else_nop_endif
 #endif
 3:
-	scs_save tsk
 
 	/* Ignore asynchronous tag check faults in the uaccess routines */
 	ldr	x0, [tsk, THREAD_SCTLR_USER]
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1346F996
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhLJD0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:26:08 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:59156 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231207AbhLJD0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:26:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V-6f21h_1639106530;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V-6f21h_1639106530)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Dec 2021 11:22:31 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Li Yang <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] x86: Use rdmsrl instead of rdmsr
Date:   Fri, 10 Dec 2021 11:22:07 +0800
Message-Id: <20211210032208.28240-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Yang <yang.lee@linux.alibaba.com>

In the current scenario, variable 'hi' set but not used,
rdmsrl() does not change the function, but it is more concise.

Eliminate the following clang warnings:
arch/x86/kernel/process.c:889:10: warning: variable 'hi' set but not
used [-Wunused-but-set-variable]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Li Yang <yang.lee@linux.alibaba.com>
---
 arch/x86/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5d481038fe0b..b415f30278d1 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -886,7 +886,7 @@ void amd_e400_c1e_apic_setup(void)
 
 void __init arch_post_acpi_subsys_init(void)
 {
-	u32 lo, hi;
+	u32 lo;
 
 	if (!boot_cpu_has_bug(X86_BUG_AMD_E400))
 		return;
@@ -896,7 +896,7 @@ void __init arch_post_acpi_subsys_init(void)
 	 * the machine is affected K8_INTP_C1E_ACTIVE_MASK bits are set in
 	 * MSR_K8_INT_PENDING_MSG.
 	 */
-	rdmsr(MSR_K8_INT_PENDING_MSG, lo, hi);
+	rdmsrl(MSR_K8_INT_PENDING_MSG, lo);
 	if (!(lo & K8_INTP_C1E_ACTIVE_MASK))
 		return;
 
-- 
2.34.0


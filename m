Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFEE562C3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiGAHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiGAHFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:05:54 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [210.0.225.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B55677C2;
        Fri,  1 Jul 2022 00:05:53 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 1 Jul
 2022 15:05:49 +0800
Received: from tony-HX002EA0.zhaoxin.com (10.32.64.1) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Fri, 1 Jul
 2022 15:05:47 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TimGuo@zhaoxin.com>, <LindaChai@zhaoxin.com>, <LeoLiu@zhaoxin.com>
Subject: [PATCH] x86/cstate: Replace vendor check with X86_FEATURE_MWAIT in ffh_cstate_init
Date:   Fri, 1 Jul 2022 15:05:47 +0800
Message-ID: <1656659147-20396-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.1]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original commit 991528d73486 ("ACPI: Processor native C-states using
MWAIT") has a vendor check for Intel in the function of ffh_cstate_init().

Commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
systems") and commit 280b68a3b3b9 ("x86/cstate: Allow ACPI C1 FFH MWAIT
use on Hygon systems") add vendor check for AMD and HYGON in the function
of ffh_cstate_init().

Recent Zhaoxin and Centaur CPUs support MONITOR/MWAIT instructions that
can be used for ACPI Cx state in the same way as Intel. So expected to
add the support of these CPUs in the function of ffh_cstate_init() too.

The CPU feature X86_FEATURE_MWAIT indicates processor supports MONITOR/
MWAIT instructions. So the check for many CPU vendors in ffh_cstate_init()
is unnecessary, use X86_FEATURE_MWAIT to replace the CPU vendor check.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/acpi/cstate.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 7945eae..a64c38f 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -209,11 +209,7 @@ EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_enter);
 
 static int __init ffh_cstate_init(void)
 {
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-
-	if (c->x86_vendor != X86_VENDOR_INTEL &&
-	    c->x86_vendor != X86_VENDOR_AMD &&
-	    c->x86_vendor != X86_VENDOR_HYGON)
+	if (!boot_cpu_has(X86_FEATURE_MWAIT))
 		return -1;
 
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
-- 
2.7.4


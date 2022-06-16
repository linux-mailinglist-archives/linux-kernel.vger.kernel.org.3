Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A054E0E7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiFPMgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 08:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiFPMgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:36:09 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCF1522EF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 05:36:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VGaLZ.H_1655382938;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VGaLZ.H_1655382938)
          by smtp.aliyun-inc.com;
          Thu, 16 Jun 2022 20:36:02 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: cpufeature: make sure cpu_mitigations_off then kpti off
Date:   Thu, 16 Jun 2022 20:35:38 +0800
Message-Id: <1655382938-126283-1-git-send-email-liusong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Song <liusong@linux.alibaba.com>

If kaslr is enabled, kpti cannot be turned off even if "mitigations=off",
adjust the code order to ensure that kpti is off when "mitigations=off".

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 arch/arm64/kernel/cpufeature.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 42ea2bd..27d4850 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1616,6 +1616,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		__kpti_forced = -1;
 	}
 
+	if (cpu_mitigations_off() && !__kpti_forced) {
+		str = "mitigations=off";
+		__kpti_forced = -1;
+	}
+
 	/* Useful for KASLR robustness */
 	if (kaslr_requires_kpti()) {
 		if (!__kpti_forced) {
@@ -1624,11 +1629,6 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		}
 	}
 
-	if (cpu_mitigations_off() && !__kpti_forced) {
-		str = "mitigations=off";
-		__kpti_forced = -1;
-	}
-
 	if (!IS_ENABLED(CONFIG_UNMAP_KERNEL_AT_EL0)) {
 		pr_info_once("kernel page table isolation disabled by kernel configuration\n");
 		return false;
-- 
1.8.3.1


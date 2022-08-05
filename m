Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E213858A8A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiHEJWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiHEJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:22:01 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7B7390A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:21:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VLQfg.m_1659691274;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VLQfg.m_1659691274)
          by smtp.aliyun-inc.com;
          Fri, 05 Aug 2022 17:21:52 +0800
From:   Liu Song <liusong@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: spectre: increase parameters that can be used to turn off bhb mitigation individually
Date:   Fri,  5 Aug 2022 17:21:14 +0800
Message-Id: <1659691274-48554-1-git-send-email-liusong@linux.alibaba.com>
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

In our environment, it was found that the mitigation BHB has a great
impact on the benchmark performance. For example, in the lmbench test,
the "process fork && exit" test performance drops by 20%.
So it is necessary to have the ability to turn off the mitigation
individually through cmdline, thus avoiding having to compile the
kernel by adjusting the config.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 arch/arm64/kernel/proton-pack.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 40be3a7..bd16903 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -988,6 +988,14 @@ static void this_cpu_set_vectors(enum arm64_bp_harden_el1_vectors slot)
 	isb();
 }
 
+static bool __read_mostly __nospectre_bhb;
+static int __init parse_spectre_bhb_param(char *str)
+{
+	__nospectre_bhb = true;
+	return 0;
+}
+early_param("nospectre_bhb", parse_spectre_bhb_param);
+
 void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 {
 	bp_hardening_cb_t cpu_cb;
@@ -1001,7 +1009,7 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 		/* No point mitigating Spectre-BHB alone. */
 	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
 		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
-	} else if (cpu_mitigations_off()) {
+	} else if (cpu_mitigations_off() || __nospectre_bhb) {
 		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
 		state = SPECTRE_MITIGATED;
-- 
1.8.3.1


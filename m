Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887C25A0F78
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239962AbiHYLmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHYLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:42:29 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BB1AB197
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:42:26 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 27PBeRiT006924
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Thu, 25 Aug 2022 19:40:27 +0800 (CST)
        (envelope-from Xuewen.Yan@unisoc.com)
Received: from BJ10918PCW.spreadtrum.com (10.0.74.50) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 25 Aug 2022 19:40:28 +0800
From:   Xuewen Yan <xuewen.yan@unisoc.com>
To:     <viresh.kumar@linaro.org>, <lukasz.luba@arm.com>,
        <amit.kachhap@gmail.com>, <daniel.lezcano@linaro.org>,
        <rafael@kernel.org>
CC:     <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <xuewen.yan94@gmail.com>, <di.shen@unisoc.com>
Subject: [PATCH] thermal: Check the policy first in cpufreq_cooling_register
Date:   Thu, 25 Aug 2022 19:40:17 +0800
Message-ID: <20220825114018.1715-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.50]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 27PBeRiT006924
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the policy needs to be accessed first when obtaining cpu devices,
first check whether the policy is legal before this.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 drivers/thermal/cpufreq_cooling.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b76293cc989c..7838b6e2dba5 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -501,17 +501,17 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device_ops *cooling_ops;
 	char *name;
 
+	if (IS_ERR_OR_NULL(policy)) {
+		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
+		return ERR_PTR(-EINVAL);
+	}
+
 	dev = get_cpu_device(policy->cpu);
 	if (unlikely(!dev)) {
 		pr_warn("No cpu device for cpu %d\n", policy->cpu);
 		return ERR_PTR(-ENODEV);
 	}
 
-	if (IS_ERR_OR_NULL(policy)) {
-		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
-		return ERR_PTR(-EINVAL);
-	}
-
 	i = cpufreq_table_count_valid_entries(policy);
 	if (!i) {
 		pr_debug("%s: CPUFreq table not found or has no valid entries\n",
-- 
2.25.1


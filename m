Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B3354CA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353732AbiFON5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352074AbiFON5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:57:22 -0400
Received: from mail-m965.mail.126.com (mail-m965.mail.126.com [123.126.96.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 172BF31918;
        Wed, 15 Jun 2022 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PWMqj
        BMK+HYiHewTHpvcWjrBmC/QgILGR1TmenH+otI=; b=jopf4CL9ObIpi5RdSsx+o
        b5FCBQLC3W+Ioq5u/k3coKCXFmSCk82se9adu+iPZH2q5J6/nITHxZ3GWHpyM1cj
        rFz0zen9jzUwmtznIBnPr35hPf6gB9jWMT4C3pKBFEakknDFqex7eXg5gWvjKGa3
        SjpHyQ1gAJauOpi+lQhA8A=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp10 (Coremail) with SMTP id NuRpCgCX91ss5ali8GzJEg--.48359S2;
        Wed, 15 Jun 2022 21:57:01 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH v2] soc: samsung: Add missing of_node_put in exynos-pmu.c
Date:   Wed, 15 Jun 2022 21:56:59 +0800
Message-Id: <20220615135659.3967956-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NuRpCgCX91ss5ali8GzJEg--.48359S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry8Xry3Gw17uw1kZr13Arb_yoWkKrg_W3
        W8WFW7WF4Yqr4xZ39rCFn8u3s09F1fW3sIvFWIgrnxJw4DZr1UJFWvvr9xAa4xZFW7uFyD
        Ar4DZrWS9r47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizg0hF18RPTF4zwAAsA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In exynos_get_pmu_regmap(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
for that node pointer. We need a similar code logic in the function
syscon_regmap_lookup_by_compatible().

Signed-off-by: Liang He <windhl@126.com>
---
 changelog:
 v2: (1) use formal name; (2) add a blank line advised by Krzysztof
 v1: fix the missing of_node_put() problem

 drivers/soc/samsung/exynos-pmu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 732c86ce2be8..ad0a94d1d88d 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -108,9 +108,14 @@ struct regmap *exynos_get_pmu_regmap(void)
 {
 	struct device_node *np = of_find_matching_node(NULL,
 						      exynos_pmu_of_device_ids);
-	if (np)
-		return syscon_node_to_regmap(np);
-	return ERR_PTR(-ENODEV);
+	struct regmap *regmap;
+	
+	if (!np)
+		return ERR_PTR(-ENODEV);
+	
+	regmap = syscon_node_to_regmap(np);
+	of_node_put(np);
+	return regmap;
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
 
-- 
2.25.1


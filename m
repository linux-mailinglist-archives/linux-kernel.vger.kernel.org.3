Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D902054C407
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343630AbiFOIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbiFOIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 04:55:38 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636BC3D1EA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 01:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=FoyvE
        K5+1pRTQLkW/X2jHCeq//YHVhfHZeoFpXlqC70=; b=DXsrAcd8CxV3E3fiHvBps
        7rgQktf3PyXCdjGAVDn7xU4wTWmO1bp889/baGnPZbDevFiCL82MI7GIBOyD0Lb8
        wg/J8NMAB+mLKY68Xh+4ZPpylpCjz1ScVKEHwSYwRsNR9dc159Vvw/klBCLQeaZd
        CCZ0MVrJRJcBUyY+DRtemg=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgCXNXt+nqliOj0dEw--.42832S2;
        Wed, 15 Jun 2022 16:55:27 +0800 (CST)
From:   heliang <windhl@126.com>
To:     krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] soc: samsung: Add missing of_node_put in exynos-pmu.c
Date:   Wed, 15 Jun 2022 16:55:25 +0800
Message-Id: <20220615085525.3961330-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgCXNXt+nqliOj0dEw--.42832S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZry8Xry3Gw17uw1kZr13Arb_yoWDKrb_G3
        W8urW7XF4jqw4xXw4DCF9xu3s09F1fWasaqFWIqF9xAw4DZr4UJFWvvrnxA34xXrWUZFyD
        Ar4DZr4xCr47tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_znQ7UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizgMhF18RPS+3oQABsw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In exynos_get_pmu_regmap(), of_find_matching_node() will return a
node pointer with refcount incremented. We should use of_node_put()
for that node pointer. We need a similar code logic in the function
syscon_regmap_lookup_by_compatible().

Signed-off-by: heliang <windhl@126.com>
---
 drivers/soc/samsung/exynos-pmu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 732c86ce2be8..a44862c405a4 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -108,9 +108,13 @@ struct regmap *exynos_get_pmu_regmap(void)
 {
 	struct device_node *np = of_find_matching_node(NULL,
 						      exynos_pmu_of_device_ids);
-	if (np)
-		return syscon_node_to_regmap(np);
-	return ERR_PTR(-ENODEV);
+	struct regmap *regmap;
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


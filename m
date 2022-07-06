Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0248F56926F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbiGFTL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiGFTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:11:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706826105;
        Wed,  6 Jul 2022 12:11:51 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266JBjuR030432;
        Wed, 6 Jul 2022 14:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657134705;
        bh=O3lkEmVthYwZRzlXtb2PMAVKCngKejtmGHIt7SVtryU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s6vTQSfhX+IL2So9AQPZPbBg8nTNDAqHKU26xBtSIl90xoFcLwPyzlMlLMFj4db/g
         /jIeMfklIS8jH0hd+P6cRCGtD62vsXXGvdMwO1KJrYFvJ0i9LkQu4EJOPP8pwkIYJY
         EU8wWS6Weudv5O98gUiNEz9Vq//WeQOjqfyiC4OY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266JBjfn100939
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 14:11:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 14:11:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 14:11:45 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266JBiXU031227;
        Wed, 6 Jul 2022 14:11:45 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 2/2] crypto: sa2ul - Check engine status before enabling
Date:   Wed, 6 Jul 2022 14:11:44 -0500
Message-ID: <20220706191144.26437-2-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706191144.26437-1-afd@ti.com>
References: <20220706191144.26437-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a engine status register that can be used to check if the
different HW crypto engines are enabled. Check that first and then only
try to enable the engines if they are not already on.

This has a couple benefits. First we don't need to use match_data for
this. Second, this driver can now work on HS devices where the engine
control registers are read-only and writing causes a firewall exception.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/crypto/sa2ul.c | 15 +++++++--------
 drivers/crypto/sa2ul.h |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 1d732113b81ec..f4bc06c24ad8f 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -86,7 +86,6 @@ struct sa_match_data {
 	u8 priv;
 	u8 priv_id;
 	u32 supported_algos;
-	bool skip_engine_control;
 };
 
 static struct device *sa_k3_dev;
@@ -2380,7 +2379,6 @@ static struct sa_match_data am64_match_data = {
 			   BIT(SA_ALG_SHA256) |
 			   BIT(SA_ALG_SHA512) |
 			   BIT(SA_ALG_AUTHENC_SHA256_AES),
-	.skip_engine_control = true,
 };
 
 static const struct of_device_id of_match[] = {
@@ -2398,6 +2396,7 @@ static int sa_ul_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	static void __iomem *saul_base;
 	struct sa_crypto_data *dev_data;
+	u32 status, val;
 	int ret;
 
 	dev_data = devm_kzalloc(dev, sizeof(*dev_data), GFP_KERNEL);
@@ -2434,13 +2433,13 @@ static int sa_ul_probe(struct platform_device *pdev)
 
 	spin_lock_init(&dev_data->scid_lock);
 
-	if (!dev_data->match_data->skip_engine_control) {
-		u32 val = SA_EEC_ENCSS_EN | SA_EEC_AUTHSS_EN | SA_EEC_CTXCACH_EN |
-			  SA_EEC_CPPI_PORT_IN_EN | SA_EEC_CPPI_PORT_OUT_EN |
-			  SA_EEC_TRNG_EN;
-
+	val = SA_EEC_ENCSS_EN | SA_EEC_AUTHSS_EN | SA_EEC_CTXCACH_EN |
+	      SA_EEC_CPPI_PORT_IN_EN | SA_EEC_CPPI_PORT_OUT_EN |
+	      SA_EEC_TRNG_EN;
+	status = readl_relaxed(saul_base + SA_ENGINE_STATUS);
+	/* Only enable engines if all are not already enabled */
+	if (val & ~status)
 		writel_relaxed(val, saul_base + SA_ENGINE_ENABLE_CONTROL);
-	}
 
 	sa_register_algos(dev_data);
 
diff --git a/drivers/crypto/sa2ul.h b/drivers/crypto/sa2ul.h
index ed66d1f111db5..92bf97232a292 100644
--- a/drivers/crypto/sa2ul.h
+++ b/drivers/crypto/sa2ul.h
@@ -16,6 +16,7 @@
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
 
+#define SA_ENGINE_STATUS		0x0008
 #define SA_ENGINE_ENABLE_CONTROL	0x1000
 
 struct sa_tfm_ctx;
-- 
2.36.1


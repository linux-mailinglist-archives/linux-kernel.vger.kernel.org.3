Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823E1567522
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiGERDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGERDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:03:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A1D18E19;
        Tue,  5 Jul 2022 10:03:46 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 265H3gL9115920;
        Tue, 5 Jul 2022 12:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657040622;
        bh=O3lkEmVthYwZRzlXtb2PMAVKCngKejtmGHIt7SVtryU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pvb6ecWLgRBXp+2kS6AcRaRbr9w3DN1Xo7Wza6QMkohxkeeX1Ik6Roj5N9S4EoTwU
         fCbORnOMXxXjjz8ENkbtGsceiRRSjiKmBuJookDIRq9xMz6kt83PNi/AsiqLo3DxQg
         HIHH5KV3sMRsoo4A2WWfVSV+9+am03VHu7WwJLS0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 265H3goL083624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jul 2022 12:03:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Jul 2022 12:03:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Jul 2022 12:03:41 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 265H3e07118192;
        Tue, 5 Jul 2022 12:03:41 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 2/6] crypto: sa2ul - Check engine status before enabling
Date:   Tue, 5 Jul 2022 12:03:36 -0500
Message-ID: <20220705170340.26719-2-afd@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705170340.26719-1-afd@ti.com>
References: <20220705170340.26719-1-afd@ti.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962BF58CE64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244301AbiHHTNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244233AbiHHTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:13:52 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EBD1704D;
        Mon,  8 Aug 2022 12:13:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 278JDbh7053370;
        Mon, 8 Aug 2022 14:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1659986017;
        bh=X3u8l1aLdabCBhjFE9C1lW0DJg6QIkwSobh1afr7YbM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qciihBVn3V076SplEFrD0gg1DqCFE8PMSlmcJoo6aEDhV9QHHZbiG9Dw0m3iZQfPw
         phkCuJ3xNYXPTq04t5mHU1EvGlvJHmwhWiYayVVaUCnTpXYqZbOLfFFyLdVQ1e+OLT
         zxXikVeS53xGmY/GH5AlmPP8uwvrOgbK5klnNrS8=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 278JDbi8016521
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Aug 2022 14:13:37 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 8
 Aug 2022 14:13:37 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 8 Aug 2022 14:13:37 -0500
Received: from uda0500628.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 278JDaYS054740;
        Mon, 8 Aug 2022 14:13:37 -0500
From:   Daniel Parks <danielrparks@ti.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 5/6] crypto: sa2ul: turn on PKA engine
Date:   Mon, 8 Aug 2022 14:12:54 -0500
Message-ID: <e0b1efc3efdc98204dfcba4e5f936d83d35dda82.1659985696.git.danielrparks@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1659985696.git.danielrparks@ti.com>
References: <cover.1659985696.git.danielrparks@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SA2UL driver is responsible for enabling power to its subdevices
before enumerating them. In order to enable the PKA driver, we need to
turn on the power to it here.

Signed-off-by: Daniel Parks <danielrparks@ti.com>
---
 drivers/crypto/sa2ul.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 6957a125b447..f3dfb3e7eea7 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2428,9 +2428,9 @@ static int sa_ul_probe(struct platform_device *pdev)
 
 	if (!dev_data->match_data->skip_engine_control) {
 		u32 val = SA_EEC_ENCSS_EN | SA_EEC_AUTHSS_EN | SA_EEC_CTXCACH_EN |
 			  SA_EEC_CPPI_PORT_IN_EN | SA_EEC_CPPI_PORT_OUT_EN |
-			  SA_EEC_TRNG_EN;
+			  SA_EEC_TRNG_EN | SA_EEC_PKA_EN;
 
 		writel_relaxed(val, saul_base + SA_ENGINE_ENABLE_CONTROL);
 	}
 
-- 
2.17.1


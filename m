Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC421567523
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiGERD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiGERDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:03:47 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72D18E05;
        Tue,  5 Jul 2022 10:03:47 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 265H3fTf065045;
        Tue, 5 Jul 2022 12:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657040621;
        bh=QXTB59IGsyV3LDLti80N3e3Dx9HJ7ZNknQKypXn5bbc=;
        h=From:To:CC:Subject:Date;
        b=Qa5XruYE9T7kcIQsMtEXFIdeH1d1SVZIA9y++FKkW3iVtcgRCgSMh62f0IVB7HqiD
         1fqYgdBIXpoaznXv/cJoVy9sbxOZUl3J7FfBbq2gZ5aI89kDy+L4r8AKJvT2Vn9om4
         lYXGEJ8L9NFZ+5FVe+94ZETIRYQFEgNMmlO/KgWw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 265H3fAj083617
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jul 2022 12:03:41 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Jul 2022 12:03:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Jul 2022 12:03:41 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 265H3e06118192;
        Tue, 5 Jul 2022 12:03:40 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 1/6] crypto: sa2ul - Set the supported_algos bits individually
Date:   Tue, 5 Jul 2022 12:03:35 -0500
Message-ID: <20220705170340.26719-1-afd@ti.com>
X-Mailer: git-send-email 2.36.1
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

Setting these individually gives a better picture of supported
functions at a glance. Plus if the list changes an unwanted
one will not accidentally get set with GENMASK.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/crypto/sa2ul.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 6957a125b4470..1d732113b81ec 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -2361,7 +2361,15 @@ static int sa_link_child(struct device *dev, void *data)
 static struct sa_match_data am654_match_data = {
 	.priv = 1,
 	.priv_id = 1,
-	.supported_algos = GENMASK(SA_ALG_AUTHENC_SHA256_AES, 0),
+	.supported_algos = BIT(SA_ALG_CBC_AES) |
+			   BIT(SA_ALG_EBC_AES) |
+			   BIT(SA_ALG_CBC_DES3) |
+			   BIT(SA_ALG_ECB_DES3) |
+			   BIT(SA_ALG_SHA1) |
+			   BIT(SA_ALG_SHA256) |
+			   BIT(SA_ALG_SHA512) |
+			   BIT(SA_ALG_AUTHENC_SHA1_AES) |
+			   BIT(SA_ALG_AUTHENC_SHA256_AES),
 };
 
 static struct sa_match_data am64_match_data = {
-- 
2.36.1


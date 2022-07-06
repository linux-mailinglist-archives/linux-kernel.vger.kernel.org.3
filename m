Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1762C56926D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiGFTL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiGFTLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 15:11:53 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFB255AF;
        Wed,  6 Jul 2022 12:11:51 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 266JBjsn067598;
        Wed, 6 Jul 2022 14:11:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657134705;
        bh=qYsQY4oZsu2uLE3q9njn/+pWKtCH37m7dGRqVwOuVls=;
        h=From:To:CC:Subject:Date;
        b=E6qyBHj7Pp40FHSvvTuvvoXfZCS8sB4dTRJS8aFOcLG7lat+i2ve5DuN12uEXZd4l
         DjHgliSjZXaepjOj5rYR2ag2nFgvpFSOeF6Rl5Sl30AgNceZX3tv6DfkvgQs/1nWYQ
         7deWLBEAJ+pEW//tlsATpTd1vU5iy10lhVRPY21s=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 266JBj1q032172
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Jul 2022 14:11:45 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 6
 Jul 2022 14:11:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 6 Jul 2022 14:11:45 -0500
Received: from ula0226330.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 266JBiXT031227;
        Wed, 6 Jul 2022 14:11:44 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH v2 1/2] crypto: sa2ul - Set the supported_algos bits individually
Date:   Wed, 6 Jul 2022 14:11:43 -0500
Message-ID: <20220706191144.26437-1-afd@ti.com>
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

Changes from v1:
 - Split these two patches from the DTS changes

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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC12556833C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 11:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiGFJPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiGFJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 05:15:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A1C23;
        Wed,  6 Jul 2022 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657098905; x=1688634905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+VI0QHCyPONLMhvZQIjJCP6FWIqDVbefx+zx+Z98RBc=;
  b=FqBCdX+dKwjfCTP4qWzmWXOyXVGACg4qF/Ljw8Bsah3nJYe1X/NVDB/c
   UpRnDBSXNg+OJmn0UY1z7fyK+zhcHh6EggVYruSKhPXVLZ9YU/pMNpHPg
   YeUaeHoLdJc1LcyG652+uaAyeiQ2eT1Lt7oj8bGSWNG05UpOtSCGLTymM
   NTZdLbMdUeApSDbPzn93fwig6pVTBnKAfJ4bbHbqJbGdgT8Xt4DE76FDh
   4iSRA9KZw4/ZM0BvD0XssGz1DSPK4+0x5KYPlHN7HBAD4/y+iHmYsTuhH
   udojrgBt4/Hnr2IS73rudankdwaWIumkcq46tBHHtyX3vni0KGHxZWMzI
   A==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="170971252"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 02:15:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 02:15:04 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 6 Jul 2022 02:15:01 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] crypto: atmel-tdes: initialize tdes_dd while declaring
Date:   Wed, 6 Jul 2022 12:17:27 +0300
Message-ID: <20220706091727.831036-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize sha_dd with platform_get_drvdata() when declaring it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi,

This patch is based on patch at [1].

[1] https://patchwork.kernel.org/project/linux-crypto/patch/20220705205144.131702-3-u.kleine-koenig@pengutronix.de

Thank you,
Claudiu Beznea

 drivers/crypto/atmel-tdes.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index a5e78aa08bf0..8b7bc1076e0d 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1263,9 +1263,7 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 
 static int atmel_tdes_remove(struct platform_device *pdev)
 {
-	struct atmel_tdes_dev *tdes_dd;
-
-	tdes_dd = platform_get_drvdata(pdev);
+	struct atmel_tdes_dev *tdes_dd = platform_get_drvdata(pdev);
 
 	spin_lock(&atmel_tdes.lock);
 	list_del(&tdes_dd->list);
-- 
2.33.0


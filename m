Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044C4BD7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbiBUH67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:58:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346627AbiBUH6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:58:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AEF267B;
        Sun, 20 Feb 2022 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645430309; x=1676966309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x4B8RAQ+sONeCB93qo7wNP3O6nHHIZlxDecPSenuJqU=;
  b=cF1S5pW+OZVza5zKHEE9rTVOKKu9FVYBrYS3uF+aQPoeC5fWmG95PJSx
   Y7jIFQxYLzfHkpsOTEwJ0ngqtnsKBKxviPqIH19HqnnfkSztIF/gcAyAQ
   Wfa+xGxKEnXp7Y8hS517xvO7EUrlsFk/v86h2CRjjr2fYvJXdCj2pP9f+
   +rsRQdCDTBNOO5t/lOPF09lKZx7qcmlCwj+GKAat5TYleQwFUKuNHFMUa
   JRB2dcAIL8F0YC7wWQxxF9oUmn+M291eHl8rJw+sQtapEA8zHpRzmuWU4
   7jqw+UUL8ao50SIvdgs4G0q9AyYMNaCTIzxP5XEi0lKFRJbFRJJ8vw22A
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="86422618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2022 00:58:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 21 Feb 2022 00:58:26 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 21 Feb 2022 00:58:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mpm@selenic.com>, <herbert@gondor.apana.org.au>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/7] hwrng: atmel - disable trng on failure path
Date:   Mon, 21 Feb 2022 09:59:23 +0200
Message-ID: <20220221075928.563806-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220221075928.563806-1-claudiu.beznea@microchip.com>
References: <20220221075928.563806-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call atmel_trng_disable() on failure path of probe.

Fixes: a1fa98d8116f ("hwrng: atmel - disable TRNG during suspend")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/char/hw_random/atmel-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
index 1a4874668c04..b7ef951927fb 100644
--- a/drivers/char/hw_random/atmel-rng.c
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -131,6 +131,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
 
 err_register:
 	clk_disable_unprepare(trng->clk);
+	atmel_trng_disable(trng);
 	return ret;
 }
 
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2EC5822B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiG0JGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiG0JFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:05:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C454243337
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658912755; x=1690448755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NVXOybPJqEwP6MHqK15Tsb+Wcp2uLtsdOnoZ40Pv0zw=;
  b=yYE3dqHv1/Kum2eHQxutk0Qgp8BmQaJVVmiPtt/6E9XtIfkKa0OEPWkt
   iFsD/zhNyaLJfdA3NBFLaoM2KpfQ6wYi1Vn6ehSI9LRrMDltIHeBIRNqR
   L+DyWuPdSjhdSbCtjnYyDueG51FvhssS28yyhJm8ZMNsXpqwiTBhNIBt2
   Qzh8Mn3SdE8nFRyNtWrRTUrogHvsUz7rd0U2zAljWdX7vs4i10VQlc1PB
   Dv+aNRgr5fvcWa9vnYGIdfMonyatxKD/N/V+4UbmUs8C4LFcgjRjlW9Xp
   hSGF7DhDox91GTagpnBC48MugeOhWCZV9RAkMNEYFojg7/snTAaSdpqN8
   A==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="183930488"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 02:05:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 02:05:53 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 27 Jul 2022 02:05:51 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/2] ASoC: mchp-spdifrx: disable end of block interrupt on failures
Date:   Wed, 27 Jul 2022 12:08:13 +0300
Message-ID: <20220727090814.2446111-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
References: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable end of block interrupt in case of wait for completion timeout
or errors to undo previously enable operation (done in
mchp_spdifrx_isr_blockend_en()). Otherwise we can end up with an
unbalanced reference counter for this interrupt.

Fixes: ef265c55c1ac ("ASoC: mchp-spdifrx: add driver for SPDIF RX")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index 85d1d92a21db..ec0705cc40fa 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -288,15 +288,17 @@ static void mchp_spdifrx_isr_blockend_en(struct mchp_spdifrx_dev *dev)
 	spin_unlock_irqrestore(&dev->blockend_lock, flags);
 }
 
-/* called from atomic context only */
+/* called from atomic/non-atomic context */
 static void mchp_spdifrx_isr_blockend_dis(struct mchp_spdifrx_dev *dev)
 {
-	spin_lock(&dev->blockend_lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->blockend_lock, flags);
 	dev->blockend_refcount--;
 	/* don't enable BLOCKEND interrupt if it's already enabled */
 	if (dev->blockend_refcount == 0)
 		regmap_write(dev->regmap, SPDIFRX_IDR, SPDIFRX_IR_BLOCKEND);
-	spin_unlock(&dev->blockend_lock);
+	spin_unlock_irqrestore(&dev->blockend_lock, flags);
 }
 
 static irqreturn_t mchp_spdif_interrupt(int irq, void *dev_id)
@@ -575,6 +577,7 @@ static int mchp_spdifrx_subcode_ch_get(struct mchp_spdifrx_dev *dev,
 	if (ret <= 0) {
 		dev_dbg(dev->dev, "user data for channel %d timeout\n",
 			channel);
+		mchp_spdifrx_isr_blockend_dis(dev);
 		return ret;
 	}
 
-- 
2.34.1


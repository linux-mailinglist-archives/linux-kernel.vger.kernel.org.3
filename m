Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B99C57FD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234651AbiGYKJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiGYKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:09:18 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C7917AB0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658743757; x=1690279757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WwU9nxdctQsI4jH9K6IXqln2aORb9QSIuV6qe2LWzS8=;
  b=S8mPzaKGQnx0Cp/uVH4EbwydGuzZyq2IKM9KatNDY/Qx8b/AkCH56B/F
   x90PVScal79ikbgplGvEKLAZVVLi8MfOBZZYntV3Q0Y5cH9xcWvlPFFvS
   /24MTR0HlXsIwJ9ZCDpca5P9uSyCxkSoJ67fEceYFDXSFVZTPg72VlviO
   2l2nKzgzBMGPENRl6A8u9p6qK/ti+tJEgyMP7HK6MZTLc5tbbfZn2Fnwr
   LtN9rnX4IOQPTbKrydNnLL9r4x2ZGuybvuCDuDlJLEEKA8Ky2AGF9FUL1
   Y8NCAWhxVbIjXSrLHRb/1AXDA4M9a/hHnWnRLzQAqq5w6SLGHYrsOH7+i
   w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="173666606"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 03:09:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 03:09:17 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 03:09:14 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 4/5] ASoC: mchp-spdiftx: return directly ret
Date:   Mon, 25 Jul 2022 13:11:29 +0300
Message-ID: <20220725101130.1780393-5-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220725101130.1780393-1-claudiu.beznea@microchip.com>
References: <20220725101130.1780393-1-claudiu.beznea@microchip.com>
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

Avoid having patterns like:

int ret;

// ...
ret = 0;
// ...

ret = call_function();
if (ret)
	return ret;

return 0;

and return directly ret for all cases.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 20e77b374f7e..74729ec8423b 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -340,12 +340,10 @@ static int mchp_spdiftx_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	ret = regmap_write(dev->regmap, SPDIFTX_MR, mr);
 	spin_unlock(&ctrl->lock);
-	if (ret) {
+	if (ret)
 		dev_err(dev->dev, "unable to disable TX: %d\n", ret);
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static int mchp_spdiftx_hw_params(struct snd_pcm_substream *substream,
@@ -841,12 +839,10 @@ static int mchp_spdiftx_probe(struct platform_device *pdev)
 	err = devm_snd_soc_register_component(&pdev->dev,
 					      &mchp_spdiftx_component,
 					      &mchp_spdiftx_dai, 1);
-	if (err) {
+	if (err)
 		dev_err(&pdev->dev, "failed to register component: %d\n", err);
-		return err;
-	}
 
-	return 0;
+	return err;
 }
 
 static struct platform_driver mchp_spdiftx_driver = {
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829F575E36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiGOJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiGOJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:07:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A425F0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657876035; x=1689412035;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xt3Cr4DjUR6uWFdmfg6tQgONs9dbD7Y0B6+swnrcj5A=;
  b=0v3pd8U36mrZGDKEadWYu1MPoIyaD9lwdZ6W3a6C0E1N5G8tp2V9sE3F
   Ou/CFUWggITIM7IkHg54QgTZ4PjWFEqYvz/UtlMEahAF4nYOln5n6iYU5
   TiYAoaRDRKQQO5CU1PmvF12DGnhp/b9r3MYUkNoASI1ln0zBQVNe33wIg
   fVPbDXx2z+mghr1Zai1ChNsu6/RcxnKIpA1IuSCX7dpNR8Pzav/qPegyA
   btWDjj9GbOpAkTPvgIi7BZepTXSUnHR24MJurbxrcJONFqQ3ei48MZn5e
   WZ1UquLssAc6suNQpw/9FPSsfp5ivWrM0MijW2Mtn9kC29snvdCJ9gIsJ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="104601118"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 02:07:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 02:07:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 02:07:12 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ASoC: atmel_ssc_dai: remove #ifdef CONFIG_PM
Date:   Fri, 15 Jul 2022 12:09:39 +0300
Message-ID: <20220715090939.1679963-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
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

Remove #ifdef CONFIG_PM and use pm_ptr() instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/atmel_ssc_dai.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 8aae0beadcfe..e868b7e028d6 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -762,7 +762,6 @@ static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#ifdef CONFIG_PM
 static int atmel_ssc_suspend(struct snd_soc_component *component)
 {
 	struct atmel_ssc_info *ssc_p;
@@ -821,10 +820,6 @@ static int atmel_ssc_resume(struct snd_soc_component *component)
 
 	return 0;
 }
-#else /* CONFIG_PM */
-#  define atmel_ssc_suspend	NULL
-#  define atmel_ssc_resume	NULL
-#endif /* CONFIG_PM */
 
 #define ATMEL_SSC_FORMATS (SNDRV_PCM_FMTBIT_S8     | SNDRV_PCM_FMTBIT_S16_LE |\
 			  SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
@@ -859,8 +854,8 @@ static struct snd_soc_dai_driver atmel_ssc_dai = {
 
 static const struct snd_soc_component_driver atmel_ssc_component = {
 	.name			= "atmel-ssc",
-	.suspend		= atmel_ssc_suspend,
-	.resume			= atmel_ssc_resume,
+	.suspend		= pm_ptr(atmel_ssc_suspend),
+	.resume			= pm_ptr(atmel_ssc_resume),
 	.legacy_dai_naming	= 1,
 };
 
-- 
2.34.1


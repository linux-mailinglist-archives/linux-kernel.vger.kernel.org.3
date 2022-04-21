Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927D150A01E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386298AbiDUM5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241689AbiDUM5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:57:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92DB32ED2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1650545661; x=1682081661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgtX4YON8Zrq5OpIcU6N0ns6NSZEzAs8X3R7e2dHKOA=;
  b=UQB6oI0xmOOj/vNyXetAohL/9eJTvswv9+wmr0tCoHsSXxsVEcxGS1UX
   ghvsj3EYbHPfYYi5FLheqK+nkngELWKGZ4g1jwrnl9fFGfxL76Xd5VvwJ
   AcRSnhzXQuPCYa+MjX2lv4xWW0syfk3MADCCZrnNqidtECalEaRmz/AfV
   AAUTGOILjS3aULNdN/97QI51Jl43CvpPfB17kU7yDQICKNI9Iw8nSC30N
   LVd2vTHPdJXVKkS254ycSkjVnj9gSVtL/AHtYHPMzJyL10AkAwivFfqPm
   fu6E9u0N1FE30MV/nlHWtCQZUuccYUhxyViJIK9grVcJWaAqI469xuTKd
   g==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643698800"; 
   d="scan'208";a="161255136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Apr 2022 05:54:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 21 Apr 2022 05:54:20 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 21 Apr 2022 05:54:17 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <alexandre.belloni@bootlin.com>, <sha@pengutronix.de>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 1/2] Revert "ASoC: dmaengine: do not use a NULL prepare_slave_config() callback"
Date:   Thu, 21 Apr 2022 15:54:02 +0300
Message-ID: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
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

This reverts commit 9a1e13440a4f2e7566fd4c5eae6a53e6400e08a4.

As pointed out by Sascha Hauer, this patch changes:
if (pmc->config && !pcm->config->prepare_slave_config)
        <do nothing>
to:
if (pmc->config && !pcm->config->prepare_slave_config)
        snd_dmaengine_pcm_prepare_slave_config()

This breaks the drivers that do not need a call to
dmaengine_slave_config(). Drivers that still need to call
snd_dmaengine_pcm_prepare_slave_config(), but have a NULL
pcm->config->prepare_slave_config should use
snd_dmaengine_pcm_prepare_slave_config() as their prepare_slave_config
callback.

Fixes: 9a1e13440a4f ("ASoC: dmaengine: do not use a NULL prepare_slave_config() callback")
Reported-by: Sascha Hauer <sha@pengutronix.de>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 2ab2ddc1294dd..285441d6aeed4 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -86,10 +86,10 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 
 	memset(&slave_config, 0, sizeof(slave_config));
 
-	if (pcm->config && pcm->config->prepare_slave_config)
-		prepare_slave_config = pcm->config->prepare_slave_config;
-	else
+	if (!pcm->config)
 		prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config;
+	else
+		prepare_slave_config = pcm->config->prepare_slave_config;
 
 	if (prepare_slave_config) {
 		int ret = prepare_slave_config(substream, params, &slave_config);
-- 
2.32.0


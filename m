Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053955075A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355364AbiDSQvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350141AbiDSQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924F36E26;
        Tue, 19 Apr 2022 09:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63FC761874;
        Tue, 19 Apr 2022 16:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80884C385AC;
        Tue, 19 Apr 2022 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386574;
        bh=RVE6EmI/XNsvZr+sz6SY+1PqohGEsq3I0n4zlwh58+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dHkbZ59jO4tpFys0DP7olW8IY7ZH5CGyEM3n2P2fl7D3JvK9hQ7BKYiNMCkVX0QMO
         DzwIJv2XuHva+L/KHbieQhFRPKov89shvDnwcRIqSGqfBDAYykBmRV+5xMRQwCndOp
         sHEX5civiLh3GC6mOa9LkgRIlBFjYRIyGRh7lIfTZoJ/GNwulWi9NOLR6NJJ2N2jTC
         fWVoQDYVTClTgFIbtWF4Aw1YdDz3Dn9HqY5Kktz5XtwGO57L+cplp1HmwGjhzgiXge
         HL9aNnhck3V9UwzUA23nrnbbVePDqvxauzNlGoRmQeEK/cTZnnxkove2t2MWjx50A7
         aeTu+UERvoByg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 31/48] ASoC: pxa: use pdev resource for FIFO regs
Date:   Tue, 19 Apr 2022 18:37:53 +0200
Message-Id: <20220419163810.2118169-32-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver currently takes the hardwired FIFO address from
a header file that we want to eliminate. Change it to use
the mmio resource instead and stop including the here.

Acked-by: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/pxa/pxa2xx-ac97.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 9443c1390d2f..809ea34736ed 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -21,10 +21,12 @@
 #include <sound/pxa2xx-lib.h>
 #include <sound/dmaengine_pcm.h>
 
-#include <mach/pxa-regs.h>
-#include <mach/regs-ac97.h>
 #include <linux/platform_data/asoc-pxa.h>
 
+#define PCDR	0x0040  /* PCM FIFO Data Register */
+#define MODR	0x0140  /* Modem FIFO Data Register */
+#define MCDR	0x0060  /* Mic-in FIFO Data Register */
+
 static void pxa2xx_ac97_warm_reset(struct ac97_controller *adrv)
 {
 	pxa2xx_ac97_try_warm_reset();
@@ -59,35 +61,30 @@ static struct ac97_controller_ops pxa2xx_ac97_ops = {
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_in = {
-	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.chan_name	= "pcm_pcm_stereo_in",
 	.maxburst	= 32,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_stereo_out = {
-	.addr		= __PREG(PCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_4_BYTES,
 	.chan_name	= "pcm_pcm_stereo_out",
 	.maxburst	= 32,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_out = {
-	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mono_out",
 	.maxburst	= 16,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_aux_mono_in = {
-	.addr		= __PREG(MODR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mono_in",
 	.maxburst	= 16,
 };
 
 static struct snd_dmaengine_dai_dma_data pxa2xx_ac97_pcm_mic_mono_in = {
-	.addr		= __PREG(MCDR),
 	.addr_width	= DMA_SLAVE_BUSWIDTH_2_BYTES,
 	.chan_name	= "pcm_aux_mic_mono",
 	.maxburst	= 16,
@@ -226,6 +223,7 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 	int ret;
 	struct ac97_controller *ctrl;
 	pxa2xx_audio_ops_t *pdata = pdev->dev.platform_data;
+	struct resource *regs;
 	void **codecs_pdata;
 
 	if (pdev->id != -1) {
@@ -233,6 +231,16 @@ static int pxa2xx_ac97_dev_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
+	pxa2xx_ac97_pcm_stereo_in.addr = regs->start + PCDR;
+	pxa2xx_ac97_pcm_stereo_out.addr = regs->start + PCDR;
+	pxa2xx_ac97_pcm_aux_mono_out.addr = regs->start + MODR;
+	pxa2xx_ac97_pcm_aux_mono_in.addr = regs->start + MODR;
+	pxa2xx_ac97_pcm_mic_mono_in.addr = regs->start + MCDR;
+
 	ret = pxa2xx_ac97_hw_probe(pdev);
 	if (ret) {
 		dev_err(&pdev->dev, "PXA2xx AC97 hw probe error (%d)\n", ret);
-- 
2.29.2


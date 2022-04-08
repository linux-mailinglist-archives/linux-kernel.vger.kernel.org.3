Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A14F904E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiDHIEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiDHIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:03:10 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3162A10E56B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=mOfgmV/e3cCSYC
        aIKTCEwxMAPTR5lG8qNDffE6Lj87U=; b=VzN7g8L5eQHC0vYCq0CEOODz9n6gan
        wl+63LJWuBEuHPN/gE7kR6Ba6lJ7jdt4K9Fatazif7HSG1TY7xQtb3yKMIUQfub7
        RD1gi/ylRe6b3uE+YK17oLn60S04EnS/drPy76V1sxtlCU67PU2R3bI70bRVQoX6
        EQ421K7HYT91Y=
Received: (qmail 3517300 invoked from network); 8 Apr 2022 10:00:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Apr 2022 10:00:52 +0200
X-UD-Smtp-Session: l3s3148p1@dPRG/h/cUqQgAQnoAEvdAHNhR6IfKwZI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 3/3] mmc: improve API to make clear hw_reset callback is for cards
Date:   Fri,  8 Apr 2022 10:00:44 +0200
Message-Id: <20220408080045.6497-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408080045.6497-1-wsa+renesas@sang-engineering.com>
References: <20220408080045.6497-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it unambiguous that the hw_reset callback is for cards and not
for controllers, we add 'card' to the callback name and convert all
users in one go. We keep the argument as mmc_host, though, because the
callback is used very early when mmc_card is not yet populated.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Ulf: I really think the callback rename makes sense here to make it
obvious for driver authors that the card should be reset. Because we got
it wrong and at least bcm2835 has it also wrong, maybe meson as well.

 drivers/mmc/core/core.c              | 4 ++--
 drivers/mmc/core/mmc.c               | 4 ++--
 drivers/mmc/host/bcm2835.c           | 2 +-
 drivers/mmc/host/dw_mmc.c            | 2 +-
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 2 +-
 drivers/mmc/host/mtk-sd.c            | 2 +-
 drivers/mmc/host/sdhci.c             | 2 +-
 drivers/mmc/host/sunxi-mmc.c         | 2 +-
 drivers/mmc/host/uniphier-sd.c       | 2 +-
 include/linux/mmc/host.h             | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 57c64c0583ac..8cc2b746414b 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1991,9 +1991,9 @@ static void mmc_hw_reset_for_init(struct mmc_host *host)
 {
 	mmc_pwrseq_reset(host);
 
-	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
+	if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->card_hw_reset)
 		return;
-	host->ops->hw_reset(host);
+	host->ops->card_hw_reset(host);
 }
 
 /**
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1f22f1d2e9b8..9ab915b5737a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2238,11 +2238,11 @@ static int _mmc_hw_reset(struct mmc_host *host)
 	 */
 	_mmc_flush_cache(host);
 
-	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->hw_reset &&
+	if ((host->caps & MMC_CAP_HW_RESET) && host->ops->card_hw_reset &&
 	     mmc_can_reset(card)) {
 		/* If the card accept RST_n signal, send it. */
 		mmc_set_clock(host, host->f_init);
-		host->ops->hw_reset(host);
+		host->ops->card_hw_reset(host);
 		/* Set initial state and call mmc_set_ios */
 		mmc_set_initial_state(host);
 	} else {
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 463b707d9e99..641ab4f42125 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1259,7 +1259,7 @@ static void bcm2835_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static const struct mmc_host_ops bcm2835_ops = {
 	.request = bcm2835_request,
 	.set_ios = bcm2835_set_ios,
-	.hw_reset = bcm2835_reset,
+	.card_hw_reset = bcm2835_reset,
 };
 
 static int bcm2835_add_host(struct bcm2835_host *host)
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 06dc56cbada8..581614196a84 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1812,7 +1812,7 @@ static const struct mmc_host_ops dw_mci_ops = {
 	.set_ios		= dw_mci_set_ios,
 	.get_ro			= dw_mci_get_ro,
 	.get_cd			= dw_mci_get_cd,
-	.hw_reset               = dw_mci_hw_reset,
+	.card_hw_reset          = dw_mci_hw_reset,
 	.enable_sdio_irq	= dw_mci_enable_sdio_irq,
 	.ack_sdio_irq		= dw_mci_ack_sdio_irq,
 	.execute_tuning		= dw_mci_execute_tuning,
diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index 28aa78aa08f3..e92e63cb5641 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -511,7 +511,7 @@ static int meson_mx_sdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 }
 
 static const struct mmc_host_ops meson_mx_sdhc_ops = {
-	.hw_reset			= meson_mx_sdhc_hw_reset,
+	.card_hw_reset			= meson_mx_sdhc_hw_reset,
 	.request			= meson_mx_sdhc_request,
 	.set_ios			= meson_mx_sdhc_set_ios,
 	.card_busy			= meson_mx_sdhc_card_busy,
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index e61b0b98065a..195dc897188b 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2458,7 +2458,7 @@ static const struct mmc_host_ops mt_msdc_ops = {
 	.execute_tuning = msdc_execute_tuning,
 	.prepare_hs400_tuning = msdc_prepare_hs400_tuning,
 	.execute_hs400_tuning = msdc_execute_hs400_tuning,
-	.hw_reset = msdc_hw_reset,
+	.card_hw_reset = msdc_hw_reset,
 };
 
 static const struct cqhci_host_ops msdc_cmdq_ops = {
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 07c6da1f2f0f..22152029e14c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2999,7 +2999,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.set_ios	= sdhci_set_ios,
 	.get_cd		= sdhci_get_cd,
 	.get_ro		= sdhci_get_ro,
-	.hw_reset	= sdhci_hw_reset,
+	.card_hw_reset	= sdhci_hw_reset,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 	.ack_sdio_irq    = sdhci_ack_sdio_irq,
 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c62afd212692..0e8fbf4957d8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1115,7 +1115,7 @@ static const struct mmc_host_ops sunxi_mmc_ops = {
 	.get_cd		 = mmc_gpio_get_cd,
 	.enable_sdio_irq = sunxi_mmc_enable_sdio_irq,
 	.start_signal_voltage_switch = sunxi_mmc_volt_switch,
-	.hw_reset	 = sunxi_mmc_hw_reset,
+	.card_hw_reset	 = sunxi_mmc_hw_reset,
 	.card_busy	 = sunxi_mmc_card_busy,
 };
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index ccbf9885a52b..3a8defdcca77 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -597,7 +597,7 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 			ret = PTR_ERR(priv->rst_hw);
 			goto free_host;
 		}
-		host->ops.hw_reset = uniphier_sd_hw_reset;
+		host->ops.card_hw_reset = uniphier_sd_hw_reset;
 	}
 
 	if (host->mmc->caps & MMC_CAP_UHS) {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7afb57cab00b..c193c50ccd78 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -181,7 +181,7 @@ struct mmc_host_ops {
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
 	/* Reset the eMMC card via RST_n */
-	void	(*hw_reset)(struct mmc_host *host);
+	void	(*card_hw_reset)(struct mmc_host *host);
 	void	(*card_event)(struct mmc_host *host);
 
 	/*
-- 
2.30.2


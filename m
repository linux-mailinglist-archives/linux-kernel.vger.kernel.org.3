Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB74F50AAD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442095AbiDUVgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiDUVgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:36:45 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD544A901;
        Thu, 21 Apr 2022 14:33:53 -0700 (PDT)
Received: from melee.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A93E760004;
        Thu, 21 Apr 2022 21:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650576830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H1SCxsyir0yk12O74c3/slnu+DY/q/kHFuNIUrrfPek=;
        b=llanma7UwoiWXapTlRDnbMcAwLIiConDmuSs+6G2cs7QkoRu+9RoLDI1H5nFuuUG2fqm89
        j2RVWDIIwQqPOoxWN+wpWlgJIfMKBgHZ+RnbcGDoBi26WGrgC5tw/1km48rbzFGxqXAvVX
        5fCIIJ+EXKIPiulUfuomVxw8MJsVdCZbBqOfmNcC0AzN4Lwqw/Ppao7CGdkz6j+G9bbf8r
        JX678bAwQ9T5C18Gd4pV89DKf+3iTPV4nf1mhv8nveuZZhCHE7zTvKBPQGWaAxGX2gaN/T
        C26/bx0Q1TBb9oq9WL7+D9gMVnVHAMnR5d3CsI5TkPg8Vt5l093unA6EtiaO5A==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     linux-spi@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: rockchip: fix missing error on unsupported SPI_CS_HIGH
Date:   Thu, 21 Apr 2022 23:32:51 +0200
Message-Id: <20220421213251.1077899-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware (except for the ROCKCHIP_SPI_VER2_TYPE2 version) does not
support active-high native chip selects. However if such a CS is configured
the core does not error as it normally should, because the
'ctlr->use_gpio_descriptors = true' line in rockchip_spi_probe() makes the
core set SPI_CS_HIGH in ctlr->mode_bits.

In such a case the spi-rockchip driver operates normally but produces an
active-low chip select signal without notice.

There is no provision in the current core code to handle this
situation. Fix by adding a check in the ctlr->setup function (similarly to
what spi-atmel.c does).

This cannot be done reading the SPI_CS_HIGH but in ctlr->mode_bits because
that bit gets always set by the core for master mode (see above).

Fixes: eb1262e3cc8b ("spi: spi-rockchip: use num-cs property and ctlr->enable_gpiods")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/spi/spi-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index cdc16eecaf6b..a08215eb9e14 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -196,6 +196,8 @@ struct rockchip_spi {
 
 	bool slave_abort;
 	bool cs_inactive; /* spi slave tansmition stop when cs inactive */
+	bool cs_high_supported; /* native CS supports active-high polarity */
+
 	struct spi_transfer *xfer; /* Store xfer temporarily */
 };
 
@@ -719,6 +721,11 @@ static int rockchip_spi_setup(struct spi_device *spi)
 	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
 	u32 cr0;
 
+	if (!spi->cs_gpiod && (spi->mode & SPI_CS_HIGH) && !rs->cs_high_supported) {
+		dev_warn(&spi->dev, "setup: non GPIO CS can't be active-high\n");
+		return -EINVAL;
+	}
+
 	pm_runtime_get_sync(rs->dev);
 
 	cr0 = readl_relaxed(rs->regs + ROCKCHIP_SPI_CTRLR0);
@@ -899,6 +906,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	switch (readl_relaxed(rs->regs + ROCKCHIP_SPI_VERSION)) {
 	case ROCKCHIP_SPI_VER2_TYPE2:
+		rs->cs_high_supported = true;
 		ctlr->mode_bits |= SPI_CS_HIGH;
 		if (ctlr->can_dma && slave_mode)
 			rs->cs_inactive = true;
-- 
2.25.1


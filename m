Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CF158DCFE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiHIRVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 13:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiHIRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:21:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55324093
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 10:20:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v5so6651326wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j5pKd3SNByzA9ZE9Yo+f21ddZl4q1tS4Vn2hXAxuZ/M=;
        b=gKa/S4xVWJ+3Ubhmc+AmhI54Ekq/yygnzPP6luiABvGhAoDEfX8xSCjI0PcSmzivMC
         XOq0tRbcZJwhIgomP/okBZGrAxzmkZzyAf28tmARSW42r/DGQoYnudzV+sqjcBLcrcgJ
         IZrP6aQI/+3EkQFBYzXmWG5iIVwCqADQf7gH0nXjvVueg1ao/TlFKa1yqO0z9upvXSeH
         REyQr8gzPZvIjTcEKJqOm3s5rGBQU4ah/iz0Q0YzZrHGJNIDlCYc/rEsA8FVMYVkdKP+
         jF8G1w5CFihQcZ5HMIAbX68DhdsEFj+deGRfBlIsth/5Yu/d/3eyS9J8t9YtStQTrP0z
         Ugvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j5pKd3SNByzA9ZE9Yo+f21ddZl4q1tS4Vn2hXAxuZ/M=;
        b=cnp6cZYNeL/cFopnnxujEttc0RoaQNKRdTa2JNltfjWggO+jKzjjgBXTnFkBOa2OnN
         SI1E7fxRd9Us9K470i/ZKyWXKpARKfBFVZQOdlDCdZxiUjXUEuyswqEGgzD9Iv7vQncS
         wkO7IhAVsIrnGbPMu0e5i8ULPFSsccVmFANbdEROSfuNSsJ3TtpUjvR75rqzSisdjf8y
         bsPRB7TJXO9ZGMOlxxMl9KNTxUA4KoRIO9jqtqYdtSwJRzpgR5aYe/KvU0hZRD7cPDoV
         b1G3pUiwMqx5Obu3cefP1cIC1VLIihN/35C0TBSAUg+XF3AXuohwwUSbr1gJJUfM7Bul
         PewQ==
X-Gm-Message-State: ACgBeo38wiO9VIrbH5PoFAmBKBulOVXwkujxyRgCEhzUySupHH6rqANq
        yOpWulbv43VzA72lfENXIKhkaQ==
X-Google-Smtp-Source: AA6agR6ORaCQsrs+snEDMhescIXTPAHI5GllCnmWMx5gNV9fMFiK0wgjhM+x0lAeC7OEYjsv/46MHA==
X-Received: by 2002:a05:600c:2186:b0:3a5:eb9:593f with SMTP id e6-20020a05600c218600b003a50eb9593fmr16465702wme.203.1660065658410;
        Tue, 09 Aug 2022 10:20:58 -0700 (PDT)
Received: from localhost.localdomain (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id b3-20020a05600010c300b002206261cb6esm13915030wrx.66.2022.08.09.10.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 10:20:58 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Da Xue <da@libre.computer>
Subject: [PATCH 2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle
Date:   Tue,  9 Aug 2022 19:20:17 +0200
Message-Id: <20220809172017.215412-3-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809172017.215412-1-aouledameur@baylibre.com>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between SPI transactions, all SPI pins are in HiZ state. When using the SS
signal from the SPICC controller it's not an issue because when the
transaction resumes all pins come back to the right state at the same time
as SS.

The problem is when we use CS as a GPIO. In fact, between the GPIO CS
state change and SPI pins state change from idle, you can have a missing or
spurious clock transition.

Set a bias on the clock depending on the clock polarity requested before CS
goes active, by passing a special "idle-low" and "idle-high" pinctrl state
and setting the right state at a start of a message

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 ++++++++
 drivers/spi/spi-meson-spicc.c              | 39 +++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c3ac531c4f84..04e9d0f1bde0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -429,6 +429,20 @@ mux {
 			};
 		};
 
+		spi_idle_high_pins: spi-idle-high-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-up;
+			};
+		};
+
+		spi_idle_low_pins: spi-idle-low-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-down;
+			};
+		};
+
 		spi_ss0_pins: spi-ss0 {
 			mux {
 				groups = "spi_ss0";
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 0bc7daa7afc8..d42171ee1d61 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pinctrl/consumer.h>
 
 /*
  * The Meson SPICC controller could support DMA based transfers, but is not
@@ -166,14 +167,31 @@ struct meson_spicc_device {
 	unsigned long			tx_remain;
 	unsigned long			rx_remain;
 	unsigned long			xfer_remain;
+	struct pinctrl			*pinctrl;
+	struct pinctrl_state		*pins_idle_high;
+	struct pinctrl_state		*pins_idle_low;
 };
 
 static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
 {
 	u32 conf;
 
-	if (!spicc->data->has_oen)
+	if (!spicc->data->has_oen) {
+		/* Try to get pinctrl states for idle high/low */
+		spicc->pins_idle_high = pinctrl_lookup_state(spicc->pinctrl,
+							     "idle-high");
+		if (IS_ERR(spicc->pins_idle_high)) {
+			dev_warn(&spicc->pdev->dev, "can't get idle-high pinctrl\n");
+			spicc->pins_idle_high = NULL;
+		}
+		spicc->pins_idle_low = pinctrl_lookup_state(spicc->pinctrl,
+							     "idle-low");
+		if (IS_ERR(spicc->pins_idle_low)) {
+			dev_warn(&spicc->pdev->dev, "can't get idle-low pinctrl\n");
+			spicc->pins_idle_low = NULL;
+		}
 		return;
+	}
 
 	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
 		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
@@ -438,6 +456,16 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	else
 		conf &= ~SPICC_POL;
 
+	if (!spicc->data->has_oen) {
+		if (spi->mode & SPI_CPOL) {
+			if (spicc->pins_idle_high)
+				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_high);
+		} else {
+			if (spicc->pins_idle_low)
+				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_low);
+		}
+	}
+
 	if (spi->mode & SPI_CPHA)
 		conf |= SPICC_PHA;
 	else
@@ -482,6 +510,9 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 
 	device_reset_optional(&spicc->pdev->dev);
 
+	if (!spicc->data->has_oen)
+		pinctrl_select_default_state(&spicc->pdev->dev);
+
 	return 0;
 }
 
@@ -733,6 +764,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_core_clk;
 	}
 
+	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(spicc->pinctrl)) {
+		ret = PTR_ERR(spicc->pinctrl);
+		goto out_clk;
+	}
+
 	device_reset_optional(&pdev->dev);
 
 	master->num_chipselect = 4;
-- 
2.37.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E457E473FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhLNJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhLNJu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:50:57 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70613C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:50:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o29so13828428wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nsRfFjdoa2Fef1cqbeFwUOpeAISCeqGWxecBBnZatl8=;
        b=EkKqgbsawtEafSZAY7mZ9tIdet08L6XvSWJcQgKd2E2b0IwMDg2B3X1DSw9o4PWacQ
         6m5IsruTOYWfgpkZdmTkUnXHiq4bJxrvh7CG3kLT8s+qhO2NtSESfZmRAR9NmrGGsACE
         YUNQ+pKUMoZxxmV2GWAuP5San5a52hrCCD/cy+br4s+CnB0VFrBOPGwIWBrP8PWBwo0T
         bWovcPvxLzguTM9giSjKexi5qtyEIH8Um8hT/QICCaRpfydY93to1N1HN6+z05X9kycx
         B9DgIW6+r+veRzR+cjjsD1LCoM4SJYOV2PtffoxjE1lyf2Cvym8bhlXQ3VyUpEA8/to7
         gulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nsRfFjdoa2Fef1cqbeFwUOpeAISCeqGWxecBBnZatl8=;
        b=j+VTEE4kDzkw+SRjn934haD/yWXFbZp2WkDT/Vmg2qY6Bn3Q1wUqBwGFBZ9cQVyDbN
         EPXH2Z+ESx2/Pspx69ea+yaSlZdlHkODwwWP1P665S4VqfFai9wDbNaROhr4Kc5luSM4
         MoIEgyNYZP+HIMtAOttwuZOZryLegpVyKD1jd4yub33uQIpvA8W77PdNNggiG1IBegsq
         Ja1t2nQiYIy7SlOwL0Rm02fOGSJzWq/67duJODNDrjOx+1K33Mj4Z7idJwSiNxdcBWHR
         pChc++CHp41zHd1EtQPn3e+XkNCM8vIVaYDdCrpqP6g2x9oKW3Xf9g2u4dkdn16bFLEk
         1znA==
X-Gm-Message-State: AOAM532TxLdSmKPqQjK7zQfFy7XxzoExb/rKcfDIKKYiCWtQ7HtbObi/
        e6W/xDx2S0Z0dYz1ObIvSiprXg==
X-Google-Smtp-Source: ABdhPJzLvjKmZbqhj/0aEH8wjxtVwdxyNjx21q4FAZ11fNn4Z5F6J6xO2W1e2X2pRIXBKBdwO5tpzw==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr5697077wmq.24.1639475455964;
        Tue, 14 Dec 2021 01:50:55 -0800 (PST)
Received: from fedora.sec.9e.network (ip-88-153-139-166.hsi04.unitymediagroup.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id s24sm1522757wmj.26.2021.12.14.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:50:55 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drivers/i2c/mux: Add MAX735x support to PCA954x
Date:   Tue, 14 Dec 2021 10:50:19 +0100
Message-Id: <20211214095021.572799-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211214095021.572799-1-patrick.rudolph@9elements.com>
References: <20211214095021.572799-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MAX7356, MAX7357 and MAX7358 using the existing driver.
All added Maxim chips behave like the PCA9848, where a single SMBUS byte
write selects up to 8 channels to be bridged to the primary bus.

The MAX7357 exposes 6 additional registers at Power-On-Reset and is
configured to enable additional features:
 - Disabled interrupts on bus locked up detection
 - Enable bus locked-up clearing
 - Disconnect only locked bus instead of all channels

The MAX7357/MAX7358 IRQs aren't supported and must not be enabled.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/i2c/muxes/Kconfig           |  4 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c | 63 +++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index 1708b1a82da2..621c8a5314f6 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -65,11 +65,11 @@ config I2C_MUX_PCA9541
 	  will be called i2c-mux-pca9541.
 
 config I2C_MUX_PCA954x
-	tristate "NXP PCA954x and PCA984x I2C Mux/switches"
+	tristate "NXP PCA954x and PCA984x and Maxim MAX735x I2C Mux/switches"
 	depends on GPIOLIB || COMPILE_TEST
 	help
 	  If you say yes here you get support for the NXP PCA954x
-	  and PCA984x I2C mux/switch devices.
+	  and PCA984x and Maxim MAX735x I2C mux/switch devices.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-mux-pca954x.
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index 4ad665757dd8..23e0f24bab04 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -11,6 +11,12 @@
  *	 PCA9540, PCA9542, PCA9543, PCA9544, PCA9545, PCA9546, PCA9547,
  *	 PCA9548, PCA9846, PCA9847, PCA9848 and PCA9849.
  *
+ * It's also compatible to Maxims MAX735x I2C switch chips, which is controlled
+ * as the NXP PCA9548.
+ *
+ * This includes the:
+ *	 MAX7356, MAX7357 and MAX7358.
+ *
  * These chips are all controlled via the I2C bus itself, and all have a
  * single 8-bit register. The upstream "parent" bus fans out to two,
  * four, or eight downstream busses or channels; which of these
@@ -50,7 +56,12 @@
 
 #define PCA954X_IRQ_OFFSET 4
 
+#define MAX7357_REG_CONFIG_DEFAULTS 0x16
+
 enum pca_type {
+	max_7356,
+	max_7357,
+	max_7358,
 	pca_9540,
 	pca_9542,
 	pca_9543,
@@ -69,6 +80,8 @@ struct chip_desc {
 	u8 nchans;
 	u8 enable;	/* used for muxes only */
 	u8 has_irq;
+	u8 max7357;
+	u8 max735x;
 	enum muxtype {
 		pca954x_ismux = 0,
 		pca954x_isswi
@@ -90,8 +103,27 @@ struct pca954x {
 	raw_spinlock_t lock;
 };
 
-/* Provide specs for the PCA954x types we know about */
+/* Provide specs for the PCA954x and MAX735x types we know about */
 static const struct chip_desc chips[] = {
+	[max_7356] = {
+		.nchans = 8,
+		.muxtype = pca954x_isswi,
+		.max735x = 1,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
+	},
+	[max_7357] = {
+		.nchans = 8,
+		.muxtype = pca954x_isswi,
+		.max735x = 1,
+		.max7357 = 1,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
+	},
+	[max_7358] = {
+		.nchans = 8,
+		.muxtype = pca954x_isswi,
+		.max735x = 1,
+		.id = { .manufacturer_id = I2C_DEVICE_ID_NONE },
+	},
 	[pca_9540] = {
 		.nchans = 2,
 		.enable = 0x4,
@@ -177,6 +209,9 @@ static const struct chip_desc chips[] = {
 };
 
 static const struct i2c_device_id pca954x_id[] = {
+	{ "max7356", max_7356 },
+	{ "max7357", max_7357 },
+	{ "max7358", max_7358 },
 	{ "pca9540", pca_9540 },
 	{ "pca9542", pca_9542 },
 	{ "pca9543", pca_9543 },
@@ -194,6 +229,9 @@ static const struct i2c_device_id pca954x_id[] = {
 MODULE_DEVICE_TABLE(i2c, pca954x_id);
 
 static const struct of_device_id pca954x_of_match[] = {
+	{ .compatible = "maxim,max7356", .data = &chips[max_7356] },
+	{ .compatible = "maxim,max7357", .data = &chips[max_7357] },
+	{ .compatible = "maxim,max7358", .data = &chips[max_7358] },
 	{ .compatible = "nxp,pca9540", .data = &chips[pca_9540] },
 	{ .compatible = "nxp,pca9542", .data = &chips[pca_9542] },
 	{ .compatible = "nxp,pca9543", .data = &chips[pca_9543] },
@@ -355,6 +393,11 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 	if (!data->chip->has_irq || client->irq <= 0)
 		return 0;
 
+	if (data->chip->max735x) {
+		dev_err(&client->dev, "IRQs not supported for MAX735x\n");
+		return -EOPNOTSUPP;
+	}
+
 	raw_spin_lock_init(&data->lock);
 
 	data->irq = irq_domain_add_linear(client->dev.of_node,
@@ -401,9 +444,21 @@ static int pca954x_init(struct i2c_client *client, struct pca954x *data)
 	else
 		data->last_chan = 0; /* Disconnect multiplexer */
 
-	ret = i2c_smbus_write_byte(client, data->last_chan);
-	if (ret < 0)
-		data->last_chan = 0;
+	/*
+	 * MAX7357 exposes 7 register on POR which allows to configure additional
+	 * features. Disable interrupts, enable bus locked-up clearing,
+	 * disconnect only locked bus instead of all channels.
+	 */
+	if (data->chip->max7357) {
+		ret = i2c_smbus_write_byte_data(client, data->last_chan,
+						MAX7357_REG_CONFIG_DEFAULTS);
+		if (ret < 0)
+			data->last_chan = 0;
+	} else {
+		ret = i2c_smbus_write_byte(client, data->last_chan);
+		if (ret < 0)
+			data->last_chan = 0;
+	}
 
 	return ret;
 }
-- 
2.33.1


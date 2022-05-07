Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4656C51E61D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446190AbiEGJe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446186AbiEGJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:33:54 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013AC56211;
        Sat,  7 May 2022 02:30:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so12854774pjv.4;
        Sat, 07 May 2022 02:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSSA/bfReVrgc4cWkZW6zBQeIN4+PVoXqZR0RTRh8V8=;
        b=DKQNHPhk1MKnOfbc9Yj6diMbdtgW2aRWPGw4tXyyPmig83hQ4OSf8LPAueWvUU2K1v
         QnCQYSKmJgfg96DJgZ/pv+au1a80B0aVukaW8GTcTK82wiNPEsZKIbx0quYt80jsGGxc
         AkU45I27ZXkJdkEf8uZIl7xjK0BR/DjtEZu/AKnPkdDnABt4Icd7UrnkcCpOZMrNPT5E
         RXBSI9MapDWfJsGCz+2mDVB3A8Tv351yhonWlDnabIXFumf+dc3Z9vNTH5SE9jwmVFLo
         sSMNEVGk1FQXl1YgKFNrNxd1bZbJHLbMm+czYTG6waBm3bjlX2U+hnC7D/jPl9dLRZc1
         qJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSSA/bfReVrgc4cWkZW6zBQeIN4+PVoXqZR0RTRh8V8=;
        b=zDaVIhiZMPclW413GlpAXG8k/UJbRsQvWp0g6Enp6yHXoav/zkQyB8sNZEqVm7KhPa
         XLWN03xwa3SjJabjJ+3dxjY9ZMlpW4kydIapnOz9R9DMk0Keljh04m7h0HkpTmaM6wKJ
         Tqfz7MGXxcsy/wgX3wUUjK7Q/c+36EanSF3Z69nS2OCBqvgZHaJM7JpuX9kt0YAotZpI
         f1aGo/0a/ByItvgLe81xgzsNPKbGZ7xcl3AyiLKV6++vGqBt0f4h8kicOGN6DmOrSRkL
         feUtrwLB8DJxVSnupbTsnoTD4YSWs4oOgdl5o1l6ODQ5XexnF9OZb5q4zHoEcVSCLAyd
         AR4Q==
X-Gm-Message-State: AOAM5322Gx8B+wvgIhORgFLdatoLOlFwn7BIAtMBO/Qc3XWqdYGElTJT
        bxcnrU9eOtHc8gV5nHgMiPk=
X-Google-Smtp-Source: ABdhPJxHLmAbTXPkxj5MwVtSIsuuAb8lz+d678apckoYrQytfxtCCHFldlJ46Fm+JreP5OKPbou7gw==
X-Received: by 2002:a17:902:7891:b0:15e:f845:b816 with SMTP id q17-20020a170902789100b0015ef845b816mr3018549pll.60.1651915807308;
        Sat, 07 May 2022 02:30:07 -0700 (PDT)
Received: from tj10039pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b0015ee24acf38sm3212300plr.212.2022.05.07.02.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 02:30:06 -0700 (PDT)
From:   Cixi Geng <gengcixi@gmail.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: typec: sprd: Support the SC27CC typec port controller
Date:   Sat,  7 May 2022 17:29:53 +0800
Message-Id: <20220507092953.2273879-3-gengcixi@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220507092953.2273879-1-gengcixi@gmail.com>
References: <20220507092953.2273879-1-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

The Spreadtrum PMIC SC27xx integrated typec port controller.
Add a typec class driver for it.

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/usb/typec/Kconfig        |  10 +
 drivers/usb/typec/Makefile       |   1 +
 drivers/usb/typec/sc27xx-typec.c | 554 +++++++++++++++++++++++++++++++
 3 files changed, 565 insertions(+)
 create mode 100644 drivers/usb/typec/sc27xx-typec.c

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index ba24847fb245..3058e3a971ce 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -111,6 +111,16 @@ config TYPEC_WUSB3801
 	  If you choose to build this driver as a dynamically linked module, the
 	  module will be called wusb3801.ko.
 
+config TYPEC_SC27XX
+	tristate "Unisoc SC27XX Serials PMICs Type-C controller driver"
+	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	help
+	  Say Y or M here if system has the Type-C port controller of PMIC
+	  SC27XX serials.
+
+	  If you choose to build this driver as a dynamically linked module, the
+	  module will be called sx27xx-typec.ko.
+
 source "drivers/usb/typec/mux/Kconfig"
 
 source "drivers/usb/typec/altmodes/Kconfig"
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index 43626acc0aaf..1df88570e10a 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -11,4 +11,5 @@ obj-$(CONFIG_TYPEC_QCOM_PMIC)	+= qcom-pmic-typec.o
 obj-$(CONFIG_TYPEC_STUSB160X) 	+= stusb160x.o
 obj-$(CONFIG_TYPEC_RT1719)	+= rt1719.o
 obj-$(CONFIG_TYPEC_WUSB3801)	+= wusb3801.o
+obj-$(CONFIG_TYPEC_SC27XX)	+= sc27xx-typec.o
 obj-$(CONFIG_TYPEC)		+= mux/
diff --git a/drivers/usb/typec/sc27xx-typec.c b/drivers/usb/typec/sc27xx-typec.c
new file mode 100644
index 000000000000..6305dd9fed18
--- /dev/null
+++ b/drivers/usb/typec/sc27xx-typec.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL
+/*
+ * Driver for Spreadtrum SC27XX USB Type-C
+ *
+ * Copyright (C) 2022 Unisoc Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/usb/typec.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/extcon.h>
+#include <linux/kernel.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/slab.h>
+#include <linux/extcon-provider.h>
+
+/* registers definitions for controller REGS_TYPEC */
+#define SC27XX_EN			0x00
+#define SC27XX_MODE			0x04
+#define SC27XX_INT_EN			0x0c
+#define SC27XX_INT_CLR			0x10
+#define SC27XX_INT_RAW			0x14
+#define SC27XX_INT_MASK			0x18
+#define SC27XX_STATUS			0x1c
+#define SC27XX_TCCDE_CNT		0x20
+#define SC27XX_RTRIM			0x3c
+
+/* SC27XX_TYPEC_EN */
+#define SC27XX_TYPEC_USB20_ONLY		BIT(4)
+
+/* SC27XX_TYPEC MODE */
+#define SC27XX_MODE_SNK			0
+#define SC27XX_MODE_SRC			1
+#define SC27XX_MODE_DRP			2
+#define SC27XX_MODE_MASK		3
+
+/* SC27XX_INT_EN */
+#define SC27XX_ATTACH_INT_EN		BIT(0)
+#define SC27XX_DETACH_INT_EN		BIT(1)
+
+/* SC27XX_INT_CLR */
+#define SC27XX_ATTACH_INT_CLR		BIT(0)
+#define SC27XX_DETACH_INT_CLR		BIT(1)
+
+/* SC27XX_INT_MASK */
+#define SC27XX_ATTACH_INT		BIT(0)
+#define SC27XX_DETACH_INT		BIT(1)
+
+#define SC27XX_STATE_MASK		GENMASK(4, 0)
+#define SC27XX_EVENT_MASK		GENMASK(9, 0)
+
+#define SC2730_EFUSE_CC1_SHIFT		5
+#define SC2730_EFUSE_CC2_SHIFT		0
+#define SC2721_EFUSE_CC1_SHIFT		11
+#define SC2721_EFUSE_CC2_SHIFT		6
+#define UMP9620_EFUSE_CC1_SHIFT		1
+#define UMP9620_EFUSE_CC2_SHIFT		11
+
+#define SC27XX_CC1_MASK(n)		GENMASK((n) + 9, (n) + 5)
+#define SC27XX_CC2_MASK(n)		GENMASK((n) + 4, (n))
+#define SC27XX_CC_SHIFT(n)		(n)
+
+/* sc2721 registers definitions for controller REGS_TYPEC */
+#define SC2721_EN			0x00
+#define SC2721_CLR			0x04
+#define SC2721_MODE			0x08
+
+/* SC2721_INT_EN */
+#define SC2721_ATTACH_INT_EN		BIT(5)
+#define SC2721_DETACH_INT_EN		BIT(6)
+
+#define SC2721_STATE_MASK		GENMASK(3, 0)
+#define SC2721_EVENT_MASK		GENMASK(6, 0)
+
+/* modify sc2730 tcc debunce */
+#define SC27XX_TCC_DEBOUNCE_CNT		0xc7f
+
+/* sc2730 registers definitions for controller REGS_TYPEC */
+#define SC2730_TYPEC_PD_CFG		0x08
+/* SC2730_TYPEC_PD_CFG */
+#define SC27XX_VCONN_LDO_EN		BIT(13)
+#define SC27XX_VCONN_LDO_RDY		BIT(12)
+
+enum sc27xx_typec_connection_state {
+	SC27XX_DETACHED_SNK,
+	SC27XX_ATTACHWAIT_SNK,
+	SC27XX_ATTACHED_SNK,
+	SC27XX_DETACHED_SRC,
+	SC27XX_ATTACHWAIT_SRC,
+	SC27XX_ATTACHED_SRC,
+	SC27XX_POWERED_CABLE,
+	SC27XX_AUDIO_CABLE,
+	SC27XX_DEBUG_CABLE,
+	SC27XX_TOGGLE_SLEEP,
+	SC27XX_ERR_RECOV,
+	SC27XX_DISABLED,
+	SC27XX_TRY_SNK,
+	SC27XX_TRY_WAIT_SRC,
+	SC27XX_TRY_SRC,
+	SC27XX_TRY_WAIT_SNK,
+	SC27XX_UNSUPOORT_ACC,
+	SC27XX_ORIENTED_DEBUG,
+};
+
+struct sprd_typec_variant_data {
+	u32 efuse_cc1_shift;
+	u32 efuse_cc2_shift;
+	u32 int_en;
+	u32 int_clr;
+	u32 mode;
+	u32 attach_en;
+	u32 detach_en;
+	u32 state_mask;
+	u32 event_mask;
+};
+
+static const struct sprd_typec_variant_data sc2730_data = {
+	.efuse_cc1_shift = SC2730_EFUSE_CC1_SHIFT,
+	.efuse_cc2_shift = SC2730_EFUSE_CC2_SHIFT,
+	.int_en = SC27XX_INT_EN,
+	.int_clr = SC27XX_INT_CLR,
+	.mode = SC27XX_MODE,
+	.attach_en = SC27XX_ATTACH_INT_EN,
+	.detach_en = SC27XX_DETACH_INT_EN,
+	.state_mask = SC27XX_STATE_MASK,
+	.event_mask = SC27XX_EVENT_MASK,
+};
+
+static const struct sprd_typec_variant_data sc2721_data = {
+	.efuse_cc1_shift = SC2721_EFUSE_CC1_SHIFT,
+	.efuse_cc2_shift = SC2721_EFUSE_CC2_SHIFT,
+	.int_en = SC2721_EN,
+	.int_clr = SC2721_CLR,
+	.mode = SC2721_MODE,
+	.attach_en = SC2721_ATTACH_INT_EN,
+	.detach_en = SC2721_DETACH_INT_EN,
+	.state_mask = SC2721_STATE_MASK,
+	.event_mask = SC2721_EVENT_MASK,
+};
+
+static const struct sprd_typec_variant_data ump9620_data = {
+	.efuse_cc1_shift = UMP9620_EFUSE_CC1_SHIFT,
+	.efuse_cc2_shift = UMP9620_EFUSE_CC2_SHIFT,
+	.int_en = SC27XX_INT_EN,
+	.int_clr = SC27XX_INT_CLR,
+	.mode = SC27XX_MODE,
+	.attach_en = SC27XX_ATTACH_INT_EN,
+	.detach_en = SC27XX_DETACH_INT_EN,
+	.state_mask = SC27XX_STATE_MASK,
+	.event_mask = SC27XX_EVENT_MASK,
+};
+
+struct sc27xx_typec {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 base;
+	int irq;
+	struct extcon_dev *edev;
+	bool usb20_only;
+
+	enum sc27xx_typec_connection_state state;
+	enum sc27xx_typec_connection_state pre_state;
+	struct typec_port *port;
+	struct typec_partner *partner;
+	struct typec_capability typec_cap;
+	const struct sprd_typec_variant_data *var_data;
+};
+
+static int sc27xx_typec_connect(struct sc27xx_typec *sc, u32 status)
+{
+	enum typec_data_role data_role = TYPEC_DEVICE;
+	enum typec_role power_role = TYPEC_SOURCE;
+	enum typec_role vconn_role = TYPEC_SOURCE;
+	struct typec_partner_desc desc;
+
+	if (sc->partner)
+		return 0;
+
+	switch (sc->state) {
+	case SC27XX_ATTACHED_SNK:
+	case SC27XX_DEBUG_CABLE:
+		power_role = TYPEC_SINK;
+		data_role = TYPEC_DEVICE;
+		vconn_role = TYPEC_SINK;
+		break;
+	case SC27XX_ATTACHED_SRC:
+	case SC27XX_AUDIO_CABLE:
+		power_role = TYPEC_SOURCE;
+		data_role = TYPEC_HOST;
+		vconn_role = TYPEC_SOURCE;
+		break;
+	default:
+		break;
+	}
+
+	desc.usb_pd = 0;
+	desc.accessory = TYPEC_ACCESSORY_NONE;
+	desc.identity = NULL;
+
+	sc->partner = typec_register_partner(sc->port, &desc);
+	if (!sc->partner)
+		return -ENODEV;
+
+	typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
+	typec_set_pwr_role(sc->port, power_role);
+	typec_set_data_role(sc->port, data_role);
+	typec_set_vconn_role(sc->port, vconn_role);
+
+	switch (sc->state) {
+	case SC27XX_ATTACHED_SNK:
+	case SC27XX_DEBUG_CABLE:
+		sc->pre_state = SC27XX_ATTACHED_SNK;
+		extcon_set_state_sync(sc->edev, EXTCON_USB, true);
+		break;
+	case SC27XX_ATTACHED_SRC:
+		sc->pre_state = SC27XX_ATTACHED_SRC;
+		extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, true);
+		break;
+	case SC27XX_AUDIO_CABLE:
+		sc->pre_state = SC27XX_AUDIO_CABLE;
+		extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void sc27xx_typec_disconnect(struct sc27xx_typec *sc, u32 status)
+{
+	typec_unregister_partner(sc->partner);
+	sc->partner = NULL;
+	typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
+	typec_set_pwr_role(sc->port, TYPEC_SINK);
+	typec_set_data_role(sc->port, TYPEC_DEVICE);
+	typec_set_vconn_role(sc->port, TYPEC_SINK);
+
+	switch (sc->pre_state) {
+	case SC27XX_ATTACHED_SNK:
+	case SC27XX_DEBUG_CABLE:
+		extcon_set_state_sync(sc->edev, EXTCON_USB, false);
+		break;
+	case SC27XX_ATTACHED_SRC:
+		extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, false);
+		break;
+	case SC27XX_AUDIO_CABLE:
+		extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, false);
+		break;
+	default:
+		break;
+	}
+}
+
+static irqreturn_t sc27xx_typec_interrupt(int irq, void *data)
+{
+	struct sc27xx_typec *sc = data;
+	u32 event;
+	int ret;
+
+	ret = regmap_read(sc->regmap, sc->base + SC27XX_INT_MASK, &event);
+	if (ret)
+		return ret;
+
+	event &= sc->var_data->event_mask;
+
+	ret = regmap_read(sc->regmap, sc->base + SC27XX_STATUS, &sc->state);
+	if (ret)
+		goto clear_ints;
+
+	sc->state &= sc->var_data->state_mask;
+
+	if (event & SC27XX_ATTACH_INT) {
+		ret = sc27xx_typec_connect(sc, sc->state);
+		if (ret)
+			dev_warn(sc->dev, "failed to register partner\n");
+	} else if (event & SC27XX_DETACH_INT) {
+		sc27xx_typec_disconnect(sc, sc->state);
+	}
+
+clear_ints:
+	regmap_write(sc->regmap, sc->base + sc->var_data->int_clr, event);
+
+	dev_info(sc->dev, "now works as DRP and is in %d state, event %d\n",
+		sc->state, event);
+	return IRQ_HANDLED;
+}
+
+static int sc27xx_typec_enable(struct sc27xx_typec *sc)
+{
+	int ret;
+	u32 val;
+
+	/* Set typec mode */
+	ret = regmap_read(sc->regmap, sc->base + sc->var_data->mode, &val);
+	if (ret)
+		return ret;
+
+	val &= ~SC27XX_MODE_MASK;
+	switch (sc->typec_cap.type) {
+	case TYPEC_PORT_DFP:
+		val |= SC27XX_MODE_SRC;
+		break;
+	case TYPEC_PORT_UFP:
+		val |= SC27XX_MODE_SNK;
+		break;
+	case TYPEC_PORT_DRP:
+		val |= SC27XX_MODE_DRP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write(sc->regmap, sc->base + sc->var_data->mode, val);
+	if (ret)
+		return ret;
+
+	/* typec USB20 only flag, only work in snk mode */
+	if (sc->typec_cap.data == TYPEC_PORT_UFP && sc->usb20_only) {
+		ret = regmap_update_bits(sc->regmap, sc->base + SC27XX_EN,
+					 SC27XX_TYPEC_USB20_ONLY,
+					 SC27XX_TYPEC_USB20_ONLY);
+		if (ret)
+			return ret;
+	}
+
+	/* modify sc2730 tcc debounce to 100ms while PD signal occur at 150ms
+	 * and effect tccde reginize.Reason is hardware signal and clk not
+	 * accurate.
+	 */
+	if (sc->var_data->efuse_cc2_shift == SC2730_EFUSE_CC2_SHIFT) {
+		ret = regmap_write(sc->regmap, sc->base + SC27XX_TCCDE_CNT,
+				SC27XX_TCC_DEBOUNCE_CNT);
+		if (ret)
+			return ret;
+	}
+
+	/* Enable typec interrupt and enable typec */
+	ret = regmap_read(sc->regmap, sc->base + sc->var_data->int_en, &val);
+	if (ret)
+		return ret;
+
+	val |= sc->var_data->attach_en | sc->var_data->detach_en;
+	return regmap_write(sc->regmap, sc->base + sc->var_data->int_en, val);
+}
+
+static const u32 sc27xx_typec_cable[] = {
+	EXTCON_USB,
+	EXTCON_USB_HOST,
+	EXTCON_JACK_HEADPHONE,
+	EXTCON_NONE,
+};
+
+static int sc27xx_typec_get_cc1_efuse(struct sc27xx_typec *sc)
+{
+	struct nvmem_cell *cell;
+	u32 calib_data = 0;
+	void *buf;
+	size_t len;
+
+	cell = nvmem_cell_get(sc->dev, "typec_cc1_cal");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+	calib_data = (calib_data & SC27XX_CC1_MASK(sc->var_data->efuse_cc1_shift))
+			>> SC27XX_CC_SHIFT(sc->var_data->efuse_cc1_shift);
+	kfree(buf);
+
+	return calib_data;
+}
+
+static int sc27xx_typec_get_cc2_efuse(struct sc27xx_typec *sc)
+{
+	struct nvmem_cell *cell;
+	u32 calib_data = 0;
+	void *buf;
+	size_t len = 0;
+
+	cell = nvmem_cell_get(sc->dev, "typec_cc2_cal");
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	memcpy(&calib_data, buf, min(len, sizeof(u32)));
+	calib_data = (calib_data & SC27XX_CC2_MASK(sc->var_data->efuse_cc2_shift))
+			>> SC27XX_CC_SHIFT(sc->var_data->efuse_cc2_shift);
+	kfree(buf);
+
+	return calib_data;
+}
+
+static int typec_set_rtrim(struct sc27xx_typec *sc)
+{
+	int calib_cc1;
+	int calib_cc2;
+	u32 rtrim;
+
+	calib_cc1 = sc27xx_typec_get_cc1_efuse(sc);
+	if (calib_cc1 < 0)
+		return calib_cc1;
+	calib_cc2 = sc27xx_typec_get_cc2_efuse(sc);
+	if (calib_cc2 < 0)
+		return calib_cc2;
+
+	rtrim = calib_cc1 | calib_cc2<<5;
+
+	return regmap_write(sc->regmap, sc->base + SC27XX_RTRIM, rtrim);
+}
+
+static int sc27xx_typec_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = pdev->dev.of_node;
+	struct sc27xx_typec *sc;
+	const struct sprd_typec_variant_data *pdata;
+	int mode, ret;
+
+	pdata = of_device_get_match_data(dev);
+	if (!pdata) {
+		dev_err(&pdev->dev, "No matching driver data found\n");
+		return -EINVAL;
+	}
+
+	sc = devm_kzalloc(&pdev->dev, sizeof(*sc), GFP_KERNEL);
+	if (!sc)
+		return -ENOMEM;
+
+	sc->edev = devm_extcon_dev_allocate(&pdev->dev, sc27xx_typec_cable);
+	if (IS_ERR(sc->edev)) {
+		dev_err(&pdev->dev, "failed to allocate extcon device\n");
+		return PTR_ERR(sc->edev);
+	}
+
+	ret = devm_extcon_dev_register(&pdev->dev, sc->edev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "can't register extcon device: %d\n", ret);
+		return ret;
+	}
+
+	sc->dev = &pdev->dev;
+	sc->irq = platform_get_irq(pdev, 0);
+	if (sc->irq < 0) {
+		dev_err(sc->dev, "failed to get typec interrupt.\n");
+		return sc->irq;
+	}
+
+	sc->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!sc->regmap) {
+		dev_err(sc->dev, "failed to get regmap.\n");
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(node, "reg", &sc->base);
+	if (ret) {
+		dev_err(dev, "failed to get reg offset!\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "sprd,mode", &mode);
+	if (ret) {
+		dev_err(dev, "failed to get typec port mode type\n");
+		return ret;
+	}
+
+	if (mode < TYPEC_PORT_DFP || mode > TYPEC_PORT_DRP
+	    || mode == TYPEC_PORT_UFP) {
+		mode = TYPEC_PORT_UFP;
+		sc->usb20_only = true;
+		dev_info(dev, "usb 2.0 only is enabled\n");
+	}
+
+	sc->var_data = pdata;
+	sc->typec_cap.type = mode;
+	sc->typec_cap.data = TYPEC_PORT_DRD;
+	sc->typec_cap.revision = USB_TYPEC_REV_1_2;
+	sc->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	sc->port = typec_register_port(&pdev->dev, &sc->typec_cap);
+	if (!sc->port) {
+		dev_err(sc->dev, "failed to register port!\n");
+		return -ENODEV;
+	}
+
+	ret = typec_set_rtrim(sc);
+	if (ret < 0) {
+		dev_err(sc->dev, "failed to set typec rtrim %d\n", ret);
+		goto error;
+	}
+
+	ret = devm_request_threaded_irq(sc->dev, sc->irq, NULL,
+					sc27xx_typec_interrupt,
+					IRQF_EARLY_RESUME | IRQF_ONESHOT,
+					dev_name(sc->dev), sc);
+	if (ret) {
+		dev_err(sc->dev, "failed to request irq %d\n", ret);
+		goto error;
+	}
+
+	ret = sc27xx_typec_enable(sc);
+	if (ret)
+		goto error;
+
+	platform_set_drvdata(pdev, sc);
+	return 0;
+
+error:
+	typec_unregister_port(sc->port);
+	return ret;
+}
+
+static int sc27xx_typec_remove(struct platform_device *pdev)
+{
+	struct sc27xx_typec *sc = platform_get_drvdata(pdev);
+
+	sc27xx_typec_disconnect(sc, 0);
+	typec_unregister_port(sc->port);
+
+	return 0;
+}
+
+static const struct of_device_id typec_sprd_match[] = {
+	{.compatible = "sprd,sc2730-typec", .data = &sc2730_data},
+	{.compatible = "sprd,sc2721-typec", .data = &sc2721_data},
+	{.compatible = "sprd,ump96xx-typec", .data = &ump9620_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, typec_sprd_match);
+
+static struct platform_driver sc27xx_typec_driver = {
+	.probe = sc27xx_typec_probe,
+	.remove = sc27xx_typec_remove,
+	.driver = {
+		.name = "sc27xx-typec",
+		.of_match_table = typec_sprd_match,
+	},
+};
+module_platform_driver(sc27xx_typec_driver);
+MODULE_LICENSE("GPL");
+
-- 
2.25.1


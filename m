Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7A496894
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiAVAQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiAVAQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:16:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84263C06173B;
        Fri, 21 Jan 2022 16:16:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id ah7so4286590ejc.4;
        Fri, 21 Jan 2022 16:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QcioYZ2uutzsqiNbfCJ7lyogIcgRTK3T1r6j6Yl7F2Q=;
        b=PeLqSAMF6VftXW1rFvOH0iFD4Lp8jpqlkq1Uqe6PRwumPqTNYsmzjo330154immXBf
         qfp2bTF0MNygBIkfBJueE0KaPay/5lMWArF27ghKMkLnUcb5AXZtLBu14vbzuE62wW9E
         b2W2DQPVh8D1pQTpRq0wbQJ6BEq4cjQx8q/5QKsvBUX+Zs80mP4f9gKMP22Yi9ExKtNi
         AvRe8daSxbSAOhuZuzVHMM6nnANbN2MeBwJJCx4dGctmHjgHeR11kZGv4CPp0fM6o9F3
         l+qg7yw1VC/d59W0UTYe0Z4PxRVwFyk3M21i2vNs4kidgD9GA6dUBWf8ATLwJmeLE3Tz
         7Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcioYZ2uutzsqiNbfCJ7lyogIcgRTK3T1r6j6Yl7F2Q=;
        b=wwwR+qFmScuD0jV9q1QCZjzUXWzyKhRupBFT7cKqEwTeBW3VNi9N7OoT7inpa1ZTTg
         I7v5raVWT/Dwek301C+Z/bGv9BmBR7hcTSKtLS/VSkZwXUBbHvmm2KaO5gP5nSyJ/xA8
         hi4VlsfhbdUoZne9WYgFyRlMZ7V2zSYTrJWt6VpBp3Enup6ytG4tmqwCLwFzdkrgahls
         yFsNCGBGTl0/nYtw8a1wHK3OTiY1VNhzTNbc2KAD1NF4QwPZSfMy6fZ6/HoW198O0po5
         /0UXHlg9dd1WT9sBF/bdzwAv+mO7zysfRqK+yTjuSqpVfzxR+JoWAWFiF1FDHPGy0wkY
         6Jvg==
X-Gm-Message-State: AOAM531MxhTR2fIOifd40cbM5lLk+6dA1sNEcrBs4FkL2g/oLW+N1k+o
        p400qmdduQCC+yosCJ49ptw=
X-Google-Smtp-Source: ABdhPJxAJrwXRcSW5rFonsgmbKTYHr23MFFr+/ad0ww8fMUmSdEOyJw7LYlg93jx7AqdO56DM4MB0Q==
X-Received: by 2002:a17:907:960f:: with SMTP id gb15mr51526ejc.583.1642810582953;
        Fri, 21 Jan 2022 16:16:22 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d8sm2445525ejy.107.2022.01.21.16.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:16:22 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: soc: qcom: add TCSR driver
Date:   Sat, 22 Jan 2022 01:16:09 +0100
Message-Id: <20220122001609.15904-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220122001609.15904-1-ansuelsmth@gmail.com>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QCOM Top Control and Status Registers driver required to control and
configure various peripherals for ipq8064 and ipq4019. This is required
to configure usb3 mode, gsbi configuration for ipq8064 and various
devices (WiFi, USB mode, WiFi memtype, ESS interface mode) for ipq4019.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/soc/qcom/Kconfig     |   8 ++
 drivers/soc/qcom/Makefile    |   1 +
 drivers/soc/qcom/qcom_tcsr.c | 198 +++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100644 drivers/soc/qcom/qcom_tcsr.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e718b8735444..20dd341ae369 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -209,6 +209,14 @@ config QCOM_STATS
 	  various SoC level low power modes statistics and export to debugfs
 	  interface.
 
+config QCOM_TCSR
+	tristate "QCOM Top Control and Status Registers"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Say y here to enable TCSR support. The TCSR provides control
+	  functions for various peripherals (USB, WiFi, ESS).
+
 config QCOM_WCNSS_CTRL
 	tristate "Qualcomm WCNSS control driver"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 70d5de69fd7b..b17dd46ed1fa 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
 obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
 obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
+obj-$(CONFIG_QCOM_TCSR)	 += qcom_tcsr.o
diff --git a/drivers/soc/qcom/qcom_tcsr.c b/drivers/soc/qcom/qcom_tcsr.c
new file mode 100644
index 000000000000..dc80768d57c2
--- /dev/null
+++ b/drivers/soc/qcom/qcom_tcsr.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/bitfield.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+
+#define TCSR_USB_PORT_SEL_REG			0xb0
+#define TCSR_USB_PORT_SEL_MASK			GENMASK(1, 0)
+
+#define TCSR_USB_SELECT_USB3_P0			FIELD_PREP(TCSR_USB_PORT_SEL_MASK, 0x1)
+#define TCSR_USB_SELECT_USB3_P1			FIELD_PREP(TCSR_USB_PORT_SEL_MASK, 0x2)
+#define TCSR_USB_SELECT_USB3_DUAL		FIELD_PREP(TCSR_USB_PORT_SEL_MASK, 0x3)
+
+/* IPQ40xx HS PHY Mode Select */
+#define TCSR_USB_HSPHY_CONFIG_REG		0xc
+#define TCSR_USB_HSPHY_MODE_MASK		BIT(21)
+#define TCSR_USB_HSPHY_MODE_HOST_MODE		FIELD_PREP(TCSR_USB_HSPHY_MODE_MASK, 0x0)
+#define TCSR_USB_HSPHY_MODE_DEVICE_MODE		FIELD_PREP(TCSR_USB_HSPHY_MODE_MASK, 0x1)
+
+/* IPQ40xx ess interface mode select */
+#define TCSR_ESS_INTERFACE_SEL_REG		0x0
+#define TCSR_ESS_INTERFACE_SEL_MASK		GENMASK(3, 0)
+#define TCSR_ESS_PSGMII				FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x0)
+#define TCSR_ESS_PSGMII_RGMII5			FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x1)
+#define TCSR_ESS_PSGMII_RMII0			FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x2)
+#define TCSR_ESS_PSGMII_RMII1			FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x4)
+#define TCSR_ESS_PSGMII_RMII0_RMII1		FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x6)
+#define TCSR_ESS_PSGMII_RGMII4			FIELD_PREP(TCSR_ESS_INTERFACE_SEL_MASK, 0x9)
+
+/* IPQ40xx WiFi Global Config */
+#define TCSR_WIFI0_GLB_CFG_OFFSET_REG		0x0
+#define TCSR_WIFI1_GLB_CFG_OFFSET_REG		0x4
+/* Enable AXI master bus Axid translating to confirm all txn submitted by order */
+#define TCSR_WIFI_GLB_CFG_AXID_EN		BIT(30)
+/* 1:  use locally generate socslv_wxi_bvalid for performance.
+ * 0:  use SNOC socslv_wxi_bvalid.
+ */
+#define TCSR_WIFI_GLB_CFG_SOCSLV_WXI_BVALID	BIT(24)
+#define TCSR_WIFI_GLB_CFG_SOCSLV_SNOC		FIELD_PREP(TCSR_WIFI_GLB_CFG_SOCSLV_WXI_BVALID, 0x0)
+#define TCSR_WIFI_GLB_CFG_SOCSLV_LOCAL		FIELD_PREP(TCSR_WIFI_GLB_CFG_SOCSLV_WXI_BVALID, 0x1)
+
+/* Configure special wifi memory type needed for some IPQ40xx devices */
+#define TCSR_PNOC_SNOC_MEMTYPE_M0_M2_REG	0x4
+#define TCSR_WIFI_NOC_MEMTYPE_MASK		GENMASK(26, 24)
+#define TCSR_WIFI_NOC_MEMTYPE_M0_M2		FIELD_PREP(TCSR_WIFI_NOC_MEMTYPE_MASK, 0x2)
+
+static int qcom_tcsr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node;
+	struct regmap *tcsr;
+	int ret, val;
+
+	node = dev->of_node;
+	tcsr = syscon_node_to_regmap(node);
+	if (IS_ERR(tcsr))
+		return PTR_ERR(tcsr);
+
+	if (of_find_property(node, "qcom,usb-ctrl-select", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq8064")) {
+		if (of_property_match_string(node, "qcom,usb-ctrl-select",
+					     "p0")) {
+			val = TCSR_USB_SELECT_USB3_P0;
+		} else if (of_property_match_string(node, "qcom,usb-ctrl-select",
+						  "p1")) {
+			val = TCSR_USB_SELECT_USB3_P1;
+		} else if (of_property_match_string(node, "qcom,usb-ctrl-select",
+						  "dual")) {
+			val = TCSR_USB_SELECT_USB3_DUAL;
+		} else {
+			dev_err(dev, "invalid value for qcom,usb-ctrl-select");
+			return -EINVAL;
+		}
+
+		ret = regmap_update_bits(tcsr, TCSR_USB_PORT_SEL_REG,
+					 TCSR_USB_PORT_SEL_MASK, val);
+		if (ret)
+			return ret;
+	}
+
+	if (of_find_property(node, "qcom,usb-hsphy-mode-select", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq4019")) {
+		if (of_property_match_string(node, "qcom,usb-hsphy-mode-select",
+					     "host")) {
+			val = TCSR_USB_HSPHY_MODE_HOST_MODE;
+		} else if (of_property_match_string(node, "qcom,usb-hsphy-mode-select",
+						  "device")) {
+			val = TCSR_USB_HSPHY_MODE_DEVICE_MODE;
+		} else {
+			dev_err(dev, "invalid value for qcom,usb-hsphy-mode-select");
+			return -EINVAL;
+		}
+
+		ret = regmap_update_bits(tcsr, TCSR_USB_HSPHY_CONFIG_REG,
+					 TCSR_USB_HSPHY_MODE_MASK, val);
+		if (ret)
+			return ret;
+	}
+
+	if (of_find_property(node, "qcom,ess-interface-select", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq4019")) {
+		if (of_property_match_string(node, "qcom,ess-interface-select",
+					     "psgmii")) {
+			val = TCSR_ESS_PSGMII;
+		} else if (of_property_match_string(node, "qcom,ess-interface-select",
+						  "rgmii5")) {
+			val = TCSR_ESS_PSGMII_RGMII5;
+		} else if (of_property_match_string(node, "qcom,ess-interface-select",
+						  "rmii0")) {
+			val = TCSR_ESS_PSGMII_RMII0;
+		} else if (of_property_match_string(node, "qcom,ess-interface-select",
+						  "rmii1")) {
+			val = TCSR_ESS_PSGMII_RMII1;
+		} else if (of_property_match_string(node, "qcom,ess-interface-select",
+						  "rmii0_rmii1")) {
+			val = TCSR_ESS_PSGMII_RMII0_RMII1;
+		} else if (of_property_match_string(node, "qcom,ess-interface-select",
+						  "rgmii4")) {
+			val = TCSR_ESS_PSGMII_RGMII4;
+		} else {
+			dev_err(dev, "invalid value for qcom,ess-interface-select");
+			return -EINVAL;
+		}
+
+		ret = regmap_update_bits(tcsr, TCSR_ESS_INTERFACE_SEL_REG,
+					 TCSR_ESS_INTERFACE_SEL_MASK, val);
+		if (ret)
+			return ret;
+	}
+
+	if (of_find_property(node, "qcom,wifi-glb-cfg-enable-axid", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq4019")) {
+		ret = regmap_set_bits(tcsr, TCSR_WIFI0_GLB_CFG_OFFSET_REG,
+				      TCSR_WIFI_GLB_CFG_AXID_EN);
+		ret = regmap_set_bits(tcsr, TCSR_WIFI1_GLB_CFG_OFFSET_REG,
+				      TCSR_WIFI_GLB_CFG_AXID_EN);
+		if (ret)
+			return ret;
+	}
+
+	if (of_find_property(node, "qcom,wifi-glb-cfg-socslv-mode", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq4019")) {
+		if (of_property_match_string(node, "qcom,wifi-glb-cfg-socslv-mode",
+					     "snoc")) {
+			val = TCSR_WIFI_GLB_CFG_SOCSLV_SNOC;
+		} else if (of_property_match_string(node, "qcom,wifi-glb-cfg-socslv-mode",
+						  "local")) {
+			val = TCSR_WIFI_GLB_CFG_SOCSLV_SNOC;
+		} else {
+			dev_err(dev, "invalid value for qcom,wifi-glb-cfg-socslv-mode");
+			return -EINVAL;
+		}
+
+		ret = regmap_update_bits(tcsr, TCSR_WIFI0_GLB_CFG_OFFSET_REG,
+					 TCSR_WIFI_GLB_CFG_SOCSLV_WXI_BVALID, val);
+		ret = regmap_update_bits(tcsr, TCSR_WIFI1_GLB_CFG_OFFSET_REG,
+					 TCSR_WIFI_GLB_CFG_SOCSLV_WXI_BVALID, val);
+	}
+
+	if (of_find_property(node, "qcom,wifi_noc_memtype_m0_m2", NULL) &&
+	    of_device_is_compatible(node, "qcom,tcsr-ipq4019")) {
+		ret = regmap_update_bits(tcsr, TCSR_PNOC_SNOC_MEMTYPE_M0_M2_REG,
+					 TCSR_WIFI_NOC_MEMTYPE_MASK,
+					 TCSR_WIFI_NOC_MEMTYPE_M0_M2);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id qcom_tcsr_dt_match[] = {
+	{ .compatible = "qcom,tcsr-ipq8064", },
+	{ .compatible = "qcom,tcsr-ipq4019", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_tcsr_dt_match);
+
+static struct platform_driver qcom_tcsr_driver = {
+	.probe = qcom_tcsr_probe,
+	.driver = {
+		.name		= "qcom-tcsr",
+		.of_match_table	= qcom_tcsr_dt_match,
+	},
+};
+
+module_platform_driver(qcom_tcsr_driver);
+
+MODULE_AUTHOR("Ansuel Smith <ansuelsmth@gmail.com>");
+MODULE_DESCRIPTION("QCOM TCSR driver");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78029582420
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiG0KWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiG0KV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:21:59 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32042AFA;
        Wed, 27 Jul 2022 03:21:49 -0700 (PDT)
X-UUID: 318bfb2912f24c269f55467238768656-20220727
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:d4d13170-a946-49b4-86aa-340c0b04c861,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:0f94e32,CLOUDID:dd2685c9-5f65-4fda-abe9-f2436fed4c72,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:1,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:1
X-UUID: 318bfb2912f24c269f55467238768656-20220727
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <hui.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 183958589; Wed, 27 Jul 2022 18:21:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 27 Jul 2022 18:21:45 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jul 2022 18:21:44 +0800
From:   Hui Liu <hui.liu@mediatek.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <hui.liu@mediatek.com>, <jianguo.zhang@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <sean.wang@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] pinctrl: mediatek: add mt8188 driver
Date:   Wed, 27 Jul 2022 18:21:40 +0800
Message-ID: <20220727102140.6676-3-hui.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220727102140.6676-1-hui.liu@mediatek.com>
References: <20220727102140.6676-1-hui.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Hui.Liu" <hui.liu@mediatek.com>

Add pinctrl driver support for MediaTek SoC mt8188.

Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig              |   12 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8188.c     | 1669 ++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h | 2260 +++++++++++++++++
 4 files changed, 3942 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8188.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 1600a2c18eee..fed02c6fea06 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -162,6 +162,18 @@ config PINCTRL_MT8186
 	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_PARIS
 
+config PINCTRL_MT8188
+	bool "MediaTek MT8188 pin control"
+	depends on OF
+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK_PARIS
+	help
+	  Say yes here to support pin controller and gpio driver
+	  on MediaTek MT8188 SoC.
+	  In MTK platform, we support virtual gpio and use it to
+	  map specific eint which doesn't have real gpio pin.
+
 config PINCTRL_MT8192
 	bool "Mediatek MT8192 pin control"
 	depends on OF
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index c8f226ae36c9..53265404a39d 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL_MT8167)	+= pinctrl-mt8167.o
 obj-$(CONFIG_PINCTRL_MT8173)	+= pinctrl-mt8173.o
 obj-$(CONFIG_PINCTRL_MT8183)	+= pinctrl-mt8183.o
 obj-$(CONFIG_PINCTRL_MT8186)	+= pinctrl-mt8186.o
+obj-$(CONFIG_PINCTRL_MT8188)	+= pinctrl-mt8188.o
 obj-$(CONFIG_PINCTRL_MT8192)	+= pinctrl-mt8192.o
 obj-$(CONFIG_PINCTRL_MT8195)    += pinctrl-mt8195.o
 obj-$(CONFIG_PINCTRL_MT8365)	+= pinctrl-mt8365.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8188.c b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
new file mode 100644
index 000000000000..3f4f78b65c29
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8188.c
@@ -0,0 +1,1669 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ * Auther: Hui Liu <hui.liu@mediatek.com>
+ *
+ */
+
+#include <linux/module.h>
+#include "pinctrl-mtk-mt8188.h"
+#include "pinctrl-paris.h"
+
+/* MT8188 have multiple bases to program pin configuration listed as the below:
+ * iocfg[0]:0x10005000, iocfg[1]:0x11c00000, iocfg[2]:0x11e10000,
+ * iocfg[3]:0x11e20000, iocfg[4]:0x11ea0000
+ * _i_based could be used to indicate what base the pin should be mapped into.
+ */
+
+#define PIN_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits)  \
+	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits, \
+		32, 0)
+
+#define PINS_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits) \
+	PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits, \
+		32, 1)
+
+static const struct mtk_pin_field_calc mt8188_pin_mode_range[] = {
+	PIN_FIELD(0, 177, 0x0300, 0x10, 0, 4),
+};
+static const struct mtk_pin_field_calc mt8188_pin_dir_range[] = {
+	PIN_FIELD(0, 177, 0x0000, 0x10, 0, 1),
+};
+static const struct mtk_pin_field_calc mt8188_pin_di_range[] = {
+	PIN_FIELD(0, 177, 0x0200, 0x10, 0, 1),
+};
+static const struct mtk_pin_field_calc mt8188_pin_do_range[] = {
+	PIN_FIELD(0, 177, 0x0100, 0x10, 0, 1),
+};
+static const struct mtk_pin_field_calc mt8188_pin_smt_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x0170, 0x10, 8, 1),
+	PIN_FIELD_BASE(1, 1, 1, 0x0170, 0x10, 9, 1),
+	PIN_FIELD_BASE(2, 2, 1, 0x0170, 0x10, 10, 1),
+	PIN_FIELD_BASE(3, 3, 1, 0x0170, 0x10, 11, 1),
+	PIN_FIELD_BASE(4, 4, 1, 0x0170, 0x10, 18, 1),
+	PIN_FIELD_BASE(5, 5, 1, 0x0170, 0x10, 18, 1),
+	PIN_FIELD_BASE(6, 6, 1, 0x0170, 0x10, 18, 1),
+	PIN_FIELD_BASE(7, 7, 1, 0x0170, 0x10, 12, 1),
+	PIN_FIELD_BASE(8, 8, 1, 0x0170, 0x10, 13, 1),
+	PIN_FIELD_BASE(9, 9, 1, 0x0170, 0x10, 14, 1),
+	PIN_FIELD_BASE(10, 10, 1, 0x0170, 0x10, 15, 1),
+	PIN_FIELD_BASE(11, 11, 1, 0x0170, 0x10, 19, 1),
+	PIN_FIELD_BASE(12, 12, 2, 0x0160, 0x10, 12, 1),
+	PIN_FIELD_BASE(13, 13, 2, 0x0160, 0x10, 13, 1),
+	PIN_FIELD_BASE(14, 14, 2, 0x0160, 0x10, 14, 1),
+	PIN_FIELD_BASE(15, 15, 2, 0x0160, 0x10, 15, 1),
+	PIN_FIELD_BASE(16, 16, 3, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(17, 17, 3, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(18, 18, 4, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(19, 19, 4, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(20, 20, 4, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(21, 21, 4, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(22, 22, 4, 0x00e0, 0x10, 0, 1),
+	PIN_FIELD_BASE(23, 23, 4, 0x00e0, 0x10, 1, 1),
+	PIN_FIELD_BASE(24, 24, 4, 0x00e0, 0x10, 2, 1),
+	PIN_FIELD_BASE(25, 25, 1, 0x0170, 0x10, 17, 1),
+	PIN_FIELD_BASE(26, 26, 1, 0x0170, 0x10, 17, 1),
+	PIN_FIELD_BASE(27, 27, 1, 0x0170, 0x10, 17, 1),
+	PIN_FIELD_BASE(28, 28, 1, 0x0170, 0x10, 18, 1),
+	PIN_FIELD_BASE(29, 29, 1, 0x0170, 0x10, 16, 1),
+	PIN_FIELD_BASE(30, 30, 1, 0x0170, 0x10, 17, 1),
+	PIN_FIELD_BASE(31, 31, 1, 0x0170, 0x10, 19, 1),
+	PIN_FIELD_BASE(32, 32, 1, 0x0170, 0x10, 19, 1),
+	PIN_FIELD_BASE(33, 33, 1, 0x0170, 0x10, 20, 1),
+	PIN_FIELD_BASE(34, 34, 1, 0x0170, 0x10, 20, 1),
+	PIN_FIELD_BASE(35, 35, 1, 0x0170, 0x10, 19, 1),
+	PIN_FIELD_BASE(36, 36, 1, 0x0170, 0x10, 20, 1),
+	PIN_FIELD_BASE(37, 37, 1, 0x0170, 0x10, 21, 1),
+	PIN_FIELD_BASE(38, 38, 1, 0x0170, 0x10, 20, 1),
+	PIN_FIELD_BASE(39, 39, 1, 0x0170, 0x10, 21, 1),
+	PIN_FIELD_BASE(40, 40, 1, 0x0170, 0x10, 21, 1),
+	PIN_FIELD_BASE(41, 41, 1, 0x0170, 0x10, 21, 1),
+	PIN_FIELD_BASE(42, 42, 2, 0x0160, 0x10, 21, 1),
+	PIN_FIELD_BASE(43, 43, 2, 0x0160, 0x10, 22, 1),
+	PIN_FIELD_BASE(44, 44, 2, 0x0160, 0x10, 21, 1),
+	PIN_FIELD_BASE(45, 45, 2, 0x0160, 0x10, 22, 1),
+	PIN_FIELD_BASE(46, 46, 3, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(47, 47, 1, 0x0170, 0x10, 16, 1),
+	PIN_FIELD_BASE(48, 48, 1, 0x0170, 0x10, 16, 1),
+	PIN_FIELD_BASE(49, 49, 1, 0x0170, 0x10, 16, 1),
+	PIN_FIELD_BASE(50, 50, 3, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(51, 51, 3, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(52, 52, 3, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(53, 53, 3, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(54, 54, 3, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(55, 55, 1, 0x0170, 0x10, 25, 1),
+	PIN_FIELD_BASE(56, 56, 1, 0x0170, 0x10, 28, 1),
+	PIN_FIELD_BASE(57, 57, 2, 0x0160, 0x10, 29, 1),
+	PIN_FIELD_BASE(58, 58, 2, 0x0160, 0x10, 31, 1),
+	PIN_FIELD_BASE(59, 59, 1, 0x0170, 0x10, 26, 1),
+	PIN_FIELD_BASE(60, 60, 1, 0x0170, 0x10, 29, 1),
+	PIN_FIELD_BASE(61, 61, 1, 0x0170, 0x10, 27, 1),
+	PIN_FIELD_BASE(62, 62, 1, 0x0170, 0x10, 30, 1),
+	PIN_FIELD_BASE(63, 63, 2, 0x0160, 0x10, 30, 1),
+	PIN_FIELD_BASE(64, 64, 2, 0x0170, 0x10, 0, 1),
+	PIN_FIELD_BASE(65, 65, 4, 0x00e0, 0x10, 10, 1),
+	PIN_FIELD_BASE(66, 66, 4, 0x00e0, 0x10, 12, 1),
+	PIN_FIELD_BASE(67, 67, 4, 0x00e0, 0x10, 11, 1),
+	PIN_FIELD_BASE(68, 68, 4, 0x00e0, 0x10, 13, 1),
+	PIN_FIELD_BASE(69, 69, 1, 0x0180, 0x10, 0, 1),
+	PIN_FIELD_BASE(70, 70, 1, 0x0170, 0x10, 31, 1),
+	PIN_FIELD_BASE(71, 71, 1, 0x0180, 0x10, 4, 1),
+	PIN_FIELD_BASE(72, 72, 1, 0x0180, 0x10, 3, 1),
+	PIN_FIELD_BASE(73, 73, 1, 0x0180, 0x10, 1, 1),
+	PIN_FIELD_BASE(74, 74, 1, 0x0180, 0x10, 2, 1),
+	PIN_FIELD_BASE(75, 75, 1, 0x0180, 0x10, 6, 1),
+	PIN_FIELD_BASE(76, 76, 1, 0x0180, 0x10, 5, 1),
+	PIN_FIELD_BASE(77, 77, 1, 0x0180, 0x10, 8, 1),
+	PIN_FIELD_BASE(78, 78, 1, 0x0180, 0x10, 7, 1),
+	PIN_FIELD_BASE(79, 79, 4, 0x00e0, 0x10, 15, 1),
+	PIN_FIELD_BASE(80, 80, 4, 0x00e0, 0x10, 14, 1),
+	PIN_FIELD_BASE(81, 81, 4, 0x00e0, 0x10, 17, 1),
+	PIN_FIELD_BASE(82, 82, 4, 0x00e0, 0x10, 16, 1),
+	PIN_FIELD_BASE(83, 83, 2, 0x0160, 0x10, 26, 1),
+	PIN_FIELD_BASE(84, 84, 2, 0x0160, 0x10, 26, 1),
+	PIN_FIELD_BASE(85, 85, 2, 0x0160, 0x10, 27, 1),
+	PIN_FIELD_BASE(86, 86, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(87, 87, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(88, 88, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(89, 89, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(90, 90, 2, 0x0160, 0x10, 27, 1),
+	PIN_FIELD_BASE(91, 91, 2, 0x0160, 0x10, 27, 1),
+	PIN_FIELD_BASE(92, 92, 2, 0x0160, 0x10, 18, 1),
+	PIN_FIELD_BASE(93, 93, 2, 0x0160, 0x10, 18, 1),
+	PIN_FIELD_BASE(94, 94, 2, 0x0160, 0x10, 18, 1),
+	PIN_FIELD_BASE(95, 95, 2, 0x0160, 0x10, 18, 1),
+	PIN_FIELD_BASE(96, 96, 2, 0x0160, 0x10, 22, 1),
+	PIN_FIELD_BASE(97, 97, 2, 0x0160, 0x10, 23, 1),
+	PIN_FIELD_BASE(98, 98, 2, 0x0160, 0x10, 24, 1),
+	PIN_FIELD_BASE(99, 99, 2, 0x0160, 0x10, 22, 1),
+	PIN_FIELD_BASE(100, 100, 2, 0x0160, 0x10, 16, 1),
+	PIN_FIELD_BASE(101, 101, 2, 0x0160, 0x10, 23, 1),
+	PIN_FIELD_BASE(102, 102, 2, 0x0160, 0x10, 23, 1),
+	PIN_FIELD_BASE(103, 103, 2, 0x0160, 0x10, 23, 1),
+	PIN_FIELD_BASE(104, 104, 2, 0x0160, 0x10, 24, 1),
+	PIN_FIELD_BASE(105, 105, 2, 0x0160, 0x10, 24, 1),
+	PIN_FIELD_BASE(106, 106, 2, 0x0160, 0x10, 24, 1),
+	PIN_FIELD_BASE(107, 107, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(108, 108, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(109, 109, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(110, 110, 2, 0x0160, 0x10, 17, 1),
+	PIN_FIELD_BASE(111, 111, 2, 0x0160, 0x10, 19, 1),
+	PIN_FIELD_BASE(112, 112, 2, 0x0160, 0x10, 19, 1),
+	PIN_FIELD_BASE(113, 113, 2, 0x0160, 0x10, 19, 1),
+	PIN_FIELD_BASE(114, 114, 2, 0x0160, 0x10, 19, 1),
+	PIN_FIELD_BASE(115, 115, 2, 0x0160, 0x10, 20, 1),
+	PIN_FIELD_BASE(116, 116, 2, 0x0160, 0x10, 20, 1),
+	PIN_FIELD_BASE(117, 117, 2, 0x0160, 0x10, 20, 1),
+	PIN_FIELD_BASE(118, 118, 2, 0x0160, 0x10, 20, 1),
+	PIN_FIELD_BASE(119, 119, 2, 0x0160, 0x10, 21, 1),
+	PIN_FIELD_BASE(120, 120, 2, 0x0160, 0x10, 21, 1),
+	PIN_FIELD_BASE(121, 121, 3, 0x00d0, 0x10, 6, 1),
+	PIN_FIELD_BASE(122, 122, 3, 0x00d0, 0x10, 9, 1),
+	PIN_FIELD_BASE(123, 123, 3, 0x00d0, 0x10, 8, 1),
+	PIN_FIELD_BASE(124, 124, 3, 0x00d0, 0x10, 7, 1),
+	PIN_FIELD_BASE(125, 125, 2, 0x0160, 0x10, 25, 1),
+	PIN_FIELD_BASE(126, 126, 2, 0x0160, 0x10, 25, 1),
+	PIN_FIELD_BASE(127, 127, 2, 0x0160, 0x10, 25, 1),
+	PIN_FIELD_BASE(128, 128, 2, 0x0160, 0x10, 25, 1),
+	PIN_FIELD_BASE(129, 129, 2, 0x0160, 0x10, 26, 1),
+	PIN_FIELD_BASE(130, 130, 2, 0x0160, 0x10, 26, 1),
+	PIN_FIELD_BASE(131, 131, 1, 0x0170, 0x10, 0, 1),
+	PIN_FIELD_BASE(132, 132, 1, 0x0170, 0x10, 1, 1),
+	PIN_FIELD_BASE(133, 133, 1, 0x0170, 0x10, 6, 1),
+	PIN_FIELD_BASE(134, 134, 1, 0x0170, 0x10, 7, 1),
+	PIN_FIELD_BASE(135, 135, 1, 0x0170, 0x10, 22, 1),
+	PIN_FIELD_BASE(136, 136, 1, 0x0170, 0x10, 22, 1),
+	PIN_FIELD_BASE(137, 137, 1, 0x0170, 0x10, 22, 1),
+	PIN_FIELD_BASE(138, 138, 1, 0x0170, 0x10, 22, 1),
+	PIN_FIELD_BASE(139, 139, 1, 0x0170, 0x10, 23, 1),
+	PIN_FIELD_BASE(140, 140, 1, 0x0170, 0x10, 23, 1),
+	PIN_FIELD_BASE(141, 141, 1, 0x0170, 0x10, 23, 1),
+	PIN_FIELD_BASE(142, 142, 1, 0x0170, 0x10, 23, 1),
+	PIN_FIELD_BASE(143, 143, 1, 0x0170, 0x10, 2, 1),
+	PIN_FIELD_BASE(144, 144, 1, 0x0170, 0x10, 3, 1),
+	PIN_FIELD_BASE(145, 145, 1, 0x0170, 0x10, 4, 1),
+	PIN_FIELD_BASE(146, 146, 1, 0x0170, 0x10, 5, 1),
+	PIN_FIELD_BASE(147, 147, 1, 0x0170, 0x10, 24, 1),
+	PIN_FIELD_BASE(148, 148, 1, 0x0170, 0x10, 24, 1),
+	PIN_FIELD_BASE(149, 149, 1, 0x0170, 0x10, 24, 1),
+	PIN_FIELD_BASE(150, 150, 1, 0x0170, 0x10, 24, 1),
+	PIN_FIELD_BASE(151, 151, 2, 0x0160, 0x10, 9, 1),
+	PIN_FIELD_BASE(152, 152, 2, 0x0160, 0x10, 8, 1),
+	PIN_FIELD_BASE(153, 153, 2, 0x0160, 0x10, 7, 1),
+	PIN_FIELD_BASE(154, 154, 2, 0x0160, 0x10, 6, 1),
+	PIN_FIELD_BASE(155, 155, 2, 0x0160, 0x10, 11, 1),
+	PIN_FIELD_BASE(156, 156, 2, 0x0160, 0x10, 1, 1),
+	PIN_FIELD_BASE(157, 157, 2, 0x0160, 0x10, 0, 1),
+	PIN_FIELD_BASE(158, 158, 2, 0x0160, 0x10, 5, 1),
+	PIN_FIELD_BASE(159, 159, 2, 0x0160, 0x10, 4, 1),
+	PIN_FIELD_BASE(160, 160, 2, 0x0160, 0x10, 3, 1),
+	PIN_FIELD_BASE(161, 161, 2, 0x0160, 0x10, 2, 1),
+	PIN_FIELD_BASE(162, 162, 2, 0x0160, 0x10, 10, 1),
+	PIN_FIELD_BASE(163, 163, 4, 0x00e0, 0x10, 4, 1),
+	PIN_FIELD_BASE(164, 164, 4, 0x00e0, 0x10, 3, 1),
+	PIN_FIELD_BASE(165, 165, 4, 0x00e0, 0x10, 5, 1),
+	PIN_FIELD_BASE(166, 166, 4, 0x00e0, 0x10, 6, 1),
+	PIN_FIELD_BASE(167, 167, 4, 0x00e0, 0x10, 7, 1),
+	PIN_FIELD_BASE(168, 168, 4, 0x00e0, 0x10, 8, 1),
+	PIN_FIELD_BASE(169, 169, 3, 0x00d0, 0x10, 1, 1),
+	PIN_FIELD_BASE(170, 170, 3, 0x00d0, 0x10, 0, 1),
+	PIN_FIELD_BASE(171, 171, 3, 0x00d0, 0x10, 2, 1),
+	PIN_FIELD_BASE(172, 172, 3, 0x00d0, 0x10, 3, 1),
+	PIN_FIELD_BASE(173, 173, 3, 0x00d0, 0x10, 4, 1),
+	PIN_FIELD_BASE(174, 174, 3, 0x00d0, 0x10, 5, 1),
+	PIN_FIELD_BASE(175, 175, 2, 0x0160, 0x10, 28, 1),
+	PIN_FIELD_BASE(176, 176, 2, 0x0160, 0x10, 28, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_ies_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x0080, 0x10, 26, 1),
+	PIN_FIELD_BASE(1, 1, 1, 0x0080, 0x10, 27, 1),
+	PIN_FIELD_BASE(2, 2, 1, 0x0080, 0x10, 28, 1),
+	PIN_FIELD_BASE(3, 3, 1, 0x0080, 0x10, 29, 1),
+	PIN_FIELD_BASE(4, 4, 1, 0x0080, 0x10, 30, 1),
+	PIN_FIELD_BASE(5, 5, 1, 0x0080, 0x10, 31, 1),
+	PIN_FIELD_BASE(6, 6, 1, 0x0090, 0x10, 0, 1),
+	PIN_FIELD_BASE(7, 7, 1, 0x0090, 0x10, 1, 1),
+	PIN_FIELD_BASE(8, 8, 1, 0x0090, 0x10, 2, 1),
+	PIN_FIELD_BASE(9, 9, 1, 0x0090, 0x10, 3, 1),
+	PIN_FIELD_BASE(10, 10, 1, 0x0090, 0x10, 4, 1),
+	PIN_FIELD_BASE(11, 11, 1, 0x0090, 0x10, 5, 1),
+	PIN_FIELD_BASE(12, 12, 2, 0x0070, 0x10, 24, 1),
+	PIN_FIELD_BASE(13, 13, 2, 0x0070, 0x10, 25, 1),
+	PIN_FIELD_BASE(14, 14, 2, 0x0070, 0x10, 26, 1),
+	PIN_FIELD_BASE(15, 15, 2, 0x0070, 0x10, 27, 1),
+	PIN_FIELD_BASE(16, 16, 3, 0x0040, 0x10, 1, 1),
+	PIN_FIELD_BASE(17, 17, 3, 0x0040, 0x10, 2, 1),
+	PIN_FIELD_BASE(18, 18, 4, 0x0050, 0x10, 3, 1),
+	PIN_FIELD_BASE(19, 19, 4, 0x0050, 0x10, 5, 1),
+	PIN_FIELD_BASE(20, 20, 4, 0x0050, 0x10, 4, 1),
+	PIN_FIELD_BASE(21, 21, 4, 0x0050, 0x10, 6, 1),
+	PIN_FIELD_BASE(22, 22, 4, 0x0050, 0x10, 0, 1),
+	PIN_FIELD_BASE(23, 23, 4, 0x0050, 0x10, 1, 1),
+	PIN_FIELD_BASE(24, 24, 4, 0x0050, 0x10, 2, 1),
+	PIN_FIELD_BASE(25, 25, 1, 0x0080, 0x10, 23, 1),
+	PIN_FIELD_BASE(26, 26, 1, 0x0080, 0x10, 22, 1),
+	PIN_FIELD_BASE(27, 27, 1, 0x0080, 0x10, 25, 1),
+	PIN_FIELD_BASE(28, 28, 1, 0x0080, 0x10, 24, 1),
+	PIN_FIELD_BASE(29, 29, 1, 0x0080, 0x10, 0, 1),
+	PIN_FIELD_BASE(30, 30, 1, 0x0080, 0x10, 1, 1),
+	PIN_FIELD_BASE(31, 31, 1, 0x0090, 0x10, 31, 1),
+	PIN_FIELD_BASE(32, 32, 1, 0x0090, 0x10, 30, 1),
+	PIN_FIELD_BASE(33, 33, 1, 0x00a0, 0x10, 1, 1),
+	PIN_FIELD_BASE(34, 34, 1, 0x00a0, 0x10, 0, 1),
+	PIN_FIELD_BASE(35, 35, 1, 0x00a0, 0x10, 3, 1),
+	PIN_FIELD_BASE(36, 36, 1, 0x00a0, 0x10, 2, 1),
+	PIN_FIELD_BASE(37, 37, 1, 0x0090, 0x10, 9, 1),
+	PIN_FIELD_BASE(38, 38, 1, 0x0090, 0x10, 6, 1),
+	PIN_FIELD_BASE(39, 39, 1, 0x0090, 0x10, 7, 1),
+	PIN_FIELD_BASE(40, 40, 1, 0x0090, 0x10, 8, 1),
+	PIN_FIELD_BASE(41, 41, 1, 0x0090, 0x10, 10, 1),
+	PIN_FIELD_BASE(42, 42, 2, 0x0080, 0x10, 10, 1),
+	PIN_FIELD_BASE(43, 43, 2, 0x0080, 0x10, 11, 1),
+	PIN_FIELD_BASE(44, 44, 2, 0x0080, 0x10, 12, 1),
+	PIN_FIELD_BASE(45, 45, 2, 0x0080, 0x10, 13, 1),
+	PIN_FIELD_BASE(46, 46, 3, 0x0040, 0x10, 0, 1),
+	PIN_FIELD_BASE(47, 47, 1, 0x0090, 0x10, 13, 1),
+	PIN_FIELD_BASE(48, 48, 1, 0x0090, 0x10, 12, 1),
+	PIN_FIELD_BASE(49, 49, 1, 0x0090, 0x10, 11, 1),
+	PIN_FIELD_BASE(50, 50, 3, 0x0040, 0x10, 5, 1),
+	PIN_FIELD_BASE(51, 51, 3, 0x0040, 0x10, 4, 1),
+	PIN_FIELD_BASE(52, 52, 3, 0x0040, 0x10, 3, 1),
+	PIN_FIELD_BASE(53, 53, 3, 0x0040, 0x10, 6, 1),
+	PIN_FIELD_BASE(54, 54, 3, 0x0040, 0x10, 7, 1),
+	PIN_FIELD_BASE(55, 55, 1, 0x0090, 0x10, 14, 1),
+	PIN_FIELD_BASE(56, 56, 1, 0x0090, 0x10, 17, 1),
+	PIN_FIELD_BASE(57, 57, 2, 0x0080, 0x10, 22, 1),
+	PIN_FIELD_BASE(58, 58, 2, 0x0080, 0x10, 25, 1),
+	PIN_FIELD_BASE(59, 59, 1, 0x0090, 0x10, 15, 1),
+	PIN_FIELD_BASE(60, 60, 1, 0x0090, 0x10, 18, 1),
+	PIN_FIELD_BASE(61, 61, 1, 0x0090, 0x10, 16, 1),
+	PIN_FIELD_BASE(62, 62, 1, 0x0090, 0x10, 19, 1),
+	PIN_FIELD_BASE(63, 63, 2, 0x0080, 0x10, 23, 1),
+	PIN_FIELD_BASE(64, 64, 2, 0x0080, 0x10, 26, 1),
+	PIN_FIELD_BASE(65, 65, 4, 0x0050, 0x10, 13, 1),
+	PIN_FIELD_BASE(66, 66, 4, 0x0050, 0x10, 15, 1),
+	PIN_FIELD_BASE(67, 67, 4, 0x0050, 0x10, 14, 1),
+	PIN_FIELD_BASE(68, 68, 4, 0x0050, 0x10, 16, 1),
+	PIN_FIELD_BASE(69, 69, 1, 0x0090, 0x10, 21, 1),
+	PIN_FIELD_BASE(70, 70, 1, 0x0090, 0x10, 20, 1),
+	PIN_FIELD_BASE(71, 71, 1, 0x0090, 0x10, 25, 1),
+	PIN_FIELD_BASE(72, 72, 1, 0x0090, 0x10, 24, 1),
+	PIN_FIELD_BASE(73, 73, 1, 0x0090, 0x10, 22, 1),
+	PIN_FIELD_BASE(74, 74, 1, 0x0090, 0x10, 23, 1),
+	PIN_FIELD_BASE(75, 75, 1, 0x0090, 0x10, 27, 1),
+	PIN_FIELD_BASE(76, 76, 1, 0x0090, 0x10, 26, 1),
+	PIN_FIELD_BASE(77, 77, 1, 0x0090, 0x10, 29, 1),
+	PIN_FIELD_BASE(78, 78, 1, 0x0090, 0x10, 28, 1),
+	PIN_FIELD_BASE(79, 79, 4, 0x0050, 0x10, 18, 1),
+	PIN_FIELD_BASE(80, 80, 4, 0x0050, 0x10, 17, 1),
+	PIN_FIELD_BASE(81, 81, 4, 0x0050, 0x10, 20, 1),
+	PIN_FIELD_BASE(82, 82, 4, 0x0050, 0x10, 19, 1),
+	PIN_FIELD_BASE(83, 83, 2, 0x0080, 0x10, 30, 1),
+	PIN_FIELD_BASE(84, 84, 2, 0x0080, 0x10, 29, 1),
+	PIN_FIELD_BASE(85, 85, 2, 0x0080, 0x10, 31, 1),
+	PIN_FIELD_BASE(86, 86, 2, 0x0090, 0x10, 1, 1),
+	PIN_FIELD_BASE(87, 87, 2, 0x0090, 0x10, 0, 1),
+	PIN_FIELD_BASE(88, 88, 2, 0x0090, 0x10, 2, 1),
+	PIN_FIELD_BASE(89, 89, 2, 0x0090, 0x10, 4, 1),
+	PIN_FIELD_BASE(90, 90, 2, 0x0090, 0x10, 3, 1),
+	PIN_FIELD_BASE(91, 91, 2, 0x0090, 0x10, 5, 1),
+	PIN_FIELD_BASE(92, 92, 2, 0x0080, 0x10, 19, 1),
+	PIN_FIELD_BASE(93, 93, 2, 0x0080, 0x10, 18, 1),
+	PIN_FIELD_BASE(94, 94, 2, 0x0080, 0x10, 21, 1),
+	PIN_FIELD_BASE(95, 95, 2, 0x0080, 0x10, 20, 1),
+	PIN_FIELD_BASE(96, 96, 2, 0x0080, 0x10, 15, 1),
+	PIN_FIELD_BASE(97, 97, 2, 0x0080, 0x10, 16, 1),
+	PIN_FIELD_BASE(98, 98, 2, 0x0080, 0x10, 24, 1),
+	PIN_FIELD_BASE(99, 99, 2, 0x0080, 0x10, 14, 1),
+	PIN_FIELD_BASE(100, 100, 2, 0x0080, 0x10, 17, 1),
+	PIN_FIELD_BASE(101, 101, 2, 0x0070, 0x10, 0, 1),
+	PIN_FIELD_BASE(102, 102, 2, 0x0070, 0x10, 5, 1),
+	PIN_FIELD_BASE(103, 103, 2, 0x0070, 0x10, 3, 1),
+	PIN_FIELD_BASE(104, 104, 2, 0x0070, 0x10, 4, 1),
+	PIN_FIELD_BASE(105, 105, 2, 0x0070, 0x10, 1, 1),
+	PIN_FIELD_BASE(106, 106, 2, 0x0070, 0x10, 2, 1),
+	PIN_FIELD_BASE(107, 107, 2, 0x0080, 0x10, 1, 1),
+	PIN_FIELD_BASE(108, 108, 2, 0x0070, 0x10, 28, 1),
+	PIN_FIELD_BASE(109, 109, 2, 0x0080, 0x10, 2, 1),
+	PIN_FIELD_BASE(110, 110, 2, 0x0070, 0x10, 29, 1),
+	PIN_FIELD_BASE(111, 111, 2, 0x0070, 0x10, 30, 1),
+	PIN_FIELD_BASE(112, 112, 2, 0x0070, 0x10, 31, 1),
+	PIN_FIELD_BASE(113, 113, 2, 0x0080, 0x10, 0, 1),
+	PIN_FIELD_BASE(114, 114, 2, 0x0080, 0x10, 8, 1),
+	PIN_FIELD_BASE(115, 115, 2, 0x0080, 0x10, 3, 1),
+	PIN_FIELD_BASE(116, 116, 2, 0x0080, 0x10, 9, 1),
+	PIN_FIELD_BASE(117, 117, 2, 0x0080, 0x10, 4, 1),
+	PIN_FIELD_BASE(118, 118, 2, 0x0080, 0x10, 5, 1),
+	PIN_FIELD_BASE(119, 119, 2, 0x0080, 0x10, 6, 1),
+	PIN_FIELD_BASE(120, 120, 2, 0x0080, 0x10, 7, 1),
+	PIN_FIELD_BASE(121, 121, 3, 0x0040, 0x10, 14, 1),
+	PIN_FIELD_BASE(122, 122, 3, 0x0040, 0x10, 17, 1),
+	PIN_FIELD_BASE(123, 123, 3, 0x0040, 0x10, 16, 1),
+	PIN_FIELD_BASE(124, 124, 3, 0x0040, 0x10, 15, 1),
+	PIN_FIELD_BASE(125, 125, 2, 0x0070, 0x10, 6, 1),
+	PIN_FIELD_BASE(126, 126, 2, 0x0070, 0x10, 7, 1),
+	PIN_FIELD_BASE(127, 127, 2, 0x0070, 0x10, 8, 1),
+	PIN_FIELD_BASE(128, 128, 2, 0x0070, 0x10, 9, 1),
+	PIN_FIELD_BASE(129, 129, 2, 0x0070, 0x10, 10, 1),
+	PIN_FIELD_BASE(130, 130, 2, 0x0070, 0x10, 11, 1),
+	PIN_FIELD_BASE(131, 131, 1, 0x0080, 0x10, 3, 1),
+	PIN_FIELD_BASE(132, 132, 1, 0x0080, 0x10, 4, 1),
+	PIN_FIELD_BASE(133, 133, 1, 0x0080, 0x10, 11, 1),
+	PIN_FIELD_BASE(134, 134, 1, 0x0080, 0x10, 12, 1),
+	PIN_FIELD_BASE(135, 135, 1, 0x0080, 0x10, 13, 1),
+	PIN_FIELD_BASE(136, 136, 1, 0x0080, 0x10, 14, 1),
+	PIN_FIELD_BASE(137, 137, 1, 0x0080, 0x10, 15, 1),
+	PIN_FIELD_BASE(138, 138, 1, 0x0080, 0x10, 16, 1),
+	PIN_FIELD_BASE(139, 139, 1, 0x0080, 0x10, 17, 1),
+	PIN_FIELD_BASE(140, 140, 1, 0x0080, 0x10, 18, 1),
+	PIN_FIELD_BASE(141, 141, 1, 0x0080, 0x10, 5, 1),
+	PIN_FIELD_BASE(142, 142, 1, 0x0080, 0x10, 6, 1),
+	PIN_FIELD_BASE(143, 143, 1, 0x0080, 0x10, 7, 1),
+	PIN_FIELD_BASE(144, 144, 1, 0x0080, 0x10, 8, 1),
+	PIN_FIELD_BASE(145, 145, 1, 0x0080, 0x10, 9, 1),
+	PIN_FIELD_BASE(146, 146, 1, 0x0080, 0x10, 10, 1),
+	PIN_FIELD_BASE(147, 147, 1, 0x0080, 0x10, 20, 1),
+	PIN_FIELD_BASE(148, 148, 1, 0x0080, 0x10, 21, 1),
+	PIN_FIELD_BASE(149, 149, 1, 0x0080, 0x10, 19, 1),
+	PIN_FIELD_BASE(150, 150, 1, 0x0080, 0x10, 2, 1),
+	PIN_FIELD_BASE(151, 151, 2, 0x0070, 0x10, 21, 1),
+	PIN_FIELD_BASE(152, 152, 2, 0x0070, 0x10, 20, 1),
+	PIN_FIELD_BASE(153, 153, 2, 0x0070, 0x10, 19, 1),
+	PIN_FIELD_BASE(154, 154, 2, 0x0070, 0x10, 18, 1),
+	PIN_FIELD_BASE(155, 155, 2, 0x0070, 0x10, 23, 1),
+	PIN_FIELD_BASE(156, 156, 2, 0x0070, 0x10, 13, 1),
+	PIN_FIELD_BASE(157, 157, 2, 0x0070, 0x10, 12, 1),
+	PIN_FIELD_BASE(158, 158, 2, 0x0070, 0x10, 17, 1),
+	PIN_FIELD_BASE(159, 159, 2, 0x0070, 0x10, 16, 1),
+	PIN_FIELD_BASE(160, 160, 2, 0x0070, 0x10, 15, 1),
+	PIN_FIELD_BASE(161, 161, 2, 0x0070, 0x10, 14, 1),
+	PIN_FIELD_BASE(162, 162, 2, 0x0070, 0x10, 22, 1),
+	PIN_FIELD_BASE(163, 163, 4, 0x0050, 0x10, 8, 1),
+	PIN_FIELD_BASE(164, 164, 4, 0x0050, 0x10, 7, 1),
+	PIN_FIELD_BASE(165, 165, 4, 0x0050, 0x10, 9, 1),
+	PIN_FIELD_BASE(166, 166, 4, 0x0050, 0x10, 10, 1),
+	PIN_FIELD_BASE(167, 167, 4, 0x0050, 0x10, 11, 1),
+	PIN_FIELD_BASE(168, 168, 4, 0x0050, 0x10, 12, 1),
+	PIN_FIELD_BASE(169, 169, 3, 0x0040, 0x10, 9, 1),
+	PIN_FIELD_BASE(170, 170, 3, 0x0040, 0x10, 8, 1),
+	PIN_FIELD_BASE(171, 171, 3, 0x0040, 0x10, 10, 1),
+	PIN_FIELD_BASE(172, 172, 3, 0x0040, 0x10, 11, 1),
+	PIN_FIELD_BASE(173, 173, 3, 0x0040, 0x10, 12, 1),
+	PIN_FIELD_BASE(174, 174, 3, 0x0040, 0x10, 13, 1),
+	PIN_FIELD_BASE(175, 175, 2, 0x0080, 0x10, 27, 1),
+	PIN_FIELD_BASE(176, 176, 2, 0x0080, 0x10, 28, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_tdsel_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x01b0, 0x10, 0, 4),
+	PIN_FIELD_BASE(1, 1, 1, 0x01b0, 0x10, 4, 4),
+	PIN_FIELD_BASE(2, 2, 1, 0x01b0, 0x10, 8, 4),
+	PIN_FIELD_BASE(3, 3, 1, 0x01b0, 0x10, 12, 4),
+	PIN_FIELD_BASE(4, 4, 1, 0x01c0, 0x10, 16, 4),
+	PIN_FIELD_BASE(5, 5, 1, 0x01c0, 0x10, 20, 4),
+	PIN_FIELD_BASE(6, 6, 1, 0x01c0, 0x10, 20, 4),
+	PIN_FIELD_BASE(7, 7, 1, 0x01b0, 0x10, 16, 4),
+	PIN_FIELD_BASE(8, 8, 1, 0x01b0, 0x10, 20, 4),
+	PIN_FIELD_BASE(9, 9, 1, 0x01b0, 0x10, 24, 4),
+	PIN_FIELD_BASE(10, 10, 1, 0x01b0, 0x10, 28, 4),
+	PIN_FIELD_BASE(11, 11, 1, 0x01c0, 0x10, 20, 4),
+	PIN_FIELD_BASE(12, 12, 2, 0x0190, 0x10, 16, 4),
+	PIN_FIELD_BASE(13, 13, 2, 0x0190, 0x10, 20, 4),
+	PIN_FIELD_BASE(14, 14, 2, 0x0190, 0x10, 24, 4),
+	PIN_FIELD_BASE(15, 15, 2, 0x0190, 0x10, 28, 4),
+	PIN_FIELD_BASE(16, 16, 3, 0x0100, 0x10, 8, 4),
+	PIN_FIELD_BASE(17, 17, 3, 0x0100, 0x10, 8, 4),
+	PIN_FIELD_BASE(18, 18, 4, 0x0110, 0x10, 4, 4),
+	PIN_FIELD_BASE(19, 19, 4, 0x0110, 0x10, 8, 4),
+	PIN_FIELD_BASE(20, 20, 4, 0x0110, 0x10, 8, 4),
+	PIN_FIELD_BASE(21, 21, 4, 0x0110, 0x10, 8, 4),
+	PIN_FIELD_BASE(22, 22, 4, 0x0100, 0x10, 0, 4),
+	PIN_FIELD_BASE(23, 23, 4, 0x0100, 0x10, 4, 4),
+	PIN_FIELD_BASE(24, 24, 4, 0x0100, 0x10, 8, 4),
+	PIN_FIELD_BASE(25, 25, 1, 0x01c0, 0x10, 8, 4),
+	PIN_FIELD_BASE(26, 26, 1, 0x01c0, 0x10, 8, 4),
+	PIN_FIELD_BASE(27, 27, 1, 0x01c0, 0x10, 8, 4),
+	PIN_FIELD_BASE(28, 28, 1, 0x01c0, 0x10, 12, 4),
+	PIN_FIELD_BASE(29, 29, 1, 0x01c0, 0x10, 0, 4),
+	PIN_FIELD_BASE(30, 30, 1, 0x01c0, 0x10, 8, 4),
+	PIN_FIELD_BASE(31, 31, 1, 0x01c0, 0x10, 20, 4),
+	PIN_FIELD_BASE(32, 32, 1, 0x01c0, 0x10, 24, 4),
+	PIN_FIELD_BASE(33, 33, 1, 0x01c0, 0x10, 24, 4),
+	PIN_FIELD_BASE(34, 34, 1, 0x01c0, 0x10, 28, 4),
+	PIN_FIELD_BASE(35, 35, 1, 0x01c0, 0x10, 24, 4),
+	PIN_FIELD_BASE(36, 36, 1, 0x01c0, 0x10, 24, 4),
+	PIN_FIELD_BASE(37, 37, 1, 0x01c0, 0x10, 28, 4),
+	PIN_FIELD_BASE(38, 38, 1, 0x01c0, 0x10, 28, 4),
+	PIN_FIELD_BASE(39, 39, 1, 0x01c0, 0x10, 28, 4),
+	PIN_FIELD_BASE(40, 40, 1, 0x01d0, 0x10, 0, 4),
+	PIN_FIELD_BASE(41, 41, 1, 0x01d0, 0x10, 0, 4),
+	PIN_FIELD_BASE(42, 42, 2, 0x01a0, 0x10, 16, 4),
+	PIN_FIELD_BASE(43, 43, 2, 0x01a0, 0x10, 20, 4),
+	PIN_FIELD_BASE(44, 44, 2, 0x01a0, 0x10, 16, 4),
+	PIN_FIELD_BASE(45, 45, 2, 0x01a0, 0x10, 20, 4),
+	PIN_FIELD_BASE(46, 46, 3, 0x0100, 0x10, 8, 4),
+	PIN_FIELD_BASE(47, 47, 1, 0x01c0, 0x10, 0, 4),
+	PIN_FIELD_BASE(48, 48, 1, 0x01c0, 0x10, 0, 4),
+	PIN_FIELD_BASE(49, 49, 1, 0x01c0, 0x10, 0, 4),
+	PIN_FIELD_BASE(50, 50, 3, 0x0100, 0x10, 8, 4),
+	PIN_FIELD_BASE(51, 51, 3, 0x0100, 0x10, 12, 4),
+	PIN_FIELD_BASE(52, 52, 3, 0x0100, 0x10, 12, 4),
+	PIN_FIELD_BASE(53, 53, 3, 0x0100, 0x10, 12, 4),
+	PIN_FIELD_BASE(54, 54, 3, 0x0100, 0x10, 12, 4),
+	PIN_FIELD_BASE(55, 55, 1, 0x01c0, 0x10, 12, 4),
+	PIN_FIELD_BASE(56, 56, 1, 0x01c0, 0x10, 12, 4),
+	PIN_FIELD_BASE(57, 57, 2, 0x01a0, 0x10, 24, 4),
+	PIN_FIELD_BASE(58, 58, 2, 0x01a0, 0x10, 24, 4),
+	PIN_FIELD_BASE(59, 59, 1, 0x01c0, 0x10, 16, 4),
+	PIN_FIELD_BASE(60, 60, 1, 0x01c0, 0x10, 12, 4),
+	PIN_FIELD_BASE(61, 61, 1, 0x01c0, 0x10, 16, 4),
+	PIN_FIELD_BASE(62, 62, 1, 0x01c0, 0x10, 16, 4),
+	PIN_FIELD_BASE(63, 63, 2, 0x01a0, 0x10, 20, 4),
+	PIN_FIELD_BASE(64, 64, 2, 0x01a0, 0x10, 20, 4),
+	PIN_FIELD_BASE(65, 65, 4, 0x0110, 0x10, 12, 4),
+	PIN_FIELD_BASE(66, 66, 4, 0x0110, 0x10, 8, 4),
+	PIN_FIELD_BASE(67, 67, 4, 0x0110, 0x10, 12, 4),
+	PIN_FIELD_BASE(68, 68, 4, 0x0110, 0x10, 12, 4),
+	PIN_FIELD_BASE(69, 69, 1, 0x01d0, 0x10, 16, 4),
+	PIN_FIELD_BASE(70, 70, 1, 0x01d0, 0x10, 12, 4),
+	PIN_FIELD_BASE(71, 71, 1, 0x01e0, 0x10, 0, 4),
+	PIN_FIELD_BASE(72, 72, 1, 0x01d0, 0x10, 28, 4),
+	PIN_FIELD_BASE(73, 73, 1, 0x01d0, 0x10, 20, 4),
+	PIN_FIELD_BASE(74, 74, 1, 0x01d0, 0x10, 24, 4),
+	PIN_FIELD_BASE(75, 75, 1, 0x01e0, 0x10, 8, 4),
+	PIN_FIELD_BASE(76, 76, 1, 0x01e0, 0x10, 4, 4),
+	PIN_FIELD_BASE(77, 77, 1, 0x01e0, 0x10, 16, 4),
+	PIN_FIELD_BASE(78, 78, 1, 0x01e0, 0x10, 12, 4),
+	PIN_FIELD_BASE(79, 79, 4, 0x0110, 0x10, 20, 4),
+	PIN_FIELD_BASE(80, 80, 4, 0x0110, 0x10, 16, 4),
+	PIN_FIELD_BASE(81, 81, 4, 0x0110, 0x10, 28, 4),
+	PIN_FIELD_BASE(82, 82, 4, 0x0110, 0x10, 24, 4),
+	PIN_FIELD_BASE(83, 83, 2, 0x01b0, 0x10, 8, 4),
+	PIN_FIELD_BASE(84, 84, 2, 0x01b0, 0x10, 8, 4),
+	PIN_FIELD_BASE(85, 85, 2, 0x01b0, 0x10, 12, 4),
+	PIN_FIELD_BASE(86, 86, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(87, 87, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(88, 88, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(89, 89, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(90, 90, 2, 0x01b0, 0x10, 12, 4),
+	PIN_FIELD_BASE(91, 91, 2, 0x01b0, 0x10, 12, 4),
+	PIN_FIELD_BASE(92, 92, 2, 0x01a0, 0x10, 4, 4),
+	PIN_FIELD_BASE(93, 93, 2, 0x01a0, 0x10, 4, 4),
+	PIN_FIELD_BASE(94, 94, 2, 0x01a0, 0x10, 4, 4),
+	PIN_FIELD_BASE(95, 95, 2, 0x01a0, 0x10, 4, 4),
+	PIN_FIELD_BASE(96, 96, 2, 0x01a0, 0x10, 24, 4),
+	PIN_FIELD_BASE(97, 97, 2, 0x01a0, 0x10, 28, 4),
+	PIN_FIELD_BASE(98, 98, 2, 0x01b0, 0x10, 0, 4),
+	PIN_FIELD_BASE(99, 99, 2, 0x01a0, 0x10, 24, 4),
+	PIN_FIELD_BASE(100, 100, 2, 0x01b0, 0x10, 20, 4),
+	PIN_FIELD_BASE(101, 101, 2, 0x01a0, 0x10, 28, 4),
+	PIN_FIELD_BASE(102, 102, 2, 0x01a0, 0x10, 28, 4),
+	PIN_FIELD_BASE(103, 103, 2, 0x01a0, 0x10, 28, 4),
+	PIN_FIELD_BASE(104, 104, 2, 0x01b0, 0x10, 0, 4),
+	PIN_FIELD_BASE(105, 105, 2, 0x01b0, 0x10, 0, 4),
+	PIN_FIELD_BASE(106, 106, 2, 0x01b0, 0x10, 0, 4),
+	PIN_FIELD_BASE(107, 107, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(108, 108, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(109, 109, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(110, 110, 2, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(111, 111, 2, 0x01a0, 0x10, 8, 4),
+	PIN_FIELD_BASE(112, 112, 2, 0x01a0, 0x10, 8, 4),
+	PIN_FIELD_BASE(113, 113, 2, 0x01a0, 0x10, 8, 4),
+	PIN_FIELD_BASE(114, 114, 2, 0x01a0, 0x10, 8, 4),
+	PIN_FIELD_BASE(115, 115, 2, 0x01a0, 0x10, 12, 4),
+	PIN_FIELD_BASE(116, 116, 2, 0x01a0, 0x10, 12, 4),
+	PIN_FIELD_BASE(117, 117, 2, 0x01a0, 0x10, 12, 4),
+	PIN_FIELD_BASE(118, 118, 2, 0x01a0, 0x10, 12, 4),
+	PIN_FIELD_BASE(119, 119, 2, 0x01a0, 0x10, 16, 4),
+	PIN_FIELD_BASE(120, 120, 2, 0x01a0, 0x10, 16, 4),
+	PIN_FIELD_BASE(121, 121, 3, 0x00f0, 0x10, 24, 4),
+	PIN_FIELD_BASE(122, 122, 3, 0x0100, 0x10, 4, 4),
+	PIN_FIELD_BASE(123, 123, 3, 0x0100, 0x10, 0, 4),
+	PIN_FIELD_BASE(124, 124, 3, 0x00f0, 0x10, 28, 4),
+	PIN_FIELD_BASE(125, 125, 2, 0x01b0, 0x10, 4, 4),
+	PIN_FIELD_BASE(126, 126, 2, 0x01b0, 0x10, 4, 4),
+	PIN_FIELD_BASE(127, 127, 2, 0x01b0, 0x10, 4, 4),
+	PIN_FIELD_BASE(128, 128, 2, 0x01b0, 0x10, 4, 4),
+	PIN_FIELD_BASE(129, 129, 2, 0x01b0, 0x10, 8, 4),
+	PIN_FIELD_BASE(130, 130, 2, 0x01b0, 0x10, 8, 4),
+	PIN_FIELD_BASE(131, 131, 1, 0x01a0, 0x10, 0, 4),
+	PIN_FIELD_BASE(132, 132, 1, 0x01a0, 0x10, 20, 4),
+	PIN_FIELD_BASE(133, 133, 1, 0x01a0, 0x10, 24, 4),
+	PIN_FIELD_BASE(134, 134, 1, 0x01a0, 0x10, 28, 4),
+	PIN_FIELD_BASE(135, 135, 1, 0x01d0, 0x10, 0, 4),
+	PIN_FIELD_BASE(136, 136, 1, 0x01d0, 0x10, 0, 4),
+	PIN_FIELD_BASE(137, 137, 1, 0x01d0, 0x10, 4, 4),
+	PIN_FIELD_BASE(138, 138, 1, 0x01d0, 0x10, 4, 4),
+	PIN_FIELD_BASE(139, 139, 1, 0x01d0, 0x10, 4, 4),
+	PIN_FIELD_BASE(140, 140, 1, 0x01d0, 0x10, 4, 4),
+	PIN_FIELD_BASE(141, 141, 1, 0x01d0, 0x10, 8, 4),
+	PIN_FIELD_BASE(142, 142, 1, 0x01d0, 0x10, 8, 4),
+	PIN_FIELD_BASE(143, 143, 1, 0x01a0, 0x10, 4, 4),
+	PIN_FIELD_BASE(144, 144, 1, 0x01a0, 0x10, 8, 4),
+	PIN_FIELD_BASE(145, 145, 1, 0x01a0, 0x10, 12, 4),
+	PIN_FIELD_BASE(146, 146, 1, 0x01a0, 0x10, 16, 4),
+	PIN_FIELD_BASE(147, 147, 1, 0x01d0, 0x10, 8, 4),
+	PIN_FIELD_BASE(148, 148, 1, 0x01d0, 0x10, 8, 4),
+	PIN_FIELD_BASE(149, 149, 1, 0x01c0, 0x10, 4, 4),
+	PIN_FIELD_BASE(150, 150, 1, 0x01c0, 0x10, 4, 4),
+	PIN_FIELD_BASE(151, 151, 2, 0x0190, 0x10, 4, 4),
+	PIN_FIELD_BASE(152, 152, 2, 0x0190, 0x10, 0, 4),
+	PIN_FIELD_BASE(153, 153, 2, 0x0180, 0x10, 28, 4),
+	PIN_FIELD_BASE(154, 154, 2, 0x0180, 0x10, 24, 4),
+	PIN_FIELD_BASE(155, 155, 2, 0x0190, 0x10, 12, 4),
+	PIN_FIELD_BASE(156, 156, 2, 0x0180, 0x10, 4, 4),
+	PIN_FIELD_BASE(157, 157, 2, 0x0180, 0x10, 0, 4),
+	PIN_FIELD_BASE(158, 158, 2, 0x0180, 0x10, 20, 4),
+	PIN_FIELD_BASE(159, 159, 2, 0x0180, 0x10, 16, 4),
+	PIN_FIELD_BASE(160, 160, 2, 0x0180, 0x10, 12, 4),
+	PIN_FIELD_BASE(161, 161, 2, 0x0180, 0x10, 8, 4),
+	PIN_FIELD_BASE(162, 162, 2, 0x0190, 0x10, 8, 4),
+	PIN_FIELD_BASE(163, 163, 4, 0x0100, 0x10, 16, 4),
+	PIN_FIELD_BASE(164, 164, 4, 0x0100, 0x10, 12, 4),
+	PIN_FIELD_BASE(165, 165, 4, 0x0100, 0x10, 20, 4),
+	PIN_FIELD_BASE(166, 166, 4, 0x0100, 0x10, 24, 4),
+	PIN_FIELD_BASE(167, 167, 4, 0x0100, 0x10, 28, 4),
+	PIN_FIELD_BASE(168, 168, 4, 0x0110, 0x10, 0, 4),
+	PIN_FIELD_BASE(169, 169, 3, 0x00f0, 0x10, 4, 4),
+	PIN_FIELD_BASE(170, 170, 3, 0x00f0, 0x10, 0, 4),
+	PIN_FIELD_BASE(171, 171, 3, 0x00f0, 0x10, 8, 4),
+	PIN_FIELD_BASE(172, 172, 3, 0x00f0, 0x10, 12, 4),
+	PIN_FIELD_BASE(173, 173, 3, 0x00f0, 0x10, 16, 4),
+	PIN_FIELD_BASE(174, 174, 3, 0x00f0, 0x10, 20, 4),
+	PIN_FIELD_BASE(175, 175, 2, 0x01b0, 0x10, 16, 4),
+	PIN_FIELD_BASE(176, 176, 2, 0x01b0, 0x10, 16, 4),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_rdsel_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x0130, 0x10, 18, 2),
+	PIN_FIELD_BASE(1, 1, 1, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(2, 2, 1, 0x0130, 0x10, 22, 2),
+	PIN_FIELD_BASE(3, 3, 1, 0x0130, 0x10, 24, 2),
+	PIN_FIELD_BASE(4, 4, 1, 0x0140, 0x10, 14, 2),
+	PIN_FIELD_BASE(5, 5, 1, 0x0140, 0x10, 16, 2),
+	PIN_FIELD_BASE(6, 6, 1, 0x0140, 0x10, 16, 2),
+	PIN_FIELD_BASE(7, 7, 1, 0x0130, 0x10, 26, 2),
+	PIN_FIELD_BASE(8, 8, 1, 0x0130, 0x10, 28, 2),
+	PIN_FIELD_BASE(9, 9, 1, 0x0130, 0x10, 30, 2),
+	PIN_FIELD_BASE(10, 10, 1, 0x0140, 0x10, 0, 2),
+	PIN_FIELD_BASE(11, 11, 1, 0x0140, 0x10, 16, 2),
+	PIN_FIELD_BASE(12, 12, 2, 0x0130, 0x10, 12, 2),
+	PIN_FIELD_BASE(13, 13, 2, 0x0130, 0x10, 14, 2),
+	PIN_FIELD_BASE(14, 14, 2, 0x0130, 0x10, 16, 2),
+	PIN_FIELD_BASE(15, 15, 2, 0x0130, 0x10, 18, 2),
+	PIN_FIELD_BASE(16, 16, 3, 0x00b0, 0x10, 14, 2),
+	PIN_FIELD_BASE(17, 17, 3, 0x00b0, 0x10, 14, 2),
+	PIN_FIELD_BASE(18, 18, 4, 0x00c0, 0x10, 12, 2),
+	PIN_FIELD_BASE(19, 19, 4, 0x00c0, 0x10, 12, 2),
+	PIN_FIELD_BASE(20, 20, 4, 0x00c0, 0x10, 12, 2),
+	PIN_FIELD_BASE(21, 21, 4, 0x00c0, 0x10, 12, 2),
+	PIN_FIELD_BASE(22, 22, 4, 0x00b0, 0x10, 0, 2),
+	PIN_FIELD_BASE(23, 23, 4, 0x00b0, 0x10, 2, 2),
+	PIN_FIELD_BASE(24, 24, 4, 0x00b0, 0x10, 4, 2),
+	PIN_FIELD_BASE(25, 25, 1, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(26, 26, 1, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(27, 27, 1, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(28, 28, 1, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(29, 29, 1, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(30, 30, 1, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(31, 31, 1, 0x0140, 0x10, 16, 2),
+	PIN_FIELD_BASE(32, 32, 1, 0x0140, 0x10, 18, 2),
+	PIN_FIELD_BASE(33, 33, 1, 0x0140, 0x10, 18, 2),
+	PIN_FIELD_BASE(34, 34, 1, 0x0140, 0x10, 20, 2),
+	PIN_FIELD_BASE(35, 35, 1, 0x0140, 0x10, 18, 2),
+	PIN_FIELD_BASE(36, 36, 1, 0x0140, 0x10, 18, 2),
+	PIN_FIELD_BASE(37, 37, 1, 0x0140, 0x10, 20, 2),
+	PIN_FIELD_BASE(38, 38, 1, 0x0140, 0x10, 20, 2),
+	PIN_FIELD_BASE(39, 39, 1, 0x0140, 0x10, 20, 2),
+	PIN_FIELD_BASE(40, 40, 1, 0x0140, 0x10, 22, 2),
+	PIN_FIELD_BASE(41, 41, 1, 0x0140, 0x10, 22, 2),
+	PIN_FIELD_BASE(42, 42, 2, 0x0130, 0x10, 30, 2),
+	PIN_FIELD_BASE(43, 43, 2, 0x0140, 0x10, 0, 2),
+	PIN_FIELD_BASE(44, 44, 2, 0x0130, 0x10, 30, 2),
+	PIN_FIELD_BASE(45, 45, 2, 0x0140, 0x10, 0, 2),
+	PIN_FIELD_BASE(46, 46, 3, 0x00b0, 0x10, 14, 2),
+	PIN_FIELD_BASE(47, 47, 1, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(48, 48, 1, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(49, 49, 1, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(50, 50, 3, 0x00b0, 0x10, 14, 2),
+	PIN_FIELD_BASE(51, 51, 3, 0x00b0, 0x10, 16, 2),
+	PIN_FIELD_BASE(52, 52, 3, 0x00b0, 0x10, 16, 2),
+	PIN_FIELD_BASE(53, 53, 3, 0x00b0, 0x10, 16, 2),
+	PIN_FIELD_BASE(54, 54, 3, 0x00b0, 0x10, 16, 2),
+	PIN_FIELD_BASE(55, 55, 1, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(56, 56, 1, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(57, 57, 2, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(58, 58, 2, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(59, 59, 1, 0x0140, 0x10, 14, 2),
+	PIN_FIELD_BASE(60, 60, 1, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(61, 61, 1, 0x0140, 0x10, 14, 2),
+	PIN_FIELD_BASE(62, 62, 1, 0x0140, 0x10, 14, 2),
+	PIN_FIELD_BASE(63, 63, 2, 0x0140, 0x10, 0, 2),
+	PIN_FIELD_BASE(64, 64, 2, 0x0140, 0x10, 0, 2),
+	PIN_FIELD_BASE(65, 65, 4, 0x00c0, 0x10, 14, 2),
+	PIN_FIELD_BASE(66, 66, 4, 0x00c0, 0x10, 14, 2),
+	PIN_FIELD_BASE(67, 67, 4, 0x00c0, 0x10, 14, 2),
+	PIN_FIELD_BASE(68, 68, 4, 0x00c0, 0x10, 14, 2),
+	PIN_FIELD_BASE(69, 69, 1, 0x0150, 0x10, 14, 2),
+	PIN_FIELD_BASE(70, 70, 1, 0x0150, 0x10, 12, 2),
+	PIN_FIELD_BASE(71, 71, 1, 0x0150, 0x10, 22, 2),
+	PIN_FIELD_BASE(72, 72, 1, 0x0150, 0x10, 20, 2),
+	PIN_FIELD_BASE(73, 73, 1, 0x0150, 0x10, 16, 2),
+	PIN_FIELD_BASE(74, 74, 1, 0x0150, 0x10, 18, 2),
+	PIN_FIELD_BASE(75, 75, 1, 0x0150, 0x10, 26, 2),
+	PIN_FIELD_BASE(76, 76, 1, 0x0150, 0x10, 24, 2),
+	PIN_FIELD_BASE(77, 77, 1, 0x0150, 0x10, 30, 2),
+	PIN_FIELD_BASE(78, 78, 1, 0x0150, 0x10, 28, 2),
+	PIN_FIELD_BASE(79, 79, 4, 0x00c0, 0x10, 18, 2),
+	PIN_FIELD_BASE(80, 80, 4, 0x00c0, 0x10, 16, 2),
+	PIN_FIELD_BASE(81, 81, 4, 0x00c0, 0x10, 22, 2),
+	PIN_FIELD_BASE(82, 82, 4, 0x00c0, 0x10, 20, 2),
+	PIN_FIELD_BASE(83, 83, 2, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(84, 84, 2, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(85, 85, 2, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(86, 86, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(87, 87, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(88, 88, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(89, 89, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(90, 90, 2, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(91, 91, 2, 0x0140, 0x10, 12, 2),
+	PIN_FIELD_BASE(92, 92, 2, 0x0130, 0x10, 22, 2),
+	PIN_FIELD_BASE(93, 93, 2, 0x0130, 0x10, 22, 2),
+	PIN_FIELD_BASE(94, 94, 2, 0x0130, 0x10, 22, 2),
+	PIN_FIELD_BASE(95, 95, 2, 0x0130, 0x10, 22, 2),
+	PIN_FIELD_BASE(96, 96, 2, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(97, 97, 2, 0x0140, 0x10, 4, 2),
+	PIN_FIELD_BASE(98, 98, 2, 0x0140, 0x10, 6, 2),
+	PIN_FIELD_BASE(99, 99, 2, 0x0140, 0x10, 2, 2),
+	PIN_FIELD_BASE(100, 100, 2, 0x0140, 0x10, 16, 2),
+	PIN_FIELD_BASE(101, 101, 2, 0x0140, 0x10, 4, 2),
+	PIN_FIELD_BASE(102, 102, 2, 0x0140, 0x10, 4, 2),
+	PIN_FIELD_BASE(103, 103, 2, 0x0140, 0x10, 4, 2),
+	PIN_FIELD_BASE(104, 104, 2, 0x0140, 0x10, 6, 2),
+	PIN_FIELD_BASE(105, 105, 2, 0x0140, 0x10, 6, 2),
+	PIN_FIELD_BASE(106, 106, 2, 0x0140, 0x10, 6, 2),
+	PIN_FIELD_BASE(107, 107, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(108, 108, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(109, 109, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(110, 110, 2, 0x0130, 0x10, 20, 2),
+	PIN_FIELD_BASE(111, 111, 2, 0x0130, 0x10, 24, 2),
+	PIN_FIELD_BASE(112, 112, 2, 0x0130, 0x10, 24, 2),
+	PIN_FIELD_BASE(113, 113, 2, 0x0130, 0x10, 24, 2),
+	PIN_FIELD_BASE(114, 114, 2, 0x0130, 0x10, 24, 2),
+	PIN_FIELD_BASE(115, 115, 2, 0x0130, 0x10, 28, 2),
+	PIN_FIELD_BASE(116, 116, 2, 0x0130, 0x10, 28, 2),
+	PIN_FIELD_BASE(117, 117, 2, 0x0130, 0x10, 28, 2),
+	PIN_FIELD_BASE(118, 118, 2, 0x0130, 0x10, 28, 2),
+	PIN_FIELD_BASE(119, 119, 2, 0x0130, 0x10, 30, 2),
+	PIN_FIELD_BASE(120, 120, 2, 0x0130, 0x10, 30, 2),
+	PIN_FIELD_BASE(121, 121, 3, 0x00b0, 0x10, 6, 2),
+	PIN_FIELD_BASE(122, 122, 3, 0x00b0, 0x10, 12, 2),
+	PIN_FIELD_BASE(123, 123, 3, 0x00b0, 0x10, 10, 2),
+	PIN_FIELD_BASE(124, 124, 3, 0x00b0, 0x10, 8, 2),
+	PIN_FIELD_BASE(125, 125, 2, 0x0140, 0x10, 8, 2),
+	PIN_FIELD_BASE(126, 126, 2, 0x0140, 0x10, 8, 2),
+	PIN_FIELD_BASE(127, 127, 2, 0x0140, 0x10, 8, 2),
+	PIN_FIELD_BASE(128, 128, 2, 0x0140, 0x10, 8, 2),
+	PIN_FIELD_BASE(129, 129, 2, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(130, 130, 2, 0x0140, 0x10, 10, 2),
+	PIN_FIELD_BASE(131, 131, 1, 0x0120, 0x10, 0, 6),
+	PIN_FIELD_BASE(132, 132, 1, 0x0130, 0x10, 0, 6),
+	PIN_FIELD_BASE(133, 133, 1, 0x0130, 0x10, 6, 6),
+	PIN_FIELD_BASE(134, 134, 1, 0x0130, 0x10, 12, 6),
+	PIN_FIELD_BASE(135, 135, 1, 0x0140, 0x10, 24, 6),
+	PIN_FIELD_BASE(136, 136, 1, 0x0140, 0x10, 24, 6),
+	PIN_FIELD_BASE(137, 137, 1, 0x0150, 0x10, 0, 6),
+	PIN_FIELD_BASE(138, 138, 1, 0x0150, 0x10, 0, 6),
+	PIN_FIELD_BASE(139, 139, 1, 0x0150, 0x10, 0, 6),
+	PIN_FIELD_BASE(140, 140, 1, 0x0150, 0x10, 0, 6),
+	PIN_FIELD_BASE(141, 141, 1, 0x0150, 0x10, 6, 6),
+	PIN_FIELD_BASE(142, 142, 1, 0x0150, 0x10, 6, 6),
+	PIN_FIELD_BASE(143, 143, 1, 0x0120, 0x10, 6, 6),
+	PIN_FIELD_BASE(144, 144, 1, 0x0120, 0x10, 12, 6),
+	PIN_FIELD_BASE(145, 145, 1, 0x0120, 0x10, 18, 6),
+	PIN_FIELD_BASE(146, 146, 1, 0x0120, 0x10, 24, 6),
+	PIN_FIELD_BASE(147, 147, 1, 0x0150, 0x10, 6, 6),
+	PIN_FIELD_BASE(148, 148, 1, 0x0150, 0x10, 6, 6),
+	PIN_FIELD_BASE(149, 149, 1, 0x0140, 0x10, 4, 6),
+	PIN_FIELD_BASE(150, 150, 1, 0x0140, 0x10, 4, 6),
+	PIN_FIELD_BASE(151, 151, 2, 0x0120, 0x10, 24, 6),
+	PIN_FIELD_BASE(152, 152, 2, 0x0120, 0x10, 18, 6),
+	PIN_FIELD_BASE(153, 153, 2, 0x0120, 0x10, 12, 6),
+	PIN_FIELD_BASE(154, 154, 2, 0x0120, 0x10, 6, 6),
+	PIN_FIELD_BASE(155, 155, 2, 0x0130, 0x10, 6, 6),
+	PIN_FIELD_BASE(156, 156, 2, 0x0110, 0x10, 6, 6),
+	PIN_FIELD_BASE(157, 157, 2, 0x0110, 0x10, 0, 6),
+	PIN_FIELD_BASE(158, 158, 2, 0x0120, 0x10, 0, 6),
+	PIN_FIELD_BASE(159, 159, 2, 0x0110, 0x10, 24, 6),
+	PIN_FIELD_BASE(160, 160, 2, 0x0110, 0x10, 18, 6),
+	PIN_FIELD_BASE(161, 161, 2, 0x0110, 0x10, 12, 6),
+	PIN_FIELD_BASE(162, 162, 2, 0x0130, 0x10, 0, 6),
+	PIN_FIELD_BASE(163, 163, 4, 0x00b0, 0x10, 12, 6),
+	PIN_FIELD_BASE(164, 164, 4, 0x00b0, 0x10, 6, 6),
+	PIN_FIELD_BASE(165, 165, 4, 0x00b0, 0x10, 18, 6),
+	PIN_FIELD_BASE(166, 166, 4, 0x00b0, 0x10, 24, 6),
+	PIN_FIELD_BASE(167, 167, 4, 0x00c0, 0x10, 0, 6),
+	PIN_FIELD_BASE(168, 168, 4, 0x00c0, 0x10, 6, 6),
+	PIN_FIELD_BASE(169, 169, 3, 0x00a0, 0x10, 6, 6),
+	PIN_FIELD_BASE(170, 170, 3, 0x00a0, 0x10, 0, 6),
+	PIN_FIELD_BASE(171, 171, 3, 0x00a0, 0x10, 12, 6),
+	PIN_FIELD_BASE(172, 172, 3, 0x00a0, 0x10, 18, 6),
+	PIN_FIELD_BASE(173, 173, 3, 0x00a0, 0x10, 24, 6),
+	PIN_FIELD_BASE(174, 174, 3, 0x00b0, 0x10, 0, 6),
+	PIN_FIELD_BASE(175, 175, 2, 0x0140, 0x10, 14, 2),
+	PIN_FIELD_BASE(176, 176, 2, 0x0140, 0x10, 14, 2),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_pupd_range[] = {
+	PIN_FIELD_BASE(42, 42, 2, 0x00c0, 0x10, 12, 1),
+	PIN_FIELD_BASE(43, 43, 2, 0x00c0, 0x10, 13, 1),
+	PIN_FIELD_BASE(44, 44, 2, 0x00c0, 0x10, 14, 1),
+	PIN_FIELD_BASE(45, 45, 2, 0x00c0, 0x10, 15, 1),
+	PIN_FIELD_BASE(131, 131, 1, 0x00d0, 0x10, 1, 1),
+	PIN_FIELD_BASE(132, 132, 1, 0x00d0, 0x10, 2, 1),
+	PIN_FIELD_BASE(133, 133, 1, 0x00d0, 0x10, 9, 1),
+	PIN_FIELD_BASE(134, 134, 1, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(135, 135, 1, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(136, 136, 1, 0x00d0, 0x10, 12, 1),
+	PIN_FIELD_BASE(137, 137, 1, 0x00d0, 0x10, 13, 1),
+	PIN_FIELD_BASE(138, 138, 1, 0x00d0, 0x10, 14, 1),
+	PIN_FIELD_BASE(139, 139, 1, 0x00d0, 0x10, 15, 1),
+	PIN_FIELD_BASE(140, 140, 1, 0x00d0, 0x10, 16, 1),
+	PIN_FIELD_BASE(141, 141, 1, 0x00d0, 0x10, 3, 1),
+	PIN_FIELD_BASE(142, 142, 1, 0x00d0, 0x10, 4, 1),
+	PIN_FIELD_BASE(143, 143, 1, 0x00d0, 0x10, 5, 1),
+	PIN_FIELD_BASE(144, 144, 1, 0x00d0, 0x10, 6, 1),
+	PIN_FIELD_BASE(145, 145, 1, 0x00d0, 0x10, 7, 1),
+	PIN_FIELD_BASE(146, 146, 1, 0x00d0, 0x10, 8, 1),
+	PIN_FIELD_BASE(147, 147, 1, 0x00d0, 0x10, 18, 1),
+	PIN_FIELD_BASE(148, 148, 1, 0x00d0, 0x10, 19, 1),
+	PIN_FIELD_BASE(149, 149, 1, 0x00d0, 0x10, 17, 1),
+	PIN_FIELD_BASE(150, 150, 1, 0x00d0, 0x10, 0, 1),
+	PIN_FIELD_BASE(151, 151, 2, 0x00c0, 0x10, 9, 1),
+	PIN_FIELD_BASE(152, 152, 2, 0x00c0, 0x10, 8, 1),
+	PIN_FIELD_BASE(153, 153, 2, 0x00c0, 0x10, 7, 1),
+	PIN_FIELD_BASE(154, 154, 2, 0x00c0, 0x10, 6, 1),
+	PIN_FIELD_BASE(155, 155, 2, 0x00c0, 0x10, 11, 1),
+	PIN_FIELD_BASE(156, 156, 2, 0x00c0, 0x10, 1, 1),
+	PIN_FIELD_BASE(157, 157, 2, 0x00c0, 0x10, 0, 1),
+	PIN_FIELD_BASE(158, 158, 2, 0x00c0, 0x10, 5, 1),
+	PIN_FIELD_BASE(159, 159, 2, 0x00c0, 0x10, 4, 1),
+	PIN_FIELD_BASE(160, 160, 2, 0x00c0, 0x10, 3, 1),
+	PIN_FIELD_BASE(161, 161, 2, 0x00c0, 0x10, 2, 1),
+	PIN_FIELD_BASE(162, 162, 2, 0x00c0, 0x10, 10, 1),
+	PIN_FIELD_BASE(163, 163, 4, 0x0070, 0x10, 1, 1),
+	PIN_FIELD_BASE(164, 164, 4, 0x0070, 0x10, 0, 1),
+	PIN_FIELD_BASE(165, 165, 4, 0x0070, 0x10, 2, 1),
+	PIN_FIELD_BASE(166, 166, 4, 0x0070, 0x10, 3, 1),
+	PIN_FIELD_BASE(167, 167, 4, 0x0070, 0x10, 4, 1),
+	PIN_FIELD_BASE(168, 168, 4, 0x0070, 0x10, 5, 1),
+	PIN_FIELD_BASE(169, 169, 3, 0x0060, 0x10, 1, 1),
+	PIN_FIELD_BASE(170, 170, 3, 0x0060, 0x10, 0, 1),
+	PIN_FIELD_BASE(171, 171, 3, 0x0060, 0x10, 2, 1),
+	PIN_FIELD_BASE(172, 172, 3, 0x0060, 0x10, 3, 1),
+	PIN_FIELD_BASE(173, 173, 3, 0x0060, 0x10, 4, 1),
+	PIN_FIELD_BASE(174, 174, 3, 0x0060, 0x10, 5, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_r0_range[] = {
+	PIN_FIELD_BASE(42, 42, 2, 0x00f0, 0x10, 12, 1),
+	PIN_FIELD_BASE(43, 43, 2, 0x00f0, 0x10, 13, 1),
+	PIN_FIELD_BASE(44, 44, 2, 0x00f0, 0x10, 14, 1),
+	PIN_FIELD_BASE(45, 45, 2, 0x00f0, 0x10, 15, 1),
+	PIN_FIELD_BASE(131, 131, 1, 0x0100, 0x10, 1, 1),
+	PIN_FIELD_BASE(132, 132, 1, 0x0100, 0x10, 2, 1),
+	PIN_FIELD_BASE(133, 133, 1, 0x0100, 0x10, 9, 1),
+	PIN_FIELD_BASE(134, 134, 1, 0x0100, 0x10, 10, 1),
+	PIN_FIELD_BASE(135, 135, 1, 0x0100, 0x10, 11, 1),
+	PIN_FIELD_BASE(136, 136, 1, 0x0100, 0x10, 12, 1),
+	PIN_FIELD_BASE(137, 137, 1, 0x0100, 0x10, 13, 1),
+	PIN_FIELD_BASE(138, 138, 1, 0x0100, 0x10, 14, 1),
+	PIN_FIELD_BASE(139, 139, 1, 0x0100, 0x10, 15, 1),
+	PIN_FIELD_BASE(140, 140, 1, 0x0100, 0x10, 16, 1),
+	PIN_FIELD_BASE(141, 141, 1, 0x0100, 0x10, 3, 1),
+	PIN_FIELD_BASE(142, 142, 1, 0x0100, 0x10, 4, 1),
+	PIN_FIELD_BASE(143, 143, 1, 0x0100, 0x10, 5, 1),
+	PIN_FIELD_BASE(144, 144, 1, 0x0100, 0x10, 6, 1),
+	PIN_FIELD_BASE(145, 145, 1, 0x0100, 0x10, 7, 1),
+	PIN_FIELD_BASE(146, 146, 1, 0x0100, 0x10, 8, 1),
+	PIN_FIELD_BASE(147, 147, 1, 0x0100, 0x10, 18, 1),
+	PIN_FIELD_BASE(148, 148, 1, 0x0100, 0x10, 19, 1),
+	PIN_FIELD_BASE(149, 149, 1, 0x0100, 0x10, 17, 1),
+	PIN_FIELD_BASE(150, 150, 1, 0x0100, 0x10, 0, 1),
+	PIN_FIELD_BASE(151, 151, 2, 0x00f0, 0x10, 9, 1),
+	PIN_FIELD_BASE(152, 152, 2, 0x00f0, 0x10, 8, 1),
+	PIN_FIELD_BASE(153, 153, 2, 0x00f0, 0x10, 7, 1),
+	PIN_FIELD_BASE(154, 154, 2, 0x00f0, 0x10, 6, 1),
+	PIN_FIELD_BASE(155, 155, 2, 0x00f0, 0x10, 11, 1),
+	PIN_FIELD_BASE(156, 156, 2, 0x00f0, 0x10, 1, 1),
+	PIN_FIELD_BASE(157, 157, 2, 0x00f0, 0x10, 0, 1),
+	PIN_FIELD_BASE(158, 158, 2, 0x00f0, 0x10, 5, 1),
+	PIN_FIELD_BASE(159, 159, 2, 0x00f0, 0x10, 4, 1),
+	PIN_FIELD_BASE(160, 160, 2, 0x00f0, 0x10, 3, 1),
+	PIN_FIELD_BASE(161, 161, 2, 0x00f0, 0x10, 2, 1),
+	PIN_FIELD_BASE(162, 162, 2, 0x00f0, 0x10, 10, 1),
+	PIN_FIELD_BASE(163, 163, 4, 0x0090, 0x10, 1, 1),
+	PIN_FIELD_BASE(164, 164, 4, 0x0090, 0x10, 0, 1),
+	PIN_FIELD_BASE(165, 165, 4, 0x0090, 0x10, 2, 1),
+	PIN_FIELD_BASE(166, 166, 4, 0x0090, 0x10, 3, 1),
+	PIN_FIELD_BASE(167, 167, 4, 0x0090, 0x10, 4, 1),
+	PIN_FIELD_BASE(168, 168, 4, 0x0090, 0x10, 5, 1),
+	PIN_FIELD_BASE(169, 169, 3, 0x0080, 0x10, 1, 1),
+	PIN_FIELD_BASE(170, 170, 3, 0x0080, 0x10, 0, 1),
+	PIN_FIELD_BASE(171, 171, 3, 0x0080, 0x10, 2, 1),
+	PIN_FIELD_BASE(172, 172, 3, 0x0080, 0x10, 3, 1),
+	PIN_FIELD_BASE(173, 173, 3, 0x0080, 0x10, 4, 1),
+	PIN_FIELD_BASE(174, 174, 3, 0x0080, 0x10, 5, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_r1_range[] = {
+	PIN_FIELD_BASE(42, 42, 2, 0x0100, 0x10, 12, 1),
+	PIN_FIELD_BASE(43, 43, 2, 0x0100, 0x10, 13, 1),
+	PIN_FIELD_BASE(44, 44, 2, 0x0100, 0x10, 14, 1),
+	PIN_FIELD_BASE(45, 45, 2, 0x0100, 0x10, 15, 1),
+	PIN_FIELD_BASE(131, 131, 1, 0x0110, 0x10, 1, 1),
+	PIN_FIELD_BASE(132, 132, 1, 0x0110, 0x10, 2, 1),
+	PIN_FIELD_BASE(133, 133, 1, 0x0110, 0x10, 9, 1),
+	PIN_FIELD_BASE(134, 134, 1, 0x0110, 0x10, 10, 1),
+	PIN_FIELD_BASE(135, 135, 1, 0x0110, 0x10, 11, 1),
+	PIN_FIELD_BASE(136, 136, 1, 0x0110, 0x10, 12, 1),
+	PIN_FIELD_BASE(137, 137, 1, 0x0110, 0x10, 13, 1),
+	PIN_FIELD_BASE(138, 138, 1, 0x0110, 0x10, 14, 1),
+	PIN_FIELD_BASE(139, 139, 1, 0x0110, 0x10, 15, 1),
+	PIN_FIELD_BASE(140, 140, 1, 0x0110, 0x10, 16, 1),
+	PIN_FIELD_BASE(141, 141, 1, 0x0110, 0x10, 3, 1),
+	PIN_FIELD_BASE(142, 142, 1, 0x0110, 0x10, 4, 1),
+	PIN_FIELD_BASE(143, 143, 1, 0x0110, 0x10, 5, 1),
+	PIN_FIELD_BASE(144, 144, 1, 0x0110, 0x10, 6, 1),
+	PIN_FIELD_BASE(145, 145, 1, 0x0110, 0x10, 7, 1),
+	PIN_FIELD_BASE(146, 146, 1, 0x0110, 0x10, 8, 1),
+	PIN_FIELD_BASE(147, 147, 1, 0x0110, 0x10, 18, 1),
+	PIN_FIELD_BASE(148, 148, 1, 0x0110, 0x10, 19, 1),
+	PIN_FIELD_BASE(149, 149, 1, 0x0110, 0x10, 17, 1),
+	PIN_FIELD_BASE(150, 150, 1, 0x0110, 0x10, 0, 1),
+	PIN_FIELD_BASE(151, 151, 2, 0x0100, 0x10, 9, 1),
+	PIN_FIELD_BASE(152, 152, 2, 0x0100, 0x10, 8, 1),
+	PIN_FIELD_BASE(153, 153, 2, 0x0100, 0x10, 7, 1),
+	PIN_FIELD_BASE(154, 154, 2, 0x0100, 0x10, 6, 1),
+	PIN_FIELD_BASE(155, 155, 2, 0x0100, 0x10, 11, 1),
+	PIN_FIELD_BASE(156, 156, 2, 0x0100, 0x10, 1, 1),
+	PIN_FIELD_BASE(157, 157, 2, 0x0100, 0x10, 0, 1),
+	PIN_FIELD_BASE(158, 158, 2, 0x0100, 0x10, 5, 1),
+	PIN_FIELD_BASE(159, 159, 2, 0x0100, 0x10, 4, 1),
+	PIN_FIELD_BASE(160, 160, 2, 0x0100, 0x10, 3, 1),
+	PIN_FIELD_BASE(161, 161, 2, 0x0100, 0x10, 2, 1),
+	PIN_FIELD_BASE(162, 162, 2, 0x0100, 0x10, 10, 1),
+	PIN_FIELD_BASE(163, 163, 4, 0x00a0, 0x10, 1, 1),
+	PIN_FIELD_BASE(164, 164, 4, 0x00a0, 0x10, 0, 1),
+	PIN_FIELD_BASE(165, 165, 4, 0x00a0, 0x10, 2, 1),
+	PIN_FIELD_BASE(166, 166, 4, 0x00a0, 0x10, 3, 1),
+	PIN_FIELD_BASE(167, 167, 4, 0x00a0, 0x10, 4, 1),
+	PIN_FIELD_BASE(168, 168, 4, 0x00a0, 0x10, 5, 1),
+	PIN_FIELD_BASE(169, 169, 3, 0x0090, 0x10, 1, 1),
+	PIN_FIELD_BASE(170, 170, 3, 0x0090, 0x10, 0, 1),
+	PIN_FIELD_BASE(171, 171, 3, 0x0090, 0x10, 2, 1),
+	PIN_FIELD_BASE(172, 172, 3, 0x0090, 0x10, 3, 1),
+	PIN_FIELD_BASE(173, 173, 3, 0x0090, 0x10, 4, 1),
+	PIN_FIELD_BASE(174, 174, 3, 0x0090, 0x10, 5, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_pu_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x00e0, 0x10, 6, 1),
+	PIN_FIELD_BASE(1, 1, 1, 0x00e0, 0x10, 7, 1),
+	PIN_FIELD_BASE(2, 2, 1, 0x00e0, 0x10, 8, 1),
+	PIN_FIELD_BASE(3, 3, 1, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(4, 4, 1, 0x00e0, 0x10, 10, 1),
+	PIN_FIELD_BASE(5, 5, 1, 0x00e0, 0x10, 11, 1),
+	PIN_FIELD_BASE(6, 6, 1, 0x00e0, 0x10, 12, 1),
+	PIN_FIELD_BASE(7, 7, 1, 0x00e0, 0x10, 13, 1),
+	PIN_FIELD_BASE(8, 8, 1, 0x00e0, 0x10, 14, 1),
+	PIN_FIELD_BASE(9, 9, 1, 0x00e0, 0x10, 15, 1),
+	PIN_FIELD_BASE(10, 10, 1, 0x00e0, 0x10, 16, 1),
+	PIN_FIELD_BASE(11, 11, 1, 0x00e0, 0x10, 17, 1),
+	PIN_FIELD_BASE(12, 12, 2, 0x00d0, 0x10, 12, 1),
+	PIN_FIELD_BASE(13, 13, 2, 0x00d0, 0x10, 13, 1),
+	PIN_FIELD_BASE(14, 14, 2, 0x00d0, 0x10, 14, 1),
+	PIN_FIELD_BASE(15, 15, 2, 0x00d0, 0x10, 15, 1),
+	PIN_FIELD_BASE(16, 16, 3, 0x0070, 0x10, 1, 1),
+	PIN_FIELD_BASE(17, 17, 3, 0x0070, 0x10, 2, 1),
+	PIN_FIELD_BASE(18, 18, 4, 0x0080, 0x10, 3, 1),
+	PIN_FIELD_BASE(19, 19, 4, 0x0080, 0x10, 5, 1),
+	PIN_FIELD_BASE(20, 20, 4, 0x0080, 0x10, 4, 1),
+	PIN_FIELD_BASE(21, 21, 4, 0x0080, 0x10, 6, 1),
+	PIN_FIELD_BASE(22, 22, 4, 0x0080, 0x10, 0, 1),
+	PIN_FIELD_BASE(23, 23, 4, 0x0080, 0x10, 1, 1),
+	PIN_FIELD_BASE(24, 24, 4, 0x0080, 0x10, 2, 1),
+	PIN_FIELD_BASE(25, 25, 1, 0x00e0, 0x10, 3, 1),
+	PIN_FIELD_BASE(26, 26, 1, 0x00e0, 0x10, 2, 1),
+	PIN_FIELD_BASE(27, 27, 1, 0x00e0, 0x10, 5, 1),
+	PIN_FIELD_BASE(28, 28, 1, 0x00e0, 0x10, 4, 1),
+	PIN_FIELD_BASE(29, 29, 1, 0x00e0, 0x10, 0, 1),
+	PIN_FIELD_BASE(30, 30, 1, 0x00e0, 0x10, 1, 1),
+	PIN_FIELD_BASE(31, 31, 1, 0x00f0, 0x10, 11, 1),
+	PIN_FIELD_BASE(32, 32, 1, 0x00f0, 0x10, 10, 1),
+	PIN_FIELD_BASE(33, 33, 1, 0x00f0, 0x10, 13, 1),
+	PIN_FIELD_BASE(34, 34, 1, 0x00f0, 0x10, 12, 1),
+	PIN_FIELD_BASE(35, 35, 1, 0x00f0, 0x10, 15, 1),
+	PIN_FIELD_BASE(36, 36, 1, 0x00f0, 0x10, 14, 1),
+	PIN_FIELD_BASE(37, 37, 1, 0x00e0, 0x10, 21, 1),
+	PIN_FIELD_BASE(38, 38, 1, 0x00e0, 0x10, 18, 1),
+	PIN_FIELD_BASE(39, 39, 1, 0x00e0, 0x10, 19, 1),
+	PIN_FIELD_BASE(40, 40, 1, 0x00e0, 0x10, 20, 1),
+	PIN_FIELD_BASE(41, 41, 1, 0x00e0, 0x10, 22, 1),
+	PIN_FIELD_BASE(46, 46, 3, 0x0070, 0x10, 0, 1),
+	PIN_FIELD_BASE(47, 47, 1, 0x00e0, 0x10, 25, 1),
+	PIN_FIELD_BASE(48, 48, 1, 0x00e0, 0x10, 24, 1),
+	PIN_FIELD_BASE(49, 49, 1, 0x00e0, 0x10, 23, 1),
+	PIN_FIELD_BASE(50, 50, 3, 0x0070, 0x10, 5, 1),
+	PIN_FIELD_BASE(51, 51, 3, 0x0070, 0x10, 4, 1),
+	PIN_FIELD_BASE(52, 52, 3, 0x0070, 0x10, 3, 1),
+	PIN_FIELD_BASE(53, 53, 3, 0x0070, 0x10, 6, 1),
+	PIN_FIELD_BASE(54, 54, 3, 0x0070, 0x10, 7, 1),
+	PIN_FIELD_BASE(55, 55, 1, 0x00e0, 0x10, 26, 1),
+	PIN_FIELD_BASE(56, 56, 1, 0x00e0, 0x10, 29, 1),
+	PIN_FIELD_BASE(57, 57, 2, 0x00e0, 0x10, 6, 1),
+	PIN_FIELD_BASE(58, 58, 2, 0x00e0, 0x10, 9, 1),
+	PIN_FIELD_BASE(59, 59, 1, 0x00e0, 0x10, 27, 1),
+	PIN_FIELD_BASE(60, 60, 1, 0x00e0, 0x10, 30, 1),
+	PIN_FIELD_BASE(61, 61, 1, 0x00e0, 0x10, 28, 1),
+	PIN_FIELD_BASE(62, 62, 1, 0x00e0, 0x10, 31, 1),
+	PIN_FIELD_BASE(63, 63, 2, 0x00e0, 0x10, 7, 1),
+	PIN_FIELD_BASE(64, 64, 2, 0x00e0, 0x10, 10, 1),
+	PIN_FIELD_BASE(65, 65, 4, 0x0080, 0x10, 7, 1),
+	PIN_FIELD_BASE(66, 66, 4, 0x0080, 0x10, 9, 1),
+	PIN_FIELD_BASE(67, 67, 4, 0x0080, 0x10, 8, 1),
+	PIN_FIELD_BASE(68, 68, 4, 0x0080, 0x10, 10, 1),
+	PIN_FIELD_BASE(69, 69, 1, 0x00f0, 0x10, 1, 1),
+	PIN_FIELD_BASE(70, 70, 1, 0x00f0, 0x10, 0, 1),
+	PIN_FIELD_BASE(71, 71, 1, 0x00f0, 0x10, 5, 1),
+	PIN_FIELD_BASE(72, 72, 1, 0x00f0, 0x10, 4, 1),
+	PIN_FIELD_BASE(73, 73, 1, 0x00f0, 0x10, 2, 1),
+	PIN_FIELD_BASE(74, 74, 1, 0x00f0, 0x10, 3, 1),
+	PIN_FIELD_BASE(75, 75, 1, 0x00f0, 0x10, 7, 1),
+	PIN_FIELD_BASE(76, 76, 1, 0x00f0, 0x10, 6, 1),
+	PIN_FIELD_BASE(77, 77, 1, 0x00f0, 0x10, 9, 1),
+	PIN_FIELD_BASE(78, 78, 1, 0x00f0, 0x10, 8, 1),
+	PIN_FIELD_BASE(79, 79, 4, 0x0080, 0x10, 12, 1),
+	PIN_FIELD_BASE(80, 80, 4, 0x0080, 0x10, 11, 1),
+	PIN_FIELD_BASE(81, 81, 4, 0x0080, 0x10, 14, 1),
+	PIN_FIELD_BASE(82, 82, 4, 0x0080, 0x10, 13, 1),
+	PIN_FIELD_BASE(83, 83, 2, 0x00e0, 0x10, 16, 1),
+	PIN_FIELD_BASE(84, 84, 2, 0x00e0, 0x10, 15, 1),
+	PIN_FIELD_BASE(85, 85, 2, 0x00e0, 0x10, 17, 1),
+	PIN_FIELD_BASE(86, 86, 2, 0x00e0, 0x10, 19, 1),
+	PIN_FIELD_BASE(87, 87, 2, 0x00e0, 0x10, 18, 1),
+	PIN_FIELD_BASE(88, 88, 2, 0x00e0, 0x10, 20, 1),
+	PIN_FIELD_BASE(89, 89, 2, 0x00e0, 0x10, 22, 1),
+	PIN_FIELD_BASE(90, 90, 2, 0x00e0, 0x10, 21, 1),
+	PIN_FIELD_BASE(91, 91, 2, 0x00e0, 0x10, 23, 1),
+	PIN_FIELD_BASE(92, 92, 2, 0x00e0, 0x10, 3, 1),
+	PIN_FIELD_BASE(93, 93, 2, 0x00e0, 0x10, 2, 1),
+	PIN_FIELD_BASE(94, 94, 2, 0x00e0, 0x10, 5, 1),
+	PIN_FIELD_BASE(95, 95, 2, 0x00e0, 0x10, 4, 1),
+	PIN_FIELD_BASE(96, 96, 2, 0x00d0, 0x10, 31, 1),
+	PIN_FIELD_BASE(97, 97, 2, 0x00e0, 0x10, 0, 1),
+	PIN_FIELD_BASE(98, 98, 2, 0x00e0, 0x10, 8, 1),
+	PIN_FIELD_BASE(99, 99, 2, 0x00d0, 0x10, 30, 1),
+	PIN_FIELD_BASE(100, 100, 2, 0x00e0, 0x10, 1, 1),
+	PIN_FIELD_BASE(101, 101, 2, 0x00d0, 0x10, 0, 1),
+	PIN_FIELD_BASE(102, 102, 2, 0x00d0, 0x10, 5, 1),
+	PIN_FIELD_BASE(103, 103, 2, 0x00d0, 0x10, 3, 1),
+	PIN_FIELD_BASE(104, 104, 2, 0x00d0, 0x10, 4, 1),
+	PIN_FIELD_BASE(105, 105, 2, 0x00d0, 0x10, 1, 1),
+	PIN_FIELD_BASE(106, 106, 2, 0x00d0, 0x10, 2, 1),
+	PIN_FIELD_BASE(107, 107, 2, 0x00d0, 0x10, 21, 1),
+	PIN_FIELD_BASE(108, 108, 2, 0x00d0, 0x10, 16, 1),
+	PIN_FIELD_BASE(109, 109, 2, 0x00d0, 0x10, 22, 1),
+	PIN_FIELD_BASE(110, 110, 2, 0x00d0, 0x10, 17, 1),
+	PIN_FIELD_BASE(111, 111, 2, 0x00d0, 0x10, 18, 1),
+	PIN_FIELD_BASE(112, 112, 2, 0x00d0, 0x10, 19, 1),
+	PIN_FIELD_BASE(113, 113, 2, 0x00d0, 0x10, 20, 1),
+	PIN_FIELD_BASE(114, 114, 2, 0x00d0, 0x10, 28, 1),
+	PIN_FIELD_BASE(115, 115, 2, 0x00d0, 0x10, 23, 1),
+	PIN_FIELD_BASE(116, 116, 2, 0x00d0, 0x10, 29, 1),
+	PIN_FIELD_BASE(117, 117, 2, 0x00d0, 0x10, 24, 1),
+	PIN_FIELD_BASE(118, 118, 2, 0x00d0, 0x10, 25, 1),
+	PIN_FIELD_BASE(119, 119, 2, 0x00d0, 0x10, 26, 1),
+	PIN_FIELD_BASE(120, 120, 2, 0x00d0, 0x10, 27, 1),
+	PIN_FIELD_BASE(121, 121, 3, 0x0070, 0x10, 8, 1),
+	PIN_FIELD_BASE(122, 122, 3, 0x0070, 0x10, 11, 1),
+	PIN_FIELD_BASE(123, 123, 3, 0x0070, 0x10, 10, 1),
+	PIN_FIELD_BASE(124, 124, 3, 0x0070, 0x10, 9, 1),
+	PIN_FIELD_BASE(125, 125, 2, 0x00d0, 0x10, 6, 1),
+	PIN_FIELD_BASE(126, 126, 2, 0x00d0, 0x10, 7, 1),
+	PIN_FIELD_BASE(127, 127, 2, 0x00d0, 0x10, 8, 1),
+	PIN_FIELD_BASE(128, 128, 2, 0x00d0, 0x10, 9, 1),
+	PIN_FIELD_BASE(129, 129, 2, 0x00d0, 0x10, 10, 1),
+	PIN_FIELD_BASE(130, 130, 2, 0x00d0, 0x10, 11, 1),
+	PIN_FIELD_BASE(175, 175, 2, 0x00e0, 0x10, 11, 1),
+	PIN_FIELD_BASE(176, 176, 2, 0x00e0, 0x10, 12, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_pd_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x00b0, 0x10, 6, 1),
+	PIN_FIELD_BASE(1, 1, 1, 0x00b0, 0x10, 7, 1),
+	PIN_FIELD_BASE(2, 2, 1, 0x00b0, 0x10, 8, 1),
+	PIN_FIELD_BASE(3, 3, 1, 0x00b0, 0x10, 9, 1),
+	PIN_FIELD_BASE(4, 4, 1, 0x00b0, 0x10, 10, 1),
+	PIN_FIELD_BASE(5, 5, 1, 0x00b0, 0x10, 11, 1),
+	PIN_FIELD_BASE(6, 6, 1, 0x00b0, 0x10, 12, 1),
+	PIN_FIELD_BASE(7, 7, 1, 0x00b0, 0x10, 13, 1),
+	PIN_FIELD_BASE(8, 8, 1, 0x00b0, 0x10, 14, 1),
+	PIN_FIELD_BASE(9, 9, 1, 0x00b0, 0x10, 15, 1),
+	PIN_FIELD_BASE(10, 10, 1, 0x00b0, 0x10, 16, 1),
+	PIN_FIELD_BASE(11, 11, 1, 0x00b0, 0x10, 17, 1),
+	PIN_FIELD_BASE(12, 12, 2, 0x00a0, 0x10, 12, 1),
+	PIN_FIELD_BASE(13, 13, 2, 0x00a0, 0x10, 13, 1),
+	PIN_FIELD_BASE(14, 14, 2, 0x00a0, 0x10, 14, 1),
+	PIN_FIELD_BASE(15, 15, 2, 0x00a0, 0x10, 15, 1),
+	PIN_FIELD_BASE(16, 16, 3, 0x0050, 0x10, 1, 1),
+	PIN_FIELD_BASE(17, 17, 3, 0x0050, 0x10, 2, 1),
+	PIN_FIELD_BASE(18, 18, 4, 0x0060, 0x10, 3, 1),
+	PIN_FIELD_BASE(19, 19, 4, 0x0060, 0x10, 5, 1),
+	PIN_FIELD_BASE(20, 20, 4, 0x0060, 0x10, 4, 1),
+	PIN_FIELD_BASE(21, 21, 4, 0x0060, 0x10, 6, 1),
+	PIN_FIELD_BASE(22, 22, 4, 0x0060, 0x10, 0, 1),
+	PIN_FIELD_BASE(23, 23, 4, 0x0060, 0x10, 1, 1),
+	PIN_FIELD_BASE(24, 24, 4, 0x0060, 0x10, 2, 1),
+	PIN_FIELD_BASE(25, 25, 1, 0x00b0, 0x10, 3, 1),
+	PIN_FIELD_BASE(26, 26, 1, 0x00b0, 0x10, 2, 1),
+	PIN_FIELD_BASE(27, 27, 1, 0x00b0, 0x10, 5, 1),
+	PIN_FIELD_BASE(28, 28, 1, 0x00b0, 0x10, 4, 1),
+	PIN_FIELD_BASE(29, 29, 1, 0x00b0, 0x10, 0, 1),
+	PIN_FIELD_BASE(30, 30, 1, 0x00b0, 0x10, 1, 1),
+	PIN_FIELD_BASE(31, 31, 1, 0x00c0, 0x10, 11, 1),
+	PIN_FIELD_BASE(32, 32, 1, 0x00c0, 0x10, 10, 1),
+	PIN_FIELD_BASE(33, 33, 1, 0x00c0, 0x10, 13, 1),
+	PIN_FIELD_BASE(34, 34, 1, 0x00c0, 0x10, 12, 1),
+	PIN_FIELD_BASE(35, 35, 1, 0x00c0, 0x10, 15, 1),
+	PIN_FIELD_BASE(36, 36, 1, 0x00c0, 0x10, 14, 1),
+	PIN_FIELD_BASE(37, 37, 1, 0x00b0, 0x10, 21, 1),
+	PIN_FIELD_BASE(38, 38, 1, 0x00b0, 0x10, 18, 1),
+	PIN_FIELD_BASE(39, 39, 1, 0x00b0, 0x10, 19, 1),
+	PIN_FIELD_BASE(40, 40, 1, 0x00b0, 0x10, 20, 1),
+	PIN_FIELD_BASE(41, 41, 1, 0x00b0, 0x10, 22, 1),
+	PIN_FIELD_BASE(46, 46, 3, 0x0050, 0x10, 0, 1),
+	PIN_FIELD_BASE(47, 47, 1, 0x00b0, 0x10, 25, 1),
+	PIN_FIELD_BASE(48, 48, 1, 0x00b0, 0x10, 24, 1),
+	PIN_FIELD_BASE(49, 49, 1, 0x00b0, 0x10, 23, 1),
+	PIN_FIELD_BASE(50, 50, 3, 0x0050, 0x10, 5, 1),
+	PIN_FIELD_BASE(51, 51, 3, 0x0050, 0x10, 4, 1),
+	PIN_FIELD_BASE(52, 52, 3, 0x0050, 0x10, 3, 1),
+	PIN_FIELD_BASE(53, 53, 3, 0x0050, 0x10, 6, 1),
+	PIN_FIELD_BASE(54, 54, 3, 0x0050, 0x10, 7, 1),
+	PIN_FIELD_BASE(55, 55, 1, 0x00b0, 0x10, 26, 1),
+	PIN_FIELD_BASE(56, 56, 1, 0x00b0, 0x10, 29, 1),
+	PIN_FIELD_BASE(57, 57, 2, 0x00b0, 0x10, 6, 1),
+	PIN_FIELD_BASE(58, 58, 2, 0x00b0, 0x10, 9, 1),
+	PIN_FIELD_BASE(59, 59, 1, 0x00b0, 0x10, 27, 1),
+	PIN_FIELD_BASE(60, 60, 1, 0x00b0, 0x10, 30, 1),
+	PIN_FIELD_BASE(61, 61, 1, 0x00b0, 0x10, 28, 1),
+	PIN_FIELD_BASE(62, 62, 1, 0x00b0, 0x10, 31, 1),
+	PIN_FIELD_BASE(63, 63, 2, 0x00b0, 0x10, 7, 1),
+	PIN_FIELD_BASE(64, 64, 2, 0x00b0, 0x10, 10, 1),
+	PIN_FIELD_BASE(65, 65, 4, 0x0060, 0x10, 7, 1),
+	PIN_FIELD_BASE(66, 66, 4, 0x0060, 0x10, 9, 1),
+	PIN_FIELD_BASE(67, 67, 4, 0x0060, 0x10, 8, 1),
+	PIN_FIELD_BASE(68, 68, 4, 0x0060, 0x10, 10, 1),
+	PIN_FIELD_BASE(69, 69, 1, 0x00c0, 0x10, 1, 1),
+	PIN_FIELD_BASE(70, 70, 1, 0x00c0, 0x10, 0, 1),
+	PIN_FIELD_BASE(71, 71, 1, 0x00c0, 0x10, 5, 1),
+	PIN_FIELD_BASE(72, 72, 1, 0x00c0, 0x10, 4, 1),
+	PIN_FIELD_BASE(73, 73, 1, 0x00c0, 0x10, 2, 1),
+	PIN_FIELD_BASE(74, 74, 1, 0x00c0, 0x10, 3, 1),
+	PIN_FIELD_BASE(75, 75, 1, 0x00c0, 0x10, 7, 1),
+	PIN_FIELD_BASE(76, 76, 1, 0x00c0, 0x10, 6, 1),
+	PIN_FIELD_BASE(77, 77, 1, 0x00c0, 0x10, 9, 1),
+	PIN_FIELD_BASE(78, 78, 1, 0x00c0, 0x10, 8, 1),
+	PIN_FIELD_BASE(79, 79, 4, 0x0060, 0x10, 12, 1),
+	PIN_FIELD_BASE(80, 80, 4, 0x0060, 0x10, 11, 1),
+	PIN_FIELD_BASE(81, 81, 4, 0x0060, 0x10, 14, 1),
+	PIN_FIELD_BASE(82, 82, 4, 0x0060, 0x10, 13, 1),
+	PIN_FIELD_BASE(83, 83, 2, 0x00b0, 0x10, 16, 1),
+	PIN_FIELD_BASE(84, 84, 2, 0x00b0, 0x10, 15, 1),
+	PIN_FIELD_BASE(85, 85, 2, 0x00b0, 0x10, 17, 1),
+	PIN_FIELD_BASE(86, 86, 2, 0x00b0, 0x10, 19, 1),
+	PIN_FIELD_BASE(87, 87, 2, 0x00b0, 0x10, 18, 1),
+	PIN_FIELD_BASE(88, 88, 2, 0x00b0, 0x10, 20, 1),
+	PIN_FIELD_BASE(89, 89, 2, 0x00b0, 0x10, 22, 1),
+	PIN_FIELD_BASE(90, 90, 2, 0x00b0, 0x10, 21, 1),
+	PIN_FIELD_BASE(91, 91, 2, 0x00b0, 0x10, 23, 1),
+	PIN_FIELD_BASE(92, 92, 2, 0x00b0, 0x10, 3, 1),
+	PIN_FIELD_BASE(93, 93, 2, 0x00b0, 0x10, 2, 1),
+	PIN_FIELD_BASE(94, 94, 2, 0x00b0, 0x10, 5, 1),
+	PIN_FIELD_BASE(95, 95, 2, 0x00b0, 0x10, 4, 1),
+	PIN_FIELD_BASE(96, 96, 2, 0x00a0, 0x10, 31, 1),
+	PIN_FIELD_BASE(97, 97, 2, 0x00b0, 0x10, 0, 1),
+	PIN_FIELD_BASE(98, 98, 2, 0x00b0, 0x10, 8, 1),
+	PIN_FIELD_BASE(99, 99, 2, 0x00a0, 0x10, 30, 1),
+	PIN_FIELD_BASE(100, 100, 2, 0x00b0, 0x10, 1, 1),
+	PIN_FIELD_BASE(101, 101, 2, 0x00a0, 0x10, 0, 1),
+	PIN_FIELD_BASE(102, 102, 2, 0x00a0, 0x10, 5, 1),
+	PIN_FIELD_BASE(103, 103, 2, 0x00a0, 0x10, 3, 1),
+	PIN_FIELD_BASE(104, 104, 2, 0x00a0, 0x10, 4, 1),
+	PIN_FIELD_BASE(105, 105, 2, 0x00a0, 0x10, 1, 1),
+	PIN_FIELD_BASE(106, 106, 2, 0x00a0, 0x10, 2, 1),
+	PIN_FIELD_BASE(107, 107, 2, 0x00a0, 0x10, 21, 1),
+	PIN_FIELD_BASE(108, 108, 2, 0x00a0, 0x10, 16, 1),
+	PIN_FIELD_BASE(109, 109, 2, 0x00a0, 0x10, 22, 1),
+	PIN_FIELD_BASE(110, 110, 2, 0x00a0, 0x10, 17, 1),
+	PIN_FIELD_BASE(111, 111, 2, 0x00a0, 0x10, 18, 1),
+	PIN_FIELD_BASE(112, 112, 2, 0x00a0, 0x10, 19, 1),
+	PIN_FIELD_BASE(113, 113, 2, 0x00a0, 0x10, 20, 1),
+	PIN_FIELD_BASE(114, 114, 2, 0x00a0, 0x10, 28, 1),
+	PIN_FIELD_BASE(115, 115, 2, 0x00a0, 0x10, 23, 1),
+	PIN_FIELD_BASE(116, 116, 2, 0x00a0, 0x10, 29, 1),
+	PIN_FIELD_BASE(117, 117, 2, 0x00a0, 0x10, 24, 1),
+	PIN_FIELD_BASE(118, 118, 2, 0x00a0, 0x10, 25, 1),
+	PIN_FIELD_BASE(119, 119, 2, 0x00a0, 0x10, 26, 1),
+	PIN_FIELD_BASE(120, 120, 2, 0x00a0, 0x10, 27, 1),
+	PIN_FIELD_BASE(121, 121, 3, 0x0050, 0x10, 8, 1),
+	PIN_FIELD_BASE(122, 122, 3, 0x0050, 0x10, 11, 1),
+	PIN_FIELD_BASE(123, 123, 3, 0x0050, 0x10, 10, 1),
+	PIN_FIELD_BASE(124, 124, 3, 0x0050, 0x10, 9, 1),
+	PIN_FIELD_BASE(125, 125, 2, 0x00a0, 0x10, 6, 1),
+	PIN_FIELD_BASE(126, 126, 2, 0x00a0, 0x10, 7, 1),
+	PIN_FIELD_BASE(127, 127, 2, 0x00a0, 0x10, 8, 1),
+	PIN_FIELD_BASE(128, 128, 2, 0x00a0, 0x10, 9, 1),
+	PIN_FIELD_BASE(129, 129, 2, 0x00a0, 0x10, 10, 1),
+	PIN_FIELD_BASE(130, 130, 2, 0x00a0, 0x10, 11, 1),
+	PIN_FIELD_BASE(175, 175, 2, 0x00b0, 0x10, 11, 1),
+	PIN_FIELD_BASE(176, 176, 2, 0x00b0, 0x10, 12, 1),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_drv_range[] = {
+	PIN_FIELD_BASE(0, 0, 1, 0x0000, 0x10, 24, 3),
+	PIN_FIELD_BASE(1, 1, 1, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(2, 2, 1, 0x0010, 0x10, 0, 3),
+	PIN_FIELD_BASE(3, 3, 1, 0x0010, 0x10, 3, 3),
+	PIN_FIELD_BASE(4, 4, 1, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(5, 5, 1, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(6, 6, 1, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(7, 7, 1, 0x0010, 0x10, 6, 3),
+	PIN_FIELD_BASE(8, 8, 1, 0x0010, 0x10, 9, 3),
+	PIN_FIELD_BASE(9, 9, 1, 0x0010, 0x10, 12, 3),
+	PIN_FIELD_BASE(10, 10, 1, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(11, 11, 1, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(12, 12, 2, 0x0010, 0x10, 24, 3),
+	PIN_FIELD_BASE(13, 13, 2, 0x0010, 0x10, 27, 3),
+	PIN_FIELD_BASE(14, 14, 2, 0x0020, 0x10, 0, 3),
+	PIN_FIELD_BASE(15, 15, 2, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(16, 16, 3, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(17, 17, 3, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(18, 18, 4, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(19, 19, 4, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(20, 20, 4, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(21, 21, 4, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(22, 22, 4, 0x0000, 0x10, 0, 3),
+	PIN_FIELD_BASE(23, 23, 4, 0x0000, 0x10, 3, 3),
+	PIN_FIELD_BASE(24, 24, 4, 0x0000, 0x10, 6, 3),
+	PIN_FIELD_BASE(25, 25, 1, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(26, 26, 1, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(27, 27, 1, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(28, 28, 1, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(29, 29, 1, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(30, 30, 1, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(31, 31, 1, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(32, 32, 1, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(33, 33, 1, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(34, 34, 1, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(35, 35, 1, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(36, 36, 1, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(37, 37, 1, 0x0010, 0x10, 27, 3),
+	PIN_FIELD_BASE(38, 38, 1, 0x0010, 0x10, 18, 3),
+	PIN_FIELD_BASE(39, 39, 1, 0x0010, 0x10, 21, 3),
+	PIN_FIELD_BASE(40, 40, 1, 0x0010, 0x10, 24, 3),
+	PIN_FIELD_BASE(41, 41, 1, 0x0020, 0x10, 0, 3),
+	PIN_FIELD_BASE(42, 42, 2, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(43, 43, 2, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(44, 44, 2, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(45, 45, 2, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(46, 46, 3, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(47, 47, 1, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(48, 48, 1, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(49, 49, 1, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(50, 50, 3, 0x0000, 0x10, 6, 3),
+	PIN_FIELD_BASE(51, 51, 3, 0x0000, 0x10, 3, 3),
+	PIN_FIELD_BASE(52, 52, 3, 0x0000, 0x10, 0, 3),
+	PIN_FIELD_BASE(53, 53, 3, 0x0000, 0x10, 9, 3),
+	PIN_FIELD_BASE(54, 54, 3, 0x0000, 0x10, 12, 3),
+	PIN_FIELD_BASE(55, 55, 1, 0x0020, 0x10, 27, 3),
+	PIN_FIELD_BASE(56, 56, 1, 0x0030, 0x10, 6, 3),
+	PIN_FIELD_BASE(57, 57, 2, 0x0030, 0x10, 9, 3),
+	PIN_FIELD_BASE(58, 58, 2, 0x0030, 0x10, 15, 3),
+	PIN_FIELD_BASE(59, 59, 1, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(60, 60, 1, 0x0030, 0x10, 9, 3),
+	PIN_FIELD_BASE(61, 61, 1, 0x0030, 0x10, 3, 3),
+	PIN_FIELD_BASE(62, 62, 1, 0x0030, 0x10, 12, 3),
+	PIN_FIELD_BASE(63, 63, 2, 0x0030, 0x10, 12, 3),
+	PIN_FIELD_BASE(64, 64, 2, 0x0030, 0x10, 18, 3),
+	PIN_FIELD_BASE(65, 65, 4, 0x0010, 0x10, 0, 3),
+	PIN_FIELD_BASE(66, 66, 4, 0x0010, 0x10, 6, 3),
+	PIN_FIELD_BASE(67, 67, 4, 0x0010, 0x10, 3, 3),
+	PIN_FIELD_BASE(68, 68, 4, 0x0010, 0x10, 9, 3),
+	PIN_FIELD_BASE(69, 69, 1, 0x0030, 0x10, 18, 3),
+	PIN_FIELD_BASE(70, 70, 1, 0x0030, 0x10, 15, 3),
+	PIN_FIELD_BASE(71, 71, 1, 0x0040, 0x10, 0, 3),
+	PIN_FIELD_BASE(72, 72, 1, 0x0030, 0x10, 27, 3),
+	PIN_FIELD_BASE(73, 73, 1, 0x0030, 0x10, 21, 3),
+	PIN_FIELD_BASE(74, 74, 1, 0x0030, 0x10, 24, 3),
+	PIN_FIELD_BASE(75, 75, 1, 0x0040, 0x10, 6, 3),
+	PIN_FIELD_BASE(76, 76, 1, 0x0040, 0x10, 3, 3),
+	PIN_FIELD_BASE(77, 77, 1, 0x0040, 0x10, 12, 3),
+	PIN_FIELD_BASE(78, 78, 1, 0x0040, 0x10, 9, 3),
+	PIN_FIELD_BASE(79, 79, 4, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(80, 80, 4, 0x0010, 0x10, 12, 3),
+	PIN_FIELD_BASE(81, 81, 4, 0x0010, 0x10, 21, 3),
+	PIN_FIELD_BASE(82, 82, 4, 0x0010, 0x10, 18, 3),
+	PIN_FIELD_BASE(83, 83, 2, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(84, 84, 2, 0x0020, 0x10, 27, 3),
+	PIN_FIELD_BASE(85, 85, 2, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(86, 86, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(87, 87, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(88, 88, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(89, 89, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(90, 90, 2, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(91, 91, 2, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(92, 92, 2, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(93, 93, 2, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(94, 94, 2, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(95, 95, 2, 0x0020, 0x10, 9, 3),
+	PIN_FIELD_BASE(96, 96, 2, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(97, 97, 2, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(98, 98, 2, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(99, 99, 2, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(100, 100, 2, 0x0030, 0x10, 6, 3),
+	PIN_FIELD_BASE(101, 101, 2, 0x0000, 0x10, 0, 3),
+	PIN_FIELD_BASE(102, 102, 2, 0x0000, 0x10, 15, 3),
+	PIN_FIELD_BASE(103, 103, 2, 0x0000, 0x10, 9, 3),
+	PIN_FIELD_BASE(104, 104, 2, 0x0000, 0x10, 12, 3),
+	PIN_FIELD_BASE(105, 105, 2, 0x0000, 0x10, 3, 3),
+	PIN_FIELD_BASE(106, 106, 2, 0x0000, 0x10, 6, 3),
+	PIN_FIELD_BASE(107, 107, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(108, 108, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(109, 109, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(110, 110, 2, 0x0020, 0x10, 6, 3),
+	PIN_FIELD_BASE(111, 111, 2, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(112, 112, 2, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(113, 113, 2, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(114, 114, 2, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(115, 115, 2, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(116, 116, 2, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(117, 117, 2, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(118, 118, 2, 0x0020, 0x10, 12, 3),
+	PIN_FIELD_BASE(119, 119, 2, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(120, 120, 2, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(121, 121, 3, 0x0010, 0x10, 3, 3),
+	PIN_FIELD_BASE(122, 122, 3, 0x0010, 0x10, 12, 3),
+	PIN_FIELD_BASE(123, 123, 3, 0x0010, 0x10, 9, 3),
+	PIN_FIELD_BASE(124, 124, 3, 0x0010, 0x10, 6, 3),
+	PIN_FIELD_BASE(125, 125, 2, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(126, 126, 2, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(127, 127, 2, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(128, 128, 2, 0x0020, 0x10, 27, 3),
+	PIN_FIELD_BASE(129, 129, 2, 0x0020, 0x10, 27, 3),
+	PIN_FIELD_BASE(130, 130, 2, 0x0020, 0x10, 27, 3),
+	PIN_FIELD_BASE(131, 131, 1, 0x0000, 0x10, 0, 3),
+	PIN_FIELD_BASE(132, 132, 1, 0x0000, 0x10, 15, 3),
+	PIN_FIELD_BASE(133, 133, 1, 0x0000, 0x10, 18, 3),
+	PIN_FIELD_BASE(134, 134, 1, 0x0000, 0x10, 21, 3),
+	PIN_FIELD_BASE(135, 135, 1, 0x0020, 0x10, 15, 3),
+	PIN_FIELD_BASE(136, 136, 1, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(137, 137, 1, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(138, 138, 1, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(139, 139, 1, 0x0020, 0x10, 18, 3),
+	PIN_FIELD_BASE(140, 140, 1, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(141, 141, 1, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(142, 142, 1, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(143, 143, 1, 0x0000, 0x10, 3, 3),
+	PIN_FIELD_BASE(144, 144, 1, 0x0000, 0x10, 6, 3),
+	PIN_FIELD_BASE(145, 145, 1, 0x0000, 0x10, 9, 3),
+	PIN_FIELD_BASE(146, 146, 1, 0x0000, 0x10, 12, 3),
+	PIN_FIELD_BASE(147, 147, 1, 0x0020, 0x10, 21, 3),
+	PIN_FIELD_BASE(148, 148, 1, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(149, 149, 1, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(150, 150, 1, 0x0020, 0x10, 24, 3),
+	PIN_FIELD_BASE(151, 151, 2, 0x0010, 0x10, 15, 3),
+	PIN_FIELD_BASE(152, 152, 2, 0x0010, 0x10, 12, 3),
+	PIN_FIELD_BASE(153, 153, 2, 0x0010, 0x10, 9, 3),
+	PIN_FIELD_BASE(154, 154, 2, 0x0010, 0x10, 6, 3),
+	PIN_FIELD_BASE(155, 155, 2, 0x0010, 0x10, 21, 3),
+	PIN_FIELD_BASE(156, 156, 2, 0x0000, 0x10, 21, 3),
+	PIN_FIELD_BASE(157, 157, 2, 0x0000, 0x10, 18, 3),
+	PIN_FIELD_BASE(158, 158, 2, 0x0010, 0x10, 3, 3),
+	PIN_FIELD_BASE(159, 159, 2, 0x0010, 0x10, 0, 3),
+	PIN_FIELD_BASE(160, 160, 2, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(161, 161, 2, 0x0000, 0x10, 24, 3),
+	PIN_FIELD_BASE(162, 162, 2, 0x0010, 0x10, 18, 3),
+	PIN_FIELD_BASE(163, 163, 4, 0x0000, 0x10, 12, 3),
+	PIN_FIELD_BASE(164, 164, 4, 0x0000, 0x10, 9, 3),
+	PIN_FIELD_BASE(165, 165, 4, 0x0000, 0x10, 15, 3),
+	PIN_FIELD_BASE(166, 166, 4, 0x0000, 0x10, 18, 3),
+	PIN_FIELD_BASE(167, 167, 4, 0x0000, 0x10, 21, 3),
+	PIN_FIELD_BASE(168, 168, 4, 0x0000, 0x10, 24, 3),
+	PIN_FIELD_BASE(169, 169, 3, 0x0000, 0x10, 18, 3),
+	PIN_FIELD_BASE(170, 170, 3, 0x0000, 0x10, 15, 3),
+	PIN_FIELD_BASE(171, 171, 3, 0x0000, 0x10, 21, 3),
+	PIN_FIELD_BASE(172, 172, 3, 0x0000, 0x10, 24, 3),
+	PIN_FIELD_BASE(173, 173, 3, 0x0000, 0x10, 27, 3),
+	PIN_FIELD_BASE(174, 174, 3, 0x0010, 0x10, 0, 3),
+	PIN_FIELD_BASE(175, 175, 2, 0x0030, 0x10, 3, 3),
+	PIN_FIELD_BASE(176, 176, 2, 0x0030, 0x10, 3, 3),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_drv_adv_range[] = {
+	PIN_FIELD_BASE(53, 53, 3, 0x0020, 0x10, 0, 3),
+	PIN_FIELD_BASE(54, 54, 3, 0x0020, 0x10, 3, 3),
+	PIN_FIELD_BASE(55, 55, 1, 0x0060, 0x10, 0, 3),
+	PIN_FIELD_BASE(56, 56, 1, 0x0060, 0x10, 9, 3),
+	PIN_FIELD_BASE(57, 57, 2, 0x0050, 0x10, 0, 3),
+	PIN_FIELD_BASE(58, 58, 2, 0x0050, 0x10, 6, 3),
+	PIN_FIELD_BASE(59, 59, 1, 0x0060, 0x10, 3, 3),
+	PIN_FIELD_BASE(60, 60, 1, 0x0060, 0x10, 12, 3),
+	PIN_FIELD_BASE(61, 61, 1, 0x0060, 0x10, 6, 3),
+	PIN_FIELD_BASE(62, 62, 1, 0x0060, 0x10, 15, 3),
+	PIN_FIELD_BASE(63, 63, 2, 0x0050, 0x10, 3, 3),
+	PIN_FIELD_BASE(64, 64, 2, 0x0050, 0x10, 9, 3),
+	PIN_FIELD_BASE(65, 65, 4, 0x0030, 0x10, 0, 3),
+	PIN_FIELD_BASE(66, 66, 4, 0x0030, 0x10, 6, 3),
+	PIN_FIELD_BASE(67, 67, 4, 0x0030, 0x10, 3, 3),
+	PIN_FIELD_BASE(68, 68, 4, 0x0030, 0x10, 9, 3),
+	PIN_FIELD_BASE(175, 175, 2, 0x0050, 0x10, 12, 3),
+	PIN_FIELD_BASE(176, 176, 2, 0x0050, 0x10, 15, 3),
+};
+
+static const struct mtk_pin_field_calc mt8188_pin_rsel_range[] = {
+	PIN_FIELD_BASE(53, 53, 3, 0x00c0, 0x10, 0, 3),
+	PIN_FIELD_BASE(54, 54, 3, 0x00c0, 0x10, 3, 3),
+	PIN_FIELD_BASE(55, 55, 1, 0x0160, 0x10, 0, 3),
+	PIN_FIELD_BASE(56, 56, 1, 0x0160, 0x10, 9, 3),
+	PIN_FIELD_BASE(57, 57, 2, 0x0150, 0x10, 0, 3),
+	PIN_FIELD_BASE(58, 58, 2, 0x0150, 0x10, 6, 3),
+	PIN_FIELD_BASE(59, 59, 1, 0x0160, 0x10, 3, 3),
+	PIN_FIELD_BASE(60, 60, 1, 0x0160, 0x10, 12, 3),
+	PIN_FIELD_BASE(61, 61, 1, 0x0160, 0x10, 6, 3),
+	PIN_FIELD_BASE(62, 62, 1, 0x0160, 0x10, 15, 3),
+	PIN_FIELD_BASE(63, 63, 2, 0x0150, 0x10, 3, 3),
+	PIN_FIELD_BASE(64, 64, 2, 0x0150, 0x10, 9, 3),
+	PIN_FIELD_BASE(65, 65, 4, 0x00d0, 0x10, 0, 3),
+	PIN_FIELD_BASE(66, 66, 4, 0x00d0, 0x10, 6, 3),
+	PIN_FIELD_BASE(67, 67, 4, 0x00d0, 0x10, 3, 3),
+	PIN_FIELD_BASE(68, 68, 4, 0x00d0, 0x10, 9, 3),
+	PIN_FIELD_BASE(175, 175, 2, 0x0150, 0x10, 12, 3),
+	PIN_FIELD_BASE(176, 176, 2, 0x0150, 0x10, 15, 3),
+};
+
+static const struct mtk_pin_rsel mt8188_pin_rsel_val_range[] = {
+	PIN_RSEL(53, 68, 0x0, 75000, 75000),
+	PIN_RSEL(53, 68, 0x1, 10000, 5000),
+	PIN_RSEL(53, 68, 0x2, 5000, 75000),
+	PIN_RSEL(53, 68, 0x3, 4000, 5000),
+	PIN_RSEL(53, 68, 0x4, 3000, 75000),
+	PIN_RSEL(53, 68, 0x5, 2000, 5000),
+	PIN_RSEL(53, 68, 0x6, 1500, 75000),
+	PIN_RSEL(53, 68, 0x7, 1000, 5000),
+	PIN_RSEL(175, 176, 0x0, 75000, 75000),
+	PIN_RSEL(175, 176, 0x1, 10000, 5000),
+	PIN_RSEL(175, 176, 0x2, 5000, 75000),
+	PIN_RSEL(175, 176, 0x3, 4000, 5000),
+	PIN_RSEL(175, 176, 0x4, 3000, 75000),
+	PIN_RSEL(175, 176, 0x5, 2000, 5000),
+	PIN_RSEL(175, 176, 0x6, 1500, 75000),
+	PIN_RSEL(175, 176, 0x7, 1000, 5000),
+};
+
+static const unsigned int mt8188_pull_type[] = {
+	MTK_PULL_PU_PD_TYPE, /*0*/
+	MTK_PULL_PU_PD_TYPE, /*1*/
+	MTK_PULL_PU_PD_TYPE, /*2*/
+	MTK_PULL_PU_PD_TYPE, /*3*/
+	MTK_PULL_PU_PD_TYPE, /*4*/
+	MTK_PULL_PU_PD_TYPE, /*5*/
+	MTK_PULL_PU_PD_TYPE, /*6*/
+	MTK_PULL_PU_PD_TYPE, /*7*/
+	MTK_PULL_PU_PD_TYPE, /*8*/
+	MTK_PULL_PU_PD_TYPE, /*9*/
+	MTK_PULL_PU_PD_TYPE, /*10*/
+	MTK_PULL_PU_PD_TYPE, /*11*/
+	MTK_PULL_PU_PD_TYPE, /*12*/
+	MTK_PULL_PU_PD_TYPE, /*13*/
+	MTK_PULL_PU_PD_TYPE, /*14*/
+	MTK_PULL_PU_PD_TYPE, /*15*/
+	MTK_PULL_PU_PD_TYPE, /*16*/
+	MTK_PULL_PU_PD_TYPE, /*17*/
+	MTK_PULL_PU_PD_TYPE, /*18*/
+	MTK_PULL_PU_PD_TYPE, /*19*/
+	MTK_PULL_PU_PD_TYPE, /*20*/
+	MTK_PULL_PU_PD_TYPE, /*21*/
+	MTK_PULL_PU_PD_TYPE, /*22*/
+	MTK_PULL_PU_PD_TYPE, /*23*/
+	MTK_PULL_PU_PD_TYPE, /*24*/
+	MTK_PULL_PU_PD_TYPE, /*25*/
+	MTK_PULL_PU_PD_TYPE, /*26*/
+	MTK_PULL_PU_PD_TYPE, /*27*/
+	MTK_PULL_PU_PD_TYPE, /*28*/
+	MTK_PULL_PU_PD_TYPE, /*29*/
+	MTK_PULL_PU_PD_TYPE, /*30*/
+	MTK_PULL_PU_PD_TYPE, /*31*/
+	MTK_PULL_PU_PD_TYPE, /*32*/
+	MTK_PULL_PU_PD_TYPE, /*33*/
+	MTK_PULL_PU_PD_TYPE, /*34*/
+	MTK_PULL_PU_PD_TYPE, /*35*/
+	MTK_PULL_PU_PD_TYPE, /*36*/
+	MTK_PULL_PU_PD_TYPE, /*37*/
+	MTK_PULL_PU_PD_TYPE, /*38*/
+	MTK_PULL_PU_PD_TYPE, /*39*/
+	MTK_PULL_PU_PD_TYPE, /*40*/
+	MTK_PULL_PU_PD_TYPE, /*41*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*42*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*43*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*44*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*45*/
+	MTK_PULL_PU_PD_TYPE, /*46*/
+	MTK_PULL_PU_PD_TYPE, /*47*/
+	MTK_PULL_PU_PD_TYPE, /*48*/
+	MTK_PULL_PU_PD_TYPE, /*49*/
+	MTK_PULL_PU_PD_TYPE, /*50*/
+	MTK_PULL_PU_PD_TYPE, /*51*/
+	MTK_PULL_PU_PD_TYPE, /*52*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*53*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*54*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*55*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*56*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*57*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*58*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*59*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*60*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*61*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*62*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*63*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*64*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*65*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*66*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*67*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*68*/
+	MTK_PULL_PU_PD_TYPE, /*69*/
+	MTK_PULL_PU_PD_TYPE, /*70*/
+	MTK_PULL_PU_PD_TYPE, /*71*/
+	MTK_PULL_PU_PD_TYPE, /*72*/
+	MTK_PULL_PU_PD_TYPE, /*73*/
+	MTK_PULL_PU_PD_TYPE, /*74*/
+	MTK_PULL_PU_PD_TYPE, /*75*/
+	MTK_PULL_PU_PD_TYPE, /*76*/
+	MTK_PULL_PU_PD_TYPE, /*77*/
+	MTK_PULL_PU_PD_TYPE, /*78*/
+	MTK_PULL_PU_PD_TYPE, /*79*/
+	MTK_PULL_PU_PD_TYPE, /*80*/
+	MTK_PULL_PU_PD_TYPE, /*81*/
+	MTK_PULL_PU_PD_TYPE, /*82*/
+	MTK_PULL_PU_PD_TYPE, /*83*/
+	MTK_PULL_PU_PD_TYPE, /*84*/
+	MTK_PULL_PU_PD_TYPE, /*85*/
+	MTK_PULL_PU_PD_TYPE, /*86*/
+	MTK_PULL_PU_PD_TYPE, /*87*/
+	MTK_PULL_PU_PD_TYPE, /*88*/
+	MTK_PULL_PU_PD_TYPE, /*89*/
+	MTK_PULL_PU_PD_TYPE, /*90*/
+	MTK_PULL_PU_PD_TYPE, /*91*/
+	MTK_PULL_PU_PD_TYPE, /*92*/
+	MTK_PULL_PU_PD_TYPE, /*93*/
+	MTK_PULL_PU_PD_TYPE, /*94*/
+	MTK_PULL_PU_PD_TYPE, /*95*/
+	MTK_PULL_PU_PD_TYPE, /*96*/
+	MTK_PULL_PU_PD_TYPE, /*97*/
+	MTK_PULL_PU_PD_TYPE, /*98*/
+	MTK_PULL_PU_PD_TYPE, /*99*/
+	MTK_PULL_PU_PD_TYPE, /*100*/
+	MTK_PULL_PU_PD_TYPE, /*101*/
+	MTK_PULL_PU_PD_TYPE, /*102*/
+	MTK_PULL_PU_PD_TYPE, /*103*/
+	MTK_PULL_PU_PD_TYPE, /*104*/
+	MTK_PULL_PU_PD_TYPE, /*105*/
+	MTK_PULL_PU_PD_TYPE, /*106*/
+	MTK_PULL_PU_PD_TYPE, /*107*/
+	MTK_PULL_PU_PD_TYPE, /*108*/
+	MTK_PULL_PU_PD_TYPE, /*109*/
+	MTK_PULL_PU_PD_TYPE, /*110*/
+	MTK_PULL_PU_PD_TYPE, /*111*/
+	MTK_PULL_PU_PD_TYPE, /*112*/
+	MTK_PULL_PU_PD_TYPE, /*113*/
+	MTK_PULL_PU_PD_TYPE, /*114*/
+	MTK_PULL_PU_PD_TYPE, /*115*/
+	MTK_PULL_PU_PD_TYPE, /*116*/
+	MTK_PULL_PU_PD_TYPE, /*117*/
+	MTK_PULL_PU_PD_TYPE, /*118*/
+	MTK_PULL_PU_PD_TYPE, /*119*/
+	MTK_PULL_PU_PD_TYPE, /*120*/
+	MTK_PULL_PU_PD_TYPE, /*121*/
+	MTK_PULL_PU_PD_TYPE, /*122*/
+	MTK_PULL_PU_PD_TYPE, /*123*/
+	MTK_PULL_PU_PD_TYPE, /*124*/
+	MTK_PULL_PU_PD_TYPE, /*125*/
+	MTK_PULL_PU_PD_TYPE, /*126*/
+	MTK_PULL_PU_PD_TYPE, /*127*/
+	MTK_PULL_PU_PD_TYPE, /*128*/
+	MTK_PULL_PU_PD_TYPE, /*129*/
+	MTK_PULL_PU_PD_TYPE, /*130*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*131*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*132*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*133*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*134*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*135*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*136*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*137*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*138*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*139*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*140*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*141*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*142*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*143*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*144*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*145*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*146*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*147*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*148*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*149*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*150*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*151*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*152*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*153*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*154*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*155*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*156*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*157*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*158*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*159*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*160*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*161*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*162*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*163*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*164*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*165*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*166*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*167*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*168*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*169*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*170*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*171*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*172*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*173*/
+	MTK_PULL_PUPD_R1R0_TYPE, /*174*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*175*/
+	MTK_PULL_PU_PD_RSEL_TYPE, /*176*/
+};
+
+static const struct mtk_pin_reg_calc mt8188_reg_cals[PINCTRL_PIN_REG_MAX] = {
+	[PINCTRL_PIN_REG_MODE]	= MTK_RANGE(mt8188_pin_mode_range),
+	[PINCTRL_PIN_REG_DIR]	= MTK_RANGE(mt8188_pin_dir_range),
+	[PINCTRL_PIN_REG_DI]	= MTK_RANGE(mt8188_pin_di_range),
+	[PINCTRL_PIN_REG_DO]	= MTK_RANGE(mt8188_pin_do_range),
+	[PINCTRL_PIN_REG_SMT]	= MTK_RANGE(mt8188_pin_smt_range),
+	[PINCTRL_PIN_REG_IES]	= MTK_RANGE(mt8188_pin_ies_range),
+	[PINCTRL_PIN_REG_TDSEL]	= MTK_RANGE(mt8188_pin_tdsel_range),
+	[PINCTRL_PIN_REG_RDSEL]	= MTK_RANGE(mt8188_pin_rdsel_range),
+	[PINCTRL_PIN_REG_PUPD]	= MTK_RANGE(mt8188_pin_pupd_range),
+	[PINCTRL_PIN_REG_R0]	= MTK_RANGE(mt8188_pin_r0_range),
+	[PINCTRL_PIN_REG_R1]	= MTK_RANGE(mt8188_pin_r1_range),
+	[PINCTRL_PIN_REG_PU]	= MTK_RANGE(mt8188_pin_pu_range),
+	[PINCTRL_PIN_REG_PD]	= MTK_RANGE(mt8188_pin_pd_range),
+	[PINCTRL_PIN_REG_DRV]	= MTK_RANGE(mt8188_pin_drv_range),
+	[PINCTRL_PIN_REG_DRV_ADV]	= MTK_RANGE(mt8188_pin_drv_adv_range),
+	[PINCTRL_PIN_REG_RSEL]	= MTK_RANGE(mt8188_pin_rsel_range),
+};
+
+static const char * const mt8188_pinctrl_register_base_name[] = {
+	"iocfg0", "iocfg_rm", "iocfg_lt", "iocfg_lm", "iocfg_rt",
+};
+
+static const struct mtk_eint_hw mt8188_eint_hw = {
+	.port_mask = 0xf,
+	.ports     = 7,
+	.ap_num    = 225,
+	.db_cnt    = 32,
+};
+
+static const struct mtk_pin_soc mt8188_data = {
+	.reg_cal	= mt8188_reg_cals,
+	.pins	= mtk_pins_mt8188,
+	.npins	= ARRAY_SIZE(mtk_pins_mt8188),
+	.ngrps	= ARRAY_SIZE(mtk_pins_mt8188),
+	.eint_hw	= &mt8188_eint_hw,
+	.nfuncs	= 8,
+	.gpio_m	= 0,
+	.base_names	= mt8188_pinctrl_register_base_name,
+	.nbase_names	= ARRAY_SIZE(mt8188_pinctrl_register_base_name),
+	.bias_set_combo	= mtk_pinconf_bias_set_combo,
+	.pull_type = mt8188_pull_type,
+	.pin_rsel = mt8188_pin_rsel_val_range,
+	.npin_rsel = ARRAY_SIZE(mt8188_pin_rsel_val_range),
+	.bias_get_combo	= mtk_pinconf_bias_get_combo,
+	.drive_set	= mtk_pinconf_drive_set_rev1,
+	.drive_get	= mtk_pinconf_drive_get_rev1,
+	.adv_drive_set	= mtk_pinconf_adv_drive_set_raw,
+	.adv_drive_get	= mtk_pinconf_adv_drive_get_raw,
+};
+
+static const struct of_device_id mt8188_pinctrl_of_match[] = {
+	{ .compatible = "mediatek,mt8188-pinctrl", .data = &mt8188_data },
+	{ }
+};
+
+static struct platform_driver mt8188_pinctrl_driver = {
+	.driver = {
+		.name = "mt8188-pinctrl",
+		.of_match_table = mt8188_pinctrl_of_match,
+		.pm = &mtk_paris_pinctrl_pm_ops
+	},
+	.probe = mtk_paris_pinctrl_probe,
+};
+
+static int __init mt8188_pinctrl_init(void)
+{
+	return platform_driver_register(&mt8188_pinctrl_driver);
+}
+
+arch_initcall(mt8188_pinctrl_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek MT8188 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h
new file mode 100644
index 000000000000..26679b50e2c4
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8188.h
@@ -0,0 +1,2260 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ * Auther: Hui Liu <hui.liu@mediatek.com>
+ *
+ */
+
+#ifndef __PINCTRL_MTK_MT8188_H
+#define __PINCTRL_MTK_MT8188_H
+
+#include "pinctrl-paris.h"
+
+static const struct mtk_pin_desc mtk_pins_mt8188[] = {
+
+	MTK_PIN(
+		0, "GPIO0",
+		MTK_EINT_FUNCTION(0, 0),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO0"),
+		MTK_FUNCTION(1, "B0_TP_GPIO0_AO"),
+		MTK_FUNCTION(2, "O_SPIM5_CSB"),
+		MTK_FUNCTION(3, "O_UTXD1"),
+		MTK_FUNCTION(4, "O_DMIC3_CLK"),
+		MTK_FUNCTION(5, "B0_I2SIN_MCK"),
+		MTK_FUNCTION(6, "O_I2SO2_MCK"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A0")
+	),
+
+	MTK_PIN(
+		1, "GPIO1",
+		MTK_EINT_FUNCTION(0, 1),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO1"),
+		MTK_FUNCTION(1, "B0_TP_GPIO1_AO"),
+		MTK_FUNCTION(2, "O_SPIM5_CLK"),
+		MTK_FUNCTION(3, "I1_URXD1"),
+		MTK_FUNCTION(4, "I0_DMIC3_DAT"),
+		MTK_FUNCTION(5, "B0_I2SIN_BCK"),
+		MTK_FUNCTION(6, "B0_I2SO2_BCK"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A1")
+	),
+
+	MTK_PIN(
+		2, "GPIO2",
+		MTK_EINT_FUNCTION(0, 2),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO2"),
+		MTK_FUNCTION(1, "B0_TP_GPIO2_AO"),
+		MTK_FUNCTION(2, "B0_SPIM5_MOSI"),
+		MTK_FUNCTION(3, "O_URTS1"),
+		MTK_FUNCTION(4, "I0_DMIC3_DAT_R"),
+		MTK_FUNCTION(5, "B0_I2SIN_WS"),
+		MTK_FUNCTION(6, "B0_I2SO2_WS"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A2")
+	),
+
+	MTK_PIN(
+		3, "GPIO3",
+		MTK_EINT_FUNCTION(0, 3),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO3"),
+		MTK_FUNCTION(1, "B0_TP_GPIO3_AO"),
+		MTK_FUNCTION(2, "B0_SPIM5_MISO"),
+		MTK_FUNCTION(3, "I1_UCTS1"),
+		MTK_FUNCTION(4, "O_DMIC4_CLK"),
+		MTK_FUNCTION(5, "I0_I2SIN_D0"),
+		MTK_FUNCTION(6, "O_I2SO2_D0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A3")
+	),
+
+	MTK_PIN(
+		4, "GPIO4",
+		MTK_EINT_FUNCTION(0, 4),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO4"),
+		MTK_FUNCTION(1, "B0_TP_GPIO4_AO"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN2"),
+		MTK_FUNCTION(3, "O_I2SO1_MCK"),
+		MTK_FUNCTION(4, "I0_DMIC4_DAT"),
+		MTK_FUNCTION(5, "I0_I2SIN_D1"),
+		MTK_FUNCTION(6, "O_I2SO2_D1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A4")
+	),
+
+	MTK_PIN(
+		5, "GPIO5",
+		MTK_EINT_FUNCTION(0, 5),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO5"),
+		MTK_FUNCTION(1, "B0_TP_GPIO5_AO"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN1"),
+		MTK_FUNCTION(3, "O_I2SO1_BCK"),
+		MTK_FUNCTION(4, "I0_DMIC4_DAT_R"),
+		MTK_FUNCTION(5, "I0_I2SIN_D2"),
+		MTK_FUNCTION(6, "O_I2SO2_D2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A5")
+	),
+
+	MTK_PIN(
+		6, "GPIO6",
+		MTK_EINT_FUNCTION(0, 6),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO6"),
+		MTK_FUNCTION(1, "B0_TP_GPIO6_AO"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN0"),
+		MTK_FUNCTION(3, "O_I2SO1_WS"),
+		MTK_FUNCTION(4, "O_DMIC1_CLK"),
+		MTK_FUNCTION(5, "I0_I2SIN_D3"),
+		MTK_FUNCTION(6, "O_I2SO2_D3"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO0")
+	),
+
+	MTK_PIN(
+		7, "GPIO7",
+		MTK_EINT_FUNCTION(0, 7),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO7"),
+		MTK_FUNCTION(1, "B0_TP_GPIO7_AO"),
+		MTK_FUNCTION(2, "O_SPIM3_CSB"),
+		MTK_FUNCTION(3, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(4, "I0_DMIC1_DAT"),
+		MTK_FUNCTION(5, "O_CMVREF0"),
+		MTK_FUNCTION(6, "O_CLKM0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A6")
+	),
+
+	MTK_PIN(
+		8, "GPIO8",
+		MTK_EINT_FUNCTION(0, 8),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO8"),
+		MTK_FUNCTION(1, "B0_TP_GPIO0_AO"),
+		MTK_FUNCTION(2, "O_SPIM3_CLK"),
+		MTK_FUNCTION(3, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(4, "I0_DMIC1_DAT_R"),
+		MTK_FUNCTION(5, "O_CMVREF1"),
+		MTK_FUNCTION(6, "O_CLKM1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A7")
+	),
+
+	MTK_PIN(
+		9, "GPIO9",
+		MTK_EINT_FUNCTION(0, 9),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO9"),
+		MTK_FUNCTION(1, "B0_TP_GPIO1_AO"),
+		MTK_FUNCTION(2, "B0_SPIM3_MOSI"),
+		MTK_FUNCTION(3, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(4, "O_DMIC2_CLK"),
+		MTK_FUNCTION(5, "O_CMFLASH0"),
+		MTK_FUNCTION(6, "O_PWM_0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A8")
+	),
+
+	MTK_PIN(
+		10, "GPIO10",
+		MTK_EINT_FUNCTION(0, 10),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO10"),
+		MTK_FUNCTION(1, "B0_TP_GPIO2_AO"),
+		MTK_FUNCTION(2, "B0_SPIM3_MISO"),
+		MTK_FUNCTION(3, "I0_TDMIN_DI"),
+		MTK_FUNCTION(4, "I0_DMIC2_DAT"),
+		MTK_FUNCTION(5, "O_CMFLASH1"),
+		MTK_FUNCTION(6, "O_PWM_1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A9")
+	),
+
+	MTK_PIN(
+		11, "GPIO11",
+		MTK_EINT_FUNCTION(0, 11),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO11"),
+		MTK_FUNCTION(1, "B0_TP_GPIO3_AO"),
+		MTK_FUNCTION(2, "O_SPDIF_OUT"),
+		MTK_FUNCTION(3, "O_I2SO1_D0"),
+		MTK_FUNCTION(4, "I0_DMIC2_DAT_R"),
+		MTK_FUNCTION(5, "I0_DVFSRC_EXT_REQ"),
+		MTK_FUNCTION(6, "O_CMVREF6"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A10")
+	),
+
+	MTK_PIN(
+		12, "GPIO12",
+		MTK_EINT_FUNCTION(0, 12),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO12"),
+		MTK_FUNCTION(1, "B0_TP_GPIO4_AO"),
+		MTK_FUNCTION(2, "O_SPIM4_CSB"),
+		MTK_FUNCTION(3, "B1_JTMS_SEL3"),
+		MTK_FUNCTION(4, "B1_APU_JTAG_TMS"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TMS"),
+		MTK_FUNCTION(6, "I0_IPU_JTAG_TMS"),
+		MTK_FUNCTION(7, "I0_HDMITX20_HTPLG")
+	),
+
+	MTK_PIN(
+		13, "GPIO13",
+		MTK_EINT_FUNCTION(0, 13),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO13"),
+		MTK_FUNCTION(1, "B0_TP_GPIO5_AO"),
+		MTK_FUNCTION(2, "O_SPIM4_CLK"),
+		MTK_FUNCTION(3, "I0_JTCK_SEL3"),
+		MTK_FUNCTION(4, "I0_APU_JTAG_TCK"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TCK"),
+		MTK_FUNCTION(6, "I0_IPU_JTAG_TCK"),
+		MTK_FUNCTION(7, "B1_HDMITX20_CEC")
+	),
+
+	MTK_PIN(
+		14, "GPIO14",
+		MTK_EINT_FUNCTION(0, 14),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO14"),
+		MTK_FUNCTION(1, "B0_TP_GPIO6_AO"),
+		MTK_FUNCTION(2, "B0_SPIM4_MOSI"),
+		MTK_FUNCTION(3, "I1_JTDI_SEL3"),
+		MTK_FUNCTION(4, "I1_APU_JTAG_TDI"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TDI"),
+		MTK_FUNCTION(6, "I0_IPU_JTAG_TDI"),
+		MTK_FUNCTION(7, "B1_HDMITX20_SCL")
+	),
+
+	MTK_PIN(
+		15, "GPIO15",
+		MTK_EINT_FUNCTION(0, 15),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO15"),
+		MTK_FUNCTION(1, "B0_TP_GPIO7_AO"),
+		MTK_FUNCTION(2, "B0_SPIM4_MISO"),
+		MTK_FUNCTION(3, "O_JTDO_SEL3"),
+		MTK_FUNCTION(4, "O_APU_JTAG_TDO"),
+		MTK_FUNCTION(5, "O_VPU_UDI_TDO"),
+		MTK_FUNCTION(6, "O_IPU_JTAG_TDO"),
+		MTK_FUNCTION(7, "B1_HDMITX20_SDA")
+	),
+
+	MTK_PIN(
+		16, "GPIO16",
+		MTK_EINT_FUNCTION(0, 16),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO16"),
+		MTK_FUNCTION(1, "B0_TP_GPIO0_AO"),
+		MTK_FUNCTION(2, "O_UTXD3"),
+		MTK_FUNCTION(3, "I1_JTRSTn_SEL3"),
+		MTK_FUNCTION(4, "I0_APU_JTAG_TRST"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_NTRST"),
+		MTK_FUNCTION(6, "I0_IPU_JTAG_TRST"),
+		MTK_FUNCTION(7, "O_HDMITX20_PWR5V")
+	),
+
+	MTK_PIN(
+		17, "GPIO17",
+		MTK_EINT_FUNCTION(0, 17),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO17"),
+		MTK_FUNCTION(1, "B0_TP_GPIO1_AO"),
+		MTK_FUNCTION(2, "I1_URXD3"),
+		MTK_FUNCTION(3, "O_CMFLASH2"),
+		MTK_FUNCTION(4, "I0_EDP_TX_HPD"),
+		MTK_FUNCTION(5, "I0_DVFSRC_EXT_REQ"),
+		MTK_FUNCTION(6, "O_CMVREF7"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO1")
+	),
+
+	MTK_PIN(
+		18, "GPIO18",
+		MTK_EINT_FUNCTION(0, 18),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO18"),
+		MTK_FUNCTION(1, "B0_TP_GPIO2_AO"),
+		MTK_FUNCTION(2, "O_CMFLASH0"),
+		MTK_FUNCTION(3, "O_CMVREF4"),
+		MTK_FUNCTION(4, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(5, "O_UTXD1"),
+		MTK_FUNCTION(6, "O_TP_UTXD1_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A11")
+	),
+
+	MTK_PIN(
+		19, "GPIO19",
+		MTK_EINT_FUNCTION(0, 19),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO19"),
+		MTK_FUNCTION(1, "B0_TP_GPIO3_AO"),
+		MTK_FUNCTION(2, "O_CMFLASH1"),
+		MTK_FUNCTION(3, "O_CMVREF5"),
+		MTK_FUNCTION(4, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(5, "I1_URXD1"),
+		MTK_FUNCTION(6, "I1_TP_URXD1_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A12")
+	),
+
+	MTK_PIN(
+		20, "GPIO20",
+		MTK_EINT_FUNCTION(0, 20),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO20"),
+		MTK_FUNCTION(1, "B0_TP_GPIO4_AO"),
+		MTK_FUNCTION(2, "O_CMFLASH2"),
+		MTK_FUNCTION(3, "O_CLKM2"),
+		MTK_FUNCTION(4, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(5, "O_URTS1"),
+		MTK_FUNCTION(6, "O_TP_URTS1_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A13")
+	),
+
+	MTK_PIN(
+		21, "GPIO21",
+		MTK_EINT_FUNCTION(0, 21),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO21"),
+		MTK_FUNCTION(1, "B0_TP_GPIO5_AO"),
+		MTK_FUNCTION(2, "O_CMFLASH3"),
+		MTK_FUNCTION(3, "O_CLKM3"),
+		MTK_FUNCTION(4, "I0_TDMIN_DI"),
+		MTK_FUNCTION(5, "I1_UCTS1"),
+		MTK_FUNCTION(6, "I1_TP_UCTS1_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A14")
+	),
+
+	MTK_PIN(
+		22, "GPIO22",
+		MTK_EINT_FUNCTION(0, 22),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO22"),
+		MTK_FUNCTION(1, "O_CMMCLK0"),
+		MTK_FUNCTION(5, "B0_TP_GPIO6_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A15")
+	),
+
+	MTK_PIN(
+		23, "GPIO23",
+		MTK_EINT_FUNCTION(0, 23),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO23"),
+		MTK_FUNCTION(1, "O_CMMCLK1"),
+		MTK_FUNCTION(3, "O_PWM_2"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SCL"),
+		MTK_FUNCTION(5, "B0_TP_GPIO7_AO"),
+		MTK_FUNCTION(6, "I0_DP_TX_HPD"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A16")
+	),
+
+	MTK_PIN(
+		24, "GPIO24",
+		MTK_EINT_FUNCTION(0, 24),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO24"),
+		MTK_FUNCTION(1, "O_CMMCLK2"),
+		MTK_FUNCTION(3, "O_PWM_3"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SDA"),
+		MTK_FUNCTION(5, "I0_DVFSRC_EXT_REQ"),
+		MTK_FUNCTION(6, "I0_EDP_TX_HPD"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO2")
+	),
+
+	MTK_PIN(
+		25, "GPIO25",
+		MTK_EINT_FUNCTION(0, 25),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO25"),
+		MTK_FUNCTION(1, "O_LCM_RST"),
+		MTK_FUNCTION(2, "O_LCM1_RST"),
+		MTK_FUNCTION(3, "I0_DP_TX_HPD")
+	),
+
+	MTK_PIN(
+		26, "GPIO26",
+		MTK_EINT_FUNCTION(0, 26),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO26"),
+		MTK_FUNCTION(1, "I0_DSI_TE"),
+		MTK_FUNCTION(2, "I0_DSI1_TE"),
+		MTK_FUNCTION(3, "I0_EDP_TX_HPD")
+	),
+
+	MTK_PIN(
+		27, "GPIO27",
+		MTK_EINT_FUNCTION(0, 27),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO27"),
+		MTK_FUNCTION(1, "O_LCM1_RST"),
+		MTK_FUNCTION(2, "O_LCM_RST"),
+		MTK_FUNCTION(3, "I0_DP_TX_HPD"),
+		MTK_FUNCTION(4, "O_CMVREF2"),
+		MTK_FUNCTION(5, "O_mbistwriteen_trigger"),
+		MTK_FUNCTION(6, "O_PWM_2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A17")
+	),
+
+	MTK_PIN(
+		28, "GPIO28",
+		MTK_EINT_FUNCTION(0, 28),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO28"),
+		MTK_FUNCTION(1, "I0_DSI1_TE"),
+		MTK_FUNCTION(2, "I0_DSI_TE"),
+		MTK_FUNCTION(3, "I0_EDP_TX_HPD"),
+		MTK_FUNCTION(4, "O_CMVREF3"),
+		MTK_FUNCTION(5, "O_mbistreaden_trigger"),
+		MTK_FUNCTION(6, "O_PWM_3"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A18")
+	),
+
+	MTK_PIN(
+		29, "GPIO29",
+		MTK_EINT_FUNCTION(0, 29),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO29"),
+		MTK_FUNCTION(1, "O_DISP_PWM0"),
+		MTK_FUNCTION(2, "O_DISP_PWM1")
+	),
+
+	MTK_PIN(
+		30, "GPIO30",
+		MTK_EINT_FUNCTION(0, 30),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO30"),
+		MTK_FUNCTION(1, "O_DISP_PWM1"),
+		MTK_FUNCTION(2, "O_DISP_PWM0"),
+		MTK_FUNCTION(3, "O_CMFLASH3"),
+		MTK_FUNCTION(4, "O_PWM_1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A19")
+	),
+
+	MTK_PIN(
+		31, "GPIO31",
+		MTK_EINT_FUNCTION(0, 31),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO31"),
+		MTK_FUNCTION(1, "O_UTXD0"),
+		MTK_FUNCTION(2, "O_TP_UTXD1_AO"),
+		MTK_FUNCTION(3, "O_ADSP_UTXD0"),
+		MTK_FUNCTION(4, "O_TP_UTXD2_AO"),
+		MTK_FUNCTION(5, "O_MD32_0_TXD"),
+		MTK_FUNCTION(6, "O_MD32_1_TXD"),
+		MTK_FUNCTION(7, "O_SSPM_UTXD_AO")
+	),
+
+	MTK_PIN(
+		32, "GPIO32",
+		MTK_EINT_FUNCTION(0, 32),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO32"),
+		MTK_FUNCTION(1, "I1_URXD0"),
+		MTK_FUNCTION(2, "I1_TP_URXD1_AO"),
+		MTK_FUNCTION(3, "I1_ADSP_URXD0"),
+		MTK_FUNCTION(4, "I1_TP_URXD2_AO"),
+		MTK_FUNCTION(5, "I1_MD32_0_RXD"),
+		MTK_FUNCTION(6, "I1_MD32_1_RXD"),
+		MTK_FUNCTION(7, "I1_SSPM_URXD_AO")
+	),
+
+	MTK_PIN(
+		33, "GPIO33",
+		MTK_EINT_FUNCTION(0, 33),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO33"),
+		MTK_FUNCTION(1, "O_UTXD1"),
+		MTK_FUNCTION(2, "O_URTS2"),
+		MTK_FUNCTION(3, "O_ADSP_UTXD0"),
+		MTK_FUNCTION(4, "O_TP_UTXD1_AO"),
+		MTK_FUNCTION(5, "O_mbistwriteen_trigger"),
+		MTK_FUNCTION(6, "O_MD32_0_TXD"),
+		MTK_FUNCTION(7, "O_SSPM_UTXD_AO")
+	),
+
+	MTK_PIN(
+		34, "GPIO34",
+		MTK_EINT_FUNCTION(0, 34),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO34"),
+		MTK_FUNCTION(1, "I1_URXD1"),
+		MTK_FUNCTION(2, "I1_UCTS2"),
+		MTK_FUNCTION(3, "I1_ADSP_URXD0"),
+		MTK_FUNCTION(4, "I1_TP_URXD1_AO"),
+		MTK_FUNCTION(5, "O_mbistreaden_trigger"),
+		MTK_FUNCTION(6, "I1_MD32_0_RXD"),
+		MTK_FUNCTION(7, "I1_SSPM_URXD_AO")
+	),
+
+	MTK_PIN(
+		35, "GPIO35",
+		MTK_EINT_FUNCTION(0, 35),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO35"),
+		MTK_FUNCTION(1, "O_UTXD2"),
+		MTK_FUNCTION(2, "O_URTS1"),
+		MTK_FUNCTION(3, "O_ADSP_UTXD0"),
+		MTK_FUNCTION(4, "O_TP_URTS1_AO"),
+		MTK_FUNCTION(5, "O_TP_UTXD2_AO"),
+		MTK_FUNCTION(6, "O_MD32_1_TXD"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A20")
+	),
+
+	MTK_PIN(
+		36, "GPIO36",
+		MTK_EINT_FUNCTION(0, 36),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO36"),
+		MTK_FUNCTION(1, "I1_URXD2"),
+		MTK_FUNCTION(2, "I1_UCTS1"),
+		MTK_FUNCTION(3, "I1_ADSP_URXD0"),
+		MTK_FUNCTION(4, "I1_TP_UCTS1_AO"),
+		MTK_FUNCTION(5, "I1_TP_URXD2_AO"),
+		MTK_FUNCTION(6, "I1_MD32_1_RXD"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A21")
+	),
+
+	MTK_PIN(
+		37, "GPIO37",
+		MTK_EINT_FUNCTION(0, 37),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO37"),
+		MTK_FUNCTION(1, "B1_JTMS_SEL1"),
+		MTK_FUNCTION(2, "I0_UDI_TMS"),
+		MTK_FUNCTION(3, "I1_SPM_JTAG_TMS"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TMS"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TMS"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TMS"),
+		MTK_FUNCTION(7, "I1_MCUPM_JTAG_TMS")
+	),
+
+	MTK_PIN(
+		38, "GPIO38",
+		MTK_EINT_FUNCTION(0, 38),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO38"),
+		MTK_FUNCTION(1, "I0_JTCK_SEL1"),
+		MTK_FUNCTION(2, "I0_UDI_TCK"),
+		MTK_FUNCTION(3, "I1_SPM_JTAG_TCK"),
+		MTK_FUNCTION(4, "I0_ADSP_JTAG0_TCK"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TCK"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TCK"),
+		MTK_FUNCTION(7, "I1_MCUPM_JTAG_TCK")
+	),
+
+	MTK_PIN(
+		39, "GPIO39",
+		MTK_EINT_FUNCTION(0, 39),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO39"),
+		MTK_FUNCTION(1, "I1_JTDI_SEL1"),
+		MTK_FUNCTION(2, "I0_UDI_TDI"),
+		MTK_FUNCTION(3, "I1_SPM_JTAG_TDI"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TDI"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TDI"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TDI"),
+		MTK_FUNCTION(7, "I1_MCUPM_JTAG_TDI")
+	),
+
+	MTK_PIN(
+		40, "GPIO40",
+		MTK_EINT_FUNCTION(0, 40),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO40"),
+		MTK_FUNCTION(1, "O_JTDO_SEL1"),
+		MTK_FUNCTION(2, "O_UDI_TDO"),
+		MTK_FUNCTION(3, "O_SPM_JTAG_TDO"),
+		MTK_FUNCTION(4, "O_ADSP_JTAG0_TDO"),
+		MTK_FUNCTION(5, "O_SCP_JTAG0_TDO"),
+		MTK_FUNCTION(6, "O_CCU0_JTAG_TDO"),
+		MTK_FUNCTION(7, "O_MCUPM_JTAG_TDO")
+	),
+
+	MTK_PIN(
+		41, "GPIO41",
+		MTK_EINT_FUNCTION(0, 41),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO41"),
+		MTK_FUNCTION(1, "I1_JTRSTn_SEL1"),
+		MTK_FUNCTION(2, "I0_UDI_NTRST"),
+		MTK_FUNCTION(3, "I0_SPM_JTAG_TRSTN"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TRSTN"),
+		MTK_FUNCTION(5, "I0_SCP_JTAG0_TRSTN"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TRST"),
+		MTK_FUNCTION(7, "I0_MCUPM_JTAG_TRSTN")
+	),
+
+	MTK_PIN(
+		42, "GPIO42",
+		MTK_EINT_FUNCTION(0, 42),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO42"),
+		MTK_FUNCTION(1, "B1_KPCOL0")
+	),
+
+	MTK_PIN(
+		43, "GPIO43",
+		MTK_EINT_FUNCTION(0, 43),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO43"),
+		MTK_FUNCTION(1, "B1_KPCOL1"),
+		MTK_FUNCTION(2, "I0_DP_TX_HPD"),
+		MTK_FUNCTION(3, "O_CMFLASH2"),
+		MTK_FUNCTION(4, "I0_DVFSRC_EXT_REQ"),
+		MTK_FUNCTION(7, "O_mbistwriteen_trigger")
+	),
+
+	MTK_PIN(
+		44, "GPIO44",
+		MTK_EINT_FUNCTION(0, 44),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO44"),
+		MTK_FUNCTION(1, "B1_KPROW0")
+	),
+
+	MTK_PIN(
+		45, "GPIO45",
+		MTK_EINT_FUNCTION(0, 45),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO45"),
+		MTK_FUNCTION(1, "B1_KPROW1"),
+		MTK_FUNCTION(2, "I0_EDP_TX_HPD"),
+		MTK_FUNCTION(3, "O_CMFLASH3"),
+		MTK_FUNCTION(4, "B0_I2SIN_MCK"),
+		MTK_FUNCTION(7, "O_mbistreaden_trigger")
+	),
+
+	MTK_PIN(
+		46, "GPIO46",
+		MTK_EINT_FUNCTION(0, 46),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO46"),
+		MTK_FUNCTION(1, "I0_DP_TX_HPD"),
+		MTK_FUNCTION(2, "O_PWM_0"),
+		MTK_FUNCTION(3, "I0_VBUSVALID_2P"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A22")
+	),
+
+	MTK_PIN(
+		47, "GPIO47",
+		MTK_EINT_FUNCTION(0, 47),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO47"),
+		MTK_FUNCTION(1, "I1_WAKEN"),
+		MTK_FUNCTION(6, "O_GDU_TROOPS_DET0")
+	),
+
+	MTK_PIN(
+		48, "GPIO48",
+		MTK_EINT_FUNCTION(0, 48),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO48"),
+		MTK_FUNCTION(1, "O_PERSTN"),
+		MTK_FUNCTION(6, "O_GDU_TROOPS_DET1")
+	),
+
+	MTK_PIN(
+		49, "GPIO49",
+		MTK_EINT_FUNCTION(0, 49),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO49"),
+		MTK_FUNCTION(1, "B1_CLKREQN"),
+		MTK_FUNCTION(6, "O_GDU_TROOPS_DET2")
+	),
+
+	MTK_PIN(
+		50, "GPIO50",
+		MTK_EINT_FUNCTION(0, 50),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO50"),
+		MTK_FUNCTION(1, "O_HDMITX20_PWR5V"),
+		MTK_FUNCTION(3, "I1_IDDIG_1P"),
+		MTK_FUNCTION(4, "I1_SCP_JTAG1_TMS"),
+		MTK_FUNCTION(5, "I1_SSPM_JTAG_TMS"),
+		MTK_FUNCTION(6, "I1_MD32_0_JTAG_TMS"),
+		MTK_FUNCTION(7, "I1_MD32_1_JTAG_TMS")
+	),
+
+	MTK_PIN(
+		51, "GPIO51",
+		MTK_EINT_FUNCTION(0, 51),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO51"),
+		MTK_FUNCTION(1, "I0_HDMITX20_HTPLG"),
+		MTK_FUNCTION(2, "I0_EDP_TX_HPD"),
+		MTK_FUNCTION(3, "O_USB_DRVVBUS_1P"),
+		MTK_FUNCTION(4, "I1_SCP_JTAG1_TCK"),
+		MTK_FUNCTION(5, "I1_SSPM_JTAG_TCK"),
+		MTK_FUNCTION(6, "I1_MD32_0_JTAG_TCK"),
+		MTK_FUNCTION(7, "I1_MD32_1_JTAG_TCK")
+	),
+
+	MTK_PIN(
+		52, "GPIO52",
+		MTK_EINT_FUNCTION(0, 52),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO52"),
+		MTK_FUNCTION(1, "B1_HDMITX20_CEC"),
+		MTK_FUNCTION(3, "I0_VBUSVALID_1P"),
+		MTK_FUNCTION(4, "I1_SCP_JTAG1_TDI"),
+		MTK_FUNCTION(5, "I1_SSPM_JTAG_TDI"),
+		MTK_FUNCTION(6, "I1_MD32_0_JTAG_TDI"),
+		MTK_FUNCTION(7, "I1_MD32_1_JTAG_TDI")
+	),
+
+	MTK_PIN(
+		53, "GPIO53",
+		MTK_EINT_FUNCTION(0, 53),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO53"),
+		MTK_FUNCTION(1, "B1_HDMITX20_SCL"),
+		MTK_FUNCTION(3, "I1_IDDIG_2P"),
+		MTK_FUNCTION(4, "O_SCP_JTAG1_TDO"),
+		MTK_FUNCTION(5, "O_SSPM_JTAG_TDO"),
+		MTK_FUNCTION(6, "O_MD32_0_JTAG_TDO"),
+		MTK_FUNCTION(7, "O_MD32_1_JTAG_TDO")
+	),
+
+	MTK_PIN(
+		54, "GPIO54",
+		MTK_EINT_FUNCTION(0, 54),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO54"),
+		MTK_FUNCTION(1, "B1_HDMITX20_SDA"),
+		MTK_FUNCTION(3, "O_USB_DRVVBUS_2P"),
+		MTK_FUNCTION(4, "I0_SCP_JTAG1_TRSTN"),
+		MTK_FUNCTION(5, "I0_SSPM_JTAG_TRSTN"),
+		MTK_FUNCTION(6, "I1_MD32_0_JTAG_TRST"),
+		MTK_FUNCTION(7, "I1_MD32_1_JTAG_TRST")
+	),
+
+	MTK_PIN(
+		55, "GPIO55",
+		MTK_EINT_FUNCTION(0, 55),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO55"),
+		MTK_FUNCTION(1, "B1_SCL0"),
+		MTK_FUNCTION(2, "B1_SCP_SCL0"),
+		MTK_FUNCTION(3, "B1_SCP_SCL1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SCL")
+	),
+
+	MTK_PIN(
+		56, "GPIO56",
+		MTK_EINT_FUNCTION(0, 56),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO56"),
+		MTK_FUNCTION(1, "B1_SDA0"),
+		MTK_FUNCTION(2, "B1_SCP_SDA0"),
+		MTK_FUNCTION(3, "B1_SCP_SDA1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SDA")
+	),
+
+	MTK_PIN(
+		57, "GPIO57",
+		MTK_EINT_FUNCTION(0, 57),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO57"),
+		MTK_FUNCTION(1, "B1_SCL1")
+	),
+
+	MTK_PIN(
+		58, "GPIO58",
+		MTK_EINT_FUNCTION(0, 58),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO58"),
+		MTK_FUNCTION(1, "B1_SDA1")
+	),
+
+	MTK_PIN(
+		59, "GPIO59",
+		MTK_EINT_FUNCTION(0, 59),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO59"),
+		MTK_FUNCTION(1, "B1_SCL2"),
+		MTK_FUNCTION(2, "B1_SCP_SCL0"),
+		MTK_FUNCTION(3, "B1_SCP_SCL1")
+	),
+
+	MTK_PIN(
+		60, "GPIO60",
+		MTK_EINT_FUNCTION(0, 60),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO60"),
+		MTK_FUNCTION(1, "B1_SDA2"),
+		MTK_FUNCTION(2, "B1_SCP_SDA0"),
+		MTK_FUNCTION(3, "B1_SCP_SDA1")
+	),
+
+	MTK_PIN(
+		61, "GPIO61",
+		MTK_EINT_FUNCTION(0, 61),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO61"),
+		MTK_FUNCTION(1, "B1_SCL3"),
+		MTK_FUNCTION(2, "B1_SCP_SCL0"),
+		MTK_FUNCTION(3, "B1_SCP_SCL1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SCL")
+	),
+
+	MTK_PIN(
+		62, "GPIO62",
+		MTK_EINT_FUNCTION(0, 62),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO62"),
+		MTK_FUNCTION(1, "B1_SDA3"),
+		MTK_FUNCTION(2, "B1_SCP_SDA0"),
+		MTK_FUNCTION(3, "B1_SCP_SDA1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SDA")
+	),
+
+	MTK_PIN(
+		63, "GPIO63",
+		MTK_EINT_FUNCTION(0, 63),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO63"),
+		MTK_FUNCTION(1, "B1_SCL4")
+	),
+
+	MTK_PIN(
+		64, "GPIO64",
+		MTK_EINT_FUNCTION(0, 64),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO64"),
+		MTK_FUNCTION(1, "B1_SDA4")
+	),
+
+	MTK_PIN(
+		65, "GPIO65",
+		MTK_EINT_FUNCTION(0, 65),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO65"),
+		MTK_FUNCTION(1, "B1_SCL5"),
+		MTK_FUNCTION(2, "B1_SCP_SCL0"),
+		MTK_FUNCTION(3, "B1_SCP_SCL1")
+	),
+
+	MTK_PIN(
+		66, "GPIO66",
+		MTK_EINT_FUNCTION(0, 66),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO66"),
+		MTK_FUNCTION(1, "B1_SDA5"),
+		MTK_FUNCTION(2, "B1_SCP_SDA0"),
+		MTK_FUNCTION(3, "B1_SCP_SDA1")
+	),
+
+	MTK_PIN(
+		67, "GPIO67",
+		MTK_EINT_FUNCTION(0, 67),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO67"),
+		MTK_FUNCTION(1, "B1_SCL6"),
+		MTK_FUNCTION(2, "B1_SCP_SCL0"),
+		MTK_FUNCTION(3, "B1_SCP_SCL1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SCL")
+	),
+
+	MTK_PIN(
+		68, "GPIO68",
+		MTK_EINT_FUNCTION(0, 68),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO68"),
+		MTK_FUNCTION(1, "B1_SDA6"),
+		MTK_FUNCTION(2, "B1_SCP_SDA0"),
+		MTK_FUNCTION(3, "B1_SCP_SDA1"),
+		MTK_FUNCTION(4, "B1_PCIE_PHY_I2C_SDA")
+	),
+
+	MTK_PIN(
+		69, "GPIO69",
+		MTK_EINT_FUNCTION(0, 69),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO69"),
+		MTK_FUNCTION(1, "O_SPIM0_CSB"),
+		MTK_FUNCTION(2, "O_SCP_SPI0_CS"),
+		MTK_FUNCTION(3, "O_DMIC3_CLK"),
+		MTK_FUNCTION(4, "B0_MD32_1_GPIO0"),
+		MTK_FUNCTION(5, "O_CMVREF0"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP0_0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A23")
+	),
+
+	MTK_PIN(
+		70, "GPIO70",
+		MTK_EINT_FUNCTION(0, 70),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO70"),
+		MTK_FUNCTION(1, "O_SPIM0_CLK"),
+		MTK_FUNCTION(2, "O_SCP_SPI0_CK"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT"),
+		MTK_FUNCTION(4, "B0_MD32_1_GPIO1"),
+		MTK_FUNCTION(5, "O_CMVREF1"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP0_1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A24")
+	),
+
+	MTK_PIN(
+		71, "GPIO71",
+		MTK_EINT_FUNCTION(0, 71),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO71"),
+		MTK_FUNCTION(1, "B0_SPIM0_MOSI"),
+		MTK_FUNCTION(2, "O_SCP_SPI0_MO"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT_R"),
+		MTK_FUNCTION(4, "B0_MD32_1_GPIO2"),
+		MTK_FUNCTION(5, "O_CMVREF2"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP0_2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A25")
+	),
+
+	MTK_PIN(
+		72, "GPIO72",
+		MTK_EINT_FUNCTION(0, 72),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO72"),
+		MTK_FUNCTION(1, "B0_SPIM0_MISO"),
+		MTK_FUNCTION(2, "I0_SCP_SPI0_MI"),
+		MTK_FUNCTION(3, "O_DMIC4_CLK"),
+		MTK_FUNCTION(5, "O_CMVREF3"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP1_0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A26")
+	),
+
+	MTK_PIN(
+		73, "GPIO73",
+		MTK_EINT_FUNCTION(0, 73),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO73"),
+		MTK_FUNCTION(1, "B0_SPIM0_MIO2"),
+		MTK_FUNCTION(2, "O_UTXD3"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT"),
+		MTK_FUNCTION(4, "O_CLKM0"),
+		MTK_FUNCTION(5, "O_CMVREF4"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP1_1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A27")
+	),
+
+	MTK_PIN(
+		74, "GPIO74",
+		MTK_EINT_FUNCTION(0, 74),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO74"),
+		MTK_FUNCTION(1, "B0_SPIM0_MIO3"),
+		MTK_FUNCTION(2, "I1_URXD3"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT_R"),
+		MTK_FUNCTION(4, "O_CLKM1"),
+		MTK_FUNCTION(5, "O_CMVREF5"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP1_2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A28")
+	),
+
+	MTK_PIN(
+		75, "GPIO75",
+		MTK_EINT_FUNCTION(0, 75),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO75"),
+		MTK_FUNCTION(1, "O_SPIM1_CSB"),
+		MTK_FUNCTION(2, "O_SCP_SPI1_A_CS"),
+		MTK_FUNCTION(3, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(4, "B1_SCP_SCL0"),
+		MTK_FUNCTION(5, "O_CMVREF6"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP2_0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A29")
+	),
+
+	MTK_PIN(
+		76, "GPIO76",
+		MTK_EINT_FUNCTION(0, 76),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO76"),
+		MTK_FUNCTION(1, "O_SPIM1_CLK"),
+		MTK_FUNCTION(2, "O_SCP_SPI1_A_CK"),
+		MTK_FUNCTION(3, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(4, "B1_SCP_SDA0"),
+		MTK_FUNCTION(5, "O_CMVREF7"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP2_1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A30")
+	),
+
+	MTK_PIN(
+		77, "GPIO77",
+		MTK_EINT_FUNCTION(0, 77),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO77"),
+		MTK_FUNCTION(1, "B0_SPIM1_MOSI"),
+		MTK_FUNCTION(2, "O_SCP_SPI1_A_MO"),
+		MTK_FUNCTION(3, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(4, "B1_SCP_SCL1"),
+		MTK_FUNCTION(6, "O_GDU_SUM_TROOP2_2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A31")
+	),
+
+	MTK_PIN(
+		78, "GPIO78",
+		MTK_EINT_FUNCTION(0, 78),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO78"),
+		MTK_FUNCTION(1, "B0_SPIM1_MISO"),
+		MTK_FUNCTION(2, "I0_SCP_SPI1_A_MI"),
+		MTK_FUNCTION(3, "I0_TDMIN_DI"),
+		MTK_FUNCTION(4, "B1_SCP_SDA1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_A32")
+	),
+
+	MTK_PIN(
+		79, "GPIO79",
+		MTK_EINT_FUNCTION(0, 79),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO79"),
+		MTK_FUNCTION(1, "O_SPIM2_CSB"),
+		MTK_FUNCTION(2, "O_SCP_SPI2_CS"),
+		MTK_FUNCTION(3, "O_I2SO1_MCK"),
+		MTK_FUNCTION(4, "O_UTXD2"),
+		MTK_FUNCTION(5, "O_TP_UTXD2_AO"),
+		MTK_FUNCTION(6, "B0_PCM_SYNC"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B0")
+	),
+
+	MTK_PIN(
+		80, "GPIO80",
+		MTK_EINT_FUNCTION(0, 80),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO80"),
+		MTK_FUNCTION(1, "O_SPIM2_CLK"),
+		MTK_FUNCTION(2, "O_SCP_SPI2_CK"),
+		MTK_FUNCTION(3, "O_I2SO1_BCK"),
+		MTK_FUNCTION(4, "I1_URXD2"),
+		MTK_FUNCTION(5, "I1_TP_URXD2_AO"),
+		MTK_FUNCTION(6, "B0_PCM_CLK"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B1")
+	),
+
+	MTK_PIN(
+		81, "GPIO81",
+		MTK_EINT_FUNCTION(0, 81),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO81"),
+		MTK_FUNCTION(1, "B0_SPIM2_MOSI"),
+		MTK_FUNCTION(2, "O_SCP_SPI2_MO"),
+		MTK_FUNCTION(3, "O_I2SO1_WS"),
+		MTK_FUNCTION(4, "O_URTS2"),
+		MTK_FUNCTION(5, "O_TP_URTS2_AO"),
+		MTK_FUNCTION(6, "O_PCM_DO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B2")
+	),
+
+	MTK_PIN(
+		82, "GPIO82",
+		MTK_EINT_FUNCTION(0, 82),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO82"),
+		MTK_FUNCTION(1, "B0_SPIM2_MISO"),
+		MTK_FUNCTION(2, "I0_SCP_SPI2_MI"),
+		MTK_FUNCTION(3, "O_I2SO1_D0"),
+		MTK_FUNCTION(4, "I1_UCTS2"),
+		MTK_FUNCTION(5, "I1_TP_UCTS2_AO"),
+		MTK_FUNCTION(6, "I0_PCM_DI"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B3")
+	),
+
+	MTK_PIN(
+		83, "GPIO83",
+		MTK_EINT_FUNCTION(0, 83),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO83"),
+		MTK_FUNCTION(1, "I1_IDDIG")
+	),
+
+	MTK_PIN(
+		84, "GPIO84",
+		MTK_EINT_FUNCTION(0, 84),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO84"),
+		MTK_FUNCTION(1, "O_USB_DRVVBUS")
+	),
+
+	MTK_PIN(
+		85, "GPIO85",
+		MTK_EINT_FUNCTION(0, 85),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO85"),
+		MTK_FUNCTION(1, "I0_VBUSVALID")
+	),
+
+	MTK_PIN(
+		86, "GPIO86",
+		MTK_EINT_FUNCTION(0, 86),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO86"),
+		MTK_FUNCTION(1, "I1_IDDIG_1P"),
+		MTK_FUNCTION(2, "O_UTXD1"),
+		MTK_FUNCTION(3, "O_URTS2"),
+		MTK_FUNCTION(4, "O_PWM_2"),
+		MTK_FUNCTION(5, "B0_TP_GPIO4_AO"),
+		MTK_FUNCTION(6, "O_AUXIF_ST0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B4")
+	),
+
+	MTK_PIN(
+		87, "GPIO87",
+		MTK_EINT_FUNCTION(0, 87),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO87"),
+		MTK_FUNCTION(1, "O_USB_DRVVBUS_1P"),
+		MTK_FUNCTION(2, "I1_URXD1"),
+		MTK_FUNCTION(3, "I1_UCTS2"),
+		MTK_FUNCTION(4, "O_PWM_3"),
+		MTK_FUNCTION(5, "B0_TP_GPIO5_AO"),
+		MTK_FUNCTION(6, "O_AUXIF_CLK0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B5")
+	),
+
+	MTK_PIN(
+		88, "GPIO88",
+		MTK_EINT_FUNCTION(0, 88),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO88"),
+		MTK_FUNCTION(1, "I0_VBUSVALID_1P"),
+		MTK_FUNCTION(2, "O_UTXD2"),
+		MTK_FUNCTION(3, "O_URTS1"),
+		MTK_FUNCTION(4, "O_CLKM2"),
+		MTK_FUNCTION(5, "B0_TP_GPIO6_AO"),
+		MTK_FUNCTION(6, "O_AUXIF_ST1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B6")
+	),
+
+	MTK_PIN(
+		89, "GPIO89",
+		MTK_EINT_FUNCTION(0, 89),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO89"),
+		MTK_FUNCTION(1, "I1_IDDIG_2P"),
+		MTK_FUNCTION(2, "I1_URXD2"),
+		MTK_FUNCTION(3, "I1_UCTS1"),
+		MTK_FUNCTION(4, "O_CLKM3"),
+		MTK_FUNCTION(5, "B0_TP_GPIO7_AO"),
+		MTK_FUNCTION(6, "O_AUXIF_CLK1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B7")
+	),
+
+	MTK_PIN(
+		90, "GPIO90",
+		MTK_EINT_FUNCTION(0, 90),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO90"),
+		MTK_FUNCTION(1, "O_USB_DRVVBUS_2P"),
+		MTK_FUNCTION(2, "O_UTXD3"),
+		MTK_FUNCTION(3, "O_ADSP_UTXD0"),
+		MTK_FUNCTION(4, "O_SSPM_UTXD_AO"),
+		MTK_FUNCTION(5, "O_MD32_0_TXD"),
+		MTK_FUNCTION(6, "O_MD32_1_TXD"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B8")
+	),
+
+	MTK_PIN(
+		91, "GPIO91",
+		MTK_EINT_FUNCTION(0, 91),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO91"),
+		MTK_FUNCTION(1, "I0_VBUSVALID_2P"),
+		MTK_FUNCTION(2, "I1_URXD3"),
+		MTK_FUNCTION(3, "I1_ADSP_URXD0"),
+		MTK_FUNCTION(4, "I1_SSPM_URXD_AO"),
+		MTK_FUNCTION(5, "I1_MD32_0_RXD"),
+		MTK_FUNCTION(6, "I1_MD32_1_RXD"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B9")
+	),
+
+	MTK_PIN(
+		92, "GPIO92",
+		MTK_EINT_FUNCTION(0, 92),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO92"),
+		MTK_FUNCTION(1, "O_PWRAP_SPI0_CSN")
+	),
+
+	MTK_PIN(
+		93, "GPIO93",
+		MTK_EINT_FUNCTION(0, 93),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO93"),
+		MTK_FUNCTION(1, "O_PWRAP_SPI0_CK")
+	),
+
+	MTK_PIN(
+		94, "GPIO94",
+		MTK_EINT_FUNCTION(0, 94),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO94"),
+		MTK_FUNCTION(1, "B0_PWRAP_SPI0_MO"),
+		MTK_FUNCTION(2, "B0_PWRAP_SPI0_MI")
+	),
+
+	MTK_PIN(
+		95, "GPIO95",
+		MTK_EINT_FUNCTION(0, 95),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO95"),
+		MTK_FUNCTION(1, "B0_PWRAP_SPI0_MI"),
+		MTK_FUNCTION(2, "B0_PWRAP_SPI0_MO")
+	),
+
+	MTK_PIN(
+		96, "GPIO96",
+		MTK_EINT_FUNCTION(0, 96),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO96"),
+		MTK_FUNCTION(1, "O_SRCLKENA0")
+	),
+
+	MTK_PIN(
+		97, "GPIO97",
+		MTK_EINT_FUNCTION(0, 97),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO97"),
+		MTK_FUNCTION(1, "O_SRCLKENA1")
+	),
+
+	MTK_PIN(
+		98, "GPIO98",
+		MTK_EINT_FUNCTION(0, 98),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO98"),
+		MTK_FUNCTION(1, "O_SCP_VREQ_VAO"),
+		MTK_FUNCTION(2, "I0_DVFSRC_EXT_REQ")
+	),
+
+	MTK_PIN(
+		99, "GPIO99",
+		MTK_EINT_FUNCTION(0, 99),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO99"),
+		MTK_FUNCTION(1, "I0_RTC32K_CK")
+	),
+
+	MTK_PIN(
+		100, "GPIO100",
+		MTK_EINT_FUNCTION(0, 100),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO100"),
+		MTK_FUNCTION(1, "O_WATCHDOG")
+	),
+
+	MTK_PIN(
+		101, "GPIO101",
+		MTK_EINT_FUNCTION(0, 101),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO101"),
+		MTK_FUNCTION(1, "O_AUD_CLK_MOSI"),
+		MTK_FUNCTION(2, "O_I2SO1_MCK"),
+		MTK_FUNCTION(3, "B0_I2SIN_BCK")
+	),
+
+	MTK_PIN(
+		102, "GPIO102",
+		MTK_EINT_FUNCTION(0, 102),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO102"),
+		MTK_FUNCTION(1, "O_AUD_SYNC_MOSI"),
+		MTK_FUNCTION(2, "O_I2SO1_BCK"),
+		MTK_FUNCTION(3, "B0_I2SIN_WS")
+	),
+
+	MTK_PIN(
+		103, "GPIO103",
+		MTK_EINT_FUNCTION(0, 103),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO103"),
+		MTK_FUNCTION(1, "O_AUD_DAT_MOSI0"),
+		MTK_FUNCTION(2, "O_I2SO1_WS"),
+		MTK_FUNCTION(3, "I0_I2SIN_D0")
+	),
+
+	MTK_PIN(
+		104, "GPIO104",
+		MTK_EINT_FUNCTION(0, 104),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO104"),
+		MTK_FUNCTION(1, "O_AUD_DAT_MOSI1"),
+		MTK_FUNCTION(2, "O_I2SO1_D0"),
+		MTK_FUNCTION(3, "I0_I2SIN_D1")
+	),
+
+	MTK_PIN(
+		105, "GPIO105",
+		MTK_EINT_FUNCTION(0, 105),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO105"),
+		MTK_FUNCTION(1, "I0_AUD_DAT_MISO0"),
+		MTK_FUNCTION(2, "I0_VOW_DAT_MISO"),
+		MTK_FUNCTION(3, "I0_I2SIN_D2")
+	),
+
+	MTK_PIN(
+		106, "GPIO106",
+		MTK_EINT_FUNCTION(0, 106),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO106"),
+		MTK_FUNCTION(1, "I0_AUD_DAT_MISO1"),
+		MTK_FUNCTION(2, "I0_VOW_CLK_MISO"),
+		MTK_FUNCTION(3, "I0_I2SIN_D3")
+	),
+
+	MTK_PIN(
+		107, "GPIO107",
+		MTK_EINT_FUNCTION(0, 107),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO107"),
+		MTK_FUNCTION(1, "B0_I2SIN_MCK"),
+		MTK_FUNCTION(2, "I0_SPLIN_MCK"),
+		MTK_FUNCTION(3, "I0_SPDIF_IN0"),
+		MTK_FUNCTION(4, "O_CMVREF4"),
+		MTK_FUNCTION(5, "O_AUXIF_ST0"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR0")
+	),
+
+	MTK_PIN(
+		108, "GPIO108",
+		MTK_EINT_FUNCTION(0, 108),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO108"),
+		MTK_FUNCTION(1, "B0_I2SIN_BCK"),
+		MTK_FUNCTION(2, "I0_SPLIN_LRCK"),
+		MTK_FUNCTION(3, "O_DMIC4_CLK"),
+		MTK_FUNCTION(4, "O_CMVREF5"),
+		MTK_FUNCTION(5, "O_AUXIF_CLK0"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR1"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B10")
+	),
+
+	MTK_PIN(
+		109, "GPIO109",
+		MTK_EINT_FUNCTION(0, 109),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO109"),
+		MTK_FUNCTION(1, "B0_I2SIN_WS"),
+		MTK_FUNCTION(2, "I0_SPLIN_BCK"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT"),
+		MTK_FUNCTION(4, "O_CMVREF6"),
+		MTK_FUNCTION(5, "O_AUXIF_ST1"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR2"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B11")
+	),
+
+	MTK_PIN(
+		110, "GPIO110",
+		MTK_EINT_FUNCTION(0, 110),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO110"),
+		MTK_FUNCTION(1, "I0_I2SIN_D0"),
+		MTK_FUNCTION(2, "I0_SPLIN_D0"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT_R"),
+		MTK_FUNCTION(4, "O_CMVREF7"),
+		MTK_FUNCTION(5, "O_AUXIF_CLK1"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR3"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B12")
+	),
+
+	MTK_PIN(
+		111, "GPIO111",
+		MTK_EINT_FUNCTION(0, 111),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO111"),
+		MTK_FUNCTION(1, "I0_I2SIN_D1"),
+		MTK_FUNCTION(2, "I0_SPLIN_D1"),
+		MTK_FUNCTION(3, "O_DMIC3_CLK"),
+		MTK_FUNCTION(4, "O_SPDIF_OUT"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR4"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B13")
+	),
+
+	MTK_PIN(
+		112, "GPIO112",
+		MTK_EINT_FUNCTION(0, 112),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO112"),
+		MTK_FUNCTION(1, "I0_I2SIN_D2"),
+		MTK_FUNCTION(2, "I0_SPLIN_D2"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT"),
+		MTK_FUNCTION(4, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(5, "O_I2SO1_WS"),
+		MTK_FUNCTION(6, "O_PGD_LV_LSC_PWR5"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B14")
+	),
+
+	MTK_PIN(
+		113, "GPIO113",
+		MTK_EINT_FUNCTION(0, 113),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO113"),
+		MTK_FUNCTION(1, "I0_I2SIN_D3"),
+		MTK_FUNCTION(2, "I0_SPLIN_D3"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT_R"),
+		MTK_FUNCTION(4, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(5, "O_I2SO1_D0"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B15")
+	),
+
+	MTK_PIN(
+		114, "GPIO114",
+		MTK_EINT_FUNCTION(0, 114),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO114"),
+		MTK_FUNCTION(1, "O_I2SO2_MCK"),
+		MTK_FUNCTION(2, "B0_I2SIN_MCK"),
+		MTK_FUNCTION(3, "I1_MCUPM_JTAG_TMS"),
+		MTK_FUNCTION(4, "B1_APU_JTAG_TMS"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG1_TMS"),
+		MTK_FUNCTION(6, "I1_SPM_JTAG_TMS"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B16")
+	),
+
+	MTK_PIN(
+		115, "GPIO115",
+		MTK_EINT_FUNCTION(0, 115),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO115"),
+		MTK_FUNCTION(1, "B0_I2SO2_BCK"),
+		MTK_FUNCTION(2, "B0_I2SIN_BCK"),
+		MTK_FUNCTION(3, "I1_MCUPM_JTAG_TCK"),
+		MTK_FUNCTION(4, "I0_APU_JTAG_TCK"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG1_TCK"),
+		MTK_FUNCTION(6, "I1_SPM_JTAG_TCK"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B17")
+	),
+
+	MTK_PIN(
+		116, "GPIO116",
+		MTK_EINT_FUNCTION(0, 116),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO116"),
+		MTK_FUNCTION(1, "B0_I2SO2_WS"),
+		MTK_FUNCTION(2, "B0_I2SIN_WS"),
+		MTK_FUNCTION(3, "I1_MCUPM_JTAG_TDI"),
+		MTK_FUNCTION(4, "I1_APU_JTAG_TDI"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG1_TDI"),
+		MTK_FUNCTION(6, "I1_SPM_JTAG_TDI"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B18")
+	),
+
+	MTK_PIN(
+		117, "GPIO117",
+		MTK_EINT_FUNCTION(0, 117),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO117"),
+		MTK_FUNCTION(1, "O_I2SO2_D0"),
+		MTK_FUNCTION(2, "I0_I2SIN_D0"),
+		MTK_FUNCTION(3, "O_MCUPM_JTAG_TDO"),
+		MTK_FUNCTION(4, "O_APU_JTAG_TDO"),
+		MTK_FUNCTION(5, "O_SCP_JTAG1_TDO"),
+		MTK_FUNCTION(6, "O_SPM_JTAG_TDO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B19")
+	),
+
+	MTK_PIN(
+		118, "GPIO118",
+		MTK_EINT_FUNCTION(0, 118),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO118"),
+		MTK_FUNCTION(1, "O_I2SO2_D1"),
+		MTK_FUNCTION(2, "I0_I2SIN_D1"),
+		MTK_FUNCTION(3, "I0_MCUPM_JTAG_TRSTN"),
+		MTK_FUNCTION(4, "I0_APU_JTAG_TRST"),
+		MTK_FUNCTION(5, "I0_SCP_JTAG1_TRSTN"),
+		MTK_FUNCTION(6, "I0_SPM_JTAG_TRSTN"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B20")
+	),
+
+	MTK_PIN(
+		119, "GPIO119",
+		MTK_EINT_FUNCTION(0, 119),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO119"),
+		MTK_FUNCTION(1, "O_I2SO2_D2"),
+		MTK_FUNCTION(2, "I0_I2SIN_D2"),
+		MTK_FUNCTION(3, "O_UTXD3"),
+		MTK_FUNCTION(4, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(5, "O_I2SO1_MCK"),
+		MTK_FUNCTION(6, "O_SSPM_UTXD_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B21")
+	),
+
+	MTK_PIN(
+		120, "GPIO120",
+		MTK_EINT_FUNCTION(0, 120),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO120"),
+		MTK_FUNCTION(1, "O_I2SO2_D3"),
+		MTK_FUNCTION(2, "I0_I2SIN_D3"),
+		MTK_FUNCTION(3, "I1_URXD3"),
+		MTK_FUNCTION(4, "I0_TDMIN_DI"),
+		MTK_FUNCTION(5, "O_I2SO1_BCK"),
+		MTK_FUNCTION(6, "I1_SSPM_URXD_AO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B22")
+	),
+
+	MTK_PIN(
+		121, "GPIO121",
+		MTK_EINT_FUNCTION(0, 121),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO121"),
+		MTK_FUNCTION(1, "B0_PCM_CLK"),
+		MTK_FUNCTION(2, "O_SPIM4_CSB"),
+		MTK_FUNCTION(3, "O_SCP_SPI1_B_CS"),
+		MTK_FUNCTION(4, "O_TP_UTXD2_AO"),
+		MTK_FUNCTION(5, "O_AUXIF_ST0"),
+		MTK_FUNCTION(6, "O_PGD_DA_EFUSE_RDY"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B23")
+	),
+
+	MTK_PIN(
+		122, "GPIO122",
+		MTK_EINT_FUNCTION(0, 122),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO122"),
+		MTK_FUNCTION(1, "B0_PCM_SYNC"),
+		MTK_FUNCTION(2, "O_SPIM4_CLK"),
+		MTK_FUNCTION(3, "O_SCP_SPI1_B_CK"),
+		MTK_FUNCTION(4, "I1_TP_URXD2_AO"),
+		MTK_FUNCTION(5, "O_AUXIF_CLK0"),
+		MTK_FUNCTION(6, "O_PGD_DA_EFUSE_RDY_PRE"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B24")
+	),
+
+	MTK_PIN(
+		123, "GPIO123",
+		MTK_EINT_FUNCTION(0, 123),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO123"),
+		MTK_FUNCTION(1, "O_PCM_DO"),
+		MTK_FUNCTION(2, "B0_SPIM4_MOSI"),
+		MTK_FUNCTION(3, "O_SCP_SPI1_B_MO"),
+		MTK_FUNCTION(4, "O_TP_URTS2_AO"),
+		MTK_FUNCTION(5, "O_AUXIF_ST1"),
+		MTK_FUNCTION(6, "O_PGD_DA_PWRGD_RESET"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B25")
+	),
+
+	MTK_PIN(
+		124, "GPIO124",
+		MTK_EINT_FUNCTION(0, 124),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO124"),
+		MTK_FUNCTION(1, "I0_PCM_DI"),
+		MTK_FUNCTION(2, "B0_SPIM4_MISO"),
+		MTK_FUNCTION(3, "I0_SCP_SPI1_B_MI"),
+		MTK_FUNCTION(4, "I1_TP_UCTS2_AO"),
+		MTK_FUNCTION(5, "O_AUXIF_CLK1"),
+		MTK_FUNCTION(6, "O_PGD_DA_PWRGD_ENB"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B26")
+	),
+
+	MTK_PIN(
+		125, "GPIO125",
+		MTK_EINT_FUNCTION(0, 125),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO125"),
+		MTK_FUNCTION(1, "O_DMIC1_CLK"),
+		MTK_FUNCTION(2, "O_SPINOR_CK"),
+		MTK_FUNCTION(3, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(6, "O_LVTS_FOUT"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B27")
+	),
+
+	MTK_PIN(
+		126, "GPIO126",
+		MTK_EINT_FUNCTION(0, 126),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO126"),
+		MTK_FUNCTION(1, "I0_DMIC1_DAT"),
+		MTK_FUNCTION(2, "O_SPINOR_CS"),
+		MTK_FUNCTION(3, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(6, "O_LVTS_SDO"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B28")
+	),
+
+	MTK_PIN(
+		127, "GPIO127",
+		MTK_EINT_FUNCTION(0, 127),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO127"),
+		MTK_FUNCTION(1, "I0_DMIC1_DAT_R"),
+		MTK_FUNCTION(2, "B0_SPINOR_IO0"),
+		MTK_FUNCTION(3, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(6, "I0_LVTS_26M"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B29")
+	),
+
+	MTK_PIN(
+		128, "GPIO128",
+		MTK_EINT_FUNCTION(0, 128),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO128"),
+		MTK_FUNCTION(1, "O_DMIC2_CLK"),
+		MTK_FUNCTION(2, "B0_SPINOR_IO1"),
+		MTK_FUNCTION(3, "I0_TDMIN_DI"),
+		MTK_FUNCTION(6, "I0_LVTS_SCF"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B30")
+	),
+
+	MTK_PIN(
+		129, "GPIO129",
+		MTK_EINT_FUNCTION(0, 129),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO129"),
+		MTK_FUNCTION(1, "I0_DMIC2_DAT"),
+		MTK_FUNCTION(2, "B0_SPINOR_IO2"),
+		MTK_FUNCTION(3, "I0_SPDIF_IN1"),
+		MTK_FUNCTION(6, "I0_LVTS_SCK"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B31")
+	),
+
+	MTK_PIN(
+		130, "GPIO130",
+		MTK_EINT_FUNCTION(0, 130),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO130"),
+		MTK_FUNCTION(1, "I0_DMIC2_DAT_R"),
+		MTK_FUNCTION(2, "B0_SPINOR_IO3"),
+		MTK_FUNCTION(3, "I0_SPDIF_IN2"),
+		MTK_FUNCTION(6, "I0_LVTS_SDI"),
+		MTK_FUNCTION(7, "B0_DBG_MON_B32")
+	),
+
+	MTK_PIN(
+		131, "GPIO131",
+		MTK_EINT_FUNCTION(0, 131),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO131"),
+		MTK_FUNCTION(1, "O_DPI_D0"),
+		MTK_FUNCTION(2, "O_GBE_TXD3"),
+		MTK_FUNCTION(3, "O_DMIC1_CLK"),
+		MTK_FUNCTION(4, "O_I2SO2_MCK"),
+		MTK_FUNCTION(5, "B0_TP_GPIO0_AO"),
+		MTK_FUNCTION(6, "O_SPIM5_CSB"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR0")
+	),
+
+	MTK_PIN(
+		132, "GPIO132",
+		MTK_EINT_FUNCTION(0, 132),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO132"),
+		MTK_FUNCTION(1, "O_DPI_D1"),
+		MTK_FUNCTION(2, "O_GBE_TXD2"),
+		MTK_FUNCTION(3, "I0_DMIC1_DAT"),
+		MTK_FUNCTION(4, "B0_I2SO2_BCK"),
+		MTK_FUNCTION(5, "B0_TP_GPIO1_AO"),
+		MTK_FUNCTION(6, "O_SPIM5_CLK"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR1")
+	),
+
+	MTK_PIN(
+		133, "GPIO133",
+		MTK_EINT_FUNCTION(0, 133),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO133"),
+		MTK_FUNCTION(1, "O_DPI_D2"),
+		MTK_FUNCTION(2, "O_GBE_TXD1"),
+		MTK_FUNCTION(3, "I0_DMIC1_DAT_R"),
+		MTK_FUNCTION(4, "B0_I2SO2_WS"),
+		MTK_FUNCTION(5, "B0_TP_GPIO2_AO"),
+		MTK_FUNCTION(6, "B0_SPIM5_MOSI"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR2")
+	),
+
+	MTK_PIN(
+		134, "GPIO134",
+		MTK_EINT_FUNCTION(0, 134),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO134"),
+		MTK_FUNCTION(1, "O_DPI_D3"),
+		MTK_FUNCTION(2, "O_GBE_TXD0"),
+		MTK_FUNCTION(3, "O_DMIC2_CLK"),
+		MTK_FUNCTION(4, "O_I2SO2_D0"),
+		MTK_FUNCTION(5, "B0_TP_GPIO3_AO"),
+		MTK_FUNCTION(6, "B0_SPIM5_MISO"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR3")
+	),
+
+	MTK_PIN(
+		135, "GPIO135",
+		MTK_EINT_FUNCTION(0, 135),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO135"),
+		MTK_FUNCTION(1, "O_DPI_D4"),
+		MTK_FUNCTION(2, "I0_GBE_RXD3"),
+		MTK_FUNCTION(3, "I0_DMIC2_DAT"),
+		MTK_FUNCTION(4, "O_I2SO2_D1"),
+		MTK_FUNCTION(5, "B0_TP_GPIO4_AO"),
+		MTK_FUNCTION(6, "I1_WAKEN"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR4")
+	),
+
+	MTK_PIN(
+		136, "GPIO136",
+		MTK_EINT_FUNCTION(0, 136),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO136"),
+		MTK_FUNCTION(1, "O_DPI_D5"),
+		MTK_FUNCTION(2, "I0_GBE_RXD2"),
+		MTK_FUNCTION(3, "I0_DMIC2_DAT_R"),
+		MTK_FUNCTION(4, "O_I2SO2_D2"),
+		MTK_FUNCTION(5, "B0_TP_GPIO5_AO"),
+		MTK_FUNCTION(6, "O_PERSTN"),
+		MTK_FUNCTION(7, "O_PGD_LV_HSC_PWR5")
+	),
+
+	MTK_PIN(
+		137, "GPIO137",
+		MTK_EINT_FUNCTION(0, 137),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO137"),
+		MTK_FUNCTION(1, "O_DPI_D6"),
+		MTK_FUNCTION(2, "I0_GBE_RXD1"),
+		MTK_FUNCTION(3, "O_DMIC3_CLK"),
+		MTK_FUNCTION(4, "O_I2SO2_D3"),
+		MTK_FUNCTION(5, "B0_TP_GPIO6_AO"),
+		MTK_FUNCTION(6, "B1_CLKREQN"),
+		MTK_FUNCTION(7, "O_PWM_0")
+	),
+
+	MTK_PIN(
+		138, "GPIO138",
+		MTK_EINT_FUNCTION(0, 138),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO138"),
+		MTK_FUNCTION(1, "O_DPI_D7"),
+		MTK_FUNCTION(2, "I0_GBE_RXD0"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT"),
+		MTK_FUNCTION(4, "O_CLKM2"),
+		MTK_FUNCTION(5, "B0_TP_GPIO7_AO"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO0")
+	),
+
+	MTK_PIN(
+		139, "GPIO139",
+		MTK_EINT_FUNCTION(0, 139),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO139"),
+		MTK_FUNCTION(1, "O_DPI_D8"),
+		MTK_FUNCTION(2, "B0_GBE_TXC"),
+		MTK_FUNCTION(3, "I0_DMIC3_DAT_R"),
+		MTK_FUNCTION(4, "O_CLKM3"),
+		MTK_FUNCTION(5, "O_TP_UTXD2_AO"),
+		MTK_FUNCTION(6, "O_UTXD2"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO1")
+	),
+
+	MTK_PIN(
+		140, "GPIO140",
+		MTK_EINT_FUNCTION(0, 140),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO140"),
+		MTK_FUNCTION(1, "O_DPI_D9"),
+		MTK_FUNCTION(2, "I0_GBE_RXC"),
+		MTK_FUNCTION(3, "O_DMIC4_CLK"),
+		MTK_FUNCTION(4, "O_PWM_2"),
+		MTK_FUNCTION(5, "I1_TP_URXD2_AO"),
+		MTK_FUNCTION(6, "I1_URXD2"),
+		MTK_FUNCTION(7, "B0_MD32_0_GPIO2")
+	),
+
+	MTK_PIN(
+		141, "GPIO141",
+		MTK_EINT_FUNCTION(0, 141),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO141"),
+		MTK_FUNCTION(1, "O_DPI_D10"),
+		MTK_FUNCTION(2, "I0_GBE_RXDV"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT"),
+		MTK_FUNCTION(4, "O_PWM_3"),
+		MTK_FUNCTION(5, "O_TP_URTS2_AO"),
+		MTK_FUNCTION(6, "O_URTS2"),
+		MTK_FUNCTION(7, "B0_MD32_1_GPIO0")
+	),
+
+	MTK_PIN(
+		142, "GPIO142",
+		MTK_EINT_FUNCTION(0, 142),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO142"),
+		MTK_FUNCTION(1, "O_DPI_D11"),
+		MTK_FUNCTION(2, "O_GBE_TXEN"),
+		MTK_FUNCTION(3, "I0_DMIC4_DAT_R"),
+		MTK_FUNCTION(4, "O_PWM_1"),
+		MTK_FUNCTION(5, "I1_TP_UCTS2_AO"),
+		MTK_FUNCTION(6, "I1_UCTS2"),
+		MTK_FUNCTION(7, "B0_MD32_1_GPIO1")
+	),
+
+	MTK_PIN(
+		143, "GPIO143",
+		MTK_EINT_FUNCTION(0, 143),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO143"),
+		MTK_FUNCTION(1, "O_DPI_D12"),
+		MTK_FUNCTION(2, "O_GBE_MDC"),
+		MTK_FUNCTION(3, "B0_MD32_0_GPIO0"),
+		MTK_FUNCTION(4, "O_CLKM0"),
+		MTK_FUNCTION(5, "O_SPIM3_CSB"),
+		MTK_FUNCTION(6, "O_UTXD1"),
+		MTK_FUNCTION(7, "B0_MD32_1_GPIO2")
+	),
+
+	MTK_PIN(
+		144, "GPIO144",
+		MTK_EINT_FUNCTION(0, 144),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO144"),
+		MTK_FUNCTION(1, "O_DPI_D13"),
+		MTK_FUNCTION(2, "B1_GBE_MDIO"),
+		MTK_FUNCTION(3, "B0_MD32_0_GPIO1"),
+		MTK_FUNCTION(4, "O_CLKM1"),
+		MTK_FUNCTION(5, "O_SPIM3_CLK"),
+		MTK_FUNCTION(6, "I1_URXD1"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR0")
+	),
+
+	MTK_PIN(
+		145, "GPIO145",
+		MTK_EINT_FUNCTION(0, 145),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO145"),
+		MTK_FUNCTION(1, "O_DPI_D14"),
+		MTK_FUNCTION(2, "O_GBE_TXER"),
+		MTK_FUNCTION(3, "B0_MD32_1_GPIO0"),
+		MTK_FUNCTION(4, "O_CMFLASH0"),
+		MTK_FUNCTION(5, "B0_SPIM3_MOSI"),
+		MTK_FUNCTION(6, "B0_GBE_AUX_PPS2"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR1")
+	),
+
+	MTK_PIN(
+		146, "GPIO146",
+		MTK_EINT_FUNCTION(0, 146),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO146"),
+		MTK_FUNCTION(1, "O_DPI_D15"),
+		MTK_FUNCTION(2, "I0_GBE_RXER"),
+		MTK_FUNCTION(3, "B0_MD32_1_GPIO1"),
+		MTK_FUNCTION(4, "O_CMFLASH1"),
+		MTK_FUNCTION(5, "B0_SPIM3_MISO"),
+		MTK_FUNCTION(6, "B0_GBE_AUX_PPS3"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR2")
+	),
+
+	MTK_PIN(
+		147, "GPIO147",
+		MTK_EINT_FUNCTION(0, 147),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO147"),
+		MTK_FUNCTION(1, "O_DPI_HSYNC"),
+		MTK_FUNCTION(2, "I0_GBE_COL"),
+		MTK_FUNCTION(3, "O_I2SO1_MCK"),
+		MTK_FUNCTION(4, "O_CMVREF0"),
+		MTK_FUNCTION(5, "O_SPDIF_OUT"),
+		MTK_FUNCTION(6, "O_URTS1"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR3")
+	),
+
+	MTK_PIN(
+		148, "GPIO148",
+		MTK_EINT_FUNCTION(0, 148),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO148"),
+		MTK_FUNCTION(1, "O_DPI_VSYNC"),
+		MTK_FUNCTION(2, "I0_GBE_INTR"),
+		MTK_FUNCTION(3, "O_I2SO1_BCK"),
+		MTK_FUNCTION(4, "O_CMVREF1"),
+		MTK_FUNCTION(5, "I0_SPDIF_IN0"),
+		MTK_FUNCTION(6, "I1_UCTS1"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR4")
+	),
+
+	MTK_PIN(
+		149, "GPIO149",
+		MTK_EINT_FUNCTION(0, 149),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO149"),
+		MTK_FUNCTION(1, "O_DPI_DE"),
+		MTK_FUNCTION(2, "B0_GBE_AUX_PPS0"),
+		MTK_FUNCTION(3, "O_I2SO1_WS"),
+		MTK_FUNCTION(4, "O_CMVREF2"),
+		MTK_FUNCTION(5, "I0_SPDIF_IN1"),
+		MTK_FUNCTION(6, "O_UTXD3"),
+		MTK_FUNCTION(7, "O_PGD_HV_HSC_PWR5")
+	),
+
+	MTK_PIN(
+		150, "GPIO150",
+		MTK_EINT_FUNCTION(0, 150),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO150"),
+		MTK_FUNCTION(1, "O_DPI_CK"),
+		MTK_FUNCTION(2, "B0_GBE_AUX_PPS1"),
+		MTK_FUNCTION(3, "O_I2SO1_D0"),
+		MTK_FUNCTION(4, "O_CMVREF3"),
+		MTK_FUNCTION(5, "I0_SPDIF_IN2"),
+		MTK_FUNCTION(6, "I1_URXD3")
+	),
+
+	MTK_PIN(
+		151, "GPIO151",
+		MTK_EINT_FUNCTION(0, 151),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO151"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT7")
+	),
+
+	MTK_PIN(
+		152, "GPIO152",
+		MTK_EINT_FUNCTION(0, 152),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO152"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT6")
+	),
+
+	MTK_PIN(
+		153, "GPIO153",
+		MTK_EINT_FUNCTION(0, 153),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO153"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT5")
+	),
+
+	MTK_PIN(
+		154, "GPIO154",
+		MTK_EINT_FUNCTION(0, 154),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO154"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT4")
+	),
+
+	MTK_PIN(
+		155, "GPIO155",
+		MTK_EINT_FUNCTION(0, 155),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO155"),
+		MTK_FUNCTION(1, "O_MSDC0_RSTB")
+	),
+
+	MTK_PIN(
+		156, "GPIO156",
+		MTK_EINT_FUNCTION(0, 156),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO156"),
+		MTK_FUNCTION(1, "B1_MSDC0_CMD")
+	),
+
+	MTK_PIN(
+		157, "GPIO157",
+		MTK_EINT_FUNCTION(0, 157),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO157"),
+		MTK_FUNCTION(1, "B1_MSDC0_CLK")
+	),
+
+	MTK_PIN(
+		158, "GPIO158",
+		MTK_EINT_FUNCTION(0, 158),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO158"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT3")
+	),
+
+	MTK_PIN(
+		159, "GPIO159",
+		MTK_EINT_FUNCTION(0, 159),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO159"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT2")
+	),
+
+	MTK_PIN(
+		160, "GPIO160",
+		MTK_EINT_FUNCTION(0, 160),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO160"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT1")
+	),
+
+	MTK_PIN(
+		161, "GPIO161",
+		MTK_EINT_FUNCTION(0, 161),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO161"),
+		MTK_FUNCTION(1, "B1_MSDC0_DAT0")
+	),
+
+	MTK_PIN(
+		162, "GPIO162",
+		MTK_EINT_FUNCTION(0, 162),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO162"),
+		MTK_FUNCTION(1, "B0_MSDC0_DSL")
+	),
+
+	MTK_PIN(
+		163, "GPIO163",
+		MTK_EINT_FUNCTION(0, 163),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO163"),
+		MTK_FUNCTION(1, "B1_MSDC1_CMD"),
+		MTK_FUNCTION(2, "O_SPDIF_OUT"),
+		MTK_FUNCTION(3, "I1_MD32_0_JTAG_TMS"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TMS"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TMS"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TMS"),
+		MTK_FUNCTION(7, "I0_IPU_JTAG_TMS")
+	),
+
+	MTK_PIN(
+		164, "GPIO164",
+		MTK_EINT_FUNCTION(0, 164),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO164"),
+		MTK_FUNCTION(1, "B1_MSDC1_CLK"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN0"),
+		MTK_FUNCTION(3, "I1_MD32_0_JTAG_TCK"),
+		MTK_FUNCTION(4, "I0_ADSP_JTAG0_TCK"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TCK"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TCK"),
+		MTK_FUNCTION(7, "I0_IPU_JTAG_TCK")
+	),
+
+	MTK_PIN(
+		165, "GPIO165",
+		MTK_EINT_FUNCTION(0, 165),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO165"),
+		MTK_FUNCTION(1, "B1_MSDC1_DAT0"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN1"),
+		MTK_FUNCTION(3, "I1_MD32_0_JTAG_TDI"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TDI"),
+		MTK_FUNCTION(5, "I1_SCP_JTAG0_TDI"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TDI"),
+		MTK_FUNCTION(7, "I0_IPU_JTAG_TDI")
+	),
+
+	MTK_PIN(
+		166, "GPIO166",
+		MTK_EINT_FUNCTION(0, 166),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO166"),
+		MTK_FUNCTION(1, "B1_MSDC1_DAT1"),
+		MTK_FUNCTION(2, "I0_SPDIF_IN2"),
+		MTK_FUNCTION(3, "O_MD32_0_JTAG_TDO"),
+		MTK_FUNCTION(4, "O_ADSP_JTAG0_TDO"),
+		MTK_FUNCTION(5, "O_SCP_JTAG0_TDO"),
+		MTK_FUNCTION(6, "O_CCU0_JTAG_TDO"),
+		MTK_FUNCTION(7, "O_IPU_JTAG_TDO")
+	),
+
+	MTK_PIN(
+		167, "GPIO167",
+		MTK_EINT_FUNCTION(0, 167),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO167"),
+		MTK_FUNCTION(1, "B1_MSDC1_DAT2"),
+		MTK_FUNCTION(2, "O_PWM_0"),
+		MTK_FUNCTION(3, "I1_MD32_0_JTAG_TRST"),
+		MTK_FUNCTION(4, "I1_ADSP_JTAG0_TRSTN"),
+		MTK_FUNCTION(5, "I0_SCP_JTAG0_TRSTN"),
+		MTK_FUNCTION(6, "I1_CCU0_JTAG_TRST"),
+		MTK_FUNCTION(7, "I0_IPU_JTAG_TRST")
+	),
+
+	MTK_PIN(
+		168, "GPIO168",
+		MTK_EINT_FUNCTION(0, 168),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO168"),
+		MTK_FUNCTION(1, "B1_MSDC1_DAT3"),
+		MTK_FUNCTION(2, "O_PWM_1"),
+		MTK_FUNCTION(3, "O_CLKM0")
+	),
+
+	MTK_PIN(
+		169, "GPIO169",
+		MTK_EINT_FUNCTION(0, 169),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO169"),
+		MTK_FUNCTION(1, "B1_MSDC2_CMD"),
+		MTK_FUNCTION(2, "O_LVTS_FOUT"),
+		MTK_FUNCTION(3, "I1_MD32_1_JTAG_TMS"),
+		MTK_FUNCTION(4, "I0_UDI_TMS"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TMS"),
+		MTK_FUNCTION(6, "B0_TDMIN_MCK"),
+		MTK_FUNCTION(7, "I1_SSPM_JTAG_TMS")
+	),
+
+	MTK_PIN(
+		170, "GPIO170",
+		MTK_EINT_FUNCTION(0, 170),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO170"),
+		MTK_FUNCTION(1, "B1_MSDC2_CLK"),
+		MTK_FUNCTION(2, "O_LVTS_SDO"),
+		MTK_FUNCTION(3, "I1_MD32_1_JTAG_TCK"),
+		MTK_FUNCTION(4, "I0_UDI_TCK"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TCK"),
+		MTK_FUNCTION(6, "B0_TDMIN_BCK"),
+		MTK_FUNCTION(7, "I1_SSPM_JTAG_TCK")
+	),
+
+	MTK_PIN(
+		171, "GPIO171",
+		MTK_EINT_FUNCTION(0, 171),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO171"),
+		MTK_FUNCTION(1, "B1_MSDC2_DAT0"),
+		MTK_FUNCTION(2, "I0_LVTS_26M"),
+		MTK_FUNCTION(3, "I1_MD32_1_JTAG_TDI"),
+		MTK_FUNCTION(4, "I0_UDI_TDI"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_TDI"),
+		MTK_FUNCTION(6, "B0_TDMIN_LRCK"),
+		MTK_FUNCTION(7, "I1_SSPM_JTAG_TDI")
+	),
+
+	MTK_PIN(
+		172, "GPIO172",
+		MTK_EINT_FUNCTION(0, 172),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO172"),
+		MTK_FUNCTION(1, "B1_MSDC2_DAT1"),
+		MTK_FUNCTION(2, "I0_LVTS_SCF"),
+		MTK_FUNCTION(3, "O_MD32_1_JTAG_TDO"),
+		MTK_FUNCTION(4, "O_UDI_TDO"),
+		MTK_FUNCTION(5, "O_VPU_UDI_TDO"),
+		MTK_FUNCTION(6, "I0_TDMIN_DI"),
+		MTK_FUNCTION(7, "O_SSPM_JTAG_TDO")
+	),
+
+	MTK_PIN(
+		173, "GPIO173",
+		MTK_EINT_FUNCTION(0, 173),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO173"),
+		MTK_FUNCTION(1, "B1_MSDC2_DAT2"),
+		MTK_FUNCTION(2, "I0_LVTS_SCK"),
+		MTK_FUNCTION(3, "I1_MD32_1_JTAG_TRST"),
+		MTK_FUNCTION(4, "I0_UDI_NTRST"),
+		MTK_FUNCTION(5, "I0_VPU_UDI_NTRST"),
+		MTK_FUNCTION(7, "I0_SSPM_JTAG_TRSTN")
+	),
+
+	MTK_PIN(
+		174, "GPIO174",
+		MTK_EINT_FUNCTION(0, 174),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO174"),
+		MTK_FUNCTION(1, "B1_MSDC2_DAT3"),
+		MTK_FUNCTION(2, "I0_LVTS_SDI")
+	),
+
+	MTK_PIN(
+		175, "GPIO175",
+		MTK_EINT_FUNCTION(0, 175),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO175"),
+		MTK_FUNCTION(1, "B0_SPMI_M_SCL")
+	),
+
+	MTK_PIN(
+		176, "GPIO176",
+		MTK_EINT_FUNCTION(0, 176),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "B_GPIO176"),
+		MTK_FUNCTION(1, "B0_SPMI_M_SDA")
+	),
+
+	MTK_PIN(
+		177, "GPIO177",
+		MTK_EINT_FUNCTION(0, 212),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		178, "GPIO178",
+		MTK_EINT_FUNCTION(0, 213),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		179, "GPIO179",
+		MTK_EINT_FUNCTION(0, 214),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		180, "GPIO180",
+		MTK_EINT_FUNCTION(0, 215),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		181, "GPIO181",
+		MTK_EINT_FUNCTION(0, 216),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		182, "GPIO182",
+		MTK_EINT_FUNCTION(0, 217),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		183, "GPIO183",
+		MTK_EINT_FUNCTION(0, 218),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		184, "GPIO184",
+		MTK_EINT_FUNCTION(0, 219),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		185, "GPIO185",
+		MTK_EINT_FUNCTION(0, 220),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		186, "GPIO186",
+		MTK_EINT_FUNCTION(0, 221),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		187, "GPIO187",
+		MTK_EINT_FUNCTION(0, 222),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		188, "GPIO188",
+		MTK_EINT_FUNCTION(0, 223),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	),
+
+	MTK_PIN(
+		189, "GPIO189",
+		MTK_EINT_FUNCTION(0, 224),
+		DRV_FIXED,
+		MTK_FUNCTION(0, NULL)
+	)
+};
+
+#endif /* __PINCTRL__MTK_MT8188_H */
-- 
2.18.0


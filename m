Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86F8529CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240691AbiEQIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243557AbiEQIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:40:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67143AED;
        Tue, 17 May 2022 01:40:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 14E841F442C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652776806;
        bh=mxQLYbSOu4PkqhkIbXO5nD37hAog9ok0cQ0iXGpz7ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aLN+phLd8Z5+ahKP3W1fOAq8XnoS+aBZ1d5iqRZ0URhUZss3n/5DThYTfAnjD2Omj
         mWZZmRcyG6ovHfFh0HCH72BEeZRwsZMbr7NnT/5yQDPkSiyo/mAn/96c+h6ihIdjgL
         Afs07sEoyAL8rJrvwwWNGMX9UKkCrc7V+gnpabboYXf/LDBTVTdVdG8eB/8EqhU7NI
         WQujf3zO1L+q9cipfqH/+s8UTLmNl4uJHHq4Oed7otPxNljhPpZHNMi1hzF5ImRLqD
         5TBD7/2/5ErNK/9GHDDb9ZbWtmMhU5FC02p40GECDYE8sRwfnx4y/6Hu2UU84OVe6C
         QvsPM8X5bmRiA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        angelogioacchino.delregno@collabora.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
Subject: [PATCH v4 2/2] pinctrl: mediatek: Add pinctrl driver for MT6795 Helio X10
Date:   Tue, 17 May 2022 10:39:57 +0200
Message-Id: <20220517083957.11816-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com>
References: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the MediaTek Helio X10 (MT6795) SoC's GPIO/pinmux
controller.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6795.c     |  623 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h | 1698 +++++++++++++++++
 4 files changed, 2329 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6795.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index b3074082c56d..1600a2c18eee 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -106,6 +106,13 @@ config PINCTRL_MT6779
 	  In MTK platform, we support virtual gpio and use it to
 	  map specific eint which doesn't have real gpio pin.
 
+config PINCTRL_MT6795
+	bool "Mediatek MT6795 pin control"
+	depends on OF
+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK_PARIS
+
 config PINCTRL_MT6797
 	bool "Mediatek MT6797 pin control"
 	depends on OF
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index 29018d6ad0de..c8f226ae36c9 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
 obj-$(CONFIG_PINCTRL_MT6765)	+= pinctrl-mt6765.o
 obj-$(CONFIG_PINCTRL_MT6779)	+= pinctrl-mt6779.o
+obj-$(CONFIG_PINCTRL_MT6795)	+= pinctrl-mt6795.o
 obj-$(CONFIG_PINCTRL_MT6797)	+= pinctrl-mt6797.o
 obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mt7622.o
 obj-$(CONFIG_PINCTRL_MT7623)	+= pinctrl-mt7623.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6795.c b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
new file mode 100644
index 000000000000..f90152261a0f
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6795.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include "pinctrl-mtk-mt6795.h"
+#include "pinctrl-paris.h"
+
+#define PIN_FIELD15(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 15, 0)
+
+#define PIN_FIELD16(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 16, 0)
+
+#define PINS_FIELD16(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)\
+	PIN_FIELD_CALC(_s_pin, _e_pin, 0, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 16, 1)
+
+static const struct mtk_pin_field_calc mt6795_pin_dir_range[] = {
+	PIN_FIELD16(0, 196, 0x0, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_pullen_range[] = {
+	PIN_FIELD16(0, 196, 0x100, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_pullsel_range[] = {
+	PIN_FIELD16(0, 196, 0x200, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_do_range[] = {
+	PIN_FIELD16(0, 196, 0x400, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_di_range[] = {
+	PIN_FIELD16(0, 196, 0x500, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_mode_range[] = {
+	PIN_FIELD15(0, 196, 0x600, 0x10, 0, 3),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_ies_range[] = {
+	PINS_FIELD16(0, 4, 0x900, 0x10, 1, 1),
+	PINS_FIELD16(5, 9, 0x900, 0x10, 2, 1),
+	PINS_FIELD16(10, 15, 0x900, 0x10, 10, 1),
+	PINS_FIELD16(16, 16, 0x900, 0x10, 2, 1),
+	PINS_FIELD16(17, 19, 0x910, 0x10, 3, 1),
+	PINS_FIELD16(20, 22, 0x910, 0x10, 4, 1),
+	PINS_FIELD16(23, 26, 0xce0, 0x10, 14, 1),
+	PINS_FIELD16(27, 27, 0xcc0, 0x10, 14, 1),
+	PINS_FIELD16(28, 28, 0xcd0, 0x10, 14, 1),
+	PINS_FIELD16(29, 32, 0x900, 0x10, 3, 1),
+	PINS_FIELD16(33, 33, 0x900, 0x10, 4, 1),
+	PINS_FIELD16(34, 36, 0x900, 0x10, 5, 1),
+	PINS_FIELD16(37, 38, 0x900, 0x10, 6, 1),
+	PINS_FIELD16(39, 39, 0x900, 0x10, 7, 1),
+	PINS_FIELD16(40, 40, 0x900, 0x10, 8, 1),
+	PINS_FIELD16(41, 42, 0x900, 0x10, 9, 1),
+	PINS_FIELD16(43, 46, 0x900, 0x10, 11, 1),
+	PINS_FIELD16(47, 61, 0x920, 0x10, 3, 1),
+	PINS_FIELD16(62, 66, 0x920, 0x10, 4, 1),
+	PINS_FIELD16(67, 67, 0x920, 0x10, 3, 1),
+	PINS_FIELD16(68, 72, 0x920, 0x10, 5, 1),
+	PINS_FIELD16(73, 77, 0x920, 0x10, 6, 1),
+	PINS_FIELD16(78, 91, 0x920, 0x10, 7, 1),
+	PINS_FIELD16(92, 92, 0x900, 0x10, 13, 1),
+	PINS_FIELD16(93, 95, 0x900, 0x10, 14, 1),
+	PINS_FIELD16(96, 99, 0x900, 0x10, 15, 1),
+	PINS_FIELD16(100, 103, 0xca0, 0x10, 14, 1),
+	PINS_FIELD16(104, 104, 0xc80, 0x10, 14, 1),
+	PINS_FIELD16(105, 105, 0xc90, 0x10, 14, 1),
+	PINS_FIELD16(106, 107, 0x910, 0x10, 0, 1),
+	PINS_FIELD16(108, 112, 0x910, 0x10, 1, 1),
+	PINS_FIELD16(113, 116, 0x910, 0x10, 2, 1),
+	PINS_FIELD16(117, 118, 0x910, 0x10, 5, 1),
+	PINS_FIELD16(119, 124, 0x910, 0x10, 6, 1),
+	PINS_FIELD16(125, 126, 0x910, 0x10, 7, 1),
+	PINS_FIELD16(129, 129, 0x910, 0x10, 8, 1),
+	PINS_FIELD16(130, 131, 0x910, 0x10, 9, 1),
+	PINS_FIELD16(132, 135, 0x910, 0x10, 8, 1),
+	PINS_FIELD16(136, 137, 0x910, 0x10, 7, 1),
+	PINS_FIELD16(154, 161, 0xc20, 0x10, 14, 1),
+	PINS_FIELD16(162, 162, 0xc10, 0x10, 14, 1),
+	PINS_FIELD16(163, 163, 0xc00, 0x10, 14, 1),
+	PINS_FIELD16(164, 164, 0xd10, 0x10, 14, 1),
+	PINS_FIELD16(165, 165, 0xd00, 0x10, 14, 1),
+	PINS_FIELD16(166, 169, 0x910, 0x10, 14, 1),
+	PINS_FIELD16(176, 179, 0x910, 0x10, 15, 1),
+	PINS_FIELD16(180, 180, 0x920, 0x10, 0, 1),
+	PINS_FIELD16(181, 184, 0x920, 0x10, 1, 1),
+	PINS_FIELD16(185, 191, 0x920, 0x10, 2, 1),
+	PINS_FIELD16(192, 192, 0x920, 0x10, 8, 1),
+	PINS_FIELD16(193, 194, 0x920, 0x10, 9, 1),
+	PINS_FIELD16(195, 196, 0x920, 0x10, 8, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_smt_range[] = {
+	PINS_FIELD16(0, 4, 0x930, 0x10, 1, 1),
+	PINS_FIELD16(5, 9, 0x930, 0x10, 2, 1),
+	PINS_FIELD16(10, 15, 0x930, 0x10, 10, 1),
+	PINS_FIELD16(16, 16, 0x930, 0x10, 2, 1),
+	PINS_FIELD16(17, 19, 0x940, 0x10, 3, 1),
+	PINS_FIELD16(20, 22, 0x940, 0x10, 4, 1),
+	PINS_FIELD16(23, 26, 0xce0, 0x10, 13, 1),
+	PINS_FIELD16(27, 27, 0xcc0, 0x10, 13, 1),
+	PINS_FIELD16(28, 28, 0xcd0, 0x10, 13, 1),
+	PINS_FIELD16(29, 32, 0x930, 0x10, 3, 1),
+	PINS_FIELD16(33, 33, 0x930, 0x10, 4, 1),
+	PINS_FIELD16(34, 36, 0x930, 0x10, 5, 1),
+	PINS_FIELD16(37, 38, 0x930, 0x10, 6, 1),
+	PINS_FIELD16(39, 39, 0x930, 0x10, 7, 1),
+	PINS_FIELD16(40, 40, 0x930, 0x10, 8, 1),
+	PINS_FIELD16(41, 42, 0x930, 0x10, 9, 1),
+	PINS_FIELD16(43, 46, 0x930, 0x10, 11, 1),
+	PINS_FIELD16(47, 61, 0x950, 0x10, 3, 1),
+	PINS_FIELD16(62, 66, 0x950, 0x10, 4, 1),
+	PINS_FIELD16(67, 67, 0x950, 0x10, 3, 1),
+	PINS_FIELD16(68, 72, 0x950, 0x10, 5, 1),
+	PINS_FIELD16(73, 77, 0x950, 0x10, 6, 1),
+	PINS_FIELD16(78, 91, 0x950, 0x10, 7, 1),
+	PINS_FIELD16(92, 92, 0x930, 0x10, 13, 1),
+	PINS_FIELD16(93, 95, 0x930, 0x10, 14, 1),
+	PINS_FIELD16(96, 99, 0x930, 0x10, 15, 1),
+	PINS_FIELD16(100, 103, 0xca0, 0x10, 13, 1),
+	PINS_FIELD16(104, 104, 0xc80, 0x10, 13, 1),
+	PINS_FIELD16(105, 105, 0xc90, 0x10, 13, 1),
+	PINS_FIELD16(106, 107, 0x940, 0x10, 0, 1),
+	PINS_FIELD16(108, 112, 0x940, 0x10, 1, 1),
+	PINS_FIELD16(113, 116, 0x940, 0x10, 2, 1),
+	PINS_FIELD16(117, 118, 0x940, 0x10, 5, 1),
+	PINS_FIELD16(119, 124, 0x940, 0x10, 6, 1),
+	PINS_FIELD16(125, 126, 0x940, 0x10, 7, 1),
+	PINS_FIELD16(129, 129, 0x940, 0x10, 8, 1),
+	PINS_FIELD16(130, 131, 0x940, 0x10, 9, 1),
+	PINS_FIELD16(132, 135, 0x940, 0x10, 8, 1),
+	PINS_FIELD16(136, 137, 0x940, 0x10, 7, 1),
+	PINS_FIELD16(154, 161, 0xc20, 0x10, 13, 1),
+	PINS_FIELD16(162, 162, 0xc10, 0x10, 13, 1),
+	PINS_FIELD16(163, 163, 0xc00, 0x10, 13, 1),
+	PINS_FIELD16(164, 164, 0xd10, 0x10, 13, 1),
+	PINS_FIELD16(165, 165, 0xd00, 0x10, 13, 1),
+	PINS_FIELD16(166, 169, 0x940, 0x10, 14, 1),
+	PINS_FIELD16(176, 179, 0x940, 0x10, 15, 1),
+	PINS_FIELD16(180, 180, 0x950, 0x10, 0, 1),
+	PINS_FIELD16(181, 184, 0x950, 0x10, 1, 1),
+	PINS_FIELD16(185, 191, 0x950, 0x10, 2, 1),
+	PINS_FIELD16(192, 192, 0x950, 0x10, 8, 1),
+	PINS_FIELD16(193, 194, 0x950, 0x10, 9, 1),
+	PINS_FIELD16(195, 196, 0x950, 0x10, 8, 1),
+};
+
+
+static const struct mtk_pin_field_calc mt6795_pin_pupd_range[] = {
+	/* KROW */
+	PIN_FIELD16(119, 119, 0xe00, 0x10, 2, 1),	/* KROW0 */
+	PIN_FIELD16(120, 120, 0xe00, 0x10, 6, 1),	/* KROW1 */
+	PIN_FIELD16(121, 121, 0xe00, 0x10, 10, 1),	/* KROW2 */
+	PIN_FIELD16(122, 122, 0xe10, 0x10, 2, 1),	/* KCOL0 */
+	PIN_FIELD16(123, 123, 0xe10, 0x10, 6, 1),	/* KCOL1 */
+	PIN_FIELD16(124, 124, 0xe10, 0x10, 10, 1),	/* KCOL2 */
+
+	/* DPI */
+	PIN_FIELD16(138, 138, 0xd50, 0x10, 2, 1),	/* CK */
+	PIN_FIELD16(139, 139, 0xd60, 0x10, 1, 1),	/* DE */
+	PIN_FIELD16(140, 140, 0xd70, 0x10, 1, 1),	/* data0 */
+	PIN_FIELD16(141, 141, 0xd70, 0x10, 3, 1),	/* data1 */
+	PIN_FIELD16(142, 142, 0xd70, 0x10, 5, 1),	/* data2 */
+	PIN_FIELD16(143, 143, 0xd70, 0x10, 7, 1),	/* data3 */
+	PIN_FIELD16(144, 144, 0xd50, 0x10, 5, 1),	/* data4 */
+	PIN_FIELD16(145, 145, 0xd50, 0x10, 7, 1),	/* data5 */
+	PIN_FIELD16(146, 146, 0xd60, 0x10, 7, 1),	/* data6 */
+	PIN_FIELD16(147, 147, 0xed0, 0x10, 6, 1),	/* data7 */
+	PIN_FIELD16(148, 148, 0xed0, 0x10, 8, 1),	/* data8 */
+	PIN_FIELD16(149, 149, 0xed0, 0x10, 10, 1),	/* data9 */
+	PIN_FIELD16(150, 150, 0xed0, 0x10, 12, 1),	/* data10 */
+	PIN_FIELD16(151, 151, 0xed0, 0x10, 14, 1),	/* data11 */
+	PIN_FIELD16(152, 152, 0xd60, 0x10, 3, 1),	/* hsync */
+	PIN_FIELD16(153, 153, 0xd60, 0x10, 5, 1),	/* vsync */
+
+	/* MSDC0 */
+	PIN_FIELD16(154, 154, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(155, 155, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(156, 156, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(157, 157, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(158, 158, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(159, 159, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(160, 160, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(161, 161, 0xc20, 0x10, 2, 1),	/* DATA 0-7 */
+	PIN_FIELD16(162, 162, 0xc10, 0x10, 2, 1),	/* CMD */
+	PIN_FIELD16(163, 163, 0xc00, 0x10, 2, 1),	/* CLK */
+	PIN_FIELD16(164, 164, 0xd10, 0x10, 2, 1),	/* DS  */
+	PIN_FIELD16(165, 165, 0xd00, 0x10, 2, 1),	/* RST */
+
+	/* MSDC1 */
+	PIN_FIELD16(170, 170, 0xc50, 0x10, 2, 1),	/* CMD */
+	PIN_FIELD16(171, 171, 0xd20, 0x10, 2, 1),	/* DAT0 */
+	PIN_FIELD16(172, 172, 0xd20, 0x10, 6, 1),	/* DAT1 */
+	PIN_FIELD16(173, 173, 0xd20, 0x10, 10, 1),	/* DAT2 */
+	PIN_FIELD16(174, 174, 0xd20, 0x10, 14, 1),	/* DAT3 */
+	PIN_FIELD16(175, 175, 0xc40, 0x10, 2, 1),	/* CLK */
+
+	/* MSDC2 */
+	PIN_FIELD16(100, 100, 0xd30, 0x10, 2, 1),	/* DAT0 */
+	PIN_FIELD16(101, 101, 0xd30, 0x10, 6, 1),	/* DAT1 */
+	PIN_FIELD16(102, 102, 0xd30, 0x10, 10, 1),	/* DAT2 */
+	PIN_FIELD16(103, 103, 0xd30, 0x10, 14, 1),	/* DAT3 */
+	PIN_FIELD16(104, 104, 0xc80, 0x10, 2, 1),	/* CLK */
+	PIN_FIELD16(105, 105, 0xc90, 0x10, 2, 1),	/* CMD */
+
+	/* MSDC3 */
+	PIN_FIELD16(23, 23, 0xd40, 0x10, 2, 1),		/* DAT0 */
+	PIN_FIELD16(24, 24, 0xd40, 0x10, 6, 5),		/* DAT1 */
+	PIN_FIELD16(25, 25, 0xd40, 0x10, 10, 9),	/* DAT2 */
+	PIN_FIELD16(26, 26, 0xd40, 0x10, 14, 13),	/* DAT3 */
+	PIN_FIELD16(27, 27, 0xcc0, 0x10, 2, 1),		/* CLK */
+	PIN_FIELD16(28, 28, 0xcd0, 0x10, 2, 1)		/* CMD */
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_r0_range[] = {
+	PIN_FIELD16(23, 23, 0xd40, 0x10, 0, 1),
+	PIN_FIELD16(24, 24, 0xd40, 0x10, 4, 1),
+	PIN_FIELD16(25, 25, 0xd40, 0x10, 8, 1),
+	PIN_FIELD16(26, 26, 0xd40, 0x10, 12, 1),
+	PIN_FIELD16(27, 27, 0xcc0, 0x10, 0, 1),
+	PIN_FIELD16(28, 28, 0xcd0, 0x10, 0, 1),
+	PIN_FIELD16(100, 100, 0xd30, 0x10, 0, 1),
+	PIN_FIELD16(101, 101, 0xd30, 0x10, 4, 1),
+	PIN_FIELD16(102, 102, 0xd30, 0x10, 8, 1),
+	PIN_FIELD16(103, 103, 0xd30, 0x10, 12, 1),
+	PIN_FIELD16(104, 104, 0xc80, 0x10, 0, 1),
+	PIN_FIELD16(105, 105, 0xc90, 0x10, 0, 1),
+	PIN_FIELD16(119, 119, 0xe00, 0x10, 0, 1),
+	PIN_FIELD16(120, 120, 0xe00, 0x10, 4, 1),
+	PIN_FIELD16(121, 121, 0xe00, 0x10, 8, 1),
+	PIN_FIELD16(122, 122, 0xe10, 0x10, 0, 1),
+	PIN_FIELD16(123, 123, 0xe10, 0x10, 4, 1),
+	PIN_FIELD16(124, 124, 0xe10, 0x10, 8, 1),
+	PIN_FIELD16(138, 138, 0xd50, 0x10, 0, 1),
+	PIN_FIELD16(139, 139, 0xd60, 0x10, 0, 1),
+	PIN_FIELD16(140, 140, 0xd70, 0x10, 0, 1),
+	PIN_FIELD16(141, 141, 0xd70, 0x10, 1, 1),
+	PIN_FIELD16(142, 142, 0xd70, 0x10, 3, 1),
+	PIN_FIELD16(143, 143, 0xd70, 0x10, 5, 1),
+	PIN_FIELD16(144, 144, 0xd50, 0x10, 3, 1),
+	PIN_FIELD16(145, 145, 0xd50, 0x10, 5, 1),
+	PIN_FIELD16(146, 146, 0xd60, 0x10, 5, 1),
+	PIN_FIELD16(147, 147, 0xed0, 0x10, 4, 1),
+	PIN_FIELD16(148, 148, 0xed0, 0x10, 6, 1),
+	PIN_FIELD16(149, 149, 0xed0, 0x10, 8, 1),
+	PIN_FIELD16(150, 150, 0xed0, 0x10, 10, 1),
+	PIN_FIELD16(151, 151, 0xed0, 0x10, 12, 1),
+	PIN_FIELD16(152, 152, 0xd60, 0x10, 1, 1),
+	PIN_FIELD16(153, 153, 0xd60, 0x10, 3, 1),
+	PIN_FIELD16(154, 155, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(155, 156, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(156, 157, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(157, 158, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(158, 159, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(159, 160, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(160, 161, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(161, 161, 0xc20, 0x10, 0, 1),
+	PIN_FIELD16(162, 162, 0xc10, 0x10, 0, 1),
+	PIN_FIELD16(163, 163, 0xc00, 0x10, 0, 1),
+	PIN_FIELD16(164, 164, 0xd10, 0x10, 0, 1),
+	PIN_FIELD16(165, 165, 0xd00, 0x10, 0, 1),
+	PIN_FIELD16(170, 170, 0xc50, 0x10, 0, 1),
+	PIN_FIELD16(171, 171, 0xd20, 0x10, 0, 1),
+	PIN_FIELD16(172, 172, 0xd20, 0x10, 4, 1),
+	PIN_FIELD16(173, 173, 0xd20, 0x10, 8, 1),
+	PIN_FIELD16(174, 174, 0xd20, 0x10, 12, 1),
+	PIN_FIELD16(175, 175, 0xc40, 0x10, 0, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_r1_range[] = {
+	PIN_FIELD16(23, 23, 0xd40, 0x10, 1, 1),
+	PIN_FIELD16(24, 24, 0xd40, 0x10, 5, 1),
+	PIN_FIELD16(25, 25, 0xd40, 0x10, 9, 1),
+	PIN_FIELD16(26, 26, 0xd40, 0x10, 13, 1),
+	PIN_FIELD16(27, 27, 0xcc0, 0x10, 1, 1),
+	PIN_FIELD16(28, 28, 0xcd0, 0x10, 1, 1),
+	PIN_FIELD16(100, 100, 0xd30, 0x10, 1, 1),
+	PIN_FIELD16(101, 101, 0xd30, 0x10, 5, 1),
+	PIN_FIELD16(102, 102, 0xd30, 0x10, 9, 1),
+	PIN_FIELD16(103, 103, 0xd30, 0x10, 13, 1),
+	PIN_FIELD16(104, 104, 0xc80, 0x10, 1, 1),
+	PIN_FIELD16(105, 105, 0xc90, 0x10, 1, 1),
+	PIN_FIELD16(119, 119, 0xe00, 0x10, 1, 1),
+	PIN_FIELD16(120, 120, 0xe00, 0x10, 5, 1),
+	PIN_FIELD16(121, 121, 0xe00, 0x10, 9, 1),
+	PIN_FIELD16(122, 122, 0xe10, 0x10, 1, 1),
+	PIN_FIELD16(123, 123, 0xe10, 0x10, 5, 1),
+	PIN_FIELD16(124, 124, 0xe10, 0x10, 9, 1),
+	PIN_FIELD16(138, 138, 0xd50, 0x10, 1, 1),
+	PIN_FIELD16(139, 139, 0xd60, 0x10, 0, 1),
+	PIN_FIELD16(140, 140, 0xd70, 0x10, 0, 1),
+	PIN_FIELD16(141, 141, 0xd70, 0x10, 2, 1),
+	PIN_FIELD16(142, 142, 0xd70, 0x10, 4, 1),
+	PIN_FIELD16(143, 143, 0xd70, 0x10, 6, 1),
+	PIN_FIELD16(144, 144, 0xd50, 0x10, 4, 1),
+	PIN_FIELD16(145, 145, 0xd50, 0x10, 6, 1),
+	PIN_FIELD16(146, 146, 0xd60, 0x10, 6, 1),
+	PIN_FIELD16(147, 147, 0xed0, 0x10, 5, 1),
+	PIN_FIELD16(148, 148, 0xed0, 0x10, 7, 1),
+	PIN_FIELD16(149, 149, 0xed0, 0x10, 9, 1),
+	PIN_FIELD16(150, 150, 0xed0, 0x10, 11, 1),
+	PIN_FIELD16(151, 151, 0xed0, 0x10, 13, 1),
+	PIN_FIELD16(152, 152, 0xd60, 0x10, 2, 1),
+	PIN_FIELD16(153, 153, 0xd60, 0x10, 4, 1),
+	PIN_FIELD16(154, 155, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(155, 156, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(156, 157, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(157, 158, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(158, 159, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(159, 160, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(160, 161, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(161, 161, 0xc20, 0x10, 1, 1),
+	PIN_FIELD16(162, 162, 0xc10, 0x10, 1, 1),
+	PIN_FIELD16(163, 163, 0xc00, 0x10, 1, 1),
+	PIN_FIELD16(164, 164, 0xd10, 0x10, 1, 1),
+	PIN_FIELD16(165, 165, 0xd00, 0x10, 1, 1),
+	PIN_FIELD16(170, 170, 0xc50, 0x10, 1, 1),
+	PIN_FIELD16(171, 171, 0xd20, 0x10, 1, 1),
+	PIN_FIELD16(172, 172, 0xd20, 0x10, 5, 1),
+	PIN_FIELD16(173, 173, 0xd20, 0x10, 9, 1),
+	PIN_FIELD16(174, 174, 0xd20, 0x10, 13, 1),
+	PIN_FIELD16(175, 175, 0xc40, 0x10, 1, 1),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_drv_range[] = {
+	PINS_FIELD16(0, 4, 0xb30, 0x10, 13, 2),
+	PINS_FIELD16(5, 9, 0xb30, 0x10, 1, 2),
+	PINS_FIELD16(10, 15, 0xb30, 0x10, 5, 2),
+	PIN_FIELD16(16, 16, 0xb30, 0x10, 1, 2),
+	PINS_FIELD16(17, 19, 0xb70, 0x10, 5, 2),
+	PINS_FIELD16(20, 22, 0xb70, 0x10, 9, 2),
+	PINS_FIELD16(23, 26, 0xce0, 0x10, 8, 2),
+	PIN_FIELD16(27, 27, 0xcc0, 0x10, 8, 2),
+	PIN_FIELD16(28, 28, 0xcd0, 0x10, 8, 2),
+	PINS_FIELD16(29, 32, 0xb80, 0x10, 13, 2),
+	PIN_FIELD16(33, 33, 0xb10, 0x10, 13, 2),
+	PINS_FIELD16(34, 36, 0xb10, 0x10, 9, 2),
+	PINS_FIELD16(37, 38, 0xb10, 0x10, 5, 2),
+	PIN_FIELD16(39, 39, 0xb20, 0x10, 1, 2),
+	PIN_FIELD16(40, 40, 0xb20, 0x10, 5, 2),
+	PINS_FIELD16(41, 42, 0xb20, 0x10, 9, 2),
+	PINS_FIELD16(47, 61, 0xb00, 0x10, 9, 2),
+	PINS_FIELD16(62, 66, 0xb70, 0x10, 1, 2),
+	PINS_FIELD16(67, 67, 0xb00, 0x10, 9, 2),
+	PINS_FIELD16(68, 72, 0xb60, 0x10, 13, 2),
+	PINS_FIELD16(73, 77, 0xb40, 0x10, 13, 2),
+	PIN_FIELD16(78, 78, 0xb00, 0x10, 12, 3),
+	PINS_FIELD16(79, 91, 0xb00, 0x10, 13, 2),
+	PIN_FIELD16(92, 92, 0xb60, 0x10, 5, 2),
+	PINS_FIELD16(93, 95, 0xb60, 0x10, 1, 2),
+	PINS_FIELD16(96, 99, 0xb80, 0x10, 9, 2),
+	PINS_FIELD16(100, 103, 0xca0, 0x10, 8, 2),
+	PIN_FIELD16(104, 104, 0xc80, 0x10, 8, 2),
+	PIN_FIELD16(105, 105, 0xc90, 0x10, 8, 2),
+	PINS_FIELD16(106, 107, 0xb50, 0x10, 9, 2),
+	PINS_FIELD16(108, 112, 0xb50, 0x10, 1, 2),
+	PINS_FIELD16(113, 116, 0xb80, 0x10, 5, 2),
+	PINS_FIELD16(117, 118, 0xb90, 0x10, 1, 2),
+	PINS_FIELD16(119, 124, 0xb50, 0x10, 5, 2),
+	PIN_FIELD16(127, 127, 0xb70, 0x10, 5, 2),
+	PIN_FIELD16(128, 128, 0xb70, 0x10, 9, 2),
+	PIN_FIELD16(129, 129, 0xb40, 0x10, 9, 2),
+	PINS_FIELD16(130, 131, 0xb40, 0x10, 13, 2),
+	PINS_FIELD16(132, 135, 0xb40, 0x10, 9, 2),
+	PIN_FIELD16(138, 138, 0xb50, 0x10, 8, 2),
+	PIN_FIELD16(139, 139, 0xb60, 0x10, 8, 2),
+	PINS_FIELD16(140, 151, 0xb70, 0x10, 8, 2),
+	PINS_FIELD16(152, 153, 0xb60, 0x10, 8, 2),
+	PINS_FIELD16(153, 153, 0xb60, 0x10, 8, 2),
+	PINS_FIELD16(154, 161, 0xc20, 0x10, 8, 2),
+	PIN_FIELD16(162, 162, 0xc10, 0x10, 8, 2),
+	PIN_FIELD16(163, 163, 0xc00, 0x10, 8, 2),
+	PIN_FIELD16(164, 164, 0xd10, 0x10, 8, 2),
+	PIN_FIELD16(165, 165, 0xd00, 0x10, 8, 2),
+	PINS_FIELD16(166, 169, 0xb80, 0x10, 1, 2),
+	PINS_FIELD16(170, 173, 0xc60, 0x10, 8, 2),
+	PIN_FIELD16(174, 174, 0xc40, 0x10, 8, 2),
+	PIN_FIELD16(175, 175, 0xc50, 0x10, 8, 2),
+	PINS_FIELD16(176, 179, 0xb70, 0x10, 13, 2),
+	PIN_FIELD16(180, 180, 0xb00, 0x10, 5, 2),
+	PINS_FIELD16(181, 184, 0xb00, 0x10, 1, 2),
+	PINS_FIELD16(185, 191, 0xb60, 0x10, 9, 2),
+	PIN_FIELD16(192, 192, 0xb40, 0x10, 1, 2),
+	PINS_FIELD16(193, 194, 0xb40, 0x10, 5, 2),
+	PINS_FIELD16(195, 196, 0xb40, 0x10, 1, 2),
+};
+
+static const struct mtk_pin_field_calc mt6795_pin_sr_range[] = {
+	PINS_FIELD16(0, 4, 0xb30, 0x10, 15, 1),
+	PINS_FIELD16(5, 9, 0xb30, 0x10, 3, 1),
+	PINS_FIELD16(10, 15, 0xb30, 0x10, 7, 1),
+	PIN_FIELD16(16, 16, 0xb30, 0x10, 5, 1),
+	PINS_FIELD16(23, 26, 0xce0, 0x10, 12, 1),
+	PIN_FIELD16(27, 27, 0xcc0, 0x10, 12, 1),
+	PIN_FIELD16(28, 28, 0xcd0, 0x10, 12, 1),
+	PINS_FIELD16(29, 32, 0xb80, 0x10, 15, 1),
+	PIN_FIELD16(33, 33, 0xb10, 0x10, 15, 1),
+	PINS_FIELD16(34, 36, 0xb10, 0x10, 11, 1),
+	PINS_FIELD16(37, 38, 0xb10, 0x10, 7, 1),
+	PIN_FIELD16(39, 39, 0xb20, 0x10, 3, 1),
+	PIN_FIELD16(40, 40, 0xb20, 0x10, 7, 1),
+	PINS_FIELD16(41, 42, 0xb20, 0x10, 11, 1),
+	PINS_FIELD16(47, 61, 0xb00, 0x10, 11, 1),
+	PINS_FIELD16(62, 66, 0xb70, 0x10, 3, 1),
+	PINS_FIELD16(67, 67, 0xb00, 0x10, 11, 1),
+	PINS_FIELD16(68, 72, 0xb60, 0x10, 15, 1),
+	PINS_FIELD16(73, 77, 0xb40, 0x10, 15, 1),
+	PIN_FIELD16(78, 78, 0xb00, 0x10, 15, 3),
+	PINS_FIELD16(79, 91, 0xb00, 0x10, 15, 1),
+	PIN_FIELD16(92, 92, 0xb60, 0x10, 7, 1),
+	PINS_FIELD16(93, 95, 0xb60, 0x10, 3, 1),
+	PINS_FIELD16(96, 99, 0xb80, 0x10, 11, 1),
+	PINS_FIELD16(100, 103, 0xca0, 0x10, 12, 1),
+	PIN_FIELD16(104, 104, 0xc80, 0x10, 12, 1),
+	PIN_FIELD16(105, 105, 0xc90, 0x10, 12, 1),
+	PINS_FIELD16(106, 107, 0xb50, 0x10, 11, 1),
+	PINS_FIELD16(108, 112, 0xb50, 0x10, 3, 1),
+	PINS_FIELD16(113, 116, 0xb80, 0x10, 7, 1),
+	PINS_FIELD16(117, 118, 0xb90, 0x10, 3, 1),
+	PINS_FIELD16(119, 124, 0xb50, 0x10, 7, 1),
+	PIN_FIELD16(127, 127, 0xb70, 0x10, 7, 1),
+	PIN_FIELD16(128, 128, 0xb70, 0x10, 11, 1),
+	PIN_FIELD16(129, 129, 0xb40, 0x10, 11, 1),
+	PINS_FIELD16(130, 131, 0xb40, 0x10, 15, 1),
+	PINS_FIELD16(132, 135, 0xb40, 0x10, 11, 1),
+	PIN_FIELD16(138, 138, 0xb50, 0x10, 12, 1),
+	PIN_FIELD16(139, 139, 0xb60, 0x10, 12, 1),
+	PINS_FIELD16(140, 151, 0xb70, 0x10, 12, 1),
+	PINS_FIELD16(152, 153, 0xb60, 0x10, 12, 1),
+	PINS_FIELD16(153, 153, 0xb60, 0x10, 12, 1),
+	PINS_FIELD16(154, 161, 0xc20, 0x10, 12, 1),
+	PIN_FIELD16(162, 162, 0xc10, 0x10, 12, 1),
+	PIN_FIELD16(163, 163, 0xc00, 0x10, 12, 1),
+	PIN_FIELD16(164, 164, 0xd10, 0x10, 12, 1),
+	PIN_FIELD16(165, 165, 0xd00, 0x10, 12, 1),
+	PINS_FIELD16(166, 169, 0xb80, 0x10, 3, 1),
+	PINS_FIELD16(170, 173, 0xc60, 0x10, 12, 1),
+	PIN_FIELD16(174, 174, 0xc40, 0x10, 12, 1),
+	PIN_FIELD16(175, 175, 0xc50, 0x10, 12, 1),
+	PINS_FIELD16(176, 179, 0xb70, 0x10, 15, 1),
+	PIN_FIELD16(180, 180, 0xb00, 0x10, 7, 1),
+	PINS_FIELD16(181, 184, 0xb00, 0x10, 3, 1),
+	PINS_FIELD16(185, 191, 0xb60, 0x10, 11, 1),
+	PIN_FIELD16(192, 192, 0xb40, 0x10, 3, 1),
+	PINS_FIELD16(193, 194, 0xb40, 0x10, 7, 1),
+	PINS_FIELD16(195, 196, 0xb40, 0x10, 3, 1),
+};
+
+static const struct mtk_pin_reg_calc mt6795_reg_cals[PINCTRL_PIN_REG_MAX] = {
+	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt6795_pin_mode_range),
+	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt6795_pin_dir_range),
+	[PINCTRL_PIN_REG_DI] = MTK_RANGE(mt6795_pin_di_range),
+	[PINCTRL_PIN_REG_DO] = MTK_RANGE(mt6795_pin_do_range),
+	[PINCTRL_PIN_REG_SR] = MTK_RANGE(mt6795_pin_sr_range),
+	[PINCTRL_PIN_REG_SMT] = MTK_RANGE(mt6795_pin_smt_range),
+	[PINCTRL_PIN_REG_DRV] = MTK_RANGE(mt6795_pin_drv_range),
+	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt6795_pin_pupd_range),
+	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt6795_pin_r0_range),
+	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt6795_pin_r1_range),
+	[PINCTRL_PIN_REG_IES] = MTK_RANGE(mt6795_pin_ies_range),
+	[PINCTRL_PIN_REG_PULLEN] = MTK_RANGE(mt6795_pin_pullen_range),
+	[PINCTRL_PIN_REG_PULLSEL] = MTK_RANGE(mt6795_pin_pullsel_range),
+};
+
+static const struct mtk_eint_hw mt6795_eint_hw = {
+	.port_mask = 7,
+	.ports     = 7,
+	.ap_num    = 224,
+	.db_cnt    = 32,
+};
+
+static const unsigned int mt6795_pull_type[] = {
+	MTK_PULL_PULLSEL_TYPE,/*0*/		MTK_PULL_PULLSEL_TYPE,/*1*/
+	MTK_PULL_PULLSEL_TYPE,/*2*/		MTK_PULL_PULLSEL_TYPE,/*3*/
+	MTK_PULL_PULLSEL_TYPE,/*4*/		MTK_PULL_PULLSEL_TYPE,/*5*/
+	MTK_PULL_PULLSEL_TYPE,/*6*/		MTK_PULL_PULLSEL_TYPE,/*7*/
+	MTK_PULL_PULLSEL_TYPE,/*8*/		MTK_PULL_PULLSEL_TYPE,/*9*/
+	MTK_PULL_PULLSEL_TYPE,/*10*/		MTK_PULL_PULLSEL_TYPE,/*11*/
+	MTK_PULL_PULLSEL_TYPE,/*12*/		MTK_PULL_PULLSEL_TYPE,/*13*/
+	MTK_PULL_PULLSEL_TYPE,/*14*/		MTK_PULL_PULLSEL_TYPE,/*15*/
+	MTK_PULL_PULLSEL_TYPE,/*16*/		MTK_PULL_PULLSEL_TYPE,/*17*/
+	MTK_PULL_PULLSEL_TYPE,/*18*/		MTK_PULL_PULLSEL_TYPE,/*19*/
+	MTK_PULL_PULLSEL_TYPE,/*20*/		MTK_PULL_PULLSEL_TYPE,/*21*/
+	MTK_PULL_PULLSEL_TYPE,/*22*/		MTK_PULL_PUPD_R1R0_TYPE,/*23*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*24*/		MTK_PULL_PUPD_R1R0_TYPE,/*25*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*26*/		MTK_PULL_PUPD_R1R0_TYPE,/*27*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*28*/		MTK_PULL_PULLSEL_TYPE,/*29*/
+	MTK_PULL_PULLSEL_TYPE,/*30*/		MTK_PULL_PULLSEL_TYPE,/*31*/
+	MTK_PULL_PULLSEL_TYPE,/*32*/		MTK_PULL_PULLSEL_TYPE,/*33*/
+	MTK_PULL_PULLSEL_TYPE,/*34*/		MTK_PULL_PULLSEL_TYPE,/*35*/
+	MTK_PULL_PULLSEL_TYPE,/*36*/		MTK_PULL_PULLSEL_TYPE,/*37*/
+	MTK_PULL_PULLSEL_TYPE,/*38*/		MTK_PULL_PULLSEL_TYPE,/*39*/
+	MTK_PULL_PULLSEL_TYPE,/*40*/		MTK_PULL_PULLSEL_TYPE,/*41*/
+	MTK_PULL_PULLSEL_TYPE,/*42*/		MTK_PULL_PULLSEL_TYPE,/*43*/
+	MTK_PULL_PULLSEL_TYPE,/*44*/		MTK_PULL_PULLSEL_TYPE,/*45*/
+	MTK_PULL_PULLSEL_TYPE,/*46*/		MTK_PULL_PULLSEL_TYPE,/*47*/
+	MTK_PULL_PULLSEL_TYPE,/*48*/		MTK_PULL_PULLSEL_TYPE,/*49*/
+	MTK_PULL_PULLSEL_TYPE,/*50*/		MTK_PULL_PULLSEL_TYPE,/*51*/
+	MTK_PULL_PULLSEL_TYPE,/*52*/		MTK_PULL_PULLSEL_TYPE,/*53*/
+	MTK_PULL_PULLSEL_TYPE,/*54*/		MTK_PULL_PULLSEL_TYPE,/*55*/
+	MTK_PULL_PULLSEL_TYPE,/*56*/		MTK_PULL_PULLSEL_TYPE,/*57*/
+	MTK_PULL_PULLSEL_TYPE,/*58*/		MTK_PULL_PULLSEL_TYPE,/*59*/
+	MTK_PULL_PULLSEL_TYPE,/*60*/		MTK_PULL_PULLSEL_TYPE,/*61*/
+	MTK_PULL_PULLSEL_TYPE,/*62*/		MTK_PULL_PULLSEL_TYPE,/*63*/
+	MTK_PULL_PULLSEL_TYPE,/*64*/		MTK_PULL_PULLSEL_TYPE,/*65*/
+	MTK_PULL_PULLSEL_TYPE,/*66*/		MTK_PULL_PUPD_R1R0_TYPE,/*67*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*68*/		MTK_PULL_PUPD_R1R0_TYPE,/*69*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*70*/		MTK_PULL_PUPD_R1R0_TYPE,/*71*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*72*/		MTK_PULL_PUPD_R1R0_TYPE,/*73*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*74*/		MTK_PULL_PUPD_R1R0_TYPE,/*75*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*76*/		MTK_PULL_PUPD_R1R0_TYPE,/*77*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*78*/		MTK_PULL_PUPD_R1R0_TYPE,/*79*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*80*/		MTK_PULL_PUPD_R1R0_TYPE,/*81*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*82*/		MTK_PULL_PULLSEL_TYPE,/*83*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*84*/		MTK_PULL_PUPD_R1R0_TYPE,/*85*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*86*/		MTK_PULL_PUPD_R1R0_TYPE,/*87*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*88*/		MTK_PULL_PUPD_R1R0_TYPE,/*89*/
+	MTK_PULL_PULLSEL_TYPE,/*90*/		MTK_PULL_PULLSEL_TYPE,/*91*/
+	MTK_PULL_PULLSEL_TYPE,/*92*/		MTK_PULL_PULLSEL_TYPE,/*93*/
+	MTK_PULL_PULLSEL_TYPE,/*94*/		MTK_PULL_PULLSEL_TYPE,/*95*/
+	MTK_PULL_PULLSEL_TYPE,/*96*/		MTK_PULL_PULLSEL_TYPE,/*97*/
+	MTK_PULL_PULLSEL_TYPE,/*98*/		MTK_PULL_PULLSEL_TYPE,/*99*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*100*/		MTK_PULL_PUPD_R1R0_TYPE,/*101*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*102*/		MTK_PULL_PUPD_R1R0_TYPE,/*103*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*104*/		MTK_PULL_PUPD_R1R0_TYPE,/*105*/
+	MTK_PULL_PULLSEL_TYPE,/*106*/		MTK_PULL_PULLSEL_TYPE,/*107*/
+	MTK_PULL_PULLSEL_TYPE,/*108*/		MTK_PULL_PULLSEL_TYPE,/*109*/
+	MTK_PULL_PULLSEL_TYPE,/*110*/		MTK_PULL_PULLSEL_TYPE,/*111*/
+	MTK_PULL_PULLSEL_TYPE,/*112*/		MTK_PULL_PULLSEL_TYPE,/*113*/
+	MTK_PULL_PULLSEL_TYPE,/*114*/		MTK_PULL_PULLSEL_TYPE,/*115*/
+	MTK_PULL_PULLSEL_TYPE,/*116*/		MTK_PULL_PULLSEL_TYPE,/*117*/
+	MTK_PULL_PULLSEL_TYPE,/*118*/		MTK_PULL_PUPD_R1R0_TYPE,/*119*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*120*/		MTK_PULL_PUPD_R1R0_TYPE,/*121*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*122*/		MTK_PULL_PUPD_R1R0_TYPE,/*123*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*124*/		MTK_PULL_PULLSEL_TYPE,/*125*/
+	MTK_PULL_PULLSEL_TYPE,/*126*/		MTK_PULL_PULLSEL_TYPE,/*127*/
+	MTK_PULL_PULLSEL_TYPE,/*128*/		MTK_PULL_PULLSEL_TYPE,/*129*/
+	MTK_PULL_PULLSEL_TYPE,/*130*/		MTK_PULL_PULLSEL_TYPE,/*131*/
+	MTK_PULL_PULLSEL_TYPE,/*132*/		MTK_PULL_PULLSEL_TYPE,/*133*/
+	MTK_PULL_PULLSEL_TYPE,/*134*/		MTK_PULL_PULLSEL_TYPE,/*135*/
+	MTK_PULL_PULLSEL_TYPE,/*136*/		MTK_PULL_PULLSEL_TYPE,/*137*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*138*/		MTK_PULL_PUPD_R1R0_TYPE,/*139*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*140*/		MTK_PULL_PUPD_R1R0_TYPE,/*141*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*142*/		MTK_PULL_PUPD_R1R0_TYPE,/*143*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*144*/		MTK_PULL_PUPD_R1R0_TYPE,/*145*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*146*/		MTK_PULL_PUPD_R1R0_TYPE,/*147*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*148*/		MTK_PULL_PUPD_R1R0_TYPE,/*149*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*150*/		MTK_PULL_PUPD_R1R0_TYPE,/*151*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*152*/		MTK_PULL_PUPD_R1R0_TYPE,/*153*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*154*/		MTK_PULL_PUPD_R1R0_TYPE,/*155*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*156*/		MTK_PULL_PUPD_R1R0_TYPE,/*157*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*158*/		MTK_PULL_PUPD_R1R0_TYPE,/*159*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*160*/		MTK_PULL_PUPD_R1R0_TYPE,/*161*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*162*/		MTK_PULL_PUPD_R1R0_TYPE,/*163*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*164*/		MTK_PULL_PUPD_R1R0_TYPE,/*165*/
+	MTK_PULL_PULLSEL_TYPE,/*166*/		MTK_PULL_PULLSEL_TYPE,/*167*/
+	MTK_PULL_PULLSEL_TYPE,/*168*/		MTK_PULL_PULLSEL_TYPE,/*169*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*170*/		MTK_PULL_PUPD_R1R0_TYPE,/*171*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*172*/		MTK_PULL_PUPD_R1R0_TYPE,/*173*/
+	MTK_PULL_PUPD_R1R0_TYPE,/*174*/		MTK_PULL_PUPD_R1R0_TYPE,/*175*/
+	MTK_PULL_PULLSEL_TYPE,/*176*/		MTK_PULL_PULLSEL_TYPE,/*177*/
+	MTK_PULL_PULLSEL_TYPE,/*178*/		MTK_PULL_PULLSEL_TYPE,/*179*/
+	MTK_PULL_PULLSEL_TYPE,/*180*/		MTK_PULL_PULLSEL_TYPE,/*181*/
+	MTK_PULL_PULLSEL_TYPE,/*182*/		MTK_PULL_PULLSEL_TYPE,/*183*/
+	MTK_PULL_PULLSEL_TYPE,/*184*/		MTK_PULL_PULLSEL_TYPE,/*185*/
+	MTK_PULL_PULLSEL_TYPE,/*186*/		MTK_PULL_PULLSEL_TYPE,/*187*/
+	MTK_PULL_PULLSEL_TYPE,/*188*/		MTK_PULL_PULLSEL_TYPE,/*189*/
+	MTK_PULL_PULLSEL_TYPE,/*190*/		MTK_PULL_PULLSEL_TYPE,/*191*/
+	MTK_PULL_PULLSEL_TYPE,/*192*/		MTK_PULL_PULLSEL_TYPE,/*193*/
+	MTK_PULL_PULLSEL_TYPE,/*194*/		MTK_PULL_PULLSEL_TYPE,/*195*/
+	MTK_PULL_PULLSEL_TYPE,/*196*/
+};
+
+static const struct mtk_pin_soc mt6795_data = {
+	.reg_cal = mt6795_reg_cals,
+	.pins = mtk_pins_mt6795,
+	.npins = ARRAY_SIZE(mtk_pins_mt6795),
+	.ngrps = ARRAY_SIZE(mtk_pins_mt6795),
+	.nfuncs = 8,
+	.eint_hw = &mt6795_eint_hw,
+	.gpio_m = 0,
+	.base_names = mtk_default_register_base_names,
+	.nbase_names = ARRAY_SIZE(mtk_default_register_base_names),
+	.pull_type = mt6795_pull_type,
+	.bias_disable_set = mtk_pinconf_bias_disable_set_rev1,
+	.bias_disable_get = mtk_pinconf_bias_disable_get_rev1,
+	.bias_set = mtk_pinconf_bias_set_rev1,
+	.bias_get = mtk_pinconf_bias_get_rev1,
+	.bias_set_combo = mtk_pinconf_bias_set_combo,
+	.bias_get_combo = mtk_pinconf_bias_get_combo,
+	.drive_set = mtk_pinconf_drive_set_rev1,
+	.drive_get = mtk_pinconf_drive_get_rev1,
+	.adv_pull_get = mtk_pinconf_adv_pull_get,
+	.adv_pull_set = mtk_pinconf_adv_pull_set,
+};
+
+static const struct of_device_id mt6795_pctrl_match[] = {
+	{ .compatible = "mediatek,mt6795-pinctrl", .data = &mt6795_data },
+	{ }
+};
+
+static struct platform_driver mt6795_pinctrl_driver = {
+	.driver = {
+		.name = "mt6795-pinctrl",
+		.of_match_table = mt6795_pctrl_match,
+		.pm = &mtk_paris_pinctrl_pm_ops,
+	},
+	.probe = mtk_paris_pinctrl_probe,
+};
+
+static int __init mtk_pinctrl_init(void)
+{
+	return platform_driver_register(&mt6795_pinctrl_driver);
+}
+arch_initcall(mtk_pinctrl_init);
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h
new file mode 100644
index 000000000000..f639bd859116
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h
@@ -0,0 +1,1698 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __PINCTRL_MTK_MT6795_H
+#define __PINCTRL_MTK_MT6795_H
+
+#include "pinctrl-paris.h"
+
+static const struct mtk_pin_desc mtk_pins_mt6795[] = {
+	MTK_PIN(
+		0, "GPIO0",
+		MTK_EINT_FUNCTION(0, 0),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "IRDA_PDN"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "UTXD0")
+	),
+	MTK_PIN(
+		1, "GPIO1",
+		MTK_EINT_FUNCTION(0, 1),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "IRDA_RXD"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(3, "SDA4"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "URXD0")
+	),
+	MTK_PIN(
+		2, "GPIO2",
+		MTK_EINT_FUNCTION(0, 2),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "IRDA_TXD"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(3, "SCL4"),
+		MTK_FUNCTION(4, "TDD_TDI"),
+		MTK_FUNCTION(5, "UTXD3")
+	),
+	MTK_PIN(
+		3, "GPIO3",
+		MTK_EINT_FUNCTION(0, 3),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "DSI1_TE"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(3, "SDA3"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "URXD3")
+	),
+	MTK_PIN(
+		4, "GPIO4",
+		MTK_EINT_FUNCTION(0, 4),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "DISP_PWM1"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(3, "SCL3"),
+		MTK_FUNCTION(4, "TDD_TRSTN")
+	),
+	MTK_PIN(
+		5, "GPIO5",
+		MTK_EINT_FUNCTION(0, 5),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "I2S2_WS"),
+		MTK_FUNCTION(3, "SPI_CK_3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TMS")
+	),
+	MTK_PIN(
+		6, "GPIO6",
+		MTK_EINT_FUNCTION(0, 6),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "I2S2_BCK"),
+		MTK_FUNCTION(3, "SPI_MI_3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TCK")
+	),
+	MTK_PIN(
+		7, "GPIO7",
+		MTK_EINT_FUNCTION(0, 7),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "I2S2_DI_1"),
+		MTK_FUNCTION(3, "SPI_MO_3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDI")
+	),
+	MTK_PIN(
+		8, "GPIO8",
+		MTK_EINT_FUNCTION(0, 8),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "PCM1_DO"),
+		MTK_FUNCTION(2, "I2S2_DI_2"),
+		MTK_FUNCTION(3, "SPI_CS_3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDO")
+	),
+	MTK_PIN(
+		9, "GPIO9",
+		MTK_EINT_FUNCTION(0, 9),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "USB_DRVVBUS"),
+		MTK_FUNCTION(2, "I2S2_MCK"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TRST")
+	),
+	MTK_PIN(
+		10, "GPIO10",
+		MTK_EINT_FUNCTION(0, 10),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(2, "I2S0_WS")
+	),
+	MTK_PIN(
+		11, "GPIO11",
+		MTK_EINT_FUNCTION(0, 11),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(2, "I2S0_BCK")
+	),
+	MTK_PIN(
+		12, "GPIO12",
+		MTK_EINT_FUNCTION(0, 12),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(2, "I2S0_MCK")
+	),
+	MTK_PIN(
+		13, "GPIO13",
+		MTK_EINT_FUNCTION(0, 13),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(2, "I2S0_DO")
+	),
+	MTK_PIN(
+		14, "GPIO14",
+		MTK_EINT_FUNCTION(0, 14),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(2, "I2S0_DI"),
+		MTK_FUNCTION(3, "DISP_PWM1"),
+		MTK_FUNCTION(4, "PWM4"),
+		MTK_FUNCTION(5, "IRDA_RXD"),
+		MTK_FUNCTION(6, "I2S1_BCK")
+	),
+	MTK_PIN(
+		15, "GPIO15",
+		MTK_EINT_FUNCTION(0, 15),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(2, "DSI1_TE"),
+		MTK_FUNCTION(3, "USB_DRVVBUS"),
+		MTK_FUNCTION(4, "PWM5"),
+		MTK_FUNCTION(5, "IRDA_TXD"),
+		MTK_FUNCTION(6, "I2S1_MCK")
+	),
+	MTK_PIN(
+		16, "GPIO16",
+		MTK_EINT_FUNCTION(0, 16),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "IDDIG"),
+		MTK_FUNCTION(2, "FLASH"),
+		MTK_FUNCTION(3, "EXT_FRAME_SYNC"),
+		MTK_FUNCTION(4, "PWM5")
+	),
+	MTK_PIN(
+		17, "GPIO17",
+		MTK_EINT_FUNCTION(0, 17),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "SIM1_SCLK"),
+		MTK_FUNCTION(2, "SIM2_SCLK")
+	),
+	MTK_PIN(
+		18, "GPIO18",
+		MTK_EINT_FUNCTION(0, 18),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "SIM1_SRST"),
+		MTK_FUNCTION(2, "SIM2_SRST")
+	),
+	MTK_PIN(
+		19, "GPIO19",
+		MTK_EINT_FUNCTION(0, 19),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "SIM1_SDAT"),
+		MTK_FUNCTION(2, "SIM2_SDAT")
+	),
+	MTK_PIN(
+		20, "GPIO20",
+		MTK_EINT_FUNCTION(0, 20),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "SIM2_SCLK"),
+		MTK_FUNCTION(2, "SIM1_SCLK")
+	),
+	MTK_PIN(
+		21, "GPIO21",
+		MTK_EINT_FUNCTION(0, 21),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "SIM2_SRST"),
+		MTK_FUNCTION(2, "SIM1_SRST")
+	),
+	MTK_PIN(
+		22, "GPIO22",
+		MTK_EINT_FUNCTION(0, 22),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "SIM2_SDAT"),
+		MTK_FUNCTION(2, "SIM1_SDAT")
+	),
+	MTK_PIN(
+		23, "GPIO23",
+		MTK_EINT_FUNCTION(0, 23),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "MSDC3_DAT0")
+	),
+	MTK_PIN(
+		24, "GPIO24",
+		MTK_EINT_FUNCTION(0, 24),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "MSDC3_DAT1")
+	),
+	MTK_PIN(
+		25, "GPIO25",
+		MTK_EINT_FUNCTION(0, 25),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "MSDC3_DAT2")
+	),
+	MTK_PIN(
+		26, "GPIO26",
+		MTK_EINT_FUNCTION(0, 26),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "MSDC3_DAT3")
+	),
+	MTK_PIN(
+		27, "GPIO27",
+		MTK_EINT_FUNCTION(0, 27),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "MSDC3_CLK")
+	),
+	MTK_PIN(
+		28, "GPIO28",
+		MTK_EINT_FUNCTION(0, 28),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "MSDC3_CMD")
+	),
+	MTK_PIN(
+		29, "GPIO29",
+		MTK_EINT_FUNCTION(0, 29),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "PTA_RXD"),
+		MTK_FUNCTION(2, "UCTS2")
+	),
+	MTK_PIN(
+		30, "GPIO30",
+		MTK_EINT_FUNCTION(0, 30),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "PTA_TXD"),
+		MTK_FUNCTION(2, "URTS2")
+	),
+	MTK_PIN(
+		31, "GPIO31",
+		MTK_EINT_FUNCTION(0, 31),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "UTXD2")
+	),
+	MTK_PIN(
+		32, "GPIO32",
+		MTK_EINT_FUNCTION(0, 32),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "URXD2")
+	),
+	MTK_PIN(
+		33, "GPIO33",
+		MTK_EINT_FUNCTION(0, 33),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "MRG_CLK"),
+		MTK_FUNCTION(2, "PCM0_CLK")
+	),
+	MTK_PIN(
+		34, "GPIO34",
+		MTK_EINT_FUNCTION(0, 34),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "MRG_DI"),
+		MTK_FUNCTION(2, "PCM0_DI")
+	),
+	MTK_PIN(
+		35, "GPIO35",
+		MTK_EINT_FUNCTION(0, 35),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "MRG_DO"),
+		MTK_FUNCTION(2, "PCM0_DO")
+	),
+	MTK_PIN(
+		36, "GPIO36",
+		MTK_EINT_FUNCTION(0, 36),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "MRG_SYNC"),
+		MTK_FUNCTION(2, "PCM0_SYNC")
+	),
+	MTK_PIN(
+		37, "GPIO37",
+		MTK_EINT_FUNCTION(0, 37),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "GPS_SYNC")
+	),
+	MTK_PIN(
+		38, "GPIO38",
+		MTK_EINT_FUNCTION(0, 38),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "DAIRSTB")
+	),
+	MTK_PIN(
+		39, "GPIO39",
+		MTK_EINT_FUNCTION(0, 39),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "CM2MCLK")
+	),
+	MTK_PIN(
+		40, "GPIO40",
+		MTK_EINT_FUNCTION(0, 40),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "CM3MCLK"),
+		MTK_FUNCTION(2, "IRDA_PDN"),
+		MTK_FUNCTION(3, "PWM6"),
+		MTK_FUNCTION(4, "I2S1_WS")
+	),
+	MTK_PIN(
+		41, "GPIO41",
+		MTK_EINT_FUNCTION(0, 41),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "CMPCLK"),
+		MTK_FUNCTION(2, "CMCSK"),
+		MTK_FUNCTION(3, "FLASH")
+	),
+	MTK_PIN(
+		42, "GPIO42",
+		MTK_EINT_FUNCTION(0, 42),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "CMMCLK")
+	),
+	MTK_PIN(
+		43, "GPIO43",
+		MTK_EINT_FUNCTION(0, 43),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		44, "GPIO44",
+		MTK_EINT_FUNCTION(0, 44),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		45, "GPIO45",
+		MTK_EINT_FUNCTION(0, 45),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		46, "GPIO46",
+		MTK_EINT_FUNCTION(0, 46),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		47, "GPIO47",
+		MTK_EINT_FUNCTION(0, 47),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "BPI_BUS0")
+	),
+	MTK_PIN(
+		48, "GPIO48",
+		MTK_EINT_FUNCTION(0, 48),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "BPI_BUS1")
+	),
+	MTK_PIN(
+		49, "GPIO49",
+		MTK_EINT_FUNCTION(0, 49),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "BPI_BUS2")
+	),
+	MTK_PIN(
+		50, "GPIO50",
+		MTK_EINT_FUNCTION(0, 50),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "BPI_BUS3")
+	),
+	MTK_PIN(
+		51, "GPIO51",
+		MTK_EINT_FUNCTION(0, 51),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "BPI_BUS4")
+	),
+	MTK_PIN(
+		52, "GPIO52",
+		MTK_EINT_FUNCTION(0, 52),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "BPI_BUS5")
+	),
+	MTK_PIN(
+		53, "GPIO53",
+		MTK_EINT_FUNCTION(0, 53),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "BPI_BUS6")
+	),
+	MTK_PIN(
+		54, "GPIO54",
+		MTK_EINT_FUNCTION(0, 54),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "BPI_BUS7")
+	),
+	MTK_PIN(
+		55, "GPIO55",
+		MTK_EINT_FUNCTION(0, 55),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "BPI_BUS8")
+	),
+	MTK_PIN(
+		56, "GPIO56",
+		MTK_EINT_FUNCTION(0, 56),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "BPI_BUS9")
+	),
+	MTK_PIN(
+		57, "GPIO57",
+		MTK_EINT_FUNCTION(0, 57),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "BPI_BUS10")
+	),
+	MTK_PIN(
+		58, "GPIO58",
+		MTK_EINT_FUNCTION(0, 58),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "BPI_BUS11")
+	),
+	MTK_PIN(
+		59, "GPIO59",
+		MTK_EINT_FUNCTION(0, 59),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "BPI_BUS12")
+	),
+	MTK_PIN(
+		60, "GPIO60",
+		MTK_EINT_FUNCTION(0, 60),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "BPI_BUS13")
+	),
+	MTK_PIN(
+		61, "GPIO61",
+		MTK_EINT_FUNCTION(0, 61),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "BPI_BUS14")
+	),
+	MTK_PIN(
+		62, "GPIO62",
+		MTK_EINT_FUNCTION(0, 62),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "RFIC1_BSI_CK")
+	),
+	MTK_PIN(
+		63, "GPIO63",
+		MTK_EINT_FUNCTION(0, 63),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D0")
+	),
+	MTK_PIN(
+		64, "GPIO64",
+		MTK_EINT_FUNCTION(0, 64),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D1")
+	),
+	MTK_PIN(
+		65, "GPIO65",
+		MTK_EINT_FUNCTION(0, 65),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "RFIC1_BSI_D2")
+	),
+	MTK_PIN(
+		66, "GPIO66",
+		MTK_EINT_FUNCTION(0, 66),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "RFIC1_BSI_CS")
+	),
+	MTK_PIN(
+		67, "GPIO67",
+		MTK_EINT_FUNCTION(0, 67),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(1, "TD_TXBPI")
+	),
+	MTK_PIN(
+		68, "GPIO68",
+		MTK_EINT_FUNCTION(0, 68),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "RFIC0_BSI_CK")
+	),
+	MTK_PIN(
+		69, "GPIO69",
+		MTK_EINT_FUNCTION(0, 69),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D0")
+	),
+	MTK_PIN(
+		70, "GPIO70",
+		MTK_EINT_FUNCTION(0, 70),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO70"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D1")
+	),
+	MTK_PIN(
+		71, "GPIO71",
+		MTK_EINT_FUNCTION(0, 71),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "RFIC0_BSI_D2")
+	),
+	MTK_PIN(
+		72, "GPIO72",
+		MTK_EINT_FUNCTION(0, 72),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "RFIC0_BSI_CS")
+	),
+	MTK_PIN(
+		73, "GPIO73",
+		MTK_EINT_FUNCTION(0, 73),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "MISC_BSI_DO")
+	),
+	MTK_PIN(
+		74, "GPIO74",
+		MTK_EINT_FUNCTION(0, 74),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "MISC_BSI_CK")
+	),
+	MTK_PIN(
+		75, "GPIO75",
+		MTK_EINT_FUNCTION(0, 75),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "MISC_BSI_CS0B"),
+		MTK_FUNCTION(2, "MIPI1_SCLK")
+	),
+	MTK_PIN(
+		76, "GPIO76",
+		MTK_EINT_FUNCTION(0, 76),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "MISC_BSI_CS1B")
+	),
+	MTK_PIN(
+		77, "GPIO77",
+		MTK_EINT_FUNCTION(0, 77),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "MISC_BSI_DI"),
+		MTK_FUNCTION(2, "MIPI1_SDATA")
+	),
+	MTK_PIN(
+		78, "GPIO78",
+		MTK_EINT_FUNCTION(0, 78),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "LTE_TXBPI")
+	),
+	MTK_PIN(
+		79, "GPIO79",
+		MTK_EINT_FUNCTION(0, 79),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "BPI_BUS15")
+	),
+	MTK_PIN(
+		80, "GPIO80",
+		MTK_EINT_FUNCTION(0, 80),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "BPI_BUS16")
+	),
+	MTK_PIN(
+		81, "GPIO81",
+		MTK_EINT_FUNCTION(0, 81),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "BPI_BUS17")
+	),
+	MTK_PIN(
+		82, "GPIO82",
+		MTK_EINT_FUNCTION(0, 82),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "BPI_BUS18")
+	),
+	MTK_PIN(
+		83, "GPIO83",
+		MTK_EINT_FUNCTION(0, 83),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "BPI_BUS19")
+	),
+	MTK_PIN(
+		84, "GPIO84",
+		MTK_EINT_FUNCTION(0, 84),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "BPI_BUS20")
+	),
+	MTK_PIN(
+		85, "GPIO85",
+		MTK_EINT_FUNCTION(0, 85),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "BPI_BUS21")
+	),
+	MTK_PIN(
+		86, "GPIO86",
+		MTK_EINT_FUNCTION(0, 86),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "BPI_BUS22")
+	),
+	MTK_PIN(
+		87, "GPIO87",
+		MTK_EINT_FUNCTION(0, 87),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "BPI_BUS23")
+	),
+	MTK_PIN(
+		88, "GPIO88",
+		MTK_EINT_FUNCTION(0, 88),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "BPI_BUS24")
+	),
+	MTK_PIN(
+		89, "GPIO89",
+		MTK_EINT_FUNCTION(0, 89),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "BPI_BUS25")
+	),
+	MTK_PIN(
+		90, "GPIO90",
+		MTK_EINT_FUNCTION(0, 90),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "BPI_BUS26")
+	),
+	MTK_PIN(
+		91, "GPIO91",
+		MTK_EINT_FUNCTION(0, 91),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "BPI_BUS27")
+	),
+	MTK_PIN(
+		92, "GPIO92",
+		MTK_EINT_FUNCTION(0, 92),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "I2S0_BCK"),
+		MTK_FUNCTION(3, "NLD6")
+	),
+	MTK_PIN(
+		93, "GPIO93",
+		MTK_EINT_FUNCTION(0, 93),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "I2S0_WS"),
+		MTK_FUNCTION(3, "NLD7")
+	),
+	MTK_PIN(
+		94, "GPIO94",
+		MTK_EINT_FUNCTION(0, 94),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "I2S0_DI"),
+		MTK_FUNCTION(3, "NREB")
+	),
+	MTK_PIN(
+		95, "GPIO95",
+		MTK_EINT_FUNCTION(0, 95),
+		DRV_GRP0,
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "PCM1_DO"),
+		MTK_FUNCTION(2, "I2S0_DO"),
+		MTK_FUNCTION(3, "NRNB0")
+	),
+	MTK_PIN(
+		96, "GPIO96",
+		MTK_EINT_FUNCTION(0, 96),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1"),
+		MTK_FUNCTION(3, "NWEB")
+	),
+	MTK_PIN(
+		97, "GPIO97",
+		MTK_EINT_FUNCTION(0, 97),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1"),
+		MTK_FUNCTION(3, "NCEB0")
+	),
+	MTK_PIN(
+		98, "GPIO98",
+		MTK_EINT_FUNCTION(0, 98),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "URTS1"),
+		MTK_FUNCTION(2, "UCTS1"),
+		MTK_FUNCTION(3, "NALE")
+	),
+	MTK_PIN(
+		99, "GPIO99",
+		MTK_EINT_FUNCTION(0, 99),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "UCTS1"),
+		MTK_FUNCTION(2, "URTS1"),
+		MTK_FUNCTION(3, "NCLE")
+	),
+	MTK_PIN(
+		100, "GPIO100",
+		MTK_EINT_FUNCTION(0, 100),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(2, "URXD1"),
+		MTK_FUNCTION(3, "USB_DRVVBUS"),
+		MTK_FUNCTION(4, "SDA4")
+	),
+	MTK_PIN(
+		101, "GPIO101",
+		MTK_EINT_FUNCTION(0, 101),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(2, "UTXD1"),
+		MTK_FUNCTION(4, "SCL4")
+	),
+	MTK_PIN(
+		102, "GPIO102",
+		MTK_EINT_FUNCTION(0, 102),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(2, "URTS1"),
+		MTK_FUNCTION(3, "UTXD0"),
+		MTK_FUNCTION(5, "PWM0"),
+		MTK_FUNCTION(6, "SPI_CK_1")
+	),
+	MTK_PIN(
+		103, "GPIO103",
+		MTK_EINT_FUNCTION(0, 103),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(2, "UCTS1"),
+		MTK_FUNCTION(3, "URXD0"),
+		MTK_FUNCTION(5, "PWM1"),
+		MTK_FUNCTION(6, "SPI_MI_1")
+	),
+	MTK_PIN(
+		104, "GPIO104",
+		MTK_EINT_FUNCTION(0, 104),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(2, "NLD4"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "SDA3"),
+		MTK_FUNCTION(5, "PWM2"),
+		MTK_FUNCTION(6, "SPI_MO_1")
+	),
+	MTK_PIN(
+		105, "GPIO105",
+		MTK_EINT_FUNCTION(0, 105),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(2, "NLD5"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "SCL3"),
+		MTK_FUNCTION(5, "PWM3"),
+		MTK_FUNCTION(6, "SPI_CS_1")
+	),
+	MTK_PIN(
+		106, "GPIO106",
+		MTK_EINT_FUNCTION(0, 106),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "LCM_RST")
+	),
+	MTK_PIN(
+		107, "GPIO107",
+		MTK_EINT_FUNCTION(0, 107),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "DSI_TE")
+	),
+	MTK_PIN(
+		108, "GPIO108",
+		MTK_EINT_FUNCTION(0, 108),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "JTMS"),
+		MTK_FUNCTION(2, "MFG_JTAG_TMS"),
+		MTK_FUNCTION(3, "TDD_TMS"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TMS"),
+		MTK_FUNCTION(6, "DFD_TMS")
+	),
+	MTK_PIN(
+		109, "GPIO109",
+		MTK_EINT_FUNCTION(0, 109),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(1, "JTCK"),
+		MTK_FUNCTION(2, "MFG_JTAG_TCK"),
+		MTK_FUNCTION(3, "TDD_TCK"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TCK"),
+		MTK_FUNCTION(6, "DFD_TCK")
+	),
+	MTK_PIN(
+		110, "GPIO110",
+		MTK_EINT_FUNCTION(0, 110),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "JTDI"),
+		MTK_FUNCTION(2, "MFG_JTAG_TDI"),
+		MTK_FUNCTION(3, "TDD_TDI"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDI"),
+		MTK_FUNCTION(6, "DFD_TDI")
+	),
+	MTK_PIN(
+		111, "GPIO111",
+		MTK_EINT_FUNCTION(0, 111),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "JTDO"),
+		MTK_FUNCTION(2, "MFG_JTAG_TDO"),
+		MTK_FUNCTION(3, "TDD_TDO"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TDO"),
+		MTK_FUNCTION(6, "DFD_TDO")
+	),
+	MTK_PIN(
+		112, "GPIO112",
+		MTK_EINT_FUNCTION(0, 112),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "JTRST_B"),
+		MTK_FUNCTION(2, "MFG_JTAG_TRSTN"),
+		MTK_FUNCTION(3, "TDD_TRSTN"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(5, "AP_MD32_JTAG_TRST"),
+		MTK_FUNCTION(6, "DFD_NTRST")
+	),
+	MTK_PIN(
+		113, "GPIO113",
+		MTK_EINT_FUNCTION(0, 113),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "LTE_URXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "I2S2_WS")
+	),
+	MTK_PIN(
+		114, "GPIO114",
+		MTK_EINT_FUNCTION(0, 114),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "LTE_UTXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "I2S2_BCK")
+	),
+	MTK_PIN(
+		115, "GPIO115",
+		MTK_EINT_FUNCTION(0, 115),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "URTS0"),
+		MTK_FUNCTION(2, "UCTS0"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "LTE_URXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "I2S2_MCK")
+	),
+	MTK_PIN(
+		116, "GPIO116",
+		MTK_EINT_FUNCTION(0, 116),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "UCTS0"),
+		MTK_FUNCTION(2, "URTS0"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "LTE_UTXD"),
+		MTK_FUNCTION(5, "TDD_TXD"),
+		MTK_FUNCTION(6, "I2S2_DI_1")
+	),
+	MTK_PIN(
+		117, "GPIO117",
+		MTK_EINT_FUNCTION(0, 117),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "UTXD3"),
+		MTK_FUNCTION(3, "MD_URXD"),
+		MTK_FUNCTION(4, "LTE_URXD"),
+		MTK_FUNCTION(5, "TDD_TXD")
+	),
+	MTK_PIN(
+		118, "GPIO118",
+		MTK_EINT_FUNCTION(0, 118),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "URXD3"),
+		MTK_FUNCTION(3, "MD_UTXD"),
+		MTK_FUNCTION(4, "LTE_UTXD"),
+		MTK_FUNCTION(5, "TDD_TXD")
+	),
+	MTK_PIN(
+		119, "GPIO119",
+		MTK_EINT_FUNCTION(0, 119),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "KROW0")
+	),
+	MTK_PIN(
+		120, "GPIO120",
+		MTK_EINT_FUNCTION(0, 120),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "KROW1"),
+		MTK_FUNCTION(3, "PWM6")
+	),
+	MTK_PIN(
+		121, "GPIO121",
+		MTK_EINT_FUNCTION(0, 121),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "KROW2"),
+		MTK_FUNCTION(2, "IRDA_PDN"),
+		MTK_FUNCTION(3, "I2S1_DO_1"),
+		MTK_FUNCTION(4, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "SPI_CK_2"),
+		MTK_FUNCTION(6, "PWM4")
+	),
+	MTK_PIN(
+		122, "GPIO122",
+		MTK_EINT_FUNCTION(0, 122),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "KCOL0")
+	),
+	MTK_PIN(
+		123, "GPIO123",
+		MTK_EINT_FUNCTION(0, 123),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "KCOL1"),
+		MTK_FUNCTION(2, "IRDA_RXD"),
+		MTK_FUNCTION(3, "I2S2_DI_2"),
+		MTK_FUNCTION(4, "PWM5")
+	),
+	MTK_PIN(
+		124, "GPIO124",
+		MTK_EINT_FUNCTION(0, 124),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "KCOL2"),
+		MTK_FUNCTION(2, "IRDA_TXD"),
+		MTK_FUNCTION(3, "I2S1_DO_2"),
+		MTK_FUNCTION(4, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "SPI_MI_2"),
+		MTK_FUNCTION(6, "PWM3")
+	),
+	MTK_PIN(
+		125, "GPIO125",
+		MTK_EINT_FUNCTION(0, 125),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		126, "GPIO126",
+		MTK_EINT_FUNCTION(0, 126),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		127, "GPIO127",
+		MTK_EINT_FUNCTION(1, 127),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "MD_EINT1"),
+		MTK_FUNCTION(2, "DISP_PWM1"),
+		MTK_FUNCTION(3, "SPI_MO_2")
+	),
+	MTK_PIN(
+		128, "GPIO128",
+		MTK_EINT_FUNCTION(1, 128),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "MD_EINT2"),
+		MTK_FUNCTION(2, "DSI1_TE"),
+		MTK_FUNCTION(3, "SPI_CS_2")
+	),
+	MTK_PIN(
+		129, "GPIO129",
+		MTK_EINT_FUNCTION(0, 129),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "I2S3_WS"),
+		MTK_FUNCTION(2, "I2S2_WS"),
+		MTK_FUNCTION(3, "PWM0")
+	),
+	MTK_PIN(
+		130, "GPIO130",
+		MTK_EINT_FUNCTION(0, 130),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "I2S3_BCK"),
+		MTK_FUNCTION(2, "I2S2_BCK"),
+		MTK_FUNCTION(3, "PWM1")
+	),
+	MTK_PIN(
+		131, "GPIO131",
+		MTK_EINT_FUNCTION(0, 131),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "I2S3_MCK"),
+		MTK_FUNCTION(2, "I2S2_MCK"),
+		MTK_FUNCTION(3, "PWM2")
+	),
+	MTK_PIN(
+		132, "GPIO132",
+		MTK_EINT_FUNCTION(0, 132),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "I2S3_DO_1"),
+		MTK_FUNCTION(2, "I2S2_DI_1"),
+		MTK_FUNCTION(3, "PWM3")
+	),
+	MTK_PIN(
+		133, "GPIO133",
+		MTK_EINT_FUNCTION(0, 133),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "I2S3_DO_2"),
+		MTK_FUNCTION(2, "I2S2_DI_2"),
+		MTK_FUNCTION(3, "PWM4")
+	),
+	MTK_PIN(
+		134, "GPIO134",
+		MTK_EINT_FUNCTION(0, 134),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "I2S3_DO_3"),
+		MTK_FUNCTION(2, "DISP_PWM1"),
+		MTK_FUNCTION(3, "I2S1_DO_1"),
+		MTK_FUNCTION(4, "PWM5")
+	),
+	MTK_PIN(
+		135, "GPIO135",
+		MTK_EINT_FUNCTION(0, 135),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "I2S3_DO_4"),
+		MTK_FUNCTION(2, "DSI1_TE"),
+		MTK_FUNCTION(3, "I2S1_DO_2"),
+		MTK_FUNCTION(4, "PWM6")
+	),
+	MTK_PIN(
+		136, "GPIO136",
+		MTK_EINT_FUNCTION(0, 136),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "SDA3")
+	),
+	MTK_PIN(
+		137, "GPIO137",
+		MTK_EINT_FUNCTION(0, 137),
+		DRV_FIXED,
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "SCL3")
+	),
+	MTK_PIN(
+		138, "GPIO138",
+		MTK_EINT_FUNCTION(0, 138),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "DPI_CK"),
+		MTK_FUNCTION(2, "NLD6"),
+		MTK_FUNCTION(3, "UTXD0"),
+		MTK_FUNCTION(4, "USB_DRVVBUS"),
+		MTK_FUNCTION(5, "IRDA_PDN")
+	),
+	MTK_PIN(
+		139, "GPIO139",
+		MTK_EINT_FUNCTION(0, 139),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "DPI_DE"),
+		MTK_FUNCTION(2, "NLD7"),
+		MTK_FUNCTION(3, "URXD0"),
+		MTK_FUNCTION(4, "MD_UTXD"),
+		MTK_FUNCTION(5, "IRDA_RXD")
+	),
+	MTK_PIN(
+		140, "GPIO140",
+		MTK_EINT_FUNCTION(0, 140),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(1, "DPI_D0"),
+		MTK_FUNCTION(2, "NREB"),
+		MTK_FUNCTION(3, "UCTS0"),
+		MTK_FUNCTION(4, "MD_URXD"),
+		MTK_FUNCTION(5, "IRDA_TXD")
+	),
+	MTK_PIN(
+		141, "GPIO141",
+		MTK_EINT_FUNCTION(0, 141),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "DPI_D1"),
+		MTK_FUNCTION(2, "NRNB0"),
+		MTK_FUNCTION(3, "URTS0"),
+		MTK_FUNCTION(4, "LTE_UTXD"),
+		MTK_FUNCTION(5, "I2S2_WS")
+	),
+	MTK_PIN(
+		142, "GPIO142",
+		MTK_EINT_FUNCTION(0, 142),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "DPI_D2"),
+		MTK_FUNCTION(2, "NWEB"),
+		MTK_FUNCTION(3, "UTXD1"),
+		MTK_FUNCTION(4, "LTE_URXD"),
+		MTK_FUNCTION(5, "I2S2_BCK")
+	),
+	MTK_PIN(
+		143, "GPIO143",
+		MTK_EINT_FUNCTION(0, 143),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "DPI_D3"),
+		MTK_FUNCTION(2, "NCEB0"),
+		MTK_FUNCTION(3, "URXD1"),
+		MTK_FUNCTION(4, "TDD_TXD"),
+		MTK_FUNCTION(5, "I2S2_MCK")
+	),
+	MTK_PIN(
+		144, "GPIO144",
+		MTK_EINT_FUNCTION(0, 144),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "DPI_D4"),
+		MTK_FUNCTION(2, "NALE"),
+		MTK_FUNCTION(3, "UCTS1"),
+		MTK_FUNCTION(4, "TDD_TMS"),
+		MTK_FUNCTION(5, "I2S2_DI_1")
+	),
+	MTK_PIN(
+		145, "GPIO145",
+		MTK_EINT_FUNCTION(0, 145),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "DPI_D5"),
+		MTK_FUNCTION(2, "NCLE"),
+		MTK_FUNCTION(3, "URTS1"),
+		MTK_FUNCTION(4, "TDD_TCK"),
+		MTK_FUNCTION(5, "I2S2_DI_2")
+	),
+	MTK_PIN(
+		146, "GPIO146",
+		MTK_EINT_FUNCTION(0, 146),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "DPI_D6"),
+		MTK_FUNCTION(2, "NLD8"),
+		MTK_FUNCTION(3, "UTXD2"),
+		MTK_FUNCTION(4, "TDD_TDI")
+	),
+	MTK_PIN(
+		147, "GPIO147",
+		MTK_EINT_FUNCTION(0, 147),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "DPI_D7"),
+		MTK_FUNCTION(2, "NLD9"),
+		MTK_FUNCTION(3, "URXD2"),
+		MTK_FUNCTION(4, "TDD_TDO"),
+		MTK_FUNCTION(5, "I2S1_WS")
+	),
+	MTK_PIN(
+		148, "GPIO148",
+		MTK_EINT_FUNCTION(0, 148),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "DPI_D8"),
+		MTK_FUNCTION(2, "NLD10"),
+		MTK_FUNCTION(3, "UCTS2"),
+		MTK_FUNCTION(4, "TDD_TRSTN"),
+		MTK_FUNCTION(5, "I2S1_BCK")
+	),
+	MTK_PIN(
+		149, "GPIO149",
+		MTK_EINT_FUNCTION(0, 149),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(1, "DPI_D9"),
+		MTK_FUNCTION(2, "NLD11"),
+		MTK_FUNCTION(3, "URTS2"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TMS"),
+		MTK_FUNCTION(5, "I2S1_MCK")
+	),
+	MTK_PIN(
+		150, "GPIO150",
+		MTK_EINT_FUNCTION(0, 150),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(1, "DPI_D10"),
+		MTK_FUNCTION(2, "NLD12"),
+		MTK_FUNCTION(3, "UTXD3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TCK"),
+		MTK_FUNCTION(5, "I2S1_DO_1")
+	),
+	MTK_PIN(
+		151, "GPIO151",
+		MTK_EINT_FUNCTION(0, 151),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(1, "DPI_D11"),
+		MTK_FUNCTION(2, "NLD13"),
+		MTK_FUNCTION(3, "URXD3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDI"),
+		MTK_FUNCTION(5, "I2S1_DO_2")
+	),
+	MTK_PIN(
+		152, "GPIO152",
+		MTK_EINT_FUNCTION(0, 152),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(1, "DPI_HSYNC"),
+		MTK_FUNCTION(2, "NLD14"),
+		MTK_FUNCTION(3, "UCTS3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TDO"),
+		MTK_FUNCTION(5, "DSI1_TE")
+	),
+	MTK_PIN(
+		153, "GPIO153",
+		MTK_EINT_FUNCTION(0, 153),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(1, "DPI_VSYNC"),
+		MTK_FUNCTION(2, "NLD15"),
+		MTK_FUNCTION(3, "URTS3"),
+		MTK_FUNCTION(4, "LTE_MD32_JTAG_TRST"),
+		MTK_FUNCTION(5, "DISP_PWM1")
+	),
+	MTK_PIN(
+		154, "GPIO154",
+		MTK_EINT_FUNCTION(0, 154),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(1, "MSDC0_DAT0"),
+		MTK_FUNCTION(2, "NLD8")
+	),
+	MTK_PIN(
+		155, "GPIO155",
+		MTK_EINT_FUNCTION(0, 155),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(1, "MSDC0_DAT1"),
+		MTK_FUNCTION(2, "NLD9")
+	),
+	MTK_PIN(
+		156, "GPIO156",
+		MTK_EINT_FUNCTION(0, 156),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(1, "MSDC0_DAT2"),
+		MTK_FUNCTION(2, "NLD10")
+	),
+	MTK_PIN(
+		157, "GPIO157",
+		MTK_EINT_FUNCTION(0, 157),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(1, "MSDC0_DAT3"),
+		MTK_FUNCTION(2, "NLD11")
+	),
+	MTK_PIN(
+		158, "GPIO158",
+		MTK_EINT_FUNCTION(0, 158),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(1, "MSDC0_DAT4"),
+		MTK_FUNCTION(2, "NLD12")
+	),
+	MTK_PIN(
+		159, "GPIO159",
+		MTK_EINT_FUNCTION(0, 159),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(1, "MSDC0_DAT5"),
+		MTK_FUNCTION(2, "NLD13")
+	),
+	MTK_PIN(
+		160, "GPIO160",
+		MTK_EINT_FUNCTION(0, 160),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(1, "MSDC0_DAT6"),
+		MTK_FUNCTION(2, "NLD14")
+	),
+	MTK_PIN(
+		161, "GPIO161",
+		MTK_EINT_FUNCTION(0, 161),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(1, "MSDC0_DAT7"),
+		MTK_FUNCTION(2, "NLD15")
+	),
+	MTK_PIN(
+		162, "GPIO162",
+		MTK_EINT_FUNCTION(0, 162),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(1, "MSDC0_CMD")
+	),
+	MTK_PIN(
+		163, "GPIO163",
+		MTK_EINT_FUNCTION(0, 163),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(1, "MSDC0_CLK")
+	),
+	MTK_PIN(
+		164, "GPIO164",
+		MTK_EINT_FUNCTION(0, 164),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(1, "MSDC0_DSL")
+	),
+	MTK_PIN(
+		165, "GPIO165",
+		MTK_EINT_FUNCTION(0, 165),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO165"),
+		MTK_FUNCTION(1, "MSDC0_RSTB")
+	),
+	MTK_PIN(
+		166, "GPIO166",
+		MTK_EINT_FUNCTION(0, 166),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO166"),
+		MTK_FUNCTION(1, "SPI_CK_0"),
+		MTK_FUNCTION(3, "PWM0")
+	),
+	MTK_PIN(
+		167, "GPIO167",
+		MTK_EINT_FUNCTION(0, 167),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO167"),
+		MTK_FUNCTION(1, "SPI_MI_0"),
+		MTK_FUNCTION(3, "PWM1"),
+		MTK_FUNCTION(4, "SPI_MO_0")
+	),
+	MTK_PIN(
+		168, "GPIO168",
+		MTK_EINT_FUNCTION(2, 168),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO168"),
+		MTK_FUNCTION(1, "SPI_MO_0"),
+		MTK_FUNCTION(2, "MD_EINT3"),
+		MTK_FUNCTION(3, "PWM2"),
+		MTK_FUNCTION(4, "SPI_MI_0")
+	),
+	MTK_PIN(
+		169, "GPIO169",
+		MTK_EINT_FUNCTION(2, 169),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "SPI_CS_0"),
+		MTK_FUNCTION(2, "MD_EINT4"),
+		MTK_FUNCTION(3, "PWM3")
+	),
+	MTK_PIN(
+		170, "GPIO170",
+		MTK_EINT_FUNCTION(0, 170),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "MSDC1_CMD")
+	),
+	MTK_PIN(
+		171, "GPIO171",
+		MTK_EINT_FUNCTION(0, 171),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "MSDC1_DAT0")
+	),
+	MTK_PIN(
+		172, "GPIO172",
+		MTK_EINT_FUNCTION(0, 172),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "MSDC1_DAT1")
+	),
+	MTK_PIN(
+		173, "GPIO173",
+		MTK_EINT_FUNCTION(0, 173),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "MSDC1_DAT2")
+	),
+	MTK_PIN(
+		174, "GPIO174",
+		MTK_EINT_FUNCTION(0, 174),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "MSDC1_DAT3")
+	),
+	MTK_PIN(
+		175, "GPIO175",
+		MTK_EINT_FUNCTION(0, 175),
+		DRV_GRP4,
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "MSDC1_CLK")
+	),
+	MTK_PIN(
+		176, "GPIO176",
+		MTK_EINT_FUNCTION(0, 176),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "PWRAP_SPIMI"),
+		MTK_FUNCTION(2, "PWRAP_SPIMO")
+	),
+	MTK_PIN(
+		177, "GPIO177",
+		MTK_EINT_FUNCTION(0, 177),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "PWRAP_SPIMO"),
+		MTK_FUNCTION(2, "PWRAP_SPIMI")
+	),
+	MTK_PIN(
+		178, "GPIO178",
+		MTK_EINT_FUNCTION(0, 178),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "PWRAP_SPICK")
+	),
+	MTK_PIN(
+		179, "GPIO179",
+		MTK_EINT_FUNCTION(0, 179),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "PWRAP_SPICS")
+	),
+	MTK_PIN(
+		180, "GPIO180",
+		MTK_EINT_FUNCTION(0, 180),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "AUD_CLK_MOSI"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(3, "I2S2_WS"),
+		MTK_FUNCTION(4, "I2S0_WS")
+	),
+	MTK_PIN(
+		181, "GPIO181",
+		MTK_EINT_FUNCTION(0, 181),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO_1"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(3, "I2S2_BCK"),
+		MTK_FUNCTION(4, "I2S0_BCK")
+	),
+	MTK_PIN(
+		182, "GPIO182",
+		MTK_EINT_FUNCTION(0, 182),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI_1"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(3, "I2S2_MCK"),
+		MTK_FUNCTION(4, "I2S0_MCK")
+	),
+	MTK_PIN(
+		183, "GPIO183",
+		MTK_EINT_FUNCTION(0, 183),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "AUD_DAT_MISO_2"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(3, "I2S2_DI_1"),
+		MTK_FUNCTION(4, "I2S0_DO")
+	),
+	MTK_PIN(
+		184, "GPIO184",
+		MTK_EINT_FUNCTION(0, 184),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "AUD_DAT_MOSI_2"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(3, "I2S2_DI_2"),
+		MTK_FUNCTION(4, "I2S0_DI")
+	),
+	MTK_PIN(
+		185, "GPIO185",
+		MTK_EINT_FUNCTION(0, 185),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "RTC32K_CK")
+	),
+	MTK_PIN(
+		186, "GPIO186",
+		MTK_EINT_FUNCTION(0, 186),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "DISP_PWM0"),
+		MTK_FUNCTION(2, "DISP_PWM1")
+	),
+	MTK_PIN(
+		187, "GPIO187",
+		MTK_EINT_FUNCTION(0, 187),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "SRCLKENAI")
+	),
+	MTK_PIN(
+		188, "GPIO188",
+		MTK_EINT_FUNCTION(0, 188),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "SRCLKENAI2")
+	),
+	MTK_PIN(
+		189, "GPIO189",
+		MTK_EINT_FUNCTION(0, 189),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(1, "SRCLKENA0")
+	),
+	MTK_PIN(
+		190, "GPIO190",
+		MTK_EINT_FUNCTION(0, 190),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "SRCLKENA1")
+	),
+	MTK_PIN(
+		191, "GPIO191",
+		MTK_EINT_FUNCTION(0, 191),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "WATCHDOG_AO")
+	),
+	MTK_PIN(
+		192, "GPIO192",
+		MTK_EINT_FUNCTION(0, 192),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "I2S0_WS"),
+		MTK_FUNCTION(2, "I2S1_WS"),
+		MTK_FUNCTION(3, "I2S2_WS"),
+		MTK_FUNCTION(4, "NCEB1")
+	),
+	MTK_PIN(
+		193, "GPIO193",
+		MTK_EINT_FUNCTION(0, 193),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "I2S0_BCK"),
+		MTK_FUNCTION(2, "I2S1_BCK"),
+		MTK_FUNCTION(3, "I2S2_BCK"),
+		MTK_FUNCTION(4, "NRNB1")
+	),
+	MTK_PIN(
+		194, "GPIO194",
+		MTK_EINT_FUNCTION(0, 194),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "I2S0_MCK"),
+		MTK_FUNCTION(2, "I2S1_MCK"),
+		MTK_FUNCTION(3, "I2S2_MCK")
+	),
+	MTK_PIN(
+		195, "GPIO195",
+		MTK_EINT_FUNCTION(0, 195),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "I2S0_DO"),
+		MTK_FUNCTION(2, "I2S1_DO_1"),
+		MTK_FUNCTION(3, "I2S2_DI_1")
+	),
+	MTK_PIN(
+		196, "GPIO196",
+		MTK_EINT_FUNCTION(0, 196),
+		DRV_GRP2,
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "I2S0_DI"),
+		MTK_FUNCTION(2, "I2S1_DO_2"),
+		MTK_FUNCTION(3, "I2S2_DI_2")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT6795_H */
-- 
2.35.1


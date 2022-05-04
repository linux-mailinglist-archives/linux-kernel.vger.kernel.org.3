Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBD519F73
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349538AbiEDMeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiEDMeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:34:18 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C414099;
        Wed,  4 May 2022 05:30:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gh6so2627798ejb.0;
        Wed, 04 May 2022 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysH00HyaDWMX3g6z4wMVizpKRp8qVpyqeMYEzT6C4WY=;
        b=UmOQeFRlgk1stR2NmLpQW+SDcyKo7NYlY5RN8eB9sAoG+7DFYiW5P69CUQ14Qswzee
         8uadORkcp8BMGnvvz59WqMr+rlTLKLDiCY6QTIrQh6HCWFhw4JTJVnUw1zrmoGSZ+JJw
         TG4g2tKBxg9j+aUx81OAbAxxyanm/A/VIPcqjFiO43okoqNbsqziHTHKp8M4/yWIE5ID
         hWZ0+2ZKMkfDpa8F+CVv8oisIF1QuowYHmTAFIKw41+0G3YctIj03YPxOYPitcUqP29g
         d6fivTck2GEhetzgC44rVRxV1i5iYNECGt80oOs1s0clzm2IvDE4qspPT5pxq27vcTJ+
         CA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysH00HyaDWMX3g6z4wMVizpKRp8qVpyqeMYEzT6C4WY=;
        b=sWIB4c5Ej3PJPYNpaKIaFSP7fd7zNIS7d/zT2e2LmMoUyrGZZGIVWWOjeJefMVcDQU
         03JPxABrF9Jx12E4Jblc090WhelrpjJVUvhXgafLo06Gg+2h5w3rC5RIK9SUtqoZ9GV4
         OByIgnHO17GEQG8iRUMGE/UX7dqNoIUVO4hyHUWsqPbxTnsPIhGPQfQsGiwyJqLdSi8p
         oar/CRC2ZTAYUC0+yPbGnhcwo6oFxUY7EPtXrAIC9hrCgo/D0cSqigoq+n/5Y9fsD0ta
         atrQO5ERf8+/rC7S4f/NMTnGun/0HLxXFn9zh8H1sEsYWZratiJ5bAMsJKTWNw1DEWX4
         xzrw==
X-Gm-Message-State: AOAM533ZXhSirDkp4QQN1dL5mwkhZZcuMngonEwh0Gkl/w4wDvIObb0t
        +0MWx/Ej1SRJ74V9HR2mNKE=
X-Google-Smtp-Source: ABdhPJzqrcu+vGdjVz8arDFDG21wP7cRG4mf/U2UT7S5YNTI5mlnaRQ/efBX7UUbFJ6GRQov/bRnlA==
X-Received: by 2002:a17:907:3f16:b0:6f4:c54:2700 with SMTP id hq22-20020a1709073f1600b006f40c542700mr20290260ejc.615.1651667440245;
        Wed, 04 May 2022 05:30:40 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:30:39 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 01/13] dt-bindings: clock: Add Mediatek MT6735 clock bindings
Date:   Wed,  4 May 2022 16:25:50 +0400
Message-Id: <20220504122601.335495-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add clock definitions for Mediatek MT6735 clocks provided by
apmixedsys, topckgen, infracfg and pericfg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                                   | 10 +++
 .../clock/mediatek,mt6735-apmixedsys.h        | 16 ++++
 .../clock/mediatek,mt6735-infracfg.h          | 25 ++++++
 .../clock/mediatek,mt6735-pericfg.h           | 37 +++++++++
 .../clock/mediatek,mt6735-topckgen.h          | 79 +++++++++++++++++++
 5 files changed, 167 insertions(+)
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt6735-topckgen.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2869a958f5e4..e917039b9d8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12437,6 +12437,16 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
 F:	drivers/mmc/host/mtk-sd.c
 
+MEDIATEK MT6735 CLOCK DRIVERS
+M:	Yassine Oudjana <y.oudjana@protonmail.com>
+L:	linux-clk@vger.kernel.org
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
+F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
+F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
+
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
diff --git a/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
new file mode 100644
index 000000000000..3dda719fd5d5
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+#define _DT_BINDINGS_CLK_MT6735_APMIXEDSYS_H
+
+#define ARMPLL				0
+#define MAINPLL				1
+#define UNIVPLL				2
+#define MMPLL				3
+#define MSDCPLL				4
+#define VENCPLL				5
+#define TVDPLL				6
+#define APLL1				7
+#define APLL2				8
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-infracfg.h b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
new file mode 100644
index 000000000000..979a174ff8b6
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-infracfg.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+#define _DT_BINDINGS_CLK_MT6735_INFRACFG_H
+
+#define DBGCLK				0
+#define GCE				1
+#define TRBG				2
+#define CPUM				3
+#define DEVAPC				4
+#define AUDIO				5
+#define GCPU				6
+#define L2C_SRAM			7
+#define M4U				8
+#define CLDMA				9
+#define CONNMCU_BUS			10
+#define KP				11
+#define APXGPT				12
+#define SEJ				13
+#define CCIF0_AP			14
+#define CCIF1_AP			15
+#define PMIC_SPI			16
+#define PMIC_WRAP			17
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-pericfg.h b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
new file mode 100644
index 000000000000..16f3c6a9a772
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-pericfg.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_PERICFG_H
+#define _DT_BINDINGS_CLK_MT6735_PERICFG_H
+
+#define DISP_PWM			0
+#define THERM				1
+#define PWM1				2
+#define PWM2				3
+#define PWM3				4
+#define PWM4				5
+#define PWM5				6
+#define PWM6				7
+#define PWM7				8
+#define PWM				9
+#define USB0				10
+#define IRDA				11
+#define APDMA				12
+#define MSDC30_0			13
+#define MSDC30_1			14
+#define MSDC30_2			15
+#define MSDC30_3			16
+#define UART0				17
+#define UART1				18
+#define UART2				19
+#define UART3				20
+#define UART4				21
+#define BTIF				22
+#define I2C0				23
+#define I2C1				24
+#define I2C2				25
+#define I2C3				26
+#define AUXADC				27
+#define SPI0				28
+#define IRTX				29
+
+#endif
diff --git a/include/dt-bindings/clock/mediatek,mt6735-topckgen.h b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
new file mode 100644
index 000000000000..a771910a4b8a
--- /dev/null
+++ b/include/dt-bindings/clock/mediatek,mt6735-topckgen.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+#define _DT_BINDINGS_CLK_MT6735_TOPCKGEN_H
+
+#define AD_SYS_26M_CK			0
+#define CLKPH_MCK_O			1
+#define DMPLL				2
+#define DPI_CK				3
+#define WHPLL_AUDIO_CK			4
+
+#define SYSPLL_D2			5
+#define SYSPLL_D3			6
+#define SYSPLL_D5			7
+#define SYSPLL1_D2			8
+#define SYSPLL1_D4			9
+#define SYSPLL1_D8			10
+#define SYSPLL1_D16			11
+#define SYSPLL2_D2			12
+#define SYSPLL2_D4			13
+#define SYSPLL3_D2			14
+#define SYSPLL3_D4			15
+#define SYSPLL4_D2			16
+#define SYSPLL4_D4			17
+#define UNIVPLL_D2			18
+#define UNIVPLL_D3			19
+#define UNIVPLL_D5			20
+#define UNIVPLL_D26			21
+#define UNIVPLL1_D2			22
+#define UNIVPLL1_D4			23
+#define UNIVPLL1_D8			24
+#define UNIVPLL2_D2			25
+#define UNIVPLL2_D4			26
+#define UNIVPLL2_D8			27
+#define UNIVPLL3_D2			28
+#define UNIVPLL3_D4			29
+#define MSDCPLL_D2			30
+#define MSDCPLL_D4			31
+#define MSDCPLL_D8			32
+#define MSDCPLL_D16			33
+#define VENCPLL_D3			34
+#define TVDPLL_D2			35
+#define TVDPLL_D4			36
+#define DMPLL_D2			37
+#define DMPLL_D4			38
+#define DMPLL_D8			39
+#define AD_SYS_26M_D2			40
+
+#define AXI_SEL				41
+#define MEM_SEL				42
+#define DDRPHY_SEL			43
+#define MM_SEL				44
+#define PWM_SEL				45
+#define VDEC_SEL			46
+#define MFG_SEL				47
+#define CAMTG_SEL			48
+#define UART_SEL			49
+#define SPI_SEL				50
+#define USB20_SEL			51
+#define MSDC50_0_SEL			52
+#define MSDC30_0_SEL			53
+#define MSDC30_1_SEL			54
+#define MSDC30_2_SEL			55
+#define MSDC30_3_SEL			56
+#define AUDIO_SEL			57
+#define AUDINTBUS_SEL			58
+#define PMICSPI_SEL			59
+#define SCP_SEL				60
+#define ATB_SEL				61
+#define DPI0_SEL			62
+#define SCAM_SEL			63
+#define MFG13M_SEL			64
+#define AUD1_SEL			65
+#define AUD2_SEL			66
+#define IRDA_SEL			67
+#define IRTX_SEL			68
+#define DISPPWM_SEL			69
+
+#endif
-- 
2.36.0


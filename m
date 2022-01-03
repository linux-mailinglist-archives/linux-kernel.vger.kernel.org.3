Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81948393E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiACXkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiACXj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:39:58 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49662C061799;
        Mon,  3 Jan 2022 15:39:58 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id kc16so32829482qvb.3;
        Mon, 03 Jan 2022 15:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lXlQAu485z2WfBBkz9sVBnGI0wODXH7Vuh2L7xNU2I=;
        b=jjxEoACa3/rrcz8Kr5YWdbzXsbMleKqVK1aYfsta/o0VttLBbhavWPPzyM5n19sqbF
         UYUvMZOLuxZQsqbXxuOwlxNB/uMoTUAPGDQkPACSMksfGeGEULTX1VVnr9UKp2/CwJEG
         QMuKjJf2JtTWrvKxnhAJnuol6IKbCa0yflkt5lk6hReM70okU9vio3lQV0fcr6kB1vA1
         Og6dNqkf5EkvLRZfrA5vLaTtpIeEyjHpddwUu/iPogYjrn7Dh3DIuhzRDwIn86W3i0QL
         179J8m1JD0qaInjSUsC409WPHu7HslRagBUP9+0pq9GybQf9mh13yInidoynXxYXbOlA
         zcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lXlQAu485z2WfBBkz9sVBnGI0wODXH7Vuh2L7xNU2I=;
        b=8AmMYRmnIWRgNVnyc7TObNiod58cgr9iJirE+0/EcxKJKYPZhpwZ1OrF9CpbPIRiBt
         6E+g++c2oIn75hejWodBHjxutJQ9GoFNnlC8goeV11exh6Yta/yRHYZn6w23YG43cFyE
         MsNj0CF9aH1/HA1uRqPb+L55VuoaprAsn8CpZqdD0Jxk2BSdtr4bYXX/ruXNTYZisCKq
         HTFpRipagyf+Sz2XTbjQ7UnkcCK35flOiPZ5iVSCpcb7MrTnKGFjVxEEwxShPXAT1BvB
         WmtQBf/8h7qLUVc+J9T2/3J657UiBbzXEaHrhvEC6XrLtG7sFWb6kO4aZ/HBNwFdD7W6
         Uo/A==
X-Gm-Message-State: AOAM531teqRxqfBx62MKavdi4+CInrBLfusBHKANe7MHbCA2xxS3Z1Q2
        4Wu/s3eGMXNwQ/J6MbQ9Kjg=
X-Google-Smtp-Source: ABdhPJwFqKdXCKTcnh6Z+ZCnHlgGpSavEkzoKNRzWy0dgXJOIj+X9n4NylWY0hoD3u5tRldmKrU4hQ==
X-Received: by 2002:a05:6214:5285:: with SMTP id kj5mr44118411qvb.107.1641253197430;
        Mon, 03 Jan 2022 15:39:57 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id o5sm26965991qkp.132.2022.01.03.15.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 15:39:57 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v7 3/7] dt-bindings: imx: Add clock binding for i.MXRT1050
Date:   Mon,  3 Jan 2022 18:39:44 -0500
Message-Id: <20220103233948.198119-4-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

Add the clock binding doc for i.MXRT1050.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
[Giulio: added all clocks up to IMXRT1050_CLK_USBOH3]
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
[Jesse: added clocks from IMXRT1050_CLK_IPG_PDOF to
IMXRT1050_CLK_DMA_MUX and moved IMXRT1050_CLK_END on]
---
V1->V2:
* Nothing done
V2->V3:
* Added GPT binding
V3->V4:
* Change License to MIT or GPL-2
V4->V5:
* Nothing done
V5->V6:
* Nothing done
V6->V7:
* Fix typo in numbering
* Remove GPT
---
 include/dt-bindings/clock/imxrt1050-clock.h | 72 +++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h

diff --git a/include/dt-bindings/clock/imxrt1050-clock.h b/include/dt-bindings/clock/imxrt1050-clock.h
new file mode 100644
index 000000000000..93bef0832d16
--- /dev/null
+++ b/include/dt-bindings/clock/imxrt1050-clock.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+/*
+ * Copyright(C) 2019
+ * Author(s): Giulio Benetti <giulio.benetti@benettiengineering.com>
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMXRT1050_H
+#define __DT_BINDINGS_CLOCK_IMXRT1050_H
+
+#define IMXRT1050_CLK_DUMMY			0
+#define IMXRT1050_CLK_CKIL			1
+#define IMXRT1050_CLK_CKIH			2
+#define IMXRT1050_CLK_OSC			3
+#define IMXRT1050_CLK_PLL2_PFD0_352M		4
+#define IMXRT1050_CLK_PLL2_PFD1_594M		5
+#define IMXRT1050_CLK_PLL2_PFD2_396M		6
+#define IMXRT1050_CLK_PLL3_PFD0_720M		7
+#define IMXRT1050_CLK_PLL3_PFD1_664_62M		8
+#define IMXRT1050_CLK_PLL3_PFD2_508_24M		9
+#define IMXRT1050_CLK_PLL3_PFD3_454_74M		10
+#define IMXRT1050_CLK_PLL2_198M			11
+#define IMXRT1050_CLK_PLL3_120M			12
+#define IMXRT1050_CLK_PLL3_80M			13
+#define IMXRT1050_CLK_PLL3_60M			14
+#define IMXRT1050_CLK_PLL1_BYPASS		15
+#define IMXRT1050_CLK_PLL2_BYPASS		16
+#define IMXRT1050_CLK_PLL3_BYPASS		17
+#define IMXRT1050_CLK_PLL5_BYPASS		19
+#define IMXRT1050_CLK_PLL1_REF_SEL		20
+#define IMXRT1050_CLK_PLL2_REF_SEL		21
+#define IMXRT1050_CLK_PLL3_REF_SEL		22
+#define IMXRT1050_CLK_PLL5_REF_SEL		23
+#define IMXRT1050_CLK_PRE_PERIPH_SEL		24
+#define IMXRT1050_CLK_PERIPH_SEL		25
+#define IMXRT1050_CLK_SEMC_ALT_SEL		26
+#define IMXRT1050_CLK_SEMC_SEL			27
+#define IMXRT1050_CLK_USDHC1_SEL		28
+#define IMXRT1050_CLK_USDHC2_SEL		29
+#define IMXRT1050_CLK_LPUART_SEL		30
+#define IMXRT1050_CLK_LCDIF_SEL			31
+#define IMXRT1050_CLK_VIDEO_POST_DIV_SEL	32
+#define IMXRT1050_CLK_VIDEO_DIV			33
+#define IMXRT1050_CLK_ARM_PODF			34
+#define IMXRT1050_CLK_LPUART_PODF		35
+#define IMXRT1050_CLK_USDHC1_PODF		36
+#define IMXRT1050_CLK_USDHC2_PODF		37
+#define IMXRT1050_CLK_SEMC_PODF			38
+#define IMXRT1050_CLK_AHB_PODF			39
+#define IMXRT1050_CLK_LCDIF_PRED		40
+#define IMXRT1050_CLK_LCDIF_PODF		41
+#define IMXRT1050_CLK_USDHC1			42
+#define IMXRT1050_CLK_USDHC2			43
+#define IMXRT1050_CLK_LPUART1			44
+#define IMXRT1050_CLK_SEMC			45
+#define IMXRT1050_CLK_LCDIF_APB			46
+#define IMXRT1050_CLK_PLL1_ARM			47
+#define IMXRT1050_CLK_PLL2_SYS			48
+#define IMXRT1050_CLK_PLL3_USB_OTG		49
+#define IMXRT1050_CLK_PLL4_AUDIO		50
+#define IMXRT1050_CLK_PLL5_VIDEO		51
+#define IMXRT1050_CLK_PLL6_ENET			52
+#define IMXRT1050_CLK_PLL7_USB_HOST		53
+#define IMXRT1050_CLK_LCDIF_PIX			54
+#define IMXRT1050_CLK_USBOH3			55
+#define IMXRT1050_CLK_IPG_PDOF			56
+#define IMXRT1050_CLK_PER_CLK_SEL		57
+#define IMXRT1050_CLK_PER_PDOF			58
+#define IMXRT1050_CLK_DMA			59
+#define IMXRT1050_CLK_DMA_MUX			60
+#define IMXRT1050_CLK_END			61
+
+#endif /* __DT_BINDINGS_CLOCK_IMXRT1050_H */
-- 
2.34.1


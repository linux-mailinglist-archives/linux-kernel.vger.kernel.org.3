Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3F4682D3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384219AbhLDGO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbhLDGOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:19 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECBFC0611F7;
        Fri,  3 Dec 2021 22:10:53 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id t11so5670084qtw.3;
        Fri, 03 Dec 2021 22:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xBCV9vw5++14Rhc+htGrnWDIYZcmcvIWQjwsIH6sGA=;
        b=poErQ+vbqY98oeHZ9dPAkHkWrG5dbjxujdze7ycQauIWKzfTX95Qb4LI/ZlRbZZZGl
         97JZM2oZJ8m4pF+3RJ0NFkXiHfMXnf+zqs4uUWlbuYcpaaJzHn/vDz2/6UBJ4K4QnynU
         JE1cP64qIiVO2ed5g4rBFPzw9np8Xpy4sAgHwvC+IU1RDD/Vl1a3SgG2pUy+mj/+//AI
         ta0mrVyaXMSuPffjaajrnm96B43hzAuR9A44ucEdFYmVQYogQ2kKW1hHhUDApdvR2etH
         4WUJgWwnhzTzACMV5oMGGIWRF56j3J7w5zFe117UoC5mhMPFexqa4jT+B4Go0ErdpgRJ
         H9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xBCV9vw5++14Rhc+htGrnWDIYZcmcvIWQjwsIH6sGA=;
        b=sBDOFFccm/mMGOLoBp2SYs1anMPE4mfIl12HWzYKMycbAQMLCemH9aJm9MHqSpeOiT
         EpXmhMAo7V/VWUZS8dZ+JDhy5Y9ZyX+Qk8uKkOlPjQcAyjuEpD5GHLhTlrAWCT0W3opo
         jEyOHHSk/WJ2LG2IPNF13g+cugm5eCjiYNN0WefJepI7vP4WkXL95zI+XweJ81kvrRHj
         2OEnmcr5FypakrT4ZwNm2+eztUqlpYRHtpb3aSbFUgBVuxV197AUnx/XTAzRzUhaFovk
         IZMH0+yDLPr6D7/JRoh8yJupX/Kq8ckgi7qYo+D/dkS/Zw4QqvWBaalF9OcD50rLPo6Y
         RzNw==
X-Gm-Message-State: AOAM532hIIFEHNI0UAekehw/FwuCzPVogKo1wMWYQ1eKdpRPMP36IYiv
        lBbFZIAfv98v5Ns2rXyGrKA=
X-Google-Smtp-Source: ABdhPJx5uGTIcg9V9BSCFSFwsNAeSNvdBWIHnfbB0AahctyMhH9TQpFZR2wjWk+wARF6vf6sdRHhjg==
X-Received: by 2002:a05:622a:4c9:: with SMTP id q9mr26077598qtx.102.1638598252834;
        Fri, 03 Dec 2021 22:10:52 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:52 -0800 (PST)
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
Subject: [PATCH v4 05/13] dt-bindings: imx: Add clock binding for i.MXRT1050
Date:   Sat,  4 Dec 2021 01:10:34 -0500
Message-Id: <20211204061042.1248028-6-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
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
---
 include/dt-bindings/clock/imxrt1050-clock.h | 73 +++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h

diff --git a/include/dt-bindings/clock/imxrt1050-clock.h b/include/dt-bindings/clock/imxrt1050-clock.h
new file mode 100644
index 000000000000..e5d26be8621a
--- /dev/null
+++ b/include/dt-bindings/clock/imxrt1050-clock.h
@@ -0,0 +1,73 @@
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
+#define IMXRT1050_CLK_GPT			70
+#define IMXRT1050_CLK_END			71
+
+#endif /* __DT_BINDINGS_CLOCK_IMXRT1050_H */
-- 
2.34.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74CE52D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiESOYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiESOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:24:29 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974A7CC167;
        Thu, 19 May 2022 07:24:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id c9so4014028qvx.8;
        Thu, 19 May 2022 07:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/F1u/RnNvoSA5Fg84LsZu/d0EEbrb1hnUkkpK7Edzrk=;
        b=FHsawpHykc055tRH2+HvevhWPIukCAcHue8zJygAKob7t8ucVvvdXBmgcJN07r0thP
         ojaGiV2ycq+q/opTKNIuHFf18i0iUZMsjsS8CqrEUwFEnlW130W6f8Eyw8wumLjrM2wO
         l2f21/PGYyjZITV1es+WcwgNMOAiqaALUydqevrS2w02O9ttnInXoymmHW7j9bgO+Eit
         sP6GyviQW1vVWPS/1lqBNsK//9qCQfcemYkx8D1ur4Iur/t0BuOrZA/jd+l19vo7VWQv
         DF8Ifw9VAHnqr7y6oXj2s4uGOZOkFaJkeaHu1aBPuplzpnYf56hQGS5n5Ds11+I8oWEw
         Z2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/F1u/RnNvoSA5Fg84LsZu/d0EEbrb1hnUkkpK7Edzrk=;
        b=0cimmWbRg4BWsmRsYVsIgF+M8O0ngBl69qxUWPa3a1csNtv1DGaR6RbOHgVDuSjoYJ
         m7ow9BClSjPtCyNJo2Bc2dyDn4nTbOOLqu3DpVDwMIf84fjredkb8Ec9KuvJGElZzKYI
         ohqh6OM5cGNbAlFa6ttYsK5PEs6Y/UOaUwf14HbgqR8KRuKqplSPnvjGl6DmtEjZnCy9
         bVpvl53wR8tUFpFuoUxWNX0HpuU0glY2edcGX/FGmi/cbQtwLO9Pfvk+2aAwJoffSY+j
         1vEn3Irix8gIrGaG/dIBjoldlftr6V8605uEZ/eI9/3nxH+IlhuFL973aTk6eyjGCtFk
         6Ocg==
X-Gm-Message-State: AOAM531V28RUshhiLOnAnP+Tkrw75CJRDuqc8+F18jun3H0uswHdOjzd
        5Cmb84eo/TsJMPjjyWRfVwE=
X-Google-Smtp-Source: ABdhPJwE5m/Py9T4+bhXUWHIeIFP3YAlsSzC0KWD4LbPYUa0sn3pNxKup3C9qwGpQHmEFnzA1rdEtw==
X-Received: by 2002:ad4:49b1:0:b0:461:f0fb:685 with SMTP id u17-20020ad449b1000000b00461f0fb0685mr4198310qvx.22.1652970259763;
        Thu, 19 May 2022 07:24:19 -0700 (PDT)
Received: from localhost.localdomain ([217.138.206.82])
        by smtp.gmail.com with ESMTPSA id c15-20020ac85a8f000000b002f39b99f697sm1539342qtc.49.2022.05.19.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 07:24:19 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: reset: Add MT6735 reset bindings
Date:   Thu, 19 May 2022 18:22:09 +0400
Message-Id: <20220519142211.458336-3-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519142211.458336-1-y.oudjana@protonmail.com>
References: <20220519142211.458336-1-y.oudjana@protonmail.com>
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

Add reset definitions for Mediatek MT6735 resets provided by
infracfg and pericfg.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 MAINTAINERS                                   |  2 ++
 .../reset/mediatek,mt6735-infracfg.h          | 31 +++++++++++++++++++
 .../reset/mediatek,mt6735-pericfg.h           | 31 +++++++++++++++++++
 3 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
 create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a59069263cfb..1c0af554a7b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12503,6 +12503,8 @@ F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-topckgen.h
+F:	include/dt-bindings/reset/mediatek,mt6735-infracfg.h
+F:	include/dt-bindings/reset/mediatek,mt6735-pericfg.h
 
 MEDIATEK MT76 WIRELESS LAN DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
diff --git a/include/dt-bindings/reset/mediatek,mt6735-infracfg.h b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
new file mode 100644
index 000000000000..86448f946568
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-infracfg.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RST_MT6735_INFRACFG_H
+#define _DT_BINDINGS_RST_MT6735_INFRACFG_H
+
+#define EMI_REG_RST			0
+#define DRAMC0_AO_RST			1
+#define AP_CIRQ_EINT_RST		3
+#define APXGPT_RST			4
+#define SCPSYS_RST			5
+#define KP_RST				6
+#define PMIC_WRAP_RST			7
+#define CLDMA_AO_TOP_RST		8
+#define EMI_RST				16
+#define CCIF_RST			17
+#define DRAMC0_RST			18
+#define EMI_AO_REG_RST			19
+#define CCIF_AO_RST			20
+#define TRNG_RST			21
+#define SYS_CIRQ_RST			22
+#define GCE_RST				23
+#define MM_IOMMU_RST			24
+#define CCIF1_RST			25
+#define CLDMA_TOP_PD_RST		26
+#define CBIP_P2P_MFG			27
+#define CBIP_P2P_APMIXED		28
+#define CBIP_P2P_CKSYS			29
+#define CBIP_P2P_MIPI			30
+#define CBIP_P2P_DDRPHY			31
+
+#endif
diff --git a/include/dt-bindings/reset/mediatek,mt6735-pericfg.h b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
new file mode 100644
index 000000000000..6cdfaa7ddadf
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_RST_MT6735_PERICFG_H
+#define _DT_BINDINGS_RST_MT6735_PERICFG_H
+
+#define UART0_SW_RST			0
+#define UART1_SW_RST			1
+#define UART2_SW_RST			2
+#define UART3_SW_RST			3
+#define UART4_SW_RST			4
+#define BTIF_SW_RST			6
+#define DISP_PWM_SW_RST			7
+#define PWM_SW_RST			8
+#define AUXADC_SW_RST			10
+#define DMA_SW_RST			11
+#define IRDA_SW_RST			12
+#define IRTX_SW_RST			13
+#define THERM_SW_RST			16
+#define MSDC2_SW_RST			17
+#define MSDC3_SW_RST			17
+#define MSDC0_SW_RST			19
+#define MSDC1_SW_RST			20
+#define I2C0_SW_RST			22
+#define I2C1_SW_RST			23
+#define I2C2_SW_RST			24
+#define I2C3_SW_RST			25
+#define USB_SW_RST			28
+
+#define SPI0_SW_RST			33
+
+#endif
-- 
2.36.1


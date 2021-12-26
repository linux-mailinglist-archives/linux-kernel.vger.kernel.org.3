Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4006947F770
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhLZPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhLZPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:34:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C5DC061401
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 07:34:25 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bq20so29735702lfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 07:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKOhgFA6EDwm88QeGjFMZpYe/CzCFPYOKrRLqO3vV1k=;
        b=SaKmJaAjNcM38WDeiEpQvB/UDGXuxDY9zScCFHrNM8tcwGHY+atfBHItPABb3EYyTE
         lnj03VfCWZ5yNBTzCfnBCzVDQ0fnfPrz1/wER+E30UP4333/2hY+86NABzb7R11k1OA1
         0k84s65GEGLtSGcU2VmZdBNcAnHesg7LGIANKwvN3rw29kYyVaGH/uhEoYqRwO8XpX+J
         b/Ix2TbNX9SLnPktJNZmQJ1jiR4gSDghVU7CV28AGC01u+LG4RI6gYze3wJyk8mCqTM8
         5/ZF32IgI1hIVVYP0M2PUH8nGf5Lu4Esa+WC7vG9CRVtI8GHohA+TgGa+rJSsmsPsDTD
         Bnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKOhgFA6EDwm88QeGjFMZpYe/CzCFPYOKrRLqO3vV1k=;
        b=BGvOkPrnNCwzxKGSxuL2ADiCddMNCC00+qpUYS8io2YKkQXDq/m53V0K4PThgERxPN
         iAdi58+wFW2yUytfIq33IETFgeE3bWzChXxWOLs6+PH5o/I7hFV4v5gcdgTmuFrio+6l
         5FOM0iSQwcJ9fj5S1kPIi+WSxQAc6gLHFroGPxpFus/50fDbbWDRad9cJqASa2MAfoVb
         Pgucy9o8Tdf3ZGy3wVQLEBEr6eNGWIyRu+HdaES9DDI/lsqrStuPfeyXyNFK65NL/fIk
         L8pUAZx72YCrx0m4Luj8ELn7yF6h80yat7SlFKlU19tpzVAnPNZhIYxtwcr60O4NPvL+
         H9/g==
X-Gm-Message-State: AOAM533ne6HdCXUVD6/M2849eFS+uyR9E0XlMo5aJDyLJ/+d3nVETzMl
        Fti1WV6UWGFE+0Uhy0iGh/btRQ==
X-Google-Smtp-Source: ABdhPJzKPNqyGHVcxaijR/QircqRFVi3vsCTgIQTUsGh2adgcNzCVL+1DsTHPd7iRHvAttj++G1Cjw==
X-Received: by 2002:a05:6512:15b:: with SMTP id m27mr9770330lfo.218.1640532863400;
        Sun, 26 Dec 2021 07:34:23 -0800 (PST)
Received: from cobook.home ([176.59.43.180])
        by smtp.gmail.com with ESMTPSA id p14sm1388402ljj.12.2021.12.26.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 07:34:22 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 3/3 v2] arm64: dts: renesas: add MOST device
Date:   Sun, 26 Dec 2021 18:33:50 +0300
Message-Id: <20211226153349.2296024-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211226082530.2245198-4-nikita.yoush@cogentembedded.com>
References: <20211226082530.2245198-4-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds mlp device to dtsi files for R-Car Gen3 SoCs that have
it.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
Change from v1:
- fix power domain ids so all dtbs build properly

 arch/arm64/boot/dts/renesas/r8a77951.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a77960.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a77961.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 13 +++++++++++++
 6 files changed, 78 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index 1768a3e6bb8d..179d860ab9c3 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -2412,6 +2412,19 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a7795",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77960.dtsi b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
index 2bd8169735d3..1e90e848d2c8 100644
--- a/arch/arm64/boot/dts/renesas/r8a77960.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77960.dtsi
@@ -2284,6 +2284,19 @@ ssiu97: ssiu-51 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a7796",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
index a34d5b1d6431..eb70b601191b 100644
--- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
@@ -2128,6 +2128,19 @@ ssiu97: ssiu-51 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77961",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 08df75606430..293021f59818 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -2147,6 +2147,19 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77965",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77990.dtsi b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
index 0ea300a8147d..232391fd0751 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77990.dtsi
@@ -1682,6 +1682,19 @@ ssi9: ssi-9 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77990_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77990",
 				     "renesas,rcar-dmac";
diff --git a/arch/arm64/boot/dts/renesas/r8a77995.dtsi b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
index 16ad5fc23a67..33d9ed431d9c 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
@@ -1132,6 +1132,19 @@ ssi4: ssi-4 {
 			};
 		};
 
+		mlp: mlp@ec520000 {
+			compatible = "renesas,rcar-gen3-mlp";
+			reg = <0 0xec520000 0 0x800>;
+			interrupts = <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 388 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 802>;
+			power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		audma0: dma-controller@ec700000 {
 			compatible = "renesas,dmac-r8a77995",
 				     "renesas,rcar-dmac";
-- 
2.30.2


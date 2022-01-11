Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81F248B85F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbiAKUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:56 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:38354
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345518AbiAKUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:21 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7C5A240045
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932300;
        bh=Qlnwbd6fk1GAVHv44UFEkb4MIEQM8+1pdzBh/ez3KZQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=QkZOlQa5xYHr34nh1BjmgEroYXEU3QeBlFnUH8yt5pdneD4IkRXtrN4N8S5LZ4k+o
         NOE6XR6nXZQTE2LHkAt0u1mF7mwK93fF7qIxpdfhn/jpF3jsHa5EKZ3ItfBs52J43o
         KGna0GCptV7YoN75C1Mo1KPcFQtFsPAuAMfurocNtQeEY1u4BeqAuBhA6FGCNWnYPA
         vzAVfFlNypIS9ivtBKv9/KHfpLSuAO6bUmtzHv2jU+sDy9b9W1Iuv2x5b4fEgEQCEc
         c2yU8IBOAKDhu/EUhYzvdKHo2fW3O3s6JY57SgiaxnK8oPScqPclY3IFWChkPbHYu9
         cAo0cHTpXAMvA==
Received: by mail-ed1-f69.google.com with SMTP id p8-20020aa7d308000000b003fe9b0c4760so166574edq.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qlnwbd6fk1GAVHv44UFEkb4MIEQM8+1pdzBh/ez3KZQ=;
        b=HiNHPwsoQFFsN83adenpwP7gcRVVsHhToZbkTU1F7R0KIPE9Y1bxEFRySHHX5R+VdT
         YS9uULrXd1AHn9Wi4yHJBnlypT54AOHS83Sj8rfiniarSlaWaRXr7bLJmVYscGDgoQUI
         87ZBbtwCwrEWXC732Fr7na7nGUDSFRLkGPqzA6OR1vGaCwhrXIlNQXzG5b//qPyOb5P6
         QfmBENX8H5rjcE71Y3+g8Tnr+CzdWcVNmtQGQZtsA/qYOXMpVVWepmR2fDvwC1iqwmFk
         1/1k+ALjMv3FeQ7JMWQI6YUKcjwpQVNfIo9qSh7Ksy5AtCEtzjL6TwaKkLuz6QdLBEhf
         JXGA==
X-Gm-Message-State: AOAM530ftnW8IfU33x10Fn+CzJScylSg59INXMfX5LlVAF2z8WqtfeOn
        fRb/K02WZ+AH6U+mCA0aY7MMUGFDr61Rnmir8TemuGccDcMOkCJ+yCRUvGb+frTgJN658M91f+c
        GOLSicNQqoDwj58CdP1OonaYCCvpzTbRQGNKzMfqZxg==
X-Received: by 2002:a17:906:f1c1:: with SMTP id gx1mr5115805ejb.554.1641932300101;
        Tue, 11 Jan 2022 12:18:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjg8XXXEtJLzZGyVnTOplVIASttt5k3NI3JcN11jWvuGHGfSah9kGC+WsunAadBmsLBsMRZQ==
X-Received: by 2002:a17:906:f1c1:: with SMTP id gx1mr5115789ejb.554.1641932299934;
        Tue, 11 Jan 2022 12:18:19 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:18:19 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>
Subject: [PATCH v2 20/28] arm64: dts: exynos: align pinctrl with dtschema in ExynosAutov9
Date:   Tue, 11 Jan 2022 21:17:14 +0100
Message-Id: <20220111201722.327219-14-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the pin controller related nodes with dtschema.  No functional
change expected.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../boot/dts/exynos/exynosautov9-pinctrl.dtsi | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
index 2407b03b5404..ef0349d1c3d0 100644
--- a/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynosautov9-pinctrl.dtsi
@@ -11,7 +11,7 @@
 #include <dt-bindings/pinctrl/samsung.h>
 
 &pinctrl_alive {
-	gpa0: gpa0 {
+	gpa0: gpa0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -27,7 +27,7 @@ gpa0: gpa0 {
 			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	gpa1: gpa1 {
+	gpa1: gpa1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 		interrupt-controller;
@@ -47,7 +47,7 @@ dp1_hpd: dp1-hpd-pins {
 		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
-	gpq0: gpq0 {
+	gpq0: gpq0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -69,7 +69,7 @@ speedy1_bus: speedy1-bus-pins {
 };
 
 &pinctrl_aud {
-	gpb0: gpb0 {
+	gpb0: gpb0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -77,7 +77,7 @@ gpb0: gpb0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb1: gpb1 {
+	gpb1: gpb1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -85,7 +85,7 @@ gpb1: gpb1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb2: gpb2 {
+	gpb2: gpb2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -93,7 +93,7 @@ gpb2: gpb2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpb3: gpb3 {
+	gpb3: gpb3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -199,7 +199,7 @@ aud_i2s6_idle: aaud-i2s6-idle-pins {
 };
 
 &pinctrl_fsys0 {
-	gpf0: gpf0 {
+	gpf0: gpf0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -207,7 +207,7 @@ gpf0: gpf0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf1: gpf1 {
+	gpf1: gpf1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -355,7 +355,7 @@ pcie_perst5_in: pcie-perst5-in-pins {
 };
 
 &pinctrl_fsys1 {
-	gpf8: gpf8 {
+	gpf8: gpf8-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -393,7 +393,7 @@ sd2_bus4: sd2-bus-width4-pins {
 };
 
 &pinctrl_fsys2 {
-	gpf2: gpf2 {
+	gpf2: gpf2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -401,7 +401,7 @@ gpf2: gpf2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf3: gpf3 {
+	gpf3: gpf3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -409,7 +409,7 @@ gpf3: gpf3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf4: gpf4 {
+	gpf4: gpf4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -417,7 +417,7 @@ gpf4: gpf4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf5: gpf5 {
+	gpf5: gpf5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -425,7 +425,7 @@ gpf5: gpf5 {
 		#interrupt-cells = <2>;
 	};
 
-	gpf6: gpf6 {
+	gpf6: gpf6-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -499,7 +499,7 @@ eth1_pps_out: eth1-pps-out-pins {
 };
 
 &pinctrl_peric0 {
-	gpp0: gpp0 {
+	gpp0: gpp0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -507,7 +507,7 @@ gpp0: gpp0 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp1: gpp1 {
+	gpp1: gpp1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -515,7 +515,7 @@ gpp1: gpp1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp2: gpp2 {
+	gpp2: gpp2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -523,7 +523,7 @@ gpp2: gpp2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg0: gpg0 {
+	gpg0: gpg0-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -833,7 +833,7 @@ uart5_bus_dual: uart5-bus-dual-pins {
 };
 
 &pinctrl_peric1 {
-	gpp3: gpp3 {
+	gpp3: gpp3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -841,7 +841,7 @@ gpp3: gpp3 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp4: gpp4 {
+	gpp4: gpp4-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -849,7 +849,7 @@ gpp4: gpp4 {
 		#interrupt-cells = <2>;
 	};
 
-	gpp5: gpp5 {
+	gpp5: gpp5-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -857,7 +857,7 @@ gpp5: gpp5 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg1: gpg1 {
+	gpg1: gpg1-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -865,7 +865,7 @@ gpg1: gpg1 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg2: gpg2 {
+	gpg2: gpg2-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -873,7 +873,7 @@ gpg2: gpg2 {
 		#interrupt-cells = <2>;
 	};
 
-	gpg3: gpg3 {
+	gpg3: gpg3-gpio-bank {
 		gpio-controller;
 		#gpio-cells = <2>;
 
-- 
2.32.0


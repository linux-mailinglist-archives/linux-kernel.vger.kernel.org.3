Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635149711C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbiAWLQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:16:59 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:55972
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236204AbiAWLQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:50 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E37133F1C9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936609;
        bh=XKeSGyC9ItmJqAyykgNV42LPM38fJ31nboSTLUTfyvc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Fao8QoAfJkClA7pkwg4uaKxqQg0Q40FXPx5T8Z1/iZ2ja6zuUl9TMSkizZ1axUKL2
         et74ZifzmcFIaYYJtpKOJrRZfrPXPTa9/cpUp5xKIzBd3mOAtVK9r0ypCNVXxhqzFQ
         HfwXymQ5mLeZ/Th4hMl4zTSxJxA5LWybVZpm7NR/r1TQFjxK9BP+VxofY47bstwPol
         MonU6G6H0QGhNvEbKtEbo/imwHs6OeEovARYZ/pHMcp7qvXcSjgz8HjRQWq5YOOCzX
         1HY6vu0YV3pKs6tHRJ1m1QmxTbPrdA+dkcW02v+w2y1Wur309xVD/22PtaRDiQ3PHQ
         7tk1saF93mX1w==
Received: by mail-wr1-f72.google.com with SMTP id g6-20020adfbc86000000b001a2d62be244so1115435wrh.23
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKeSGyC9ItmJqAyykgNV42LPM38fJ31nboSTLUTfyvc=;
        b=vlIXe4d84Fit44J1tkIZtgDOxlApqHjJgdKGX10q7uvn737zgLqQVfL/HlzqFnb1/2
         2foFk63HgfaxgXzQlMc3wWYVYyIR9QkzST2JAzTHe5tbtdkJAdVJnX5+CGQvXeO+Jnmd
         Au7N2InN1FUNdILmp+0FPPfutKApjyr8lBSMiw+RtTDhxE+UYpDQq7/D0T0PhFqR+80o
         bHOK5THBbcXKZloOmyYdec5PWK7i/105chnKiaHfdHZIRD0UrIqAjflQHx/LWPRicaq/
         9U3IX5TCGCF3fVOrXQN6W3mII7GMkZkIMbMa3BFjvKaXbBpvV6d44NFkXQZ78wU5pj4k
         Gwxg==
X-Gm-Message-State: AOAM530vFemO4Hh7aa0nu0gfsbsZh7hVDTJVcpklVh1VDI7whX6xqtYE
        NBC2Ir2bRQf9UWL8njxYqKTSScCCzOWbq2sSZWoU8keAMMG6DbyXjzojQ+tAuegZBjIqtOR6Q+9
        RE6ITc5+lxg8p78H0NZpiZhDgdYtPFTpqHHbr0ySqaw==
X-Received: by 2002:adf:f686:: with SMTP id v6mr9080084wrp.568.1642936609614;
        Sun, 23 Jan 2022 03:16:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQBteHKoyyNnf4rlz2MD505Wn16oOqHwd91HINqnK/froSXkyccBpxKSM0tEJs7mrQYEKfxw==
X-Received: by 2002:adf:f686:: with SMTP id v6mr9080070wrp.568.1642936609419;
        Sun, 23 Jan 2022 03:16:49 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] arm64: dts: exynos: add USB DWC3 supplies to Espresso board
Date:   Sun, 23 Jan 2022 12:16:33 +0100
Message-Id: <20220123111644.25540-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos7 Espresso
board.  Due to lack of schematics of Espresso board, the choice of
regulators is approximate.  What bindings call VDD10, for Exynos7 should
be actually called VDD09 (0.9 V).  Use regulators with a matching
voltage range based on vendor sources for Meizu Pro 5 M576 handset (also
with Exynos7420).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 5 +++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi         | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index 125c03f351d9..4c45e689d34a 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -412,6 +412,11 @@ &ufs {
 	status = "okay";
 };
 
+&usbdrd {
+	vdd10-supply = <&ldo4_reg>;
+	vdd33-supply = <&ldo6_reg>;
+};
+
 &usbdrd_phy {
 	vbus-supply = <&usb30_vbus_reg>;
 	vbus-boost-supply = <&usb3drd_boost_5v>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index c3efbc8add38..01b4210d8b62 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -672,7 +672,7 @@ usbdrd_phy: phy@15500000 {
 			#phy-cells = <1>;
 		};
 
-		usbdrd3 {
+		usbdrd: usb {
 			compatible = "samsung,exynos7-dwusb3";
 			clocks = <&clock_fsys0 ACLK_USBDRD300>,
 			       <&clock_fsys0 SCLK_USBDRD300_SUSPENDCLK>,
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4C497142
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbiAWLSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:18:42 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38506
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236310AbiAWLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:17:04 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E62EF3F1E8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936620;
        bh=dx9J171TH9ajdx0PBtS6Tdib7oh/eqVqsvAw3pSWKnc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lHLj1bzHjNlNxS3oxeonrEdyowwT5vlnUHkWEype4eGaaLycbsLJGGo1zu3IzWqFy
         /VRXjXFEz0zQKqcX4CQ9Y/u1RqoWsL1IoPt86VkZLerJwhF2TpCP8dzW/KKlPZjOK6
         pA9TaFbf1UPe0xe9eUgrjY9cAEjiohA9Q7LhQYob8qFISduLw59ZlyFwG5GuH97Z7m
         XOUaPNnWFxSA4nzZVoUy12H5QuxL5TqYHb6scnmUzTGaw55b9/HkXzsSDPFz8kdd3u
         5mSjFwJSlJPUlmOKuz2+nMOM76rPjkY5xVC3NifYzf8XHU7F53gB9yqVEH/6vb3pls
         loS9bCR4cqGiQ==
Received: by mail-wm1-f71.google.com with SMTP id b4-20020a7bc244000000b0034f4c46217cso1510548wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dx9J171TH9ajdx0PBtS6Tdib7oh/eqVqsvAw3pSWKnc=;
        b=UQHZCeUQQjZ1I8Ftdjvc+WuuvHsXZIewKt8iKtyOXJ+tJUdFG7dRD9Rvu36W2R/I34
         SB4z9KyVfoMzdpQsbBhKp3W5k+L+x69mxQs09UQ22E/p2X3Wh3maLCpRIxLPVJLi3PgE
         KQYCl4GzSRSvspeBE0x+RgJPCNAUhyMY7pSKQTrU5Uy/wa9QjK2jNj4yMkWWvcBLZRnS
         f9WBATt4s30ImV0NbN5FeEItJfjA+LHWnRqo4uw70bZDeQTED5GSVQWWrOln+6s2AqUJ
         CvowIx427NaQxw+FjJ6A/rAvOswguTg6Fsv8Vka9s1oZRLxOhxeE5NYYMol1OGv47Xqj
         XD/A==
X-Gm-Message-State: AOAM532wTuZmh72Z6wthT6ElncGn7WUkux/kgvBgDwqY/rY6jf2UY2Uf
        /TiuXVPCsOq3tYFPUz0+YaisF1iq1UIe2XMbpB/uD0BTrFzEzBnbk7JWZ+e2/AfEJM9BJXlfd4s
        ZwZMVEfpw/9upIrX5i5Ock4cKNVpBebjyLylHTLjoUQ==
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr7602125wmq.64.1642936620701;
        Sun, 23 Jan 2022 03:17:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYjK0VxAe/EwPuFaJgl6CLlYcZziFBrDEE3OaETwss+bus0ChDXjO9A4TMNzg/RoD3ooiJnQ==
X-Received: by 2002:a05:600c:4f93:: with SMTP id n19mr7602112wmq.64.1642936620519;
        Sun, 23 Jan 2022 03:17:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:17:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] ARM: dts: exynos: add fake USB DWC3 supplies to SMDK5410
Date:   Sun, 23 Jan 2022 12:16:42 +0100
Message-Id: <20220123111644.25540-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dummy/fake voltage regulators for USB DWC3 block on Exynos5410
SMDK5410 board.  These regulators are required by dtschema, however the
SMDK5410 board does not define the PMIC providing regulators.  Use dummy
fixed-regulators just to satisfy the dtschema checks.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5410-smdk5410.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 2a3ade77a2de..eae69e857247 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -41,6 +41,19 @@ firmware@2037000 {
 		reg = <0x02037000 0x1000>;
 	};
 
+	vdd10_usb3: voltage-regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD10_USB3";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+	};
+
+	vdd33_usb3: voltage-regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD33_USB3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &mmc_0 {
@@ -121,3 +134,13 @@ &serial_1 {
 &serial_2 {
 	status = "okay";
 };
+
+&usbdrd3_0 {
+	vdd10-supply = <&vdd10_usb3>;
+	vdd33-supply = <&vdd33_usb3>;
+};
+
+&usbdrd3_1 {
+	vdd10-supply = <&vdd10_usb3>;
+	vdd33-supply = <&vdd33_usb3>;
+};
-- 
2.32.0


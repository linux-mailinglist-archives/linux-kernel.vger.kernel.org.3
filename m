Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFD44812D2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238676AbhL2MrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 07:47:07 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34446
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238503AbhL2MrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 07:47:03 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 554C4407AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640782022;
        bh=r9HPg3JSAEOg9NmbHzzSoR6SujxmeJ0M4OI/ixjeZrc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CJGHYoQyyuWSymqH9+Vu+NqsxVJefOflhvkVIUvCpkyruHfKiQOtGPQED5jN1Q7xV
         O0e6K47q8SQfai5fZl2kEBtoV7sF5UodruU9lIWQQ3rueMGzEH53UYuA/Nj21PgUdT
         jdjSTKJPw0+dnF6rUNqavsI64eNikEWbSnHF2ncMJuJQPSOfcQaLvtOwvSO33QhJqI
         Jnwkpi6MpfHulRUNC3HPvtOm1m8ek7rQQLFDtY/EVadeT5pQywPv7nQVV4CQ26Q/cH
         qTzXkwmsv0odc2tei+yFOS5GQmy830+4WE1SMsE6kvttv3Ny1afUIA6NzIvREVoC3/
         +TEkoe0UjKrCg==
Received: by mail-lf1-f70.google.com with SMTP id r21-20020ac25f95000000b004259e6ab262so4484782lfe.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 04:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9HPg3JSAEOg9NmbHzzSoR6SujxmeJ0M4OI/ixjeZrc=;
        b=f6/QUQPSCz/1uTWHHXcmo0PwbsUgz9MKOH6n0j0+3bu9IsfGhFF/uPgtuBOc2DthGA
         0JpQnVTTh1+FHHbIyWmWbU/pueRHmuaihYKXHM5+r7uQ7Id/+kI4r3PUNTzYDjScVkFu
         HXyncN/vUdfbMk5x+YNHw9Ku10FYQXzUmXXYlUIRO/smOJjCMpHihYTgdNH+V7T/Q+ZG
         YDz5w2ndXXRgKtY9C/cuvavnApYzDuWMh+GwC5PFyYl78Wk2Rpd3jZpjsM+nir/l5E/D
         UFN8uBqJcvnW+oE09u8S/BO6o4uLHdRADv442FAAQh9OhPwN7Va0lN88Vf3S5mIr6FKM
         Q/8Q==
X-Gm-Message-State: AOAM533T1dt7i0r81ONpMS2zt4UgCrjp2AFSCMc3OmJaVaKS/GygdlN6
        vH8VDLbM1ruwg6kT2jNOGlJiA0RV0fcQItJ69x5nTCwQkW1eLHaYj9lkT/BwGbxe/uSL6D/NsKS
        Xd1qGm8MWh1xbKE/IIvxRLaTC4v1ROQu7lxHvZGTfNQ==
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr16468100ljp.319.1640782021616;
        Wed, 29 Dec 2021 04:47:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQ5KP8xCMo76zySy7IgcVerWkV4lDnBlSblfUvCTCSfXuM2Uh2jh+Nf/55i9Fuz7F9pVdknQ==
X-Received: by 2002:a05:651c:54f:: with SMTP id q15mr16468087ljp.319.1640782021346;
        Wed, 29 Dec 2021 04:47:01 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id e11sm711158ljn.73.2021.12.29.04.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 04:47:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH 1/5] arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
Date:   Wed, 29 Dec 2021 13:46:27 +0100
Message-Id: <20211229124631.21576-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
References: <20211229124631.21576-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced dtschema for MAX77843 MUIC require the children to
have proper naming and a port@0 property.

This should not have actual impact on MFD children driver binding,
because the max77843 MFD driver uses compatibles.  The port@0 is
disabled to avoid any impact.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Please kindly test or even better - fix the DTS and extcon driver.
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index cbcc01a66aab..03f7c9acaacb 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -858,10 +858,10 @@ pmic@66 {
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 		reg = <0x66>;
 
-		muic: max77843-muic {
+		muic: extcon {
 			compatible = "maxim,max77843-muic";
 
-			musb_con: musb-connector {
+			musb_con: connector {
 				compatible = "samsung,usb-connector-11pin",
 					     "usb-b-connector";
 				label = "micro-USB";
@@ -871,6 +871,17 @@ ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
 
+					port@0 {
+						/*
+						 * TODO: The DTS this is based on does not have
+						 * port@0 which is a required property. The ports
+						 * look incomplete and need fixing.
+						 * Add a disabled port just to satisfy dtschema.
+						 */
+						reg = <0>;
+						status = "disabled";
+					};
+
 					port@3 {
 						reg = <3>;
 						musb_con_to_mhl: endpoint {
@@ -910,7 +921,7 @@ charger_reg: CHARGER {
 			};
 		};
 
-		haptic: max77843-haptic {
+		haptic: motor-driver {
 			compatible = "maxim,max77843-haptic";
 			haptic-supply = <&ldo38_reg>;
 			pwms = <&pwm 0 33670 0>;
-- 
2.32.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43648B450
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiAKRst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:48:49 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53832
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235475AbiAKRsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:48:47 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 62943405F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923326;
        bh=r9HPg3JSAEOg9NmbHzzSoR6SujxmeJ0M4OI/ixjeZrc=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=BYfHMsrncu8mPtlQX+VeaADd+cst6yRgYMKl2ueAgjtn80bD6PJ1Ev2mm/cxzJUvn
         EPYpb1e9mOIpQ+0OJi6SxOzyCFXyNF1wuxq6TB8thPULWT0ew7tThoLrcl02qfn2Nb
         MwnhojhX6pZOwobCkdFuNL3gxZa9sU6EkRv1SkY26LeLsJjFxLA1xkwyckTKDJHAqH
         2cctU9TSKKrHQSSdy2DfMt2HOHmTCvJZY3aozvFF0xlSOmR13EoHCIjyH66dKkIXKe
         q3KuWyZQdkquQICLbZ7gEE0pD+djD85JJgovDh30Vx/GyHGvg6jIOp8IVTstl0eNrc
         qHZqYdZcXBNrA==
Received: by mail-ed1-f70.google.com with SMTP id ec25-20020a0564020d5900b003fc074c5d21so9596832edb.19
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:48:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r9HPg3JSAEOg9NmbHzzSoR6SujxmeJ0M4OI/ixjeZrc=;
        b=AsxSl1gRjvh8fzQlHinYNWpGacnjSF8RdFY6e20iVSHYU0Z9YEf6YcXAYCBdFs6itI
         bhbivC1+Iskr0HRwTkzhFNVUg6q3DUmLVepl/LFJHMttuUh6nMpnBJXAW2zF0V7MoccP
         PAvnnyx+4txhAF74tNYvsgFPlzQVibhtwRa/Gif3vbFqEKZt3f7L62d2UGQtbHw3/QDz
         zlVI+98HH7M14oqWga1v3zhjKylR5a+3kjx2Ev5fCRnMx8qtmOTvsmg2OIhNe8PKOuH6
         iuXm3TKtz+4CYMa8yorQVo4BkhKIyzn964SeK/1yUV7L707Yk4IBzrpWdWpifixW/kEL
         YScw==
X-Gm-Message-State: AOAM533YS9YIs3S6+WAFvjaC4sGHR6SIZwxXEQi3OdbbW1h6A8fwJHA0
        X2fetjp9L8QCK3QBuSX5J3rntq5AkY7lWgFHYNIoyfXlDmQ+yIeW/3EnI+JLS7TmulT15ZUgaiH
        6suqTljumS7TOaBh7rhAe+73KdGpUVtdwRockvURsMg==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr5358987edb.213.1641923326088;
        Tue, 11 Jan 2022 09:48:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+p+O24kX8sPC/HNYpy64NZDAo6pLYgZcq2YV7Eo6ROyfYbvEElF6pogK2B2ET8YMiBcR5aA==
X-Received: by 2002:a05:6402:2926:: with SMTP id ee38mr5358977edb.213.1641923325879;
        Tue, 11 Jan 2022 09:48:45 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i23sm5224489edt.93.2022.01.11.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:48:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 1/5] arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
Date:   Tue, 11 Jan 2022 18:48:01 +0100
Message-Id: <20220111174805.223732-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412D3480B7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhL1QnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:43:15 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39628
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235594AbhL1QnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:43:13 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D744A4005A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640709792;
        bh=5OFsFqaSGsjPv5sIh7p3C4dzVLnGHorZakfLh7myIfQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Z+ifqaxKWUPnEeUgUGnotji4zwpQVOjdmyVFkcIjfwtZgonLYzPFVBkmQjUvMXU/+
         /ue3rq15HH+7K1OWhM6TA28Ov7rk+w8lPZK/Sh7dxHzqRmje7H3qhaKF57G9dsbYUH
         +SQ+IR/hds3xmOn2SqsrnjR3pcvspNYV9SRBAp6CjGf/IFwt4SIcuUxZLYSbnqKpgy
         vHzsNInq/jNswfNQWp4YY7w/Tx78TU28L0/mFVx8IEx3fzPay20l6s53CZNJsax7io
         EduAfXar313iBwicFlGx8AjkNMHMAY3qlWN3YbP8+L4+0eCSLoXnV8rkA0nAb9viL3
         3wgLh0+itynYw==
Received: by mail-lj1-f200.google.com with SMTP id a29-20020a2e7f1d000000b0022d7438b7e4so6188995ljd.15
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:43:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OFsFqaSGsjPv5sIh7p3C4dzVLnGHorZakfLh7myIfQ=;
        b=XnsluEkwXdjtFwe6Raa7sL/T5jwpF/QdP7IAli15s+VkgetRcaQbfeaBsS/IgpGg2M
         nuAG/70Vkyi244fCF5rL6WzOV/Zqv1ebSYdKzmAeN3qyKgIkN2qArHihAkqSQiAWOEem
         F/giwCz1am8VkKzNRjy4frgz7zTojDJaaqwEaxAS0VAm1dTMLZ3MHyx0nA6PjVO2SF0f
         THvT4WXcA/yOC8LIb35FhD7rOHcfUmSmYqg2zpB5+hgBcFMueaGUsfdq/raPrrRde/sV
         xBD6jh5EHLGQYOMwhpTmHuc7AKOGA2oaiRAMa3xfIQfiZ8eQ3augAjwkLg4rlJTcPoQQ
         yqXw==
X-Gm-Message-State: AOAM530flZqJ6r4EwdVQv+oIVT0P5PhBgeqWljGwRc3AMUPOkDWkw38y
        sTFYxzzBhJGi5Qq/qszS6YEcZrpCEl8y8GDVWXx+R7EDyYSb9NUeRipUHs8kc+iBKH0K7aWn+Qi
        gugI6JyG1xIvh6pX6klxMKAIs7O6Pt54znlLPZ6xr/A==
X-Received: by 2002:a19:7902:: with SMTP id u2mr19792373lfc.512.1640709791948;
        Tue, 28 Dec 2021 08:43:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQ/rn6qxMTI3Tjk19c1umU0DPNGMBgrso02fway7KgHERuxbrNFI343SLKCOLNwxZHtJmq2g==
X-Received: by 2002:a19:7902:: with SMTP id u2mr19792363lfc.512.1640709791801;
        Tue, 28 Dec 2021 08:43:11 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u5sm968701lja.36.2021.12.28.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 08:43:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: exynos: drop unsupported MAX77802 regulators on Odroid XU
Date:   Tue, 28 Dec 2021 17:43:03 +0100
Message-Id: <20211228164305.35877-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
References: <20211228164305.35877-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The numbering of regulators is not continuous and the MAX77802 does not
support regulators LDO16, LDO22 and LDO31.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index 884fef55836c..356d5f15dbb6 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -394,10 +394,6 @@ ldo15_reg: LDO15 {
 				regulator-always-on;
 			};
 
-			ldo16_reg: LDO16 {
-				regulator-name = "ldo16";
-			};
-
 			ldo17_reg: LDO17 {
 				regulator-name = "cam_sensor_core";
 				regulator-min-microvolt = <1200000>;
@@ -427,10 +423,6 @@ ldo21_reg: LDO21 {
 				regulator-max-microvolt = <2850000>;
 			};
 
-			ldo22_reg: LDO22 {
-				regulator-name = "ldo22";
-			};
-
 			ldo23_reg: LDO23 {
 				regulator-name = "dp_p3v3";
 				regulator-min-microvolt = <3300000>;
@@ -477,10 +469,6 @@ ldo30_reg: LDO30 {
 				regulator-always-on;
 			};
 
-			ldo31_reg: LDO31 {
-				regulator-name = "ldo31";
-			};
-
 			/* On revisions with ti,ina231 this is sensor VS */
 			ldo32_reg: LDO32 {
 				regulator-name = "vs_power_meter";
-- 
2.32.0


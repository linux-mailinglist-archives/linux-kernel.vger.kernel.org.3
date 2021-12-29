Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39CD4813F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 15:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhL2OPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 09:15:43 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36570
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240174AbhL2OPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 09:15:35 -0500
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B0F46407AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640787334;
        bh=HbKpfkrZUGdadD7XmgDwzNz9vUvDJVLjf2lMxGGzeCA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Es7GRG35Q2c9lUb1rOL3h00HWAww7hFFlh/y6OsLz4BGjY7k92kEtuHa5e3FZR7MA
         tg0IGF+sMJqu160hntY7BKEF0b7cl8yhplAkrNDl6arlCznffNz0vSkKlpo/sHqIdx
         8rFG/XhfrKxhgPUsjhNZFcRxpFvpFHVadN+4LvLsF1/J2tO95+awTSSutc4Wzb6vlO
         LBYJOBj6rwRsmIb8C0yZpiHPztPloMTxcZ+UIZCvIW/edb+Kmm0pPcj8wDy9LDPtHK
         gcmskskRyYJR3gltuCioN81Xy5qfn+IfbYCzVEOmNEYWsW4j7fRx7CYmnRe4XJpfZJ
         pcejCvzpd5XGQ==
Received: by mail-lj1-f197.google.com with SMTP id u9-20020a05651c140900b0022dd165d92bso3744943lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 06:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbKpfkrZUGdadD7XmgDwzNz9vUvDJVLjf2lMxGGzeCA=;
        b=kNcIsqu4Yq0tjQW76qZrR6RxoFg/y7KJja7N8ZPeB3+AzodDI87xisSvW1grd+6ltj
         nglraxIIXZO+OQizKLQJmGSI9V33pMDV58VWLfzaIgPwD/Cw8tE3dRJHBrVkSuZF4eCZ
         29UYQj4Naw8elqGcIBmjIqcWVGdwMMsUQUIk8Nmwd3mOOFqhCMhnoQ3MvKAYHZXFf639
         B5CF8GCcPHUo5DGcODV0pv5nZ0gtqxwXw0PPP8AEU4pWR2s7QBNzW7wSMttjZ5lbOFy3
         49oubbz57ewKzLkEBH84pG5qTV2Daq2XS02RH4Gwe00es856SMext6cXOug5XXlVB0G+
         7e+g==
X-Gm-Message-State: AOAM53352aBTsmDmVDLaHuGQm8+suUt29wGYrKq7LUxK2pGIpTyyvwiE
        UCu85G2w4iZJyo1A3QtjzkPknazdtFSRk+crpKbuWSa3mi4pAJGaMIx+l1q/zYmiiRR99vGf7n9
        RVivSBlEaUwiweThMYcO+1YA6J/HtV/Zcb0HDCWm01g==
X-Received: by 2002:a2e:8296:: with SMTP id y22mr16677140ljg.428.1640787333911;
        Wed, 29 Dec 2021 06:15:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjXxL7aKWt636pncf+xiaoHP44LWKxcavbqPXExP82pcMnBTYB6VgLf5x+PqOMV16O88Co8w==
X-Received: by 2002:a2e:8296:: with SMTP id y22mr16677129ljg.428.1640787333748;
        Wed, 29 Dec 2021 06:15:33 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a16sm1316164ljm.98.2021.12.29.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 06:15:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
Date:   Wed, 29 Dec 2021 15:15:21 +0100
Message-Id: <20211229141524.34174-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
References: <20211229141524.34174-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced dtschema for MAX77836 MUIC requires proper naming
of extcon child node.

This should not have actual impact on MFD children driver binding,
because the max77836 MFD driver uses compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts   | 2 +-
 arch/arm/boot/dts/exynos3250-rinato.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 8b41a9d5e2db..02a9dc479d34 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -69,7 +69,7 @@ max77836: pmic@25 {
 			reg = <0x25>;
 			wakeup-source;
 
-			muic: max77836-muic {
+			extcon {
 				compatible = "maxim,max77836-muic";
 			};
 
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 5f7f8fedfb92..6d2c7bb19184 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -70,7 +70,7 @@ max77836: pmic@25 {
 			reg = <0x25>;
 			wakeup-source;
 
-			muic: max77836-muic {
+			extcon {
 				compatible = "maxim,max77836-muic";
 			};
 
-- 
2.32.0


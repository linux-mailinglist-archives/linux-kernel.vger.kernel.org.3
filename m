Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE60C48B442
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344029AbiAKRoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:44:24 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53452
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241502AbiAKRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:44:19 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 274A34076E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923058;
        bh=HbKpfkrZUGdadD7XmgDwzNz9vUvDJVLjf2lMxGGzeCA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LOkmomodQEQZ7XER7XdGTg/A1guSOPUpRuHHsEdFER4h8sNXzvAK61dR0zxpx9Qvt
         bHhEliRAK2G2Qi+qq9l+poLc/EW/9YjAXSonuQiR5JfYsV2cD3HTy2OCGfdAuAYWyt
         q5/Ebm2GpqUk8WoWKD8d/TPqB0imSzmIxQpfhNHa3I1ubc06a5qRzjqjYTHlQ3Ag/6
         nnF3pnqfGQJIxqetirmQtVhy1lZfqFNuMwSD9ZswDOIa7pE7MNK/FiCk46iYHLVmGU
         VJdKenyjYbpN9wdZggH/+ql27PSvIE5wkaiIlQRe4VE8jipfYPLEAjMH9VDXGH0CSh
         /RHLnYs2521dg==
Received: by mail-ed1-f70.google.com with SMTP id p8-20020aa7d308000000b003fe9b0c4760so3825391edq.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HbKpfkrZUGdadD7XmgDwzNz9vUvDJVLjf2lMxGGzeCA=;
        b=c9vh52hlgndi2drkLWr6PAs6YwzkED3JJrvAH5hBMe01oY0Q2sGM7vYR7UU0458DH8
         saR1SGDOb2y0Fea2KliLvXDHNQhicc11TgrB8pe3uQeJO/tUMkF9MfK4bsD9TVO+OGTz
         HnoZlE+wRK8V8OOEV/JJylsiFSsTfLvXEAD3cXKLV/GEIs5VMOCU9nHrlahRYwA69dKf
         PWFqVS2PAB4LVttWyxi/PsTb+YKDgjr4FFgbAyyuk0p1Py/lh4AKyF8lUDjblo9fFLby
         sr6AcxL6PvcyjAgiHSc2WPanlwE8z9uwaBpQ9VFpGJAvgEHBV5tDfcy26MNBUt24+8gj
         DpNA==
X-Gm-Message-State: AOAM532OLGpCzejLiTl+Z/4531SQ0EQN/AoAse90Ki0JSVDyIDLg2Mqw
        KXtJpTO7F6gyeTawvivtabtdDDgcaiZUfzTy8hm6QvCgRolIJPY9BjzjwQFvRuPAJT7ikCjjM3E
        cS8QXDJ2tzAL8FwXwYbvECw00BA5VgWCDhC4BFuhRDA==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr4393042ejy.543.1641923057862;
        Tue, 11 Jan 2022 09:44:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcy6vxPNZHkL/0CL6ykZS2+K72ACBNrvG7TKjPiCN6vT6isj8/Hp40qNuu0wHVVxtz0VbcYQ==
X-Received: by 2002:a17:906:b00c:: with SMTP id v12mr4393032ejy.543.1641923057670;
        Tue, 11 Jan 2022 09:44:17 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id g9sm3758657ejo.222.2022.01.11.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:44:17 -0800 (PST)
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
Subject: [PATCH v2 1/4] ARM: dts: exynos: Align MAX77836 nodes with dtschema on Monk and Rinato
Date:   Tue, 11 Jan 2022 18:43:34 +0100
Message-Id: <20220111174337.223320-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
References: <20220111174337.223320-1-krzysztof.kozlowski@canonical.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D9C482C46
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiABQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiABQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E5C061761;
        Sun,  2 Jan 2022 08:57:45 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k18so28949042wrg.11;
        Sun, 02 Jan 2022 08:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=KrQgZJjucRqLWk+uOuwmX5KyeIny71EXNyuDW5ReDsZDQxPfLsy3zaKJYjLQzayvdK
         DJBbN3/N8uKBoiET37O5zrKeQbO4oD1UFT+tIleBFO1GoaPkFTFciqkwhrMctHecf1XZ
         Q93NH8X+a8Vm3ZAL95VYsrR1Aqf5p9yBBj5AUGa+fGNgtmzohz1Me4NUhIrVVruAIYYQ
         c0nF3nxZjgMwaugVzcNcQCmf/+38sJMikHYG5D7O7LIKcWGxkYffWTZVibveR8cGx18q
         NRRti0YYARTQxsyca/tWjZY9dJtwdp2qoGGumBL5yU3PNTbORCeo8ecKekeyfyTF9D9u
         TaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=JdH5LmY7b8hMwvj1aUuakmG1pzG+xA9jS/BkeGQtSYPvUkNeBDSaf2uMU6IlmRIgHP
         rn94g4BXpvpLL9Deg8i5yHUZI0CZqqtK5yPotoyy9YDkISvLT2Dzf4HoPTSOe02u50xw
         wrKvTOqtd2iXHGxpdETPlBhJLNpaOMFsvCtywmvOd0KIfPf/9NWoPCyDPbeNAjzHGj3C
         UTwm9QVi2HeiMIOKp0ZdeXNfS0NDQa6fK7C0fMfA0H4+NDVy78qOFIQGQP8d84qRcg2q
         vnxrY0XL0DbvYSPwJIEc4sGckNnBEPLVZEO8m9Y7Qn1WfitpFo8Hnpl2I3f1dJ0sbt2J
         qhIw==
X-Gm-Message-State: AOAM531JheNPHPka+HkxnMWbzIIC7Skoad0wZ2UqSssVaa8lgx5UBdIr
        XpIwUqhPZx71w8nhOGKkOjE4i3sniHSxMA==
X-Google-Smtp-Source: ABdhPJx779LWBPXjfsrLOgJIV4ApKAEJ67RdpJ7OhOntFNmIMbXueBJBbQk7NNU/oCrZOuXcDHQV7w==
X-Received: by 2002:adf:f384:: with SMTP id m4mr14509211wro.524.1641142663994;
        Sun, 02 Jan 2022 08:57:43 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id bk17sm2095664wrb.105.2022.01.02.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:43 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] ARM: mstar: Extend opp_table for infinity2m
Date:   Sun,  2 Jan 2022 17:57:30 +0100
Message-Id: <20220102165730.50190-10-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity2m are running up to 1.2Ghz, this extends opp_table with the
corresponding frequencies and enable operating-points table for cpu1

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index dc339cd29778..1b485efd7156 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -6,10 +6,25 @@
 
 #include "mstar-infinity.dtsi"
 
+&cpu0_opp_table {
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+};
+
 &cpus {
 	cpu1: cpu@1 {
 		device_type = "cpu";
 		compatible = "arm,cortex-a7";
+		operating-points-v2 = <&cpu0_opp_table>;
 		reg = <0x1>;
 		clocks = <&cpupll>;
 		clock-names = "cpuclk";
-- 
2.34.1


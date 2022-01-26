Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD3D49D147
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiAZR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbiAZR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3468C061747;
        Wed, 26 Jan 2022 09:56:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s9so409598wrb.6;
        Wed, 26 Jan 2022 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=flYDVQBDLjA81NHjPaYBppGWq5mETdHWxrDTn3Dbnwln9/TBEzkdnKZDe7RG6nPKOd
         dHm3QNW2gGkyIwMoF8vs2rh40atl12yYEhFFUDnianqHAJUMceTYtMvgVLPRuNO5CRec
         hKgzSLm/l07nkz05/TF82VbNTOvWiNSdQNjJl5j17UiPZRvKj0EqYvqxsispKvD5ztHF
         1e4kP81VTp35dGpp+8iiVnOxitL9I3EUn9EeIInYr5yL6RvEEXPFJneJwlO6h+ci4VxG
         zNaTTdqo46RePFXDCgZcmzELi3j6+sVk91frZNSRY0G9V0PhGTG2evKsCwmzgsaUpEmh
         8rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iD/CADMJmjE6Wqsta+zyCvYv9Ey28eqoIb5w5xoLVEA=;
        b=IokXJ+Sd7zVJhW/NGvHvMgHEKRX89nevswGdxP0k8fBFGogYfAOmmiZxAPh85bfO4x
         M5EInlTFiATnpQeMasTjFLSkVfdxIyC8QdKVg1gyfQttLoruT2rfmMIhbLWhQt0MqWBd
         s7ohWyKePDINRm1u2fidsrh9ShdiAXB4oEgoSEEuDjODa6o3odajxuUI36e7iL5e+6fo
         9ACJzWQk0JV6/JiL0XeO87qDB1lTlAL8fljYFJ7hzQAHLP3ltAgDazpHkjhvR8giiear
         e3/lASxLcUPBuU4lEs+x72xvs259Xk4gtyXEQ7WB72d/S3nV8u5oM2k85ayzh3zA61KX
         qtMg==
X-Gm-Message-State: AOAM533dwjI8Bl/MlkpGvpEcs1MP/4WykL+wE4L2DN6RYgdrfpyiXh5V
        opPwQTgZW/VqgRn601ZVuqH2gstaAApVQw==
X-Google-Smtp-Source: ABdhPJw8fPH9A4/VhWfdDH8hu/O77mu+3yiNPKg2taaBwgHgn2QguKRql4XLNDPx64znUUkGamzang==
X-Received: by 2002:a5d:4288:: with SMTP id k8mr23087912wrq.657.1643219781128;
        Wed, 26 Jan 2022 09:56:21 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id d2sm19935638wru.40.2022.01.26.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:20 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] ARM: mstar: Extend opp_table for infinity2m
Date:   Wed, 26 Jan 2022 18:56:04 +0100
Message-Id: <20220126175604.17919-9-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F834965C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiAUTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiAUTgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:36:00 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD020C061744;
        Fri, 21 Jan 2022 11:35:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l25so1509856wrb.13;
        Fri, 21 Jan 2022 11:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StcZHqzmvLp6v5k+mwDmcDs/ahnsoFhEqrHgEMI6OjQ=;
        b=NdscIRvh8fAAFXuKFaXuFzMMpmCBhWr3gQzI2sudRnqcA4FoFC60bzcV0qDFs05El7
         w0RQOojsRJGakOew/tA761yJATOkkJoQ4KP8URJQDCmpcCSyAP5GfFdklfJyraWI8Clj
         gw8ffadp2BQ2hciyvG5bemoNmwKMYEmwnrbZCerGot8+SFeJrCOBEaHNVbXvgjd7Itl8
         HW1CnMvw7Uwu8GiVGwS0WF4MN6UHse+xOgCnjR/A+w6pAFWYr5xXgaf6NbujkO2s5A6V
         PFqbytNQtIZHQISsTB8RUiFs30XvypU5MSah3sRZnwP393N3vCcrBb7+VeDOY5tfADot
         pqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StcZHqzmvLp6v5k+mwDmcDs/ahnsoFhEqrHgEMI6OjQ=;
        b=1KtPPYHdvhwT5vWTj1cUAmM2WHrf15r+Usn13xBGj5ipvelvSzPTEylwlV9IxkgORv
         tr3NY10QqGsRHFyO3tpl8HxHAkT4az+jJl2FW5QIsXu8cE9uLLgrlnNhd7WUCcwLPaj7
         YiJQkL9dE1nD5YVwoEAHYvEduIDFa11xtjTlpL/CVIEKBtaJwc4TBN/h2pyDir57RX17
         nQOMxHfRm4lbcPETfhCHrGHrEkudThI69us3rQelnAGMTuMBCa7J4WlSDmgcUjqP++pJ
         j2NTGJoOgIjNVYX4BNHeQzH5xZ+/Nkx7iywJ2PnsqiXwPmnZHYBaa4U01sNxMVr7QX3K
         o2dw==
X-Gm-Message-State: AOAM530Uxy9QsY6Lt65dwIJUSU9GBCVVYiaosq/+jP55+scDbX5qZOEN
        fC8QI/VEbQl2R+KqxDH4X0L6w28k0rYVwA==
X-Google-Smtp-Source: ABdhPJwE9vP9ZtU3zbsjE3UwgozenBF5PKt1srh15GTFxRwhjzhtsuQQ5sU8utey1E5qVE8U9UJNeA==
X-Received: by 2002:a5d:59ae:: with SMTP id p14mr4877325wrr.559.1642793758047;
        Fri, 21 Jan 2022 11:35:58 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id f13sm7201114wri.49.2022.01.21.11.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:57 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5
Date:   Fri, 21 Jan 2022 20:35:43 +0100
Message-Id: <20220121193544.23231-9-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add an OPP table for mercury5 so that cpu frequency scaling can
happen.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-mercury5.dtsi | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-mercury5.dtsi b/arch/arm/boot/dts/mstar-mercury5.dtsi
index a7d0dd9d6132..80a19bd23c9c 100644
--- a/arch/arm/boot/dts/mstar-mercury5.dtsi
+++ b/arch/arm/boot/dts/mstar-mercury5.dtsi
@@ -6,6 +6,42 @@
 
 #include "mstar-v7.dtsi"
 
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <800000 800000 850000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <850000 850000 880000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <880000 880000 890000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <900000 900000 1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <900000 900000 1000000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
-- 
2.34.1


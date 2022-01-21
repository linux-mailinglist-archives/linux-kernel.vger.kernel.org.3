Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D374965C3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiAUTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiAUTf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F285C06173B;
        Fri, 21 Jan 2022 11:35:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso23373717wms.4;
        Fri, 21 Jan 2022 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MwkPi3zTHNX/WgU468/COGljzbksLucVcX9Vresnwgs=;
        b=LwnDHY743c6eDbeipZdlM8nn4Dgac96JeYrvbzh6fJdwrL35SIQ9aku/vaFiTegm3I
         SNuL3Bmz+M78HJHbi5s+cuiave4A7a7zlOwklF+Ggc2cKwnOg7hZtijbV5aktMdXKxIo
         ZV3JLYW58W+KMvDySOGlYyUR4xsnAzon4tiyrlqVSmukDZvgm0nJgh7KHyLFqc315M0q
         hcpykVuCISlRUuGHZZ9DPKRtkgpR7AIa33NfxCVz2vFwOajBy3HpgqGtzF3cZ7jHh0+t
         X5k9KT1C4bmll5y4l+VUQ1uzleNv7KLOfA+Pre0ejloffDRu3Lxr60VqSLRbKha1pA+9
         xdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwkPi3zTHNX/WgU468/COGljzbksLucVcX9Vresnwgs=;
        b=7SgxewGoXXdKyi5gB8zr36rQ/eo8y18e5NrQEE0h1wGBWVQrFX8YMs8Lxjv9cvoQDJ
         dzobu1te0Rqkpy9dWCt9WbDhxQc/CGWuwMOxRi4WaELNMx7ju+lXz2drt6t8U5kBudyz
         2TBcmSRzP7xle1n0c6U1NrSoSTvtl8lIhCS2ZEWhIaVWlSLMa1KjoChduVYXAt7yGD8a
         kAkjMsVPRhlrDdZlkNtgE6XL5JAJdiU/bmdp/HE2kInbYO0zYSu+cMRja/NvpBNLm0Q0
         TrnD8lnADd8ZrCdasH23ps37RreUWLbZq7NAjLffTtHLbC8xtgjBQ0yEe9dXAwZZy2OC
         v4ZQ==
X-Gm-Message-State: AOAM530xSOLqcn3o/FvaeO9pKwqneVmbCSOf+oO4iNRIFlYQVNGO3efr
        B1b6gcI8a59BCVRq6k6lePQ=
X-Google-Smtp-Source: ABdhPJyFsQthU3A6b+uTqQqhxIKQGXmdPyc/ikXDfHK3s6P81y5blSPkoLY8ftvYXEVZEY0zDYbBpA==
X-Received: by 2002:a05:600c:255:: with SMTP id 21mr2093446wmj.108.1642793755826;
        Fri, 21 Jan 2022 11:35:55 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id n16sm6151123wms.13.2022.01.21.11.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:55 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 6/9] ARM: mstar: Add OPP table for infinity
Date:   Fri, 21 Jan 2022 20:35:41 +0100
Message-Id: <20220121193544.23231-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

Add an OPP table for the inifinity chips so
that cpu frequency scaling can happen.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index 0bee517797f4..441a917b88ba 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -8,6 +8,40 @@
 
 #include <dt-bindings/gpio/msc313-gpio.h>
 
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
 &imi {
 	reg = <0xa0000000 0x16000>;
 };
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1240449D146
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiAZR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244015AbiAZR4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:56:21 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E6C06173B;
        Wed, 26 Jan 2022 09:56:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r7so183705wmq.5;
        Wed, 26 Jan 2022 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YbbfYaxNXJjiNo8O6xmEfb2M0Ik6NihxDDvfwKnfopE=;
        b=LLbJQvi+fx8IkX14ezqcJmTTKm1B3+EKjhaD/fKavWP4YIT5w+OIlgUqgouf09gROv
         eTCkFvChgj2vYIN+H2LbJh1XMa3gCZT5U3VeXFwvvp8W3QEiBlAXf1uJbGwrB7IOgu2G
         TPDTU45uGhS8eoy2095OIN+S7KLNXNmvNdhBjqVQL1PxwBTML4SUADU//0yXRw2NHAdO
         DmCuRNMMxGTrD2zWP40nvf5KOkwreYz3iI7Qh2AJwSzYtefrm7h+zbAk0XoiKzOMkPwU
         vB/LhfmBJLHEWVEU7ZpZv2BK0uORZq897AQ1Rbxnw7L3JZG2Bavd55l237TbMvWhvyvj
         39RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbbfYaxNXJjiNo8O6xmEfb2M0Ik6NihxDDvfwKnfopE=;
        b=lK3QJlzto7RWaIRCNw3D3J3lgYZltnLe2DfsqLAA6uWjm1pXhs4fXlxkEvei1ATFHD
         ahWGc0+igwvitUGKgU8TvK6E8t5JcSsAcE7FkgiLV5wgx8HeWjGmS+hrhdm6SBiXQtNd
         PRLvctf1fbT+hRZlXr/JDkHApOoR2BhD/NIUtZ32/Vo7VOqkbHONTj0Vo/jbw88cBo5L
         na761/W7VMoKjL1Yr+bvQgm/v4WiuDE1vFnNH5jxF78w6qW0otulU52ThalfS9QtuIKO
         mODn41jQsWXiYc8D7L4zrvzRQG+w5ZPqEJblxKu+evH9BcRYLSG8UiNam0rPvY75kn8Q
         2NJw==
X-Gm-Message-State: AOAM532mbRGvxAiIln7nuRHRbotLMQH1brORvRAvVeJAwgzJi9KsPkZ+
        0A3DLI9IAjVfddfXp8147n4=
X-Google-Smtp-Source: ABdhPJyBNh0xEqsTSW37ZhKBR1IOZtVGY211ApiFMYBC1fYxhO0v5UJvpml8Lc7sVcNj/31SGIzgBQ==
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr8052798wmm.8.1643219780052;
        Wed, 26 Jan 2022 09:56:20 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id u3sm10515371wrs.55.2022.01.26.09.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:56:19 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v4 7/8] ARM: mstar: Add OPP table for infinity3
Date:   Wed, 26 Jan 2022 18:56:03 +0100
Message-Id: <20220126175604.17919-8-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126175604.17919-1-romain.perier@gmail.com>
References: <20220126175604.17919-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

The infinity3 has a slightly higher max frequency
compared to the infinity so extend the OPP table.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/boot/dts/mstar-infinity3.dtsi | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity3.dtsi b/arch/arm/boot/dts/mstar-infinity3.dtsi
index 9857e2a9934d..a56cf29e5d82 100644
--- a/arch/arm/boot/dts/mstar-infinity3.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity3.dtsi
@@ -6,6 +6,64 @@
 
 #include "mstar-infinity.dtsi"
 
+&cpu0_opp_table {
+	opp-1008000000 {
+		opp-hz = /bits/ 64 <1008000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+	};
+
+	// overclock frequencies below, shown to work fine up to 1.3 GHz
+	opp-108000000 {
+		opp-hz = /bits/ 64 <1080000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1188000000 {
+		opp-hz = /bits/ 64 <1188000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1296000000 {
+		opp-hz = /bits/ 64 <1296000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1350000000 {
+		opp-hz = /bits/ 64 <1350000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1404000000 {
+		opp-hz = /bits/ 64 <1404000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1458000000 {
+		opp-hz = /bits/ 64 <1458000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1512000000 {
+		opp-hz = /bits/ 64 <1512000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+};
+
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
-- 
2.34.1


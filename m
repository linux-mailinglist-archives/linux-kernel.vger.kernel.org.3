Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2955C4965C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiAUTgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAUTf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:35:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665BEC061401;
        Fri, 21 Jan 2022 11:35:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id r132-20020a1c448a000000b0034e043aaac7so6051985wma.5;
        Fri, 21 Jan 2022 11:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21h9f/ui8ZIqSSrHzJ4KrN8YACvdlcc8m+OIu8z6NvM=;
        b=ChJ5C4kaaPI5FOo+yQV886VnzSu4zGeWDBiucW3jXXe/7bjC7nwsfRhhl4bKytkqKY
         4+GOSQf6Rcb6PtJ9fpTMvGwk758DhPWsP+f3UhkZV3/i9jc7BUiEwYn58oDY/WzXyD0b
         EkGKdXAxxgFJ7ST/ZPZh8yvgwy+5h5fv6/aY0B8O+Kc9xlNMmmVHI/bAid4E5cZ9BQQt
         TLhFGobrz/vTKhFU2XOygjqhSwBQ5pSgdWRpY5BuP84uqlYtn2BJeVJd+0d56vpYVXaa
         +KsRwxhGYZEOGXsryPxJ/fk0J6f260RmmQFw0X1rik8zDcRhccTR7J8LzeE47h1Alqty
         cRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21h9f/ui8ZIqSSrHzJ4KrN8YACvdlcc8m+OIu8z6NvM=;
        b=w2t2e43hXPXlpyxhfGldUuLZvBIToo59iGdGyPQr5+wafyP6zKK8xA5ClYqNMt4xIm
         Ix+jJC1P3ftKEBPqwPpEDOx9cmhq0R9bIDYR4q7PLIMIYUTf3BMspITno7lXzRlEsFbU
         7wYvojVzW7U8wVyiqQtjkXQ2AfizWQ53EaTnZ9oF3iwi3gT6toY9pt/Pa5YJ5MebFzjw
         8HjSlSZASswg50v3hG9jqui5wZOd868A2HufrhBzjgW+2OdUgU9yarC95JwNfawYCB1s
         gr6FmTVsgJeCuhDUmPIoWeG4DGIHOg8dbrzF1g0gAa2sUEllx+BMquiz+Pqobw8IuZez
         d6Ng==
X-Gm-Message-State: AOAM5334WWIdt/CNU8OuG8jlX5PtxbExvghcm8P/2jYyzoP0Uqf6mqdZ
        lO+OVRSScMg8B/9jY1P3x4/9V+Q9vetOtA==
X-Google-Smtp-Source: ABdhPJyF6mhUKvyKvBtUdyPCx+PCcxt329Pk0xVJAVdoo7pJZUxMrUv2vevCHFg3ydT1rwgY2vKS/Q==
X-Received: by 2002:a05:600c:1da2:: with SMTP id p34mr1987262wms.97.1642793756985;
        Fri, 21 Jan 2022 11:35:56 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id p19sm6213407wmq.19.2022.01.21.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:35:56 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v3 7/9] ARM: mstar: Add OPP table for infinity3
Date:   Fri, 21 Jan 2022 20:35:42 +0100
Message-Id: <20220121193544.23231-8-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121193544.23231-1-romain.perier@gmail.com>
References: <20220121193544.23231-1-romain.perier@gmail.com>
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


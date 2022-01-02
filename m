Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDFE482C41
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 17:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbiABQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 11:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiABQ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 11:57:44 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5147FC06179C;
        Sun,  2 Jan 2022 08:57:43 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so65574323wrv.12;
        Sun, 02 Jan 2022 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21h9f/ui8ZIqSSrHzJ4KrN8YACvdlcc8m+OIu8z6NvM=;
        b=ElGGNSCD9QRK7+dw5nfGGhnn8BxEqs9+Jm/XI0ZtwxDwdeI7y6hp/nKKzi8OmmkTfd
         DfesxdRQQk9RqiyI/gy8nV7M1JGKw5EXwm1V8ZsxS4++cNwA9Y9cvcGFKl3yJ4TYDFJR
         PdQo3mBGXpTYUy6CjffI3IEKAMAs0z/QXgFssHDMe0orAfv10vB6jROWsQZ3td7PZ/Cd
         L9axkJZxSYMmyaxtnUMJ6UL9CFqC7S8Zsv4AXyzVbkF6LBpcxF/KA/W4R0WmoM6CWEYp
         Rd2Zt7f2YKdTAI+W8rAJkk5EKgtHHmQ2E9c8rt/nJgcbaTcrXFkVN5W0pZaqji6gTMJD
         E99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21h9f/ui8ZIqSSrHzJ4KrN8YACvdlcc8m+OIu8z6NvM=;
        b=FvjYyLLaNvp5KpnOLK6DHPUnpThtJM1sHELA54l/dh6ebyjmgF1N/QmxwsV8m1czzW
         gA3lDYy+XR9gg4yEguPXhsr7mp7krp1SX3EdB8RmyLDntAX7Z3CDdqQDNM0rQPNRqnLB
         5mD9tOkHDVgH5q98vCmzxTmmn9Z/jvF+vh4+8y6ge+pbkMEEpMWy8388pmigWcHElGQ/
         gHq5r+2SwCovzjogWtj5Yp+Bd0MCV6/9pA6DZwX07tmKMfY5SWikDj0fNqIof4HL55vP
         NTabJQCRAaE32DjYsDYRZX0swVc4/riVyORihZkpyFDMLqJHatggH+5MOImfUd+4no7V
         w98w==
X-Gm-Message-State: AOAM530wbLwRVmT0hl6wX0EeVJIReNFgRWF1mwL1ouk7Ik4LR2YohyD5
        k1XaYJ5QpsMWd++O03JAQdE=
X-Google-Smtp-Source: ABdhPJwJOhTLzvSn3l0lO6PPzb+/Xo7IVWWa+kzDE8rxBggDHlIZdM774Ruhx9LE0tOuEbvyX2a6LA==
X-Received: by 2002:a5d:440e:: with SMTP id z14mr14054757wrq.611.1641142661995;
        Sun, 02 Jan 2022 08:57:41 -0800 (PST)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id y1sm32261901wrm.3.2022.01.02.08.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 08:57:41 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 7/9] ARM: mstar: Add OPP table for infinity3
Date:   Sun,  2 Jan 2022 17:57:28 +0100
Message-Id: <20220102165730.50190-8-romain.perier@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220102165730.50190-1-romain.perier@gmail.com>
References: <20220102165730.50190-1-romain.perier@gmail.com>
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


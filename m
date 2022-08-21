Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7359B5A4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbiHURbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiHURbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:31:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20817A90;
        Sun, 21 Aug 2022 10:31:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h1so4522318wmd.3;
        Sun, 21 Aug 2022 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=rVeHL3XvYGZ6orYIoYz1XXXquShX0TNS4nHwqMLcSJ8=;
        b=BWcTk6yoxL1icGJDYiDE/gy02YAodotBzePCyFqUDjMk3W3m+9a/P1wWigW0BwdqGW
         clnaCETFOGOYLBzqxPUdJxI2fsY3GUPPZnISYqp3Z5tDW50VnienqWRueZFhwn0Az64n
         VJ4rTgYFx9ANOhpJD7xa4JCM51yIAol3DG0HgX9coAz3acighJ2rKXvbR6SYEn7NRgM9
         f/DPDF3JalF9uGY2J3HYKkfBG29ZZbp0tEGnaoth8VXutPSL5Ep1zlCF/dI2PwuJg2nJ
         ZY1HXi/jT3om7aeE6z9PM4m7AIx0A3MO3A3BPkEUy9x3LT5uSfMF+aXrDzYZ0o0cLT8l
         eb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=rVeHL3XvYGZ6orYIoYz1XXXquShX0TNS4nHwqMLcSJ8=;
        b=N4r/DsyvKcLKLlYL2nePJFwI/1cewGU1YYCzp8Q2m9KL8zu9gY4VY+KTrj8SsRg/97
         DIiV12AQyPhHXQUiYwsAvpSq61MgJjqdnid1cbfbyOolUjecvaB8bPAj4Ms0hClcfuF9
         +GQXgPaJBzJSlnDvGvutM501bBi9yGNfE2/3IeKGwEDBWqSd6c3P/Bh02OnlpFm9Oewu
         /37/jBK91HP06HAG0OL+syjFbuEl8v9AX8bk5RcW600roL8UeRB2zjBYEK3bOQRrFWki
         IpXH+1AB0VpJIcGbRz/62FNJLB9x9b1Gaa6VWCY6q10ZlgZDZOLOF3jhuoWqNnWGcH1m
         pdJA==
X-Gm-Message-State: ACgBeo3XO0M7hx+g5oUUXnjQD0EanmT5iSNtIqmevKkvg13zC4t75EUJ
        Lol2OpFPTUMavbxx1h6JvkhLYnXjN+qTog==
X-Google-Smtp-Source: AA6agR4O1FHEREDqGDsj8VJ42P/BMWkbYBZbIH43j2PApyw1cDuPDlt54sD4PfatY62c4hcqxfxxbg==
X-Received: by 2002:a05:600c:3846:b0:3a6:5292:f8af with SMTP id s6-20020a05600c384600b003a65292f8afmr3625313wmr.50.1661103069186;
        Sun, 21 Aug 2022 10:31:09 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:a77:3d70:9d84:ec8d:98d9:c29a])
        by smtp.gmail.com with ESMTPSA id b18-20020adff912000000b00224f7c1328dsm9387205wrr.67.2022.08.21.10.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:31:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/4] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Sun, 21 Aug 2022 19:30:50 +0200
Message-Id: <20220821173051.155038-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220821173051.155038-1-peron.clem@gmail.com>
References: <20220821173051.155038-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an Operating Performance Points table for the GPU to
enable Dynamic Voltage & Frequency Scaling on the H6.

The voltage range is set with minival voltage set to the target
and the maximal voltage set to 1.2V. This allow DVFS framework to
work properly on board with fixed regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
new file mode 100644
index 000000000000..a66204243515
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2022 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	gpu_opp_table: gpu-opp-table {
+		compatible = "operating-points-v2";
+
+		opp@216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp@360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000 820000 1200000>;
+		};
+
+		opp@384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000 830000 1200000>;
+		};
+
+		opp@408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000 840000 1200000>;
+		};
+
+		opp@420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000 850000 1200000>;
+		};
+
+		opp@432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000 860000 1200000>;
+		};
+
+		opp@456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000 870000 1200000>;
+		};
+
+		opp@504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000 890000 1200000>;
+		};
+
+		opp@540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000 910000 1200000>;
+		};
+
+		opp@576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000 930000 1200000>;
+		};
+
+		opp@624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000 950000 1200000>;
+		};
+
+		opp@756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000 1040000 1200000>;
+		};
+	};
+
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
-- 
2.34.1


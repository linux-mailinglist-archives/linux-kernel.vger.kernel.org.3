Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A455AEFF2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbiIFQID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIFQH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:07:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E6C9925C;
        Tue,  6 Sep 2022 08:30:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso9839644wmh.5;
        Tue, 06 Sep 2022 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zJZPxQVJEy8FT+BLePfAsrbdveDVonWnxw7E4dm+iGc=;
        b=jKxJ93rzIhzwM+an4KKX7gs+eUdz1/4iPoMYXEGxDsJrptfsYkEkmpqywMJbpbLAnw
         5a7R2dZQP0CiDTDqEDS5h/lCedNJvxUCqcbN+LInDDMZP3HBNGsuL0Hg3IMCkKhE6R+i
         IuJmwVoyxm+BpJEk85mmEmFWpfH+bz6RMKP/ZrT+LeQ4tDqKNGAIHvty77DmsWKitgli
         ZyhQwk72QenVaKDKdv5r91j4wclvfUMkjgsdE2rH/IY5vsvwB6ivc+fSeVNvWNwWBZdH
         9oYVJEv0jJja/bvp/vqdd/C9mCtzrY91AJt9pc736309slFTFOPOfT3AdAMtQ6Al1xn7
         FuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zJZPxQVJEy8FT+BLePfAsrbdveDVonWnxw7E4dm+iGc=;
        b=JNvyJK5PWsutY/IVqy0g/gwBEsZcwmE3iOkxuojjva6NavcqU7GO5uk7orsOVbd0HW
         GhlHP9LwzRwMT2wx9VnX+MmuMaj/B0pnhWWwIWgpN5/Ad5l2r5X6PBFZRqwhT5bAxIs2
         iBFqqz81aNoOQYmTFgAk6grD87ERmY9nrtosi4lW+8TGWz4joYgtRCKdC0o+jrqNG115
         8tzQ1gXfsNK+oJRIfd3qLVy5DO6KBv81kTM19LQo9O7NpEQhXoTPXVuNeTLfCdo5F57x
         t5QhMPq5Pfsht5O+w102PHGtDQQqvnA4sK/oSZSKmR1oK4GrqWbCflHmr/eruheWzyWl
         qY3A==
X-Gm-Message-State: ACgBeo3Dm9pSQQE+1LU5jWrPqWAMghXjZoNaQ+MFIrSwhxjx7Ec7/qql
        KdhcLBwX3DXT7Y6yrXTwAf4=
X-Google-Smtp-Source: AA6agR6X8fTOGpPx9SyhJ018vZ730P+biN2CXUDw5K/HkGx0KjlSD838vU8LLk6q1i8Pn9Eltxyhsg==
X-Received: by 2002:a05:600c:3c96:b0:3a6:59b1:5eb5 with SMTP id bg22-20020a05600c3c9600b003a659b15eb5mr14328095wmb.187.1662478241867;
        Tue, 06 Sep 2022 08:30:41 -0700 (PDT)
Received: from Clement-Blade14.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c22d800b003a6125562e1sm14922731wmg.46.2022.09.06.08.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:30:41 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 3/5] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Tue,  6 Sep 2022 17:30:32 +0200
Message-Id: <20220906153034.153321-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906153034.153321-1-peron.clem@gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com>
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

The voltage range is set with minimal voltage set to the target
and the maximal voltage set to 1.2V. This allow DVFS framework to
work properly on board with fixed regulator.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
new file mode 100644
index 000000000000..b48049c4fc85
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2022 Clément Péron <peron.clem@gmail.com>
+
+/ {
+	gpu_opp_table: opp-table-gpu {
+		compatible = "operating-points-v2";
+
+		opp-216000000 {
+			opp-hz = /bits/ 64 <216000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp-264000000 {
+			opp-hz = /bits/ 64 <264000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp-312000000 {
+			opp-hz = /bits/ 64 <312000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp-336000000 {
+			opp-hz = /bits/ 64 <336000000>;
+			opp-microvolt = <810000 810000 1200000>;
+		};
+
+		opp-360000000 {
+			opp-hz = /bits/ 64 <360000000>;
+			opp-microvolt = <820000 820000 1200000>;
+		};
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <830000 830000 1200000>;
+		};
+
+		opp-408000000 {
+			opp-hz = /bits/ 64 <408000000>;
+			opp-microvolt = <840000 840000 1200000>;
+		};
+
+		opp-420000000 {
+			opp-hz = /bits/ 64 <420000000>;
+			opp-microvolt = <850000 850000 1200000>;
+		};
+
+		opp-432000000 {
+			opp-hz = /bits/ 64 <432000000>;
+			opp-microvolt = <860000 860000 1200000>;
+		};
+
+		opp-456000000 {
+			opp-hz = /bits/ 64 <456000000>;
+			opp-microvolt = <870000 870000 1200000>;
+		};
+
+		opp-504000000 {
+			opp-hz = /bits/ 64 <504000000>;
+			opp-microvolt = <890000 890000 1200000>;
+		};
+
+		opp-540000000 {
+			opp-hz = /bits/ 64 <540000000>;
+			opp-microvolt = <910000 910000 1200000>;
+		};
+
+		opp-576000000 {
+			opp-hz = /bits/ 64 <576000000>;
+			opp-microvolt = <930000 930000 1200000>;
+		};
+
+		opp-624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <950000 950000 1200000>;
+		};
+
+		opp-756000000 {
+			opp-hz = /bits/ 64 <756000000>;
+			opp-microvolt = <1040000 1040000 1200000>;
+		};
+	};
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
-- 
2.34.1


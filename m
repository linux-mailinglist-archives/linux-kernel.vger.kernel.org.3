Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3EF4B0A43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239396AbiBJKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:06:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiBJKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:06:45 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF32C55;
        Thu, 10 Feb 2022 02:06:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s18so8559571wrv.7;
        Thu, 10 Feb 2022 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AdLoWe4TJ+d53isrSfLXpob6bEFDfaz15GEr9DTK+5k=;
        b=i5DEQyEGksT5axCgpBQ1hQ2t5ZMnMcozV7HGcpy2jwPAYpT8q8dpUJ8/nSTFrRtnyM
         L3j0GOzou9gTl6wm4a42frUCbFNfR163XJko8qIlUEZYnxb2Ua7EOiNLGBdX75esOlWQ
         iUu0UC9xZYkYjFsKhsllEGVB6vxDqCxNb4e/XwBJg0vH1NxaslaAKqNZx8bFqO0VGzQ9
         3Q0YZ7zOMn4Cxbj8eGJqkYxDHVdHznGS300aTWzKI8Y6RrX7AA5RnC9C4Rdq7XtToZEQ
         kzkJYX1oZ5DAcFLIGbOac9AhgRl8Pke6XWjKtu6dgjKC4hIkCnHtB1hpXVxgBrcy+nci
         GnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AdLoWe4TJ+d53isrSfLXpob6bEFDfaz15GEr9DTK+5k=;
        b=oeU+8nGelARLCELrSdQnXAkHkJB3q7y7VsGMz2fUx3h9dwC+otN5LKdoC+AkAfBD2Q
         CxXRDSEm9uCmET+Q5GuREfC6Yej7bbkOCmXviipydBR3V5tjy5D5uuPko/4iNBlKEm4s
         Qi0APwUvxQF9lf9edC3mep8ao29b49Gx7sjE9YRlfc9NjNPlc8Pd9Egl8hs7LRaegL/z
         WAlgWvUrB7ZxgoXq+q9NyEkrli05affnDO9qUgLM19k4NZwUn26/EgY00HARIRYrL5GE
         ciMIcC1SaQoRJ5Kof4yAviWlCr0imUdVQ9HjrCSRmuQ5YPFR/TRU6fnAanBfFMg0nYKH
         I7XA==
X-Gm-Message-State: AOAM530pKIZt/1RKt1VeZOdGy0OpUoQQjXzpmKrnwpdbl6pGwCuusCWB
        +0DW3aMzdo51qfx5lZXUCLs=
X-Google-Smtp-Source: ABdhPJxmA/ljjGJKtGRHJ20kdMBzpoWVuFUelKr1w9SqGyTwgL721t8XnS/soD648KPyCk072eEnxQ==
X-Received: by 2002:a5d:48cb:: with SMTP id p11mr5875288wrs.229.1644487605013;
        Thu, 10 Feb 2022 02:06:45 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g15sm18817494wri.82.2022.02.10.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:06:44 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 1/2] arm64: dts: meson: remove CPU opps below 1GHz for G12B boards
Date:   Thu, 10 Feb 2022 10:06:37 +0000
Message-Id: <20220210100638.19130-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210100638.19130-1-christianshewitt@gmail.com>
References: <20220210100638.19130-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12B devices experience CPU stalls and random board wedges when
the system idles and CPU cores clock down to lower opp points. Recent
vendor kernels include a change to remove 100-250MHz and other distro
sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
are removed or the CPU governor forced to performance stalls are still
observed, so let's remove them to improve stability and uptime.

Fixes: b96d4e92709b ("arm64: dts: meson-g12b: support a311d and s922x cpu operating points")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-g12b-a311d.dtsi    | 40 -------------------
 .../boot/dts/amlogic/meson-g12b-s922x.dtsi    | 40 -------------------
 2 files changed, 80 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
index d61f43052a34..8e9ad1e51d66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi
@@ -11,26 +11,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <761000>;
@@ -71,26 +51,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <731000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 1e5d0ee5d541..44c23c984034 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -11,26 +11,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <731000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <731000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <731000>;
@@ -76,26 +56,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <751000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <667000000>;
-			opp-microvolt = <751000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <771000>;
-- 
2.17.1


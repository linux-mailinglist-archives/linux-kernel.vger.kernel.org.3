Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03524F0420
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356701AbiDBOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356612AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8A6182D9D;
        Sat,  2 Apr 2022 07:36:54 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot30so1483853ejb.12;
        Sat, 02 Apr 2022 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+72+q1Txcd0x+KfNjt3ACd6ZcebuPkaO0L/4gKOj9+0=;
        b=oTJu+xsN8ywcQNmH772d3KN5prhrg21w4+tEM+sA02t5NmTbGwRiJnlFt1GjR41pu7
         DnepmW2CR8HUomcZmq1yHep8leDOECqj7dP3V5ATAhJLi0hypc7MiW8pFECHxM508nyI
         OSQnRw6h+g7LoFln3CjrgkW7S5+RNEf+MnF92OcXYMtrVyyiLlBaYDlRX4ngvBq+DvXz
         Tp1qWLpdQewlKa8wV8qqrQ5Ux4q5XjcFqiQGhIYfvrSTX8jVoMsU4h+TWrBi0yCdM+cs
         Bbg5zzyGgvmYUhFBVaLAjpYklcycSO83CHte7Vit2P+y4qCYaUs46rRwhX627KIqwXZ6
         QnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+72+q1Txcd0x+KfNjt3ACd6ZcebuPkaO0L/4gKOj9+0=;
        b=c8YzQ8QNTZ+gZAetXNfS8zLHrzDPVGrSRIKk/eoojvOQr1QtGhKk4vnNPZn1ViE7y5
         ythl7lUqdG916VnDPS7lpv6s8CsVDKpKb0UM5qlhmNZbrVtLQtZV6TJSliFK4p3cqdUq
         mzVaS95CNOXTzLWNplgiztkvysyNmQqtvl9KQmAYZk4+wCa8f1Ru7MBSDAbJlwyK08Oh
         MKKv1Gdy0m4bcICOZMxBq5txuGhL+7xC0RtsnO3mDck2462ttTvyyhGVySnfUPhyC/n3
         viViWD7tNEMMb9+Py1UA0L4I0gPTYJZ+7rlaYky4i26R14Z/x41ViGRQGl0WFQitoQ/d
         ckLw==
X-Gm-Message-State: AOAM531IWjvLc20honbGTZM2mnNrmrHy/EyVjWB5vaiDNWtxHjF3r3V0
        zGor2AULiWFMY3QO0nZsY48=
X-Google-Smtp-Source: ABdhPJx/A0xgRJhlO6BICgIqz9WDJ5poFGm4p0UJMsgf1vYVei9jL21VvAup7jxV53a7ohORvW2JLw==
X-Received: by 2002:a17:906:dc90:b0:6e0:1ef7:638f with SMTP id cs16-20020a170906dc9000b006e01ef7638fmr4147584ejc.234.1648910212849;
        Sat, 02 Apr 2022 07:36:52 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/16] ARM: dts: rockchip: add clocks property to Rockchip cru nodes
Date:   Sat,  2 Apr 2022 16:36:30 +0200
Message-Id: <20220402143636.15222-11-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220402143636.15222-1-jbx6244@gmail.com>
References: <20220402143636.15222-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks and clock-names to the Rockchip cru nodes, because
the device has to have at least one input clock.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  combine patches
---
 arch/arm/boot/dts/rk3036.dtsi  | 2 ++
 arch/arm/boot/dts/rk3066a.dtsi | 3 ++-
 arch/arm/boot/dts/rk3188.dtsi  | 3 ++-
 arch/arm/boot/dts/rk322x.dtsi  | 2 ++
 arch/arm/boot/dts/rk3288.dtsi  | 2 ++
 arch/arm/boot/dts/rv1108.dtsi  | 2 ++
 6 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ba2b8891b..3894b8d2e 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -330,6 +330,8 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3036-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index c25b9695d..de9915d94 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -202,8 +202,9 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3066a-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
-
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		assigned-clocks = <&cru PLL_CPLL>, <&cru PLL_GPLL>,
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index a94321e90..cdd4a0bd5 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -195,8 +195,9 @@
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3188-cru";
 		reg = <0x20000000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
-
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 	};
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5868eb512..2547f46fe 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -484,6 +484,8 @@
 	cru: clock-controller@110e0000 {
 		compatible = "rockchip,rk3228-cru";
 		reg = <0x110e0000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26b9bbe31..487b0e03d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -862,6 +862,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3288-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 448254906..eceaa940b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -456,6 +456,8 @@
 	cru: clock-controller@20200000 {
 		compatible = "rockchip,rv1108-cru";
 		reg = <0x20200000 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1


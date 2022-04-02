Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E304F041D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356742AbiDBOjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 10:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356616AbiDBOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 10:38:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E48182DA1;
        Sat,  2 Apr 2022 07:36:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ot30so1483918ejb.12;
        Sat, 02 Apr 2022 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WTxrl9DDD0eAWWMFEHVULS2CUBJnWkuPK0erlkszq2w=;
        b=DxUpH7rm+/P+HnQ19VTOK/tUKPQchAqczLMAB75R0meXlaemhfpXusfoWalpxwCR4s
         xqJ+MAzebx1HjyaWBZcKnNADD2X0RKmVhfWc6hxsyYnOnGekp8Crm91Ef0Mj00Jhj2T9
         k+3RMJMDyCuSpF5jo/hqn7F+c1C56L7KU7k17tQi0IC9hUW0RDovZcdex8Z/+2A1hnB5
         5yDkxgiYwxBrEuvwvCKeDOjO7EHOpzzLG6CY0TNpCwGAX9SBH4j2wM8LrCq8WFKt1Eq0
         VNM0kUM9KMBN92n93fDTvWCvDJZqoW1TdNsiCPHf7x0cTXHgSTnt1V/+h7IaQVv/bKHf
         EsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WTxrl9DDD0eAWWMFEHVULS2CUBJnWkuPK0erlkszq2w=;
        b=BuqSrtgruXjxVmkh07eZlZqVrtZ36jVxug2Xq4rmOI9uAtKwZZn9K9Gfd8zyf5CsJC
         iLbCcNudt4USXQfZimhGBluJ1auy+kvDzbhoPATLY5VbjpyTvjJbRLJbwtRTe5e9YBJm
         9wXCDxfuEw2Ah8NJSTenZwI0wnilEctU2Di1jALlkBLvZXe1HRfcoOj/qgwimUQxlrpB
         cksI/f2K+V9EgL63Gs6Q3trHR3whaqXzeS/SmqicTRsV1Qd9I6tiT9DRgfMFN03Mkr2y
         L1iRUZAp0/RbEWCYqowGvLA/03s4kEDX7dBFWCqJzIZrMg/2emeqrbCMWcVAAT+ZBZIR
         hrvg==
X-Gm-Message-State: AOAM532kbuAN2HDytVrE53W4Xu1sUsj7hvqn5EvddgZJkqcXz8UyJmy/
        2IgtVkA59F0sVnahaNgyKC8=
X-Google-Smtp-Source: ABdhPJysthL0YIUDq1FZbVLlu57eYwOcK+vbupy00jeGwH2c8ufKvDM7S2KQ3X5r7vLI8+iI6M1u/g==
X-Received: by 2002:a17:907:869f:b0:6da:888b:4258 with SMTP id qa31-20020a170907869f00b006da888b4258mr4077833ejc.720.1648910213763;
        Sat, 02 Apr 2022 07:36:53 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bp8-20020a170907918800b006e0daaa63ddsm2169557ejb.60.2022.04.02.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 07:36:53 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/16] arm64: dts: rockchip: add clocks property to Rockchip cru nodes
Date:   Sat,  2 Apr 2022 16:36:31 +0200
Message-Id: <20220402143636.15222-12-jbx6244@gmail.com>
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

Add clocks and clock-names to the Rockchip cru node, because
the device has to have at least one input clock.
With the addition of new properties also sort the node properties
a little bit where needed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  combine patches
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++--
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 ++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 4 ++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 1cbe21261..2dfa67f1c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -745,10 +745,11 @@
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
+		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		rockchip,grf = <&grf>;
-
 		assigned-clocks = <&cru SCLK_RTC32K>;
 		assigned-clock-rates = <32768>;
 	};
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc..9c76c288b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -758,6 +758,8 @@
 	cru: clock-controller@ff440000 {
 		compatible = "rockchip,rk3328-cru", "rockchip,cru", "syscon";
 		reg = <0x0 0xff440000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index c99da9032..4f0b5feaa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -747,6 +747,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3368-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 88f26d89e..ce1cc42ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1416,6 +1416,8 @@
 	pmucru: pmu-clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&pmugrf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
@@ -1426,6 +1428,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3399-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1


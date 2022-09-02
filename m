Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFB05AA79E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiIBGEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiIBGEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:04:35 -0400
Received: from mail-m11873.qiye.163.com (mail-m11873.qiye.163.com [115.236.118.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944AAE87B;
        Thu,  1 Sep 2022 23:04:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11873.qiye.163.com (Hmail) with ESMTPA id 8678890021A;
        Fri,  2 Sep 2022 14:04:29 +0800 (CST)
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-gpio@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: rk356x add 'clock-names' for gpio nodes
Date:   Fri,  2 Sep 2022 14:04:26 +0800
Message-Id: <20220902060426.2980951-3-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902060426.2980951-1-jay.xu@rock-chips.com>
References: <20220902060426.2980951-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFJSktLSjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGkNNVhhOGEkYSUMfTU1PQlUTARMWGhIXJB
        QOD1lXWRgSC1lBWU5DVUlJVUxVSkpPWVdZFhoPEhUdFFlBWU9LSFVKSUtDTk1VSktLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBQ6KAw4KD05K0IcPCE*GU8V
        OjYwFBdVSlVKTU1JS0JDTUxLSktNVTMWGhIXVREaAlUDDjsJFBgQVhgTEgsIVRgUFkVZV1kSC1lB
        WU5DVUlJVUxVSkpPWVdZCAFZQUhPS0s3Bg++
X-HM-Tid: 0a82fccd00bf2eafkusn8678890021a
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'clock-names' for gpio nodes on rk356x SoCs, after this patch, the
gpio driver can get the clocks by a const char id, 'bus' for apb clock
and 'db' for the debounce clock.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 319981c3e9f7..66d038720e65 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -1650,6 +1650,7 @@ gpio0: gpio@fdd60000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfdd60000 0x0 0x100>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "bus", "db";
 			clocks = <&pmucru PCLK_GPIO0>, <&pmucru DBCLK_GPIO0>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -1661,6 +1662,7 @@ gpio1: gpio@fe740000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe740000 0x0 0x100>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "bus", "db";
 			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -1672,6 +1674,7 @@ gpio2: gpio@fe750000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe750000 0x0 0x100>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "bus", "db";
 			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -1683,6 +1686,7 @@ gpio3: gpio@fe760000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe760000 0x0 0x100>;
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "bus", "db";
 			clocks = <&cru PCLK_GPIO3>, <&cru DBCLK_GPIO3>;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -1694,6 +1698,7 @@ gpio4: gpio@fe770000 {
 			compatible = "rockchip,gpio-bank";
 			reg = <0x0 0xfe770000 0x0 0x100>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "bus", "db";
 			clocks = <&cru PCLK_GPIO4>, <&cru DBCLK_GPIO4>;
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.25.1


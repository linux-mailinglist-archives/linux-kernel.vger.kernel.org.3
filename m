Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425D54BCA6A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiBSTJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 14:09:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243058AbiBSTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 14:08:58 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF8286;
        Sat, 19 Feb 2022 11:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=m8sEB9GrTA4GPwtivV3jg4rj+1a8Ftb8pAhyUy9NMhQ=; b=ULAnvRoeJKfXcwmauHVweXPb4i
        rwS+HvLjsOjTLWbi2FDRXSQM72mjuU9k1DF/ZAbXI+v1VEeV9GqGNjVHP0mljHuljsQ6j0o60rnCB
        uT3f6snjqoHMwJ/95d+OdomYeAWjv3awAPfdfz6Ip3nWT2AdH2Jq2KKZ6rgDTWv2MQnC0IE5tEqIA
        MoQy1TaEwC4bz1Wyrj778NHW2s+Kv5I97Did5t4rwHfPWOJ+kMzO1flVUAI/x49E5PxIjC2X11pZ9
        fb+hl76lPEV9o3EE/V2mtV2qu4FfPlN29nUmWsZ8jebDc5bqc5HxfN8SS4ewVE6vYNzVJGlPrzEYL
        /29Egm/g==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nLV5u-009gvf-6q; Sat, 19 Feb 2022 19:08:34 +0000
Date:   Sat, 19 Feb 2022 19:08:34 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] ARM: dts: qcom: remove redundant binding from
 ipq8064 rb3011 dts
Message-ID: <YhFAMlSA0WYoSE6w@earth.li>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
 <20220218002956.6590-17-ansuelsmth@gmail.com>
 <Yg+pL44ogVscn9Kw@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg+pL44ogVscn9Kw@earth.li>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 02:11:59PM +0000, Jonathan McDowell wrote:
> On Fri, Feb 18, 2022 at 01:29:54AM +0100, Ansuel Smith wrote:
> > Mdio0_pins are now declared in ipq8064 dtsi. Usb phy are enabled by
> > default.
...
> > -	mdio0_pins: mdio0_pins {
> > -		mux {
> > -			pins = "gpio0", "gpio1";
> > -			function = "gpio";
> > -			drive-strength = <8>;
> > -			bias-disable;
> > -		};
> > -	};
> > -
> 
> This sets the pins to "gpio". Your earlier patch sets them to "mdio", so
> removing this will break MDIO0 on the RB3011. It's likely that your
> fixes for MDIO/QCA8K mean that the RB3011 can be switch to use the MDIO
> driver rather than mdio-gpio, but that will need tested and this change
> alone will definitely break things.

I tried the below patch to switch the RB3011 to the IPQ8064 MDIO driver
(based on qcom,ipq8064-mdio.yaml) and get:

[    1.270310] qca8k 37000000.mdio-mii:10: Switch id detected 0 but expected 13

and none of the ports on that associated switch come up. Kernel is
5.15.23 rather than latest, but there are no updates to mdio-ipq8064.c
in later kernels than I can see and none of the qca8k changes seem
relevant. Is there something else I'm missing?


diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index c3e3070702f9..0cafee65ca22 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -24,13 +24,13 @@ memory@42000000 {
 		device_type = "memory";
 	};
 
-	mdio0: mdio-0 {
+	mdio0: mdio@37000000 {
 		status = "okay";
-		compatible = "virtual,mdio-gpio";
-		gpios = <&qcom_pinmux 1 GPIO_ACTIVE_HIGH>,
-			<&qcom_pinmux 0 GPIO_ACTIVE_HIGH>;
+		compatible = "qcom,ipq8064-mdio";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		reg = <0x37000000 0x200000>;
+		clocks = <&gcc GMAC_CORE1_CLK>;
 
 		pinctrl-0 = <&mdio0_pins>;
 		pinctrl-names = "default";
@@ -318,7 +318,7 @@ mux {
 	mdio0_pins: mdio0_pins {
 		mux {
 			pins = "gpio0", "gpio1";
-			function = "gpio";
+			function = "mdio";
 			drive-strength = <8>;
 			bias-disable;
 		};

J.

-- 
/-\                             |  Shall I call the United Nations?
|@/  Debian GNU/Linux Developer |
\-                              |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB44E5658
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245451AbiCWQaG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 12:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242091AbiCWQaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:30:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F070D23BD9;
        Wed, 23 Mar 2022 09:28:31 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nX3qT-00030m-16; Wed, 23 Mar 2022 17:28:25 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        LABBE Corentin <clabbe@baylibre.com>
Cc:     herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 18/26] arm64: dts: rockchip: rk3399: add crypto node
Date:   Wed, 23 Mar 2022 17:28:24 +0100
Message-ID: <1898921.yKVeVyVuyW@diego>
In-Reply-To: <YjsfIbLQRvoxkana@Red>
References: <20220321200739.3572792-1-clabbe@baylibre.com> <70422777-a3f9-b2f1-5faa-94d24fe200ac@arm.com> <YjsfIbLQRvoxkana@Red>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 23. März 2022, 14:22:41 CET schrieb LABBE Corentin:
> Le Tue, Mar 22, 2022 at 12:00:06PM +0000, Robin Murphy a écrit :
> > On 2022-03-21 20:07, Corentin Labbe wrote:
> > > The rk3399 has a crypto IP handled by the rk3288 crypto driver so adds a
> > > node for it.
> > > 
> > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > ---
> > >   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > index 88f26d89eea1..ca2c658371a5 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> > > @@ -573,6 +573,18 @@ saradc: saradc@ff100000 {
> > >   		status = "disabled";
> > >   	};
> > >   
> > > +	crypto0: crypto@ff8b0000 {
> > > +		compatible = "rockchip,rk3399-crypto";
> > > +		reg = <0x0 0xff8b0000 0x0 0x4000>,
> > > +		      <0x0 0xff8b8000 0x0 0x4000>;
> > > +		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>,
> > > +			     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +		clocks = <&cru SCLK_CRYPTO0>, <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>,
> > > +			 <&cru SCLK_CRYPTO1>, <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>;
> > > +		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>,
> > > +			 <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
> > > +	};
> > 
> > What's going on here? If these are simply two instances of the same IP 
> > block as the evidence suggests, why are they crammed into a single DT 
> > node rather than simply being described as two separate instances? I was 
> > rather wondering what all the confusing mess in patch #16 was about, 
> > until I got here.
> > 
> > If there's something in the crypto API that means the driver can't 
> > simply naively register itself multiple times, there should be any 
> > number of ways for the probe routine to keep track of whether it's 
> > already registered something and associate any subsequent devices with 
> > the first one internally if need be. Linux implementation details should 
> > not leak out as non-standard DT weirdness.
> > 
> > I know the Rockchip IOMMU driver does this, but in that case the two 
> > IOMMU instances are closely coupled and sharing work such that they 
> > effectively need to be programmed identically at all times, so it was a 
> > bit more justifiable. I don't know the full story here, but it certainly 
> > looks like rk_get_engine_number() is just a means to schedule work on 
> > any available unit independently, so looks like it wouldn't take much to 
> > select between distinct devices at that point, and actually end up a lot 
> > simpler and cleaner overall.
> 
> Yes rk3399 has 2 instances of the same IP (Exception: crypto1 does not have RSA).
> 
> The problem is that only one drivername (like rk-md5) could exists.
> If crypto0 and crypto1 register with different drivername (rk-md5-0/rk-md5-1), only one will be used anyway.
> So I merged them into only one instance.
> I think this way will be easier, but you are right, this is not pretty.
> 
> I found another way with 2 nodes:
> You could preview it at https://github.com/montjoie/linux/tree/cryptorockchipv4
> Basicly the crypto0 is a normal instance, and crypto1 "registers" itself against crypto0.
> So if crypto0 know another instance exists it will load balance requests.

The DT-nodes in that branch are

@@ -573,6 +573,22 @@
 		status = "disabled";
 	};
 
+	crypto0: crypto@ff8b0000 {
+		compatible = "rockchip,rk3399-crypto0";
+		reg = <0x0 0xff8b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_CRYPTO0>, <&cru HCLK_M_CRYPTO0>, <&cru HCLK_S_CRYPTO0>;
+		resets = <&cru SRST_CRYPTO0>, <&cru SRST_CRYPTO0_S>, <&cru SRST_CRYPTO0_M>;
+	};
+
+	crypto1: crypto@ff8b8000 {
+		compatible = "rockchip,rk3399-crypto1";
+		reg = <0x0 0xff8b8000 0x0 0x4000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
+		clocks = <&cru SCLK_CRYPTO1>, <&cru HCLK_M_CRYPTO1>, <&cru HCLK_S_CRYPTO1>;
+		resets = <&cru SRST_CRYPTO1>, <&cru SRST_CRYPTO1_S>, <&cru SRST_CRYPTO1_M>;
+	};
+
 	i2c1: i2c@ff110000 {
 		compatible = "rockchip,rk3399-i2c";
 		reg = <0x0 0xff110000 0x0 0x1000>;

which looks at lot better :-) .

I'm not sure about the different compatibles yet, but as the blocks
are really _not_ the same implementation that actually does make sense
[i.e. one not having RSA]

Though I think you'll need to update the binding for them.


Heiko





Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23B5A990D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiIANgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiIANft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:35:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863A1274F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:34:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m1so22612716edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=S3zXZFCmEBOEV83QS3y7v/IQ5afT79Swd6uzcIjShyU=;
        b=KRibuiuDWWm64TeVDrNMDPue417ZBtVLkcaWqEjMNR5fkg+gTFJv5p52dLZFGRcTTd
         ZRMGJ+dVRq7Y8vbbJCQANaZREXMsP/kvG7rsQQg+MzHwJ2ZtOnSyYZr9VeEVyAzeF7lV
         dGMlnM9/va1WX88w3SuT/2ImxPUflvFvX3tdrUI23EmGPZdVNNFSbcOW/ubQwDetVpJx
         MaHbiK6I19hT3JDJtImbgal6HgwWe0/2qA3kGwk5KvuEQa7fhK1eCyk28k2kzBdlt77K
         0GQFxHDYgWiqOBmbRAYyQ8bLGJeAF++TqntKjWD6JaHKJxQE4trr+3FZWGKmjBLAS35E
         0BkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S3zXZFCmEBOEV83QS3y7v/IQ5afT79Swd6uzcIjShyU=;
        b=wlhZCRV+ghoyiW6gF2am/u/omfXjViX3utRfjIGJ00sGNqdsbFl7eIJHgfjMCcdiBn
         C/caH2zjLcmIKD0pcb0u70p0Yg3jQ5LOhq3eBBsulnWjCNq27fFODkI9R5K++qfg05VG
         Tt8ijTQuO6XnRyKCVbIk7e01PQN4F51tgYoasZHgzFnrmPxYaioWR+e8d5Ec3ZVEER2m
         eN5C3eXWi6PYDjKEA1KlFzIzGIkyZfzCup7Wo8+sx04DMfih59GahXFfTvY7FS7zkKxu
         UGUgtdYwSfQIy9du/rCNDvOWXY3EtuJgXyHALqlQXq+2OXEoQsCa3FhpiArfm41t2Y0J
         MdWQ==
X-Gm-Message-State: ACgBeo1Us8ytJ29qVmGaB1UYkJnVAtOuTyo1jbBNOfaizZFlYK58EkCp
        aTTu4hni8eIx+0+9xrCTxyNKHsFCyjillEWweMjZFVknwpGw/g==
X-Google-Smtp-Source: AA6agR6mVI/RFH8EcCEbhiBN1LEiKQx6i4c00oWOshR3mE302TTTo0wyJnXNc6h9XpWfMl168s7bMNqYLa+pu3XU5Ys=
X-Received: by 2002:a05:6402:31e7:b0:447:d664:83eb with SMTP id
 dy7-20020a05640231e700b00447d66483ebmr25108122edb.276.1662039256587; Thu, 01
 Sep 2022 06:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220826182803.604563-1-paul.kocialkowski@bootlin.com>
 <20220826182803.604563-7-paul.kocialkowski@bootlin.com> <YwkaFC2tm96X5qon@pendragon.ideasonboard.com>
 <YxCqZ8GhiTJlZ8MC@aptenodytes> <YxCs4fhx+Qx7uCAF@pendragon.ideasonboard.com> <YxCyGgfNVHGIJlMz@aptenodytes>
In-Reply-To: <YxCyGgfNVHGIJlMz@aptenodytes>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Thu, 1 Sep 2022 14:34:00 +0100
Message-ID: <CAPY8ntD4EScbUC1kQCOqdPO_jF8gHKH6cjXpBkRW=AYsZSf=yQ@mail.gmail.com>
Subject: Re: [PATCH NOT FOR MERGE v5 6/6] ARM: dts: sun8i: a83t: bananapi-m3:
 Enable MIPI CSI-2 with OV8865
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?S8OpdmluIEwnaMO0cGl0YWw=?= <kevin.lhopital@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent and Paul

On Thu, 1 Sept 2022 at 14:23, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi Laurent,
>
> On Thu 01 Sep 22, 16:00, Laurent Pinchart wrote:
> > On Thu, Sep 01, 2022 at 02:49:43PM +0200, Paul Kocialkowski wrote:
> > > On Fri 26 Aug 22, 22:08, Laurent Pinchart wrote:
> > > > On Fri, Aug 26, 2022 at 08:28:03PM +0200, Paul Kocialkowski wrote:
> > > > > From: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.com>
> > > > >
> > > > > The Bananapi M3 supports a camera module which includes an OV8865=
 sensor
> > > > > connected via the parallel CSI interface and an OV8865 sensor con=
nected
> > > > > via MIPI CSI-2.
> > > > >
> > > > > The I2C2 bus is shared by the two sensors as well as the (active-=
low)
> > > > > reset signal, but each sensor has it own shutdown line.
> > > >
> > > > I see a single sensor in this file, am I missing something ?
> > >
> > > Indeed this patch only adds the OV8865, not the OV5640 which is also =
present
> > > on the same camera board extension.
> > >
> > > A patch was submitted some time ago adding support for (only) the OV5=
640:
> > > https://lore.kernel.org/lkml/20190408165744.11672-7-wens@kernel.org/
> >
> > OK. That's fine, let's just reword the commit message.
>
> Sure.
>
> > > > Sounds like a perfect candidate for an overlay, it could then be me=
rged
> > > > upstream.
> > >
> > > Do we have an upstream place to merge device-tree overlays now?
> >
> > They're accepted in the upstream kernel as far as I know, a git grep fo=
r
> > /plugin/ in .dts files produces 18 matches.
>
> Oh okay, definitely good to know thanks!
>
> > > I'll check if it's possible to describe both sensors together and act=
ually
> > > be able to select one or the other properly from userspace. Last time=
 I tried
> > > this wasn't possible: there's at least the shared reset GPIO used by =
both
> > > sensors, which cannot be requested by the two drivers in parallel.
> > >
> > > To be honest this is very poor hardware design and it was almost cert=
ainly
> > > designed with the idea that only one sensor will be configured per bo=
ot.
> > > See https://wiki.banana-pi.org/Camera and
> > > https://drive.google.com/file/d/0B4PAo2nW2KfnOEFTMjZ2aEVGUVU/view?usp=
=3Dsharing
> > > for the schematics pdf
> >
> > It's not great indeed, but not that uncommon either (unfortunately). I
> > wonder if we need some kind of reset GPIO API, but that would be a hack
> > at most I think.
>
> Yeah I don't see any obvious clean solution here.
> But that could still be two separate dt overlays for now.

Just to throw the idea out there, (ab)use the regulator API so that
they share a regulator-gpio device that claims that GPIO.
When either sensor requests the regulator, the reset line will get
pulled to the appropriate state.

  Dave

> > > > > Signed-off-by: K=C3=A9vin L'h=C3=B4pital <kevin.lhopital@bootlin.=
com>
> > > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 102 +++++++++++++=
++++++
> > > > >  1 file changed, 102 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/=
arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > index 5a7e1bd5f825..80fd99cf24b2 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > > > > @@ -85,6 +85,30 @@ led-1 {
> > > > >                 };
> > > > >         };
> > > > >
> > > > > +       reg_ov8865_avdd: ov8865-avdd {
> > > > > +               compatible =3D "regulator-fixed";
> > > > > +               regulator-name =3D "ov8865-avdd";
> > > > > +               regulator-min-microvolt =3D <2800000>;
> > > > > +               regulator-max-microvolt =3D <2800000>;
> > > > > +               vin-supply =3D <&reg_dldo4>;
> > > > > +       };
> > > > > +
> > > > > +       reg_ov8865_dovdd: ov8865-dovdd {
> > > > > +               compatible =3D "regulator-fixed";
> > > > > +               regulator-name =3D "ov8865-dovdd";
> > > > > +               regulator-min-microvolt =3D <2800000>;
> > > > > +               regulator-max-microvolt =3D <2800000>;
> > > > > +               vin-supply =3D <&reg_dldo4>;
> > > > > +       };
> > > > > +
> > > > > +       reg_ov8865_dvdd: ov8865-dvdd {
> > > > > +               compatible =3D "regulator-fixed";
> > > > > +               regulator-name =3D "ov8865-dvdd";
> > > > > +               regulator-min-microvolt =3D <1200000>;
> > > > > +               regulator-max-microvolt =3D <1200000>;
> > > > > +               vin-supply =3D <&reg_eldo1>;
> > > > > +       };
> > > >
> > > > Are those three regulators on the Banana Pi, or on the camera modul=
e ?
> > >
> > > That's on the camera module.
> > >
> > > > > +
> > > > >         reg_usb1_vbus: reg-usb1-vbus {
> > > > >                 compatible =3D "regulator-fixed";
> > > > >                 regulator-name =3D "usb1-vbus";
> > > > > @@ -115,6 +139,23 @@ &cpu100 {
> > > > >         cpu-supply =3D <&reg_dcdc3>;
> > > > >  };
> > > > >
> > > > > +&csi {
> > > > > +       status =3D "okay";
> > > > > +
> > > > > +       ports {
> > > > > +               #address-cells =3D <1>;
> > > > > +               #size-cells =3D <0>;
> > > > > +
> > > > > +               port@1 {
> > > > > +                       reg =3D <1>;
> > > >
> > > > All of this (except the status =3D "okay") should go to sun8i-a83t.=
dtsi.
> > > >
> > > > > +
> > > > > +                       csi_in_mipi_csi2: endpoint {
> > > > > +                               remote-endpoint =3D <&mipi_csi2_o=
ut_csi>;
> > > > > +                       };
> > > >
> > > > This too actually, once the issue mentioned in patch 5/6 gets fixed=
.
> > > >
> > > > > +               };
> > > > > +       };
> > > > > +};
> > > > > +
> > > > >  &de {
> > > > >         status =3D "okay";
> > > > >  };
> > > > > @@ -147,6 +188,36 @@ hdmi_out_con: endpoint {
> > > > >         };
> > > > >  };
> > > > >
> > > > > +&i2c2 {
> > > > > +       pinctrl-names =3D "default";
> > > > > +       pinctrl-0 =3D <&i2c2_pe_pins>;
> > > >
> > > > This looks like a candidate for upstreaming in
> > > > sun8i-a83t-bananapi-m3.dts, it shouldn't be in the overlay.
> > >
> > > I2C2 is actually also exported in the PH pins, which is available on =
the board
> > > header, so it's not obvious that using the PE pins should be the defa=
ult.
> > >
> > > The context is that Allwinner SoCs usually have a dedicated I2C contr=
oller for
> > > cameras, but also route a "generic" I2C controller on the same pins.
> >
> > Out of curiosity, what features do those dedicated camera I2C
> > controllers provide, compared to "normal" I2C controllers ?
>
> IIRC there's some feature to send i2c messages synced with the camera int=
erface
> vsync signal, to have some kind of hardware atomic mechanism for reconfig=
uring
> a sensor.
>
> Not sure that's very relevant for us and an implementation for it would p=
robably
> just support regular I2C. We can probably achieve simialr results with th=
e
> request API.
>
> > > Here that's on the PE14/15 pins. Since we don't have mainline support=
 for this
> > > camera-dedicated I2C controller, we end up routing the generic one to=
 the PE
> > > pins, which are routed to the camera connector.
> >
> > OK.
> >
> > > In the future we could add support for this camera-dedicated controll=
er, which
> > > would then allow routing i2c2 to the PH pins independently. This is w=
hat the
> > > downstream Allwinner BSP kernel does.
> > >
> > > > > +       status =3D "okay";
> > > > > +
> > > > > +       ov8865: camera@36 {
> > > > > +               compatible =3D "ovti,ov8865";
> > > > > +               reg =3D <0x36>;
> > > > > +               pinctrl-names =3D "default";
> > > > > +               pinctrl-0 =3D <&csi_mclk_pin>;
> > > > > +               clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > > +               assigned-clocks =3D <&ccu CLK_CSI_MCLK>;
> > > > > +               assigned-clock-rates =3D <24000000>;
> > > > > +               avdd-supply =3D <&reg_ov8865_avdd>;
> > > > > +               dovdd-supply =3D <&reg_ov8865_dovdd>;
> > > > > +               dvdd-supply =3D <&reg_ov8865_dvdd>;
> > > > > +               powerdown-gpios =3D <&pio 4 17 GPIO_ACTIVE_LOW>; =
/* PE17 */
> > > > > +               reset-gpios =3D <&pio 4 16 GPIO_ACTIVE_LOW>; /* P=
E16 */
> > > > > +
> > > > > +               port {
> > > > > +                       ov8865_out_mipi_csi2: endpoint {
> > > > > +                               data-lanes =3D <1 2 3 4>;
> > > > > +                               link-frequencies =3D /bits/ 64 <3=
60000000>;
> > > > > +
> > > > > +                               remote-endpoint =3D <&mipi_csi2_i=
n_ov8865>;
> > > > > +                       };
> > > > > +               };
> > > > > +       };
> > > > > +};
> > > > > +
> > > > >  &mdio {
> > > > >         rgmii_phy: ethernet-phy@1 {
> > > > >                 compatible =3D "ethernet-phy-ieee802.3-c22";
> > > > > @@ -154,6 +225,24 @@ rgmii_phy: ethernet-phy@1 {
> > > > >         };
> > > > >  };
> > > > >
> > > > > +&mipi_csi2 {
> > > > > +       status =3D "okay";
> > > > > +};
> > > > > +
> > > > > +&mipi_csi2_in {
> > > > > +       mipi_csi2_in_ov8865: endpoint {
> > > > > +               data-lanes =3D <1 2 3 4>;
> > > > > +
> > > > > +               remote-endpoint =3D <&ov8865_out_mipi_csi2>;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > > +&mipi_csi2_out {
> > > > > +       mipi_csi2_out_csi: endpoint {
> > > > > +               remote-endpoint =3D <&csi_in_mipi_csi2>;
> > > > > +       };
> > > > > +};
> > > > > +
> > > > >  &mmc0 {
> > > > >         pinctrl-names =3D "default";
> > > > >         pinctrl-0 =3D <&mmc0_pins>;
> > > > > @@ -327,11 +416,24 @@ &reg_dldo3 {
> > > > >         regulator-name =3D "vcc-pd";
> > > > >  };
> > > > >
> > > > > +&reg_dldo4 {
> > > > > +       regulator-always-on;
> > > >
> > > > Does it have to be always on ?
> > >
> > > Mhh so I realize the regulators handling here is quite messy.
> > > I guess I didn't do such a good review of this patch internally.
> > >
> > > The situation is that the regulators on the camera board all have the=
ir
> > > enable pin tied to the DLDO4 output, but that would be best described=
 as
> > > a vin-supply of the ov8865 regulators above. Their real vin supply is=
 an
> > > always-on board-wide power source but I don't think we can represent =
another
> > > regulator acting as enable signal in a better way.
> >
> > That's right. I've modeled that as a parent regulator in the past, even
> > if it doesn't reflect the exact hardware topology, it's functionally
> > equivalent.
>
> Sounds good, I'll change it that way.
>
> Cheers,
>
> Paul
>
> > > Now beware that the camera board schematics are confusing as they sho=
w resistors
> > > (R17, R18, R19, R20, R23) connecting some power lines together, but t=
hey are not
> > > populated on the board (I guess the point is to make a variant of the=
 design
> > > without regulators on the camera board and to use ones from the PMU i=
nstead).
> > > This probably confused Kevin and I back when this patch was made.
> > >
> > > > > +       regulator-min-microvolt =3D <2800000>;
> > > > > +       regulator-max-microvolt =3D <2800000>;
> > > > > +       regulator-name =3D "avdd-csi";
> > > >
> > > > Doesn't this belong to the base board .dts ? Same below.
> > > >
> > > > > +};
> > > > > +
> > > > >  &reg_drivevbus {
> > > > >         regulator-name =3D "usb0-vbus";AVDD-CSI
> > > > >         status =3D "okay";
> > > > >  };
> > > > >
> > > > > +&reg_eldo1 {
> > > > > +       regulator-min-microvolt =3D <1200000>;
> > > > > +       regulator-max-microvolt =3D <1200000>;
> > > > > +       regulator-name =3D "dvdd-csi-r";
> > > > > +};
> > > > > +
> > > > >  &reg_fldo1 {
> > > > >         regulator-min-microvolt =3D <1080000>;
> > > > >         regulator-max-microvolt =3D <1320000>;
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
>
> --
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com

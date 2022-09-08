Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426C15B23FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiIHQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiIHQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:53:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D36EA42F;
        Thu,  8 Sep 2022 09:51:43 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2269020wms.5;
        Thu, 08 Sep 2022 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=e5KYqEBWQ8THQ17spmw0xDJTw5S+n1XJ78rOUrMQLWE=;
        b=mrMqJeHL2N1h5YAyTrrec9CeEwKwlyw0SO1YzY2f9pfRJGSVdOlHcFrmGSKiXw1Apo
         ScBrula6ozGf+tln/IXFTkzWqIP/D5NYEEBu7NoJUhGqkzh9AoM28r6qzDtTZnh0n+3O
         GZL9ws3a8VAdYQSSBtB2J6kXuKlcmNF+TpVV2dV+XviwVdibSwcjpfjg9Gl9Y9DvmMrQ
         3vKTmRGcutvFGjffbl1PsGbkYZnm8Kp2ARj2Lt2IQCHG31+8QjhbI/CKAH4dd5s1Qrrq
         +f9+ZubY6dtkvfoydCQWiLB3p5YYO1z5Ko+pcWcIhAej+JfYw/33EgEj+9qNBA8a/AOM
         +upQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e5KYqEBWQ8THQ17spmw0xDJTw5S+n1XJ78rOUrMQLWE=;
        b=B/NJFqiWOTODQcXpgv54x3H+hjQRWm6FJ/Uv4WUkr7tAIVEwMsLRV1+m7p0+S1DTGR
         /JkZe4x30uzfKTrHV4pHA6tPuhkjanqdaoCIhTB0XcFIg+vzwtXHDjtKG7kkD97mJHRw
         qqlO1BkkA+sSGYueClERTDbn7EIheDHMv3W3ezAGMa5+f7Tn8iGEdvlUy0n7T7V263wX
         Vh2TBN1HhZhkMJjEmbFkT7MKm3JbDYr5U4LH/Sf8mLEAl1XWZOUdGHeovM6JFgbvIg0j
         87ZYwmEpOp8trFrRijbRf70XOsCapziJILmnCsju96sMKrW7qmG/ZvcttkbUn9IJ/svm
         +PJA==
X-Gm-Message-State: ACgBeo1Sf8QecgYqwAYPqe1SDLdy03G0n35tsT0rYfWK4fXsvxJD5uTw
        ItIWSu3sLZjnFbQd07hIOc4=
X-Google-Smtp-Source: AA6agR7PpD+198B5Y3yHlP3CrDqe+4xxzwp+pmGtD3TVKQAJdPtBsk5cDvgpY5VnGVgDIaunPcagbQ==
X-Received: by 2002:a05:600c:3309:b0:3b2:973d:b533 with SMTP id q9-20020a05600c330900b003b2973db533mr2951570wmp.105.1662655900588;
        Thu, 08 Sep 2022 09:51:40 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b003a342933727sm3814303wmq.3.2022.09.08.09.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:51:39 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Re: Re: [PATCH v4 3/5] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Thu, 08 Sep 2022 18:51:38 +0200
Message-ID: <2313716.NG923GbCHz@kista>
In-Reply-To: <1800669.atdPhlSkOF@kista>
References: <20220906153034.153321-1-peron.clem@gmail.com> <CAJiuCceZg_6p4yo89e0X3fD9aXFs9Xik8b8KUM+Psdy_4paKPw@mail.gmail.com> <1800669.atdPhlSkOF@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 08. september 2022 ob 18:26:31 CEST je Jernej =C5=A0krabe=
c napisal(a):
> Dne torek, 06. september 2022 ob 21:26:34 CEST je Cl=C3=A9ment P=C3=A9ron=
 napisal(a):
> > Hi Jernej,
> >=20
> > On Tue, 6 Sept 2022 at 21:10, Jernej =C5=A0krabec <jernej.skrabec@gmail=
=2Ecom>
>=20
> wrote:
> > > Dne torek, 06. september 2022 ob 17:30:32 CEST je Cl=C3=A9ment P=C3=
=A9ron
>=20
> napisal(a):
> > > > Add an Operating Performance Points table for the GPU to
> > > > enable Dynamic Voltage & Frequency Scaling on the H6.
> > > >=20
> > > > The voltage range is set with minimal voltage set to the target
> > > > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > > > work properly on board with fixed regulator.
> > > >=20
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >=20
> > > >  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87
> > > >  +++++++++++++++++++
> > > >  1 file changed, 87 insertions(+)
> > > >  create mode 100644
> > > >  arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > > > b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi new file mode
> > > > 100644
> > > > index 000000000000..b48049c4fc85
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > > > @@ -0,0 +1,87 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +// Copyright (C) 2022 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.co=
m>
> > > > +
> > > > +/ {
> > > > +     gpu_opp_table: opp-table-gpu {
> > > > +             compatible =3D "operating-points-v2";
> > > > +
> > > > +             opp-216000000 {
> > > > +                     opp-hz =3D /bits/ 64 <216000000>;
> > > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-264000000 {
> > > > +                     opp-hz =3D /bits/ 64 <264000000>;
> > > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > > +             };
> > >=20
> > > As mentioned in clock patch review, rates below 288 MHz are deemed
> > > unstable on GPU PLL by vendor GPU kernel driver. At least in the BSP
> > > version that I have. Did you test these points? If not, better to drop
> > > them.
> >=20
> > I changed the governor to userspace and set the freq to 216MHz / 264MHz
> > Run glmark2 and didn't observe any glitch nor issue.
> >=20
> > I'm not sure if it's enough to say it's stable but I didn't observe
> > any strange behavior.
>=20
> Ok then.
>=20
> Forgot to ask, where did you get 1.2 V as an upper limit? H6 datasheet li=
sts
> max. GPU voltage as 1.08 V.

To answer my own question, absolute max. voltage is 1.3 V, so 1.2 V is stil=
l=20
somewhat acceptable and in practice, fixed regulator on Tanix TX6 board is=
=20
around 1.12 V. Boards with PMIC can set lower voltage anyway.

All good.
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
=20
Best regards,
Jernej
=20
> > Regards,
> > Clement
> >=20
> > > Best regards,
> > > Jernej
> > >=20
> > > > +
> > > > +             opp-312000000 {
> > > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-336000000 {
> > > > +                     opp-hz =3D /bits/ 64 <336000000>;
> > > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-360000000 {
> > > > +                     opp-hz =3D /bits/ 64 <360000000>;
> > > > +                     opp-microvolt =3D <820000 820000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-384000000 {
> > > > +                     opp-hz =3D /bits/ 64 <384000000>;
> > > > +                     opp-microvolt =3D <830000 830000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-408000000 {
> > > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > > +                     opp-microvolt =3D <840000 840000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-420000000 {
> > > > +                     opp-hz =3D /bits/ 64 <420000000>;
> > > > +                     opp-microvolt =3D <850000 850000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-432000000 {
> > > > +                     opp-hz =3D /bits/ 64 <432000000>;
> > > > +                     opp-microvolt =3D <860000 860000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-456000000 {
> > > > +                     opp-hz =3D /bits/ 64 <456000000>;
> > > > +                     opp-microvolt =3D <870000 870000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-504000000 {
> > > > +                     opp-hz =3D /bits/ 64 <504000000>;
> > > > +                     opp-microvolt =3D <890000 890000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-540000000 {
> > > > +                     opp-hz =3D /bits/ 64 <540000000>;
> > > > +                     opp-microvolt =3D <910000 910000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-576000000 {
> > > > +                     opp-hz =3D /bits/ 64 <576000000>;
> > > > +                     opp-microvolt =3D <930000 930000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-624000000 {
> > > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > > +                     opp-microvolt =3D <950000 950000 1200000>;
> > > > +             };
> > > > +
> > > > +             opp-756000000 {
> > > > +                     opp-hz =3D /bits/ 64 <756000000>;
> > > > +                     opp-microvolt =3D <1040000 1040000 1200000>;
> > > > +             };
> > > > +     };
> > > > +};
> > > > +
> > > > +&gpu {
> > > > +     operating-points-v2 =3D <&gpu_opp_table>;
> > > > +};
> > > > --
> > > > 2.34.1



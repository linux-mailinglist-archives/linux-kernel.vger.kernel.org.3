Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438105B2393
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIHQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiIHQ0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:26:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC7F3BC1;
        Thu,  8 Sep 2022 09:26:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2202866wms.5;
        Thu, 08 Sep 2022 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8G+gH/ZdR26aobBAiGz/oS5rrDj2ImSoc83kpV+wRO0=;
        b=Lv282Mf3K67NvyFxRebxNkdvzGhqee8D1XGpHHcftviyakUdO3xMzoYCg+7ZenogQZ
         CKFxMJlR8ohcfzJVgJ57xMj+pbdL51FR0qbpIGo3Gn7u/LGkCdtiR3Z3qO4qVPAn9E/o
         noppHKRaRu9xab32KqAAnEjlRkS7oZuRh5NQ9fvmOpGIv+HKAwY6qibOxLkU/jA3+PD8
         1bP5t0dP6u+9zEyBjlP0V8W0yl3RqFf9NckOSqRXIlOPIgU24m6Yl1X9Xx/PMk5z2DXG
         4TxqycZgZG+FXA1teIK6bNRkUpVxIl3aH/qXlJDeBwQFV2uO5kizVoGD+EIcpARKVPsh
         teuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8G+gH/ZdR26aobBAiGz/oS5rrDj2ImSoc83kpV+wRO0=;
        b=qzQlvZEPCj4Nn/nnZWiwks7XCnuU0RlaLo7y98QIDSsFjhpjwIDUOKMTJGab+NZIJg
         +FmPM+y+hYlBeeisbNVerKuHih7QtHWE1VJnzZv5+CctqLoHn8OeC9KE9G8Rrl0VsWVg
         /IwD07CshiZ8gsY1Y5y/EN/gEOJYKXZmjCj/lfUBhkFKy0hdugcBWZMgCOev7tCcOVlR
         dBP2tuGJMdTp39VOaG01z0TsLvNFY+uqqdFXj/3UhIPVMw8e1BlUogx3j8z9fdMIMmCH
         yAdU8u14nRZd6JixHDxD7ThYn4xxSnlOXlqoF8NAHZgSG60+vLrHpFVfNIzhHkyRESuL
         1ocQ==
X-Gm-Message-State: ACgBeo0rXKutsKtNkhEWk8mU5iAvz7P+TneUheFqQM89elboic90wngi
        L4+XhVQFL5jyNwAe1HzeJtg=
X-Google-Smtp-Source: AA6agR5g4fKQwejx0X+xvVpuFLeBu2IKV+p52yPrFDR1V4MFUXBQpznlKeIiBMa6kmzuxVxNcu+yvA==
X-Received: by 2002:a05:600c:1c8f:b0:3b2:541c:dd34 with SMTP id k15-20020a05600c1c8f00b003b2541cdd34mr2737551wms.155.1662654393411;
        Thu, 08 Sep 2022 09:26:33 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003a5bd5ea215sm2973670wmb.37.2022.09.08.09.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 09:26:32 -0700 (PDT)
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
Subject: Re: Re: [PATCH v4 3/5] arm64: dts: allwinner: h6: Add GPU OPP table
Date:   Thu, 08 Sep 2022 18:26:31 +0200
Message-ID: <1800669.atdPhlSkOF@kista>
In-Reply-To: <CAJiuCceZg_6p4yo89e0X3fD9aXFs9Xik8b8KUM+Psdy_4paKPw@mail.gmail.com>
References: <20220906153034.153321-1-peron.clem@gmail.com> <12048299.O9o76ZdvQC@kista> <CAJiuCceZg_6p4yo89e0X3fD9aXFs9Xik8b8KUM+Psdy_4paKPw@mail.gmail.com>
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

Dne torek, 06. september 2022 ob 21:26:34 CEST je Cl=C3=A9ment P=C3=A9ron n=
apisal(a):
> Hi Jernej,
>=20
> On Tue, 6 Sept 2022 at 21:10, Jernej =C5=A0krabec <jernej.skrabec@gmail.c=
om>=20
wrote:
> > Dne torek, 06. september 2022 ob 17:30:32 CEST je Cl=C3=A9ment P=C3=A9r=
on=20
napisal(a):
> > > Add an Operating Performance Points table for the GPU to
> > > enable Dynamic Voltage & Frequency Scaling on the H6.
> > >=20
> > > The voltage range is set with minimal voltage set to the target
> > > and the maximal voltage set to 1.2V. This allow DVFS framework to
> > > work properly on board with fixed regulator.
> > >=20
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >=20
> > >  .../boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi | 87 +++++++++++++++++=
++
> > >  1 file changed, 87 insertions(+)
> > >  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.d=
tsi
> > >=20
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > > b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi new file mode
> > > 100644
> > > index 000000000000..b48049c4fc85
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-gpu-opp.dtsi
> > > @@ -0,0 +1,87 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > +// Copyright (C) 2022 Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > +
> > > +/ {
> > > +     gpu_opp_table: opp-table-gpu {
> > > +             compatible =3D "operating-points-v2";
> > > +
> > > +             opp-216000000 {
> > > +                     opp-hz =3D /bits/ 64 <216000000>;
> > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > +             };
> > > +
> > > +             opp-264000000 {
> > > +                     opp-hz =3D /bits/ 64 <264000000>;
> > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > +             };
> >=20
> > As mentioned in clock patch review, rates below 288 MHz are deemed
> > unstable on GPU PLL by vendor GPU kernel driver. At least in the BSP
> > version that I have. Did you test these points? If not, better to drop
> > them.
>=20
> I changed the governor to userspace and set the freq to 216MHz / 264MHz
> Run glmark2 and didn't observe any glitch nor issue.
>=20
> I'm not sure if it's enough to say it's stable but I didn't observe
> any strange behavior.

Ok then.

=46orgot to ask, where did you get 1.2 V as an upper limit? H6 datasheet li=
sts=20
max. GPU voltage as 1.08 V.

Best regards,
Jernej

>=20
> Regards,
> Clement
>=20
> > Best regards,
> > Jernej
> >=20
> > > +
> > > +             opp-312000000 {
> > > +                     opp-hz =3D /bits/ 64 <312000000>;
> > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > +             };
> > > +
> > > +             opp-336000000 {
> > > +                     opp-hz =3D /bits/ 64 <336000000>;
> > > +                     opp-microvolt =3D <810000 810000 1200000>;
> > > +             };
> > > +
> > > +             opp-360000000 {
> > > +                     opp-hz =3D /bits/ 64 <360000000>;
> > > +                     opp-microvolt =3D <820000 820000 1200000>;
> > > +             };
> > > +
> > > +             opp-384000000 {
> > > +                     opp-hz =3D /bits/ 64 <384000000>;
> > > +                     opp-microvolt =3D <830000 830000 1200000>;
> > > +             };
> > > +
> > > +             opp-408000000 {
> > > +                     opp-hz =3D /bits/ 64 <408000000>;
> > > +                     opp-microvolt =3D <840000 840000 1200000>;
> > > +             };
> > > +
> > > +             opp-420000000 {
> > > +                     opp-hz =3D /bits/ 64 <420000000>;
> > > +                     opp-microvolt =3D <850000 850000 1200000>;
> > > +             };
> > > +
> > > +             opp-432000000 {
> > > +                     opp-hz =3D /bits/ 64 <432000000>;
> > > +                     opp-microvolt =3D <860000 860000 1200000>;
> > > +             };
> > > +
> > > +             opp-456000000 {
> > > +                     opp-hz =3D /bits/ 64 <456000000>;
> > > +                     opp-microvolt =3D <870000 870000 1200000>;
> > > +             };
> > > +
> > > +             opp-504000000 {
> > > +                     opp-hz =3D /bits/ 64 <504000000>;
> > > +                     opp-microvolt =3D <890000 890000 1200000>;
> > > +             };
> > > +
> > > +             opp-540000000 {
> > > +                     opp-hz =3D /bits/ 64 <540000000>;
> > > +                     opp-microvolt =3D <910000 910000 1200000>;
> > > +             };
> > > +
> > > +             opp-576000000 {
> > > +                     opp-hz =3D /bits/ 64 <576000000>;
> > > +                     opp-microvolt =3D <930000 930000 1200000>;
> > > +             };
> > > +
> > > +             opp-624000000 {
> > > +                     opp-hz =3D /bits/ 64 <624000000>;
> > > +                     opp-microvolt =3D <950000 950000 1200000>;
> > > +             };
> > > +
> > > +             opp-756000000 {
> > > +                     opp-hz =3D /bits/ 64 <756000000>;
> > > +                     opp-microvolt =3D <1040000 1040000 1200000>;
> > > +             };
> > > +     };
> > > +};
> > > +
> > > +&gpu {
> > > +     operating-points-v2 =3D <&gpu_opp_table>;
> > > +};
> > > --
> > > 2.34.1



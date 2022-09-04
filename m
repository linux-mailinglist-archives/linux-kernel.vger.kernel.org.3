Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A310C5AC4CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiIDO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIDO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:29:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18BFB9;
        Sun,  4 Sep 2022 07:29:20 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb36so12458632ejc.10;
        Sun, 04 Sep 2022 07:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ZfqVcyFbKI9Os+wuA/QVa335RYVnkmodjGXffhuOttY=;
        b=FPG1SsLMC0jyE8WitBgdhh2yGeR8ZASK5uoZmOd+HPKWSifYv7jzdzzKFDhxppCgw7
         Vag1F37uPBf98sMc/qBwPXFlOhEs0mFu148esRqj9eB5tDgSASRvhioAn5FphYaioelD
         9mkCUCqJnOihqrgwVVZWNncOmPoXhARGl5+NSVEnM++2QxhZp5PaP21zzYywUGlmtwHh
         WnvyjnFGali4LAnsD5e7t3rhqF8o+UYHZ+DC47UhpRjlz0AtNuo40ebIAO4+9q6RavSG
         pyj6yacVuKxMR2jWMX1yBUmRZ0Dld/+XJUI/9BgsEFV9t5SHwRWseGXfM/yTVojsvoja
         qjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ZfqVcyFbKI9Os+wuA/QVa335RYVnkmodjGXffhuOttY=;
        b=7/tlAApMJ6bUsjv4pE5Jk4O8+IPs1umac3aNhZIZktymZShre6dpGPdlRc74SYOUZH
         yZ1/kH3Rl46vZzuWH7OFp8a20ofUEv1Vv6UTZhSzvRknYf3/E4U9z1lXRz5ryDJr8YM1
         6BcA7cWYMKE6Svm5UhE2Yk93+JTi0LGfpqemhcEZV0VbXPmX0JODLOIxKD/353s3wh6j
         6ld1t2VcdbORJ0IQUslTj+zZIrhGuHYbTAkAO3l6K/0MXVRVLg3ccE/cd+AHYWIGkJEH
         isVMiV04KBtkw1pi/JCW6zPePG8lIIbeNov9b3s0Q76SbZI/3v3bpCpzNS85hLYVSIkw
         uNhw==
X-Gm-Message-State: ACgBeo2IfFh8Is35AK7gLD0i6rNQdVeaK27I/0DomitDDnM8l0xdwqgx
        PjzEAWbf+5rNITWB24y8NckaojQ1AShtdMKkf14=
X-Google-Smtp-Source: AA6agR7XVnrPDDvO1MS/Q/m5mVMZemBGRMS+fLOrHm6jmsdUlwWEmB2mtOoI49y0CHLtPXjjASKR7loH5XA3XyRJ314=
X-Received: by 2002:a17:907:8a09:b0:731:610:ff8d with SMTP id
 sc9-20020a1709078a0900b007310610ff8dmr32726251ejc.399.1662301759048; Sun, 04
 Sep 2022 07:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220821173051.155038-1-peron.clem@gmail.com> <20220821173051.155038-5-peron.clem@gmail.com>
 <0c028109-bb50-fbaa-de18-9876706a7477@sholland.org> <CAJiuCcf7NuXFFLw6-RFcyZPNFPagfSB5aR7rY5528USzNB-iKg@mail.gmail.com>
 <CAJiuCcf0io5T=+Ap8io2uKn+CNqrCi2pbaCtyq2PVW=bEqKakg@mail.gmail.com>
 <26ebdc2d-caca-2d53-45bc-8c8b90c7c1fd@sholland.org> <CAJiuCcdGS-H+tq0o47Zm=UJNEL+Ff0_mkUU1N86ttE=iOTbknw@mail.gmail.com>
In-Reply-To: <CAJiuCcdGS-H+tq0o47Zm=UJNEL+Ff0_mkUU1N86ttE=iOTbknw@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 4 Sep 2022 16:29:07 +0200
Message-ID: <CAJiuCcfRrRwzaeikknR7OzWA=TmugvhHXtwGCdxU64hvmaDdNQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: allwinner: beelink-gs1: Enable GPU OPP
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Sun, 4 Sept 2022 at 16:23, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi Samuel,
>
> On Sun, 4 Sept 2022 at 05:32, Samuel Holland <samuel@sholland.org> wrote:
> >
> > On 9/3/22 2:06 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > > Hi Samuel,
> > >
> > > On Sat, 3 Sept 2022 at 20:41, Cl=C3=A9ment P=C3=A9ron <peron.clem@gma=
il.com> wrote:
> > >>
> > >> Hi Samuel,
> > >>
> > >> On Tue, 23 Aug 2022 at 05:07, Samuel Holland <samuel@sholland.org> w=
rote:
> > >>>
> > >>> On 8/21/22 12:30 PM, Cl=C3=A9ment P=C3=A9ron wrote:
> > >>>> Enable GPU OPP table for Beelink GS1
> > >>>>
> > >>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > >>>> ---
> > >>>>  arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 ++
> > >>>>  1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.d=
ts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > >>>> index 6249e9e02928..20fc0584d1c6 100644
> > >>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > >>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> > >>>> @@ -5,6 +5,7 @@
> > >>>>
> > >>>>  #include "sun50i-h6.dtsi"
> > >>>>  #include "sun50i-h6-cpu-opp.dtsi"
> > >>>> +#include "sun50i-h6-gpu-opp.dtsi"
> > >>>>
> > >>>>  #include <dt-bindings/gpio/gpio.h>
> > >>>>
> > >>>> @@ -261,6 +262,7 @@ reg_dcdca: dcdca {
> > >>>>                       };
> > >>>>
> > >>>>                       reg_dcdcc: dcdcc {
> > >>>> +                             regulator-always-on;
> > >>>
> > >>> Why is this necessary? This file already has:
> > >>
> > >> This is a relica from the first serie at this time the OPP doesn't
> > >> properly enable the regulator it's now fixed since:
> > >> https://patchwork.kernel.org/project/linux-pm/patch/81eb2efeeed1556d=
124065252f32777838a6d850.1589528491.git.viresh.kumar@linaro.org/
> >
> > This should have nothing to do with the OPP driver; lima already has a =
"mali"
> > regulator consumer that should be enabled whenever the GPU is in use.
>
> Okay so you propose to add a regulator_enable() in the panfrost
> drivers in addition to the OPP consumer right?

After a quick look it seems that it's explicit that we don't want two
consumer for the same regulator and OPP should handle the enabling of
the regulator.

/* OPP will handle regulators */
if (!pfdev->pfdevfreq.opp_of_table_added) {
err =3D panfrost_regulator_init(pfdev);
if (err)
goto out_devfreq;
}


>
> I will send a patch to add this and see what's panfrost maintainer
> think about it.
>
> Regards,
> Clement
>
> >
> > _Adding_ a regulator consumer from the OPP driver should not somehow de=
crease
> > the refcount.
> >
> > >> I will drop it.
> > >
> > > After retesting it, it seems to still no take the regulator and make
> > > my board hang... :(
> > >
> > > [   17.698597] sun8i-dw-hdmi 6000000.hdmi: registered DesignWare HDMI
> > > I2C bus driver
> > > [   17.708475] sun4i-drm display-engine: bound 6000000.hdmi (ops
> > > sun8i_dw_hdmi_ops [sun8i_drm_hdmi])
> > > [   17.718350] [drm] Initialized sun4i-drm 1.0.0 20150629 for
> > > display-engine on minor 1
> > > [   17.877443] Console: switching to colour frame buffer device 320x9=
0
> > > [   17.936050] sun4i-drm display-engine: [drm] fb0: sun4i-drmdrmfb
> > > frame buffer device
> > > [   17.961881] platform 5200000.usb: deferred probe pending
> > >>>>> [   31.710731] vdd-gpu: disabling <<<<<
> >
> > Are there any messages from lima, especially about mali-supply? Can you=
 provide
> > regulators_summary from debugfs?
> >
> > Regards,
> > Samuel

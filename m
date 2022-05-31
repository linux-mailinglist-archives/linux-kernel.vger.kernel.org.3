Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B1D538983
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242738AbiEaBVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiEaBVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:21:24 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E5592D0F
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:21:21 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id k4so1253375vsp.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BWNRT5udm1cgBdQ1Fxg5zG/+3/maHcJ/jTCZwv9kK0Y=;
        b=YQYAAlLeMUHgntePBFcBgxcUsquOmjLnhtgUC/3Q3o/zgoZkgVeK36XpsBCi6pns+R
         kLef9uDuC+Io3XodrSVzibaBXvsOd5uSUfLuES2zkWFDV89HFpb3G0w+Zj0tTY1/E+IC
         3LuKDTbAuqiVOqwu7QJvcN0qtjWnECEHDZoQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BWNRT5udm1cgBdQ1Fxg5zG/+3/maHcJ/jTCZwv9kK0Y=;
        b=rY2UR/CMNWhrF7sVrTFpcnwqkL+34vFOtzP5M/OApiiVSt4pEWILW025/mZ+OZibre
         yZ8ub90OQvilGJNgRCAQTmDws0e0hXtCeakfrlLOxthV+0HZE+kgC2FqXnnGL5xbt2xD
         308SuYtaIP6r0GxrtQ+CV0e/3qd4iMOm88m4abmFJpbvjHOBh/7j5Fcl9bzCekKGK/jY
         ENbqXwCTH+lUc8KKviUhwL3D7ageXxkpdrFGQkq+gOQYu4xiXUSiAJhksW35Xccy6+Vq
         YjnR0g7UeVaw/x0ylTUkKcgoUWHxixz60rE04yCbWmGVq2L4ZgkpC36c0ZrHOZRmZ3Zp
         K/Hg==
X-Gm-Message-State: AOAM533lf+BANDHDSuwhObl683uJztc/d2q7pN63ct6vpiPWqWWdK1xk
        EIiSE4YINDeONFoFpdARuTR+aStEfEZTsA==
X-Google-Smtp-Source: ABdhPJxwWObh6sJftYE9s570LAI1/0wshEDZwSKI9h88bItdnAOzzb4l0CJwrVsmPHO+V58zaEJOXw==
X-Received: by 2002:a67:ce05:0:b0:348:e08e:1708 with SMTP id s5-20020a67ce05000000b00348e08e1708mr629252vsl.8.1653960080899;
        Mon, 30 May 2022 18:21:20 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id w124-20020a1f9482000000b0034350d68fd9sm2021130vkd.0.2022.05.30.18.21.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 18:21:20 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id e7so5594709vkh.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:21:20 -0700 (PDT)
X-Received: by 2002:a05:6122:818:b0:357:26f8:5e73 with SMTP id
 24-20020a056122081800b0035726f85e73mr20773778vkj.5.1653960079694; Mon, 30 May
 2022 18:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220530130839.120710-1-pan@semihalf.com> <20220530130839.120710-3-pan@semihalf.com>
 <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org>
In-Reply-To: <f789afb2-33c5-2b28-5ade-0c76ebb7206f@linaro.org>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Mon, 30 May 2022 18:20:43 -0700
X-Gmail-Original-Message-ID: <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
Message-ID: <CAHNYxRw00QraVW0085xO-qzgGJdZ2joukuSYzBQo+yjLnkD=Tw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dts: socfpga: Add Google Chameleon v3 devicetree
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Pawe=C5=82_Anikiel?= <pan@semihalf.com>, soc@kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, arnd@arndb.de,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof

On Mon, May 30, 2022 at 11:56 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/05/2022 15:08, Pawe=C5=82 Anikiel wrote:
> > Add devicetree for the Google Chameleon v3 board.
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <pan@semihalf.com>
> > Signed-off-by: Alexandru M Stan <amstan@chromium.org>
>
> Your SoB chain looks odd. Who did what here?

Sorry about this.

It was mainly Pawel but I did some small changes at some point before
it landed in our tree (particularly the GPIOs).

>
> > ---
> >  arch/arm/boot/dts/Makefile                    |  1 +
> >  .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 023c8b4ba45c..9417106d3289 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_S5PV210) +=3D \
> >       s5pv210-torbreck.dtb
> >  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) +=3D \
> >       socfpga_arria5_socdk.dtb \
> > +     socfpga_arria10_chameleonv3.dtb \
> >       socfpga_arria10_socdk_nand.dtb \
> >       socfpga_arria10_socdk_qspi.dtb \
> >       socfpga_arria10_socdk_sdmmc.dtb \
> > diff --git a/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts b/arch/a=
rm/boot/dts/socfpga_arria10_chameleonv3.dts
> > new file mode 100644
> > index 000000000000..988cc445438e
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
> > @@ -0,0 +1,90 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2022 Google LLC
> > + */
> > +/dts-v1/;
> > +#include "socfpga_arria10_mercury_aa1.dtsi"
> > +
> > +/ {
> > +     model =3D "Google Chameleon V3";
> > +     compatible =3D "google,chameleon-v3",
>
> You miss here enclustra compatible.

Does this make sense? I don't expect this device tree to boot/work on
an enclustra motherboard. It's only really compatible with a
"chameleon-v3".

>
> > +                  "altr,socfpga-arria10", "altr,socfpga";
> > +
> > +     aliases {
> > +             serial0 =3D &uart0;
> > +             i2c0 =3D &i2c0;
> > +             i2c1 =3D &i2c1;
> > +     };
> > +};
> > +
> > +&gmac0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&gpio0 {
> > +     status =3D "okay";
> > +};
> > +
> > +&gpio1 {
> > +     status =3D "okay";
> > +};
> > +
> > +&gpio2 {
> > +     status =3D "okay";
> > +};
> > +
> > +&i2c0 {
> > +     status =3D "okay";
> > +
> > +     ssm2603: ssm2603@1a {
>
> Generic node names.

Dumb question: what does this mean?

Are you saying the name is too generic? As someone reading the
schematics this would be immediately clear what chip it's talking
about.

>
> > +             compatible =3D "adi,ssm2603";
> > +             reg =3D <0x1a>;
> > +     };
> > +};
> > +
> > +&i2c1 {
> > +     status =3D "okay";
> > +
> > +     u80: u80@21 {
> > +             compatible =3D "nxp,pca9535";
>
> Generic node names.

FWIW: Schematic is full of these pca9535 io expanders, only one (U80)
is visible to linux on an I2C bus.

>
>
>
> Best regards,
> Krzysztof

Thanks,
Alexandru Stan (amstan)

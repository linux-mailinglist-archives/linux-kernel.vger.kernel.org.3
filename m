Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE6455992E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiFXMHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiFXMHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:07:31 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A87FD2A;
        Fri, 24 Jun 2022 05:07:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id bn8so2561290ljb.2;
        Fri, 24 Jun 2022 05:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MlmWOxwc9B5om1qcXX6Sgk8MRmGPoyaBAHrPiH+sPck=;
        b=TQavJQqPAxGOqaMWJH9G5tNHL53MY09upOvdRJfLqeqqZop/EKT0tPY3DYiABuEp6R
         zLNG7my/MHYCPm5oEBkNe/RKCL3gIoCOTEYLZ5XRY+flheUaPrpqFFaSipolHublVGk7
         8Z9C6a2UXzh65Mwq/B9RTrrYSVAU33jj2TzOT+5tG18uTErqLoFcY6bpUlf7lQ4cKNrx
         FzTSgNU7Or9nuNLn2hU9yDkXPIgoY4cNUA2pxNmWAqB0XMXmPCKenP2FydicJ0Gspq03
         ItDkP4YjE/Hk/SH8BXRir0+EVbSyUi4R7qslZ7PsLFRlMk5ZmOgXJ+kQAquVkncYJVs2
         rsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MlmWOxwc9B5om1qcXX6Sgk8MRmGPoyaBAHrPiH+sPck=;
        b=3sFhTSr/HkfWNuB4gKrxZRQB+NvVKZlBrZ9kzkGIoGdlJgF0OKIFJpED1MvvKGSgEh
         M6vHZ1lksBg9iWN53MYBZ5u5/2lL88IyFQh+OeJJUxrsj74Fc/z9oXctexcJpxJ6HcrF
         d8YtTl0mzrZTaxhH28Cb1/k8wiuweHZHXOA8sYJ+rbD6nsihlcXTXV2OfdYwxR2JwhPw
         quB7ZZB+Cqlg0/XClFvJMo0VWdWHl6cdKKy6rx/HIWRcmJ/FDiz6fzp4zxsOiH2VvC6x
         jRT+sDhfmV14royii7NuiGPQVgyuEhZ7bHOO3M8kDHaHyFHazTpA0cTfnKrJaZ7Wzzx0
         PHyA==
X-Gm-Message-State: AJIora85zXfCaz7QhyW0Tv42LrwYmqqSYxJxXl+FqaccdgKHrBeHseFm
        ixINSCofN78hBfqqza+kxqg=
X-Google-Smtp-Source: AGRyM1ul024y5yyz3HCvSrcXgQgYJBlCT9N3Mk8SZtstRjOh+SrDXWzEgx7iNLMpl1idElTM3rjavg==
X-Received: by 2002:a05:651c:178a:b0:25a:44ab:593 with SMTP id bn10-20020a05651c178a00b0025a44ab0593mr7385359ljb.358.1656072448258;
        Fri, 24 Jun 2022 05:07:28 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v5-20020a2ea605000000b0025a96e2ab0csm261845ljp.133.2022.06.24.05.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 05:07:27 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:09:17 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] iio: adc: mcp3911: add support for oversampling
 ratio
Message-ID: <YrWpbcjHSY+se1Aj@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
 <20220623170844.2189814-6-marcus.folkesson@gmail.com>
 <CAHp75Ve+gDa46MRhTR-5dOutGhXqakZbSX14TurwnsuT4OeuYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mjYFCl1wg8k8qrkO"
Content-Disposition: inline
In-Reply-To: <CAHp75Ve+gDa46MRhTR-5dOutGhXqakZbSX14TurwnsuT4OeuYQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mjYFCl1wg8k8qrkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:20:01PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 9:08 PM Marcus Folkesson
> <marcus.folkesson@gmail.com> wrote:
> >
> > The chip support oversampling ratio so expose it to userspace.
>=20
> supports
>=20
> ratio, so
>=20
> ...

Thanks
>=20
> > +static const int mcp3911_osr_table[] =3D {32, 64, 128, 256, 512, 1024,=
 2048, 4096};
>=20
> Spaces inside {}.

Not sure what you mean?
>=20
> ...
>=20
> >  }
> >
> > +
>=20
> Unwanted blank line.
>=20
> ...

Removed
>=20
> > +               switch (val) {
> > +               case 4096:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x07);
> > +                       break;
> > +               case 2048:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x06);
> > +                       break;
> > +               case 1024:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x05);
> > +                       break;
> > +               case 512:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x04);
> > +                       break;
> > +               case 256:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x03);
> > +                       break;
> > +               case 128:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x02);
> > +                       break;
> > +               case 64:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x01);
> > +                       break;
> > +               case 32:
> > +                       val =3D FIELD_PREP(MCP3911_CONFIG_OSR, 0x00);
> > +                       break;
> > +               default:
> > +                       ret =3D -EINVAL;
> > +                       goto out;
> > +               }
>=20
> I understood why the table above, but this is a waste of resources.
> Use that table

Yep, I will use the table instead
>=20
> ...
>=20
> > +               ret =3D mcp3911_update(adc, MCP3911_REG_CONFIG,
> > +                               MCP3911_CONFIG_OSR,
> > +                               val, 2);
>=20
> sizeof() ?

sizeof() what?


Thanks,
Marcus Folkesson

--mjYFCl1wg8k8qrkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmK1qWgACgkQiIBOb1ld
UjLRIhAAxjpsZF7muOuTgCKiTvY0MQGsqb059NkGOLpiiiB39A0g4r+Oj3yHDdZk
RmynAm/qheM70moQNU2GUDKUm96bHVHrPmbpl8TpOZ0QldlPanXs3gZ+vBeGlO95
t0s4NPLVHnxKusVRDSMeWa5EETjm0DWTfwbwE/tDp5Gd9U56+vsJ+fndhIwolLo3
4kjkDo1oPXlFeJUwAHOZ9HNp+987NVoS0u9SDotb/CkWK63hNfpP9aL6Knk07cby
PgtLzefWXf47NVOAErZIfE0UzNQkRTP7ijH20JcX+CLYKavovEYbrMXyhVwQky4c
NrWFjHYy1DhW6WKMc2qW76q1vPrQgQo4y/rsbLlF/25TWCfN3ruFOdpGzijPkDku
r4buN5L2C7M+MOdfT6R+4Uo2RzQoeK7ZuheU51rn9B/8FQbtldD99mCoBARoEdEq
JSzIpdnheTmQwZH4BNgzEoe6/NrG08fAtG9oET+7NvCK4fA+h+KasgZ+Ixo/MbOw
jD8B3m0nNGd1RBRm41/KGUnO4IFzDWmLZAwIHGTRIMpJ3cT5BxR84mmi48EcngS6
x42I5s1LmfvwCh1k+YXcUWhttZEK/qv6NiEPFRdlK/GomREs4aVDqviveRy0TLnA
cscGoik2YWh0sOAkmxoOmPhuiNLwL3IW7YhybhrYiTh95p1lrTE=
=3t6v
-----END PGP SIGNATURE-----

--mjYFCl1wg8k8qrkO--

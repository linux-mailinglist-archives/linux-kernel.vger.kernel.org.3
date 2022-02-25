Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A284C44EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbiBYMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiBYMvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:51:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB3B715F;
        Fri, 25 Feb 2022 04:51:07 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i20so1588832wmc.3;
        Fri, 25 Feb 2022 04:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D8OkI5TiOmFqdEQ1+JExn8L7GZBvYCU0s5pvA+scH4E=;
        b=qFtlxCmsJW0iYp6O6aQUAt92qxIp3FA3KLYPQqOkTNYMBNmitYRRSJ/2XNzOlWbitx
         FBO14LkJ/Hsoks8Ycb6aOb+Udtayxs9u3mkLKbwh18PPlHXXjLBJsuM+pg4REcFo0eR/
         JnC8khZewuHT6+ea+Kp20IzzJrPaVSLgGV/n7ChimT/UUYCZ2uXKV3TkiySMFu9nW2Lj
         cYNhU0ppyM9yR+Y6iC9AZi05cjvJM3E55j41DBYEg87ULbWS6E3xkLvEN6Xl6F9ERUcr
         uTw2nbB6YwhMD+QhBCiiUNDvfbRjw401gSdkZllKI1SIUghvuK/MxqYGR+h5CpEBOjJD
         HxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D8OkI5TiOmFqdEQ1+JExn8L7GZBvYCU0s5pvA+scH4E=;
        b=23re+1oHhDHojV6qYmkdyIoFhIUCLZpELnVUKfylMT2W5XSvH+Yuop7KhfiHZuDLWi
         NnMs6PyU1/LMVEfz4+HAeIEETjjbC+CiehcUzxZz35E1c9mIVIm7utwtAlezHd3CwRkK
         H29XqLkSnrY0Aj54q3U7r5PeS9PQ1Km2vJR8qmOGQWZs4jid9mX2pdZVCAm8zyWswU7+
         +28W9hxRacIri0h45HnWZjlkJJhq1hpKBGmkWbA/FBnkk9kyNa9b6DWbjwCc3pZzZ5//
         6hS7RJ9vWdHx8sKU+FnZk9gdleaz0DnLu1KVHw6YnUY3dwbZD9fifNGW8tX2fSLJR+5x
         zZvQ==
X-Gm-Message-State: AOAM533uTh2EfZQFIYtoKqz3EHmK8uNlXFjTVvS/lFiUzbtDOLzXt2un
        NNrpbgHRUZ5drgCkLYWz43A=
X-Google-Smtp-Source: ABdhPJwgg6EZexSvdvXpWUwvbWOLrPrcS8JCeV5BHAXFWiezdJXjxL0kWP6rSVFEBHQhGy66O1fbXw==
X-Received: by 2002:a05:600c:4107:b0:381:1c3:5d3 with SMTP id j7-20020a05600c410700b0038101c305d3mr2567355wmi.107.1645793465616;
        Fri, 25 Feb 2022 04:51:05 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id t14-20020a5d460e000000b001edc107e4f7sm3253983wrq.81.2022.02.25.04.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:51:04 -0800 (PST)
Date:   Fri, 25 Feb 2022 13:51:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Mohan Kumar <mkumard@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, jonathanh@nvidia.com,
        spujar@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] dt-bindings: Add HDA support for Tegra234
Message-ID: <YhjQtrueEYNGQrSA@orome>
References: <20220216092240.26464-1-mkumard@nvidia.com>
 <20220216092240.26464-5-mkumard@nvidia.com>
 <YhfdHd2LPc+ifFTS@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMSq3re6wkdG1hOh"
Content-Disposition: inline
In-Reply-To: <YhfdHd2LPc+ifFTS@robh.at.kernel.org>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VMSq3re6wkdG1hOh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 24, 2022 at 01:31:41PM -0600, Rob Herring wrote:
> On Wed, Feb 16, 2022 at 02:52:38PM +0530, Mohan Kumar wrote:
> > Add hda clocks, memory ,power and reset binding entries
> > for Tegra234.
> >=20
> > Signed-off-by: Mohan Kumar <mkumard@nvidia.com>
> > ---
> >  include/dt-bindings/clock/tegra234-clock.h     | 4 ++++
> >  include/dt-bindings/memory/tegra234-mc.h       | 6 ++++++
> >  include/dt-bindings/power/tegra234-powergate.h | 9 +++++++++
> >  include/dt-bindings/reset/tegra234-reset.h     | 2 ++
> >  4 files changed, 21 insertions(+)
> >  create mode 100644 include/dt-bindings/power/tegra234-powergate.h
> >=20
> > diff --git a/include/dt-bindings/clock/tegra234-clock.h b/include/dt-bi=
ndings/clock/tegra234-clock.h
> > index 2529e7ec0bf4..2ab651916127 100644
> > --- a/include/dt-bindings/clock/tegra234-clock.h
> > +++ b/include/dt-bindings/clock/tegra234-clock.h
> > @@ -64,4 +64,8 @@
> >  #define TEGRA234_CLK_PLLC4			237U
> >  /** @brief 32K input clock provided by PMIC */
> >  #define TEGRA234_CLK_CLK_32K			289U
> > +/** @brief CLK_RST_CONTROLLER_AZA2XBITCLK_OUT_SWITCH_DIVIDER switch di=
vider output (aza_2xbitclk) */
> > +#define TEGRA234_CLK_AZA_2XBIT			457U
> > +/** @brief aza_2xbitclk / 2 (aza_bitclk) */
> > +#define TEGRA234_CLK_AZA_BIT			458U
> >  #endif
> > diff --git a/include/dt-bindings/memory/tegra234-mc.h b/include/dt-bind=
ings/memory/tegra234-mc.h
> > index 2662f70c15c6..c42fe61fba5e 100644
> > --- a/include/dt-bindings/memory/tegra234-mc.h
> > +++ b/include/dt-bindings/memory/tegra234-mc.h
> > @@ -7,6 +7,8 @@
> >  #define TEGRA234_SID_INVALID		0x00
> >  #define TEGRA234_SID_PASSTHROUGH	0x7f
> > =20
> > +/* NISO0 stream IDs */
> > +#define TEGRA234_SID_HDA		0x03
> > =20
> >  /* NISO1 stream IDs */
> >  #define TEGRA234_SID_SDMMC4	0x02
> > @@ -16,6 +18,10 @@
> >   * memory client IDs
> >   */
> > =20
> > +/* High-definition audio (HDA) read clients */
> > +#define TEGRA234_MEMORY_CLIENT_HDAR 0x15
> > +/* High-definition audio (HDA) write clients */
> > +#define TEGRA234_MEMORY_CLIENT_HDAW 0x35
> >  /* sdmmcd memory read client */
> >  #define TEGRA234_MEMORY_CLIENT_SDMMCRAB 0x63
> >  /* sdmmcd memory write client */
> > diff --git a/include/dt-bindings/power/tegra234-powergate.h b/include/d=
t-bindings/power/tegra234-powergate.h
> > new file mode 100644
> > index 000000000000..3c5575a51296
> > --- /dev/null
> > +++ b/include/dt-bindings/power/tegra234-powergate.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
>=20
> Dual license please.

We've got a bunch of similar files in this directory that are not
dual licensed. These files originally are part of the BPMP firmware
tree, so I'll check with the owners if relicensing would be possible.
If so, I think we should be able to relicense all of those header files.

Thierry

--VMSq3re6wkdG1hOh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIY0LMACgkQ3SOs138+
s6Ez8xAAn+49vmQ+ErSD9Sg2/t6O8Sil+0KTyZF+OSNKNEOKafvj38Sv+zjGH7ZN
OH0666hghTwlDgDBX9L/ZI4fItEVAXr7l/lMjoIiXtZ0CYb0xIXBXqIRvP8R7xOp
TjPWFBe1oTBqALv+GSRE0f4ZPT1OsWtCddlONIwMtzO4SmHjtTKTx6PvCvOL62AC
s+xHeUtfCeh8orT1Qcmr9XK0XGDikxqVi1SFfl7rgUBX2TS+7zmjHVDF5vmSkpw7
lTQ3rZsRTWlyScBolyIhNAP9y6N4/Ix3ASVrEQSPjkRx6S8UgnlCsjN9qjXS0I4W
C7rQgFPPHQVpIEFxdfZBWaP1ReyDUN/5kseJzPVqB+XQ+/cUXsFYsuP8Nnx8+F4m
/GlQwsmtLzanpKOgwyMEN9sgJcWLbXa+9ZtT2lOEr9dDMFbnMq27bZZ319DvTQ6o
Fh9aahMgLu45+gRhGMJsrGRaFqoVYzFPUh6+7bJmSshVIvvp1esNNy9ofZXdBKIW
oPzfNjAd0l4KQ2eDmZdjfZyYjgcnU6gTeSoXIPvjwf3i6Vp3kjcB5eAR6qwcKxDc
8r+dsJaPfBoS0qMWpe2zMPgiHJ5N034/Au6JqDjuv94vY1sVDCRvS1UejJlItHe9
9iTv9lVa4Fa+6r6vj0MnPhLSCk8PpmXqiuGWBMyAc8MyWMbtHyA=
=xQrv
-----END PGP SIGNATURE-----

--VMSq3re6wkdG1hOh--

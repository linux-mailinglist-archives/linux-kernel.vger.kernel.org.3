Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC8B577676
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiGQNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQNzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:55:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD5F13CFE;
        Sun, 17 Jul 2022 06:54:57 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id m9so8169037ljp.9;
        Sun, 17 Jul 2022 06:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3sTi4q00kD+o63dF5volyJSGlu0r+NSukbZgl5yU5Y=;
        b=NFLcWrEWmQ66emExXZ4oWY+UFzI0Ms5DBBLa1+AXu44OGQd9kqNAeLNMyxpOqt2Tpx
         SCkUd1f3lGX/KqhWNKmCo949+PU5BZYJFBZbuWUMrHP9Gu6Om8bLtLKLpGd7JIXTgM3w
         PBBXD0xTreljjkSj3IKHeb5RP56BYG9To/ib+mF4IJWS1vmv01VwOhAfliWfNZwBHM2F
         GDDdA4SarcpRRhaD2XQTqIorkdbMHSI1avOcQfBxuHt+uf839/9+N4lBtoOjPdqtGJnp
         d8/4nxURztbWyGbqPf9WIn/V5ECITcDVDJJqP1nH7P6tHx/ttJqCViXRbR94mDRyFYBG
         jCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3sTi4q00kD+o63dF5volyJSGlu0r+NSukbZgl5yU5Y=;
        b=EYf+79x5YgyoqUieprjjI3fNAYMAW43Fq/GAT7iEHO+PsOJMPU5Ulu8TMpSSFhovrZ
         8KRlblhidEcFnCx9/iGAXD0E90+SEYi+GGPNbcFg7S+OzsNjljj7HM63nkplXhJ5NMzg
         rZC+kC5J/fS9R3h9rc7GeheXESbUM0SMAb3GdMGoG/PQRYo27J8Z8ZMEL2m+Jt6gd1iu
         PGH1gW+whk5zDkv4VQF/rX5YQKnNfmb9obv1MchhcuKM+DIaDWsCEtsij6Xg8WMYTBO9
         Lf6oPL30vdu/P2g86KpipJg8cnblrKh+vRPyn9f5cklrLopr8hKuYCjcZviXxyhFq4xa
         Jj3g==
X-Gm-Message-State: AJIora+O1jREPqXjU8y91ZJHDx8Fc/HQ7SWtydfcIx1gywRblAyNZ7fK
        4r6/JZjdNv1kcOy3c/4W81IacA9JGzQ=
X-Google-Smtp-Source: AGRyM1vixsJrMK+W6Oq6pBHBsjSU/j13+wVk8ihBXsz6A/6OlrAVoRfflqAZ7eCUGmTgxxpRG+2S+Q==
X-Received: by 2002:a2e:a789:0:b0:25d:7a05:d179 with SMTP id c9-20020a2ea789000000b0025d7a05d179mr10724069ljf.64.1658066095137;
        Sun, 17 Jul 2022 06:54:55 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id x11-20020a2e7c0b000000b0025d73516a24sm1614427ljc.83.2022.07.17.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 06:54:54 -0700 (PDT)
Date:   Sun, 17 Jul 2022 15:58:12 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] iio: adc: mcp3911: use correct formula for AD
 conversion
Message-ID: <YtQVdNdMVDyOSEW8@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
 <20220704172116.195841-4-marcus.folkesson@gmail.com>
 <20220716181837.4b0b8870@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXWMr910dC9HA4nc"
Content-Disposition: inline
In-Reply-To: <20220716181837.4b0b8870@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXWMr910dC9HA4nc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 16, 2022 at 06:18:37PM +0100, Jonathan Cameron wrote:
> On Mon,  4 Jul 2022 19:21:10 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > The ADC conversion is actually not rail-to-rail but with a factor 1.5.
> > Make use of this factor when calculating actual voltage.
> >=20
> > Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Acked-by: Jonathan Cameron <jic23@kernel.org>
> ?  I doubt I gave a tag (mostly because I don't give tags to patches
> I'll pick up and give a SoB on.
>=20
> Note that tags have to be given explicitly in full form before you can
> add them to a patch.  If in doubt (people often given handwavey responses)
> then ask people to give an explicit tag.

Sorry for that. I will remove the tag.
I interpreted your "Otherwise looks good to me." as an acked-by.

I will only go for explicit tags forward.=20

Thanks,
Marcus Folkesson

>=20
> Jonathan

--BXWMr910dC9HA4nc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmLUFW0ACgkQiIBOb1ld
UjKfbw//aC0VsEbKL59Ib6fWVdn4UI4iYkoQcLp2fKG3e6JGnTp2azF2LQHe8u/2
gzYunEEc/v7NCyD2s1r81+Ww+YODjDMbFlIXk83Dd8A8qKIxdQ/6AzMEPyeFHjN0
xggoeKXl5nUMF+5m94LZ7VvX3jW+0AKqEI6/jZ5FXjmk8uq0NH4goPaI0UdaCIj/
MNeVJH09wboZ8ad67V5Jg4witlh0mNXAj08Y6EASSYs6TrWnZPgqwdPoTfJOt3fI
69pAGvr9gPmYi1POKm31Wrm1pMi1zI6hLWarF7evFLA9lZix2TJP/buPdDgceski
TzpU+P3bH4PYv1UoIg4FsrKRPpfQIQGaNLvBeuwmaFBdXcRlFMigoeN2DxNZyomH
HyYxBcfghDLpbdAnbO7R08xH3dvH/R4p16mnUqwenb1CheLFb7TvU4ulS17kL1qa
rAWMV2dSHFpssdEytSyYA7ofwNgssCfB/tHpZ1q7Tsi5C7VrejAoC74uKxzT0j9/
GoHS36q+Hddkm8gJYE8XGQfMiITb7tRpg+V7QsUuuvdEEvaGkYpCBNVb78RiSHwL
d8YvSiCtRHoORRpPqPw5jupVzTXWLtfgy6G8SOME5eeziVo3F+iIOMJhPud/sMJC
yp1MRS/2YLXPpNomYY+RQQKnoT4dRj26AGhv+IDeFL9rcqMID1E=
=EfKq
-----END PGP SIGNATURE-----

--BXWMr910dC9HA4nc--

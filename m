Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48F5A2BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244074AbiHZQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiHZQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:03:15 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7A5D34CC;
        Fri, 26 Aug 2022 09:03:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn9so2012531ljb.6;
        Fri, 26 Aug 2022 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=CJYOqLIO01MXVIHzVSpSMA9KtKvNIpQx9lFJup0kd+A=;
        b=nZKNJYYb7BsiUFO0xhhabyJFpwpI9wbBPKhrWhpub9OkdeTNhFbhWKITn+cBfbTXCo
         yEAXKUjBUape0cJ4SA056RPcmIsAIZpf99RCejQG8z1XHVBovkOy7XQXKLNj8kaHiLoq
         xtQXGz7pZRz458/dVk1w7/mgkIHsAcQnMD04HNV7uio4qPWSoLjRuqmg+xIPEIjBVAAw
         9MYJd95Z9KDZKK+/NcMYq4yLC0Ckli+meMCuK1bLwPhq1DyiAaFZVD5HEnqeToF1vlLG
         b4fEkn+Zx+MxDpLvh1ZF+GhCpDDQjQ46CpWGGyWJ1xrh+QV+7VyIIZD7bWAsF5fRXQ6u
         RsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=CJYOqLIO01MXVIHzVSpSMA9KtKvNIpQx9lFJup0kd+A=;
        b=rsn2AybMiVAsbfPZ0U/mFso24P8CVcBL+kSrUctTLCHL3zXastqmMg/jQaKGc9pAXy
         MUTXlgit+7PuH6QX0FpERpR9I7lwgKulNs+4vhqtA7VFoh3l3enIo94eazc/tq2URuA8
         se5j3/+S5YLC9H8K4Zo3RmSyLqO5BJW1yoZkB/gOdAEcUtiAxatJX4NV/zbuEWdzJ2+C
         58sbS8AhLYv4u74d2ZMCIsrSPu9Ta4DlCjAIPf4YBrb6SJrr70t/uTXoYm82IEitK8aA
         iZeB+hJ72+sNgEuaBM4xdR0lvMi1oYvDscrDhZ41iOzdXIPAmE5fSyMk96k5Kerrf2TY
         vc6g==
X-Gm-Message-State: ACgBeo0/RX/TsuAPAW6XjdiqbG4NnpZ9GuPE4R0Y6k7L8eI26JfEZ9xF
        OEkhKSMYgSlpMFn4R6uToQ4=
X-Google-Smtp-Source: AA6agR7icvaWbLM6+nRHP0f0x/I0DIAY+vWIHyEWhhwNgtCtOCHUZfXBrRqo6KAeJlB9s7Y/tznmCA==
X-Received: by 2002:a05:651c:1025:b0:261:cc9c:3db with SMTP id w5-20020a05651c102500b00261cc9c03dbmr2605963ljm.80.1661529791526;
        Fri, 26 Aug 2022 09:03:11 -0700 (PDT)
Received: from orome (p200300e41f12c800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f12:c800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b0048ad4c718f3sm422620lfb.30.2022.08.26.09.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:03:10 -0700 (PDT)
Date:   Fri, 26 Aug 2022 18:03:07 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Petlozu Pravareshwar <petlozup@nvidia.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "Kartik ." <kkartik@nvidia.com>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        Sandipan Patra <spatra@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc/tegra: pmc: Print reset info during probe
Message-ID: <Ywjuuw/rSRUSORFF@orome>
References: <20220817184456.1184459-1-petlozup@nvidia.com>
 <Yv5XarzacTOkTL1k@orome>
 <DM6PR12MB316434A9BA61A01251E3BA3CB5739@DM6PR12MB3164.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IwTi6ziXccuE4c+s"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB316434A9BA61A01251E3BA3CB5739@DM6PR12MB3164.namprd12.prod.outlook.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IwTi6ziXccuE4c+s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 07:39:46PM +0000, Petlozu Pravareshwar wrote:
> >=20
> > On Wed, Aug 17, 2022 at 06:44:56PM +0000, Petlozu Pravareshwar wrote:
> > > During PMC probe, print previous reset related info such as reset
> > > reason and reset level.
> > >
> > > Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
> > > ---
> > >  drivers/soc/tegra/pmc.c | 27 +++++++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> >=20
> > We already expose this information in sysfs, why do we need to print it
> > during boot?
> >=20
> > Thierry
> There are some tests which would parse the boot log for this information.
> But I agree, since we are already providing this information through sysf=
s,
> there is no need to print it during boot.

It'd be a good idea to transition the tests to try and obtain this
information through sysfs first and if that fails they could fall back
to using the boot log. Although to be honest, I think we've supported
this sysfs interface for long enough that we probably don't have to
worry about a fallback.

Thierry

--IwTi6ziXccuE4c+s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmMI7rsACgkQ3SOs138+
s6Fuuw//fpdWuuuYJumXJttWNjjZcCt38TggWatdqAJIJQ3UIyy6K/+jga2fV0SZ
SMbsuNdMyWBgq7pVNVNrAqZptg+3bnrInbJzU3BIT+UCQuXnL95I1MuvaB2zWTQv
ZFLRZwd6X4txY70t7iFwstgjkNhKkSupGE6hDHwMh3h0ptGYby3sDtbYlXBBxnRk
4MLW68/LIuJe36kRJI8Z7LLjzZYOo+Y1Z8Dk59d1pJxQukaH6gy5zxyuxoFd/XAt
THB6PHQid796Ej8w7W3U9oCyvgzqYPClIA1sxaNH9ZPblDpf2skQczrJAps73aK8
UReS3Bg0uBsj7elz9OY57bsw0gqp1EqiEK9tlfx9WVF1H2eJYKF1D/2Xb2/lsv6A
DonpVF+TKzMiYe0AL2+vSWlzK/LB7Ckh9Lyz8aijAepFiQgAjp6G8Ogbme1fsO1Z
shM4FahaAorW+aqLFBl9VLDthcTVlgx7WTt3aovSMYFS9DBWGluC5DSW9UCtLDVn
wgv1M9AyXt5sYv2UzDKC2w1LQPejRfNclu0w3wM2SNkkY2551244R0H/JTusvDC6
2dYgQ/h6f6yrxPAmmIe+2/tgYOCfp5yuMq0Sv2BdQptAR1q5v+12Lebbc0g+4du3
eotOvH6HE8RBZRubK0d8Ih9ZY9RWc6nE2ZKH+MUqgX7+v0Dgj4M=
=iqMZ
-----END PGP SIGNATURE-----

--IwTi6ziXccuE4c+s--

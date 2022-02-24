Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698AF4C2CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiBXN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234933AbiBXN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:29:03 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63290B7C42;
        Thu, 24 Feb 2022 05:28:33 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a8so4321924ejc.8;
        Thu, 24 Feb 2022 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U8ApFWalU/hZbExAJu9JWeDMkdzMfCYpGYwY4Mu/h8M=;
        b=ZDdWZqYPv3xo+qzcqesSu1qnNyPqCyHCU4OTXzCSqSQwhRi/qS6kNmN0325KLkNBaf
         r5hW/WSKtbo/Y3wpevI8uC1ygyW+hfhYeF6OKt0pRzS8tz2idVleGnvW3w8N5Ba4efMI
         o07e3JtoB3WlJQd2LYHDboHxsjYgCXqPsSbKc3vdAXQ3CxG6ziQYkkrf/Sqm0DGNQZBd
         i+ScYOWJobDhFC6MnjaW+Df4s+NSMMqI9aCfXnxuxDbbLArHOaRUn737n94EqPromu7j
         uBZ01kJ9YM2QwHUBwPrXopvtLI3T4Xzelj4TcPsh9a4oem3kUy6HLEvRy0Hqgbe2zRan
         x6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U8ApFWalU/hZbExAJu9JWeDMkdzMfCYpGYwY4Mu/h8M=;
        b=mSfpzz9WMmjsZK2nAqVsTpl9OmHvcWK62CsnLCK+CP95m7zGU4CtH2CrNjYLpM2k89
         T5HuuyO1JqCraXuT97ua35kbJ7dGeH63xpQMuOp5EjrSzjCpa03IvvxUaSknUmbAzxNq
         7cGEgjzhmQKwtFaqOg0c3Ueb3WpnYkc2sVkflPJG84q8n26uW28YCdJ3HbDbzMLcb21F
         viYV1Nn5BA2bMoggn9zNw8HKSBzE/9qzfHPn6PZgNWSdAVGJKT5jQj8ppc/zjd7ECDlz
         F4i6ugfHN6tx+2MHV0nKjiTifCG6pmnFHEZf+TOh8STmmYMb9pnEbvmMCOqq5IuoUpKP
         dqzA==
X-Gm-Message-State: AOAM531jlZKDfHms1T9V5VFIwnPBJ/IsCoB8tVaQpoVIqo5B2drpCND+
        Hn7b+5W+i1u3h3gxxSFF8gCOizTzSAQ=
X-Google-Smtp-Source: ABdhPJwPx6i2k9MdRnfKfvY56jx4rXDQln+lmVh3vJlUwi4M0boQKgn4cQwqDpz1f0/3cxt8jrbl7g==
X-Received: by 2002:a17:906:4b11:b0:6d1:ba2:5bdb with SMTP id y17-20020a1709064b1100b006d10ba25bdbmr2270099eju.61.1645709311805;
        Thu, 24 Feb 2022 05:28:31 -0800 (PST)
Received: from orome ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b4sm1332753edu.105.2022.02.24.05.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 05:28:30 -0800 (PST)
Date:   Thu, 24 Feb 2022 14:27:58 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH] dt-bindings: pwm: mtk-disp: add compatible string for
 MT8183 SoC
Message-ID: <YheH3uAzJCoPVyin@orome>
References: <20220207112657.18246-1-allen-kh.cheng@mediatek.com>
 <20220207125158.t5362u2dddccdmsq@pengutronix.de>
 <f6633fc82c4fa899c7f4ca27d9751d9e61fb90ac.camel@mediatek.com>
 <20220208091029.iwnepc343djtcvq5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0RdXHY+yV2W/4ltL"
Content-Disposition: inline
In-Reply-To: <20220208091029.iwnepc343djtcvq5@pengutronix.de>
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


--0RdXHY+yV2W/4ltL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 10:10:29AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Tue, Feb 08, 2022 at 12:28:23PM +0800, allen-kh.cheng wrote:
> > Thank you for your suggestions.
> > We will send another patch for .yaml format.
> >=20
> > About the last reminder, sorry, I don=E2=80=99t get that.=20
> > Do you mean upper/lower case letters in an email address?
>=20
> exactly. I don't know how picky Thierry (who is responsible to pick up
> this patch or not) is, but a 100% match is the safe bet.

Email isn't generally case sensitive, so I don't care all that much if
they case differs. Ultimately the username part of an email address and
the domain should match to clarify that both are the same person.

There are also circumstances where it can make sense to have sender and
author differ, like for example if your corporate email tends to butcher
patches.

In this case it's fairly obvious that sender and author are the same
person, so I've applied this as-is.

Thanks,
Thierry

--0RdXHY+yV2W/4ltL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIXh94ACgkQ3SOs138+
s6FyyQ/+O6qlN6bd84T6E93BHOHVbJc9Hg4VTzKRkidnyBGqSibA50ETyN9Dp8ds
OMon+0lkvEsU4dqgzbW4P7PygDbXUJQUwP4isAN9MVRJKHiuWaWFlJ9udehLsU5d
6D+2KfUjvG7vXxmGToSan3xPlKjCcccCqYcduQxEixalh0nzR088O0JJXHncX4a6
3CQOhfiyKL3cDcLbg/eQZ+/PZKZu9sLOXKuhw4Nh7DruZ+b8rYIS7DM7imKxp51K
vZQnuP9qnMuAkgXKoh2p+Tf3zar2yf2zQj9gPodaS8p8ljfaeYJVA5uNoGE4jLgg
c3I6WdGR93ErKJXglYsWSs0caFMBrdONAjbWHysHuEE8UhIanh/K6TRgCSAeLx5e
QIzSYpb/p27CyuTOiDK8EysrEVmLZeio/Z8yJJ2FUSEEZjc/lK4Do6xviBxwpkRV
N5yYZ1sMtpTB4HqExgRC/sEMGGlNbvRnLjco77dOdN0m9W2QYY9gDfI2iuMGsjuc
+A5mVTSyj+/eQJyvFH3kzUy8D+FDtR2c7fr85jGXmGziuMJi2c+IMR5mn/u3X4tz
7JBXnR6cyiycJ1gk3XR92M1QWZq2baSrMd68rtDx88ZMhfJDzMqSv8znq7Et9+fT
638mkXNwHKgLrzDmMaCFpg1UBZznMwHiqxGFa0jt2Ed+axL1mq0=
=XDqO
-----END PGP SIGNATURE-----

--0RdXHY+yV2W/4ltL--

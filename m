Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1DE4BAD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiBQXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:47:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiBQXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:47:27 -0500
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B65237842F;
        Thu, 17 Feb 2022 15:47:04 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id u16so941499pfg.12;
        Thu, 17 Feb 2022 15:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u00A7HXNqtn6x61TYWm7OlmiKFTOsyXYfH8TCwr1QB8=;
        b=p15mpCPvBPQa1JJ3cMVulmRKIRseXMQEsaEWk2vbVJztGY6ojcdBHQuaZbEHH1b4A9
         vdh7rQrVzJiwneRnftFMojLEHyo5Oxz8p9JGyovy2LJuU5E5aMKPZUNq2ZTF1eDD1Y1I
         /pMdAFiJsfLftcXH8Jv8ckjq2HX4TmWaeEfizIBLdOFQbVpDHy1tcht95zlmqv5Nvovc
         OzDQmtxQY5pTfcRmlYnuv8RtjIywzMoe5ZcXWYu+RbF888mjBoAeotvpUgZE+o1E2apg
         vnP3rwO288Au9CKm/bE4mpfl0Ao1yX+3Q6t0izEzeKwHuYTUnYT56/yEc2bHUw/IcrXS
         1Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u00A7HXNqtn6x61TYWm7OlmiKFTOsyXYfH8TCwr1QB8=;
        b=xfYBO3kq4HBRT/kGYY4mKRVkcIlem+9Ii2sUOxG3H7O+pdun283QnyOxPmwi/0vTFH
         1uQ4jDSWa0nl0ONG+gT8kk4hjFWGvlmJYkGBKN3ZDRLj46zcWXCWmreEO/SSutELxb8V
         3UNnU28oJaSx+M7CmHNAjM9+fxI97tAr3lrr6HJv7MKTZGDUG4YrifE8UAwNDuj2XPxY
         aNvXEF0Sm1W5qVnbv6S4gXnr+br26dUy/K7LQoTlzuzD1Hfgd1WdaTZ4jiy6jhjQy/jQ
         DqS9EKGVy9MjvXyOH/BiX3pc11QR9RVTzW02fixbinTUzqWfU0AiKPpiGhi+dSkolTV1
         WClQ==
X-Gm-Message-State: AOAM5332CB0kP63+w9Sr2LJybBOQjJt/shPAMgk3hH9dtzLi80gOreyA
        rMV40BSct4aTMnS5+YsHKq4jzlfifT2z+Q==
X-Google-Smtp-Source: ABdhPJw6JQyNTvhVXbUzQ/+zneEXeBpconb6izjpkCJT8lXzfplhbWtbFhX9XlPnZPRE1ihsoVUY8Q==
X-Received: by 2002:a65:6201:0:b0:369:4a47:aff1 with SMTP id d1-20020a656201000000b003694a47aff1mr4188198pgv.238.1645141377577;
        Thu, 17 Feb 2022 15:42:57 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id b11sm658653pfl.123.2022.02.17.15.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:42:56 -0800 (PST)
Date:   Fri, 18 Feb 2022 08:42:51 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] counter: Stop using dev_get_drvdata() to get the counter
 device
Message-ID: <Yg7de1ZlUJoNGYNa@shinobu>
References: <YfzPcyusGwAOkys6@shinobu>
 <20220204082556.370348-1-u.kleine-koenig@pengutronix.de>
 <YgHKekl9rJ2jH5j4@shinobu>
 <b9099ac3-a5fa-1aba-92a3-05a7212525ab@linux.intel.com>
 <20220217160308.oo3fmghapnvmummz@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iNB/FkNypOb1hr7K"
Content-Disposition: inline
In-Reply-To: <20220217160308.oo3fmghapnvmummz@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iNB/FkNypOb1hr7K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 17, 2022 at 05:03:08PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Feb 17, 2022 at 04:48:50PM +0200, Jarkko Nikula wrote:
> > On 2/8/22 03:42, William Breathitt Gray wrote:
> > > On Fri, Feb 04, 2022 at 09:25:56AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > > dev_get_drvdata() returns NULL since commit b56346ddbd82 ("counter:=
 Use
> > > > container_of instead of drvdata to track counter_device") which wro=
ngly
> > > > claimed there were no users of drvdata. Convert to container_of() to
> > > > fix a null pointer dereference.
> > > >=20
> > > > Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > Fixes: b56346ddbd82 ("counter: Use container_of instead of drvdata =
to track counter_device")
> > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.d=
e>
> > >=20
> > > I'll pick this up and apply it to my tree.
> >
> > Perhaps late but I hit this same issue, patch here fixes it and I wante=
d to
> > confirm it.
> >=20
> > Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>=20
> I wonder if this patch is scheduled for 5.17. Currently it's not even in
> next ... :-\
>=20
> Best regards
> Uwe

Hi Uwe,

I've got it in my tree. I'm sending a pull request for the Counter
patches for 5.17 next week, so they should all be merged after that.

Sincerely,

William Breathitt Gray

--iNB/FkNypOb1hr7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmIO3WQACgkQhvpINdm7
VJKqAQ/+N4Ipb9S/Ax8Xl5ttPmJedMOl/V5NBJ+GjFdcKkoyS/SP2FC1mylie/Ju
mbkMIL5k+enkr5EFqmIBRmJFc79RU7JWR68n4TLx+5+l7EdruUx1CDmmxu0lhgnl
gKbWj1zUsu41aEi+doFOeMfmGwMHMCNazhzaj8S7+1YRhnoKGqnV+PjJShAt1f0D
HLA6hBvm0rk5dIWH0HZ0faKnbVeBPxE4+oD5ZOZbDrr3A7x1AY6vXKDhq0BuLLI/
eEFl2u2s+13tzNsqm176RXaKD656M8qgJ3+L+WU6yPfDgNiW+5etejcwd7i6Gl6y
S3+//ijKPFmv0npH/Pcnq3VuerE9KnA5COXDvKTJ5osiMaE6G6rzdNyvrywFNigV
HyikQgQg7QTFX2WeQdkCEkDj7ZQ9P0o83bnLgA6TJxDLJjaPaQXKm9XDNM7rfQSR
L9OsDbhJM2LdC3w75lz6hgRe7EVLpKT47SRIRtQj3j0qVyWgvZb4keLJVBjNMmic
IJ+c38ZgsQDUUfrT7ciqKWY964/1wZGEigJoBWr1qGrNhKPiAjndLDTSJaYGatx2
YFTBNhZhZS55ytn3mm9kZtgx2D8MR4gNbLK5SJbxMPNOWTneCiPDWIcdTN0jr6sL
uOkdb1abxVE4VyibUZ5OFycg/ijE49J0JBY3chXEHV+PMG9RC+s=
=sOb8
-----END PGP SIGNATURE-----

--iNB/FkNypOb1hr7K--

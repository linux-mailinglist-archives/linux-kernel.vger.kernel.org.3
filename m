Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FDF481756
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 23:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhL2WlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 17:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhL2WlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 17:41:03 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63154C061574;
        Wed, 29 Dec 2021 14:41:03 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l10so19607230pgm.7;
        Wed, 29 Dec 2021 14:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bL1lZKfE8z3GTVvoDSvP2R8hrBd+1V1j8NxcyL1gpvg=;
        b=RXl3wG9uxKojHAzbuT+ZBEyEfo9r12IiZYUoxHsic6aY1+6Vp8M0sIQ7dI0kmjKQwv
         4hxJBHIHI9N33VQPM+0qa0sP7hFE/Ek+VPUo5PLBPX6sGnSY2QcDBrzSX++WVqcs5+Lj
         QUCTSLQZPG0CU6JDgCYoRvVUAXDeErgnAOW5/lzjpe7cuGSnAQO/tnIS9CYzoEI8YcA+
         8nX5ivRQcyCRT1iP5lvYqExCqNa43dFmCX/3DAPL3KgCj3cx/Rr/Ld2AGMyLBZhrYvsb
         Rh58ek9PA4zAxgvaB3cJuO4WyH1ybbjCzy9xdQrwTbsYNb9nBFifvOoIFJ/PD9Zvqhbs
         Yhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bL1lZKfE8z3GTVvoDSvP2R8hrBd+1V1j8NxcyL1gpvg=;
        b=h3C9DGIh+V4uJ5yvKo6DqYuseYRKS/gRNFroC5+doMhCGIzWGBSqwp2ixhf06jGcN6
         Tl5SFQWXDEXI9npm+91/YigG8iezQaVF+6kCDMvucgXAi3fJLpewkx8K7J7fUJ2safU8
         qxKjfsKJfM9B3ZW7VAhfG9BhfHfRH/693G9jlRjHDP3iBLW7WHxRHGYvbTyUCfuIKypV
         RlTpiznin/BtvyK01JqB6j3j4v1NXzwXiDTRbZLKkUKcQbjzNU1oOPZY/0lgSUYvyVQe
         KFFEhivfAbo4Z1Yvva0KXMDtpl3jbKaPetkccdwShhJUR7hN9Vxx1QmRvB6STyJRQQma
         d+iA==
X-Gm-Message-State: AOAM532kg9JnP4tnRYUVN5cVtwhQXJrjzM3TQ5TNKDeK8sUUsLpn45CF
        y9kmAYdjQPVa3BHJOzBTrnU0baDRQUj8g+2q
X-Google-Smtp-Source: ABdhPJy2VTISeFhm+8YcwoTHs52VBSJc8VlSe+s9OsAa5nXpMsry17t/UUSh/OdFbhDokzoPjllhTw==
X-Received: by 2002:a63:700c:: with SMTP id l12mr6195083pgc.559.1640817662831;
        Wed, 29 Dec 2021 14:41:02 -0800 (PST)
Received: from shinobu (113x37x72x24.ap113.ftth.ucom.ne.jp. [113.37.72.24])
        by smtp.gmail.com with ESMTPSA id d21sm24434528pfu.52.2021.12.29.14.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 14:41:02 -0800 (PST)
Date:   Thu, 30 Dec 2021 07:40:55 +0900
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v2 05/23] counter: 104-quad-8: Convert to counter_priv()
 wrapper
Message-ID: <Yczj9yOVkm7MWqFs@shinobu>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-6-u.kleine-koenig@pengutronix.de>
 <YcwN5e7zjNLANT6d@shinobu>
 <20211229111522.eybtnyxabuwtf4r5@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Vtt6HtF41YDJriUB"
Content-Disposition: inline
In-Reply-To: <20211229111522.eybtnyxabuwtf4r5@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Vtt6HtF41YDJriUB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 29, 2021 at 12:15:22PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello William,
>=20
> On Wed, Dec 29, 2021 at 04:27:33PM +0900, William Breathitt Gray wrote:
> > On Mon, Dec 27, 2021 at 10:45:08AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > This is a straight forward conversion to the new counter_priv() wrapp=
er.
> > >=20
> > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > This patch results in a minor merge conflict with commit c95cc0d95702
> > ("counter: 104-quad-8: Fix persistent enabled events bug") in linux-next
> > due to context changes in quad8_events_configure() and
> > quad8_watch_validate(). Fixing this after a rebase is trivial so I'll
> > give my Ack here.
>=20
> this raises the question how this patch set is to be merged. My
> expectaion up to now was, that this goes via you, so the merge conflict
> shouldn't be an issue? What is your expectation who will pick up this
> series?
>=20
> Would a PR helpful, or will the series be picked up from the mailing
> list?
>=20
> I'm about to prepare a v3 adding all the review tags and fixing the few
> issues that were pointed out.
>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |

If Greg or Jonathan don't pick this series up from the mailing list
here, I can merge it to my personal tree and then submit it in the next
cycle with any other Counter subsystem changes that come in along the
way.

William Breathitt Gray

--Vtt6HtF41YDJriUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAmHM4+4ACgkQhvpINdm7
VJJpYhAAt4u3yijhlkgNd0f+r7zLqWVBwfCg/RLKRJZG1efzTB7OkDLdI6ZuE2lK
xxviUJYRktjfwcvpbAuVRVCQYwo/sDJrrXXbQUfeYfCAcHwULewaYERKtG5NlOFB
u+b/HoDvysCQ5M8TfNIKMEHoJUYGjRMxZxrBbojNOSqyLNV2LaSKMmVRQjXJ/5Bh
nr7UP9IBzl8PiIm8KMXn4Byp7G73z+7VqOnsHh0I+dFpETiOpl5orN+w7eSAgpP/
TGmh9ukKBmSAD5Gg9/pyoX3+7nmmbvR/NmWKjeIxnye/WEU1l/V5ixTGu5ustQWR
1AsgCqd2t66EPZZt0PMPh+TwIMqlMS5i9GWQUAPxROhAtTE+l227euSqOZbx07W4
enW/oU2SD24YRE1B2BNOPGuMkxMj1eDOEOVwMpOpflnt+BwH8n6IQ4uLggXN2ocG
ovU7b++lVb5JVegSnWZmIse+xluZgtIwKV9sp5lefE3epxqBOJER1CI/UJb8Auqj
XJq6i17GDDl+rEIUBFDbjsm2M3dqauHQDyIwEFlKUMDUAYRig4WqZkNftLugJt8P
mIORcihfe8GzQt3TtY8ilGS6VY0VlGsq28LHSYdQlI1mb+3DqG8E3RiOarPTkmDu
sRpK/lvrDvVQ3cXdlqWBeyrKeN68eWAbcgMo6uAdNcaQ3m7lWyo=
=UhDF
-----END PGP SIGNATURE-----

--Vtt6HtF41YDJriUB--

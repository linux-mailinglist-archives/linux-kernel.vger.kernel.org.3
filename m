Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C624A6DAF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 10:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiBBJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 04:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244541AbiBBJUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:20:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2D4C061714;
        Wed,  2 Feb 2022 01:20:00 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id u6so39252086lfm.10;
        Wed, 02 Feb 2022 01:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=i3bI40vwmRUOXQ/5yPC1vgbVQNyge9b1o2bXN5vtiy0=;
        b=bop666ZeVkePlwCxVAzz7iNSvscG9BYAY6BH7Pua4OxvqqucMwlMaWwLz+GDxeW6mJ
         wzrhImgUcWXnA9kTtdn4/Ca48zGz6WL1klu0tErPsEqJTdfmEauGsRSoMIhf22hQyBXP
         efQEpoQJJBZAGUv6jX7t2YG9hmponN+P9zO/2ELqULb1MadAGbdnGm2glPxjh2Lu/BSK
         vU/e7oug04F8cKFWbGVeahXyNvPLvUXDyIdw3dLH5A8bi8DH55NkNk/5sJGq/KRBgw6v
         Um64p6eDqrRSBQ5wi6r2+OYWzmxCMNd5IR1Jw1EISXbqu0G2JJ8yrO4Xdp8fufP/xskx
         ckvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=i3bI40vwmRUOXQ/5yPC1vgbVQNyge9b1o2bXN5vtiy0=;
        b=5UzNfzw/HkRr4q/OtlFkvVEfGt/NYQlPE7Rck+fZqhjya3Xee7G3fHPedrJaeavPhO
         voOVbe7NifPm1XhjkMxmKrLR2dGKF4dn9R3ZRszkClC0ILWJKl6x8dXxBIvZ16/Z+Nxn
         8HoEnhyFoH36B3aUSpiiCW+KIfL3AKEqSAhJ5AUxHrU0qRIH6pF+U0igPm+um6KH6DnV
         QfAubBjqKCX0DplOv/KCvVped7J+Y+ic+Nqr6aovuycNQftrvWHJzGK5lLVYhYPyvpZY
         hSM1ZxnbslnxufcbzW52n+tLM7Qp5sfhid/uFahflricv8yVqdZfUcROxo7wpAuzKi6c
         7roA==
X-Gm-Message-State: AOAM532eNpbyzQg+GWgjgOIw6F1RBzyUGz0zBsHZeTLyQxv1nZpvI4QQ
        38MxZHoBDwa3NLLAWMmJ1uU=
X-Google-Smtp-Source: ABdhPJyvkUDp2Sj5MAQ/FWWvGJdlwySOdTfRtRXyMiuB52dnyzbGpN7Fta6vvTeF+uAFpb3Vy7DldQ==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr21770588lfg.219.1643793598385;
        Wed, 02 Feb 2022 01:19:58 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id m10sm4455747lfk.119.2022.02.02.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:19:58 -0800 (PST)
Date:   Wed, 2 Feb 2022 11:19:54 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Simon Ser <contact@emersion.fr>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <20220202111954.6ee9a10c@eldfell>
In-Reply-To: <CAMuHMdX_uyEznHy5vYwS8Q=+bBKPddeJa41KTWi4Fwh3tjX+zQ@mail.gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
        <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
        <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
        <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
        <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
        <CAKMK7uGPuhrDf8fdDgfuPt5rzO30Rm54T7GvWb203NRbVoVDgw@mail.gmail.com>
        <b0788b3d-9c77-0e96-0969-380d21663909@redhat.com>
        <20220201124208.39c31e59@eldfell>
        <CAMuHMdX_uyEznHy5vYwS8Q=+bBKPddeJa41KTWi4Fwh3tjX+zQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TjcVZakJniwKJRBiAnOmgzx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TjcVZakJniwKJRBiAnOmgzx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Feb 2022 12:07:07 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Pekka,
>=20
> On Tue, Feb 1, 2022 at 11:42 AM Pekka Paalanen <ppaalanen@gmail.com> wrot=
e:
> > On Tue, 1 Feb 2022 10:49:03 +0100
> > Javier Martinez Canillas <javierm@redhat.com> wrote: =20
> > > On 2/1/22 09:38, Daniel Vetter wrote: =20
> > > > On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrot=
e: =20
> > > >> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert=
@linux-m68k.org> wrote: =20
> > > >>> What's the story with the Rn formats?
> > > >>>
> > > >>> The comments say "n bpp Red", while this is a monochrome (even
> > > >>> inverted) display? =20
> > > >>
> > > >> I don't think the color matters that much. "Red" was picked just b=
ecause it was
> > > >> an arbitrary color, to make the difference with e.g. C8. Or am I m=
istaken? =20
> > > >
> > > > The red comes from gl, where with shaders it really doesn't matter
> > > > what meaning you attach to channels, but really just how many you
> > > > have. So 2-channel formats are called RxGx, 3-channel RxGxBx,
> > > > 4-channel RxGxBxAx and single-channel Rx. And we use drm_fourcc for
> > > > interop in general, hence why these exist.
> > > >
> > > > We should probably make a comment that this really isn't a red chan=
nel
> > > > when used for display it's a greyscale/intensity format. Aside from
> > > > that documentation gap I think reusing Rx formats for
> > > > greyscale/intensity for display makes perfect sense.
> > > > -Daniel =20
> > >
> > > To sump up the conversation in the #dri-devel channel, these drivers
> > > should support the following formats:
> > >
> > > 1) Dx (Daniel suggested that for darkness, but inverted mono) =20
> >
> > Did you consider format C1 instead? =20
>=20
> That would be a 2-color display, which is not necessarily black
> and white. Cfr. Amiga or Atari bit planes with bpp=3D1.
> That's why fbdev has separate visuals for monochrome.

Yes, that is exactly what I was aiming at: to draft a plan for panels
that have a fixed and arbitrary palette. From the discussions I
understood that the panel in question here requires somehow reversed
colors ("inverted mono"), which didn't really sound to be like "normal
monochrome".

> > I have no idea how this would map to fbdev API though. =20
>=20
>     #define FB_VISUAL_MONO01                0       /* Monochr.
> 1=3DBlack 0=3DWhite */
>     #define FB_VISUAL_MONO10                1       /* Monochr.
> 1=3DWhite 0=3DBlack */
>     #define FB_VISUAL_TRUECOLOR             2       /* True color   */
>=20
> The above is RGB (or grayscale, see below).
>=20
>     #define FB_VISUAL_PSEUDOCOLOR           3       /* Pseudo color
> (like atari) */
>=20
> Palette
>=20
>     #define FB_VISUAL_DIRECTCOLOR           4       /* Direct color */
>=20
> Usually used as RGB with gamma correction, but the actual hardware
> is more flexible.
>=20
>     #define FB_VISUAL_STATIC_PSEUDOCOLOR    5       /* Pseudo color reado=
nly */
>=20
> Fixed palette
>=20
> And:
>=20
>     struct fb_var_screeninfo {
>             ...
>             __u32 grayscale;                /* 0 =3D color, 1 =3D graysca=
le,    */

DRM has pixel formats, but no visuals so far. Maybe it needs to grow
the concept of visuals in some form? However, care should be taken to
not clash with existing colorimetry features. I would hope that the
colorimetry feature set could be extended to cover the above as well.
Well, only if there would be any users for it.

My silly attempt with Cx formats (e.g. DRM_FORMAT_C8) was a stab in that
direction, but maybe not flexible enough for the above.

If on the other hand the panel is "grayscale" but with an arbitrary
color (white, green, orange or other on black), the IRC consensus seems
to be that one should use Rx formats (e.g. DRM_FORMAT_R8) for it,
regardless of the actual color. That would convey that the pixel value
has a monotonic (increasing) mapping to brightness, unlike with
paletted formats. I agree with this, but wonder how reversed brightness
should be dealt with - or just have the driver invert the pixel values
before sending them to display?

Cx formats with a read-only palette could be used to represent
"grayscale" and "reversed grayscale" too, but people seem to think that
is too complicated to analyse and use for KMS userspace.

Other #dri-devel IRC mumblings were about maybe adding a DRM pixel
format for grayscale or intensity or luminance so that one would not
need to use "red" color channel for something that doesn't look red.
That is, do not use Cx formats because those produce completely
arbitrary colors, and do not use Rx formats because the display is not
redscale. Personally I'd be fine with Rx formats.


Thanks,
pq

--Sig_/TjcVZakJniwKJRBiAnOmgzx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmH6TLoACgkQI1/ltBGq
qqekGQ/+Ks4uYS99DrsJhQBLzuFgiXUFSHH47XE5z/Hzo6GBRNxPRdut+JR4Vtf7
lkm78vXqRfjJ/c1RE7WBlsdtfgeuOQXOLPWbBSk9eVfakspywcQ/QFFxT/2nH4Sy
dFdAoFy7esX2KkKmtg8QoQBfS9XjWvqcetBqu5p6mcJGpHSMhynVsY+exWV7636W
4VJLlTdKYIg+hv67Ndc54ovi63uncyhZ2fNkVkdcdc4kvmvE2fI0aWdxDB4HW1hK
ZZtWMksvm2Wn8FOuNn9/H7/pUlHYc+8FdjafnLwooy1cYdV//mOuVmLhcjxxp7Pz
dLfWBnRyf2IJEi7hxvdLM+wZdESEkFrdIa1xQ1qb46xPmyCOgOeZEX8GtcN1r0ol
cuabTfs5BcGTl9Vf22XUSssducV+pNS9nW5YAraJH0V6DL7x1+4s+Sa6C60COK4T
/05Zv7JxUpyaK8iu/vRl2oa3zQGrzFxGV68Rw3R5U/EevRpuqgKWvwmYE+Aahkjl
HwGwf5BlIUyUF+GtG3HhUGNHIWCIhTg4Q143Rr4GPjdrHMs2QeBvZ1Lc2L2j7ilX
5HD1LvPcKRcO9QTkQToXeK/LI6fTlGDgxLHbLkb5cVdQIQfHzaM/mnIw9gsolcTT
WTXX/oDlDG2mlAwPCCwctWGdm7Au1B7XtCdESpXkST/BWlMoHfg=
=e/GB
-----END PGP SIGNATURE-----

--Sig_/TjcVZakJniwKJRBiAnOmgzx--

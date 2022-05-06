Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BB351CEC3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387762AbiEFBJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEFBJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:09:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EA825C61;
        Thu,  5 May 2022 18:05:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvXS13JQfz4x7V;
        Fri,  6 May 2022 11:05:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651799137;
        bh=wJ89nCnpERmW1YfiR7PVKkGj17pYMLzirbJ4W1FJCms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rNt4YQRS+bCh1NzVaXqmi6FO4RnswoXhM2yza9WfSbxj3fv5pBaAg0gOsOP98wCk+
         UCX5iWF/NH61mEHFhoV3Xndidbz4HmwuyJRXqqc8hDpbescj5S/EapslRhb4rTDsob
         V0xrFjKrI4L06/yQb7Ko7Pi1AlGKd0E5gLYU88EG+2W7JxVRGXQtUh/uhujRQcgK0R
         DDeYf/ulALqfLEHi8C6gT6rkkTUPZGEH9UB/O2KY5XHda8sLwi0x9durlnErI6H/gy
         1gzMHac2zd+NgsQyhshhaxhYW5TKgq9Ho7yc+H/ID0O4XpXmShcsWTECI97vdba8DQ
         UpWKe1liLZDmA==
Date:   Fri, 6 May 2022 11:05:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220506110536.2dd76d22@canb.auug.org.au>
In-Reply-To: <CADnq5_Ma_4zWHnqjrii97niJ3pvUnUeWDi6EyFt3z5cR=7cXzA@mail.gmail.com>
References: <20220505194717.065db7ab@canb.auug.org.au>
        <YnQToaOno0MZzJ5r@dev-arch.thelio-3990X>
        <CADnq5_Ma_4zWHnqjrii97niJ3pvUnUeWDi6EyFt3z5cR=7cXzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C19o9.xD7PvLJX+FrXQ8RY3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C19o9.xD7PvLJX+FrXQ8RY3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 5 May 2022 14:46:25 -0400 Alex Deucher <alexdeucher@gmail.com> wrot=
e:
>
> On Thu, May 5, 2022 at 2:12 PM Nathan Chancellor <nathan@kernel.org> wrot=
e:
> >
> > This fixup makes CONFIG_DRM_AMDGPU unselectable on any architecture that
> > does not have CONFIG_CPU_LITTLE_ENDIAN, such as x86_64. I was rather
> > surprised when my AMD test system did not reach the login screen and
> > there were no error messages in dmesg, only to find that
> > CONFIG_DRM_AMDGPU had disappeared from my build.
> >
> > If this is not fixed by the time you do next-20220506, would you
> > consider swapping the logic like so? This should allow all implicitly
> > little endian architectures to work (at least, I tested it with x86_64),
> > while preventing errors for CONFIG_CPU_BIG_ENDIAN configurations. =20
>=20
> This is fixed.  Will push out a new branch shortly.
>=20
> >
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 2aaa9ef1168d..a57843733a96 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -244,7 +244,7 @@ source "drivers/gpu/drm/radeon/Kconfig"
> >  config DRM_AMDGPU
> >         tristate "AMD GPU"
> >         depends on DRM && PCI && MMU
> > -       depends on CPU_LITTLE_ENDIAN
> > +       depends on !CPU_BIG_ENDIAN
> >         select FW_LOADER
> >         select DRM_DISPLAY_DP_HELPER
> >         select DRM_DISPLAY_HDMI_HELPER =20

Since today's amdgpu tree is broken, I have used the above with
yesterday's tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/C19o9.xD7PvLJX+FrXQ8RY3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0dGAACgkQAVBC80lX
0GyOygf/YwfXGwiME67/MLQ0YPLb3ZLCFTmpFyycG3L75rf5C4wW8OcJ5ZZ5hrY7
5mtieIOQaGVW8Oepi7VY5UJZIGqmIII3vmFXDGVnd6tJJVAXdeYJCQixWizuv4Pf
y4pKZgh/wQot2fnigge/GkvHm2Q0/x4lANe8YPF1t5QojULi7hDpjirKDvSjlf8P
SbqajUKBM+IIGl8JCEvnLcCFY7Kps4nSoIWF3cv2E8RGHqjqCzjWSe6ejcxKoD6V
josGqGiW9QuqO7RhK5nxh3s4b8lJUdN4GgQyOIygWVauMUfYFFVyjjB98CBO9GJM
P4N3xz0i1trQQXhp2d0VqAGJ6kLQpQ==
=AOtX
-----END PGP SIGNATURE-----

--Sig_/C19o9.xD7PvLJX+FrXQ8RY3--

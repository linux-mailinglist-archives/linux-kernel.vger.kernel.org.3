Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6C4A2C29
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiA2GjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:39:06 -0500
Received: from www.zeus03.de ([194.117.254.33]:59938 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbiA2GjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Dja6htFOHSLuxcH15iAURADMtQRz
        t7/bYoOfVYKbpvQ=; b=rSplA0hs6qX8Pvq2Bqyz4RIroxiIZfaJ9G+2DxyGcsQG
        5s43dcMIZD7Zw9obz/YImxdMqMMZZf2yNhX01LY1+YEcFM5nyzy3NZ1eYUDAVHq3
        +/MpAgOzIj/xpHhQ9UBmEK8PL8fHOe+swJ1wrJEpmSWzCtnLWFGe9WHQwnJZ8fA=
Received: (qmail 511667 invoked from network); 29 Jan 2022 07:39:00 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Jan 2022 07:39:00 +0100
X-UD-Smtp-Session: l3s3148p1@sh9MzrLWDLO8ahEL
Date:   Sat, 29 Jan 2022 07:38:56 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Krzysztof Adamski <krzysztof.adamski@nokia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: move efi_reboot to restart handler
Message-ID: <YfThAF9U1DJx0Hja@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Matija Glavinic-Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <YfP0osb45uJldtM9@localhost.localdomain>
 <YfREAiRMjQ9ci4LC@shikoro>
 <YfRu86YoiFpVsqyn@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GKPNAMI1pCuG617p"
Content-Disposition: inline
In-Reply-To: <YfRu86YoiFpVsqyn@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GKPNAMI1pCuG617p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,
> I would use something like 250, or even 254, just to indicate that we
> know that most certainly nothing should be run before efi_reboot(), but
> still allow those silly people like me, to do what they want in their
> system, without the need to run the custom kernel. I think we could even
> add a proper comment, so it woudld become something like:
>=20
> /**
>  * If you are running UEFI based system, you most certainly should let
>  * efi_reboot() do a reset for you. If you think you know better, we
>  * leave you a window of opportunity here by not using maximal priorty
>  * here.
>  */
>  .priority =3D 250,

For your patchset, this seems good enough for me because it is decoupled
=66rom PSCI now. I still think a set of defines should be collected in
linux/reboot.h so they can be used in reboot handlers. This is a
different patch series, though.

> What is the downside of doing that? That we will run through atomic
> notfier chain instead of calling efi_reboot directly? Sure this is
> slightly more complicated but it works on all our platforms and is
> battle proven and we don't worry about that there. And the upside is
> that we give people possibility to use their beloved mechanism if they
> really like to. Because flexibility is a good thing.

I agree with the upside having more value than the downside.

Happy hacking,

   Wolfram


--GKPNAMI1pCuG617p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmH04PwACgkQFA3kzBSg
KbbUiw/+MH+ukDJlxKm1Hgf2mziYmP4CxKyEoAv+6iDgOr/7USa/rOtBKIjFlLpw
JHHCSkbtLI8HQdxRy45T44wP5CZ6eMFnF2bAN2/pvSDVViz3DUqeAMQZ3C1GxUys
WJ4Gx+Xxyyk9ZXApkN+X42NtbIJWxs2wyGmDTq6lGkOjZ5VpdjGdHVv1i8YUMaTN
B7dS2o7c3Y5IlK/7BCPqrpwqdoNDVJCaaFy1xczFBa9iU3PYRDNczfOR+CItscE2
JaRzIbQF10a5eM+j84OWYNK6K4qOBsad64yz+6xEpmVGh+XU9E5hVdPTbSY9lGc9
HjtvIVmeSyz59JSgrga6iItzTPHIZOcNOeD8foe6YRgVZaCzE/jWM3bh4fkKj6+I
5YrOuYFdg1QH3B6a6WljP+x85mfnVCbJ52mzYEyrJ4HGg/GIbWu81ySVMM7TX9zo
Dw652+S9iAw8C4U7LH+2diE4wh/9qQgqPqEaQ8mDlyJgqBxgzTyy0tO2GJcBYcPJ
IHbsc1pWCFlNN6bFtbfcJUU0ZgCBB9sWO+wsDg2Dt2akQbHOFg7OFwdqhPgKmMGy
nOl3Jaa683bdY1v+zzUHq3mJMNhVnEqEM5N1AlSF5dMiowRyV4/02dthJxPCENX7
tXTqqFTFH1RDbBXtHGdrJINMhiu4Pz+B9r2cY2fFQEzOZmTe1uY=
=fL8U
-----END PGP SIGNATURE-----

--GKPNAMI1pCuG617p--

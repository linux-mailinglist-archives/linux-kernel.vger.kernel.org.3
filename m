Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314E657D8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiGVCwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiGVCwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:52:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5BA98201;
        Thu, 21 Jul 2022 19:52:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lpv9T5FMwz4x7X;
        Fri, 22 Jul 2022 12:52:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658458333;
        bh=nYihNt+NelT1izzjXR5iJdDE3j5yqhhTu7Dvm/iFMeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CSRK389QJr80OXc63mvxAeBStUyqTfaIpgvMvf8fZe4Y90fSmP1HUU9aDi4/SgkDv
         pMNcp0n8lUVpAaaaeHNseZsSqTMnXU3uT8eyLv8/JSbCEn2zYHAdg39sf5UPjIBpU7
         +On/3+dY5lw7PX/1ebfoa2q+7hGwPUfLiWenOh0Cj3DvPZCle8xnRs6VFjuBJoyri5
         6bGibBKsGgImXudSgYf3kgiyADnWcKt7H7G0ZygUkqmV2gYbRHzuNKHXkBb7WAqDhI
         QjqJACcMZ0YK4pxWhsalYjRjWta6tJ+fpg6NhAJDcFif5fBm7WCS04ozgHVFBlk0jv
         7jgfORduiz/+Q==
Date:   Fri, 22 Jul 2022 12:52:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220722125212.2af3601f@canb.auug.org.au>
In-Reply-To: <20220721121618.049b9c00@canb.auug.org.au>
References: <20220719123607.63cbb3c5@canb.auug.org.au>
        <20220720124732.4aeb3748@canb.auug.org.au>
        <20220721121618.049b9c00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NP/Ofe+VdNgQVCiX/k4m2Tu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NP/Ofe+VdNgQVCiX/k4m2Tu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Jul 2022 12:16:18 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> On Wed, 20 Jul 2022 12:47:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >  =20
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_3=
2.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_3=
2.c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [=
-Werror=3Dframe-larger-than=3D]
> > >  3799 | } // ModeSupportAndSystemConfigurationFull
> > >       | ^   =20
> >=20
> > This is still here, but the frame size is down to 2336. =20
>=20
> Today it is down to 2128.

And today we are back up to 2152.  I can only imagine that maybe things
are being inlined?

My compiler (in case it matters):

$ x86_64-linux-gnu-gcc --version
x86_64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0

--=20
Cheers,
Stephen Rothwell

--Sig_/NP/Ofe+VdNgQVCiX/k4m2Tu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLaENwACgkQAVBC80lX
0GzfYgf+NvDue/RQTedFHbyjc/uAnLRpQP82QEAm9O11k9o+O2mvx4rSnmh5SDec
uSu+RSS5pw3Jd2O0lmLq/FJUd9uym/Y6tO3YT6x0sWD1h0ZOXpYfLW8rBd+LDTmb
ao87KYl8g8t4T6mSOIhApvsKB2GUei8Uf9+1FosmEfB/CUA+KyiHW49jI/nQ3f2o
HmgE3X3S/dw5btRYik0YfaYefEwmaQ6+TnSpoD+KLwSfhzCuNt8lbUSY/UHO3ty7
2GRKgtsSdgGoigBBQubMZnJ/dPMpTyS1UjsBXrW0GTuiSHnz44PKPKeXHM/NVRAo
pzvUHRA3yYN1JJqyH2BalZCpsN8IYg==
=Ochr
-----END PGP SIGNATURE-----

--Sig_/NP/Ofe+VdNgQVCiX/k4m2Tu--

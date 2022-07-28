Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA25836B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiG1CLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiG1CLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:11:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A195A3E0;
        Wed, 27 Jul 2022 19:11:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LtYzM1Hrhz4x1S;
        Thu, 28 Jul 2022 12:11:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658974272;
        bh=6O6/rqSJEj1f964QR+2xiWyKfoEJUsDxH/8FzuSmliY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hXmfrgkvp+XjkjP8rdcGoEBfVSTBp4ZY1yylGzESPK7v0dvsw/wm7VlnQJmfsMdX+
         87wnAaKIVYlnwEiExK/7Jr+ku9EjI7wVdXricyfLi+ZOAV3h7AnOHGY0kaAf6/1Mh5
         TzpcxVdLS2elc9zzx4SGd1/4pIeZp3vmGkOi5S+9orScB8/11bZuyADAOZlflhU6rl
         xyHQwYZi8vo1YoZL7NWd2YBSztSfp2ivkpjSFXwXHmjNc5Oph48bzUOHBkRZheG6RU
         QOFtafrO2uUrDgmB649tBTnahOaoJLZTi4fPvKQ3QIiDuT52iF5hXV/Vxo330FjzgB
         kEuZ7jAfwa5hg==
Date:   Thu, 28 Jul 2022 12:11:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu and
 powerpc-fixes trees
Message-ID: <20220728121109.0cf6cb51@canb.auug.org.au>
In-Reply-To: <87leseabci.fsf@mpe.ellerman.id.au>
References: <20220726205458.0b5ca446@canb.auug.org.au>
        <87leseabci.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bWz3G.CxO+f3lnQtrE/mONw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bWz3G.CxO+f3lnQtrE/mONw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 28 Jul 2022 00:17:49 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > ld: drivers/gpu/drm/amd/display/dc/dml/display_mode_lib.o uses hard flo=
at, drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.o uses soft float
> > ld: failed to merge target specific data of file drivers/gpu/drm/amd/di=
splay/dc/dcn30/dcn30_optc.o
> >
> > I have reverted commit
> >
> >   c653c591789b ("drm/amdgpu: Re-enable DCN for 64-bit powerpc")
> >
> > for today. =20
>=20
> It bisects to:
>=20
>   40b31e5355ba ("drm/amd/display: Remove FPU flags from DCN30 Makefile")
>=20
> So I guess there's still some float code in dcn30?

I have reverted commit 40b31e5355ba from the merge of the drm tree today (s=
ince
it has been merged in there) instead of commit c653c591789b.

--=20
Cheers,
Stephen Rothwell

--Sig_/bWz3G.CxO+f3lnQtrE/mONw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLh8D4ACgkQAVBC80lX
0Gyppwf43NYAZ8NC3GRODxhT4uDmUsOTDyWGJXbPSAIDFaoNTFsxiNZiUyLCoUjG
Bqbl1djk0WDY9mat8aDmp8YqSNHH93JFl7YnT7i5X8hS/jzcQYbgeNrkymGDBURX
seTEhQDtKIU+nomYV0iiJikqEO5HNWjICR1MG4RAYSLwRVf+hJJG7eyVkXHXHw+o
LhBHFtCAhKj/Mz3sPf64zlRsGQ85MZraqb0JK0U9bsPAPapXJa9X3WXI2URWr9Y/
U259nlSB+qdvLA/dmhsbuLAnL3yudhyHuzPYHPLcNrMltfKY+soy5wOskXSr0xWY
Q9RxHybQvA6+3DWrsjgyrYaZym1r
=URjw
-----END PGP SIGNATURE-----

--Sig_/bWz3G.CxO+f3lnQtrE/mONw--

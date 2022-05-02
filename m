Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A13516963
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356799AbiEBCVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245558AbiEBCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:21:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5707D3F329;
        Sun,  1 May 2022 19:17:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks6Dx3Lcgz4xdK;
        Mon,  2 May 2022 12:17:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651457857;
        bh=oCHuLM+Twa0KW/0Rao6m39tBwQtrdlow9N7TrfkpjXE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tnyavbJvW4POG27Bdr15ta+J2JmVfXPoNca+16LvXJfl8qIWIDXB8poB+pYsYdCvO
         dG1CDj0482t/8IPcizBt7ETI6I3La9me8cyqtM3SQnF9oNJYmOMtG8SsZBIjygKYrQ
         XG+0k4e9/tG7RQJY/rABNGrujvHMcKOX59UwRKPuzHG29dIhpdgwCSzKTP2KY0tTBU
         /0JaiJ2BZyje8Gl2YsXU75k0G9He8mkw9ZtPOsN+PFDs+TVUlLcanEaYPIX9XZSTlC
         iGMGSI852EqMMf2uiw0OZcHKWZwd2qgxew1rNfju7DLuxzRTvqq9ef9UW+8GDz6iC8
         zInWP0ynU/QVQ==
Date:   Mon, 2 May 2022 12:17:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the input tree
Message-ID: <20220502121736.57b06150@canb.auug.org.au>
In-Reply-To: <20220427104825.15a04680@canb.auug.org.au>
References: <20220427104825.15a04680@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cqmxetHSojN.V3L2ZDJqX0i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cqmxetHSojN.V3L2ZDJqX0i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 27 Apr 2022 10:48:25 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the input tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/input/keyboard/mtk-pmic-keys.c:93:36: error: 'MT6359_TOPSTATUS' u=
ndeclared here (not in a function); did you mean 'MT6358_TOPSTATUS'?
>    93 |                 MTK_PMIC_KEYS_REGS(MT6359_TOPSTATUS,
>       |                                    ^~~~~~~~~~~~~~~~
> drivers/input/keyboard/mtk-pmic-keys.c:48:35: note: in definition of macr=
o 'MTK_PMIC_KEYS_REGS'
>    48 |         .deb_reg                =3D _deb_reg,             \
>       |                                   ^~~~~~~~
> drivers/input/keyboard/mtk-pmic-keys.c:98:25: error: 'MT6359_TOP_RST_MISC=
' undeclared here (not in a function); did you mean 'MT6358_TOP_RST_MISC'?
>    98 |         .pmic_rst_reg =3D MT6359_TOP_RST_MISC,
>       |                         ^~~~~~~~~~~~~~~~~~~
>       |                         MT6358_TOP_RST_MISC
>=20
> Caused by commit
>=20
>   0f97adf64314 ("Input: mtk-pmic-keys - add support for MT6359")
>=20
> I have used the input tree from next-20220426 for today.

I am still getting this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/cqmxetHSojN.V3L2ZDJqX0i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvP0AACgkQAVBC80lX
0Gz/2Qf/Xi4WxgKu9cc10EF+dNPgIaCJek+cf0oj4Z022oAwlaokU+0PAZVoxfYZ
wh71IqYPglhmfVXDVZ2+3tDRxBmyk0fzj3NgQ4dQVhfPyyMvai8nNw+dljBhPguZ
8O4xV0RrQessuaDERPgRa8l26sU8ohdmHxhllbJkxQN5kfMJhkDDqa2Y5Tom40D7
YgI6J/1dQHLVhi0F78Eu0WAm29v8W900i1QtJByVsjiq9FCk2if/nPphxcg2oVtx
2IuMtqE3afE8vbt0304vNupva7gHUQk3WK4nxamyu7NzUrAuVl+HNwtPTXx5o6BQ
Ai60k7YIGPYGufo6d+9rjAgp2wYVbg==
=4grN
-----END PGP SIGNATURE-----

--Sig_/cqmxetHSojN.V3L2ZDJqX0i--

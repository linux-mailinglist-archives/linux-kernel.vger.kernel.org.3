Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5FF55128E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbiFTIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiFTIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:21:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC9B12086;
        Mon, 20 Jun 2022 01:21:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRMzp47Qxz4xZB;
        Mon, 20 Jun 2022 18:21:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655713271;
        bh=GmWBIOzwoR1yaR0PSMTUHraxjWmZ6HJsMb8gd6IVL70=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B0oZPUKohoUw9Mqq/TaIfGBKEjN7Z2zxXcGPQ9pWigwrxTmnNyIjKpv+2XDeXnkcn
         bWi+DMtanTkqmtNCLNTJ71OAhPCkAPAmKXnaIWoMO3aKQTBArd2y2hFzcykY6ghAoU
         dwt3ljtZwa0dYu5IqwHT6zg5yEWdhNG9InNmo/3pnMaB06wOKB1yuTUufE6MGplqnq
         7qBmYIaP4pCuyFA2jd0I5Rn20dprVX1SGkfTb3fN3+AQCGDg9AbcmfDGaD2nOxIxc3
         kVi0XGP/joPANvIr/gpQWSRXQEH6lMvX+aKBXIkziDc2jkYuKn94Cb/WQip3DBqobJ
         CfA+1jC6GS7fA==
Date:   Mon, 20 Jun 2022 18:21:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the libata tree
Message-ID: <20220620182108.5efb3107@canb.auug.org.au>
In-Reply-To: <20220620103400.6b03f8d9@canb.auug.org.au>
References: <20220620103400.6b03f8d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XO/KDNfh3p1WO2yhElHs/1q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XO/KDNfh3p1WO2yhElHs/1q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Jun 2022 10:34:00 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi all,
>=20
> After merging the libata tree, today's linux-next build (powercp
> ppc64_defconfig) produced this warning:
>=20
> In file included from include/linux/device.h:15,
>                  from arch/powerpc/include/asm/io.h:27,
>                  from include/linux/io.h:13,
>                  from include/linux/irq.h:20,
>                  from arch/powerpc/include/asm/hardirq.h:6,
>                  from include/linux/hardirq.h:11,
>                  from include/linux/highmem.h:11,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/ata/pata_macio.c:18:
> drivers/ata/pata_macio.c: In function 'pmac_macio_calc_timing_masks':
> drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument =
of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wform=
at=3D]
>  1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%=
lx, UDMA=3D%lx\n",

	.
	.
	.

> Introduced by commit
>=20
>   f0a6d77b351c ("ata: make transfer mode masks *unsigned int*")

This turned into a build failure in my powerpc allyesconfig build, so I
reverted the above commit for today.
--=20
Cheers,
Stephen Rothwell

--Sig_/XO/KDNfh3p1WO2yhElHs/1q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKwLfQACgkQAVBC80lX
0GwTBgf/Zi+BLOsoWaXA44le72TXra975gKnDm9VsaDqCloxedC4GgVmCFPQfaa4
GBGya2rXJN5msVNV3bnUnq+Yt9zlG8KI8afTofCqIj+5CEA7dR/gYtZWY2jBv+cc
beFmGr7KsmTcwbCscjV/ToH+ShAO7teE+N8wrAkHFlylraeF3Pb+whpFk7AUiu3X
dWL329TadKIlE5lrLvPOPzwNogRw7Hn5y22m/i/OxfMnvkgRsJRPkTHNiQ0QV8XT
5lEqwwT0ontYhps+BIoyTqDJ5/EdQEUm8BEN/hlG15lg4Zpkez1n7DmhEmhMYGfG
fu+aqrQAJacyzHPFWwMvoGkFpErluA==
=7C44
-----END PGP SIGNATURE-----

--Sig_/XO/KDNfh3p1WO2yhElHs/1q--

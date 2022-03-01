Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E914C9883
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 23:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbiCAWvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 17:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiCAWu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 17:50:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5D28F619;
        Tue,  1 Mar 2022 14:50:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7XWj5blNz4xRC;
        Wed,  2 Mar 2022 09:50:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646175012;
        bh=pRkJ4ZgaktZWojtIugGU4i1sEmMMD3CkWCHluM7Sbmo=;
        h=Date:From:To:Cc:Subject:From;
        b=mt59L2xQzgN6Se7eeXRBHerDc9GYuvaWnXJUSvz2DXVoIAHAmk+qTh1UhSXHHP8ga
         dTrMko3SVMMgxaWUcFmzOwloUHNSAL1P+k1CQrIBaoBcxOMbxvwuPvmemgqdl6W42U
         VQup3GDqgGWaOgijIaUoHbhWN0z+JLKn95S3mpwxn4lGKGRGk1mL69iLSPfykfm4Gj
         w0UtxGBN2erJ3zI05tMOwSLYnjlKSoCWrXZ9EqCvFC3bbFauFocXiNirgRiyri9Z6r
         VvlCDVceo8J9Ncm2VPn8dl7OW9AhCzDmj5kqYK/6M1zon/c8ac7ZmIRAPu0wKeJsgD
         wUEl4eFLWxKvw==
Date:   Wed, 2 Mar 2022 09:50:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20220302095008.27b6c6a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/57HT5Sb4bRnYTn6t6/28_PZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/57HT5Sb4bRnYTn6t6/28_PZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/soc/mediatek/mtk-mmsys.c:64:10: error: 'const struct mtk_mmsys_driv=
er_data' has no member named 'sw0_rst_offset'
   64 |         .sw0_rst_offset =3D MT8186_MMSYS_SW0_RST_B,
      |          ^~~~~~~~~~~~~~
In file included from drivers/soc/mediatek/mtk-mmsys.c:18:
drivers/soc/mediatek/mt8186-mmsys.h:55:57: warning: excess elements in stru=
ct initializer
   55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
      |                                                         ^~~~~
drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186=
_MMSYS_SW0_RST_B'
   64 |         .sw0_rst_offset =3D MT8186_MMSYS_SW0_RST_B,
      |                           ^~~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mt8186-mmsys.h:55:57: note: (near initialization for '=
mt8186_mmsys_driver_data')
   55 | #define MT8186_MMSYS_SW0_RST_B                          0x160
      |                                                         ^~~~~
drivers/soc/mediatek/mtk-mmsys.c:64:27: note: in expansion of macro 'MT8186=
_MMSYS_SW0_RST_B'
   64 |         .sw0_rst_offset =3D MT8186_MMSYS_SW0_RST_B,
      |                           ^~~~~~~~~~~~~~~~~~~~~~

Caused by commit

  831785f0e5b9 ("soc: mediatek: mmsys: add mmsys reset control for MT8186")

I have used the arm-soc tree from next-20220301 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/57HT5Sb4bRnYTn6t6/28_PZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIeoyAACgkQAVBC80lX
0GxGQAf/caPC6eFgeGTSyuZgClviuaMY3Qu/xIb9MVFXvA5HQrV6V2GMURFVMPMY
3yLZzDWfDydILWFPrVObbRB8wUFy3W9yHeL5OtIz83WGpgmZm/rkJfWXHNLFbtiQ
qdchNbi1m2SR0RVRWDYfda6ZaH+XMgkqu3Ft+Fk7gBascyiagO9z2uroqm+YvNpy
0gS3t5ZxS1oCg2Iper20lrSUCbTXnspSZl/iRHmktSdgMLhtAe59R2viNYBeu5te
y8ceClu52VG8uJUY8I2ABCAQ9tnyRYiNkNso2JX1ek4+S6yPhTW46uQPDb2CdXPv
Je102w5cvkmajVvqK9zh1noyr8uGuQ==
=V+DM
-----END PGP SIGNATURE-----

--Sig_/57HT5Sb4bRnYTn6t6/28_PZ--

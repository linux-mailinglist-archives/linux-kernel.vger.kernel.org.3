Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092DC5A57BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH2Xmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2Xmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:42:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B0B832DE;
        Mon, 29 Aug 2022 16:42:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGn6v2FWSz4xFv;
        Tue, 30 Aug 2022 09:42:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661816567;
        bh=eS2NUppRYcx/Qav//pzH5RKfexvonoglAigO/qZeDFg=;
        h=Date:From:To:Cc:Subject:From;
        b=CV80bENd61839LszQIEWwJ3Nug9Tn+Sj49ppyYRuDziHIizMy4MIyqmFgXHHuA6l8
         U1Vk8nHvtNb1JHxkwNA+dhmWG140Wu4+ds8DFtKniQow9aVGVHpY+brNum3O26SO08
         jZqgjUpIuEeXzOfI/xjs2GGVV0zXYVoDrXi+Z5ZVB19P9Ojv9TzTa3qE2HZ7CsUSdq
         sSQfKBz2JalCoMRdWgR9r6PIyMtRpsDguiYKNJ7dt0YPqzQJKay8YE3bTabHAFnPZ4
         7Ff7lOEY/zm+yJ2imp378tnuiX/UMIYsJWAI0q/98WrcmLoicYzVycoHwT5nBfCO1s
         j+pphnQJ4JZvg==
Date:   Tue, 30 Aug 2022 09:42:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        " =?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mediatek tree
Message-ID: <20220830094230.18c76615@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YQosNvvXEXip9TFwjxJXq.x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YQosNvvXEXip9TFwjxJXq.x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mediatek tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/soc/mediatek/mtk-svs.c: In function 'svs_get_bank_volts_v3':
drivers/soc/mediatek/mtk-svs.c:887:47: error: implicit declaration of funct=
ion 'FIELD_GET'; did you mean 'FOLL_GET'? [-Werror=3Dimplicit-function-decl=
aration]
  887 |                         svsb->volt[turn_pt] =3D FIELD_GET(SVSB_VOPS=
_FLD_VOP0_4, vop30);
      |                                               ^~~~~~~~~
      |                                               FOLL_GET
drivers/soc/mediatek/mtk-svs.c: In function 'svs_set_bank_freq_pct_v2':
drivers/soc/mediatek/mtk-svs.c:1073:25: error: implicit declaration of func=
tion 'FIELD_PREP' [-Werror=3Dimplicit-function-declaration]
 1073 |         freqpct74_val =3D FIELD_PREP(SVSB_FREQPCTS_FLD_PCT0_4, svsb=
->freq_pct[8]) |
      |                         ^~~~~~~~~~

Caused by commit

  a92438c5a30a ("soc: mediatek: mtk-svs: Use bitfield access macros where p=
ossible")

I have used the mediatek tree from next-20220829 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/YQosNvvXEXip9TFwjxJXq.x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMNTuYACgkQAVBC80lX
0GzvLgf+Mfr7ScZ2wUWrRFzOzRAdlGiGCFwIc53S2cJlfbMIZN8P04u9qxePjskp
zVTMhd04/RWTtLE3qoSS2kxirs8BYyCMk6cyZoLOvcaSz8O36UklKEPp/KcRaqTC
HtTLpFrvll0wtXqg4sdM6cyuj7GvnwxE7TQkEgvrNGATrYnfmhO/BM7Ad5wLty78
nXGiFZqviT1Te9y+CCQ08dDK3rpLjKNmcfjcXmftTKaegrc2U6cJmL7ReJl3OKxH
OymVuL48X+VS64fsIxkM0vQAZ6cAaVEXzmv39IhiqB2IxhmkmyxaQ7jzbhpWWQ9G
IYPmnVcpDQiKRZxaNvI963dwKs3Y7Q==
=QOqd
-----END PGP SIGNATURE-----

--Sig_/YQosNvvXEXip9TFwjxJXq.x--

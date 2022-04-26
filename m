Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8296050F546
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbiDZIpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiDZIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:39:25 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDED3F335;
        Tue, 26 Apr 2022 01:30:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnZpB4td1z4ySS;
        Tue, 26 Apr 2022 18:30:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650961843;
        bh=6qdUyVxgeCgLFwTIptoWNyNCeFYc5FP46XpU2AKVH6g=;
        h=Date:From:To:Cc:Subject:From;
        b=kLpjEZwiKBoGP/x65ktIG/TEyWbEceeKdebGPLHMaFS2BLu/Fdd/hwIVf5SmxqVRG
         oBZIXrtYXnQD8mEd9Xf4f7hJhXbrC/7BhJ0HpEy48T3IlAEmNcGm7E/KZJGLH+IMxo
         1exdA+RBNpKJAJJTUl2HB08RTjmhJC9bC0sNtVpZO5U5MPSSIPprXa2Q6bj6QMDhGz
         zKXb1GOV4uVY+7wpLa7x9MOevmMmnrI70H/RDkYcNiOtiIP+QjccWrEdAxHdvGl+rH
         BcPVbdaIP54Ag0RiJXqry6ZDnESwMZRmznS7PS64PbvJ8PrDX5+TqyyHdNMb1migVN
         s3O9TNfF0S65Q==
Date:   Tue, 26 Apr 2022 18:30:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20220426183041.2593d35f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NxqUWlCimMaacaTvPYFSjET";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NxqUWlCimMaacaTvPYFSjET
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x18): multiple defini=
tion of `adsp_clock_on'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0=
x60): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function `.adsp_clock_on=
':
mt8186-clk.c:(.text.adsp_clock_on+0x0): multiple definition of `.adsp_clock=
_on'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:mt8195-clk.c:(.text.adsp_c=
lock_on+0x0): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x30): multiple defini=
tion of `adsp_clock_off'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+=
0x78): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function `.adsp_clock_of=
f':
mt8186-clk.c:(.text.adsp_clock_off+0x0): multiple definition of `.adsp_cloc=
k_off'; sound/soc/sof/mediatek/mt8195/mt8195-clk.o:mt8195-clk.c:(.text.adsp=
_clock_off+0x0): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x0): multiple defi=
nition of `sof_hifixdsp_boot_sequence'; sound/soc/sof/mediatek/mt8195/mt819=
5-loader.o:(.opd+0x0): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function `.sof_hifixd=
sp_boot_sequence':
mt8186-loader.c:(.text.sof_hifixdsp_boot_sequence+0x0): multiple definition=
 of `.sof_hifixdsp_boot_sequence'; sound/soc/sof/mediatek/mt8195/mt8195-loa=
der.o:mt8195-loader.c:(.text.sof_hifixdsp_boot_sequence+0x0): first defined=
 here
ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x18): multiple def=
inition of `sof_hifixdsp_shutdown'; sound/soc/sof/mediatek/mt8195/mt8195-lo=
ader.o:(.opd+0x18): first defined here
ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function `.sof_hifixd=
sp_shutdown':
mt8186-loader.c:(.text.sof_hifixdsp_shutdown+0x0): multiple definition of `=
.sof_hifixdsp_shutdown'; sound/soc/sof/mediatek/mt8195/mt8195-loader.o:mt81=
95-loader.c:(.text.sof_hifixdsp_shutdown+0x0): first defined here

Caused by commits

  570c14dc92d5 ("ASoC: SOF: mediatek: Add mt8186 sof fw loader and dsp ops")
  210b3ab932f7 ("ASoC: SOF: mediatek: Add mt8186 dsp clock support")

I have reverted those commits and the following

  0e0b83cc7ec7 ("ASoC: SOF: mediatek: Add DSP system PM callback for mt8186=
")

for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/NxqUWlCimMaacaTvPYFSjET
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnrbEACgkQAVBC80lX
0Gz9egf/bQzoSbhllOei4arxYI2pvPMl/chnh5rTJIvf5PE5nYFNITFpcyZzlxZ3
gwi2cBvWLM6M89d/c8lP06X6CpFc3HoOl+sNS8Ib+tXlyHw7KBTGO/5W4hXacqpi
zdodoL4fW/uP956vHEwVG0Fnymt0/YlvL1J22JpUl78xdQh5AyMFB+iAzUoNRAyE
vADYZ5balFjYiA0MNn7Pi48aLjssqx5+Klf3KVYevIvuOUfOQTwuaS7lyitjCtC2
1WralgP9RWB216l2gzosjeBY4qIHTWbZczXrFqCLZEnNhQWlC3jemNQkrn4L2dPS
cScN5UVR75A5L0QRu+ssMuaAUsmDZQ==
=9T3O
-----END PGP SIGNATURE-----

--Sig_/NxqUWlCimMaacaTvPYFSjET--

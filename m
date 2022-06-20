Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4BA550DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiFTAeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiFTAeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:34:06 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6FE64D8;
        Sun, 19 Jun 2022 17:34:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LR9cn5ssGz4xXg;
        Mon, 20 Jun 2022 10:34:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655685242;
        bh=XYrTSyLWg2AFPQRTLYk09ow8SjdYYKMi0gid5hZ4uD4=;
        h=Date:From:To:Cc:Subject:From;
        b=duaL0ouuYhuOOEkW3Dq+J3iOUdebscrRtIa12Rx9G4ACbdZwwDWVmQUe+77gyNg8i
         Zn3vA25V31JJfAMUn8qBgaM/NrKE+WjndOffrVltEaejvPCDvjIbbJwNk0ikxq0uHP
         yavmkYCkWjAP05KIJsx0emOq56VcW17OHVsSRed7jZosBh8bAyZNie2ILOAlNJnWQc
         DUzQOjfh0MdH8XQ3iUEMVodXs0OC7IQbHoprpPE2orGIrOpoEdeywDUf7WtNIFbQho
         lPMpRzcd6h/E7Tl28vpJU3RNoH+Z03n4/etO7Y8uNDxRQS/fVCrLbJlGe4zxO02luW
         X5cqgR7RVRHVQ==
Date:   Mon, 20 Jun 2022 10:34:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the libata tree
Message-ID: <20220620103400.6b03f8d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rJPnq34a.us=_zyvi_8w_lF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rJPnq34a.us=_zyvi_8w_lF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the libata tree, today's linux-next build (powercp
ppc64_defconfig) produced this warning:

In file included from include/linux/device.h:15,
                 from arch/powerpc/include/asm/io.h:27,
                 from include/linux/io.h:13,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:11,
                 from include/linux/highmem.h:11,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/ata/pata_macio.c:18:
drivers/ata/pata_macio.c: In function 'pmac_macio_calc_timing_masks':
drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of=
 type 'long unsigned int', but argument 4 has type 'unsigned int' [-Wformat=
=3D]
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
  129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);       =
     \
      |                                         ^~~
include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
  163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_AR=
GS__); \
      |                                             ^~~~~~~
drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |         ^~~~~~~
drivers/ata/pata_macio.c:1031:52: note: format string is defined here
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                                                  ~~^
      |                                                    |
      |                                                    long unsigned int
      |                                                  %x
In file included from include/linux/device.h:15,
                 from arch/powerpc/include/asm/io.h:27,
                 from include/linux/io.h:13,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:11,
                 from include/linux/highmem.h:11,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/ata/pata_macio.c:18:
drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of=
 type 'long unsigned int', but argument 5 has type 'unsigned int' [-Wformat=
=3D]
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
  129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);       =
     \
      |                                         ^~~
include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
  163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_AR=
GS__); \
      |                                             ^~~~~~~
drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |         ^~~~~~~
drivers/ata/pata_macio.c:1031:63: note: format string is defined here
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                                                             ~~^
      |                                                               |
      |                                                               long =
unsigned int
      |                                                             %x
In file included from include/linux/device.h:15,
                 from arch/powerpc/include/asm/io.h:27,
                 from include/linux/io.h:13,
                 from include/linux/irq.h:20,
                 from arch/powerpc/include/asm/hardirq.h:6,
                 from include/linux/hardirq.h:11,
                 from include/linux/highmem.h:11,
                 from include/linux/bvec.h:10,
                 from include/linux/blk_types.h:10,
                 from include/linux/blkdev.h:9,
                 from drivers/ata/pata_macio.c:18:
drivers/ata/pata_macio.c:1031:28: warning: format '%lx' expects argument of=
 type 'long unsigned int', but argument 6 has type 'unsigned int' [-Wformat=
=3D]
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
include/linux/dev_printk.h:129:41: note: in definition of macro 'dev_printk'
  129 |                 _dev_printk(level, dev, fmt, ##__VA_ARGS__);       =
     \
      |                                         ^~~
include/linux/dev_printk.h:163:45: note: in expansion of macro 'dev_fmt'
  163 |                 dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_AR=
GS__); \
      |                                             ^~~~~~~
drivers/ata/pata_macio.c:1031:9: note: in expansion of macro 'dev_dbg'
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |         ^~~~~~~
drivers/ata/pata_macio.c:1031:73: note: format string is defined here
 1031 |         dev_dbg(priv->dev, "Supported masks: PIO=3D%lx, MWDMA=3D%lx=
, UDMA=3D%lx\n",
      |                                                                    =
   ~~^
      |                                                                    =
     |
      |                                                                    =
     long unsigned int
      |                                                                    =
   %x

Introduced by commit

  f0a6d77b351c ("ata: make transfer mode masks *unsigned int*")

--=20
Cheers,
Stephen Rothwell

--Sig_/rJPnq34a.us=_zyvi_8w_lF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKvwHgACgkQAVBC80lX
0Gxv1wf/Uv39UOVcDl3NlTfPJ0+6q0ChNv5dAgtvq3qLiMarkPcsrVxK+FQSWqny
sOLWyKO8TMWg+WzprqcH13ADeFBZNsUHVXFwkqUOJgpZF7Mm2z8vE6JJSFHRkq31
dVzrwD2IxClulkuvHxpsbLaQJBhTxSutOZreoNcAk5ahI4bjlAfJX1qAMCboPPDb
2RCTIu8/pm4mp+FLRZv8X06iPofYxu2e8kRlCvXIUTM1Ly1yWzbAel60R2WfjLTV
1BKr4T3CQiyVOZfQdX8HXCj0G2T3P/kY2OBXWRhUNq4/IsZAw+yWA5HmJ5AZqrkS
MsoArYjaKNTHz3g0KbxWcsqtKUVmAg==
=1V5m
-----END PGP SIGNATURE-----

--Sig_/rJPnq34a.us=_zyvi_8w_lF--

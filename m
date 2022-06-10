Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FF545A3C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243514AbiFJCqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 22:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236922AbiFJCql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 22:46:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5D0276CDA;
        Thu,  9 Jun 2022 19:46:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LK52C3N6qz4xCy;
        Fri, 10 Jun 2022 12:46:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654829187;
        bh=h2+xZoaDJ/IDzwzNAG8ZJS5fyhE5GeClSxAuSYuSlBo=;
        h=Date:From:To:Cc:Subject:From;
        b=dYiueIGqDGjkxGTydnPhy/4JOxqq2m+qfYqMF0sCSRnLJXooV5gsMBcbNRkKVsebF
         55oZlPJIXd3vNbRDpJMTU2at0ZF4GHpoK2Pu9nhwDoTFf51UCpkhOQFWddzKcieZ+g
         GH12d0zfMwPMSNa7841DGQRGERWNIswtJRpvcEh6gIqeO0pDOxOufBjcNCG0X7kGkg
         Vg9W1npkgswhEnQ4pLp5sV+GyTPDbyesu3hD+Xz8HRd7Lae4sw+fR2uKUZ2+RTI91+
         IMhjsbxzF8eIzV/L70DBFLeaEgKo/01E7UqpgW8K3qpdrkqKrKD1x5CxedrpPVTXJ4
         u8LqgzHweioYQ==
Date:   Fri, 10 Jun 2022 12:46:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Martin =?UTF-8?B?UG92acWhZXI=?= <povik+lin@cutebit.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the dmaengine tree
Message-ID: <20220610124626.141d5f61@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/i1e5Ti7wGH_brFDW+fvy44R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/i1e5Ti7wGH_brFDW+fvy44R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dmaengine tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/printk.h:584,
                 from include/linux/kernel.h:29,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/current.h:6,
                 from include/linux/sched.h:12,
                 from include/linux/ratelimit.h:6,
                 from include/linux/dev_printk.h:16,
                 from include/linux/device.h:15,
                 from drivers/dma/apple-admac.c:10:
drivers/dma/apple-admac.c: In function 'admac_cyclic_write_one_desc':
drivers/dma/apple-admac.c:209:26: error: format '%x' expects argument of ty=
pe 'unsigned int', but argument 7 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
  209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=3D0x%pad len=3D0x%z=
x flags=3D0x%x\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynam=
ic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_=
func_call'
  166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_=
dbg'
  155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~
include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
  155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
      |                              ^~~~~~~
drivers/dma/apple-admac.c:209:9: note: in expansion of macro 'dev_dbg'
  209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=3D0x%pad len=3D0x%z=
x flags=3D0x%x\n",
      |         ^~~~~~~
drivers/dma/apple-admac.c:209:75: note: format string is defined here
  209 |         dev_dbg(ad->dev, "ch%d descriptor: addr=3D0x%pad len=3D0x%z=
x flags=3D0x%x\n",
      |                                                                    =
      ~^
      |                                                                    =
       |
      |                                                                    =
       unsigned int
      |                                                                    =
      %lx
cc1: all warnings being treated as errors

Caused by commit

  b127315d9a78 ("dmaengine: apple-admac: Add Apple ADMAC driver")

I have used the dmaengine tree from next-20220609 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/i1e5Ti7wGH_brFDW+fvy44R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKisIIACgkQAVBC80lX
0GxgBAf/cGYsws/C1r2PDFSO3+imPuaRCyEI/l0llBjOkAnMWKne0jzT89Ttu6Yp
PIMCR5erD/nEBduJqBK2LwWDbBiaVqcFahdCHF//+5xJuWrf3SITyHXgINNGj8T1
yv+boeAdmwVQwntZLTY3dCsQgAtIzY1FxdJlV7u5/zOGl8c/QHFAOLSx3RttQ7ag
GhWk+SyrkWiiopiGnqewemu64+Gaa446PzWuuFF6mjkCQm6/3jSPHpkt62uo/Qe3
jJlsIjIEhEEttgEj3RyKp8qBxAPuyus6mZHydcgp/Uby6Um/jSvVW8RlENZvlOz2
1q270f8MudYuQTke9P0HPCqPm28pyA==
=gv91
-----END PGP SIGNATURE-----

--Sig_/i1e5Ti7wGH_brFDW+fvy44R--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACAE576138
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiGOMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGOMXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:23:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5387B7A4;
        Fri, 15 Jul 2022 05:22:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkr9D5yz1z4xZD;
        Fri, 15 Jul 2022 22:22:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657887776;
        bh=7loyB7EwW/Eli4IJtB27PLvodUILU8T0py4tFun80zY=;
        h=Date:From:To:Cc:Subject:From;
        b=Q2b5j3CK8l5aWE9ybny4mD89p4J3XHg6tR8G40yhMdHS215oaafxWZrW9mZEk+kVo
         aJ8R0iQ22utN0K8obDs5QkkwpDucsiFrXgYAY7z+LV9980y8CKrTqrHbk8yGUo0t1e
         q/JLN52Jpajje8qYHKpPnISCeu2K/Ml6j5Qt/5HJbzZQrW15rJhjPXUrl26rKP1T2/
         947RYJIQFOs8e2HECiwbV6qBxap2F1HG0Ob62zTBaNV8OqLM/EGaM7vxsRkdhryGHG
         OUXmY/VGxpiClJ7CXdFvP4hi+qFsSRtWD/ZbRnaWuDJQz+U+dYFXKPKkqgNFtSWCmB
         l1Jf4TbQ6YxXA==
Date:   Fri, 15 Jul 2022 22:22:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bitmap tree
Message-ID: <20220715222255.2e7fae53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WQVZ9dxuYeQ7klzkl+jcS73";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WQVZ9dxuYeQ7klzkl+jcS73
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (arm64 defconfig)
produced this warning:

In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c: In function 'setup_resources':
drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=
=3D]
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
 4999 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5000:49: note: format string is defined here
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                                                ~^
      |                                                 |
      |                                                 unsigned int
      |                                                %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=
=3D]
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
 4999 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5000:60: note: format string is defined here
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                                                           ~^
      |                                                            |
      |                                                            unsigned=
 int
      |                                                           %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5000:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 6 has type 'long unsigned int' [-Wformat=
=3D]
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:4999:17: note: in expansion of macro 'dev_info'
 4999 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5000:74: note: format string is defined here
 5000 |                          "Channels: %d (tchan: %u, rchan: %u, gp-rf=
low: %u)\n",
      |                                                                    =
     ~^
      |                                                                    =
      |
      |                                                                    =
      unsigned int
      |                                                                    =
     %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=
=3D]
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
 5010 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5011:49: note: format string is defined here
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                                                ~^
      |                                                 |
      |                                                 unsigned int
      |                                                %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=
=3D]
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
 5010 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5011:60: note: format string is defined here
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                                                           ~^
      |                                                            |
      |                                                            unsigned=
 int
      |                                                           %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5011:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 6 has type 'long unsigned int' [-Wformat=
=3D]
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:5010:17: note: in expansion of macro 'dev_info'
 5010 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5011:71: note: format string is defined here
 5011 |                          "Channels: %d (bchan: %u, tchan: %u, rchan=
: %u)\n",
      |                                                                    =
  ~^
      |                                                                    =
   |
      |                                                                    =
   unsigned int
      |                                                                    =
  %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5022:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 4 has type 'long unsigned int' [-Wformat=
=3D]
 5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:5021:17: note: in expansion of macro 'dev_info'
 5021 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5022:49: note: format string is defined here
 5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
      |                                                ~^
      |                                                 |
      |                                                 unsigned int
      |                                                %lu
In file included from include/linux/device.h:15,
                 from include/linux/dmaengine.h:8,
                 from drivers/dma/ti/k3-udma.c:9:
drivers/dma/ti/k3-udma.c:5022:26: warning: format '%u' expects argument of =
type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=
=3D]
 5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/dma/ti/k3-udma.c:5021:17: note: in expansion of macro 'dev_info'
 5021 |                 dev_info(dev,
      |                 ^~~~~~~~
drivers/dma/ti/k3-udma.c:5022:60: note: format string is defined here
 5022 |                          "Channels: %d (tchan: %u, rchan: %u)\n",
      |                                                           ~^
      |                                                            |
      |                                                            unsigned=
 int
      |                                                           %lu

Introduced by commit

  31563fb891aa ("lib/bitmap: change type of bitmap_weight to unsigned long")

I have applied the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Jul 2022 22:15:40 +1000
Subject: [PATCH] fix up for k3-udma.c

due to "lib/bitmap: change type of bitmap_weight to unsigned long"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/dma/ti/k3-udma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 2f0d2c68c93c..07cb48db76ba 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4997,7 +4997,7 @@ static int setup_resources(struct udma_dev *ud)
 	switch (ud->match_data->type) {
 	case DMA_TYPE_UDMA:
 		dev_info(dev,
-			 "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
+			 "Channels: %d (tchan: %lu, rchan: %lu, gp-rflow: %lu)\n",
 			 ch_count,
 			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
 						       ud->tchan_cnt),
@@ -5008,7 +5008,7 @@ static int setup_resources(struct udma_dev *ud)
 		break;
 	case DMA_TYPE_BCDMA:
 		dev_info(dev,
-			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
+			 "Channels: %d (bchan: %lu, tchan: %lu, rchan: %lu)\n",
 			 ch_count,
 			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
 						       ud->bchan_cnt),
@@ -5019,7 +5019,7 @@ static int setup_resources(struct udma_dev *ud)
 		break;
 	case DMA_TYPE_PKTDMA:
 		dev_info(dev,
-			 "Channels: %d (tchan: %u, rchan: %u)\n",
+			 "Channels: %d (tchan: %lu, rchan: %lu)\n",
 			 ch_count,
 			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
 						       ud->tchan_cnt),
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/WQVZ9dxuYeQ7klzkl+jcS73
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRXB8ACgkQAVBC80lX
0GyYawf+MHT1QC8EUCJqKdwsVbrGDDnTNgRNuc8QgThQrZ+qiJdC4bkoT/S6e4PO
qE0OFNHKZxUm70pzbmRmVi0pugeZuSlnR/YmDnkkzeUh5SpgTZRd0Tw0bm5LdSm3
kn74+6RCBpUfwzi72h19Pv/JGsfC/VXT06wEBs6/yPWCxvORkBUDs6CoAPBOriDp
i+521w4OR4GOM5gxpdlQIWT+XJI92FJYzLuCsAQd7yYhTAKgNpKJwPOSMg2j3Ieu
u2iedTWCY4VzpTyXZCacqAn+ddr0y6Hs+kWfhakY2fW+f5VJTBkuyYDUgFxIGEMl
jJ8YUQ0sMwiA8fx2az5fszN2RB6haQ==
=X0g3
-----END PGP SIGNATURE-----

--Sig_/WQVZ9dxuYeQ7klzkl+jcS73--

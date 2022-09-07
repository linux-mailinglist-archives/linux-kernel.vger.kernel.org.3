Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622B95AF982
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiIGBxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIGBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:53:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFD84EEC;
        Tue,  6 Sep 2022 18:53:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMldk4z4xz4xDK;
        Wed,  7 Sep 2022 11:53:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662515595;
        bh=aK8TtveelFEtYAjSL5unfQber2kPXp4XryNLKXgpSdk=;
        h=Date:From:To:Cc:Subject:From;
        b=rx4JWPOdSPE857g1DRCWx83NiTybDAwtfBay62Y2Jvx34Dux8nTT3ylJ52jh29C93
         A3pgKKGkKmlbI5JWL3Mda1HtgYA0JIVSK0w3f/mX2JEIUWhBzLMZTt/KPioObt3oOP
         Usm3URn6gaNB0/adhU1FtfTH1DOvjvmN1HtS3Y9nTrDMydxc30OaKaB+vcHNKL2qko
         6Zc6oCwj6MzVdPUhvwfYLu7ICpmnStWC6UpVg53X7SSb1wOnbtCYrkATS2xlt0vFfH
         3lIpJyvEMTYzqKJJXigi6HBUFdbmFeQ9j2rO2yhCt7BQ16nuCUtziM1uOdet68w/za
         eKzaH5AHvG5Vw==
Date:   Wed, 7 Sep 2022 11:53:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Johnny Huang <johnny_huang@aspeedtech.com>,
        Neal Liu <neal_liu@aspeedtech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20220907115313.50b5f512@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9MhBwFrdEbe6pVwNWAIwfGC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9MhBwFrdEbe6pVwNWAIwfGC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/linux/device.h:15,
                 from include/linux/dma-mapping.h:7,
                 from drivers/crypto/aspeed/aspeed-hace.h:9,
                 from drivers/crypto/aspeed/aspeed-hace-hash.c:6:
drivers/crypto/aspeed/aspeed-hace-hash.c: In function 'aspeed_ahash_dma_pre=
pare_sg':
drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: error: format '%x' expects =
argument of type 'unsigned int', but argument 7 has type 'size_t' {aka 'lon=
g unsigned int'} [-Werror=3Dformat=3D]
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |                            ^~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of macro =
'dev_info'
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |         ^~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:188:9: note: in expansion of macro=
 'AHASH_DBG'
  188 |         AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
      |         ^~~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c: In function 'aspeed_hace_ahash_tr=
igger':
drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: error: format '%x' expects =
argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' {aka =
'long long unsigned int'} [-Werror=3Dformat=3D]
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |                            ^~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of macro =
'dev_info'
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |         ^~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of macro=
 'AHASH_DBG'
  327 |         AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:=
0x%x\n",
      |         ^~~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: error: format '%x' expects =
argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' {aka =
'long long unsigned int'} [-Werror=3Dformat=3D]
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |                            ^~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of macro =
'dev_info'
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |         ^~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of macro=
 'AHASH_DBG'
  327 |         AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:=
0x%x\n",
      |         ^~~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:28: error: format '%x' expects =
argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'lon=
g unsigned int'} [-Werror=3Dformat=3D]
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |                            ^~~~~~~
include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk=
_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                  =
     \
      |                              ^~~
include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
  150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fm=
t), ##__VA_ARGS__)
      |                                                          ^~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:10:9: note: in expansion of macro =
'dev_info'
   10 |         dev_info((h)->dev, "%s() " fmt, __func__, ##__VA_ARGS__)
      |         ^~~~~~~~
drivers/crypto/aspeed/aspeed-hace-hash.c:327:9: note: in expansion of macro=
 'AHASH_DBG'
  327 |         AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:=
0x%x\n",
      |         ^~~~~~~~~

Caused by commit

  108713a713c7 ("crypto: aspeed - Add HACE hash driver")

Exposed by commits

  2be570849efc ("crypto: aspeed - fix build module error")
  31b39755e325 ("crypto: aspeed - Enable compile testing")

I have used the crypto tree from next-20220901 again today.

--=20
Cheers,
Stephen Rothwell

--Sig_/9MhBwFrdEbe6pVwNWAIwfGC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMX+YkACgkQAVBC80lX
0GxVJggAi6xrORNxmIeqnCBZfOZHmb0f1kKUt+JgXgj3Wet/uuoEV/w+jGbxecyv
BfotPZ2DVHMsGP/qUCxW7CSItDSjtA5t+8pqChG+C4IlAGcZOJ8SNSn37RQqL06p
OQrgki9JgvE8pKeAXcwKjSPDjwaQdLA9aIjssUVKtQMlrOzB6M7Qwfn7GfXaiMfa
N+mVUk0A+U2U941wtOUcJ+Iw++qenG46rcHr+Y4AxghBOe1icqg7/dE3njPMWZ7t
Q3GfiR0BtDvRKX1ELexErbGUGksSjGb+TDDtsGQ600laIiBTqractI1eEG9gF/kj
4neO1JOt6++4z4R7UkjjIyqXITG27Q==
=URzr
-----END PGP SIGNATURE-----

--Sig_/9MhBwFrdEbe6pVwNWAIwfGC--

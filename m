Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39655197BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345146AbiEDHDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiEDHDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:03:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BD065E3;
        Wed,  4 May 2022 00:00:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtSPp3Dnlz4xTX;
        Wed,  4 May 2022 16:59:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651647598;
        bh=90wlYgCpFivT1rC2wcKWEMcQDgDO6cL7YqVcGVtO2m8=;
        h=Date:From:To:Cc:Subject:From;
        b=aqyCxq+AwgXvwQ0UTcuBDMFsa60DDgyJhZlWvf05gi7G63GYCOX3iaQHtxOH/2Noh
         0TT/UTS7aIv+4vBN0OoLvO9hqraJDz3FV/HaTT+wCDkDC0Qnyv6ajrLqJh8/h/KgnP
         8y0DTvcTLkhr/qSjHNH/vAtBYlk7kR0BgwZE0i3SvsOBj7BpK8Zx9BEVSWdiidG2MP
         /UZ2zDoH1+yWDAePs/VexAo4GDKGKtmrlXNgdB+d+PHmhp0v5jkux1IOT6MYVhaqGn
         ZbmlH8eMTt1MVJh5WQyzdsKeW2ustY8VL7KwvJO3N9ZwHeuYwOd+46dZYjiS2TChdL
         iQamaKHGtUgjA==
Date:   Wed, 4 May 2022 16:59:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dipen Patel <dipenp@nvidia.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hte tree
Message-ID: <20220504165956.531c4b53@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Sxu7HfTmV2Dx4LHxmbfAJ8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Sxu7HfTmV2Dx4LHxmbfAJ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hte tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

drivers/gpio/gpiolib-cdev.c:572:8: error: unknown type name 'hte_return_t'
  572 | static hte_return_t process_hw_ts_thread(void *p)
      |        ^~~~~~~~~~~~
drivers/gpio/gpiolib-cdev.c:623:8: error: unknown type name 'hte_return_t'
  623 | static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
      |        ^~~~~~~~~~~~
drivers/gpio/gpiolib-cdev.c: In function 'hte_edge_setup':
drivers/gpio/gpiolib-cdev.c:851:41: error: passing argument 2 of 'hte_reque=
st_ts_ns' from incompatible pointer type [-Werror=3Dincompatible-pointer-ty=
pes]
  851 |         return hte_request_ts_ns(hdesc, process_hw_ts,
      |                                         ^~~~~~~~~~~~~
      |                                         |
      |                                         int (*)(struct hte_ts_data =
*, void *)
In file included from drivers/gpio/gpiolib-cdev.c:27:
include/linux/hte.h:234:75: note: expected 'hte_ts_cb_t' {aka 'enum hte_ret=
urn (*)(struct hte_ts_data *, void *)'} but argument is of type 'int (*)(st=
ruct hte_ts_data *, void *)'
  234 | static inline int hte_request_ts_ns(struct hte_ts_desc *desc, hte_t=
s_cb_t cb,
      |                                                               ~~~~~=
~~~~~~~^~
drivers/gpio/gpiolib-cdev.c:852:34: error: passing argument 3 of 'hte_reque=
st_ts_ns' from incompatible pointer type [-Werror=3Dincompatible-pointer-ty=
pes]
  852 |                                  process_hw_ts_thread, line);
      |                                  ^~~~~~~~~~~~~~~~~~~~
      |                                  |
      |                                  int (*)(void *)
In file included from drivers/gpio/gpiolib-cdev.c:27:
include/linux/hte.h:235:53: note: expected 'hte_ts_sec_cb_t' {aka 'enum hte=
_return (*)(void *)'} but argument is of type 'int (*)(void *)'
  235 |                                     hte_ts_sec_cb_t tcb, void *data)
      |                                     ~~~~~~~~~~~~~~~~^~~
cc1: some warnings being treated as errors

Something has been missed in the contruction of the git tree :-(

I have dropped the hte tree for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.Sxu7HfTmV2Dx4LHxmbfAJ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJyJG0ACgkQAVBC80lX
0Gwsgwf/U9QiLifUxSuF5snkAu+pe+s+awAPgzE4pqPpbfPhQb2VZiOkwuorZ10M
VHdOr2QAw7RZ6nbRa/1CsXLOD9/LVuyyceL0Yck6HHjUD8Pbe/k01EoW8aI7zHl6
mYcfSaQFB11OKT3Bl04J3/fURNWqJDN27wkklzyVhJJAjELLQzk4UcWE/LW2ofgI
QegiOVVQPlWcKiMvh1Xb0ktH9/3yBAFhL+i1u1hbEAd4iRa7jb6yOUBt8dUUEaJ2
ltU5TMUMkUWjTSgYsnbPhxgnWXMY8bB+GDkab0JxI6NBW2iYZ6zM/0xpU49jt8/G
LJonNe5CDVvAkygAsko0EFs1fhay1A==
=NM8K
-----END PGP SIGNATURE-----

--Sig_/.Sxu7HfTmV2Dx4LHxmbfAJ8--

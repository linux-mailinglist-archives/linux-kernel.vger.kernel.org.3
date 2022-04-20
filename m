Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F218A508053
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 06:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359365AbiDTE6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 00:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359362AbiDTE6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 00:58:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3F921251;
        Tue, 19 Apr 2022 21:55:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjpJQ0nkvz4xR9;
        Wed, 20 Apr 2022 14:55:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650430518;
        bh=YyxrZivpLBT1ds16BAwUZm+VgQWUE/URI4rLrYx4JMc=;
        h=Date:From:To:Cc:Subject:From;
        b=NtNCuNA1zPAo4LqWjzTiAJPV213bmAaedfYK8yyHhlIg9pDJednUz2ni48KNAFVRj
         4I3xJnIv3+fwsp5tQz4g6kLn/21v1tTyQxbVjcscgLxRqV8xJIKQmjRC0HJTN6A83z
         AX7UYM/ByR21molQ8ZZ67ZkqI0Y6O5RU190HIBVxuaE1U0cvo1XiFeW9wOMZIZqry4
         Q+aAL2bEfKxGa3lZaiprJEU5FZDtWnzxVSzmGHng2A6mqvonURSRPG5MqMUHzNrXbo
         +qWgGR+TxCi5RNduJTGyNrr213OmBpaaWb5qxRztgZEowXCAVvsuA9Evv8E6kNkISN
         OhbxF7d/MJooQ==
Date:   Wed, 20 Apr 2022 14:55:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pinctrl-renesas tree
Message-ID: <20220420145517.445e41b1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5wRBjX+S5_EIrTtTyp6DMEL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5wRBjX+S5_EIrTtTyp6DMEL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pinctrl-renesas tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from include/asm-generic/bug.h:22,
                 from arch/x86/include/asm/bug.h:87,
                 from include/linux/bug.h:5,
                 from include/linux/io.h:11,
                 from drivers/pinctrl/renesas/core.c:16:
drivers/pinctrl/renesas/core.c: In function 'sh_pfc_check_info':
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1186:33: note: in expansion of macro 'sh_pfc=
_err'
 1186 |                                 sh_pfc_err("drive_reg 0x%x:%u/0x%x:=
%u: pin conflict\n",
      |                                 ^~~~~~~~~~
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 6 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1186:33: note: in expansion of macro 'sh_pfc=
_err'
 1186 |                                 sh_pfc_err("drive_reg 0x%x:%u/0x%x:=
%u: pin conflict\n",
      |                                 ^~~~~~~~~~
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1206:33: note: in expansion of macro 'sh_pfc=
_err'
 1206 |                                 sh_pfc_err("bias_reg 0x%x:%u/0x%x:%=
u: pin conflict\n",
      |                                 ^~~~~~~~~~
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 6 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1206:33: note: in expansion of macro 'sh_pfc=
_err'
 1206 |                                 sh_pfc_err("bias_reg 0x%x:%u/0x%x:%=
u: pin conflict\n",
      |                                 ^~~~~~~~~~
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 4 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1210:33: note: in expansion of macro 'sh_pfc=
_err'
 1210 |                                 sh_pfc_err("bias_reg 0x%x:%u/0x%x:%=
u: pin conflict\n",
      |                                 ^~~~~~~~~~
include/linux/kern_levels.h:5:25: error: format '%u' expects argument of ty=
pe 'unsigned int', but argument 6 has type 'long unsigned int' [-Werror=3Df=
ormat=3D]
    5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
      |                         ^~~~~~
include/linux/printk.h:418:25: note: in definition of macro 'printk_index_w=
rap'
  418 |                 _p_func(_fmt, ##__VA_ARGS__);                      =
     \
      |                         ^~~~
include/linux/printk.h:489:9: note: in expansion of macro 'printk'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |         ^~~~~~
include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
   11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
      |                         ^~~~~~~~
include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
  489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
      |                ^~~~~~~~
drivers/pinctrl/renesas/core.c:767:17: note: in expansion of macro 'pr_err'
  767 |                 pr_err("%s: " fmt, drvname, ##__VA_ARGS__);     \
      |                 ^~~~~~
drivers/pinctrl/renesas/core.c:1210:33: note: in expansion of macro 'sh_pfc=
_err'
 1210 |                                 sh_pfc_err("bias_reg 0x%x:%u/0x%x:%=
u: pin conflict\n",
      |                                 ^~~~~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  be1a0d45cdd5 ("pinctrl: renesas: checker: Rework drive and bias pin itera=
tion")

I have used the pinctrl-renesas tree from next-20220419 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/5wRBjX+S5_EIrTtTyp6DMEL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfkjUACgkQAVBC80lX
0Gz/RQgAlZIEEbQ526ASrIfCn3Wm2N/it71+s2Wpapb6jAK2rVRxbhGkM2ol8JA4
CZHfhgKiAHxuy2sdpUwJKTGd7Os6N2WobqrS/5+LS3tQB8EPjqrmA4j1SHSXP5F5
PjAepUjSvIoUCI7VynciNluE6s8mfK5Ff7sP/Ngeb9hecQihTe6v58Y2+HbM/cZQ
6BU75GIQysQsmhDBlH/EBC4yPNNIpgCTYmcmhrQX8X30F/w/QCnLOQewYCuZzS/U
sCrk8BsmCJ77dmCSeZRgTqj8eA1fDX5cglA7OaKCEcY9vtRakOjnD9+D0zXTH4Tc
WNajQD8N/6SH8yORIL6v98FUAInRtA==
=Jx3K
-----END PGP SIGNATURE-----

--Sig_/5wRBjX+S5_EIrTtTyp6DMEL--

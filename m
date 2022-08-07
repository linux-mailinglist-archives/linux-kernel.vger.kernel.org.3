Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371D658BE2C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 01:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbiHGXDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 19:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiHGXDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 19:03:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D54272E;
        Sun,  7 Aug 2022 16:03:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M1FHk5r7gz4x1V;
        Mon,  8 Aug 2022 09:03:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1659913411;
        bh=deIIrGbv7K4SrmJVHFIN2GWBwvoBOtE8G6gHJ47b13Q=;
        h=Date:From:To:Cc:Subject:From;
        b=cCKiuvIsQx/H2E6g8iA4hZ5HYowA0X6lG+sLGZaQoq3AxlqHHpldC58m+YN8d6kGv
         YWMZz2u64ZBWNw2pDSVxpK2oQPBFzxEN9TBQVpOS/7ZZLIyfseixgBkZ3tOWcj+oou
         dVUkn0fOlA4wxpgG9QhUZIJLYfR8TXoKtqQlbOAxAqThVZpWRZTgAVXPnbWCSflH2z
         q+rf/AH75cVsT2ixNyhU+d88nwoy1jIpi7VnT4VrfEIXDsBv6RVBYub6z3lADr7ZB9
         HXSiD7t89erO0DZn47b8Kqz9sVbbyMewvD4WtbZDIICbxbnm2WO3UQWefCkERMW9xq
         3Ct3tmTk++2Gw==
Date:   Mon, 8 Aug 2022 09:03:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the loongarch tree
Message-ID: <20220808090329.4763fe7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xMg937Pe5A4B9ZU8inwozAA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xMg937Pe5A4B9ZU8inwozAA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the loongarch tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/acpi/tables.c: In function 'acpi_table_print_madt_entry':
drivers/acpi/tables.c:213:14: error: 'ACPI_MADT_TYPE_CORE_PIC' undeclared (=
first use in this function); did you mean 'ACPI_MADT_TYPE_IO_SAPIC'?
  213 |         case ACPI_MADT_TYPE_CORE_PIC:
      |              ^~~~~~~~~~~~~~~~~~~~~~~
      |              ACPI_MADT_TYPE_IO_SAPIC
drivers/acpi/tables.c:213:14: note: each undeclared identifier is reported =
only once for each function it appears in
In file included from include/linux/printk.h:573,
                 from include/linux/kernel.h:29,
                 from drivers/acpi/tables.c:13:
drivers/acpi/tables.c:218:35: error: invalid use of undefined type 'struct =
acpi_madt_core_pic'
  218 |                                  p->processor_id, p->core_id,
      |                                   ^~
include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynam=
ic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_=
func_call'
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
  588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
  217 |                         pr_debug("CORE PIC (processor_id[0x%02x] co=
re_id[0x%02x] %s)\n",
      |                         ^~~~~~~~
drivers/acpi/tables.c:218:52: error: invalid use of undefined type 'struct =
acpi_madt_core_pic'
  218 |                                  p->processor_id, p->core_id,
      |                                                    ^~
include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynam=
ic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_=
func_call'
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
  588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
  217 |                         pr_debug("CORE PIC (processor_id[0x%02x] co=
re_id[0x%02x] %s)\n",
      |                         ^~~~~~~~
drivers/acpi/tables.c:219:36: error: invalid use of undefined type 'struct =
acpi_madt_core_pic'
  219 |                                  (p->flags & ACPI_MADT_ENABLED) ? "=
enabled" : "disabled");
      |                                    ^~
include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynam=
ic_func_call'
  134 |                 func(&id, ##__VA_ARGS__);               \
      |                             ^~~~~~~~~~~
include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_=
func_call'
  162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
      |         ^~~~~~~~~~~~~~~~~~
include/linux/printk.h:588:9: note: in expansion of macro 'dynamic_pr_debug'
  588 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~
drivers/acpi/tables.c:217:25: note: in expansion of macro 'pr_debug'
  217 |                         pr_debug("CORE PIC (processor_id[0x%02x] co=
re_id[0x%02x] %s)\n",
      |                         ^~~~~~~~

Caused by commit

  0541f3fad39f ("LoongArch: Parse MADT to get multi-processor information")

I have used the loongarch tree from next-20220805 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xMg937Pe5A4B9ZU8inwozAA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLwRMEACgkQAVBC80lX
0GziRQf+LRFtr5r3LjPKzZdBmx37B6AfeGfhPY38ZEtPH4d1SuLtUPokH0OknCmf
iDHswfHovM9YexldmY5QbKjNOwuI7drpz+IcrAf4/6Z+t0lAhdhBdSuRoHwQ3NOA
QPCG3bOSWtSuBIJD18cQwwp0az8kmu3eCbcfAN4cOBQLtRyKAsfIYg52CRSmWwkS
zqppbNAt8SQ3ArsZGOuZ7CPZeLJO63QSEvp2R76xPD5HJa9oZzWVJf8q0++tRk+a
xRxBxcZDPKzvA4x8ZmyONQ66ZtsQ/wBrn7vmETGIuVOz7phW7c9fw8Qbo5J5tvTn
r6uWFF0rIkBCLU7XJxaGn0EjqmQegw==
=k26G
-----END PGP SIGNATURE-----

--Sig_/xMg937Pe5A4B9ZU8inwozAA--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E70527EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiEPH6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbiEPH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:58:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26B4DF40;
        Mon, 16 May 2022 00:58:00 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1s7B58FJz4xY4;
        Mon, 16 May 2022 17:57:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652687879;
        bh=xZEOTpvzB36EZKa3by0+TSpYf9eirt4UzbpTFCYK7pU=;
        h=Date:From:To:Cc:Subject:From;
        b=hWP9opOWVJj6B+pFbmQstwbjXyG1Z5qWMW+zdNiDJTm+2gkySt11K6IgRMiPDQ6IX
         D6TxIk+7zJdPIMFlN5Dw2jI63TRKWpXnHMm+wJXGjkX4V3A4YYUpIvxkNciQqbuDR0
         umzAXAHE3xS5Q28IeEGtN0Pq20oDwCl7e0G3Fj/OvAP51v9+H9YYWsScZWfeiB6VkV
         5zyouPgJWnXK4Qfy7dGYwJ4IPtsjSK9iQcFHqVRT+SYrlYvvUh/Jjw20+FhmZ8e1+G
         a2G+SSNAT3k2Y5Ig8+4ickhC8gE6zV+ReJkG2x0LrnCO+bZafSGXt5it+aCW6wt1Xu
         aVLwfuCStu9gQ==
Date:   Mon, 16 May 2022 17:57:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the bluetooth tree
Message-ID: <20220516175757.6d9f47b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d3G0.sgMfkFikdK+rqms/10";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d3G0.sgMfkFikdK+rqms/10
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

In file included from include/linux/cpumask.h:12,
                 from include/linux/mm_types_task.h:14,
                 from include/linux/mm_types.h:5,
                 from include/linux/buildid.h:5,
                 from include/linux/module.h:14,
                 from net/bluetooth/mgmt.c:27:
In function 'bitmap_copy',
    inlined from 'bitmap_copy_clear_tail' at include/linux/bitmap.h:270:2,
    inlined from 'bitmap_from_u64' at include/linux/bitmap.h:622:2,
    inlined from 'set_device_flags' at net/bluetooth/mgmt.c:4534:4:
include/linux/bitmap.h:261:9: warning: 'memcpy' forming offset [4, 7] is ou=
t of the bounds [0, 4] of object 'flags' with type 'long unsigned int[1]' [=
-Warray-bounds]
  261 |         memcpy(dst, src, len);
      |         ^~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:248,
                 from include/linux/build_bug.h:5,
                 from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/module.h:12,
                 from net/bluetooth/mgmt.c:27:
net/bluetooth/mgmt.c: In function 'set_device_flags':
net/bluetooth/mgmt.c:4532:40: note: 'flags' declared here
 4532 |                         DECLARE_BITMAP(flags, __HCI_CONN_NUM_FLAGS);
      |                                        ^~~~~
include/linux/types.h:11:23: note: in definition of macro 'DECLARE_BITMAP'
   11 |         unsigned long name[BITS_TO_LONGS(bits)]
      |                       ^~~~

Introduced by commit

  a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting HCI_CONN_FLAG_=
REMOTE_WAKEUP")

Bitmaps consist of unsigned longs (in this case 32 bits) ...

(This warning only happens due to chnges in the bitmap tree.)

--=20
Cheers,
Stephen Rothwell

--Sig_/d3G0.sgMfkFikdK+rqms/10
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKCBAUACgkQAVBC80lX
0GxTYAgAkCKHkMArtmpMurv1Gp+xMqkL1jz3SAfGa18WXCMuhX85wQjTOkgHvxV4
3OZpz00mBEmKDtR+aAnAAAh+7uEhvXic5YOqjjCuH59YX+Ud3fXOVB+dp4OSJen3
k+Y+yi4XP0iSh4ou4AoO+rrDdrv7XO7IXW60C3haa5GFnYrmb4QPMfqJtnrLqoGr
TSnlmQgZ+8pg2wph7dfHLXPzM3vGtM09LEFGfvFHjXHFSVnx06JY5jCiulhXbAQF
sQugyMADBqFzERin3sD8RiAgtu7PeQRQqjPvfE98htFELFqFU4g+6zx/eRW1CGV4
5EZ4IqBbrzdZm1K7phmrOZ+0QahgHA==
=YtFy
-----END PGP SIGNATURE-----

--Sig_/d3G0.sgMfkFikdK+rqms/10--

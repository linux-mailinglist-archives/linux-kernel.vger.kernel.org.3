Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD64D56D459
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 07:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGKFnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 01:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKFnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 01:43:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17E913E25;
        Sun, 10 Jul 2022 22:42:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LhCTT4DCcz4xbn;
        Mon, 11 Jul 2022 15:42:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657518173;
        bh=oPmJt7JRxXnbZA8BhfPX0SGxjWfpFWHY+MxKGuWgHu0=;
        h=Date:From:To:Cc:Subject:From;
        b=rjlzRykBEvLkEx4njaWGqgn62SxsK/DmmLohxlfKuzQqDmWit66W9L2j0I8Ni1IWn
         C/aoAgOfEsmZW8tPkeZ/Na2i7hy3zbhaS/ulMFtfKK1W5zaYB2zeRYtvSUNeRIpZSe
         RffDdyGmiLQANqYP+TD4+yKEvFn0SzJeCcmA//bSQ6XbCVSBkznEGmWn4s5K3BaT7h
         6GtdA7jDM9U+AZrILGPrDGcS2YkQqBvXguPTz3P7F1ItYstc2rkcXbpzIm07w1TQTU
         OCmphbRpCJOR56dPLKuiBdU96VrSMeLdJ19/WVFKSHBo1JTBhOTNG6kfuynkliImHW
         hyGfC/bEBH//Q==
Date:   Mon, 11 Jul 2022 15:42:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the irqchip tree
Message-ID: <20220711154252.4b88a601@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FMljXGzHqt3Nk71inhp2pJP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FMljXGzHqt3Nk71inhp2pJP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the irqchip tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/gpio/gpio-thunderx.c:18:
include/asm-generic/msi.h:32:3: error: conflicting types for 'msi_alloc_inf=
o_t'; have 'struct msi_alloc_info'
   32 | } msi_alloc_info_t;
      |   ^~~~~~~~~~~~~~~~
In file included from include/linux/gpio/driver.h:15,
                 from drivers/gpio/gpio-thunderx.c:10:
arch/x86/include/asm/msi.h:7:31: note: previous declaration of 'msi_alloc_i=
nfo_t' with type 'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
    7 | typedef struct irq_alloc_info msi_alloc_info_t;
      |                               ^~~~~~~~~~~~~~~~
drivers/gpio/gpio-thunderx.c: In function 'thunderx_gpio_populate_parent_al=
loc_info':
drivers/gpio/gpio-thunderx.c:416:34: error: initialization of 'msi_alloc_in=
fo_t *' {aka 'struct msi_alloc_info *'} from incompatible pointer type 'msi=
_alloc_info_t *' {aka 'struct irq_alloc_info *'} [-Werror=3Dincompatible-po=
inter-types]
  416 |         msi_alloc_info_t *info =3D &gfwspec->msiinfo;
      |                                  ^
cc1: all warnings being treated as errors

Caused by commit

  91a29af413de ("gpio: Remove dynamic allocation from populate_parent_alloc=
_arg()")

I have used the irqchip tree from next-20220707 again for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/FMljXGzHqt3Nk71inhp2pJP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLuFwACgkQAVBC80lX
0GynOwgAkR6PuOkGUZlu8LTjAecEIuhcyCZpm+Rmh/CYKq5UT0tRVrPpSG7+nEYZ
RkOSSb/XfuzTf3nyyRHhrVkCHVptNxGQgOESBgpalC4niQY0E3YuphQ8Ca/TK2pV
DZw+OX7WIq8ULVuG+2FmblE1IcKmBN7SXcXRbsxQjwCTcNvWyrrxD/gALATLB9bf
0RZieTstfArr2rqWEi0KiT+Ajl63/0Fem8xfqrB5Exn7If+CVx6mTG+iWuJ9cs0c
+hL+kM3mKlpKIbHj/NjHDvaHsz462M6sJSXm05nkjG7naxutjQZn+FWaTBd3hKFH
vWpxpuv37I5jVXDjO9Mpi06k75NG3g==
=7mdw
-----END PGP SIGNATURE-----

--Sig_/FMljXGzHqt3Nk71inhp2pJP--

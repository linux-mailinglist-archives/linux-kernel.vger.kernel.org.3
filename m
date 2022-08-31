Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226015A79CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiHaJLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiHaJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:11:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D51B07D5;
        Wed, 31 Aug 2022 02:11:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHdh31k36z4xG6;
        Wed, 31 Aug 2022 19:10:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661937059;
        bh=1tJE7MMD2g/Qq/1LgzoAg1lXR0RQ30q7LvrpouAxyQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=hGQVMKCrWSrt0SN3zoPEpA/iHMQb9niy7yMO6fTiPe5xINojjA18nqFGYfQlAJV38
         yaokmcQqZ55vQ4TLlvPKxWTHaiq3HNCjgFVYCTtgc+kXbBflDjZonprYqj4LKXSDTj
         JjeWilIzmuVTkLXeCmEvmX1xWTpyBC3duF7ur3KVzKWJM2j7xRk1x/F6TKNC8GSCcQ
         BL3nJhW38sxtzVQOq2/aCnBduqHHwvz+qhui5TJF/kaWvVNKVFUE9pvvRXQqDFgDSX
         Ot/pVUiymexfgmK9/mIw/JaWf43cghnbfdPP6/RNOoXiV2pd1RWaJ2U9Xr7xCO6jh5
         yE21JvgRyiP8g==
Date:   Wed, 31 Aug 2022 19:10:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: linux-next: build failure after merge of the arm tree
Message-ID: <20220831191055.16f85948@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4vgq=gpeq8=aX8iXKTRonxY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4vgq=gpeq8=aX8iXKTRonxY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm tree, today's linux-next build (quite a few
including arm allnoconfig clang-16, arm allnoconfig gcc-10) failed
like this:

ld.lld: error: undefined symbol: phys_initrd_start
   or
init.c:(.init.text+0xd4): undefined reference to `phys_initrd_start'

Caused by commit

  b35b2736b43d ("ARM: 9230/1: Support initrd with address in boot alias reg=
ion")

--=20
Cheers,
Stephen Rothwell

--Sig_/4vgq=gpeq8=aX8iXKTRonxY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMPJZ8ACgkQAVBC80lX
0Gy9GggAgeq/7Z/OyTbEFO/IdxikYoatYEX3K5Ag+VWGPByv/zjbKbIkMK1++u2i
uCs5MrxK6GXzwLIJ7+/IJ+kipesNeDx4zyJaV6QPcVJmQ+pnlc4lZ0O15vZmLwus
hPsG36weL71Wiv+U8sqUZMDuzNaIqmA+ysxJuV84QWrUywmByoA2wDMjXcarKYT/
aeeEjF/qzXkk5lDJboUfCmPVfWQJncmMMB33elhXazNPzEGcTjrMR6xy521Y8KDw
h3neKZ6Wva1wow/0yF1e4ARO22wLSu6dZpFvR9YbZXeLbLH3Fmig/PDbjSyyoM0b
rDU4+Qdl/KKfpnGdkl4NuWPQkt/r5w==
=rnfl
-----END PGP SIGNATURE-----

--Sig_/4vgq=gpeq8=aX8iXKTRonxY--

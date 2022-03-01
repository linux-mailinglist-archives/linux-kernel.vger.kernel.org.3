Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B5C4C82DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiCAFPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCAFPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:15:15 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A81C4EF61;
        Mon, 28 Feb 2022 21:14:33 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K755c0yDdz4xbw;
        Tue,  1 Mar 2022 16:14:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646111669;
        bh=H8Fune5d6YVjvTlIxWcRKgVpwiDPXgX7uZrC0dJaG/A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ffn92t4J2om/wR00NgH12ApgqsP9qCazoq1DpxlfWmr2zDNYTk2qmaMgJxlmqjgQS
         S0s7BwKm9/L781aIzZpDZ1k70LNvXKXOzykADyhAqcm5j+b16L7kuF4bhnPnyJuDLL
         sqw3zLvPx1GhNlYipgPjwqmbUGWQaorT7WCnFX2k4d9es5mZhCGUGieh44v+3rMYRK
         fXVTKWhDqtKZyrsabWfQbZS72uCzwhCRaId6BanzAiEQPq80GRtzSwoApd4bWX+3F8
         AFNRZWp8vTUcFuq2TiuHZIhvE86fQdZonBq3y0OFfYCAbY0cy2eCr0N2rLrrw9SRgf
         jZ9AKMS+fzAAw==
Date:   Tue, 1 Mar 2022 16:14:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the char-misc tree
Message-ID: <20220301161426.0218d519@canb.auug.org.au>
In-Reply-To: <YhpCcE19y3sGqLQ3@kroah.com>
References: <20220225204055.3899986-1-broonie@kernel.org>
        <YhpCcE19y3sGqLQ3@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oH0An4cK9raxBdT22Ad.OEu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oH0An4cK9raxBdT22Ad.OEu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 26 Feb 2022 16:08:32 +0100 Greg KH <gregkh@linuxfoundation.org> wro=
te:
>
> On Fri, Feb 25, 2022 at 08:40:55PM +0000, broonie@kernel.org wrote:
> >=20
> > After merging the char-misc tree, today's linux-next build (x86
> > allmodconfig) failed like this:
> >=20
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sd_requ=
est':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:809:17: error: unused=
 variable 'dev' [-Werror=3Dunused-variable]
> >   809 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_s=
et_ios':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1084:17: error: unuse=
d variable 'dev' [-Werror=3Dunused-variable]
> >  1084 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_g=
et_ro':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1133:17: error: unuse=
d variable 'dev' [-Werror=3Dunused-variable]
> >  1133 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_g=
et_cd':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1159:17: error: unuse=
d variable 'dev' [-Werror=3Dunused-variable]
> >  1159 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_s=
witch_voltage':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1258:17: error: unuse=
d variable 'dev' [-Werror=3Dunused-variable]
> >  1258 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c: In function 'sdmmc_e=
xecute_tuning':
> > /tmp/next/build/drivers/mmc/host/rtsx_pci_sdmmc.c:1311:17: error: unuse=
d variable 'dev' [-Werror=3Dunused-variable]
> >  1311 |  struct device *dev =3D &host->pdev->dev;
> >       |                 ^~~
> > cc1: all warnings being treated as errors
> >=20
> > Caused by commit
> >=20
> >   7570fb41e450ba37 ("mmc: rtsx: Let MMC core handle runtime PM")
> >=20
> > I have used the char-misc tree from yesterday instead. =20
>=20
> Kai-Heng, can you send an add-on patch to fix this?
>=20
> thanks,

I am still getting these build errors.

--=20
Cheers,
Stephen Rothwell

--Sig_/oH0An4cK9raxBdT22Ad.OEu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIdq7IACgkQAVBC80lX
0GzmFwf9HJMF/qsEVM6oImsrYPgoAFirrQDKkyonF5GkBnR0QMkzQeCCsB74S+jI
VxyAi+Uzba2fCEPSKPbziirlBatSLXU1LIg500T13ghzCOyJRDkwAb4znqgNhimp
F39RAaXC+jLAwSRCnP0atI9UMBh2JrG9XXy7uYGL5UN5YO2Fgfom1H/sL5QR2krn
yy/9unUblA/hr/RRFf+U0FRI3oGmgcPeP5ZMQ+BgpdGAuiNIymTAvskerl4dbGhO
QbN2IZ5dTtXMYZkn69UpOjU9zybP+ZslHvLINHY6yQuFeHnXoQLHA0XSCsKobHPM
8mbgQwPo37nw0w3LUuVZpSt7+29Ruw==
=FZiu
-----END PGP SIGNATURE-----

--Sig_/oH0An4cK9raxBdT22Ad.OEu--

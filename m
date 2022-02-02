Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199B24A76EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346291AbiBBRfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:35:05 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:36819 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiBBRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:35:04 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F11ED60009;
        Wed,  2 Feb 2022 17:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643823303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XJHM+S//eHV18bv/SGD+WZqBPCD5hy69+eUdTMxC6h0=;
        b=kYQR8I+pQgC9KMkWLja+W9U1hwj5aIiNVtvBSnzRcKeTSkS+cF++rw2qiFTIry5a6u9uEV
        ferGhvAmCNn41tnjR8OHH/5ZccxPjZGiRFZ85qUA2wv4VGOwvdtgRrUeoIAnm1ALIL5HNf
        /QZRWsltd1PcURebCNx89k/W05R/UUTCSV9l6lcQFj4Y6I4bodhIL3GI4l2zLqT5NnNeM6
        agaMXgpFi3W54UnG2nMhkttarGiJP8dCBpKrIGmiqF0FEg2O/5dX/JI4gsRP3WyVmxx3GX
        RuR19okU/W2uQ5LsXP67T8Cg2XrJrnCyY9+51z2RreoTbcvVgsNiO7hV3u5FEg==
Date:   Wed, 2 Feb 2022 18:35:00 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 30/30] ld.lld: error: undefined symbol:
 nand_ecc_unregister_on_host_hw_engine
Message-ID: <20220202183500.7e4ef7cb@xps13>
In-Reply-To: <YfquJwtbg/hF5WJF@sirena.org.uk>
References: <202202011308.a6RlPiGp-lkp@intel.com>
        <20220202154504.7737deed@xps13>
        <YfqhJZ+BzfMrpN4Y@sirena.org.uk>
        <20220202163452.746d50ca@xps13>
        <YfquJwtbg/hF5WJF@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

broonie@kernel.org wrote on Wed, 2 Feb 2022 16:15:35 +0000:

> On Wed, Feb 02, 2022 at 04:34:52PM +0100, Miquel Raynal wrote:
> > > On Wed, Feb 02, 2022 at 03:45:04PM +0100, Miquel Raynal wrote: =20
>=20
> > > > I've failed to prevent faulty configurations with regular depends
> > > > on/select keywords, so I've come with a new solution which received=
 a
> > > > successful build coverage test from the 0-day robots.   =20
>=20
> > > > In order to still be able to use the spi controller driver (=3Dy) w=
hile
> > > > mtd is =3Dm or =3Dn, I need to add an IS_REACHABLE() check in a cou=
ple of
> > > > headers. This way we can just imply the right MTD symbols from the
> > > > SPI_MXIC Kconfig entry.   =20
>=20
> > > Isn't this just a case where we shouldn't allow MTD to be built modul=
ar? =20
>=20
> > How would you do that in a nice Kconfig way? =20
>=20
> depends on MTD=3Dy if SPI_MXC=3Dy

In this case I believe we should also add

depends on MTD=3Dm if SPI_MXC=3Dm ?

Anyway, this would force building the ECC support (and MTD...) even
though we don't need it in most cases.

My idea was to give people the right to only select SPI_MXIC without
really caring about MTD/ECC support at all because this is IMHO a
valid use case. We would then save a few kiB of extra MTD fat.

What do you think?

Thanks,
Miqu=C3=A8l

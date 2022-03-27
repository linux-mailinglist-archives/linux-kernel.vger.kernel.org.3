Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE64E88CD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbiC0QTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbiC0QTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:19:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E89F11C1F;
        Sun, 27 Mar 2022 09:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16CBD6101C;
        Sun, 27 Mar 2022 16:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A94C340EC;
        Sun, 27 Mar 2022 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648397894;
        bh=iHeFz+xrKE7uKuB/dUPpK+m1qKZRqb6P9qUhGKMhVc4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UqOSShuycOk/6K5gIR8uAkzvdpgPetj2hk6s3OBeMLm/BDftz8OYYIG8w/gWWrJFR
         ascTdifwpW950Dp/nMx9yEIpzQNd81iDPyvUIPRi9sZCO6V72wpTeteLylac7+2i5w
         XoBYSDEGEb5mo6qPx6oTnfaACAq71k+80Ppk2XUj/uuDOSeiVoKfUQoTZQs6n6rbh+
         +LV1rr5p9cSHw0gEFU2DCU/Lo3KS3pwfYNmnEIBn51tNBBBhtks5mCtExISx7YsX+c
         kPC+vfHIVYRu1U14wBKcLLKUDItzB79CdP0kL0aGtMuLDqJKqWT7yOHCajLucAl3DB
         s9H2223sIMaQQ==
Date:   Sun, 27 Mar 2022 17:25:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>,
        "cj.chengjian@huawei.com" <cj.chengjian@huawei.com>,
        "liwei391@huawei.com" <liwei391@huawei.com>,
        "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for ADMV8818
Message-ID: <20220327172546.40497743@jic23-huawei>
In-Reply-To: <PH0PR03MB67860473C10499C1EEED1C0A99169@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220320055457.254983-1-bobo.shaobowang@huawei.com>
        <PH0PR03MB67860473C10499C1EEED1C0A99169@PH0PR03MB6786.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 09:10:01 +0000
"Sa, Nuno" <Nuno.Sa@analog.com> wrote:

> > -----Original Message-----
> > From: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > Sent: Sunday, March 20, 2022 6:55 AM
> > Cc: cj.chengjian@huawei.com; liwei391@huawei.com;
> > bobo.shaobowang@huawei.com; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> > linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org;
> > jic23@kernel.org; Jonathan.Cameron@huawei.com
> > Subject: [PATCH v2] iio:filter:admv8818: select REGMAP_SPI for
> > ADMV8818
> >=20
> > [External]
> >=20
> > admv8818 driver needs __devm_regmap_init_spi() which is defined
> > when CONFIG_REGMAP_SPI is set and struct regmap_config when
> > CONFIG_REGMAP is set, so automatically select CONFIG_REGMAP_SPI
> > which also sets CONFIG_REGMAP.
> >=20
> > Fixes: f34fe888ad05 ("iio:filter:admv8818: add support for ADMV8818")
> > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git but I'll not push that tree o=
ut
until I have had a chance to rebase on rc1.

Thanks,

Jonathan

>=20
> >  drivers/iio/filter/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/iio/filter/Kconfig b/drivers/iio/filter/Kconfig
> > index 3ae35817ad82..a85b345ea14e 100644
> > --- a/drivers/iio/filter/Kconfig
> > +++ b/drivers/iio/filter/Kconfig
> > @@ -8,6 +8,7 @@ menu "Filters"
> >  config ADMV8818
> >  	tristate "Analog Devices ADMV8818 High-Pass and Low-Pass
> > Filter"
> >  	depends on SPI && COMMON_CLK && 64BIT
> > +	select REGMAP_SPI
> >  	help
> >  	  Say yes here to build support for Analog Devices ADMV8818
> >  	  2 GHz to 18 GHz, Digitally Tunable, High-Pass and Low-Pass
> > Filter.
> > --
> > 2.25.1 =20
>=20


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5954ACD4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242713AbiFNJCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242692AbiFNJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:02:40 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9BA2717F;
        Tue, 14 Jun 2022 02:02:36 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C03BCE001B;
        Tue, 14 Jun 2022 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1655197355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VkpGiXPoXaWOWQvypa0vCIM+uO/ijHmOl4KXjKbX0k=;
        b=ZYsOgvJ4SheAj9johdMIEhkWhCZFkH3Rp+m6pvTevjhTrUmiZ/5WPeF0H+1A91/xUTGqIl
        06rgGRGplqFKBI9bxayGayLsIE4YQ8468mhQ6tDsD94gcKo2kppaa8wqQH8hqgK96AGfAi
        72esq1VG+/pvs2iYl2IsqWmTeh9UDHAPLO7ItL7Rr6BuyNeIq8D2wsbxCQldaHDkUzbVdU
        TMtI2jTGzKy8vmG7FVh+ONC3wMto4Qi0dcIHP7NKfuGgwoRMWIyaqAZ0Ee+rrV2ltoSUmB
        sIL3iI7WgyJ81OI/RWvsKU00LdLmV19EHAq3R01/xFLk1gmxcXMU5UdMsd9Phg==
Date:   Tue, 14 Jun 2022 11:02:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 2/2] nvmem: add driver handling U-Boot environment
 variables
Message-ID: <20220614110230.46fab506@xps-13>
In-Reply-To: <20220614074657.GQ2387@pengutronix.de>
References: <20220611204651.19947-1-zajec5@gmail.com>
        <20220611204651.19947-2-zajec5@gmail.com>
        <20220614074657.GQ2387@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > +static int u_boot_env_probe(struct platform_device *pdev)
> > +{
> > +	struct nvmem_config config =3D {
> > +		.name =3D "u-boot-env",
> > +		.reg_read =3D u_boot_env_read,
> > +	};
> > +	struct device *dev =3D &pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	const struct of_device_id *of_id;
> > +	struct u_boot_env *priv;
> > +	int err;
> > +
> > +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +	priv->dev =3D dev;
> > +
> > +	of_id =3D of_match_device(u_boot_env_of_match_table, dev);
> > +	if (!of_id)
> > +		return -EINVAL;
> > +	priv->format =3D (uintptr_t)of_id->data;
> > +
> > +	if (of_property_read_u32(np, "reg", (u32 *)&priv->offset) ||
> > +	    of_property_read_u32_index(np, "reg", 1, (u32 *)&priv->size)) {
> > +		dev_err(dev, "Failed to read \"reg\" property\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	priv->mtd =3D of_get_mtd_device_by_node(np->parent);
> > +	if (IS_ERR(priv->mtd)) {
> > +		dev_err(dev, "Failed to get %pOF MTD: %ld\n", np->parent, PTR_ERR(pr=
iv->mtd));
> > +		return PTR_ERR(priv->mtd);
> > +	} =20
>=20
> Partitions are mtd devices themselves and the mtd layer directly
> associates these devices to their OF node, so it should be possible
> to do a of_get_mtd_device_by_node(np) which gets you the partition.
> You can use the whole mtd device then and do not have to fiddle with
> reg properties, offsets and sizes in your driver yourself.

Just for the record, there will be one mtd device per partition, but
the "full" mtd device will only exist if the configuration contains
CONFIG_MTD_PARTITIONED_MASTER.

Thanks,
Miqu=C3=A8l

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F44252A422
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348278AbiEQOCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348239AbiEQOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:02:32 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB4A3CFDC;
        Tue, 17 May 2022 07:02:30 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5A6B9C000A;
        Tue, 17 May 2022 14:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652796149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFYtPsh6s9dzHCZdoQzXiCPCMhM47AP7OmBzXLX/B4I=;
        b=HX3COE9t4BRjmNMfjKgyvM1XLP0ODDvStZTU9hi+qbFefEzb79wkyXSKSQ0swG9xtgopkp
        kb7BtpESwuOEj9NiHLMXQh7vzERBwIDFqVsEXb2o5tUrd/4HAhgCi9d/tPP+WsuM9+ADvb
        pXz+EhPuk8RNXC4x4/Pz7cJ1/lsu/BuoJvQOHeCWerF4kvc3BcLs0XV18/B/N3F/nHNlqo
        aKdG+rRP5Q6cwMAcSeS3UXQszTUk+Hj4MNKBWgsbFp+fqlESJEqFbmwzM2AOcPMUcSVwVz
        mL6e0HBgioq6t9FeejYiruQ6+O6DUlqHUkC8kWqR+koXOTxDkmfWo/xFvbmFBw==
Date:   Tue, 17 May 2022 16:02:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 3/6] mtd: spi-nor: core: run calibration when
 initialization is done
Message-ID: <20220517160226.4107f282@xps-13>
In-Reply-To: <20210311191216.7363-4-p.yadav@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
        <20210311191216.7363-4-p.yadav@ti.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pratyush,

p.yadav@ti.com wrote on Fri, 12 Mar 2021 00:42:13 +0530:

> Once the flash is initialized tell the controller it can run
> calibration procedures if needed. This can be useful when calibration is
> needed to run at higher clock speeds.
>=20
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> ---
>  drivers/mtd/spi-nor/core.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 88888df009f0..e0cbcaf1be89 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3650,6 +3650,7 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  	 * checking what's really supported using spi_mem_supports_op().
>  	 */
>  	const struct spi_nor_hwcaps hwcaps =3D { .mask =3D SNOR_HWCAPS_ALL };
> +	struct spi_mem_op op;
>  	char *flash_name;
>  	int ret;
> =20
> @@ -3709,8 +3710,15 @@ static int spi_nor_probe(struct spi_mem *spimem)
>  	if (ret)
>  		return ret;
> =20
> -	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> -				   data ? data->nr_parts : 0);
> +	ret =3D mtd_device_register(&nor->mtd, data ? data->parts : NULL,
> +				  data ? data->nr_parts : 0);
> +	if (ret)
> +		return ret;
> +
> +	op =3D spi_nor_spimem_get_read_op(nor);

Isn't this too specific? I really don't know much about spi-nors, but I
find odd to have this op being created here, why not moving this into
the _do_calibration() helper?

> +	spi_mem_do_calibration(nor->spimem, &op);

A warning/info upon calibration error (not on the absence of the hook)
would be nice?

> +
> +	return 0;
>  }
> =20
>  static int spi_nor_remove(struct spi_mem *spimem)

Otherwise I like the overall idea.

Thanks,
Miqu=C3=A8l

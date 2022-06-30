Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F8561330
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbiF3H0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiF3H0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:26:10 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAA3879C;
        Thu, 30 Jun 2022 00:26:08 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5C3B810000C;
        Thu, 30 Jun 2022 07:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656573966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbHADpDXYr/X5U7Qq4I3DXnnwEmjtF/efxJQ5ykP7Io=;
        b=VherGTDEfCbIuQysIFuAAJsl6Ygh2UoZMdw+yIdXK2X5fZ8d11J5vIhR/7MQtz3xKOt73Y
        K9iEIF+mDDrNpg3TX0aMXuLLE/O/nfzayqXQ/mBvf5ITXEE7cCyzKOguOiTyhaHVoZ8RNq
        yjI3bEpAgxb0qxcHG7QwnMDWdGB9eEqB1NtvIRevfN1BSKWnSHhFvPBgoFt/TYPePBlYAc
        BygPdlDjczkRo9yZCNecazZuGo+pE1TSxp/532OeL3UjaZ7izxi2jFf4lgjHIg7JfBlBc2
        e21eQOgI9zwOz8TA+mBYNx/5PRKQDgGfhKq/Dr1p3oa2cs7pVD9FnHIKbdA/Mg==
Date:   Thu, 30 Jun 2022 09:25:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] memory: renesas-rpc-if: Pass device instead of
 rpcif to rpcif_*()
Message-ID: <20220630092552.68a8b3ff@xps-13>
In-Reply-To: <e313b7f9a856fd8546aabb20d44d10e3af6676c6.1656341824.git.geert+renesas@glider.be>
References: <cover.1656341824.git.geert+renesas@glider.be>
        <e313b7f9a856fd8546aabb20d44d10e3af6676c6.1656341824.git.geert+renesas@glider.be>
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

Hi Krzysztof,

geert+renesas@glider.be wrote on Mon, 27 Jun 2022 17:31:13 +0200:

> Most rpcif_*() API functions do not need access to any other fields in
> the rpcif structure than the device pointer.  Simplify dependencies by
> passing the device pointer instead.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/memory/renesas-rpc-if.c | 32 ++++++++++++++++----------------
>  drivers/mtd/hyperbus/rpc-if.c   | 18 +++++++++---------

[...]

> diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
> index d00d302434030b20..41734e337ac00e40 100644
> --- a/drivers/mtd/hyperbus/rpc-if.c
> +++ b/drivers/mtd/hyperbus/rpc-if.c
> @@ -56,7 +56,7 @@ static void rpcif_hb_prepare_read(struct rpcif *rpc, vo=
id *to,
>  	op.data.nbytes =3D len;
>  	op.data.buf.in =3D to;
> =20
> -	rpcif_prepare(rpc, &op, NULL, NULL);
> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
>  }
> =20
>  static void rpcif_hb_prepare_write(struct rpcif *rpc, unsigned long to,
> @@ -70,7 +70,7 @@ static void rpcif_hb_prepare_write(struct rpcif *rpc, u=
nsigned long to,
>  	op.data.nbytes =3D len;
>  	op.data.buf.out =3D from;
> =20
> -	rpcif_prepare(rpc, &op, NULL, NULL);
> +	rpcif_prepare(rpc->dev, &op, NULL, NULL);
>  }
> =20
>  static u16 rpcif_hb_read16(struct hyperbus_device *hbdev, unsigned long =
addr)
> @@ -81,7 +81,7 @@ static u16 rpcif_hb_read16(struct hyperbus_device *hbde=
v, unsigned long addr)
> =20
>  	rpcif_hb_prepare_read(&hyperbus->rpc, &data, addr, 2);
> =20
> -	rpcif_manual_xfer(&hyperbus->rpc);
> +	rpcif_manual_xfer(hyperbus->rpc.dev);
> =20
>  	return data.x[0];
>  }
> @@ -94,7 +94,7 @@ static void rpcif_hb_write16(struct hyperbus_device *hb=
dev, unsigned long addr,
> =20
>  	rpcif_hb_prepare_write(&hyperbus->rpc, addr, &data, 2);
> =20
> -	rpcif_manual_xfer(&hyperbus->rpc);
> +	rpcif_manual_xfer(hyperbus->rpc.dev);
>  }
> =20
>  static void rpcif_hb_copy_from(struct hyperbus_device *hbdev, void *to,
> @@ -105,7 +105,7 @@ static void rpcif_hb_copy_from(struct hyperbus_device=
 *hbdev, void *to,
> =20
>  	rpcif_hb_prepare_read(&hyperbus->rpc, to, from, len);
> =20
> -	rpcif_dirmap_read(&hyperbus->rpc, from, len, to);
> +	rpcif_dirmap_read(hyperbus->rpc.dev, from, len, to);
>  }
> =20
>  static const struct hyperbus_ops rpcif_hb_ops =3D {
> @@ -130,9 +130,9 @@ static int rpcif_hb_probe(struct platform_device *pde=
v)
> =20
>  	platform_set_drvdata(pdev, hyperbus);
> =20
> -	rpcif_enable_rpm(&hyperbus->rpc);
> +	rpcif_enable_rpm(hyperbus->rpc.dev);
> =20
> -	error =3D rpcif_hw_init(&hyperbus->rpc, true);
> +	error =3D rpcif_hw_init(hyperbus->rpc.dev, true);
>  	if (error)
>  		goto out_disable_rpm;
> =20
> @@ -150,7 +150,7 @@ static int rpcif_hb_probe(struct platform_device *pde=
v)
>  	return 0;
> =20
>  out_disable_rpm:
> -	rpcif_disable_rpm(&hyperbus->rpc);
> +	rpcif_disable_rpm(hyperbus->rpc.dev);
>  	return error;
>  }

This will only apply on top of mtd/next, because that
rpcif_disable_rpm() balance call was very recently contributed by Geert:
https://lore.kernel.org/linux-mtd/f3070e1af480cb252ae183d479a593dbbf947685.=
1655457790.git.geert+renesas@glider.be/

So we need to first share an immutable tag on the current mtd/next
branch. Richard, that is my vacation gift for you :)

Otherwise,

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

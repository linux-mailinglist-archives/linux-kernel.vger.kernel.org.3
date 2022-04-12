Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B994FDA2B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355294AbiDLIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354931AbiDLH1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:00 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C03134BBE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 00:06:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D03D2100006;
        Tue, 12 Apr 2022 07:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649747213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hHE9xZlRw6yCvZ9NF+G39h3IwPXo9JEMBwpXiVM9BZY=;
        b=pop483FddIsrAJGnsnh4fpMhHQtW9fV5e+RCouMqROZqVSvYzfxHBAg/OdfnS6aIQJPDL6
        Xa8gFv8mzozSV0dnTOAn/eKoVLCEAuf34G2l+3xQsuQPvxb2EJYhpjqD2yQKN+HBB2/XDz
        BEcUjiLn3nvM6XkRdIHOBmnjCdH8J2lJ/3jL3c4kRweGp8ZWuKOto11K4N5ZN2cnJnuJsf
        lip2hfwR/6V6rcfKo9PhxpU3G7o/S/5cotLqIAwMNKMo89eRFLwl5tBInVnQlUtACV017C
        j0cEVktrqX1+sHtiCaIBbUg2ZuJqN0+EV3LqRQVZlUWkctqlRo9GvuicB4L5Og==
Date:   Tue, 12 Apr 2022 09:06:49 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Message-ID: <20220412090649.33bb3f8b@xps13>
In-Reply-To: <20220412063703.8537-1-linmq006@gmail.com>
References: <202204121253.NcZifMQi-lkp@intel.com>
        <20220412063703.8537-1-linmq006@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

Hi Miaoqian,

linmq006@gmail.com wrote on Tue, 12 Apr 2022 06:36:52 +0000:

> wait_for_completion_timeout() returns unsigned long not int.
> It returns 0 if timed out, and positive if completed.
> The check for <=3D 0 is ambiguous and should be =3D=3D 0 here
> indicating timeout which is the only error case.
>=20
> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> change in v2:
> - initialize ret to 1.
> ---
>  drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_fl=
ctl.c
> index b85b9c6fcc42..2373251f585b 100644
> --- a/drivers/mtd/nand/raw/sh_flctl.c
> +++ b/drivers/mtd/nand/raw/sh_flctl.c
> @@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *=
flctl, unsigned long *buf,
>  	dma_addr_t dma_addr;
>  	dma_cookie_t cookie;
>  	uint32_t reg;
> -	int ret;
> +	int ret =3D 1;

Does not look right. I know this function returns > 0 on positive
outcomes but this does not make any sense in the first place.

This function is static and only called twice, please turn it into
something like:

if (dma_fifo_transfer())
	error
else
	ok

> +	unsigned long time_left;
> =20
>  	if (dir =3D=3D DMA_FROM_DEVICE) {
>  		chan =3D flctl->chan_fifo0_rx;
> @@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl=
 *flctl, unsigned long *buf,
>  		goto out;
>  	}
> =20
> -	ret =3D
> +	time_left =3D
>  	wait_for_completion_timeout(&flctl->dma_complete,
>  				msecs_to_jiffies(3000));
> =20
> -	if (ret <=3D 0) {
> +	if (time_left =3D=3D 0) {
>  		dmaengine_terminate_all(chan);
>  		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
> +		ret =3D -ETIMEDOUT;
>  	}
> =20
>  out:


Thanks,
Miqu=C3=A8l

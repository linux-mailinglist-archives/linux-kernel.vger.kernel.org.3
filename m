Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031B50661A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349507AbiDSHnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238657AbiDSHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:43:40 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3669BF50
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:40:56 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 134AD1BF204;
        Tue, 19 Apr 2022 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650354055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=of4YeTK1eJ00pFq6VieUlJBzisMH3rSgJqKoj0W85NI=;
        b=bcg8861t63+6BVYpGB0OsDpwva35+7JugamEk6l6VaV5mri9LyzSPrQ0CiBezR+t/k11MH
        oTtut1S2VfFHBoWP0kO1PCHWoVoDxthloH7LlxNdY20bLlw4AEhmyeoJkEeLwwFnDdChRJ
        O9cg9W0Jxf+cgz174Q5FGLgmbCGUSt+PcF+0hE5iz+whRvP5+3iuafrzCvL1U9KClt69SO
        uJMueiumos16vYue3bBk7ER8tN1ibEDHxj0qPvaMgm6WysfW/5GqjJ8z0tPwvNcXVu7LaV
        qzFnG3oOz0MEraSI2qV+MlPoPjjBswx4rT+LKdo2h0WYpbfG4lh2DoyhU6D/kw==
Date:   Tue, 19 Apr 2022 09:40:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     cgel.zte@gmail.com
Cc:     han.xu@nxp.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] mtd: nand: gpmi-nand: using pm_runtime_resume_and_get
 instead of pm_runtime_get_sync
Message-ID: <20220419094051.3bb9fe45@xps13>
In-Reply-To: <20220418105549.2558765-1-chi.minghao@zte.com.cn>
References: <20220418105549.2558765-1-chi.minghao@zte.com.cn>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

cgel.zte@gmail.com wrote on Mon, 18 Apr 2022 10:55:49 +0000:

> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code

Would you mind reducing a little bit the title of the commit? Othewise
fine by me.

>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nan=
d/raw/gpmi-nand/gpmi-nand.c
> index 44b14c9dc9a7..6e7477aef8a7 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -148,11 +148,9 @@ static int gpmi_init(struct gpmi_nand_data *this)
>  	struct resources *r =3D &this->resources;
>  	int ret;
> =20
> -	ret =3D pm_runtime_get_sync(this->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(this->dev);
> +	ret =3D pm_runtime_resume_and_get(this->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	ret =3D gpmi_reset_block(r->gpmi_regs, false);
>  	if (ret)
> @@ -544,11 +542,9 @@ static int bch_set_geometry(struct gpmi_nand_data *t=
his)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D pm_runtime_get_sync(this->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_autosuspend(this->dev);
> +	ret =3D pm_runtime_resume_and_get(this->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	/*
>  	* Due to erratum #2847 of the MX23, the BCH cannot be soft reset on this
> @@ -2286,11 +2282,9 @@ static int gpmi_nfc_exec_op(struct nand_chip *chip,
>  	for (i =3D 0; i < GPMI_MAX_TRANSFERS; i++)
>  		this->transfers[i].direction =3D DMA_NONE;
> =20
> -	ret =3D pm_runtime_get_sync(this->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(this->dev);
> +	ret =3D pm_runtime_resume_and_get(this->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
> =20
>  	/*
>  	 * This driver currently supports only one NAND chip. Plus, dies share


Thanks,
Miqu=C3=A8l

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1DD4F101D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377719AbiDDHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiDDHnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 03:43:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E1237D7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 00:41:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A6921BF20C;
        Mon,  4 Apr 2022 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649058064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NF/lJpAU/03I6K15u5g/9mSVcCQHoYVSaTao1w1uDOY=;
        b=js/pMYM+6GRo15VMAvIr6mlVXqnxs+Wy/XTidvHnkvi1yU16p8akkRvd7Fpo9AqsEiRiRY
        XlSpI2iFJXdu0nFG8xGxkGgZDkTG9YVCEXbtVHPjjuNCFwyMS5Q9hJVRe7hKtm9ivt3LAp
        pNZP1B1axMOKxWhrf/SJEsvfmL92N2ekSfUl9cLw/rv3V72f8joQ4Uwd8QVXbvj03MIAjW
        2whEKSr4OfY2FY2IAoOILxDIkn0CMo80LXkUntFiByoZ89mL6MuKHagpzsmtrrjKu8BSS7
        bSqqagwP7BLw2i0qHfkZZj0PnQGNO9HkAA88ayPT+RpDQ61EsFW1AscjqbRIow==
Date:   Mon, 4 Apr 2022 09:41:02 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: mxic: Fix an error handling path in
 mxic_spi_probe()
Message-ID: <20220404094102.48edaab5@xps13>
In-Reply-To: <09c81f751241f6ec0bac7a48d4ec814a742e0d17.1648980664.git.christophe.jaillet@wanadoo.fr>
References: <09c81f751241f6ec0bac7a48d4ec814a742e0d17.1648980664.git.christophe.jaillet@wanadoo.fr>
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

Hi Christophe,

christophe.jaillet@wanadoo.fr wrote on Sun,  3 Apr 2022 12:11:13 +0200:

> If spi_register_master() fails, we must undo a previous
> mxic_spi_mem_ecc_probe() call, as already done in the remove function.
>=20
> Fixes: 00360ebae483 ("spi: mxic: Add support for pipelined ECC operations=
")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/spi/spi-mxic.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
> index 55c092069301..65be8e085ab8 100644
> --- a/drivers/spi/spi-mxic.c
> +++ b/drivers/spi/spi-mxic.c
> @@ -813,6 +813,7 @@ static int mxic_spi_probe(struct platform_device *pde=
v)
>  	if (ret) {
>  		dev_err(&pdev->dev, "spi_register_master failed\n");
>  		pm_runtime_disable(&pdev->dev);
> +		mxic_spi_mem_ecc_remove(mxic);

I missed it, thanks!

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Cheers,
Miqu=C3=A8l

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013F4AD96B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiBHNSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiBHNGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:06:01 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B22C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:05:59 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id F3BEE20000A;
        Tue,  8 Feb 2022 13:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644325557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=II38vjLqRQLg/txnWaGaYMH5G+TMjmxUgp39Q+KTFOI=;
        b=cg78R25fOkgb5ywOTBX32Ds9RDk2APYA7e1uYvGLZfPi06/mTEq8+GkVPwGTaR1fLB1WVs
        MeA+3P/QBgqREUS/55SrecEY7vmpaW579tgSxLcqqHTqoO1BDIommGnumCSg+8i2aZNL5O
        m4E4t5GhKA6ICt0hiBOdfqaVhVhFCKj00Np/wM7cfEJjZrh22izqYdMuF3he0kmw7z5Cwm
        zcMMF++SjVytXqfTbvC3aprnLqBdYO/RWujfqLSLVQHiozdu7DAc0JckuC2AlQrnRykiE9
        ejCHAzAkhskQWJP59w3q/fys6innvYxgNfqEB/0ajLCHg8OQcMlC9/WzFn3lkw==
Date:   Tue, 8 Feb 2022 14:05:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     <vigneshr@ti.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>
Subject: Re: [PATCH] mtd: rawnand: pl353: Set the nand chip node as the
 flash node
Message-ID: <20220208140551.6271f976@xps13>
In-Reply-To: <20220208125738.32162-1-amit.kumar-mahapatra@xilinx.com>
References: <20220208125738.32162-1-amit.kumar-mahapatra@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

amit.kumar-mahapatra@xilinx.com wrote on Tue, 8 Feb 2022 18:27:38 +0530:

> In devicetree the flash information is embedded within nand chip node,
> so during nand chip initialization the nand chip node should be passed
> to nand_set_flash_node() api, instead of nand controller node.
>=20
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>

Can you please add Fixes tag?

> ---
> BRANCH: nand/next
> ---
>  drivers/mtd/nand/raw/pl35x-nand-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/n=
and/raw/pl35x-nand-controller.c
> index 8a91e069ee2e..3c6f6aff649f 100644
> --- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
> +++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
> @@ -1062,7 +1062,7 @@ static int pl35x_nand_chip_init(struct pl35x_nandc =
*nfc,
>  	chip->controller =3D &nfc->controller;
>  	mtd =3D nand_to_mtd(chip);
>  	mtd->dev.parent =3D nfc->dev;
> -	nand_set_flash_node(chip, nfc->dev->of_node);
> +	nand_set_flash_node(chip, np);
>  	if (!mtd->name) {
>  		mtd->name =3D devm_kasprintf(nfc->dev, GFP_KERNEL,
>  					   "%s", PL35X_NANDC_DRIVER_NAME);

yup, that was wrong.

Thanks,
Miqu=C3=A8l

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EA58CD9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243693AbiHHS0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 14:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHHS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 14:26:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1064DE82
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 11:26:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7751D61221
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E7BC433D6;
        Mon,  8 Aug 2022 18:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659983205;
        bh=0I9URx+gPUqGptctGVhHS9ZIOHnIDlJW8ZgwpkFQxRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5vCqzaw1oiiq5INwMNjZxnNeNYodQMwL8B+u48VrfHPniitIYQXejJkpXswPVj4h
         4l8qNBI/+U8fXlfzLsTYtSoKugUEg1jDcy9zOC00EypZekaH8NQmynX/TY970wToT9
         Fb5CioLa7uN/GkyBxByk0f0b1ZwdhOQDXrBP2Gt4rKhKRAFAsv1TmacYOyujC4Mozk
         YSD5dz7eUpesfLlXk4ROLWD2hQbxmRAqCZg3B9s96g7Nrq0c2bzAHtfw13WpbkfsQ/
         E+hbTrr3CskqUcVT+g8ULTJdWS8xsqpWTH7nITDmbylEYBBlUxiEqcgu2rVg5r90GQ
         SzDs5Tv8uiACw==
Received: by pali.im (Postfix)
        id 8CFF7F13; Mon,  8 Aug 2022 20:26:42 +0200 (CEST)
Date:   Mon, 8 Aug 2022 20:26:42 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fsl_elbc: Fix none ECC mode
Message-ID: <20220808182642.edlqreldxikje53l@pali>
References: <20220707184328.3845-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220707184328.3845-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Thursday 07 July 2022 20:43:28 Pali Rohár wrote:
> Commit f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work") added
> support for specifying ECC mode via DTS and skipping autodetection.
> 
> But it broke explicit specification of HW ECC mode in DTS as correct
> settings for HW ECC mode are applied only when NONE mode or nothing was
> specified in DTS file.
> 
> Also it started aliasing NONE mode to be same as when ECC mode was not
> specified and disallowed usage of ON_DIE mode.
> 
> Fix all these issues. Use autodetection of ECC mode only in case when mode
> was really not specified in DTS file by checking that ecc value is invalid.
> Set HW ECC settings either when HW ECC was specified in DTS or it was
> autodetected. And do not fail when ON_DIE mode is set.
> 
> Fixes: f6424c22aa36 ("mtd: rawnand: fsl_elbc: Make SW ECC work")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/mtd/nand/raw/fsl_elbc_nand.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsl_elbc_nand.c b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> index aab93b9e6052..a18d121396aa 100644
> --- a/drivers/mtd/nand/raw/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_elbc_nand.c
> @@ -726,36 +726,40 @@ static int fsl_elbc_attach_chip(struct nand_chip *chip)
>  	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
>  	unsigned int al;
>  
> -	switch (chip->ecc.engine_type) {
>  	/*
>  	 * if ECC was not chosen in DT, decide whether to use HW or SW ECC from
>  	 * CS Base Register
>  	 */
> -	case NAND_ECC_ENGINE_TYPE_NONE:
> +	if (chip->ecc.engine_type == NAND_ECC_ENGINE_TYPE_INVALID) {
>  		/* If CS Base Register selects full hardware ECC then use it */
>  		if ((in_be32(&lbc->bank[priv->bank].br) & BR_DECC) ==
>  		    BR_DECC_CHK_GEN) {
> -			chip->ecc.read_page = fsl_elbc_read_page;
> -			chip->ecc.write_page = fsl_elbc_write_page;
> -			chip->ecc.write_subpage = fsl_elbc_write_subpage;
> -
>  			chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_ON_HOST;
> -			mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
> -			chip->ecc.size = 512;
> -			chip->ecc.bytes = 3;
> -			chip->ecc.strength = 1;
>  		} else {
>  			/* otherwise fall back to default software ECC */
>  			chip->ecc.engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
>  			chip->ecc.algo = NAND_ECC_ALGO_HAMMING;
>  		}
> +	}
> +
> +	switch (chip->ecc.engine_type) {
> +	/* if HW ECC was chosen, setup ecc and oob layout */
> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		chip->ecc.read_page = fsl_elbc_read_page;
> +		chip->ecc.write_page = fsl_elbc_write_page;
> +		chip->ecc.write_subpage = fsl_elbc_write_subpage;
> +		mtd_set_ooblayout(mtd, &fsl_elbc_ooblayout_ops);
> +		chip->ecc.size = 512;
> +		chip->ecc.bytes = 3;
> +		chip->ecc.strength = 1;
>  		break;
>  
> -	/* if SW ECC was chosen in DT, we do not need to set anything here */
> +	/* if none or SW ECC was chosen, we do not need to set anything here */
> +	case NAND_ECC_ENGINE_TYPE_NONE:
>  	case NAND_ECC_ENGINE_TYPE_SOFT:
> +	case NAND_ECC_ENGINE_TYPE_ON_DIE:
>  		break;
>  
> -	/* should we also implement *_ECC_ENGINE_CONTROLLER to do as above? */
>  	default:
>  		return -EINVAL;
>  	}
> -- 
> 2.20.1
> 

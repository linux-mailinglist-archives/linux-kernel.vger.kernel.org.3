Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C052D48308F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbiACLcO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 06:32:14 -0500
Received: from aposti.net ([89.234.176.197]:56640 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231569AbiACLcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:32:12 -0500
Date:   Mon, 03 Jan 2022 11:32:02 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: Fix missing put_device in
 ingenic_ecc_get
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <EDT45R.P10AQNFPT9FP1@crapouillou.net>
In-Reply-To: <20211230072751.21622-1-linmq006@gmail.com>
References: <20211230072751.21622-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeu., déc. 30 2021 at 07:27:51 +0000, Miaoqian Lin 
<linmq006@gmail.com> a écrit :
> If of_find_device_by_node() succeeds, ingenic_ecc_get() doesn't have
> a corresponding put_device(). Thus add put_device() to fix the 
> exception
> handling.
> 
> Fixes: 15de8c6 ("mtd: rawnand: ingenic: Separate top-level and SoC 
> specific code")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c 
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> index efe0ffe4f1ab..9054559e52dd 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> @@ -68,9 +68,14 @@ static struct ingenic_ecc *ingenic_ecc_get(struct 
> device_node *np)
>  	struct ingenic_ecc *ecc;
> 
>  	pdev = of_find_device_by_node(np);
> -	if (!pdev || !platform_get_drvdata(pdev))
> +	if (!pdev)
>  		return ERR_PTR(-EPROBE_DEFER);
> 
> +	if (!platform_get_drvdata(pdev)) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
>  	ecc = platform_get_drvdata(pdev);
>  	clk_prepare_enable(ecc->clk);
> 
> --
> 2.17.1
> 



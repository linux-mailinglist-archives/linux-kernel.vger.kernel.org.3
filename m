Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10848AA33
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349182AbiAKJL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:11:26 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:48806 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349188AbiAKJLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:11:25 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7384894;
        Tue, 11 Jan 2022 10:11:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641892283;
        bh=WD0tw22/8L5IHQvf+LMKdWmE0PHO2LbdCXh8NZikC7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MzhL5A29hYKiSGEDqwAo5zANhTxkc4CilZy0HKR7DPXusfodRzBk7vtWy//74OSqG
         LCS6t8SpUyOznVctAVd7TBJSRIxiFPOBStmUWwkAuSv8/YJZYhAynjR9NZ0EJIjy+M
         w07eAwEHEn5WxwvuuVNOpxBgEANduZckZib5GtJ4=
Date:   Tue, 11 Jan 2022 11:11:12 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Watson Chow <watson.chow@avnet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] regulator: max20086: fix error code in
 max20086_parse_regulators_dt()
Message-ID: <Yd1JsCFiu5cqmS9N@pendragon.ideasonboard.com>
References: <20220111072657.GK11243@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220111072657.GK11243@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thank you for the patch.

On Tue, Jan 11, 2022 at 10:26:58AM +0300, Dan Carpenter wrote:
> This code accidentally returns PTR_ERR(NULL) which is success.  It
> should return a negative error code.

Oops, sorry.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Fixes: bfff546aae50 ("regulator: Add MAX20086-MAX20089 driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/regulator/max20086-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/max20086-regulator.c b/drivers/regulator/max20086-regulator.c
> index fbc56b043071..63aa6ec3254a 100644
> --- a/drivers/regulator/max20086-regulator.c
> +++ b/drivers/regulator/max20086-regulator.c
> @@ -140,7 +140,7 @@ static int max20086_parse_regulators_dt(struct max20086 *chip, bool *boot_on)
>  	node = of_get_child_by_name(chip->dev->of_node, "regulators");
>  	if (!node) {
>  		dev_err(chip->dev, "regulators node not found\n");
> -		return PTR_ERR(node);
> +		return -ENODEV;
>  	}
>  
>  	for (i = 0; i < chip->info->num_outputs; ++i)

-- 
Regards,

Laurent Pinchart

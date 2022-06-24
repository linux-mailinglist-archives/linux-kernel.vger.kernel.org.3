Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5A95598D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiFXLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiFXLpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A977A6FC;
        Fri, 24 Jun 2022 04:45:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78DB162229;
        Fri, 24 Jun 2022 11:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBE7C3411C;
        Fri, 24 Jun 2022 11:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656071099;
        bh=/juf5uhRx4ref2vuTs7Hpo06T65AVQbyQOqQDhjmWU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDFVvIZPp4ipTFbNzLCLY2ngcLnNYWoXHX/GzPbN8cyROyLW4td75MRwsyhRgn7zM
         cXka7AsavQuuFK7GAbINaUSf4rveA/+sfSUqHie0Z6MF2T0DGDipSwWMlGtc/iyfVa
         AmWiS7kApkn+paPWGLqt7+XBVclDlrb0caJvhd98=
Date:   Fri, 24 Jun 2022 13:36:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lewis.hanly@microchip.com, conor.dooley@microchip.com,
        b-liu@ti.com, linux-riscv@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix missing error code in mpfs_probe()
Message-ID: <YrWhyppxkpQQ6Y8U@kroah.com>
References: <20220624072515.123646-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624072515.123646-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 03:25:15PM +0800, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-ENOMEM' to the return value 'ret'.
> 
> This was found by coccicheck:
> 
> drivers/usb/musb/mpfs.c:185 mpfs_probe() warn: missing error code 'ret'.
> 
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/usb/musb/mpfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/mpfs.c b/drivers/usb/musb/mpfs.c
> index 99666ef8af06..c8bf6570bcc4 100644
> --- a/drivers/usb/musb/mpfs.c
> +++ b/drivers/usb/musb/mpfs.c
> @@ -181,8 +181,10 @@ static int mpfs_probe(struct platform_device *pdev)
>  	glue->clk = clk;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata)
> +	if (!pdata) {
> +		ret = -ENOMEM;
>  		goto err_clk_disable;
> +	}
>  
>  	pdata->config = &mpfs_musb_hdrc_config;
>  	pdata->platform_ops = &mpfs_ops;
> -- 
> 2.20.1.7.g153144c
> 

Dan beat you to it, and provided a better fix:
	https://lore.kernel.org/r/YrVmLEc/FOEzNdzj@kili

thanks,

greg k-h

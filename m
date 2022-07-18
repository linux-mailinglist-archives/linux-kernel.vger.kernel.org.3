Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD50257853C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiGROVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbiGROVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:21:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCB12D2E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:21:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B933760BAD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:21:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC48C341C0;
        Mon, 18 Jul 2022 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658154091;
        bh=HsbEQ0cup+GTbgFcZh5vi5cNabrvyGIm/P5WA/QPIbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xu5F5E/LR1H1VzQgpouo3xyCPUnXcSvnz2C+OAeAgOG/kOfP1XIpykPcFy/GQB+4y
         eY/mkUPYINJpezGclVZjMGjSbd0nDFEwe1S+Vfs7upLZwhWZU84/k2xjJ1vfoZr8ag
         dFe/3nXwYyFurk/mqjHQv2EdYqE17ITreCYMmAmM=
Date:   Mon, 18 Jul 2022 16:21:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH -next,v5] nvmem: core: Fix memleak in nvmem_register()
Message-ID: <YtVsZ9C0s62wUXc5@kroah.com>
References: <20220718123949.3111223-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718123949.3111223-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 08:39:49PM +0800, Gaosheng Cui wrote:
> dev_set_name will alloc memory for nvmem->dev.kobj.name in
> nvmem_register, when nvmem_validate_keepouts failed, nvmem's
> memory will be freed and return, but nobody will free memory
> for nvmem->dev.kobj.name, there will be memleak, so moving
> nvmem_validate_keepouts() after device_register() and let
> the device core deal with cleaning name in error cases.
> 
> Fixes: de0534df9347 ("nvmem: core: fix error handling while validating keepout regions")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/nvmem/core.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 1e3c754efd0d..2164efd12ba9 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -829,21 +829,18 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  	nvmem->dev.groups = nvmem_dev_groups;
>  #endif
>  
> -	if (nvmem->nkeepout) {
> -		rval = nvmem_validate_keepouts(nvmem);
> -		if (rval) {
> -			ida_free(&nvmem_ida, nvmem->id);
> -			kfree(nvmem);
> -			return ERR_PTR(rval);
> -		}
> -	}
> -
>  	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>  
>  	rval = device_register(&nvmem->dev);
>  	if (rval)
>  		goto err_put_device;
>  
> +	if (nvmem->nkeepout) {
> +		rval = nvmem_validate_keepouts(nvmem);
> +		if (rval)
> +			goto err_device_del;
> +	}
> +
>  	if (config->compat) {
>  		rval = nvmem_sysfs_setup_compat(nvmem, config);
>  		if (rval)
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:


- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

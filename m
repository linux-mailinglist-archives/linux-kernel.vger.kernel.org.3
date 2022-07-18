Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E66578533
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiGROUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiGROUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:20:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A24710A8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 07:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6DDFB815EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C30C341C0;
        Mon, 18 Jul 2022 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658154003;
        bh=rKO6+e1rmJn4MWBW235F+xjzGx/4PEdBSaThdZ0TQ5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dc8lOscqP+tBqM47cWg+d8Op/R3G1XOnxK6CUTiqQG21vvZsbKYl4UqD8BcdxS1T0
         BadKe2OPzPxpjfMY8evcjsheTUOMcwh1MHK/Yi+2mAINwpEjW34BaHsFKHwrtReoEh
         6E6mdaifhofwLHCQkvcz7b9rzsjIah2n33Nil2jA=
Date:   Mon, 18 Jul 2022 16:20:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        gongruiqi1@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH -next] nvmem: core: add error handling for dev_set_name
Message-ID: <YtVsENslBv/CMQv9@kroah.com>
References: <20220718133612.3200045-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718133612.3200045-1-cuigaosheng1@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 09:36:12PM +0800, Gaosheng Cui wrote:
> The type of return value of dev_set_name is int, which may return
> wrong result, so we add error handling for it to reclaim memory
> of nvmem resource, and return early when an error occurs.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/nvmem/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 2164efd12ba9..321d7d63e068 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -810,18 +810,24 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>  
>  	switch (config->id) {
>  	case NVMEM_DEVID_NONE:
> -		dev_set_name(&nvmem->dev, "%s", config->name);
> +		rval = dev_set_name(&nvmem->dev, "%s", config->name);
>  		break;
>  	case NVMEM_DEVID_AUTO:
> -		dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
> +		rval = dev_set_name(&nvmem->dev, "%s%d", config->name, nvmem->id);
>  		break;
>  	default:
> -		dev_set_name(&nvmem->dev, "%s%d",
> +		rval = dev_set_name(&nvmem->dev, "%s%d",
>  			     config->name ? : "nvmem",
>  			     config->name ? config->id : nvmem->id);
>  		break;
>  	}
>  
> +	if (rval) {
> +		ida_free(&nvmem_ida, nvmem->id);
> +		kfree(nvmem);
> +		return ERR_PTR(rval);
> +	}
> +
>  	nvmem->read_only = device_property_present(config->dev, "read-only") ||
>  			   config->read_only || !nvmem->reg_write;
>  
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

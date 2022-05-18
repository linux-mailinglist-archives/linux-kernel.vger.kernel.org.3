Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B03352B573
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiERIqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiERIqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF5E1DA51;
        Wed, 18 May 2022 01:46:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87426B81ED4;
        Wed, 18 May 2022 08:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E1C385A5;
        Wed, 18 May 2022 08:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652863560;
        bh=+KBdOkPfbel0JzOuikwQH/7ZizZgZt7pXPZZW85THGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JGF0Xb7n3sMBtHUMYuvZERKmhsUVg5ez+M5MQIopoIVrf+b6UJ7cS+8mg4Mi6i5sU
         wzg1fK2L14iMvS6spnjgiEYWgdH9AKJajTQmsQj3YvT2LpleID1h1xMQK75F7bK/FE
         3Q2l+XwoXIZHWk3msAEu49265DrKikP7IQmL4R+Y=
Date:   Wed, 18 May 2022 10:45:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        zbr@ioremap.net, jdelvare@suse.com, linux@roeck-us.net
Subject: Re: [PATCH -next] drivers: w1: drop unnecessary memset() in
 w1_master_release()
Message-ID: <YoSyRQbX/oH3UhFw@kroah.com>
References: <20220518080136.2686030-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518080136.2686030-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 04:01:36PM +0800, Yang Yingliang wrote:
> It's unnecessary to use memset() in w1_master_release() before
> the memory is freed, so remove it.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/w1/w1.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
> index f2ae2e563dc5..f4d1499bb853 100644
> --- a/drivers/w1/w1.c
> +++ b/drivers/w1/w1.c
> @@ -73,7 +73,6 @@ static void w1_master_release(struct device *dev)
>  	struct w1_master *md = dev_to_w1_master(dev);
>  
>  	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
> -	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
>  	kfree(md);
>  }
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

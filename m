Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4524A52337A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiEKM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiEKM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64960E15C8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA27361B80
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D295C3410F;
        Wed, 11 May 2022 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652273852;
        bh=uxHPMBN5yQXxmfO/0nUY2+0k1/gbgLaj1MLiANVXd8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFfdNix2hKtskXkXJMYEIhDw3mSEaepicBeEmRbu5MsTITaaxjCJNzsD9utlbWv2m
         PuLKddftGVdxA2ZaeJzDTXxtfTM5QvwhTWfR84bapyXEPxORQ23KJc/SFX+Q4TbD3h
         PG6rsmgjjWa4aEs6/J5fad0bK6S2KrV3D4vZxnxY=
Date:   Wed, 11 May 2022 14:57:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     rafael@kernel.org, ming.lei@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: base: fix UAF when driver_attach failed
Message-ID: <YnuyuFRaDTY2n4VB@kroah.com>
References: <20220511124336.66705-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511124336.66705-1-schspa@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 08:43:36PM +0800, Schspa Shi wrote:
> When driver_attach(drv); failed, the driver_private will be freed.
> But it has been added to the bus, which caused a UAF.
> 
> To fix it, we need to delete it from the bus when failed.
> 
> Fixes: 190888ac01d0 ("driver core: fix possible missing of device probe")
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>

No blank line needed after fixes:

> ---
>  drivers/base/bus.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 97936ec49bde..7ca47e5b3c1f 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -617,7 +617,7 @@ int bus_add_driver(struct device_driver *drv)
>  	if (drv->bus->p->drivers_autoprobe) {
>  		error = driver_attach(drv);
>  		if (error)
> -			goto out_unregister;
> +			goto out_del_list;
>  	}
>  	module_add_driver(drv->owner, drv);
>  
> @@ -644,6 +644,8 @@ int bus_add_driver(struct device_driver *drv)
>  
>  	return 0;
>  
> +out_del_list:
> +	klist_del(&priv->knode_bus);

Odd, how did you find this?  Has this ever been triggered by any
real-world situations?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCD53CC88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbiFCPrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245657AbiFCPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:47:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F173286F8;
        Fri,  3 Jun 2022 08:47:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21199618CD;
        Fri,  3 Jun 2022 15:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C28C385A9;
        Fri,  3 Jun 2022 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654271263;
        bh=DkHpOszBjvs97DI/fvHycYbfHbNLMuU6YAPeq1EHMUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DTc2jjhDIeM8HhagsgByJvmNNwsqDzXU0w3R7vhjfxhdayanpzV/2zgPYTOzqQ8/F
         ZlEI/LJOVaNtYoZ2O7IWcbycGRkps53fEjq0oB0VHioXeV40BlmrFqaYQTjZEeQMLy
         U6PREmURbMnDn/KE/mcJmZjYWVwZ2j+9aUOfKrrMUinnf95PlGiIPWzxzdd6wVm2h2
         LrolcvuAhZOCJHK5jpPB4PCg06ei+QJDEf0cgw4zeFMo5SOyUDX/YVooRlfQ76UVys
         RZmM9T86v9Hdtk2e6HuCYsHUHZawi+rwPVnpw2FRCPiEdbzDwext4x18zHntWXcj2P
         Wam9Z0/pnbi+A==
Date:   Fri, 3 Jun 2022 16:56:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     keliu <liuke94@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:  Directly use ida_alloc()/free()
Message-ID: <20220603165645.28ecc972@jic23-huawei>
In-Reply-To: <20220527091739.2949426-1-liuke94@huawei.com>
References: <20220527091739.2949426-1-liuke94@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 09:17:39 +0000
keliu <liuke94@huawei.com> wrote:

> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out initially as testing
to let 0-day see if it can find any problems we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c    | 6 +++---
>  drivers/iio/industrialio-trigger.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index e1ed44dec2ab..41daa10cd63d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1618,7 +1618,7 @@ static void iio_dev_release(struct device *device)
>  
>  	iio_device_detach_buffers(indio_dev);
>  
> -	ida_simple_remove(&iio_ida, iio_dev_opaque->id);
> +	ida_free(&iio_ida, iio_dev_opaque->id);
>  	kfree(iio_dev_opaque);
>  }
>  
> @@ -1660,7 +1660,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	mutex_init(&iio_dev_opaque->info_exist_lock);
>  	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
>  
> -	iio_dev_opaque->id = ida_simple_get(&iio_ida, 0, 0, GFP_KERNEL);
> +	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
>  	if (iio_dev_opaque->id < 0) {
>  		/* cannot use a dev_err as the name isn't available */
>  		pr_err("failed to get device id\n");
> @@ -1669,7 +1669,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>  	}
>  
>  	if (dev_set_name(&indio_dev->dev, "iio:device%d", iio_dev_opaque->id)) {
> -		ida_simple_remove(&iio_ida, iio_dev_opaque->id);
> +		ida_free(&iio_ida, iio_dev_opaque->id);
>  		kfree(iio_dev_opaque);
>  		return NULL;
>  	}
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index f504ed351b3e..6eb9b721676e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -71,7 +71,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
>  
>  	trig_info->owner = this_mod;
>  
> -	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
> +	trig_info->id = ida_alloc(&iio_trigger_ida, GFP_KERNEL);
>  	if (trig_info->id < 0)
>  		return trig_info->id;
>  
> @@ -98,7 +98,7 @@ int __iio_trigger_register(struct iio_trigger *trig_info,
>  	mutex_unlock(&iio_trigger_list_lock);
>  	device_del(&trig_info->dev);
>  error_unregister_id:
> -	ida_simple_remove(&iio_trigger_ida, trig_info->id);
> +	ida_free(&iio_trigger_ida, trig_info->id);
>  	return ret;
>  }
>  EXPORT_SYMBOL(__iio_trigger_register);
> @@ -109,7 +109,7 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
>  	list_del(&trig_info->list);
>  	mutex_unlock(&iio_trigger_list_lock);
>  
> -	ida_simple_remove(&iio_trigger_ida, trig_info->id);
> +	ida_free(&iio_trigger_ida, trig_info->id);
>  	/* Possible issue in here */
>  	device_del(&trig_info->dev);
>  }


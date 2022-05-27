Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF35364C6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbiE0Phe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238927AbiE0Ph2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:37:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38338106A4E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 08:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=H1tT2tnQbN1nhTikaf1IL7tfvFjSbCKwU7IE3CDEnPo=; b=dGTBYVqTW0joBZQ4aRiKWQqcYc
        cXILUY5W/Y27zFlV/OkVFcR4ofnMxCXolGRbQfAlnIXcIZP36z1TnrqO8+uHmJjWM3+hHm1pH7dLD
        TS8pAWu6ZD8Zwv6t1yRLt9cQj/q9JO6LZHkqnXzRxeuZ9zT0ch+z3dx3Pm/2p9luKVrM1XbMOW9F9
        wsXrqyvfs7I1Ej0yItk7rTjgv41zQVlZYU6ori/bnb+bdGT7FGdXnIjmDVnOpu2WJ3BQwoaocjqsZ
        aVx/E46V9VfR97w3Zp0jEwxjBBqi9YHzRwsEo/FVzjOebfkHX8lucRbz7mBlqdHo/zLmui9kZu8F9
        0hKNu4uw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuc1Q-002C57-AV; Fri, 27 May 2022 15:37:04 +0000
Message-ID: <7b0181da-7327-0594-ce9a-9601aca56909@infradead.org>
Date:   Fri, 27 May 2022 08:37:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] most: Directly use ida_alloc()/free()
Content-Language: en-US
To:     keliu <liuke94@huawei.com>, gregkh@linuxfoundation.org,
        christian.gromm@microchip.com, linux-kernel@vger.kernel.org
References: <20220527083309.2553087-1-liuke94@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220527083309.2553087-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/22 01:33, keliu wrote:
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

The Signed-off-by: needs a more complete name (unless that is your full name).

Do any of Christophe's comments apply here?

thanks.

> ---
>  drivers/most/core.c      | 10 +++++-----
>  drivers/most/most_cdev.c |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/most/core.c b/drivers/most/core.c
> index e4412c7d25b0..81d60d4ee8c2 100644
> --- a/drivers/most/core.c
> +++ b/drivers/most/core.c
> @@ -1286,7 +1286,7 @@ int most_register_interface(struct most_interface *iface)
>  	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
>  		return -EINVAL;
>  
> -	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&mdev_id, GFP_KERNEL);
>  	if (id < 0) {
>  		dev_err(iface->dev, "Failed to allocate device ID\n");
>  		return id;
> @@ -1294,7 +1294,7 @@ int most_register_interface(struct most_interface *iface)
>  
>  	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
>  	if (!iface->p) {
> -		ida_simple_remove(&mdev_id, id);
> +		ida_free(&mdev_id, id);
>  		return -ENOMEM;
>  	}
>  
> @@ -1308,7 +1308,7 @@ int most_register_interface(struct most_interface *iface)
>  		dev_err(iface->dev, "Failed to register interface device\n");
>  		kfree(iface->p);
>  		put_device(iface->dev);
> -		ida_simple_remove(&mdev_id, id);
> +		ida_free(&mdev_id, id);
>  		return -ENOMEM;
>  	}
>  
> @@ -1366,7 +1366,7 @@ int most_register_interface(struct most_interface *iface)
>  	}
>  	kfree(iface->p);
>  	device_unregister(iface->dev);
> -	ida_simple_remove(&mdev_id, id);
> +	ida_free(&mdev_id, id);
>  	return -ENOMEM;
>  }
>  EXPORT_SYMBOL_GPL(most_register_interface);
> @@ -1397,7 +1397,7 @@ void most_deregister_interface(struct most_interface *iface)
>  		device_unregister(&c->dev);
>  	}
>  
> -	ida_simple_remove(&mdev_id, iface->p->dev_id);
> +	ida_free(&mdev_id, iface->p->dev_id);
>  	kfree(iface->p);
>  	device_unregister(iface->dev);
>  }
> diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
> index 3722f9abd7b9..27913b1c8128 100644
> --- a/drivers/most/most_cdev.c
> +++ b/drivers/most/most_cdev.c
> @@ -100,7 +100,7 @@ static void destroy_cdev(struct comp_channel *c)
>  
>  static void destroy_channel(struct comp_channel *c)
>  {
> -	ida_simple_remove(&comp.minor_id, MINOR(c->devno));
> +	ida_free(&comp.minor_id, MINOR(c->devno));
>  	kfifo_free(&c->fifo);
>  	kfree(c);
>  }
> @@ -424,7 +424,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
>  	if (c)
>  		return -EEXIST;
>  
> -	current_minor = ida_simple_get(&comp.minor_id, 0, 0, GFP_KERNEL);
> +	current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
>  	if (current_minor < 0)
>  		return current_minor;
>  
> @@ -471,7 +471,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
>  err_free_c:
>  	kfree(c);
>  err_remove_ida:
> -	ida_simple_remove(&comp.minor_id, current_minor);
> +	ida_free(&comp.minor_id, current_minor);
>  	return retval;
>  }
>  

-- 
~Randy

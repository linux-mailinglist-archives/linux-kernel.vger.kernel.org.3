Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08C552E20
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347680AbiFUJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347604AbiFUJVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCD41AF1A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 02:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6C756155C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DB3C3411C;
        Tue, 21 Jun 2022 09:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655803293;
        bh=tLFl3NPsWZx6U7LiKRVGtumSH0CZrXn2AYNCegSzJwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H2pPcLSE1yTCq8tTzqno+Z8p282Zk+f+DmIhtq8KzlmT/Muz+4bASepBPc1bFvVdG
         +X/SO5ykm3h+MsrZfUltWVX55N1kiUDZzEzqB0OPUjir0mMkpe5vq1zO9bww1+XzCI
         qtdI1z09qGYvZqQCpEyLupa48QZ37rdB3RYh8qHbC04runRXaPgqdESlFCMGk1N5dg
         CcLdTTxxgQj3FtArEFVesrp5xPc1iaTFfubKAFurl02UM3yCE8KAc9D7m4fn3qr3Bp
         WzQxRIDPKOz0IcNKrFbs5bMiRx64fA8IDBui4H/56rRYrom9jVwefG4x+QHY56NpB6
         vmf8OqB0/p4eA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3a4d-0001m4-Dd; Tue, 21 Jun 2022 11:21:27 +0200
Date:   Tue, 21 Jun 2022 11:21:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     keliu <liuke94@huawei.com>
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] drivers: greybus: Directly use
 ida_alloc()/free()
Message-ID: <YrGNlwxsI7SH0Bqr@hovoldconsulting.com>
References: <20220527111348.3444003-1-liuke94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527111348.3444003-1-liuke94@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 11:13:48AM +0000, keliu wrote:

Please drop "drivers: " from Subject and use a more descriptive summary
like:

	greybus: replace ida_simple interface

> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>

Again, this needs to be a full (legal) name.

> ---
>  drivers/greybus/es2.c       |  4 ++--
>  drivers/greybus/hd.c        | 12 ++++++------
>  drivers/greybus/interface.c |  8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/greybus/es2.c b/drivers/greybus/es2.c
> index e89cca015095..c861fb2acd8a 100644
> --- a/drivers/greybus/es2.c
> +++ b/drivers/greybus/es2.c
> @@ -522,7 +522,7 @@ static int es2_cport_allocate(struct gb_host_device *hd, int cport_id,
>  		return -EINVAL;
>  	}
>  
> -	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
> +	return ida_alloc_range(id_map, ida_start, ida_end - 1, GFP_KERNEL);

Please mention in the commit message that the upper bound is inclusive
in the new API.

>  }
>  
>  static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
> @@ -535,7 +535,7 @@ static void es2_cport_release(struct gb_host_device *hd, u16 cport_id)
>  		return;
>  	}
>  
> -	ida_simple_remove(&hd->cport_id_map, cport_id);
> +	ida_free(&hd->cport_id_map, cport_id);
>  }
>  
>  static int cport_enable(struct gb_host_device *hd, u16 cport_id,
> diff --git a/drivers/greybus/hd.c b/drivers/greybus/hd.c
> index 72b21bf2d7d3..6ff5b0cfd539 100644
> --- a/drivers/greybus/hd.c
> +++ b/drivers/greybus/hd.c
> @@ -50,7 +50,7 @@ int gb_hd_cport_reserve(struct gb_host_device *hd, u16 cport_id)
>  	struct ida *id_map = &hd->cport_id_map;
>  	int ret;
>  
> -	ret = ida_simple_get(id_map, cport_id, cport_id + 1, GFP_KERNEL);
> +	ret = ida_alloc_range(id_map, cport_id, cport_id, GFP_KERNEL);
>  	if (ret < 0) {
>  		dev_err(&hd->dev, "failed to reserve cport %u\n", cport_id);
>  		return ret;
> @@ -64,7 +64,7 @@ void gb_hd_cport_release_reserved(struct gb_host_device *hd, u16 cport_id)
>  {
>  	struct ida *id_map = &hd->cport_id_map;
>  
> -	ida_simple_remove(id_map, cport_id);
> +	ida_free(id_map, cport_id);
>  }
>  EXPORT_SYMBOL_GPL(gb_hd_cport_release_reserved);
>  
> @@ -89,7 +89,7 @@ int gb_hd_cport_allocate(struct gb_host_device *hd, int cport_id,
>  		return -EINVAL;
>  	}
>  
> -	return ida_simple_get(id_map, ida_start, ida_end, GFP_KERNEL);
> +	return ida_alloc_range(id_map, ida_start, ida_end - 1, GFP_KERNEL);
>  }
>  
>  /* Locking: Caller guarantees serialisation */
> @@ -100,7 +100,7 @@ void gb_hd_cport_release(struct gb_host_device *hd, u16 cport_id)
>  		return;
>  	}
>  
> -	ida_simple_remove(&hd->cport_id_map, cport_id);
> +	ida_free(&hd->cport_id_map, cport_id);
>  }
>  
>  static void gb_hd_release(struct device *dev)
> @@ -111,7 +111,7 @@ static void gb_hd_release(struct device *dev)
>  
>  	if (hd->svc)
>  		gb_svc_put(hd->svc);
> -	ida_simple_remove(&gb_hd_bus_id_map, hd->bus_id);
> +	ida_free(&gb_hd_bus_id_map, hd->bus_id);
>  	ida_destroy(&hd->cport_id_map);
>  	kfree(hd);
>  }
> @@ -162,7 +162,7 @@ struct gb_host_device *gb_hd_create(struct gb_hd_driver *driver,
>  	if (!hd)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = ida_simple_get(&gb_hd_bus_id_map, 1, 0, GFP_KERNEL);
> +	ret = ida_alloc_min(&gb_hd_bus_id_map, 1, GFP_KERNEL);
>  	if (ret < 0) {
>  		kfree(hd);
>  		return ERR_PTR(ret);
> diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
> index 9ec949a438ef..f685e5f7b7b1 100644
> --- a/drivers/greybus/interface.c
> +++ b/drivers/greybus/interface.c
> @@ -131,8 +131,8 @@ static int gb_interface_route_create(struct gb_interface *intf)
>  	int ret;
>  
>  	/* Allocate an interface device id. */
> -	ret = ida_simple_get(&svc->device_id_map,
> -			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX + 1,
> +	ret = ida_alloc_range(&svc->device_id_map,
> +			     GB_SVC_DEVICE_ID_MIN, GB_SVC_DEVICE_ID_MAX,
>  			     GFP_KERNEL);
>  	if (ret < 0) {
>  		dev_err(&intf->dev, "failed to allocate device id: %d\n", ret);
> @@ -165,7 +165,7 @@ static int gb_interface_route_create(struct gb_interface *intf)
>  	 * XXX anymore.
>  	 */
>  err_ida_remove:
> -	ida_simple_remove(&svc->device_id_map, device_id);
> +	ida_free(&svc->device_id_map, device_id);
>  
>  	return ret;
>  }
> @@ -178,7 +178,7 @@ static void gb_interface_route_destroy(struct gb_interface *intf)
>  		return;
>  
>  	gb_svc_route_destroy(svc, svc->ap_intf_id, intf->interface_id);
> -	ida_simple_remove(&svc->device_id_map, intf->device_id);
> +	ida_free(&svc->device_id_map, intf->device_id);
>  	intf->device_id = GB_INTERFACE_DEVICE_ID_BAD;
>  }

Looks good otherwise.

Johan

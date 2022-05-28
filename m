Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B58F536CE4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 14:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355512AbiE1MdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 08:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235067AbiE1MdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 08:33:02 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7485C167C4
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 05:33:00 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uvcjntSVD4Ltquvcjnpvi7; Sat, 28 May 2022 14:32:58 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 28 May 2022 14:32:58 +0200
X-ME-IP: 90.11.191.102
Message-ID: <d219c358-243e-da61-ecfa-27a2d1dbaf49@wanadoo.fr>
Date:   Sat, 28 May 2022 14:32:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drivers: fsi: Directly use ida_alloc()/free()
Content-Language: en-US
To:     Ke Liu <liuke94@huawei.com>, jk@ozlabs.org
Cc:     joel@jms.id.au, alistair@popple.id.au, eajames@linux.ibm.com,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220528113552.1889871-1-liuke94@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220528113552.1889871-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 28/05/2022 à 13:35, Ke Liu a écrit :
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove().
> 
> Signed-off-by: Ke Liu <liuke94@huawei.com>
> ---
> v2 fix some bad modify
> ---
>   drivers/fsi/fsi-core.c | 14 +++++++-------
>   drivers/fsi/fsi-occ.c  | 17 ++++++++---------
>   2 files changed, 15 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 3a7b78e36701..10ef611058f0 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -951,7 +951,7 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
>   	if (cid >= 0 && cid < 16 && type < 4) {
>   		/* Try reserving the legacy number */
>   		id = (cid << 4) | type;
> -		id = ida_simple_get(&fsi_minor_ida, id, id + 1, GFP_KERNEL);
> +		id = ida_alloc_range(&fsi_minor_ida, id, id, GFP_KERNEL);
>   		if (id >= 0) {
>   			*out_index = fsi_adjust_index(cid);
>   			*out_dev = fsi_base_dev + id;
> @@ -962,8 +962,8 @@ static int __fsi_get_new_minor(struct fsi_slave *slave, enum fsi_dev_type type,
>   			return id;
>   		/* Fallback to non-legacy allocation */
>   	}
> -	id = ida_simple_get(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
> -			    FSI_CHAR_MAX_DEVICES, GFP_KERNEL);
> +	id = ida_alloc_range(&fsi_minor_ida, FSI_CHAR_LEGACY_TOP,
> +			    FSI_CHAR_MAX_DEVICES - 1, GFP_KERNEL);
>   	if (id < 0)
>   		return id;
>   	*out_index = fsi_adjust_index(id);
> @@ -980,7 +980,7 @@ EXPORT_SYMBOL_GPL(fsi_get_new_minor);
>   
>   void fsi_free_minor(dev_t dev)
>   {
> -	ida_simple_remove(&fsi_minor_ida, MINOR(dev));
> +	ida_free(&fsi_minor_ida, MINOR(dev));
>   }
>   EXPORT_SYMBOL_GPL(fsi_free_minor);
>   
> @@ -1313,13 +1313,13 @@ int fsi_master_register(struct fsi_master *master)
>   	struct device_node *np;
>   
>   	mutex_init(&master->scan_lock);
> -	master->idx = ida_simple_get(&master_ida, 0, INT_MAX, GFP_KERNEL);
> +	master->idx = ida_alloc(&master_ida, GFP_KERNEL);

Did you double check that it was correct?

'master->idx' is an 'int'.
Negative values have special meaning (see [1]). I think that this test 
is useless and that we can't have a negative value here, but 
nevertheless, it is an indication that it is expected not to be negative.

I would go for:
	master->idx = ida_alloc_max(&master_ida, INT_MAX, GFP_KERNEL);

I don't think that the -1 is needed here. INT_MAX is a valid 'int'.

However, all this should be explained in the changelog, so that a 
reviewer understand your logic.

If you prefer to be safe, add the -1. The behavior will be as before.


[1]: 
https://elixir.bootlin.com/linux/v5.18-rc7/source/drivers/fsi/fsi-core.c#L1339

>   	dev_set_name(&master->dev, "fsi%d", master->idx);
>   	master->dev.class = &fsi_master_class;
>   
>   	rc = device_register(&master->dev);
>   	if (rc) {
> -		ida_simple_remove(&master_ida, master->idx);
> +		ida_free(&master_ida, master->idx);
>   		return rc;
>   	}
>   
> @@ -1337,7 +1337,7 @@ EXPORT_SYMBOL_GPL(fsi_master_register);
>   void fsi_master_unregister(struct fsi_master *master)
>   {
>   	if (master->idx >= 0) {
> -		ida_simple_remove(&master_ida, master->idx);
> +		ida_free(&master_ida, master->idx);
>   		master->idx = -1;
>   	}
>   
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index c9cc75fbdfb9..63af5cad1015 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -630,17 +630,16 @@ static int occ_probe(struct platform_device *pdev)
>   		rc = of_property_read_u32(dev->of_node, "reg", &reg);
>   		if (!rc) {
>   			/* make sure we don't have a duplicate from dts */
> -			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
> -						  GFP_KERNEL);
> +			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
> +						GFP_KERNEL);

GFP_KERNEL should be aligned below "&occ_ida".
Their are a few other similar issues below.

To spot such tiny issue, you can run:
	./scripts/checkpatch.pl --strict <path/name_of_your_patch>


>   			if (occ->idx < 0)
> -				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
> -							  GFP_KERNEL);
> +				occ->idx = ida_alloc_min(&occ_ida, 1,
> +							GFP_KERNEL);

Did you check that it was correct?

A few lines below, occ->idx is used as a %d in a snprintf().
A few lines later, it ends in "hwmon_dev_info.id" which is a 'int'.

So in order not to generate negatives id, the upper INT_MAX looks fine, 
finally. So, my guess was wrong.

I would go for:
		occ->idx = ida_alloc_range(&occ_ida, 1, INT_MAX,
					   GFP_KERNEL);

I don't think that the -1 is needed here. INT_MAX is a valid 'int'.

However, all this should be explained in the changelog, so that a 
reviewer understand your logic.

If you prefer to be safe, add the -1. The behavior will be as before.


>   		} else {
> -			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
> -						  GFP_KERNEL);
> +			occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
>   		}

And here.

>   	} else {
> -		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
> +		occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);

And here.

>   	}
>   
>   	platform_set_drvdata(pdev, occ);
> @@ -654,7 +653,7 @@ static int occ_probe(struct platform_device *pdev)
>   	rc = misc_register(&occ->mdev);
>   	if (rc) {
>   		dev_err(dev, "failed to register miscdevice: %d\n", rc);
> -		ida_simple_remove(&occ_ida, occ->idx);
> +		ida_free(&occ_ida, occ->idx);
>   		kvfree(occ->buffer);
>   		return rc;
>   	}
> @@ -677,7 +676,7 @@ static int occ_remove(struct platform_device *pdev)
>   
>   	device_for_each_child(&pdev->dev, NULL, occ_unregister_child);
>   
> -	ida_simple_remove(&occ_ida, occ->idx);
> +	ida_free(&occ_ida, occ->idx);
>   
>   	return 0;
>   }


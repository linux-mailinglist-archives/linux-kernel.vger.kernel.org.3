Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1761535AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245187AbiE0Hnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiE0Hnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:43:37 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C55580D2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:43:35 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uUd2nKXXuIaWOuUd2ntUeq; Fri, 27 May 2022 09:43:34 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 09:43:34 +0200
X-ME-IP: 90.11.191.102
Message-ID: <a9741fc6-96ef-ccbf-2cb0-2cf0b8923ee7@wanadoo.fr>
Date:   Fri, 27 May 2022 09:43:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc: core: Directly use ida_free()
Content-Language: fr
To:     keliu <liuke94@huawei.com>, ulf.hansson@linaro.org,
        axboe@kernel.dk, Avri.Altman@wdc.com, adrian.hunter@intel.com,
        shawn.lin@rock-chips.com, CLoehle@hyperstone.com,
        swboyd@chromium.org, digetx@gmail.com, bigeasy@linutronix.de,
        wsa+renesas@sang-engineering.com, yoshihiro.shimoda.uh@renesas.com,
        dev@lynxeye.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220527075428.2475782-1-liuke94@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220527075428.2475782-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/05/2022 à 09:54, keliu a écrit :
> Use ida_free() instead of deprecated
> ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>   drivers/mmc/core/block.c | 8 ++++----
>   drivers/mmc/core/host.c  | 2 +-
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 506dc900f5c7..c8d702db483d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -204,7 +204,7 @@ static void mmc_blk_kref_release(struct kref *ref)
>   	int devidx;
>   
>   	devidx = mmc_get_devidx(md->disk);
> -	ida_simple_remove(&mmc_blk_ida, devidx);
> +	ida_free(&mmc_blk_ida, devidx);
>   
>   	mutex_lock(&open_lock);
>   	md->disk->private_data = NULL;
> @@ -2495,7 +2495,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
>    err_kfree:
>   	kfree(md);
>    out:
> -	ida_simple_remove(&mmc_blk_ida, devidx);
> +	ida_free(&mmc_blk_ida, devidx);
>   	return ERR_PTR(ret);
>   }
>   
> @@ -2621,7 +2621,7 @@ static void mmc_blk_rpmb_device_release(struct device *dev)
>   {
>   	struct mmc_rpmb_data *rpmb = dev_get_drvdata(dev);
>   
> -	ida_simple_remove(&mmc_rpmb_ida, rpmb->id);
> +	ida_free(&mmc_rpmb_ida, rpmb->id);
>   	kfree(rpmb);
>   }
>   
> @@ -2643,7 +2643,7 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card *card,
>   
>   	rpmb = kzalloc(sizeof(*rpmb), GFP_KERNEL);
>   	if (!rpmb) {
> -		ida_simple_remove(&mmc_rpmb_ida, devidx);
> +		ida_free(&mmc_rpmb_ida, devidx);
>   		return -ENOMEM;
>   	}
>   
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 2ed2b4d5e5a5..9332e82e175a 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -76,7 +76,7 @@ static void mmc_host_classdev_release(struct device *dev)
>   	struct mmc_host *host = cls_dev_to_mmc_host(dev);
>   	wakeup_source_unregister(host->ws);
>   	if (of_alias_get_id(host->parent->of_node, "mmc") < 0)
> -		ida_simple_remove(&mmc_host_ida, host->index);
> +		ida_free(&mmc_host_ida, host->index);
>   	kfree(host);
>   }
>   

Hi,

You missed ida_simple_get() that shoud become ida_alloc_max() here.

CJ

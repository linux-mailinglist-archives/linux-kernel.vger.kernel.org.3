Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B222D535AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiE0Hor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbiE0Hon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:44:43 -0400
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr [80.12.242.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1D35EDD5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:44:42 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uUeEnKNQ90JImuUeFnsE7E; Fri, 27 May 2022 09:44:40 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 09:44:40 +0200
X-ME-IP: 90.11.191.102
Message-ID: <cd80d7b8-a753-25f7-2f7f-dfb45f69acd6@wanadoo.fr>
Date:   Fri, 27 May 2022 09:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] rpmsg: Directly use ida_alloc()/free()
Content-Language: fr
To:     keliu <liuke94@huawei.com>, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220527075129.2475594-1-liuke94@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220527075129.2475594-1-liuke94@huawei.com>
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

Le 27/05/2022 à 09:51, keliu a écrit :
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>   drivers/rpmsg/rpmsg_char.c | 10 +++++-----
>   drivers/rpmsg/rpmsg_ctrl.c | 10 +++++-----
>   2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b6183d4f62a2..7daa21d92f20 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -342,8 +342,8 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>   {
>   	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>   
> -	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
> +	ida_free(&rpmsg_ept_ida, dev->id);
> +	ida_free(&rpmsg_minor_ida, MINOR(eptdev->dev.devt));
>   	kfree(eptdev);
>   }
>   
> @@ -389,7 +389,7 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
>   		goto free_eptdev;
>   	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
>   
> -	ret = ida_simple_get(&rpmsg_ept_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&rpmsg_ept_ida, GFP_KERNEL);


Hi,

You missed ida_simple_get() a few lines above that shoud become 
ida_alloc_max() here.

CJ


>   	if (ret < 0)
>   		goto free_minor_ida;
>   	dev->id = ret;
> @@ -405,9 +405,9 @@ static int rpmsg_chrdev_eptdev_add(struct rpmsg_eptdev *eptdev, struct rpmsg_cha
>   	return ret;
>   
>   free_ept_ida:
> -	ida_simple_remove(&rpmsg_ept_ida, dev->id);
> +	ida_free(&rpmsg_ept_ida, dev->id);
>   free_minor_ida:
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>   free_eptdev:
>   	put_device(dev);
>   	kfree(eptdev);
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index 107da70fdbaa..8418e2ea0716 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -130,8 +130,8 @@ static void rpmsg_ctrldev_release_device(struct device *dev)
>   {
>   	struct rpmsg_ctrldev *ctrldev = dev_to_ctrldev(dev);
>   
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_ctrl_ida, dev->id);
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>   	kfree(ctrldev);
>   }
>   
> @@ -161,7 +161,7 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>   		goto free_ctrldev;
>   	dev->devt = MKDEV(MAJOR(rpmsg_major), ret);
>   
> -	ret = ida_simple_get(&rpmsg_ctrl_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&rpmsg_ctrl_ida, GFP_KERNEL);
>   	if (ret < 0)
>   		goto free_minor_ida;
>   	dev->id = ret;
> @@ -179,9 +179,9 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>   	return ret;
>   
>   free_ctrl_ida:
> -	ida_simple_remove(&rpmsg_ctrl_ida, dev->id);
> +	ida_free(&rpmsg_ctrl_ida, dev->id);
>   free_minor_ida:
> -	ida_simple_remove(&rpmsg_minor_ida, MINOR(dev->devt));
> +	ida_free(&rpmsg_minor_ida, MINOR(dev->devt));
>   free_ctrldev:
>   	put_device(dev);
>   	kfree(ctrldev);


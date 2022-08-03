Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FD588741
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiHCGTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiHCGTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:19:23 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783CC313B6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:19:22 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id J7iuoIv64sKAkJ7iuoiS4i; Wed, 03 Aug 2022 08:19:21 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 03 Aug 2022 08:19:21 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d9360eb7-b7b3-b76c-921e-9c24f133985d@wanadoo.fr>
Date:   Wed, 3 Aug 2022 08:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] w1: omap-hdq:using the
 pm_runtime_resume_and_get to simplify the code
Content-Language: en-GB
To:     cgel.zte@gmail.com, linux-kernel@vger.kernel.org
Cc:     zbr@ioremap.net, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220803061135.1650266-1-ye.xingchen@zte.com.cn>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220803061135.1650266-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/08/2022 à 08:11, cgel.zte@gmail.com a écrit :
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Using pm_runtime_resume_and_get() to instade of
>   pm_runtime_get_sync and pm_runtime_put_noidle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>   drivers/w1/masters/omap_hdq.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/w1/masters/omap_hdq.c b/drivers/w1/masters/omap_hdq.c
> index bf2ec59c1f9d..ec4292bc0458 100644
> --- a/drivers/w1/masters/omap_hdq.c
> +++ b/drivers/w1/masters/omap_hdq.c
> @@ -372,9 +372,8 @@ static u8 omap_w1_triplet(void *_hdq, u8 bdir)
>   		  OMAP_HDQ_CTRL_STATUS_INTERRUPTMASK;
>   	u8 mask = ctrl | OMAP_HDQ_CTRL_STATUS_DIR;
>   
> -	err = pm_runtime_get_sync(hdq_data->dev);
> +	err = pm_runtime_resume_and_get(hdq_data->dev);
>   	if (err < 0) {
> -		pm_runtime_put_noidle(hdq_data->dev);
>   
>   		return err;
>   	}

I don't have a strong opinion on the patch itself, but the resulting 
would look like:
	err = pm_runtime_resume_and_get(hdq_data->dev);
    	if (err < 0) {

    		return err;
    	}

which is odd. { } and extra blank line should be removed, IMHO.

CJ

[...]

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4D4D2349
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbiCHV0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350453AbiCHV0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:26:50 -0500
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719335046C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:25:52 -0800 (PST)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id RhKwn3JSLzH5fRhKwn1IDA; Tue, 08 Mar 2022 22:25:49 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 08 Mar 2022 22:25:49 +0100
X-ME-IP: 90.126.236.122
Message-ID: <4039fd4b-87db-2d6e-2c8d-b6ff0129ed0d@wanadoo.fr>
Date:   Tue, 8 Mar 2022 22:25:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mmc: wmt-sdmmc: Fix an error handling path in
 wmt_mci_probe()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <bf2e2e69226b20d173cce66287f59488fd47474b.1646588375.git.christophe.jaillet@wanadoo.fr>
 <20220308125445.GE3293@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220308125445.GE3293@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/03/2022 à 13:54, Dan Carpenter a écrit :
> On Sun, Mar 06, 2022 at 06:44:56PM +0100, Christophe JAILLET wrote:
>> A dma_free_coherent() call is missing in the error handling path of the
>> probe, as already done in the remove function.
>>
>> Fixes: 3a96dff0f828 ("mmc: SD/MMC Host Controller for Wondermedia WM8505/WM8650")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> I've not been able to find a Fixes tag because of the renaming of
>> function and files.
>> However, it looks old (before 2008)
> 
> You did add a fixes tag and it's from 2012.  :P

Well, a bit too much of copy&paste from [1] :(

[1]: 
https://lore.kernel.org/all/242ebc5e7dedc6b0d7f47cbf7768326c127f955b.1646584729.git.christophe.jaillet@wanadoo.fr/

> 
>> ---
>>   drivers/mmc/host/wmt-sdmmc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> index 163ac9df8cca..8e18f01c0938 100644
>> --- a/drivers/mmc/host/wmt-sdmmc.c
>> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> @@ -863,6 +863,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>>   	return 0;
>>   fail6:
>>   	clk_put(priv->clk_sdmmc);
>> +	dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
>> +			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
>>   fail5:
>>   	free_irq(dma_irq, priv);
> 
> This isn't quite right.  If of_clk_get() fails it should call
> dma_free_coherent() but it does not.  You need to add:

Agreed, thx for the review.
If no one fix it in the meanwhile, I'll send a v2 this WE or next week.

CJ


> 
>   fail6:
>   	clk_put(priv->clk_sdmmc);
> +fail5_and_a_half:
> +	dma_free_coherent(&pdev->dev, mmc->max_blk_count * 16,
> +			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
>   fail5:
>   	free_irq(dma_irq, priv);
> 
> regards,
> dan carpenter
> 
> 


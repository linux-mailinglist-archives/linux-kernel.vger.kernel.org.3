Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F784BB52A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 10:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiBRJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 04:18:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiBRJRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 04:17:12 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B3810FC3;
        Fri, 18 Feb 2022 01:16:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 35B0D1F41376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645175813;
        bh=U7lrWAwexr4OGIHGR/8E7hJ30LUne6rDxFg0tlfKKeE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dYSoqAoFunE26Zuzip6yj5ZI2T1UyC2GkhrcpgU8ahqnmNZRKgLt6EShgsOUl/E3e
         wdtmkmqGgFkuNJZjb7HYkmxONjqaGPQ6aPELatm4rp43UcQaZxpbmbOqKijBLuWTpM
         Hns7vuM1njcewRDBbHn8qJMXE1cxi4XwPt3ERxmtukAqJGHHUipL8TRlqrryqrjqOr
         cmGZBGwZaRkFOfIEOSwUGyy+HqTQz/zP6/MMxUP7RodX1pyCBQNHNcekgbO7nA14FJ
         9bYbp6i6mEABn5PQZ2elbyCCv+RmjRb7gTRYcVK/93xrxPJk7WVEucGbqQJhXHkvYz
         7s1LPBMFEVwFg==
Message-ID: <ad306275-cd38-e6ad-55cc-0f7c4bdfcecf@collabora.com>
Date:   Fri, 18 Feb 2022 10:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     bjorn.andersson@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
 <20220217190349.GA477215@p14s>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217190349.GA477215@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 20:03, Mathieu Poirier ha scritto:
> Hi Angelo,
> 
> On Fri, Jan 14, 2022 at 03:47:37PM +0100, AngeloGioacchino Del Regno wrote:
>> During execution of the worker that's used to register rpmsg devices
>> we are safely locking the channels mutex but, when creating a new
>> endpoint for such devices, we are registering a IPI on the SCP, which
>> then makes the SCP to trigger an interrupt, lock its own mutex and in
>> turn register more subdevices.
>> This creates a circular locking dependency situation, as the mtk_rpmsg
>> channels_lock will then depend on the SCP IPI lock.
>>
>> [   18.014514]  Possible unsafe locking scenario:
>> [   18.014515]        CPU0                    CPU1
>> [   18.014517]        ----                    ----
>> [   18.045467]   lock(&mtk_subdev->channels_lock);
>> [   18.045474]                                lock(&scp->ipi_desc[i].lock);
> 
> I spent well over an hour tracing through the meanders of the code to end up in
> scp_ipi_register() which, I think, leads to the above.  But from there I don't
> see how an IPI can come in and that tells me my assumption is wrong.
> 
> Can you give more details on the events that lead to the above?  I'm not saying
> there is no problem, I just need to understand it.
> 

Hi Mathieu,

I understand that following this flow without the assistance of the actual
hardware may be a little confusing, so, no worries.

drivers/remoteproc/mtk_scp.c - this driver manages the SCP (obviously, a
remote processor)
drivers/remoteproc/mtk_scp_ipi.c - public functions for kernel SCP IPC

Flow:
- MediaTek SCP gets probed
- RPMSG starts, we start probing "something", like google,cros-ec-rpmsg
- mtk_rpmsg: creates endpoint; IPI handler is registered here.

          ( more flow )

- mtk_rpmsg: mtk_rpmsg_ns_cb() -> mtk_rpmsg_create_device(), channel is
              added to the channels list, worker gets scheduled


Now for the part that produces the real issue:

label_a:

*** RPMSG MUTEX LOCK ***
- mtk_rpmsg: ## Go through multiple channels ##, call mtk_rpmsg_register_device()

- Registered device tries to communicate through RPMSG
- .send() or .trysend() (depending on the device) is called: send_ipi()
     *** SCP MUTEX LOCK ***
    - mtk_scp_ipi: Data written, ACK? ok -> return 0
     *** SCP MUTEX UNLOCK ***

- mtk_scp_ipi: **** INTERRUPT!!! **** New RPMSG NS available? -> create channel
           goto label_a;

*** RPMSG MUTEX UNLOCK ***


Pardon me for keeping some things in this flow implicit, but that was done to
simplify it as much as possible as to try to make you understand the situation.

Cheers,
Angelo

> Thanks,
> Mathieu
> 
>> [   18.228399]                                lock(&mtk_subdev->channels_lock);
>> [   18.228405]   lock(&scp->ipi_desc[i].lock);
>> [   18.264405]
>>
>> To solve this, simply unlock the channels_lock mutex before calling
>> mtk_rpmsg_register_device() and relock it right after, as safety is
>> still ensured by the locking mechanism that happens right after
>> through SCP.
>> Notably, mtk_rpmsg_register_device() does not even require locking.
>>
>> Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/rpmsg/mtk_rpmsg.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
>> index 5b4404b8be4c..d1213c33da20 100644
>> --- a/drivers/rpmsg/mtk_rpmsg.c
>> +++ b/drivers/rpmsg/mtk_rpmsg.c
>> @@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
>>   		if (info->registered)
>>   			continue;
>>   
>> +		mutex_unlock(&subdev->channels_lock);
>>   		ret = mtk_rpmsg_register_device(subdev, &info->info);
>> +		mutex_lock(&subdev->channels_lock);
>>   		if (ret) {
>>   			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
>>   			continue;
>> -- 
>> 2.33.1
>>




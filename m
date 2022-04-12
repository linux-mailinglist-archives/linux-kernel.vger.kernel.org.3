Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB3E4FD570
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbiDLJdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387939AbiDLJNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:13:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FBD29813
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:23:28 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p8so16847868pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gyrYbauxjPaWclooKJn/hrAsYXOy+/frieJJ/OTDBFY=;
        b=GK+W9vKpAguKJLGc8nUI0FFmuwES/dxXHn3pT6bo04ps4aY+/qlMgV2UGoAtjTtQw8
         GDDD+BRA4ZKb3YQNfC98H720Ob1gRczHWaUfvrRaVJV1Cajcmb967p+5oow1nLZvcm4j
         UECuyBFzs2nzdg0JStGhfIFGHlCtFFkxzBcAFMVEUCHIuQDRQVUBlHVcB9V6OJbQlhxf
         2qQATXvKM2c2NRQmK5tKLekn6J861eTIr021N4PsEfHHsUo7Hx4yQz6LpslMMylku0UP
         U5lRUhsCSocCGJX4XslCdvhFXk5FxFLPOwCcUM4JU+lGpzWNBNzB1wN4Lxp/yISVCoOG
         r3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gyrYbauxjPaWclooKJn/hrAsYXOy+/frieJJ/OTDBFY=;
        b=QRA8e1DbhF0EJTdBS4MEj/2Y1N3aFX4N8mRL7pxPhZcxGECcdKO3hu2Bm4AfnpDRPS
         gk0O0c6SE2W39zMclO7y05FB7AVF/q0MCPf2skvnURNh+2HmyZ+/BnSDR+dovktUx3+s
         oDjxlWAsjKfYyB9AyKwVcuZl1qo1jVNG2gtqeLsbzkp9VYzdoSd8h7NKGm/1E0sNFBVX
         PisResBBufkKzZ79Nu7NObVQ/TepYQT6v/aPrLvEWqqUqYY23oiKkCckoqIMYSLzu1fd
         Lmcpd9YWdDayThkmNQEGTIIPknksRW7MkDhTnUPHEqWmGoDCJK43YOr0m8Zj4B74V6g+
         Zwhg==
X-Gm-Message-State: AOAM530njG+GMnqM1rKZRbYUZVIJQSrZx44tFCEv34K5a1BA/gLgO1mO
        LFLR3tkvNmhhjyM0ZDZlCyo=
X-Google-Smtp-Source: ABdhPJyu2IzZL5JsRvXeXyzTtw7BsyS1eaDhNkE2C+IuVlvVmERn2qRNc6suaSyU2MeJtksNwjYYKw==
X-Received: by 2002:a65:6956:0:b0:399:1f0e:6172 with SMTP id w22-20020a656956000000b003991f0e6172mr29356681pgq.286.1649751807937;
        Tue, 12 Apr 2022 01:23:27 -0700 (PDT)
Received: from [192.168.1.101] ([159.226.95.33])
        by smtp.gmail.com with ESMTPSA id q27-20020aa7961b000000b004fdf7a4d49esm30886644pfg.170.2022.04.12.01.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 01:23:27 -0700 (PDT)
Message-ID: <bf603638-cc34-b185-3001-9caeba1884d7@gmail.com>
Date:   Tue, 12 Apr 2022 16:23:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] mtd: rawnand: Fix return value check of
 wait_for_completion_timeout
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bastian Hecht <hechtb@googlemail.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <202204121253.NcZifMQi-lkp@intel.com>
 <20220412063703.8537-1-linmq006@gmail.com> <20220412090649.33bb3f8b@xps13>
 <61783400-4df2-47af-78a7-7acb715c3a71@gmail.com>
 <20220412094822.3818ebc2@xps13>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <20220412094822.3818ebc2@xps13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 2022/4/12 15:48, Miquel Raynal wrote:
>
>>> Hi Miaoqian,
>>>
>>> linmq006@gmail.com wrote on Tue, 12 Apr 2022 06:36:52 +0000:
>>>  
>>>> wait_for_completion_timeout() returns unsigned long not int.
>>>> It returns 0 if timed out, and positive if completed.
>>>> The check for <= 0 is ambiguous and should be == 0 here
>>>> indicating timeout which is the only error case.
>>>>
>>>> Fixes: 83738d87e3a0 ("mtd: sh_flctl: Add DMA capabilty")
>>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>>> ---
>>>> change in v2:
>>>> - initialize ret to 1.
>>>> ---
>>>>  drivers/mtd/nand/raw/sh_flctl.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
>>>> index b85b9c6fcc42..2373251f585b 100644
>>>> --- a/drivers/mtd/nand/raw/sh_flctl.c
>>>> +++ b/drivers/mtd/nand/raw/sh_flctl.c
>>>> @@ -384,7 +384,8 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
>>>>  	dma_addr_t dma_addr;
>>>>  	dma_cookie_t cookie;
>>>>  	uint32_t reg;
>>>> -	int ret;
>>>> +	int ret = 1;  
>>> Does not look right. I know this function returns > 0 on positive
>>> outcomes but this does not make any sense in the first place.  
>> Yes, I made a mistake, Now I realize that in v2, it will return 1 in error path
>>
>> when DMA submit failed.
> Not 1, but a proper error code please (-ETIMEDOUT, -EINVAL, whatever)
>
>> And for patch v1, it will return 0  if calls wait_for_completion_timeout succeeds.
>>
>>> This function is static and only called twice, please turn it into
>>> something like:
>>>
>>> if (dma_fifo_transfer())
>>> 	error
>>> else
>>> 	ok  
>> So I want to keep ret>0 means success.
>>
>> Or could I set ret > 0 after in wait_for_completion_timeout() success path?
>>
>> like:
>>
>>     if(time_left == 0)
>>
>>             ret = -ETIMEDOUT;
>>
>>     else
>>
>>             ret = 1;
> You can initialize ret to zero at to top. So that anything != 0 is an
> error (like a lot of functions in the kernel). 

Thanks for your advice, I will do this.
> And use:
>
> 	if (dma_fifo_transfer())
> 		error();
I think keeping the original condition structure is better,
something like:

if (dma_fifo_transfer()==0)
	succeed();

In this way, only minor changes is needed——only need to update the symbol in condition.
Otherwise It needs to restructure the code and be more complicated.


Thanks,

>> What do you think?
>>
>>
>> Thanks,
>>
>>>> +	unsigned long time_left;
>>>>  
>>>>  	if (dir == DMA_FROM_DEVICE) {
>>>>  		chan = flctl->chan_fifo0_rx;
>>>> @@ -425,13 +426,14 @@ static int flctl_dma_fifo0_transfer(struct sh_flctl *flctl, unsigned long *buf,
>>>>  		goto out;
>>>>  	}
>>>>  
>>>> -	ret =
>>>> +	time_left =
>>>>  	wait_for_completion_timeout(&flctl->dma_complete,
>>>>  				msecs_to_jiffies(3000));
>>>>  
>>>> -	if (ret <= 0) {
>>>> +	if (time_left == 0) {
>>>>  		dmaengine_terminate_all(chan);
>>>>  		dev_err(&flctl->pdev->dev, "wait_for_completion_timeout\n");
>>>> +		ret = -ETIMEDOUT;
>>>>  	}
>>>>  
>>>>  out:  
>>> Thanks,
>>> Miquèl  
>
> Thanks,
> Miquèl

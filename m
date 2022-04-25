Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6457A50E28A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242311AbiDYODk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiDYODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C7982B188
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650895233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9u2nqt1fAgYEoKl131YI31Ovqdnkz65FuwgpqzDfxQ=;
        b=Dq+09mjexC42LCC3wIEYrbHG+x5G5z90idXswC0wSQAKUke4FWexKWQiZxy+Bfs7cyCQwE
        nJs6F0Be3uYj+Z5DSszjKHLC9rg/q2x277wKMhNxpP/q0fCp3ed2H3jL0FDIREGJxX0lQW
        6x9+nEmK8Uhg6OKPAhMpf4wGOyuNgAQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-LYSozPFZMxyq024Gpjh51A-1; Mon, 25 Apr 2022 10:00:31 -0400
X-MC-Unique: LYSozPFZMxyq024Gpjh51A-1
Received: by mail-ed1-f71.google.com with SMTP id co27-20020a0564020c1b00b00425ab566200so5922243edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N9u2nqt1fAgYEoKl131YI31Ovqdnkz65FuwgpqzDfxQ=;
        b=1V8SFVBh1tk16pS13qiVV9hn6j1XElfKAhEflFKjaSoS7U1oQodPImghzmjdCoXZ1J
         kW8mNW/Hj+LUelM0Nzykne9J9l0aSzpQDObhU5n2JdSwIEQRL46XAIcOwRJlli2x/HkC
         VxWiZjCPG6T1Q1ScV7WnRDCstYEhxBppewjCTEQeNk3pfk2Bt4129+qCLa9jL5ya9ltn
         0iNZafpnAKYSYHvyJRjWNFiCIAbHQguBPIkARnJ+MEfESGiiuZM+Qw//emGOOxHpvqtm
         R5aRwOl7zLMzjkQu6BXArmo3HDeHmDK3r9gwnLQm2WhZFPveFSy1+TA68CZPiRUdKWOP
         pvXQ==
X-Gm-Message-State: AOAM533ceGc2VPcDTn3RTAhVmn7ECnjenNB9Qh5p6Alp1kd0UZGrW+Fw
        nOyLeqM0qQhmhcl6lpmeyHVURoq9TD8Ryf1eO/pmGEzR2oo1CkwMf070J3XgzdkthLk+e0ZANEB
        EWYQuQi6CRxNXSw7HpZR+fHdJ
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id w9-20020a056402268900b0042215c4e17emr19469794edd.33.1650895230352;
        Mon, 25 Apr 2022 07:00:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0qu9w9vjCP20szbQtRmFzELzT/qvzG9iDj/X//vDCrHXo1NIhXjB+U9HZPw7Lp6Dq2qoQfA==
X-Received: by 2002:a05:6402:2689:b0:422:15c4:e17e with SMTP id w9-20020a056402268900b0042215c4e17emr19469762edd.33.1650895230131;
        Mon, 25 Apr 2022 07:00:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7d54c000000b00423e004bf9asm4651103edr.86.2022.04.25.07.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 07:00:29 -0700 (PDT)
Message-ID: <7e8cfa5f-2779-f95a-edcf-d9097e18af52@redhat.com>
Date:   Mon, 25 Apr 2022 16:00:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] mmc: sunxi-mmc: Correct the maximum segment size
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chen-Yu Tsai <wens@csie.org>,
        Chris Ball <chris@printf.net>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Mike Turquette <mturquette@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220424230640.31735-1-samuel@sholland.org>
 <dcc1b028-7e53-cb94-9a66-41890393f2ed@redhat.com>
 <31a12028-8593-c558-0f21-044d69f97e6f@sholland.org>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <31a12028-8593-c558-0f21-044d69f97e6f@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/22 15:40, Samuel Holland wrote:
> On 4/25/22 5:40 AM, Hans de Goede wrote:
>> Hi Samuel,
>>
>> On 4/25/22 01:06, Samuel Holland wrote:
>>> According to the DMA descriptor documentation, the lowest two bits of
>>> the size field are ignored, so the size must be rounded up to a multiple
>>> of 4 bytes. Furthermore, 0 is not a valid buffer size; setting the size
>>> to 0 will cause that DMA descriptor to be ignored.
>>>
>>> Together, these restrictions limit the maximum DMA segment size to 4
>>> less than the power-of-two width of the size field.
>>
>> I assume that you were seeing some problems where things where not working
>> which caused you to investigate this; and that this patch fixes those
>> problems?   If yes then it would be good to also mention the problems +
>> investigative process in the commit message.
> 
> No, this is just based on reading the manual. I was investigating some problems
> when I originally wrote this patch, but they turned out to be unrelated, and
> reverting this patch doesn't cause any obvious regression.

I see, I'm not sure if we should proceed with this patch then,
since at least on the older boards with 13 idma_des_size_bits
the current code is likely correct given all the testing it has
seen.

>> I'm no longer involved in sunxi development, but still I wonder if the
>> subtraction of 4 from the max_seg_size is really necessary? This seems
>> to be based on the notion that as you say "0 is not a valid buffer size"
>> where as the code so far has been operating under the assumption that
>> putting 0 in sunxi_idma_des.buf_size means maximum buf-size.
>>
>> I'm pretty sure that 0 meaning maximum buf-size is correct for at least
>> the older chips where idma_des_size_bits equals 13, which means that
>> only 2 4K pages fit in a single desc, so we almost certainly have been
>> hitting this code path ?
>>
>> Although: drivers/mmc/host/dw_mmc.c which seems to be for similar
>> hw suggests that on designs where idma_des_size_bits == 13 only
>> 4k can be used, which sorta matches what you are doing here except
>> that you limit things to 8k - 4 instead of to just 4k.
>>
>> Anyways I was just wondering about all this...
> 
> It probably deserves someone testing this specific scenario, so we can either
> verify the fix is needed, or add a comment explaining that the documentation is
> wrong.

I agree that this should be verified before merging this patch. As for the
documentation, which documentation are you referring too ? At least for the
older sunxi SoCs which I'm familiar with the MMC controller bits were not
documented at all.

Regards,

Hans



>>>
>>> Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
>>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>>> ---
>>>
>>>  drivers/mmc/host/sunxi-mmc.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index c62afd212692..4bd5f37b1036 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -214,6 +214,9 @@
>>>  #define SDXC_IDMAC_DES0_CES	BIT(30) /* card error summary */
>>>  #define SDXC_IDMAC_DES0_OWN	BIT(31) /* 1-idma owns it, 0-host owns it */
>>>  
>>> +/* Buffer size must be a multiple of 4 bytes. */
>>> +#define SDXC_IDMAC_SIZE_ALIGN	4
>>> +
>>>  #define SDXC_CLK_400K		0
>>>  #define SDXC_CLK_25M		1
>>>  #define SDXC_CLK_50M		2
>>> @@ -361,17 +364,15 @@ static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
>>>  {
>>>  	struct sunxi_idma_des *pdes = (struct sunxi_idma_des *)host->sg_cpu;
>>>  	dma_addr_t next_desc = host->sg_dma;
>>> -	int i, max_len = (1 << host->cfg->idma_des_size_bits);
>>> +	int i;
>>>  
>>>  	for (i = 0; i < data->sg_len; i++) {
>>>  		pdes[i].config = cpu_to_le32(SDXC_IDMAC_DES0_CH |
>>>  					     SDXC_IDMAC_DES0_OWN |
>>>  					     SDXC_IDMAC_DES0_DIC);
>>>  
>>> -		if (data->sg[i].length == max_len)
>>> -			pdes[i].buf_size = 0; /* 0 == max_len */
>>> -		else
>>> -			pdes[i].buf_size = cpu_to_le32(data->sg[i].length);
>>> +		pdes[i].buf_size = cpu_to_le32(ALIGN(data->sg[i].length,
>>> +						     SDXC_IDMAC_SIZE_ALIGN));
>>>  
>>>  		next_desc += sizeof(struct sunxi_idma_des);
>>>  		pdes[i].buf_addr_ptr1 =
>>> @@ -1420,7 +1421,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
>>>  	mmc->max_blk_count	= 8192;
>>>  	mmc->max_blk_size	= 4096;
>>>  	mmc->max_segs		= PAGE_SIZE / sizeof(struct sunxi_idma_des);
>>> -	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits);
>>> +	mmc->max_seg_size	= (1 << host->cfg->idma_des_size_bits) -
>>> +				  SDXC_IDMAC_SIZE_ALIGN;
>>>  	mmc->max_req_size	= mmc->max_seg_size * mmc->max_segs;
>>>  	/* 400kHz ~ 52MHz */
>>>  	mmc->f_min		=   400000;
>>
> 


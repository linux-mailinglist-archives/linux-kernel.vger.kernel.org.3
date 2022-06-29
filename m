Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8FC55F9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiF2ICK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiF2ICD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:02:03 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212063A180
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:02:02 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id pk21so30947499ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Viz1ZP9VtvajOYcBqzTA3hqYlKNwj1b1TN6tp7yivm4=;
        b=iaWcatXWkv8khJ9y4MBhrfxkn3ToqWrxQyLJQkkWX/9f4c5UKIlkD0rd0v7r99gV1E
         ujrr6uAV32ZkmS+wAw4LdQefshb1Ek/pV6a0nXHDTfk7oWI8BQRstoeDkXFuUHbRBaBj
         BrbGYePz6ImBTByIHKT0Jl65XkjSsyTY1Gdmcvx2GdN3uBpQ2s9zzw8yKBqZT8LVMpGu
         WVsBvKxQYvVxseQivZTuiWjlYnAxw757+Z7yZ5EQ5KqhhjW6AViH7uvXpT0nBN/swmIM
         tNq8iIsjqY2mfqyA1LFR/X5Om92MlVvlWVLMUFOrSva9Afrqf0/0E+Prk4aQxwgqQ5pv
         wqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Viz1ZP9VtvajOYcBqzTA3hqYlKNwj1b1TN6tp7yivm4=;
        b=XL6zn9AKr4ImATt8863Ms8yaNBgfF76uh7E7/yo39t28pMu7d40yhc7OSYvS5/KKl+
         8x2QTS9rNLgM98pBtOgKdey5fxka144hr5qMDbvWFHH340au2/eJIE0d5p/DW6akbYrj
         dJM9Bdbz2x+J1Ow9EvVvFwmI9bpkERHny6LWDYTEZ7E8/SErkagvaBOxieXOuUSSUqDx
         AvYjNtEkXO5I3Ok5h3bqUc58ZmkNWqwPL/O3LVUFLzKPQi3rT+dWh8sA7HGuDdlmE9jE
         vAZHM5Kr3hBq1UGIx7fvCO5GLfOlfd6QMnLwkVlQR/Q+XoJTxPE7vTRKv2LOKlZzAk5Q
         VVrg==
X-Gm-Message-State: AJIora/cgKTnvj03DZW8vm84tyXIMwZL4CeNS1l6n0ANxmLbNLcB++gy
        7EG1+yas8bPNiVviOxy+I0Gt+w==
X-Google-Smtp-Source: AGRyM1vO7SGdnsCGYLmlnxZnMJUpI/1lJrFBUrqZgXT8n+78HOyrtE1+gmTy3RSQtFx4xDctKuDt6A==
X-Received: by 2002:a17:907:a0ca:b0:722:f8df:7d21 with SMTP id hw10-20020a170907a0ca00b00722f8df7d21mr1944691ejc.393.1656489720637;
        Wed, 29 Jun 2022 01:02:00 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b00435d4179bbdsm11054730edv.4.2022.06.29.01.01.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 01:01:59 -0700 (PDT)
Message-ID: <9237dbad-12de-cd0f-82dd-40c08bf2a47b@linaro.org>
Date:   Wed, 29 Jun 2022 10:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] rpmsg: fix possible refcount leak in
 rpmsg_register_device_override()
Content-Language: en-US
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220624024120.11576-1-hbh25y@gmail.com>
 <20220624173621.GC1736477@p14s>
 <47db0cd8-c940-6e74-f8dc-8e3931e13d80@linaro.org>
 <CANLsYkzT5ZROReZNQ_eYL-r49ijaZYZ5TzdMpqy1RK0_hvW3_Q@mail.gmail.com>
 <0bbee169-6fdc-b50e-87f7-1551dac821e2@linaro.org>
 <20220628163107.GA1942439@p14s>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628163107.GA1942439@p14s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2022 18:31, Mathieu Poirier wrote:
> On Sat, Jun 25, 2022 at 09:40:36PM +0200, Krzysztof Kozlowski wrote:
>> On 24/06/2022 20:43, Mathieu Poirier wrote:
>>> On Fri, 24 Jun 2022 at 11:45, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 24/06/2022 19:36, Mathieu Poirier wrote:
>>>>> On Fri, Jun 24, 2022 at 10:41:20AM +0800, Hangyu Hua wrote:
>>>>>> rpmsg_register_device_override need to call put_device to free vch when
>>>>>> driver_set_override fails.
>>>>>>
>>>>>> Fix this by adding a put_device() to the error path.
>>>>>>
>>>>>> Fixes: bb17d110cbf2 ("rpmsg: Fix calling device_lock() on non-initialized device")
>>>>>
>>>>> This is funny... Neither Bjorn nor I have reviewed this patch...
>>>>
>>>> It was a fix for commit in Greg's tree and Greg's pick it up after a
>>>> week or something. I am not sure if that's actually funny that Greg has
>>>> to pick it up without review :(
>>>>
>>>
>>> The patch was sent out on April 19th and committed 3 days later on
>>> April 22nd.  Is 3 days the new patch review time standard?
>>
>> Neither 19th, nor 22nd are correct. The patch which you set you never
>> reviewed, so commit bb17d110cbf2 was sent on 29th of April:
>> https://lore.kernel.org/all/20220429195946.1061725-1-krzysztof.kozlowski@linaro.org/
>>
> 
> Twitchy fingers... Those dates are for commit 42cd402b8fd4, which is referenced
> by bb17d110cbf2.
> 
> The end result is the same, that is patches related to the remoteproc/rpmsg
> subsystems (or any subsystem) should not be committed before their maintainers
> have the opportunity to review them.

I think two months for your involvement was enough. During this two
months there was a comment from Bjorn, applied and later quite plenty of
time to revise/check/review.

I understand that we are all busy, pretty often working on upstream in
spare time etc. So no one here complained that you did not review this
patch within two months. But I don't understand what shall we do more if
two months are not enough - wait four months? Six months?

Best regards,
Krzysztof

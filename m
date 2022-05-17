Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8752A1E9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346355AbiEQMrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346386AbiEQMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:47:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9F3C4B7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:47:21 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q15so843566pgr.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uPzI2NrDruMsQhpRvojLxqAMj39DRNPyO6rdqBSN6WI=;
        b=8MnH6yhBAp56fktUprxfKAWWVHVAc10JTu9Cu3lZkdbut6LdHfKVs6lUqV0hKis3kO
         7JHDLaQBSlglECY2YwhiCXKBAMuAgpb+/S5hPklqFZFOYsn4jvR59jxlTfEZKb+7muhg
         pXBAxpnN5Uca1L5YFqmvqN+PEnBkZDtH4Yn85SwLx8RsNnhmdVwIbcww7HXHUsAXRSn7
         +eYmoHri323IPMJd4LYxD8DVMWIp8bgb8A8HUJZ7ODKO/WqkLJYPevkR/amqvi+HJ8Xs
         n3Hw5W28f1Oopd7cfnE3q5CE6xaMOUvNBj2wCMuYMIitIlZ6vktHucsRjoseTHV1XQwe
         vqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uPzI2NrDruMsQhpRvojLxqAMj39DRNPyO6rdqBSN6WI=;
        b=M3oF9jTJky7jzqjaD7pWsGHeZ4mZqGzm90394AMQ+Apv9kgQQsE157LJzQyNVb0tG4
         SNm6BAVfCll6ITZYPNB4umz4a7L1E5AXJnhU9+3JwbFo/blHIaYvnVJqWSXT4VfdmX9K
         IcadF9FxYblY5x8VTg9x3Y1HiQr4h5iDxoOg0Uic0PNL89BLxJEvvZcmPUVU2vhLAdMo
         BhXfZdrzseGLdWBLBz7SeS3axerQ7CLmSZRjDQMW958htylO/joFoL7BZdbD4P8EUTrp
         PSRbzyHKSAFB+07nlQk8Q2EVcxqKCe8zlwpoR2j5BWVckcf3wvwnARk4J4tqs2BX7Cp3
         Zj0g==
X-Gm-Message-State: AOAM533PZDFacnQyULYd4+FvpCAMQTIzOZFONEgsK0g+ed0nALxsyDhv
        sfDUCd9yn2N8NqGGnofV/Q2vFQ==
X-Google-Smtp-Source: ABdhPJx1CPqw/ut3dzEX3LKjQ08PsOTU2iRbFD2/TlBgCe3+4sFB4uej65dGSXc4brDcrHOKXOCGuQ==
X-Received: by 2002:a05:6a00:2484:b0:50e:68e:d5a5 with SMTP id c4-20020a056a00248400b0050e068ed5a5mr22340952pfv.47.1652791641262;
        Tue, 17 May 2022 05:47:21 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y13-20020a170902b48d00b00161ac982b52sm1372754plr.95.2022.05.17.05.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 05:47:19 -0700 (PDT)
Message-ID: <3d271554-9ddc-07ad-3ff8-30aba31f8bf2@kernel.dk>
Date:   Tue, 17 May 2022 06:47:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [REPORT] Use-after-free Read in __fdget_raw in v5.10.y
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YoOJ/T4QRKC+fAZE@google.com>
 <97cba3e1-4ef7-0a17-8456-e0787d6702c6@kernel.dk>
 <YoOT7Cyobsed5IE3@google.com>
 <d503d5ff-4bc5-2bd0-00d3-cd7b0a0724cb@kernel.dk>
 <YoOW2+ov8KF1YcYF@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoOW2+ov8KF1YcYF@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/22 6:36 AM, Lee Jones wrote:
> On Tue, 17 May 2022, Jens Axboe wrote:
> 
>> On 5/17/22 6:24 AM, Lee Jones wrote:
>>> On Tue, 17 May 2022, Jens Axboe wrote:
>>>
>>>> On 5/17/22 5:41 AM, Lee Jones wrote:
>>>>> Good afternoon Jens, Pavel, et al.,
>>>>>
>>>>> Not sure if you are presently aware, but there appears to be a
>>>>> use-after-free issue affecting the io_uring worker driver (fs/io-wq.c)
>>>>> in Stable v5.10.y.
>>>>>
>>>>> The full sysbot report can be seen below [0].
>>>>>
>>>>> The C-reproducer has been placed below that [1].
>>>>>
>>>>> I had great success running this reproducer in an infinite loop.
>>>>>
>>>>> My colleague reverse-bisected the fixing commit to:
>>>>>
>>>>>   commit fb3a1f6c745ccd896afadf6e2d6f073e871d38ba
>>>>>   Author: Jens Axboe <axboe@kernel.dk>
>>>>>   Date:   Fri Feb 26 09:47:20 2021 -0700
>>>>>
>>>>>        io-wq: have manager wait for all workers to exit
>>>>>
>>>>>        Instead of having to wait separately on workers and manager, just have
>>>>>        the manager wait on the workers. We use an atomic_t for the reference
>>>>>        here, as we need to start at 0 and allow increment from that. Since the
>>>>>        number of workers is naturally capped by the allowed nr of processes,
>>>>>        and that uses an int, there is no risk of overflow.
>>>>>
>>>>>        Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>>     fs/io-wq.c | 30 ++++++++++++++++++++++--------
>>>>>     1 file changed, 22 insertions(+), 8 deletions(-)
>>>>
>>>> Does this fix it:
>>>>
>>>> commit 886d0137f104a440d9dfa1d16efc1db06c9a2c02
>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>> Date:   Fri Mar 5 12:59:30 2021 -0700
>>>>
>>>>     io-wq: fix race in freeing 'wq' and worker access
>>>>
>>>> Looks like it didn't make it into 5.10-stable, but we can certainly
>>>> rectify that.
>>>
>>> Thanks for your quick response Jens.
>>>
>>> This patch doesn't apply cleanly to v5.10.y.
>>
>> This is probably why it never made it into 5.10-stable :-/
> 
> Right.  It doesn't apply at all unfortunately.
> 
>>> I'll have a go at back-porting it.  Please bear with me.
>>
>> Let me know if you into issues with that and I can help out.
> 
> I think the dependency list is too big.
> 
> Too much has changed that was never back-ported.
> 
> Actually the list of patches pertaining to fs/io-wq.c alone isn't so
> bad, I did start to back-port them all but some of the big ones have
> fs/io_uring.c changes incorporated and that list is huge (256 patches
> from v5.10 to the fixing patch mentioned above).

The problem is that 5.12 went to the new worker setup, and this patch
landed after that even though it also applies to the pre-native workers.
Hence the dependency chain isn't really as long as it seems, probably
just a few patches backporting the change references and completions.

I'll take a look this afternoon.

-- 
Jens Axboe


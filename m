Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B48B52C09A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240051AbiERQX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiERQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:23:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAB21DFDB7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:23:21 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so2832684ioe.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZMsRoI4KrjHlDEKqoEe/GvbetyAMCIzixojKRxrV6BU=;
        b=IrWUtN8Gw5fp1BODZDdvMtTFT909fmx7BVUrRA5LnACeXOXOFJQIVAEU8aHS+sIgsZ
         8XqOF6A76YUXmBfqpMaIAnLpA6BnFPYw8+oeGEGM92eytIfksBkbrZY4egC5+PuLD+zV
         c4W4NO/W6oIgiqKFv8fyRDE4iW6VVmUaMNfNIwQH0Uboa4T2l2MjybZ7OVOeVEQFOaVN
         VlO6Zh/MA7n7uQgU6rq0J6ZKXO6Bq13PBwa9F64ClIdTyupim9AYkN0yU8tM2+eCmkpg
         DmIkl6C9VOuZqzg9gwJw+FQpKPCuZLc3vaB9+rmGgou+hJXjPs/EJQn78Ygln76T/Ap6
         1wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZMsRoI4KrjHlDEKqoEe/GvbetyAMCIzixojKRxrV6BU=;
        b=4mJTgIA5yhm2CxvkMjP8IOmFcXd73sxPw+Vg1qcswqp7gBN10hl3aLGVTiLcZh1xSx
         Xg68NR/eIu5ZLHawoTzTOsV/PD1OZiBeuxypw8ItMirvu3wNY8qIeFjJaYAijbisRkvV
         dHYHu+u3dE0BR2PgkhXmqcY8+BgyeSLl+hMt57n7p0aD8YXj9Ue/776fKOG3EsyhNH6E
         HnjSKJVvpOmG6grtrrtKOHHT4WYTrPQiN4ORekeZAdtd1ACLx7sBgC5fgGbk3NXtGupZ
         VQuMhfN5QZmDGA4pixHuJ25IcR0sGzetJBioO5ou0ybxm5WKsxGYDaqKAyiDJz1AK9o/
         G9Kg==
X-Gm-Message-State: AOAM5331Qy3eNeIn9vh2aSJc7wF4ML6qqj8uOP3XN5pkdmgS3UX6FS3l
        OQmZoYBYCS2ZWoht96IgznIw+Q==
X-Google-Smtp-Source: ABdhPJxrykWSB+g83T/y/HW4GFRqEVUddjLGoyn8EjivMQzsYVNt+NniJE6eMd5Lk537ZYTfOeybrQ==
X-Received: by 2002:a05:6602:1687:b0:65a:cc6a:91f5 with SMTP id s7-20020a056602168700b0065acc6a91f5mr192093iow.191.1652891000472;
        Wed, 18 May 2022 09:23:20 -0700 (PDT)
Received: from [192.168.1.170] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k8-20020a0566022a4800b0065a47e16f55sm754840iov.39.2022.05.18.09.23.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 09:23:17 -0700 (PDT)
Message-ID: <1e64d20a-42cc-31cd-0fd8-2718dd8b1f31@kernel.dk>
Date:   Wed, 18 May 2022 10:23:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [REPORT] Use-after-free Read in __fdget_raw in v5.10.y
Content-Language: en-US
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YoOW2+ov8KF1YcYF@google.com>
 <3d271554-9ddc-07ad-3ff8-30aba31f8bf2@kernel.dk>
 <YoOcYR15Jhkw2XwL@google.com>
 <f34c85cc-71a5-59d4-dd7a-cc07e2af536c@kernel.dk>
 <YoTrmjuct3ctvFim@google.com>
 <b7dc2992-e2d6-8e76-f089-b33561f8471f@kernel.dk>
 <f821d544-78d5-a227-1370-b5f0895fb184@kernel.dk>
 <06710b30-fec8-b593-3af4-1318515b41d8@kernel.dk>
 <YoUNQlzU0W4ShA85@google.com>
 <49609b89-f2f0-44b3-d732-dfcb4f73cee1@kernel.dk>
 <YoUTPIVOhLlnIO04@google.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoUTPIVOhLlnIO04@google.com>
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

On 5/18/22 09:39, Lee Jones wrote:
> On Wed, 18 May 2022, Jens Axboe wrote:
> 
>> On 5/18/22 9:14 AM, Lee Jones wrote:
>>> On Wed, 18 May 2022, Jens Axboe wrote:
>>>
>>>> On 5/18/22 6:54 AM, Jens Axboe wrote:
>>>>> On 5/18/22 6:52 AM, Jens Axboe wrote:
>>>>>> On 5/18/22 6:50 AM, Lee Jones wrote:
>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
>>>>>>>
>>>>>>>> On 5/17/22 7:00 AM, Lee Jones wrote:
>>>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
>>>>>>>>>
>>>>>>>>>> On 5/17/22 6:36 AM, Lee Jones wrote:
>>>>>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 5/17/22 6:24 AM, Lee Jones wrote:
>>>>>>>>>>>>> On Tue, 17 May 2022, Jens Axboe wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> On 5/17/22 5:41 AM, Lee Jones wrote:
>>>>>>>>>>>>>>> Good afternoon Jens, Pavel, et al.,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Not sure if you are presently aware, but there appears to be a
>>>>>>>>>>>>>>> use-after-free issue affecting the io_uring worker driver (fs/io-wq.c)
>>>>>>>>>>>>>>> in Stable v5.10.y.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The full sysbot report can be seen below [0].
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The C-reproducer has been placed below that [1].
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I had great success running this reproducer in an infinite loop.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> My colleague reverse-bisected the fixing commit to:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>   commit fb3a1f6c745ccd896afadf6e2d6f073e871d38ba
>>>>>>>>>>>>>>>   Author: Jens Axboe <axboe@kernel.dk>
>>>>>>>>>>>>>>>   Date:   Fri Feb 26 09:47:20 2021 -0700
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>        io-wq: have manager wait for all workers to exit
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>        Instead of having to wait separately on workers and manager, just have
>>>>>>>>>>>>>>>        the manager wait on the workers. We use an atomic_t for the reference
>>>>>>>>>>>>>>>        here, as we need to start at 0 and allow increment from that. Since the
>>>>>>>>>>>>>>>        number of workers is naturally capped by the allowed nr of processes,
>>>>>>>>>>>>>>>        and that uses an int, there is no risk of overflow.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>        Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>     fs/io-wq.c | 30 ++++++++++++++++++++++--------
>>>>>>>>>>>>>>>     1 file changed, 22 insertions(+), 8 deletions(-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Does this fix it:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> commit 886d0137f104a440d9dfa1d16efc1db06c9a2c02
>>>>>>>>>>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>>>>>>>>>>> Date:   Fri Mar 5 12:59:30 2021 -0700
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>     io-wq: fix race in freeing 'wq' and worker access
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Looks like it didn't make it into 5.10-stable, but we can certainly
>>>>>>>>>>>>>> rectify that.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks for your quick response Jens.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This patch doesn't apply cleanly to v5.10.y.
>>>>>>>>>>>>
>>>>>>>>>>>> This is probably why it never made it into 5.10-stable :-/
>>>>>>>>>>>
>>>>>>>>>>> Right.  It doesn't apply at all unfortunately.
>>>>>>>>>>>
>>>>>>>>>>>>> I'll have a go at back-porting it.  Please bear with me.
>>>>>>>>>>>>
>>>>>>>>>>>> Let me know if you into issues with that and I can help out.
>>>>>>>>>>>
>>>>>>>>>>> I think the dependency list is too big.
>>>>>>>>>>>
>>>>>>>>>>> Too much has changed that was never back-ported.
>>>>>>>>>>>
>>>>>>>>>>> Actually the list of patches pertaining to fs/io-wq.c alone isn't so
>>>>>>>>>>> bad, I did start to back-port them all but some of the big ones have
>>>>>>>>>>> fs/io_uring.c changes incorporated and that list is huge (256 patches
>>>>>>>>>>> from v5.10 to the fixing patch mentioned above).
>>>>>>>>>>
>>>>>>>>>> The problem is that 5.12 went to the new worker setup, and this patch
>>>>>>>>>> landed after that even though it also applies to the pre-native workers.
>>>>>>>>>> Hence the dependency chain isn't really as long as it seems, probably
>>>>>>>>>> just a few patches backporting the change references and completions.
>>>>>>>>>>
>>>>>>>>>> I'll take a look this afternoon.
>>>>>>>>>
>>>>>>>>> Thanks Jens.  I really appreciate it.
>>>>>>>>
>>>>>>>> Can you see if this helps? Untested...
>>>>>>>
>>>>>>> What base does this apply against please?
>>>>>>>
>>>>>>> I tried Mainline and v5.10.116 and both failed.
>>>>>>
>>>>>> It's against 5.10.116, so that's puzzling. Let me double check I sent
>>>>>> the right one...
>>>>>
>>>>> Looks like I sent the one from the wrong directory, sorry about that.
>>>>> This one should be better:
>>>>
>>>> Nope, both are the right one. Maybe your mailer is mangling the patch?
>>>> I'll attach it gzip'ed here in case that helps.
>>>
>>> Okay, that applied, thanks.
>>>
>>> Unfortunately, I am still able to crash the kernel in the same way.
>>
>> Alright, maybe it's not enough. I can't get your reproducer to crash,
>> unfortunately. I'll try on a different box.
> 
> You need to have fuzzing and kasan enabled.

I do have kasan enabled. What's fuzzing?

-- 
Jens Axboe


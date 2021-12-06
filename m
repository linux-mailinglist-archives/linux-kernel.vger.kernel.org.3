Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE5346A6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349735AbhLFUie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbhLFUie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:38:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C92C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:35:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 75AA21F43911
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638822903; bh=Tywh5Z25K4ZKXNz67giESzYOoPVDIKEPK6wkKKydDo0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ouWKTS1qAmjUH3n1Ecs3mywaxj0VBgL8eiKl5MlH8fzNgkyF5hfFLvru4sOerEwnR
         SquQDBOQXCRBGdDzGRC3SdC4Y9HBzZLYclkcl+2RYvN6355X7fJZ+xwTlYQFiUKEuv
         YCKkr9ApRwiw6E67IWXwRENXrSkYUlqMB2jOZog/436ljU51WCwZV34m6MuFpw6f4J
         q5g6RyjkBbigfVMvF2bPs5yTzr0Dia88QoV/m7X5cSnRscIYUqHijupxDpWhiNSi/W
         hWitmcPBFHhvldP8XPwKIAzXA0hAF4x84WK+Vnetp5+LoWUEkJuuaagEeLpI44N7LW
         2PH+M24MZhSXQ==
Message-ID: <8a7cc760-b1e2-0da6-f3cc-4e7baa3d956c@collabora.com>
Date:   Mon, 6 Dec 2021 17:34:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] futex: Fix a faulty comment.
Content-Language: en-US
To:     Jangwoong Kim <6812skiii@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        dvhart@infradead.org, dave@stgolabs.net,
        linux-kernel@vger.kernel.org
References: <20211204181458.10076-1-6812skiii@gmail.com>
 <f7d9194b-6681-48f0-b5e9-11f43d2849bd@collabora.com>
 <CAF=mnpi65WtnK_mF1f8GfMEczS1ruj8q4YbA18R5KvWcpkxLxw@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <CAF=mnpi65WtnK_mF1f8GfMEczS1ruj8q4YbA18R5KvWcpkxLxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jangwoong,

Please don't top post when replying to emails in this list (read more
here: https://www.mediawiki.org/wiki/Mailing_list_etiquette)

Às 14:44 de 06/12/21, Jangwoong Kim escreveu:
> Hi André.
> 
> That patch was definitely wrong, I apologize.
> 
> However, since futex_wait_multiple_setup() sets the last index of
> futex that was woken up,
> shouldn't the comment be modified as below?
> 
> If so, I will resend a patch.
> 
>                 /*
> -                * Even if something went wrong, if we find out that a futex
> -                * was woken, we don't return error and return this index to
> -                * userspace
> +                * Even if something went wrong, if we find out that any futex
> +                * was woken, we don't return error and return the last index
> +                * awoken to userspace

Indeed, this is more correct. You can send a patch to clarify this comment.

>                  */
>                 *woken = unqueue_multiple(vs, i);
>                 if (*woken >= 0)
> 
> I sent the patch because I thought this was important enough to be corrected.
> 
> Let me know If this is not crucial enough to be patched, so I won't
> keep sending comment-fixing patches.
> 
> Thank you.
> Jangwoong Kim.
> 
> 2021년 12월 6일 (월) 오후 9:12, André Almeida <andrealmeid@collabora.com>님이 작성:
>>
>> Hi Jangwoong,
>>
>> Thanks for your patch! However...
>>
>> Às 15:14 de 04/12/21, 6812skiii@gmail.com escreveu:
>>> From: Jangwoong Kim <6812skiii@gmail.com>
>>>
>>> We return 1, not the index of futex woken up.
>>>
>>> Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
>>> ---
>>>  kernel/futex/waitwake.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
>>> index 4ce0923f1ce3..d148e5d4956b 100644
>>> --- a/kernel/futex/waitwake.c
>>> +++ b/kernel/futex/waitwake.c
>>> @@ -455,8 +455,8 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
>>>
>>>               /*
>>>                * Even if something went wrong, if we find out that a futex
>>> -              * was woken, we don't return error and return this index to
>>> -              * userspace
>>> +              * was woken, we don't return error and make userspace aware
>>> +              * of this by returning 1.
>>
>> We return to userspace the value at *woken, so your fix is wrong. Have a
>> look at futex_wait_multiple():
>>
>>                 ret = futex_wait_multiple_setup(vs, count, &hint);
>>                 if (ret) {
>>                         if (ret > 0) {
>>                                 /* A futex was woken during setup */
>>                                 ret = hint;
>>                         }
>>                         return ret;
>>                 }
>>
>> When we return 1 at futex_wait_multiple_setup(), we end up returning the
>> hint/woken value to userspace.
>>
>> Let me know if you have questions.
>>
>>         André

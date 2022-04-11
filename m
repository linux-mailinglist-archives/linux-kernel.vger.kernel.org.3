Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0421C4FB47F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiDKHVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiDKHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:21:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348781D301
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:19:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h19so13861099pfv.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 00:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8bS+xErHAGcrcon+8lxsi6Kya24d6PhBJKfU0r5BfDc=;
        b=o+lmv2WaStZIOtDUEmOuH5gI1NF2ha452cnwJkJWj6B7MAt439eAgjQVoJosG28zzu
         MZhXU1nBab+9J1BIpAMX55+bAAKdAp5WK7WYYuK+0QqYA0/Bg1K/G28cXkxqf50z6MVI
         9Iexe56dMsxsPdjOsBUrRo+U5TmRPIyyeqlIFmjj9Kq4p6gmiM2rpQGSBwqU+wOLYbLN
         8Tok41N6z+tK1XJkAZ0qUQI1I06BmWucLFgwMlnV5QS13iBLCn7e+WOwfCO6nn2xj0eb
         1vdCBqkzeeFtjVp4sRhDQh3o6k7PjtgcYyPeAb0iIOtbZmS4j4uKg5SiXljhFQmsb/Ev
         I/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8bS+xErHAGcrcon+8lxsi6Kya24d6PhBJKfU0r5BfDc=;
        b=PtMX6OqZt4B8Yx6opNNlxKKxW2OlcjLugTKkegAO9KTDbDCu596mMZfGSimoqtsosk
         qePveicxqItY/cQ5yDLW/lnZYcjPm2xXIAsE24+lxVXnkZ/Qr+oXd90txQlCZkP52O+S
         T/1No6zybBXIAPqwNg6qp2fcycKstWu3HnKUVDR5ZWhpYZKn74U9InzcgVXx9N9Ky6Wg
         jM6bUVoSgfGKEE9jdmuTSp9uY+gsMu7D7W/AwrwTsy+mQzSfFMB6OmPOpNBDqClY/Uyr
         RtD1JKBCVs5QVA/CmFYTPbaiFNlGaSkO8ZFo6qwbvazk27SXDA2ZwnrcmaGkAeQXkVnK
         jnMw==
X-Gm-Message-State: AOAM532yLIL3Gg9yjqszlPNEe4PwQ9uJFvT580OgCfnd7kp3I6y+58Yi
        YN5gzNVjFnY4wbHo19fjnPKawg==
X-Google-Smtp-Source: ABdhPJyatikuFExRipYPOvZibGosGBND/jugvysFTT17HVykDJ6NelEAbFQNNHM8mlfRiskYBkT8RA==
X-Received: by 2002:a05:6a00:178f:b0:505:8b3d:48d8 with SMTP id s15-20020a056a00178f00b005058b3d48d8mr14461426pfg.64.1649661568994;
        Mon, 11 Apr 2022 00:19:28 -0700 (PDT)
Received: from [10.255.164.50] ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm35771995pfj.146.2022.04.11.00.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 00:19:28 -0700 (PDT)
Message-ID: <e5dbcdfe-c011-cf26-07c8-71dd720eb16a@bytedance.com>
Date:   Mon, 11 Apr 2022 15:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Content-Language: en-US
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, songmuchun@bytedance.com
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <YlBzsakUloG4nS7W@slm.duckdns.org>
 <7213fc3b-27f5-373a-0786-0ca9441b9e7e@bytedance.com>
In-Reply-To: <7213fc3b-27f5-373a-0786-0ca9441b9e7e@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/9 8:40 AM, Qi Zheng wrote:
> 
> 
> On 2022/4/9 1:41 AM, Tejun Heo wrote:
>> Hello,
>>
>> On Thu, Apr 07, 2022 at 06:33:35PM +0800, Qi Zheng wrote:
>>> In the percpu_ref_call_confirm_rcu(), we call the wake_up_all()
>>> before calling percpu_ref_put(), which will cause the value of
>>> percpu_ref to be unstable when percpu_ref_switch_to_atomic_sync()
>>> returns.
>>>
>>>     CPU0                CPU1
>>>
>>> percpu_ref_switch_to_atomic_sync(&ref)
>>> --> percpu_ref_switch_to_atomic(&ref)
>>>      --> percpu_ref_get(ref);    /* put after confirmation */
>>>     call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
>>>
>>>                     percpu_ref_switch_to_atomic_rcu
>>>                     --> percpu_ref_call_confirm_rcu
>>>                         --> data->confirm_switch = NULL;
>>>                         wake_up_all(&percpu_ref_switch_waitq);
>>>
>>>      /* here waiting to wake up */
>>>      wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
>>>                         (A)percpu_ref_put(ref);
>>> /* The value of &ref is unstable! */
>>> percpu_ref_is_zero(&ref)
>>>                         (B)percpu_ref_put(ref);
>>>
>>> As shown above, assuming that the counts on each cpu add up to 0 before
>>> calling percpu_ref_switch_to_atomic_sync(), we expect that after 
>>> switching
>>> to atomic mode, percpu_ref_is_zero() can return true. But actually it 
>>> will
>>> return different values in the two cases of A and B, which is not what
>>> we expected.
>>>
>>> Maybe the original purpose of percpu_ref_switch_to_atomic_sync() is
>>> just to ensure that the conversion to atomic mode is completed, but it
>>> should not return with an extra reference count.
>>>
>>> Calling wake_up_all() after percpu_ref_put() ensures that the value of
>>> percpu_ref is stable after percpu_ref_switch_to_atomic_sync() returns.
>>> So just do it.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>   lib/percpu-refcount.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
>>> index af9302141bcf..b11b4152c8cd 100644
>>> --- a/lib/percpu-refcount.c
>>> +++ b/lib/percpu-refcount.c
>>> @@ -154,13 +154,14 @@ static void percpu_ref_call_confirm_rcu(struct 
>>> rcu_head *rcu)
>>>       data->confirm_switch(ref);
>>>       data->confirm_switch = NULL;
>>> -    wake_up_all(&percpu_ref_switch_waitq);
>>>       if (!data->allow_reinit)
>>>           __percpu_ref_exit(ref);
>>>       /* drop ref from percpu_ref_switch_to_atomic() */
>>>       percpu_ref_put(ref);
>>> +
>>> +    wake_up_all(&percpu_ref_switch_waitq);
>>
>> The interface, at least originally, doesn't give any guarantee over 
>> whether
>> there's gonna be a residual reference on it or not. There's nothing
>> necessarily wrong with guaranteeing that but it's rather unusual and 
>> given
>> that putting the base ref in a percpu_ref is a special "kill" 
>> operation and
>> a ref in percpu mode always returns %false on is_zero(), I'm not quite 
>> sure
>> how such semantics would be useful. Do you care to explain the use 
>> case with
>> concrete examples?
> 
> There are currently two users of percpu_ref_switch_to_atomic_sync(), and 
> both are used in the example, one is mddev->writes_pending in
> driver/md/md.c and the other is q->q_usage_counter in block/blk-pm.c.
> 
> The former discards the initial reference count after percpu_ref_init(),
> and the latter kills the initial reference count(by calling 
> percpu_ref_kill() in blk_freeze_queue_start()) before
> percpu_ref_switch_to_atomic_sync(). Looks like they all expect
> percpu_ref to be stable when percpu_ref_switch_to_atomic_sync() returns.
> 
>>
>> Also, the proposed patch is racy. There's nothing preventing
>> percpu_ref_switch_to_atomic_sync() from waking up early between
>> confirm_switch clearing and the wake_up_all, so the above change doesn't
>> guarantee what it tries to guarantee. For that, you'd have to move
>> confirm_switch clearing *after* percpu_ref_put() but then, you'd be
>> accessing the ref after its final ref is put which can lead to
>> use-after-free.
>>
> 
> Oh sorry, it is my bad missing.
> 
>> In fact, the whole premise seems wrong. The switching needs a 
>> reference to
>> the percpu_ref because it is accessing it asynchronously. The 
>> switching side
>> doesn't know when the ref is gonna go away once it puts its reference and
>> thus can't signal that they're done after putting their reference.
>>
>> We *can* make that work by putting the whole thing in its own critical
>> section so that we can make confirm_switch clearing atomic with the 
>> possibly
>> final put, but that's gonna add some complexity and begs the question why
>> we'd need such a thing.
> 
> How about moving the last percpu_ref_put() outside of the
> percpu_ref_switch_to_atomic_rcu() in sync mode like below? But this may 
> not be elegant.
> 
> diff --git a/include/linux/percpu-refcount.h 
> b/include/linux/percpu-refcount.h
> index d73a1c08c3e3..07f92e7e3e19 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h
> @@ -98,6 +98,7 @@ struct percpu_ref_data {
>          percpu_ref_func_t       *confirm_switch;
>          bool                    force_atomic:1;
>          bool                    allow_reinit:1;
> +       bool                    sync;
>          struct rcu_head         rcu;
>          struct percpu_ref       *ref;
>   };
> @@ -123,7 +124,8 @@ int __must_check percpu_ref_init(struct percpu_ref 
> *ref,
>                                   gfp_t gfp);
>   void percpu_ref_exit(struct percpu_ref *ref);
>   void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
> -                                percpu_ref_func_t *confirm_switch);
> +                                percpu_ref_func_t *confirm_switch,
> +                                bool sync);
>   void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
>   void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
>   void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index af9302141bcf..2a9d777bcf35 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -99,6 +99,7 @@ int percpu_ref_init(struct percpu_ref *ref, 
> percpu_ref_func_t *release,
>          data->release = release;
>          data->confirm_switch = NULL;
>          data->ref = ref;
> +       data->sync = false;
>          ref->data = data;
>          return 0;
>   }
> @@ -146,21 +147,30 @@ void percpu_ref_exit(struct percpu_ref *ref)
>   }
>   EXPORT_SYMBOL_GPL(percpu_ref_exit);
> 
> +static inline void percpu_ref_switch_to_atomic_post(struct percpu_ref 
> *ref)
> +{
> +       struct percpu_ref_data *data = ref->data;
> +
> +       if (!data->allow_reinit)
> +               __percpu_ref_exit(ref);
> +
> +       /* drop ref from percpu_ref_switch_to_atomic() */
> +       percpu_ref_put(ref);
> +}
> +
>   static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
>   {
>          struct percpu_ref_data *data = container_of(rcu,
>                          struct percpu_ref_data, rcu);
>          struct percpu_ref *ref = data->ref;
> +       bool need_put = !data->sync;
> 
>          data->confirm_switch(ref);
>          data->confirm_switch = NULL;
>          wake_up_all(&percpu_ref_switch_waitq);
> 
> -       if (!data->allow_reinit)
> -               __percpu_ref_exit(ref);
> -
> -       /* drop ref from percpu_ref_switch_to_atomic() */
> -       percpu_ref_put(ref);
> +       if (need_put)
> +               percpu_ref_switch_to_atomic_post(ref);
>   }
> 
>   static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
> @@ -302,12 +312,14 @@ static void __percpu_ref_switch_mode(struct 
> percpu_ref *ref,
>    * switching to atomic mode, this function can be called from any 
> context.
>    */
>   void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
> -                                percpu_ref_func_t *confirm_switch)
> +                                percpu_ref_func_t *confirm_switch,
> +                                bool sync)
>   {
>          unsigned long flags;
> 
>          spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> 
> +       ref->data->sync = sync;
>          ref->data->force_atomic = true;
>          __percpu_ref_switch_mode(ref, confirm_switch);
> 
> @@ -325,8 +337,9 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
>    */
>   void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
>   {
> -       percpu_ref_switch_to_atomic(ref, NULL);
> +       percpu_ref_switch_to_atomic(ref, NULL, true);
>          wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
> +       percpu_ref_switch_to_atomic_post(ref);
>   }
>   EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);

Hi all, is this fix ok? I can send the v2 version if it looks good.

Thanks,
Qi

> 
>>
>> Andrew, I don't think the patch as proposed makes much sense. Maybe 
>> it'd be
>> better to keep it out of the tree for the time being?
>>
>> Thanks.
>>
> 

-- 
Thanks,
Qi

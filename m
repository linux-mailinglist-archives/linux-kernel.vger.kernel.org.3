Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95C4B5B29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiBNUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:45:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiBNUpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75F3C1BAC46
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644871176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAECzVoo6xb20snd0BZ4vnL4W4MCzeWKIUtHRwlsp2E=;
        b=VjEbaqBGJvMe2bYdI9Dx55EeQiidMGaHnaHeu/p6Cg1d9BgBPZKUFYlWAT6CGZY0q+Lzro
        4z/uVEayc1B1UzPOmBrY29K1iQjbpL7wxNWcehy7apL6dLtcFZb7g3dZwUJSGsQziTo85V
        LjPXbHj2swzdRmHsWkoklecuLHCzSYI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-yCYbegcjPfOImNpnK1GKog-1; Mon, 14 Feb 2022 15:39:34 -0500
X-MC-Unique: yCYbegcjPfOImNpnK1GKog-1
Received: by mail-il1-f199.google.com with SMTP id x6-20020a923006000000b002bea39c3974so9927765ile.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HAECzVoo6xb20snd0BZ4vnL4W4MCzeWKIUtHRwlsp2E=;
        b=gI/A3aXgAA2BzBtkdPaqr/6xewqsWEj0iYhmx3tLnle/c0Ty8LWSEHKbD4csA9u8If
         AaAQnZOkfPC0ZiAw6dTAFB8x7NWTeu8ODuGzx6JVjhTKhs6Mkh2dygl5MVCN7cAB4gAI
         1aKotpHw/cpXJVM00DQuf6FOFXv5/PasqvFdJBWFic2Qk6nXCjrqbLZYm00LY8xRDdTf
         6kMEuLQ/PosnwCjgXI7ORVUB03PFQo+GQ8JSVOyfQgXZjBTAOh5bmShsfRnLrXn5PSHS
         KZQFNpPxIS/DRC1bqpYlLI3ntDI4ycT+K4rAJ13nYjDnSB+gQQ8ItWoucNds6xwgUtoJ
         MlkA==
X-Gm-Message-State: AOAM533BIxTeAYIkm8vs7rVa9eeYNKtwzJ3SMHLXjxGDWQqF11OibuAz
        vD46I6G2i2XszY82Gsc8Q8tC1+ilnHyp41PEQO5ndacQ0om+/nJSxryfZGeO3J13RNSE7yV8Lld
        NZeb23tqWTpdHy7kXvNs0qx/8
X-Received: by 2002:a05:6e02:15c8:: with SMTP id q8mr395721ilu.19.1644871174089;
        Mon, 14 Feb 2022 12:39:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5cu3m+TozT2FZ+o5dsIkovOwm0QFJliaGHGqwZZ83nc7T40s7dpZ9fgU1na7EoDMJfryjvg==
X-Received: by 2002:a05:6e02:15c8:: with SMTP id q8mr395702ilu.19.1644871173792;
        Mon, 14 Feb 2022 12:39:33 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::4f60? ([2601:280:4400:a2e0::4f60])
        by smtp.gmail.com with ESMTPSA id u12sm16796049ilg.51.2022.02.14.12.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 12:39:33 -0800 (PST)
Message-ID: <118fc685-c68d-614f-006a-7d5487302122@redhat.com>
Date:   Mon, 14 Feb 2022 15:39:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved robust
 futex
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        jsavitz@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
 <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
 <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YeZ/mL808DpA8mdG@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/22 03:51, Michal Hocko wrote:
> On Mon 17-01-22 17:56:28, Nico Pache wrote:
>> On 1/17/22 11:05, Waiman Long wrote:
>>> On 1/17/22 03:52, Michal Hocko wrote:
> [...]
>>>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>>>> index 1ddabefcfb5a..3cdaac9c7de5 100644
>>>>> --- a/mm/oom_kill.c
>>>>> +++ b/mm/oom_kill.c
>>>>> @@ -667,6 +667,21 @@ static void wake_oom_reaper(struct task_struct *tsk)
>>>>>       if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
>>>>>           return;
>>>>>   +#ifdef CONFIG_FUTEX
>>>>> +    /*
>>>>> +     * If the ooming task's SIGKILL has not finished handling the
>>>>> +     * robust futex it is not correct to reap the mm concurrently.
>>>>> +     * Do not wake the oom reaper when the task still contains a
>>>>> +     * robust list.
>>>>> +     */
>>>>> +    if (tsk->robust_list)
>>>>> +        return;
>>>>> +#ifdef CONFIG_COMPAT
>>>>> +    if (tsk->compat_robust_list)
>>>>> +        return;
>>>>> +#endif
>>>>> +#endif
>>>> If this turns out to be really needed, which I do not really see at the
>>>> moment, then this is not the right way to handle this situation. The oom
>>>> victim could get stuck and the oom killer wouldn't be able to move
>>>> forward. If anything the victim would need to get MMF_OOM_SKIP set.
>>
>> I will try this, but I don't immediately see any difference between this return
>> case and setting the bit, passing the oom_reaper_list, then skipping it based on
>> the flag. Do you mind explaining how this could lead to the oom killer getting
>> stuck?
> 
> The primary purpose of the oom_reaper is to guarantee a forward
> progress. If a task gets stuck in the kernel - e.g. on locks then it
> won't bail out and won't handle signals (i.e. SIGKILL from the
> userspace). The oom killer prevents new oom victims selection in a
> presence of an existing oom victim (see oom_evaluate_task). That means
> that we not only send a SIGKILL to the victim, we also wake up the oom
> reaper which then asynchronously tears down the private memory of the
> task (thus release at least some of its memory) and once it is done it
> will set MMF_OOM_SKIP flag which will tell the oom killer
> (oom_evaluate_task) that this victim is no longer interesting and a new
> victim can be selected.
> 
> Makes sense?
Thank does, Thank you for clearing that up!
> 
> Part of the async tear down is also MMF_UNSTABLE handling (see
> __oom_reap_task_mm) which tells #PF handling code
> (check_stable_address_space) that the underlying memory could have been
> tempered with and thus it should return SIGBUS. The underlying
> assumption is that the process (and all tasks which share its mm) has
> been killed and it will never return to the userspace so the de-facto
> memory corruption doesn't matter.
> 
> One thing that is still unclear to me is why this leads to any locked up
> tasks. Looking at exit_robust_list I can see that it is accessing the
> userspace memory but this should return EFAULT in this situation. My
> assumption (which might be really wrong) is that futex shared among
> processes which are not sharing mm nor signal handling will be sitting
> in a shared memory. 
> 
> Now to the actual fix. I do not think we want to hide the task from the
> oom reaper as you are suggesting. Futexes are very likely to be used for
> many processes and that would make the whole async scheme useless. We
> need something like the below.
> 
> futex_exit_release is not directly usable as it implicitly depends
> on memory allocation (#PF) and that is not acceptable. So instead we
> need something futex_exit_try_release or similar which would fail the
> operation in case get_user (pagefault_disable) needs to really handle
> the #PF or if the futex_exit_mutex is locked. In other words this would
> have to be a completely non-blocking operation. The oom reaper would
> then bail out.
Yeah Joel came up with a similar idea once we realized his v2 had the issue with
sleeping.

We've recently been discussing the following if statement in __oom_reap_task_mm:
	if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED))

Given the comment above it, and some of the upstream discussion the original
RFC, we are struggling to see why this should be a `||` and not an `&&`. If we
only want to reap anon memory and reaping shared memory can be dangerous is this
statement incorrect?

We have a patch queued up to make this change, but wanted to get your opinion on
why this was originally designed this way in case we are missing something.

-- Nico

> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index ef5860fc7d22..57660d3d1b79 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -613,6 +613,9 @@ static void oom_reap_task(struct task_struct *tsk)
>  	int attempts = 0;
>  	struct mm_struct *mm = tsk->signal->oom_mm;
>  
> +	if (futex_exit_try_release(tsk))
> +		goto fail;
> +
>  	/* Retry the mmap_read_trylock(mm) a few times */
>  	while (attempts++ < MAX_OOM_REAP_RETRIES && !oom_reap_task_mm(tsk, mm))
>  		schedule_timeout_idle(HZ/10);
> @@ -621,6 +624,7 @@ static void oom_reap_task(struct task_struct *tsk)
>  	    test_bit(MMF_OOM_SKIP, &mm->flags))
>  		goto done;
>  
> +fail:
>  	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
>  		task_pid_nr(tsk), tsk->comm);
>  	sched_show_task(tsk);
> @@ -1184,6 +1188,11 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	if (!reap)
>  		goto drop_mm;
>  
> +	if (futex_exit_try_release(tsk)) {
> +		ret = -EAGAIN;
> +		goto drop_mm;
> +	}
> +	
>  	if (mmap_read_lock_killable(mm)) {
>  		ret = -EINTR;
>  		goto drop_mm;


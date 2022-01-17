Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4819E491203
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiAQW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233824AbiAQW4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:56:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642460193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4SiMDUKf0bwggQ9QQhfQEewwFBN7FboHXsvR2X1LEE=;
        b=ac3YvuGHhxAjlaZ0EGMKxo0QS43FzJQopDn7PKhjtQ+OoP3uBgdUXBwQWNpqwAPwr6+owG
        l6vrtH7pmHy24b+yQn4xeCyBVss1jjYLasIhi0TIKxxtZLgc5dsBqdzoXlGqOBrGbxOmmx
        Rmg/QleBiEwizn/AO37qOvlvgpnQ6XI=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-eK8woRmRM8O9-okRSOLPfg-1; Mon, 17 Jan 2022 17:56:32 -0500
X-MC-Unique: eK8woRmRM8O9-okRSOLPfg-1
Received: by mail-io1-f71.google.com with SMTP id g16-20020a05660203d000b005f7b3b0642eso10406397iov.16
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=W4SiMDUKf0bwggQ9QQhfQEewwFBN7FboHXsvR2X1LEE=;
        b=484RGJd96XxCEcpEg0DFAItWPXZjnAzgW4URA1POIjxnRHKTFz+dj/9LJykiAJn9W2
         3GLCXvw7TE8m3WjMM0SGAP7qQFC42uPSjSHQXd627KPZDRJrsh5v8jWW3FLmffpSe3Uo
         xbEKuPrhpef8VKpzNjy/8v6IaFRi8fFp1tfHygl9M50EexGOWgLfUPNYLpgCmMwhYT6X
         g9Qg2pPwdcTWfdUX558ZMjfPyafqEUjjUdIBcs8w1FDvvBd0Mqs74NMMjt/v3SPPsAqB
         vCRWfRfs8jzQUXV7koXsLbBJsIJueXkk2QO+ijcTAY7VAQqmzYXjA71HGz23P0cqdH87
         RJyQ==
X-Gm-Message-State: AOAM531/P9UzBvRxWiKmYqwuruPDEdJK9bOe0PQAczeH5d3UKpnqloYp
        X5ObJUwlBllr+oUEabzJsPsEz/sg2asDEYlq2EgjqPQoFxDWK14aSteJVrk+TDUYQQ42RIFpCcR
        NfAcgu//MYh/TdhqzaGZIrBjk
X-Received: by 2002:a02:6d67:: with SMTP id e39mr10302127jaf.299.1642460191370;
        Mon, 17 Jan 2022 14:56:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzbvmGb4GePwXJb8ImQK18ji/RNeX0Lma2vHcZeyZjzEcuuSrGcAOgBTgpVoiYpBJhHpEv6nw==
X-Received: by 2002:a02:6d67:: with SMTP id e39mr10302121jaf.299.1642460191051;
        Mon, 17 Jan 2022 14:56:31 -0800 (PST)
Received: from ?IPV6:2601:280:4400:a2e0::101f? ([2601:280:4400:a2e0::101f])
        by smtp.gmail.com with ESMTPSA id d16sm11796916iow.14.2022.01.17.14.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 14:56:30 -0800 (PST)
Message-ID: <43a6c470-9fc2-6195-9a25-5321d17540e5@redhat.com>
Date:   Mon, 17 Jan 2022 17:56:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved robust
 futex
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, jsavitz@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@collabora.com
References: <20220114180135.83308-1-npache@redhat.com>
 <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
 <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <ad639326-bea8-9bfb-23e3-4e2b216d9645@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/17/22 11:05, Waiman Long wrote:
> On 1/17/22 03:52, Michal Hocko wrote:
>> On Fri 14-01-22 13:01:35, Nico Pache wrote:
>>> In the case that two or more processes share a futex located within
>>> a shared mmaped region, such as a process that shares a lock between
>>> itself and child processes, we have observed that when a process holding
>>> the lock is oom killed, at least one waiter is never alerted to this new
>>> development and simply continues to wait.
>>>
>>> This is visible via pthreads by checking the __owner field of the
>>> pthread_mutex_t structure within a waiting process, perhaps with gdb.
>>>
>>> We identify reproduction of this issue by checking a waiting process of
>>> a test program and viewing the contents of the pthread_mutex_t, taking note
>>> of the value in the owner field, and then checking dmesg to see if the
>>> owner has already been killed.
>> I believe we really need to find out why the original holder of the
>> futex is not woken up to release the lock when exiting.
> 
> For a robust futex lock holder or waiter that is to be killed, it is not the
> responsibility of the task itself to wake up and release the lock. It is the
> kernel that recognizes that the task is holding or waiting for the robust futex
> and clean thing up.
> 
> 
>>> As mentioned by Michal in his patchset introducing the oom reaper,
>>> commit aac4536355496 ("mm, oom: introduce oom reaper"), the purpose of the
>>> oom reaper is to try and free memory more quickly; however, In the case
>>> that a robust futex is being used, we want to avoid utilizing the
>>> concurrent oom reaper. This is due to a race that can occur between the
>>> SIGKILL handling the robust futex, and the oom reaper freeing the memory
>>> needed to maintain the robust list.
>> OOM reaper is only unmapping private memory. It doesn't touch a shared
>> mappings. So how could it interfere?
>>
> The futex itself may be in shared memory, however the robust list entry can be
> in private memory. So when the robust list is being scanned in this case, we can
> be in a use-after-free situation.

I believe this is true.  The userspace allocation for the pthread occurs as a
private mapping:
https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L368

>>> In the case that the oom victim is utilizing a robust futex, and the
>>> SIGKILL has not yet handled the futex death, the tsk->robust_list should
>>> be non-NULL. This issue can be tricky to reproduce, but with the
>>> modifications of this patch, we have found it to be impossible to
>>> reproduce.
>> We really need a deeper analysis of the udnerlying problem because right
>> now I do not really see why the oom reaper should interfere with shared
>> futex.
> As I said above, the robust list processing can involve private memory.
>>
>>> Add a check for tsk->robust_list is non-NULL in wake_oom_reaper() to return
>>> early and prevent waking the oom reaper.
>>>
>>> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>>>
>>> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
>>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>   mm/oom_kill.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>>> index 1ddabefcfb5a..3cdaac9c7de5 100644
>>> --- a/mm/oom_kill.c
>>> +++ b/mm/oom_kill.c
>>> @@ -667,6 +667,21 @@ static void wake_oom_reaper(struct task_struct *tsk)
>>>       if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
>>>           return;
>>>   +#ifdef CONFIG_FUTEX
>>> +    /*
>>> +     * If the ooming task's SIGKILL has not finished handling the
>>> +     * robust futex it is not correct to reap the mm concurrently.
>>> +     * Do not wake the oom reaper when the task still contains a
>>> +     * robust list.
>>> +     */
>>> +    if (tsk->robust_list)
>>> +        return;
>>> +#ifdef CONFIG_COMPAT
>>> +    if (tsk->compat_robust_list)
>>> +        return;
>>> +#endif
>>> +#endif
>> If this turns out to be really needed, which I do not really see at the
>> moment, then this is not the right way to handle this situation. The oom
>> victim could get stuck and the oom killer wouldn't be able to move
>> forward. If anything the victim would need to get MMF_OOM_SKIP set.

I will try this, but I don't immediately see any difference between this return
case and setting the bit, passing the oom_reaper_list, then skipping it based on
the flag. Do you mind explaining how this could lead to the oom killer getting
stuck?

Cheers,
-- Nico
> 
> There can be other way to do that, but letting the normal kill signal processing
> finishing its job and properly invoke futex_cleanup() is certainly one possible
> solution.
> 
> Cheers,
> Longman
> 


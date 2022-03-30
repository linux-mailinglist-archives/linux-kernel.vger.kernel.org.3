Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0374ECBBA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349963AbiC3SUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349937AbiC3SUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:20:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E313C1ADAD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648664299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zCZ9vcrfzQ0QsNxEFqQrWsqYuZtAKZnlZqLRcF5z/RU=;
        b=GQP6AiWGhFMgjwOt5guWpwaZ5+dnG5K5ABD6E43bUWzbLqfyaQ4oGbYspZEhLpuMZDU+ey
        q3Xne/VoDbwdqXlrj2o0Qm4kyOcOsz+AIBt8qHjv93rhADzxc3oxKqSeYs4l4TzpvGIMzm
        BU4mBizPbKQIEXDDCGAXmcPWUDi95yk=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-mK5YQ9OCP7OeLDnYBDpwpA-1; Wed, 30 Mar 2022 14:18:18 -0400
X-MC-Unique: mK5YQ9OCP7OeLDnYBDpwpA-1
Received: by mail-il1-f199.google.com with SMTP id y2-20020a056e020f4200b002c9de5a79a1so2391755ilj.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zCZ9vcrfzQ0QsNxEFqQrWsqYuZtAKZnlZqLRcF5z/RU=;
        b=mLfpESKt/83qUHJBAxGl4mnKkddM3iUN6M8izgHVZ/Y/PhZF7vFhQHs2YuOC/NIoTS
         ai0uY/dUOo9exxYkZfFocqHsDi1WzqWEg5Y5hqIh18KWpeOuoM+9WLWjM9lkIoRfvcy8
         5BSUxpkHGmp0t9QcpOUd5bbaaHD0WE9fbhQuR1d02Gaz7C0Tdc01RA7UPsY+dvqcC6R1
         Hwszc2DgzklpY/P8qwsl0tibP9IBLW4MOTpQhnqd8fYY+ELJHaJaZQlIobb6nQsRVAav
         EQBsMHyZv2s6jvP0JXh3Tw7I4Jsv6U03WFxu9sQcXi/ON+PXOuJg8bkmstiN7yMrWwvW
         z0mg==
X-Gm-Message-State: AOAM532k18m5XHwBLcUJpcdzhyMYeSESQdDmhPugjncoLF3T1bVm/Ipq
        tiHeAre7tKShGSQD1GArrvnywFaZLrcYndoRkUbXqiti8qDyfiqwl9SBaVbjBeiu3RgqHqzRPTX
        snMgmFlcj3AHwsf3loOZnU3mW
X-Received: by 2002:a05:6e02:1a21:b0:2c9:eb4f:dd71 with SMTP id g1-20020a056e021a2100b002c9eb4fdd71mr1692318ile.236.1648664297732;
        Wed, 30 Mar 2022 11:18:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIPal6VRNTof5+bFsSq/T1XLZu6W8vEkyCR2dF99LnaHYKnKfiXYNzQekiOFm64uLjbyPDTA==
X-Received: by 2002:a05:6e02:1a21:b0:2c9:eb4f:dd71 with SMTP id g1-20020a056e021a2100b002c9eb4fdd71mr1692294ile.236.1648664297480;
        Wed, 30 Mar 2022 11:18:17 -0700 (PDT)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id o15-20020a92d38f000000b002c9aea3cff9sm5844280ilo.2.2022.03.30.11.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 11:18:17 -0700 (PDT)
Message-ID: <bd61369c-ef50-2eb4-2cca-91422fbfa328@redhat.com>
Date:   Wed, 30 Mar 2022 12:18:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz> <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld> <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx> <Yjn7FXoXtgGT977T@dhcp22.suse.cz> <87zglha9rt.ffs@tglx>
 <YjrlqAMyJg3GKZVs@dhcp22.suse.cz> <YkQgWcZ7w0zL1a7n@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YkQgWcZ7w0zL1a7n@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/22 03:18, Michal Hocko wrote:
> Nico,
> 
> On Wed 23-03-22 10:17:29, Michal Hocko wrote:
>> Let me skip over futex part which I need to digest and only focus on the
>> oom side of the things for clarification.
>>
>> On Tue 22-03-22 23:43:18, Thomas Gleixner wrote:
> [...]
>>> You can easily validate that by doing:
>>>
>>> wake_oom_reaper(task)
>>>    task->reap_time = jiffies + HZ;
>>>    queue_task(task);
>>>    wakeup(reaper);
>>>
>>> and then:
>>>
>>> oom_reap_task(task)
>>>     now = READ_ONCE(jiffies);
>>>     if (time_before(now, task->reap_time)
>>>         schedule_timeout_idle(task->reap_time - now);
>>>
>>> before trying to actually reap the mm.
>>>
>>> That will prevent the enforced race in most cases and allow the exiting
>>> and/or killed processes to cleanup themself. Not pretty, but it should
>>> reduce the chance of the reaper to win the race with the exiting and/or
>>> killed process significantly.
>>>
>>> It's not going to work when the problem is combined with a heavy VM
>>> overload situation which keeps a guest (or one/some it's vCPUs) away
>>> from being scheduled. See below for a discussion of guarantees.
>>>
>>> If it failed to do so when the sleep returns, then you still can reap
>>> it.
>>
>> Yes, this is certainly an option. Please note that the oom_reaper is not
>> the only way to trigger this. process_mrelease syscall performs the same
>> operation from the userspace. Arguably process_mrelease could be used
>> sanely/correctly because the userspace oom killer can do pro-cleanup
>> steps before going to final SIGKILL & process_mrelease. One way would be
>> to send SIGTERM in the first step and allow the victim to perform its
>> cleanup.
> 
> are you working on another version of the fix/workaround based on the
> discussion so far?

We are indeed! Sorry for the delay we've been taking the time to do our due
diligence on some of the claims made. We are also spending time rewriting the
reproducer to include more test cases that Thomas brought up.

Ill summarize here, and reply to the original emails in more detail....

Firstly, we have implemented & tested the VMA skipping... it does fix our case.
Thomas brought up a few good points about the robust list head and the potential
waiters being in different VMAs; however, I think its a moot point, given that
the locks will only be reaped if allocated as ((private|anon)|| !shared).

If the locks are private|anon then there are not two processes sharing this lock
and OOMing will stop all the pthreads operating on this address space (no need
to wake the waiters).

If its a shared lock then the VMA will not be reaped and the dying process can
still recover the stuck waiter in the other process. We do however need to skip
the robust_list_head vma as that is in private|anon memory and can race between
the exit and the OOM as described in our previous commit logs.

We are trying to create a scenario in our reproducer that will break the VMA
skipping case, but have been unsuccessful so far.

> 
> I guess the most reasonable way forward is to rework
> oom_reaper processing to be delayed. This can be either done by a
> delayed wake up or as Thomas suggests above by postponing the
> processing. I think the delayed wakeup would be _slightly_ easier to
> handle because the queue can contain many tasks to be reaped.
> 
> More specifically something like delayed work but we cannot rely on
> the WQ here. I guess we do not have any delayed wait queue interface
> but the same trick with the timer should be applicable here as well.
> exit_mmap would then cancel the timer after __oom_reap_task_mm is done.
> Actually the timer could be canceled after mmu_notifier_release already
> but this shouldn't make much of a difference.

We have not tried implementing the delayed work yet, but we see value in that
solution IFF we are able to break the vma skipping case. In that case I believe
we combine the two approaches to further improve the robustness of the futex,
allowing for less 'best-effort' recoveries bailouts.

Cheers,
-- Nico


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72448EC14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242130AbiANO6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:58:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60776 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242086AbiANO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642172322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOzdRMknZ5PmyxcIgplcnkj1XzKRyAcCC7j04FkTM74=;
        b=BJN25dskzTPhOgHdI5r+HTLcjOy82DDwNkwfp+jwr4kuXIMIsWbvpbwz8fmxSl7O/mdvU8
        wLzbSsqvUci6uNELnrwgfYAeVkrh/QP2FG4tY+bUMRrsenlp3XDOKE10auUnzteTyEu3Dj
        rDslcMqaljNNoAIQYonZaloS6B40iwo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-lLo09EyNMbe6qgC0dC3laQ-1; Fri, 14 Jan 2022 09:58:39 -0500
X-MC-Unique: lLo09EyNMbe6qgC0dC3laQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4BD11083F66;
        Fri, 14 Jan 2022 14:58:36 +0000 (UTC)
Received: from [10.22.33.90] (unknown [10.22.33.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9029B753E1;
        Fri, 14 Jan 2022 14:58:35 +0000 (UTC)
Message-ID: <e3e07a1c-0446-7408-5ef1-1bae7a1b90c5@redhat.com>
Date:   Fri, 14 Jan 2022 09:58:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Joel Savitz <jsavitz@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
 <YbB0d6T8RbHW48sZ@dhcp22.suse.cz> <YbDX16LAkvzgYHpH@dhcp22.suse.cz>
 <CAL1p7m4ka1v-Zoi-RpDy5ME-bMikGPX5V_4Hod-Y0KHOq_G8zA@mail.gmail.com>
 <YbG1mu0CLONo+Z7l@dhcp22.suse.cz>
 <CAL1p7m7mWxLE-7Qf_QjmREJ2AvfSexPvybPyHvxTUugxsPPxjQ@mail.gmail.com>
 <eee96817-1814-5849-65b8-0038235f2617@redhat.com>
In-Reply-To: <eee96817-1814-5849-65b8-0038235f2617@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/14/22 09:55, Waiman Long wrote:
> On 1/14/22 09:39, Joel Savitz wrote:
>>> What has happened to the oom victim and why it has never exited?
>> What appears to happen is that the oom victim is sent SIGKILL by the
>> process that triggers the oom while also being marked as an oom
>> victim.
>>
>> As you mention in your patchset introducing the oom reaper in commit
>> aac4536355496 ("mm, oom: introduce oom reaper"), the purpose the the
>> oom reaper is to try and free more memory more quickly than it
>> otherwise would have been by assuming anonymous or swapped out pages
>> won't be needed in the exit path as the owner is already dying.
>> However, this assumption is violated by the futex_cleanup() path,
>> which needs access to userspace in fetch_robust_entry() when it is
>> called in exit_robust_list(). Trace_printk()s in this failure path
>> reveal an apparent race between the oom reaper thread reaping the
>> victim's mm and the futex_cleanup() path. There may be other ways that
>> this race manifests but we have been most consistently able to trace
>> that one.
>>
>> Since in the case of an oom victim using robust futexes the core
>> assumption of the oom reaper is violated, we propose to solve this
>> problem by either canceling or delaying the waking of the oom reaper
>> thread by wake_oom_reaper in the case that tsk->robust_list is
>> non-NULL.
>>
>> e.g. the bug does not reproduce with this patch (from 
>> npache@redhat.com):
>>
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 989f35a2bbb1..b8c518fdcf4d 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -665,6 +665,19 @@ static void wake_oom_reaper(struct task_struct 
>> *tsk)
>>          if (test_and_set_bit(MMF_OOM_REAP_QUEUED, 
>> &tsk->signal->oom_mm->flags))
>>                  return;
>>
>> +#ifdef CONFIG_FUTEX
>> +       /*
>> +        * don't wake the oom_reaper thread if we still have a robust
>> list to handle
>> +        * This will then rely on the sigkill to handle the cleanup 
>> of memory
>> +        */
>> +       if(tsk->robust_list)
>> +               return;
>> +#ifdef CONFIG_COMPAT
>> +       if(tsk->compat_robust_list)
>> +               return;
>> +#endif
>> +#endif
>> +
>>          get_task_struct(tsk);
>>
>>          spin_lock(&oom_reaper_lock);
>
> OK, that can explain why the robust futex is not properly cleaned up. 
> Could you post a more formal v2 patch with description about the 
> possible race condition?
>
It should be v3. Sorry for the mix-up.

Cheers,
Longman


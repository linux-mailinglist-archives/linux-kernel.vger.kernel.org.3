Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1944ECEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiC3ViU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiC3ViQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1BC34B43D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648676189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nq2QaWKmjRi7ediHTAyvB1XNhkWF7u/Z5LX0xWbEYz0=;
        b=bE1zB25nwmW1HYn+Wc3iau2sZH1t3oAPOPTIP57BiHnZaEgf51r+GpUcmkwNJaEoSHdk59
        XDDf9Ph2OIHBpP26Cuf0MQl83/jPMJ0sa/AqfGLZFSCEFVLsqwc01H8nNHfnS2uyehrTUq
        TfpUcPF6nBvawckKvyP0dowRrUIaiBA=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-zi63WYE6PUiAttXTR99WnA-1; Wed, 30 Mar 2022 17:36:28 -0400
X-MC-Unique: zi63WYE6PUiAttXTR99WnA-1
Received: by mail-io1-f70.google.com with SMTP id z23-20020a6b0a17000000b00649f13ea3a7so13453687ioi.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nq2QaWKmjRi7ediHTAyvB1XNhkWF7u/Z5LX0xWbEYz0=;
        b=wYYwkO1mooI0McUrwY12ErOfXsCisDiJPWnbRnN+ogXRn6f5T7ndbQ2PpjYuRSncAq
         bhgsaIoQPdGJy1x0nS1mYVkvz0C2NmMg8fWPRJ9xsd55BAPVRTnAiIzJLmwClrjrJuE0
         szio/wrc4GcA9iJeRMs/4y3I/ImsVT4bY2HQeG+OYPfzdDSAHw78v7AtfFp2udD8biPj
         U1r9N1gusU9UAhjBJPwpkKvj37MBmdtrHkoVMPLPBeZ+VgNcYU3fn2n3BTfTOohetdgF
         KVlBOQs79kV7bgLn+S/GA+e9koIkee7/vxziHkOUquZdt8mf8nxU5hw7Jrnqp8rM30bd
         HMBA==
X-Gm-Message-State: AOAM530+KwMYk0eVssYbF4wk2z3mN+6f3nDJxL+ert9k00Z2xFEQPxBx
        ta3Nkp5cUY8aylhtmd7yn3wUIsA+ZDUH89fu2h6PYqYtGo5BrWNFIJm2TWAFaD+1FuJBArduCC9
        MZTmMFH0svAA19hNxRw6rd18Y
X-Received: by 2002:a05:6638:d0c:b0:31a:5d8a:c013 with SMTP id q12-20020a0566380d0c00b0031a5d8ac013mr1095305jaj.132.1648676187677;
        Wed, 30 Mar 2022 14:36:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYtx5RIUIAL5R23SCsLiL/45ug3XfeCC3Y2ZFaEe+SFSXjnE7oqU9hxSRpEVlxEqP4tjYw4w==
X-Received: by 2002:a05:6638:d0c:b0:31a:5d8a:c013 with SMTP id q12-20020a0566380d0c00b0031a5d8ac013mr1095294jaj.132.1648676187476;
        Wed, 30 Mar 2022 14:36:27 -0700 (PDT)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id ay18-20020a5d9d92000000b0064c77f6aaecsm6121018iob.3.2022.03.30.14.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 14:36:27 -0700 (PDT)
Message-ID: <0991b55e-3d69-a591-9bf4-26013b6ba843@redhat.com>
Date:   Wed, 30 Mar 2022 15:36:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
From:   Nico Pache <npache@redhat.com>
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
 <bd61369c-ef50-2eb4-2cca-91422fbfa328@redhat.com>
In-Reply-To: <bd61369c-ef50-2eb4-2cca-91422fbfa328@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/22 12:18, Nico Pache wrote:
> 
> 
> On 3/30/22 03:18, Michal Hocko wrote:
>> Nico,
>>
>> On Wed 23-03-22 10:17:29, Michal Hocko wrote:
>>> Let me skip over futex part which I need to digest and only focus on the
>>> oom side of the things for clarification.
>>>
>>> On Tue 22-03-22 23:43:18, Thomas Gleixner wrote:
>> [...]
>>>> You can easily validate that by doing:
>>>>
>>>> wake_oom_reaper(task)
>>>>    task->reap_time = jiffies + HZ;
>>>>    queue_task(task);
>>>>    wakeup(reaper);
>>>>
>>>> and then:
>>>>
>>>> oom_reap_task(task)
>>>>     now = READ_ONCE(jiffies);
>>>>     if (time_before(now, task->reap_time)
>>>>         schedule_timeout_idle(task->reap_time - now);
>>>>
>>>> before trying to actually reap the mm.
>>>>
>>>> That will prevent the enforced race in most cases and allow the exiting
>>>> and/or killed processes to cleanup themself. Not pretty, but it should
>>>> reduce the chance of the reaper to win the race with the exiting and/or
>>>> killed process significantly.
>>>>
>>>> It's not going to work when the problem is combined with a heavy VM
>>>> overload situation which keeps a guest (or one/some it's vCPUs) away
>>>> from being scheduled. See below for a discussion of guarantees.
>>>>
>>>> If it failed to do so when the sleep returns, then you still can reap
>>>> it.
>>>
>>> Yes, this is certainly an option. Please note that the oom_reaper is not
>>> the only way to trigger this. process_mrelease syscall performs the same
>>> operation from the userspace. Arguably process_mrelease could be used
>>> sanely/correctly because the userspace oom killer can do pro-cleanup
>>> steps before going to final SIGKILL & process_mrelease. One way would be
>>> to send SIGTERM in the first step and allow the victim to perform its
>>> cleanup.
>>
>> are you working on another version of the fix/workaround based on the
>> discussion so far?
> 
> We are indeed! Sorry for the delay we've been taking the time to do our due
> diligence on some of the claims made. We are also spending time rewriting the
> reproducer to include more test cases that Thomas brought up.
> 
> Ill summarize here, and reply to the original emails in more detail....
> 
> Firstly, we have implemented & tested the VMA skipping... it does fix our case.
> Thomas brought up a few good points about the robust list head and the potential
> waiters being in different VMAs; however, I think its a moot point, given that
> the locks will only be reaped if allocated as ((private|anon)|| !shared).

Sorry... not completely moot.

As Thomas pointed out, a robust list with the following structure will probably
fail to recover its waiters:

TLS (robust head, skip)* --> private lock (reaped) --> shared lock (not reaped)

We are working on getting a test case with multiple locks and mixed mapping
types to prove this.

Skipping the robust list head VMA will be beneficial in cases were the robust
list is full of shared locks:

TLS (robust head, skip)* --> shared lock(not reaped) --> shared lock(not reaped)

-- Nico


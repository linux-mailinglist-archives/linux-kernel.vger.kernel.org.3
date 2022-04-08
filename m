Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A284F9108
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiDHInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiDHIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:43:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2CE589CC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649407291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hfm3ta5VF34jEcNTC76QZOHm3mie3+2AwQoQ84bW2eg=;
        b=HHXMPnKCSvldf1yi1T2MuLN/5kkXpvjYxI2TMrOVw/AAaqdJ76LVRbGkR/LO46wbKhHihS
        OXAlvRddOniUZu7t6Yxt8N1a06ln1cTEtBEHTDRNrGTrbkEOWTWqNsqnZOxBZa4pCVp82X
        048QavF6oxN953AADhYTDfRep849EvM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-0yhlYKHQORucY4P2Oel2LQ-1; Fri, 08 Apr 2022 04:41:30 -0400
X-MC-Unique: 0yhlYKHQORucY4P2Oel2LQ-1
Received: by mail-qv1-f71.google.com with SMTP id p3-20020a05621421e300b0044427d0ab90so556840qvj.17
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hfm3ta5VF34jEcNTC76QZOHm3mie3+2AwQoQ84bW2eg=;
        b=e6ghWTnEXyBg5FdiAuTc2UYj2nGXrYqGhwjMzRWibhcuCWOxbPf2in+oYHdY1MhA9Y
         OE034VwdujkMHqAJRcxn7a+LPMiuYH4tSSnq9q70HNKfNTbVt9UbjIkrTgKCoBea0ilQ
         SaPAf/RnKpVnATBgz945P7j9162AJU5N/0i0SyvmZt/YCxbcP4u3f9R0Jxme8YGUjLQv
         Qji1EyRTDHY8NAzzEdLuvr97/jhdMunquEhVKczmd7j/ozWNll14entGfHnU6m4cfBJF
         X9JO1hLyXSyNSb8Kb3cTuMyKfyHbb2RsPdmMNTGtnMJWxbvh7V6nFapwFxTyUBVBlvJX
         x4BQ==
X-Gm-Message-State: AOAM532lEacoJkc6yAmQKDI+0H/3qD4jOZR6RtVv7DiX9Xnny7t2wmc5
        R5GmNiZolArH6ioBUp3v4ZuyqOyY8Ecrh0yp4qoR1ShoIAfYV6uGiw+YrdVKKpI7t4japmx84sy
        K5CC/sSA5y3Glit3kxppveISj
X-Received: by 2002:ad4:5ba2:0:b0:441:402c:2534 with SMTP id 2-20020ad45ba2000000b00441402c2534mr14981910qvq.75.1649407289635;
        Fri, 08 Apr 2022 01:41:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3NYk1umtpKK/Yl6GxoWxDcDTzzxyZCQ9JzpN5/chhlU6uzvzsQ5/3if7JRUo2FsPUePWm5w==
X-Received: by 2002:ad4:5ba2:0:b0:441:402c:2534 with SMTP id 2-20020ad45ba2000000b00441402c2534mr14981891qvq.75.1649407289457;
        Fri, 08 Apr 2022 01:41:29 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm19538890qta.52.2022.04.08.01.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:41:29 -0700 (PDT)
Message-ID: <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com>
Date:   Fri, 8 Apr 2022 04:41:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220408081549.GM2731@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 04:15, Peter Zijlstra wrote:
> On Thu, Apr 07, 2022 at 11:28:09PM -0400, Nico Pache wrote:
>> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
>> be targeted by the oom reaper. This mapping is used to store the futex
>> robust list head; the kernel does not keep a copy of the robust list and
>> instead references a userspace address to maintain the robustness during
>> a process death. A race can occur between exit_mm and the oom reaper that
>> allows the oom reaper to free the memory of the futex robust list before
>> the exit path has handled the futex death:
>>
>>     CPU1                               CPU2
>> ------------------------------------------------------------------------
>>     page_fault
>>     do_exit "signal"
>>     wake_oom_reaper
>>                                         oom_reaper
>>                                         oom_reap_task_mm (invalidates mm)
>>     exit_mm
>>     exit_mm_release
>>     futex_exit_release
>>     futex_cleanup
>>     exit_robust_list
>>     get_user (EFAULT- can't access memory)
>>
>> If the get_user EFAULT's, the kernel will be unable to recover the
>> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
>>
>> Use the robust_list address stored in the kernel to skip the VMA that holds
>> it, allowing a successful futex_cleanup.
>>
>> Theoretically a failure can still occur if there are locks mapped as
>> PRIVATE|ANON; however, the robust futexes are a best-effort approach.
>> This patch only strengthens that best-effort.
>>
>> The following case can still fail:
>> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
> 
> This is still all sorts of confused.. it's a list head, the entries can
> be in any random other VMA. You must not remove *any* user memory before
> doing the robust thing. Not removing the VMA that contains the head is
> pointless in the extreme.
Not sure how its pointless if it fixes all the different reproducers we've
written for it. As for the private lock case we stated here, we havent been able
to reproduce it, but I could see how it can be a potential issue (which is why
its noted).
> 
> Did you not read the previous discussion?

I did... Thats why I added the blurb about best-effort and the case that can
theoretically still fail.

The oom reaper doesn't reap shared memory but WITHOUT this change it was reaping
the head (PRIVATE|ANON) which is needed to get to those shared mappings; so
shared locks are safe with this added change.

If a user implements private locks they can only be used within that process. If
that process is OOMing then it doesnt really matter what happens to the
futexes... all of those threads running under that process will terminate anyways.

Perhaps I'm misunderstanding you.

-- Nico


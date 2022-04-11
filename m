Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A84FC8FC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236676AbiDKXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbiDKXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE5F627155
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649721114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2Yny/wdQGOLfSDXssmL5nGEynmk+Ee36fj4fjWkXdI=;
        b=iiTxtzimJmPDjddPw/aESV9y2w02D14XUWycgih4Vs6TujoOCfo/s5s29ozn+1E5DnfJCM
        PDvfv79jCwOGnVUcMx3PRJ6QtxeLTPil0Y213FMO05PbWk981DxXFiqbPXeEjg1hzaeWA1
        1uUzMo//LhkUopqDM0cn79AredZi2TQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-M5Ffmg0lNSe2gViVhLa3lg-1; Mon, 11 Apr 2022 19:51:53 -0400
X-MC-Unique: M5Ffmg0lNSe2gViVhLa3lg-1
Received: by mail-qv1-f71.google.com with SMTP id fw9-20020a056214238900b0043522aa5b81so16929893qvb.21
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 16:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C2Yny/wdQGOLfSDXssmL5nGEynmk+Ee36fj4fjWkXdI=;
        b=E9WyjTedtlshVBKnwtFA2bcj0dFstiRWA66rgR1IgiTE4tSbKD98twC9BLSh8gmOgK
         wxGjTGjMYZ1HeJ/45r9yb0RuMjFRcNCMI3v5F1IRD7Y0fC3xc+3HJdBYquygOr83UOti
         1BA1uaVypqIQlbI2kyWt/f7cB9CQ3Q27u5D/qbvy43UQpRTEVdvnzcg90bf87roTZzoQ
         18erm2F0me4nASNwxfTCVlJ3TTkyHCaCeupuaZCEqSho0yojMJ4etWIzAKzwFGF5kqIK
         L17J/O7mgUeDO2rleDOWQYlK9BjVR+X9Z5Fw57bcCeRQzu41+qvsELQzr7xL5KyHXRgn
         jH6Q==
X-Gm-Message-State: AOAM5301jsd65Z8MM0R/U2Z4pJg99Vt5GfGOfP8FHL+W7rpEb6zq+k3N
        XmD0lQJUOzjEg0oRSzKSdiDI9tPaxtM/kXP8uVk7Tf/64+bvFKnI4IARuRC8kxf1wE9z0JhIhJQ
        rwC7X8kYkV6VtmzdW640QL3sl
X-Received: by 2002:a05:6214:d87:b0:443:6f15:fe33 with SMTP id e7-20020a0562140d8700b004436f15fe33mr1575454qve.50.1649721112595;
        Mon, 11 Apr 2022 16:51:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrQG8u7aJ35wAwhhAtjuu9u/vtd70iPUCdYOEsCb2dpEct5qorprasylOONObrCtnpj/xA5w==
X-Received: by 2002:a05:6214:d87:b0:443:6f15:fe33 with SMTP id e7-20020a0562140d8700b004436f15fe33mr1575435qve.50.1649721112407;
        Mon, 11 Apr 2022 16:51:52 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id f15-20020a379c0f000000b0069bf3430cc4sm6119872qke.100.2022.04.11.16.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 16:51:51 -0700 (PDT)
Message-ID: <1a7944c7-d717-d5af-f71d-92326f7bb7f6@redhat.com>
Date:   Mon, 11 Apr 2022 19:51:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
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
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com> <87k0bzk7e5.ffs@tglx>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <87k0bzk7e5.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 09:54, Thomas Gleixner wrote:
> On Fri, Apr 08 2022 at 04:41, Nico Pache wrote:
>> On 4/8/22 04:15, Peter Zijlstra wrote:
>>>>
>>>> The following case can still fail:
>>>> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
>>>
>>> This is still all sorts of confused.. it's a list head, the entries can
>>> be in any random other VMA. You must not remove *any* user memory before
>>> doing the robust thing. Not removing the VMA that contains the head is
>>> pointless in the extreme.
>> Not sure how its pointless if it fixes all the different reproducers we've
>> written for it. As for the private lock case we stated here, we havent been able
>> to reproduce it, but I could see how it can be a potential issue (which is why
>> its noted).
> 
> The below reproduces the problem nicely, i.e. the lock() in the parent
> times out. So why would the OOM killer fail to cause the same problem
> when it reaps the private anon mapping where the private futex sits?
> 
> If you revert the lock order in the child the robust muck works.

Thanks for the reproducer Thomas :)

I think I need to re-up my knowledge around COW and how it effects that stack.
There are increased oddities when you add the pthread library that I cant fully
wrap my head around at the moment.

My confusion lies in how the parent/child share a robust list here, but they
obviously do. In my mind the mut_s would be different in the child/parent after
the fork and pthread_mutex_init (and friends) are done in the child.

Thanks!
-- Nico
> 
> Thanks,
> 
>         tglx
> ---
> #include <errno.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <time.h>
> #include <stdio.h>
> #include <string.h>
> #include <unistd.h>
> 
> #include <sys/types.h>
> #include <sys/mman.h>
> 
> static char n[4096];
> 
> int main(void)
> {
> 	pthread_mutexattr_t mat_s, mat_p;
> 	pthread_mutex_t *mut_s, *mut_p;
> 	pthread_barrierattr_t ba;
> 	pthread_barrier_t *b;
> 	struct timespec to;
> 	void *pri, *shr;
> 	int r;
> 
> 	shr = mmap(NULL, sizeof(n), PROT_READ | PROT_WRITE,
> 		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 
> 	pthread_mutexattr_init(&mat_s);
> 	pthread_mutexattr_setrobust(&mat_s, PTHREAD_MUTEX_ROBUST);
> 	mut_s = shr;
> 	pthread_mutex_init(mut_s, &mat_s);
> 
> 	pthread_barrierattr_init(&ba);
> 	pthread_barrierattr_setpshared(&ba, PTHREAD_PROCESS_SHARED);
> 	b = shr + 1024;
> 	pthread_barrier_init(b, &ba, 2);
> 
> 	if (!fork()) {
> 		pri = mmap(NULL, 1<<20, PROT_READ | PROT_WRITE,
> 			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 		pthread_mutexattr_init(&mat_p);
> 		pthread_mutexattr_setpshared(&mat_p, PTHREAD_PROCESS_PRIVATE);
> 		pthread_mutexattr_setrobust(&mat_p, PTHREAD_MUTEX_ROBUST);
> 		mut_p = pri;
> 		pthread_mutex_init(mut_p, &mat_p);
> 
> 		// With lock order s, p parent gets timeout
> 		// With lock order p, s parent gets owner died
> 		pthread_mutex_lock(mut_s);
> 		pthread_mutex_lock(mut_p);
> 		// Remove unmap and lock order does not matter
> 		munmap(pri, sizeof(n));
> 		pthread_barrier_wait(b);
> 		printf("child gone\n");
> 	} else {
> 		pthread_barrier_wait(b);
> 		printf("parent lock\n");
> 		clock_gettime(CLOCK_REALTIME, &to);
> 		to.tv_sec += 1;
> 		r = pthread_mutex_timedlock(mut_s, &to);
> 		printf("parent lock returned: %s\n", strerror(r));
> 	}
> 	return 0;
> }
> 


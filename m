Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF24F9761
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 15:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbiDHN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236306AbiDHN4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 09:56:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9496110241B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 06:54:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649426066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+kiGYFsPtc+olLWpLKsQjt4OwVjq7Vizjez6bSpAk8=;
        b=RBLOT5OG4p7NYsM9dNROuyxfEHNEE3mn3WNgdPdVgyv6vjE/xrGOZw4UWwwWTSQYZDiZXM
        5M0wcFjsv1X+ipAcFQxxnkA1GdUnVoQq5rKccY96Y1ByTBVX7JOJgxONJWPYJFfO4Ym8DZ
        0le6gjGxjCJ7OgWe5gxk965V/A45DVkraEmrCno4vrz6Sq5UeD0TvYqYpMCPpwqPd3aP6C
        07LJCaNXcFvd18eJGwPmfCmOO6QV1CjIqaAh3wMhfRJ6/55YXB57wPQ6V4POIQhWWQ2ddw
        KF3xKQGQt9KHq+oq6vTPwGY3qwYuZ9PBM1BYoXeMiMEFylmzXBLsGqbBEI1vHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649426066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+kiGYFsPtc+olLWpLKsQjt4OwVjq7Vizjez6bSpAk8=;
        b=nA1/WsFN4QQzqLseatdRzX59vbePCAD7ulKVEJauimUNMR7WEhQfkSpDQw4AHcipeY+QIj
        Rdc2mUeAwF0iJkBQ==
To:     Nico Pache <npache@redhat.com>,
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
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
In-Reply-To: <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com>
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <ee07a31c-c514-4a88-599f-14a30e93f32e@redhat.com>
Date:   Fri, 08 Apr 2022 15:54:26 +0200
Message-ID: <87k0bzk7e5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08 2022 at 04:41, Nico Pache wrote:
> On 4/8/22 04:15, Peter Zijlstra wrote:
>>>
>>> The following case can still fail:
>>> robust head (skipped) -> private lock (reaped) -> shared lock (skipped)
>> 
>> This is still all sorts of confused.. it's a list head, the entries can
>> be in any random other VMA. You must not remove *any* user memory before
>> doing the robust thing. Not removing the VMA that contains the head is
>> pointless in the extreme.
> Not sure how its pointless if it fixes all the different reproducers we've
> written for it. As for the private lock case we stated here, we havent been able
> to reproduce it, but I could see how it can be a potential issue (which is why
> its noted).

The below reproduces the problem nicely, i.e. the lock() in the parent
times out. So why would the OOM killer fail to cause the same problem
when it reaps the private anon mapping where the private futex sits?

If you revert the lock order in the child the robust muck works.

Thanks,

        tglx
---
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/mman.h>

static char n[4096];

int main(void)
{
	pthread_mutexattr_t mat_s, mat_p;
	pthread_mutex_t *mut_s, *mut_p;
	pthread_barrierattr_t ba;
	pthread_barrier_t *b;
	struct timespec to;
	void *pri, *shr;
	int r;

	shr = mmap(NULL, sizeof(n), PROT_READ | PROT_WRITE,
		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);

	pthread_mutexattr_init(&mat_s);
	pthread_mutexattr_setrobust(&mat_s, PTHREAD_MUTEX_ROBUST);
	mut_s = shr;
	pthread_mutex_init(mut_s, &mat_s);

	pthread_barrierattr_init(&ba);
	pthread_barrierattr_setpshared(&ba, PTHREAD_PROCESS_SHARED);
	b = shr + 1024;
	pthread_barrier_init(b, &ba, 2);

	if (!fork()) {
		pri = mmap(NULL, 1<<20, PROT_READ | PROT_WRITE,
			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
		pthread_mutexattr_init(&mat_p);
		pthread_mutexattr_setpshared(&mat_p, PTHREAD_PROCESS_PRIVATE);
		pthread_mutexattr_setrobust(&mat_p, PTHREAD_MUTEX_ROBUST);
		mut_p = pri;
		pthread_mutex_init(mut_p, &mat_p);

		// With lock order s, p parent gets timeout
		// With lock order p, s parent gets owner died
		pthread_mutex_lock(mut_s);
		pthread_mutex_lock(mut_p);
		// Remove unmap and lock order does not matter
		munmap(pri, sizeof(n));
		pthread_barrier_wait(b);
		printf("child gone\n");
	} else {
		pthread_barrier_wait(b);
		printf("parent lock\n");
		clock_gettime(CLOCK_REALTIME, &to);
		to.tv_sec += 1;
		r = pthread_mutex_timedlock(mut_s, &to);
		printf("parent lock returned: %s\n", strerror(r));
	}
	return 0;
}

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4A04982C3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238558AbiAXO60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:58:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbiAXO6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:58:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAFC86D;
        Mon, 24 Jan 2022 06:58:21 -0800 (PST)
Received: from [10.57.39.131] (unknown [10.57.39.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DDD73F7D8;
        Mon, 24 Jan 2022 06:58:20 -0800 (PST)
Subject: Re: [RFC PATCH 1/1] perf/core: Wake up parent event if inherited
 event has no ring buffer
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        leo.yan@linaro.com, Suzuki.Poulose@arm.com,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211206113840.130802-1-james.clark@arm.com>
 <20211206113840.130802-2-james.clark@arm.com>
 <Ye6SR0yxTrkNUQF6@hirez.programming.kicks-ass.net>
From:   James Clark <james.clark@arm.com>
Message-ID: <a4b64cff-f3f1-e6ad-38e9-b65a113ce561@arm.com>
Date:   Mon, 24 Jan 2022 14:58:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye6SR0yxTrkNUQF6@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2022 11:49, Peter Zijlstra wrote:
> On Mon, Dec 06, 2021 at 11:38:40AM +0000, James Clark wrote:
>> When using per-process mode and event inheritance is set to true, forked
>> processes will create a new perf events via inherit_event() ->
>> perf_event_alloc(). But these events will not have ring buffers assigned
>> to them. Any call to wakeup will be dropped if it's called on an event
>> with no ring buffer assigned because that's the object that holds the
>> wakeup list.
>>
>> If the child event is disabled due to a call to perf_aux_output_begin()
>> or perf_aux_output_end(), the wakeup is dropped leaving userspace
>> hanging forever on the poll.
>>
>> Normally the event is explicitly re-enabled by userspace after it wakes
>> up to read the aux data, but in this case it does not get woken up so
>> the event remains disabled.
>>
>> This can be reproduced when using Arm SPE and 'stress' which forks once
>> before running the workload. By looking at the list of aux buffers read,
>> it's apparent that they stop after the fork:
>>
>>   perf record -e arm_spe// -vvv -- stress -c 1
>>
>> With this patch applied they continue to be printed. This behaviour
>> doesn't happen when using systemwide or per-cpu mode.
>>
>> Reported-by: Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
> 
> Would this be the better patch?

Yes I tested this and it also works. There is one other suspicious access
of ->rb followed by if(rb) here in perf_poll(), but maybe it works out ok?

	mutex_lock(&event->mmap_mutex);
	rb = event->rb;
	if (rb)
		events = atomic_xchg(&rb->poll, 0);

We also have a Perf self test that covers this failure for Arm SPE now, I'm not
sure if I should post that separately or with your new version of this fix?

Thanks
James
 
> 
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 479c9e672ec4..b1c1928c0e7c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5985,6 +5985,8 @@ static void ring_buffer_attach(struct perf_event *event,
>  	struct perf_buffer *old_rb = NULL;
>  	unsigned long flags;
>  
> +	WARN_ON_ONCE(event->parent);
> +
>  	if (event->rb) {
>  		/*
>  		 * Should be impossible, we set this when removing
> @@ -6042,6 +6044,9 @@ static void ring_buffer_wakeup(struct perf_event *event)
>  {
>  	struct perf_buffer *rb;
>  
> +	if (event->parent)
> +		event = event->parent;
> +
>  	rcu_read_lock();
>  	rb = rcu_dereference(event->rb);
>  	if (rb) {
> @@ -6055,6 +6060,9 @@ struct perf_buffer *ring_buffer_get(struct perf_event *event)
>  {
>  	struct perf_buffer *rb;
>  
> +	if (event->parent)
> +		event = event->parent;
> +
>  	rcu_read_lock();
>  	rb = rcu_dereference(event->rb);
>  	if (rb) {
> @@ -6763,7 +6771,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
>  	if (WARN_ON_ONCE(READ_ONCE(sampler->oncpu) != smp_processor_id()))
>  		goto out;
>  
> -	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	rb = ring_buffer_get(sampler);
>  	if (!rb)
>  		goto out;
>  
> @@ -6829,7 +6837,7 @@ static void perf_aux_sample_output(struct perf_event *event,
>  	if (WARN_ON_ONCE(!sampler || !data->aux_size))
>  		return;
>  
> -	rb = ring_buffer_get(sampler->parent ? sampler->parent : sampler);
> +	rb = ring_buffer_get(sampler);
>  	if (!rb)
>  		return;
>  
> 

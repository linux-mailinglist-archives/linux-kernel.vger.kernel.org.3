Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDE49CF53
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 17:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiAZQPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 11:15:34 -0500
Received: from foss.arm.com ([217.140.110.172]:50522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239849AbiAZQPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:15:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58051D6E;
        Wed, 26 Jan 2022 08:15:33 -0800 (PST)
Received: from [10.32.33.50] (e121896.warwick.arm.com [10.32.33.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD2923F766;
        Wed, 26 Jan 2022 08:15:31 -0800 (PST)
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
 <a4b64cff-f3f1-e6ad-38e9-b65a113ce561@arm.com>
 <YfBLusfOk9fpIqqI@hirez.programming.kicks-ass.net>
From:   James Clark <james.clark@arm.com>
Message-ID: <b0de5ea6-4100-15ed-bbf8-8578a0fa5b6d@arm.com>
Date:   Wed, 26 Jan 2022 16:15:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YfBLusfOk9fpIqqI@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2022 19:12, Peter Zijlstra wrote:
> On Mon, Jan 24, 2022 at 02:58:18PM +0000, James Clark wrote:
> 
>>> Would this be the better patch?
>>
>> Yes I tested this and it also works.
> 
> Excellent!
> 
>> There is one other suspicious access
>> of ->rb followed by if(rb) here in perf_poll(), but maybe it works out ok?
>>
>> 	mutex_lock(&event->mmap_mutex);
>> 	rb = event->rb;
>> 	if (rb)
>> 		events = atomic_xchg(&rb->poll, 0);
>>
> 
> That case must be good since it is the event from a file. Those cannot
> be clones.
> 
>> We also have a Perf self test that covers this failure for Arm SPE now, I'm not
>> sure if I should post that separately or with your new version of this fix?
> 
> They'd be routed through separate trees anyway, Arnaldo takes the
> userspace stuff.
> 

Ok we will post that one separately then. What are the next steps for this one?
Will you just put your version directly in your tree, or should I resubmit it with a
new commit message?



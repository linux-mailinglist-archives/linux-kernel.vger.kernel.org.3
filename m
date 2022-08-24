Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB21059F62C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiHXJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiHXJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:28:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C445844CA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KBYiawPQJHdGe6LFvPogUSBpjNrro9gHAo8iO0fvAeA=; b=trK84ipg/aGnHjob1Y4911tc4Y
        DKSgHTZWgOy4oq1M+BYiUh7xhlQFRkna9DbxAm59u7YnaZNdpiFT539Rz+bTia4znDi83nCaVEp3W
        tR27nawd+7rsDKe8V3QzhoUgbYwZG0d6/JsknBnD/IUIUhbOOva47eCOmdyVPPV0iVBmbeBNJGlIc
        idtm6Otu7yXQEE0lwq4ISHGk3tFiXNK2XlYRSUh3MCF7uswDh+8RjNWlXeAmoTWBLUhyfMXNHbhEu
        I8uwXy3YcanLBP4Q6u+oneTrcIdG0zHA6ejJpHb9mE0r+jA/+neoOTU7fGzr/8h3eNCJ7H1gt9KUL
        d7XujCYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQmfz-00GBsu-EV; Wed, 24 Aug 2022 09:27:55 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C22F980BE2; Wed, 24 Aug 2022 11:27:53 +0200 (CEST)
Date:   Wed, 24 Aug 2022 11:27:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com
Subject: Re: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
Message-ID: <YwXvGe4/QdgGYOKJ@worktop.programming.kicks-ass.net>
References: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
 <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Should be 3 patches at the very least I think, the first one introducing
the new field and then follow up patches making use of it.

And yes as Ravi mentions there's the CALLCHAIN_EARLY hack that could be
cleaned up as well, making it 4 or something.

On Fri, Aug 05, 2022 at 09:36:37AM -0400, Liang, Kan wrote:

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 34be3bc5151a..a2c26eaeb0d9 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1687,8 +1687,10 @@ static void setup_pebs_fixed_sample_data(struct
> perf_event *event,
>  	 * We can only do this for the default trace clock.
>  	 */
>  	if (x86_pmu.intel_cap.pebs_format >= 3 &&
> -		event->attr.use_clockid == 0)
> +		event->attr.use_clockid == 0) {

Indent fail; please add: 'set cino=(0:0' to your .vimrc or figure out
the equivalent for your editor of choice.

>  		data->time = native_sched_clock_from_tsc(pebs->tsc);
> +		data->flags |= PERF_SAMPLE_DATA_TIME;
> +	}
> 
>  	if (has_branch_stack(event))
>  		data->br_stack = &cpuc->lbr_stack;

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index da759560eec5..33054bf31fc1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -999,6 +999,7 @@ int perf_event_read_local(struct perf_event *event,
> u64 *value,
>  extern u64 perf_event_read_value(struct perf_event *event,
>  				 u64 *enabled, u64 *running);
> 
> +#define PERF_SAMPLE_DATA_TIME		0x1
> 
>  struct perf_sample_data {
>  	/*
> @@ -1012,6 +1013,7 @@ struct perf_sample_data {
>  	union perf_sample_weight	weight;
>  	u64				txn;
>  	union  perf_mem_data_src	data_src;
> +	u64				flags;
> 
>  	/*
>  	 * The other fields, optionally {set,used} by

How about we call that 'sample_flags' instead and use PERF_SAMPLE_* as
we already have, something like so:


diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ee8b9ecdc03b..b0ebbb1377b9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1007,6 +1007,7 @@ struct perf_sample_data {
 	 * Fields set by perf_sample_data_init(), group so as to
 	 * minimize the cachelines touched.
 	 */
+	u64				sample_flags;
 	u64				addr;
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
@@ -1056,6 +1057,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 					 u64 addr, u64 period)
 {
 	/* remaining struct members initialized in perf_prepare_sample() */
+	data->sample_flags = 0;
 	data->addr = addr;
 	data->raw  = NULL;
 	data->br_stack = NULL;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..fed447f59024 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6792,15 +6792,21 @@ static void perf_aux_sample_output(struct perf_event *event,
 	ring_buffer_put(rb);
 }
 
-static void __perf_event_header__init_id(struct perf_event_header *header,
-					 struct perf_sample_data *data,
-					 struct perf_event *event)
+static u64 __perf_event_header__init_id(struct perf_event_header *header,
+					struct perf_sample_data *data,
+					struct perf_event *event)
 {
 	u64 sample_type = event->attr.sample_type;
 
 	data->type = sample_type;
 	header->size += event->id_header_size;
 
+	/*
+	 * Clear the sample flags that have already been done by the
+	 * PMU driver.
+	 */
+	sample_type &= ~data->sample_flags;
+
 	if (sample_type & PERF_SAMPLE_TID) {
 		/* namespace issues */
 		data->tid_entry.pid = perf_event_pid(event, current);
@@ -6820,6 +6826,8 @@ static void __perf_event_header__init_id(struct perf_event_header *header,
 		data->cpu_entry.cpu	 = raw_smp_processor_id();
 		data->cpu_entry.reserved = 0;
 	}
+
+	return sample_type;
 }
 
 void perf_event_header__init_id(struct perf_event_header *header,
@@ -7302,7 +7310,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
-	u64 sample_type = event->attr.sample_type;
+	u64 sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
@@ -7310,7 +7318,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	header->misc = 0;
 	header->misc |= perf_misc_flags(regs);
 
-	__perf_event_header__init_id(header, data, event);
+	sample_type = __perf_event_header__init_id(header, data, event);
 
 	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E445A01EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiHXTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbiHXTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:14:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FE3F3B
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661368489; x=1692904489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CdDLsx3L2B+383p/P4KVLh85vm/whKPX7vZOpfEZbYg=;
  b=LIZjcS1LDpA41FAvCMNcrcp31O59ZWP+HanmNMaUshHdy5fRKuV9AUFk
   XKK1+9TSF1N8UakLJ4kOMQW1sCGiNLl8OBlT8Oxpn67IxMzigRnhWNNbI
   iHwLwbnMBoWqSZsUhlqDxYtkpz3POqIoTB7ZBfB3vB4sLmZLktjUW9lZx
   t0+2W6TUwye/l9wXoVqEcCVQw4Ovki12dh8BBtOWDwNtOTwRAg+OcrUCn
   8tcSO4VkvfmddxNkxxWtYDYnBcf/PwxcKhVzaw3P7tOVf4s18F2HRDbUk
   fBIyVsOd5fjTqhIdfV6WhwxWEZJrSwTvfxDaWyMagogjx1mjD5OeIfqBh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="281027507"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="281027507"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 12:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="678165732"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 12:14:47 -0700
Received: from [10.252.212.116] (kliang2-mobl1.ccr.corp.intel.com [10.252.212.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 75273580B54;
        Wed, 24 Aug 2022 12:14:46 -0700 (PDT)
Message-ID: <3afbcd46-0b29-605d-66d0-7f8b6b22332a@linux.intel.com>
Date:   Wed, 24 Aug 2022 15:14:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [BUG] perf/x86/intel/pebs: PEBS timestamps overwritten
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com
References: <CABPqkBTqQaaYH+ySu3reLm5i+X6P4BsqKycp8NBOP1gW3ZV4QA@mail.gmail.com>
 <4fdaeb87-7f0a-78e0-2952-3035a3776198@linux.intel.com>
 <YwXvGe4/QdgGYOKJ@worktop.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YwXvGe4/QdgGYOKJ@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-24 5:27 a.m., Peter Zijlstra wrote:
> 
> Should be 3 patches at the very least I think, the first one introducing
> the new field and then follow up patches making use of it.
> 
> And yes as Ravi mentions there's the CALLCHAIN_EARLY hack that could be
> cleaned up as well, making it 4 or something.
> 
> On Fri, Aug 05, 2022 at 09:36:37AM -0400, Liang, Kan wrote:
> 
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 34be3bc5151a..a2c26eaeb0d9 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1687,8 +1687,10 @@ static void setup_pebs_fixed_sample_data(struct
>> perf_event *event,
>>  	 * We can only do this for the default trace clock.
>>  	 */
>>  	if (x86_pmu.intel_cap.pebs_format >= 3 &&
>> -		event->attr.use_clockid == 0)
>> +		event->attr.use_clockid == 0) {
> 
> Indent fail; please add: 'set cino=(0:0' to your .vimrc or figure out
> the equivalent for your editor of choice.
> 
>>  		data->time = native_sched_clock_from_tsc(pebs->tsc);
>> +		data->flags |= PERF_SAMPLE_DATA_TIME;
>> +	}
>>
>>  	if (has_branch_stack(event))
>>  		data->br_stack = &cpuc->lbr_stack;
> 
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index da759560eec5..33054bf31fc1 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -999,6 +999,7 @@ int perf_event_read_local(struct perf_event *event,
>> u64 *value,
>>  extern u64 perf_event_read_value(struct perf_event *event,
>>  				 u64 *enabled, u64 *running);
>>
>> +#define PERF_SAMPLE_DATA_TIME		0x1
>>
>>  struct perf_sample_data {
>>  	/*
>> @@ -1012,6 +1013,7 @@ struct perf_sample_data {
>>  	union perf_sample_weight	weight;
>>  	u64				txn;
>>  	union  perf_mem_data_src	data_src;
>> +	u64				flags;
>>
>>  	/*
>>  	 * The other fields, optionally {set,used} by
> 
> How about we call that 'sample_flags' instead and use PERF_SAMPLE_* as
> we already have, something like so:

True, I think we can use PERF_SAMPLE_* and avoid adding more flags.

I will implement some patches based on the suggestion.

Thanks,
Kan

> 
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..b0ebbb1377b9 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1007,6 +1007,7 @@ struct perf_sample_data {
>  	 * Fields set by perf_sample_data_init(), group so as to
>  	 * minimize the cachelines touched.
>  	 */
> +	u64				sample_flags;
>  	u64				addr;
>  	struct perf_raw_record		*raw;
>  	struct perf_branch_stack	*br_stack;
> @@ -1056,6 +1057,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  					 u64 addr, u64 period)
>  {
>  	/* remaining struct members initialized in perf_prepare_sample() */
> +	data->sample_flags = 0;
>  	data->addr = addr;
>  	data->raw  = NULL;
>  	data->br_stack = NULL;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..fed447f59024 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6792,15 +6792,21 @@ static void perf_aux_sample_output(struct perf_event *event,
>  	ring_buffer_put(rb);
>  }
>  
> -static void __perf_event_header__init_id(struct perf_event_header *header,
> -					 struct perf_sample_data *data,
> -					 struct perf_event *event)
> +static u64 __perf_event_header__init_id(struct perf_event_header *header,
> +					struct perf_sample_data *data,
> +					struct perf_event *event)
>  {
>  	u64 sample_type = event->attr.sample_type;
>  
>  	data->type = sample_type;
>  	header->size += event->id_header_size;
>  
> +	/*
> +	 * Clear the sample flags that have already been done by the
> +	 * PMU driver.
> +	 */
> +	sample_type &= ~data->sample_flags;
> +
>  	if (sample_type & PERF_SAMPLE_TID) {
>  		/* namespace issues */
>  		data->tid_entry.pid = perf_event_pid(event, current);
> @@ -6820,6 +6826,8 @@ static void __perf_event_header__init_id(struct perf_event_header *header,
>  		data->cpu_entry.cpu	 = raw_smp_processor_id();
>  		data->cpu_entry.reserved = 0;
>  	}
> +
> +	return sample_type;
>  }
>  
>  void perf_event_header__init_id(struct perf_event_header *header,
> @@ -7302,7 +7310,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>  			 struct perf_event *event,
>  			 struct pt_regs *regs)
>  {
> -	u64 sample_type = event->attr.sample_type;
> +	u64 sample_type;
>  
>  	header->type = PERF_RECORD_SAMPLE;
>  	header->size = sizeof(*header) + event->header_size;
> @@ -7310,7 +7318,7 @@ void perf_prepare_sample(struct perf_event_header *header,
>  	header->misc = 0;
>  	header->misc |= perf_misc_flags(regs);
>  
> -	__perf_event_header__init_id(header, data, event);
> +	sample_type = __perf_event_header__init_id(header, data, event);
>  
>  	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
>  		data->ip = perf_instruction_pointer(regs);

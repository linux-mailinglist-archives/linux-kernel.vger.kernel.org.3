Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE615AED8E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiIFOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbiIFOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:37:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA298C97
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662472819; x=1694008819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UkgvLv9YZ4lUbUSkhLrpVq2ZzON197bp01lFaQQ3LZ4=;
  b=mXXu7bxPWng1KZHnqA3jzfDCgR5fAgEDICLE3x3RbDnYTsw/6sXfap/7
   D1rBm99j8P8SAKIMSU7BxIhjdCsj6d2k311eJSQHFwr15/3pK2Wnz4xH+
   inJqG5bSprPRKYWoUw9qtr4oq3JkEzjqNknCGj4cmYM6zDY8lhwDDPSM6
   J67fImwJeOqKb8HPvY5f97rxZAoMJU4ip7h/OyKDtzaojSCEkFt+R3T9m
   JI7qI7aketVYOsvwVEeqIlCcOA+f+J60+Mo1Js74f4zEPcjCRsVUZBXye
   SPn1bCy2dpwRzK283LYv5oI35x4A3uj/Tl3XIJT4SM6Z5IorXUg5oif/Q
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="322772919"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="322772919"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:56:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="717705459"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 06 Sep 2022 06:56:16 -0700
Received: from [10.252.209.77] (kliang2-mobl1.ccr.corp.intel.com [10.252.209.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 949E2580890;
        Tue,  6 Sep 2022 06:56:14 -0700 (PDT)
Message-ID: <3597fcd7-f109-8a3c-0975-03e4c4ec8b2e@linux.intel.com>
Date:   Tue, 6 Sep 2022 09:56:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH V2 4/6] perf: Use sample_flags for weight
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, andreas.kogler.0x@gmail.com,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20220901130959.1285717-1-kan.liang@linux.intel.com>
 <20220901130959.1285717-5-kan.liang@linux.intel.com>
 <CAM9d7cgbgjz-X9Hv1o+kik+-QBAyDTShO4ChRiHehNFW+d_gOA@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAM9d7cgbgjz-X9Hv1o+kik+-QBAyDTShO4ChRiHehNFW+d_gOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-09-02 1:29 a.m., Namhyung Kim wrote:
> On Thu, Sep 1, 2022 at 6:10 AM <kan.liang@linux.intel.com> wrote:
>>
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Use the new sample_flags to indicate whether the weight field is filled
>> by the PMU driver.
>>
>> Remove the weight field from the perf_sample_data_init() to minimize the
>> number of cache lines touched.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>  arch/powerpc/perf/core-book3s.c |  5 +++--
>>  arch/x86/events/intel/ds.c      | 10 +++++++---
>>  include/linux/perf_event.h      |  3 +--
>>  kernel/events/core.c            |  3 +++
>>  4 files changed, 14 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
>> index 1ad1efdb33f9..a5c95a2006ea 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -2305,9 +2305,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
>>                         ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
>>
>>                 if (event->attr.sample_type & PERF_SAMPLE_WEIGHT_TYPE &&
>> -                                               ppmu->get_mem_weight)
>> +                                               ppmu->get_mem_weight) {
>>                         ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
>> -
>> +                       data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
>> +               }
>>                 if (perf_event_overflow(event, &data, regs))
>>                         power_pmu_stop(event, 0);
>>         } else if (period) {
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 5dcfd2de6ef8..f66a4905cc87 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1535,8 +1535,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>>         /*
>>          * Use latency for weight (only avail with PEBS-LL)
>>          */
>> -       if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
>> +       if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE)) {
>>                 data->weight.full = pebs->lat;
>> +               data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
>> +       }
>>
>>         /*
>>          * data.data_src encodes the data source
>> @@ -1628,9 +1630,10 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>>
>>         if (x86_pmu.intel_cap.pebs_format >= 2) {
>>                 /* Only set the TSX weight when no memory weight. */
>> -               if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
>> +               if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll) {
>>                         data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
>> -
>> +                       data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
>> +               }
>>                 if (sample_type & PERF_SAMPLE_TRANSACTION)
>>                         data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
>>                                                               pebs->ax);
>> @@ -1772,6 +1775,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>>                                 data->weight.var1_dw = (u32)(weight & PEBS_LATENCY_MASK) ?:
>>                                         intel_get_tsx_weight(meminfo->tsx_tuning);
>>                         }
>> +                       data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
> 
> I was thinking about splitting PERF_SAMPLE_WEIGHT and
> PERF_SAMPLE_WEIGHT_STRUCT but it'd just add complexity
> unnecessarily?

Right, I don't think it's necessary. The code path is to handle the
weight. We use the same way to handle the old and new weight flags. We
should have both set.

Thanks,
Kan
> 
> Thanks,
> Namhyung
> 
>>                 }
>>
>>                 if (sample_type & PERF_SAMPLE_DATA_SRC)
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 1e12e79454e0..06a587b5faa9 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1012,7 +1012,6 @@ struct perf_sample_data {
>>         u64                             addr;
>>         struct perf_raw_record          *raw;
>>         u64                             period;
>> -       union perf_sample_weight        weight;
>>         u64                             txn;
>>         union  perf_mem_data_src        data_src;
>>
>> @@ -1021,6 +1020,7 @@ struct perf_sample_data {
>>          * perf_{prepare,output}_sample().
>>          */
>>         struct perf_branch_stack        *br_stack;
>> +       union perf_sample_weight        weight;
>>
>>         u64                             type;
>>         u64                             ip;
>> @@ -1063,7 +1063,6 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>>         data->addr = addr;
>>         data->raw  = NULL;
>>         data->period = period;
>> -       data->weight.full = 0;
>>         data->data_src.val = PERF_MEM_NA;
>>         data->txn = 0;
>>  }
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 104c0c9f4e6f..f0af45db02b3 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -7408,6 +7408,9 @@ void perf_prepare_sample(struct perf_event_header *header,
>>                 header->size += size;
>>         }
>>
>> +       if (filtered_sample_type & PERF_SAMPLE_WEIGHT_TYPE)
>> +               data->weight.full = 0;
>> +
>>         if (sample_type & PERF_SAMPLE_REGS_INTR) {
>>                 /* regs dump ABI info */
>>                 int size = sizeof(u64);
>> --
>> 2.35.1
>>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0242592633
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 21:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbiHNTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 15:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiHNTjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 15:39:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928F17A99
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660505952; x=1692041952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X7rL4fg6h5O7O7uR51jC3e/S6X/ZtpZUor3z4Hln1r8=;
  b=dvoYFJbS0qq3t1x8IMiXwQnj1ki8XOZaCubB8zoiMqkxukbB3zIOReN/
   7xlMwmOUZq8iWf5F9sT0QJpOAqqAQVe1Yyev9AmVv5DlU+Su/TFrlf5DH
   Urp9/1XO4Aajo2G6KqKME0MXKpopcstdqmjlPHPE+8cw6inclK9ZzZa3g
   TwqnONff0HemWXsFIDfXHlgZRO3YWsG5CYY+UL79av4OX2E8eZTCp9DzS
   HPl+yf2TB8KNc/XpeSVWZBZ8T6mOEyOIOfJMtHQqDTMUgGQHs8zNHRSNy
   pqnnfHbkBWeQFVuNMxgSFPBO8yGPKx5AMSkMk+TY54Hd33M44twTVGaI1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="293119332"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="293119332"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 12:39:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="748716170"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2022 12:39:11 -0700
Received: from [10.252.214.243] (kliang2-mobl1.ccr.corp.intel.com [10.252.214.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0BD97580C50;
        Sun, 14 Aug 2022 12:39:09 -0700 (PDT)
Message-ID: <5e3e4723-bd3e-b5d2-cf9a-6d7334f93be8@linux.intel.com>
Date:   Sun, 14 Aug 2022 15:39:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, ak@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, irogers@google.com
References: <20220810210656.2799243-1-eranian@google.com>
 <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
 <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
 <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
 <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com>
 <YvarjGUrBiH6xOKO@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <YvarjGUrBiH6xOKO@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022-08-12 3:35 p.m., Arnaldo Carvalho de Melo wrote:
> Em Thu, Aug 11, 2022 at 11:56:56AM -0400, Liang, Kan escreveu:
>>
>>
>> On 2022-08-11 11:33 a.m., Stephane Eranian wrote:
>>> On Thu, Aug 11, 2022 at 6:28 PM Stephane Eranian <eranian@google.com> wrote:
>>>>
>>>> On Thu, Aug 11, 2022 at 5:42 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2022-08-11 10:17 a.m., Stephane Eranian wrote:
>>>>>> On Thu, Aug 11, 2022 at 3:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
>>>>>>>> With architected LBR, the procesosr can record the type of each sampled taken
>>>>>>>> branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
>>>>>>>>
>>>>>>>> The branch type must then extracted and saved in the perf_branch_entry in the
>>>>>>>> perf_events sampling buffer. With the current code, the raw Intel encoding of
>>>>>>>> the branch is exported to user tools.
>>>>>>>
>>>>>>> In the intel_pmu_lbr_filter(), the raw encoding will be converted into
>>>>>>> the X86_BR_* format via arch_lbr_br_type_map[]. Then the
>>>>>>> common_branch_type() will convert the X86_BR_* format to the generic
>>>>>>> PERF_BR_* type and expose to user tools.
>>>>>>>
>>>>>>> I double check the existing arch_lbr_br_type_map[] and branch_map[].
>>>>>>> They should generate the same PERF_BR_* type as your arch_lbr_type_map[].
>>>>>>>
>>>>>>> Is there a test case which I can use to reproduce the problem?
>>>>>>>
>>>>>> I was doing a simple:
>>>>>> $ perf record -b -e cpu/event=0xc4/ ....
>>>>>> $ perf report -D
>>>>>> Looking at the LBR information and the BR type, many entries has no branch type.
>>>>>> What I see is a function where you do: e->type = get_lbr_br_type() and
>>>>>> that is what
>>>>>> is then saved in the buffer. Unless I am missing a later patch.
>>>>>>
>>>>>
>>>>> To get the LBR type, the save_type filter option must be applied. See
>>>>> 60f83fa6341d ("perf record: Create a new option save_type in
>>>>> --branch-filter").
>>>>>
>>>> That seems overly complicated. I don't recall having to pass a new option
>>>> to get the LBR latency. It showed up automatically. So why for branch_type?
>>>>
>>>>> The -b only include the ANY option. Maybe we should extend the -b option
>>>>> to ANY|SAVE_TYPE.
>>>>>
>>>> Ok, that explains it then. I think we need to simplify.
>>>>
>>> In fact, I don't see a case where you would not benefit from the branch type.
>>> Furthermore, not having the branch type DOES NOT save any space in the
>>> branch record (given we have a reserved field). So I think I prefer not having
>>> to specify yet another cmdline option to get the branch type. 
>>
>>
>> I think the option is to avoid the overhead of disassembling of branch
>> instruction. See eb0baf8a0d92 ("perf/core: Define the common branch type
>> classification")
>> "Since the disassembling of branch instruction needs some overhead,
>> a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
>> needs to disassemble the branch instruction and record the branch
>> type."
>>
>> I have no idea how big the overhead is. If we can always be benefit from
>> the branch type. I guess we can make it default on.
> 
> Would you be so nice as to add a paragraph with such explanation to the
> man page so that what happened to Stephane doesn't trip other people?
> 

Sure, I will update the document once we decide whether enable the
branch type by default in the kernel for Arch LBR.

Thanks,
Kan
> - Arnaldo
>  
>>> In fact, if you do
>>> not pass the option, then perf report -D reports some bogus branch types, i.e.,
>>> not all entries have empty types.
>>
>> Yes, that's an issue for Arch LBR. If the overhead is not a problem, it
>> should be gone after we make the SAVE_TYPE default. Otherwise, I think
>> we need a patch to clear the fields if the SAVE_TYPE is not applied.
>>
>> Thanks,
>> Kan
>>>
>>>
>>>>>>
>>>>>>> Thanks,
>>>>>>> Kan
>>>>>>>
>>>>>>>> Yet tools, such as perf, expected the
>>>>>>>> branch type to be encoded using perf_events branch type enum
>>>>>>>> (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
>>>>>>>> perf report -D shows bogus branch types.
>>>>>>>>
>>>>>>>> Fix the problem by converting the Intel raw encoding into the perf_events
>>>>>>>> branch type enum values. With that in place and with no changes to the tools,
>>>>>>>> the branch types are now reported properly.
>>>>>>>>
>>>>>>>> Signed-off-by: Stephane Eranian <eranian@google.com>
>>>>>>>> ---
>>>>>>>>  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
>>>>>>>>  1 file changed, 32 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>>>>>>>> index 4f70fb6c2c1e..ef63d4d46b50 100644
>>>>>>>> --- a/arch/x86/events/intel/lbr.c
>>>>>>>> +++ b/arch/x86/events/intel/lbr.c
>>>>>>>> @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
>>>>>>>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
>>>>>>>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
>>>>>>>>
>>>>>>>> -static __always_inline int get_lbr_br_type(u64 info)
>>>>>>>> +/*
>>>>>>>> + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
>>>>>>>> + * as per Intel SDM Vol3b Branch Types section
>>>>>>>> + */
>>>>>>>> +static const int arch_lbr_type_map[]={
>>>>>>>> +     [0] = PERF_BR_COND,
>>>>>>>> +     [1] = PERF_BR_IND,
>>>>>>>> +     [2] = PERF_BR_UNCOND,
>>>>>>>> +     [3] = PERF_BR_IND_CALL,
>>>>>>>> +     [4] = PERF_BR_CALL,
>>>>>>>> +     [5] = PERF_BR_RET,
>>>>>>>> +};
>>>>>>>> +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
>>>>>>>> +
>>>>>>>> +static __always_inline u16 get_lbr_br_type(u64 info)
>>>>>>>>  {
>>>>>>>> -     int type = 0;
>>>>>>>> +     u16 type = 0;
>>>>>>>>
>>>>>>>>       if (static_branch_likely(&x86_lbr_type))
>>>>>>>>               type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
>>>>>>>> @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
>>>>>>>>       return type;
>>>>>>>>  }
>>>>>>>>
>>>>>>>> +/*
>>>>>>>> + * The kernel cannot expose raw Intel branch type encodings because they are
>>>>>>>> + * not generic. Instead, the function below  maps the encoding to the
>>>>>>>> + * perf_events user visible branch types.
>>>>>>>> + */
>>>>>>>> +static __always_inline int get_lbr_br_type_mapping(u64 info)
>>>>>>>> +{
>>>>>>>> +     if (static_branch_likely(&x86_lbr_type)) {
>>>>>>>> +             u16 raw_type = get_lbr_br_type(info);
>>>>>>>> +             if (raw_type < ARCH_LBR_TYPE_COUNT)
>>>>>>>> +                     return arch_lbr_type_map[raw_type];
>>>>>>>> +     }
>>>>>>>> +     return PERF_BR_UNKNOWN;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>  static __always_inline bool get_lbr_mispred(u64 info)
>>>>>>>>  {
>>>>>>>>       bool mispred = 0;
>>>>>>>> @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
>>>>>>>>               e->in_tx        = !!(info & LBR_INFO_IN_TX);
>>>>>>>>               e->abort        = !!(info & LBR_INFO_ABORT);
>>>>>>>>               e->cycles       = get_lbr_cycles(info);
>>>>>>>> -             e->type         = get_lbr_br_type(info);
>>>>>>>> +             e->type         = get_lbr_br_type_mapping(info);
>>>>>>>>       }
>>>>>>>>
>>>>>>>>       cpuc->lbr_stack.nr = i;
> 

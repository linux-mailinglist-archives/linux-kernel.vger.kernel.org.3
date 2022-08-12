Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F270591601
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiHLTft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiHLTfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:35:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D391AF3C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 12:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC649B82531
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 19:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05344C433D6;
        Fri, 12 Aug 2022 19:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660332943;
        bh=69cScjBMrQdoSuwkdGl5XRtHIrX/wnastBXjCsWHzW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LYgNYGvrO2kizbjrM6oUa8Gc9JiYUo0YEWQXBDP5+VRotFcNpDSVYfThsX8QelMJn
         xIV3EEnCv5FZ5L7kERWzPqiHF7uRaEYi4u61CJl5FnGC1F6UPqBd7KT8vvnjwl2bQe
         RK66sNSnx+qtse6/S9QtVkiQwRyDs5zNuh+M2+DnAamU4ctUXVr8RfA9xtt0zKE0tj
         6fPI2InXZKzFzOQRKmJe9JrNzZPi+OSimEjDmhBNP4FoxhEkJ94h2uH3KF7x9D2Ut9
         NNN/ONWHYzQvPPEwb1TcafWKXiF/T/MG/EvCPqvNDlhLd5cO+DYgnXgwxRVlq2G5r8
         jd5MgVfLp3Icw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 70E144035A; Fri, 12 Aug 2022 16:35:40 -0300 (-03)
Date:   Fri, 12 Aug 2022 16:35:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, ak@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
Message-ID: <YvarjGUrBiH6xOKO@kernel.org>
References: <20220810210656.2799243-1-eranian@google.com>
 <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
 <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
 <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
 <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fc8dc1d-6922-e2e0-8b5d-fad25ab12cbd@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 11, 2022 at 11:56:56AM -0400, Liang, Kan escreveu:
> 
> 
> On 2022-08-11 11:33 a.m., Stephane Eranian wrote:
> > On Thu, Aug 11, 2022 at 6:28 PM Stephane Eranian <eranian@google.com> wrote:
> >>
> >> On Thu, Aug 11, 2022 at 5:42 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2022-08-11 10:17 a.m., Stephane Eranian wrote:
> >>>> On Thu, Aug 11, 2022 at 3:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
> >>>>>> With architected LBR, the procesosr can record the type of each sampled taken
> >>>>>> branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
> >>>>>>
> >>>>>> The branch type must then extracted and saved in the perf_branch_entry in the
> >>>>>> perf_events sampling buffer. With the current code, the raw Intel encoding of
> >>>>>> the branch is exported to user tools.
> >>>>>
> >>>>> In the intel_pmu_lbr_filter(), the raw encoding will be converted into
> >>>>> the X86_BR_* format via arch_lbr_br_type_map[]. Then the
> >>>>> common_branch_type() will convert the X86_BR_* format to the generic
> >>>>> PERF_BR_* type and expose to user tools.
> >>>>>
> >>>>> I double check the existing arch_lbr_br_type_map[] and branch_map[].
> >>>>> They should generate the same PERF_BR_* type as your arch_lbr_type_map[].
> >>>>>
> >>>>> Is there a test case which I can use to reproduce the problem?
> >>>>>
> >>>> I was doing a simple:
> >>>> $ perf record -b -e cpu/event=0xc4/ ....
> >>>> $ perf report -D
> >>>> Looking at the LBR information and the BR type, many entries has no branch type.
> >>>> What I see is a function where you do: e->type = get_lbr_br_type() and
> >>>> that is what
> >>>> is then saved in the buffer. Unless I am missing a later patch.
> >>>>
> >>>
> >>> To get the LBR type, the save_type filter option must be applied. See
> >>> 60f83fa6341d ("perf record: Create a new option save_type in
> >>> --branch-filter").
> >>>
> >> That seems overly complicated. I don't recall having to pass a new option
> >> to get the LBR latency. It showed up automatically. So why for branch_type?
> >>
> >>> The -b only include the ANY option. Maybe we should extend the -b option
> >>> to ANY|SAVE_TYPE.
> >>>
> >> Ok, that explains it then. I think we need to simplify.
> >>
> > In fact, I don't see a case where you would not benefit from the branch type.
> > Furthermore, not having the branch type DOES NOT save any space in the
> > branch record (given we have a reserved field). So I think I prefer not having
> > to specify yet another cmdline option to get the branch type. 
> 
> 
> I think the option is to avoid the overhead of disassembling of branch
> instruction. See eb0baf8a0d92 ("perf/core: Define the common branch type
> classification")
> "Since the disassembling of branch instruction needs some overhead,
> a new PERF_SAMPLE_BRANCH_TYPE_SAVE is introduced to indicate if it
> needs to disassemble the branch instruction and record the branch
> type."
> 
> I have no idea how big the overhead is. If we can always be benefit from
> the branch type. I guess we can make it default on.

Would you be so nice as to add a paragraph with such explanation to the
man page so that what happened to Stephane doesn't trip other people?

- Arnaldo
 
> > In fact, if you do
> > not pass the option, then perf report -D reports some bogus branch types, i.e.,
> > not all entries have empty types.
> 
> Yes, that's an issue for Arch LBR. If the overhead is not a problem, it
> should be gone after we make the SAVE_TYPE default. Otherwise, I think
> we need a patch to clear the fields if the SAVE_TYPE is not applied.
> 
> Thanks,
> Kan
> > 
> > 
> >>>>
> >>>>> Thanks,
> >>>>> Kan
> >>>>>
> >>>>>> Yet tools, such as perf, expected the
> >>>>>> branch type to be encoded using perf_events branch type enum
> >>>>>> (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
> >>>>>> perf report -D shows bogus branch types.
> >>>>>>
> >>>>>> Fix the problem by converting the Intel raw encoding into the perf_events
> >>>>>> branch type enum values. With that in place and with no changes to the tools,
> >>>>>> the branch types are now reported properly.
> >>>>>>
> >>>>>> Signed-off-by: Stephane Eranian <eranian@google.com>
> >>>>>> ---
> >>>>>>  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
> >>>>>>  1 file changed, 32 insertions(+), 3 deletions(-)
> >>>>>>
> >>>>>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> >>>>>> index 4f70fb6c2c1e..ef63d4d46b50 100644
> >>>>>> --- a/arch/x86/events/intel/lbr.c
> >>>>>> +++ b/arch/x86/events/intel/lbr.c
> >>>>>> @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
> >>>>>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
> >>>>>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
> >>>>>>
> >>>>>> -static __always_inline int get_lbr_br_type(u64 info)
> >>>>>> +/*
> >>>>>> + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
> >>>>>> + * as per Intel SDM Vol3b Branch Types section
> >>>>>> + */
> >>>>>> +static const int arch_lbr_type_map[]={
> >>>>>> +     [0] = PERF_BR_COND,
> >>>>>> +     [1] = PERF_BR_IND,
> >>>>>> +     [2] = PERF_BR_UNCOND,
> >>>>>> +     [3] = PERF_BR_IND_CALL,
> >>>>>> +     [4] = PERF_BR_CALL,
> >>>>>> +     [5] = PERF_BR_RET,
> >>>>>> +};
> >>>>>> +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
> >>>>>> +
> >>>>>> +static __always_inline u16 get_lbr_br_type(u64 info)
> >>>>>>  {
> >>>>>> -     int type = 0;
> >>>>>> +     u16 type = 0;
> >>>>>>
> >>>>>>       if (static_branch_likely(&x86_lbr_type))
> >>>>>>               type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
> >>>>>> @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
> >>>>>>       return type;
> >>>>>>  }
> >>>>>>
> >>>>>> +/*
> >>>>>> + * The kernel cannot expose raw Intel branch type encodings because they are
> >>>>>> + * not generic. Instead, the function below  maps the encoding to the
> >>>>>> + * perf_events user visible branch types.
> >>>>>> + */
> >>>>>> +static __always_inline int get_lbr_br_type_mapping(u64 info)
> >>>>>> +{
> >>>>>> +     if (static_branch_likely(&x86_lbr_type)) {
> >>>>>> +             u16 raw_type = get_lbr_br_type(info);
> >>>>>> +             if (raw_type < ARCH_LBR_TYPE_COUNT)
> >>>>>> +                     return arch_lbr_type_map[raw_type];
> >>>>>> +     }
> >>>>>> +     return PERF_BR_UNKNOWN;
> >>>>>> +}
> >>>>>> +
> >>>>>>  static __always_inline bool get_lbr_mispred(u64 info)
> >>>>>>  {
> >>>>>>       bool mispred = 0;
> >>>>>> @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
> >>>>>>               e->in_tx        = !!(info & LBR_INFO_IN_TX);
> >>>>>>               e->abort        = !!(info & LBR_INFO_ABORT);
> >>>>>>               e->cycles       = get_lbr_cycles(info);
> >>>>>> -             e->type         = get_lbr_br_type(info);
> >>>>>> +             e->type         = get_lbr_br_type_mapping(info);
> >>>>>>       }
> >>>>>>
> >>>>>>       cpuc->lbr_stack.nr = i;

-- 

- Arnaldo

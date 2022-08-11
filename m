Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5757258FF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiHKP2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiHKP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:28:49 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271B492F57
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:28:48 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id t21so7079550uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=c/nuhX7+RYdmqtLyvc2oaaVrK9PE6Uvqqdw/nzrLb/Q=;
        b=WfOxla24MB9Jh3O9QDZHpGBtdFiHvvRlriHR1dXKr2QRQS9m+oTPIxRo7Fw0VWgbOi
         xf9bL7U7MBR2FJ2pE4NpekGVgdhL8yTqR2JRLEYFt4g4/tWTgBOIUtt3/pyWqWMyJ5EB
         stm3l6995LnAU9ZrhEmFcs/sr9+67vlaFhNZ2mZdzk16BOIMfKFff3laiiKy4wWmRODp
         GKgWlEAnVDqNPiLfQ8sKEaCM7uyx+E2Td5wQlALoytDYyjhdV7YEHDV9T7L1h7QucQZh
         q10Hrge8L+lP3s46trs91HPx0+KqGknWIXfGt1C3jZM+P3imvcn0mZzW5hl724YJgNwW
         Y/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=c/nuhX7+RYdmqtLyvc2oaaVrK9PE6Uvqqdw/nzrLb/Q=;
        b=WybnNq7FTTLkghVl9EbLKjm/nQJj7cl7bCFee5ZLetK0kW14tqXJEpTqwLhdhgg3FF
         ZAlRsg6iOAYzsHqhJc0KEzHlk7JBIJ4MkRvkbiYWi+Se8AnLA7vBD0klEvFCScpuoCGV
         Xv1gVX2z5jXQbyFuUxddDo5yjqZy2jGZVkuzzPrwkModEnHp7EgIxncYJDePTuDQFgvi
         lkGgHBXnUJygbRvRq5ePC7XLW110jFQbudaQieCrUKyirDFnp/rxvXCTOzCV3h3bdiIo
         0EEOGbfnXP6bIsseSO2MSmNP+G4Zrjtp9XUHdOo+h5cPJSmFRDZ/Vl9sLHPcoJgQLGXl
         tuaw==
X-Gm-Message-State: ACgBeo2zYBRjzd5l3muVRPVCkyEJ2tf9XXzlr/E1mIS+NIyoEYRRhvC8
        7kEHDDJL2ZxnErNr2HD/RJU38vmmOb1Ucj2aGPettA==
X-Google-Smtp-Source: AA6agR7KXCXTj1b+jmngAPB9jrl2AWzJNaa0NAtJSzdNpg0afNC5eCpW+aqX22jfxFfZK4UhFsA/Y3v+Y6l3E1jBeu8=
X-Received: by 2002:ab0:3cc:0:b0:384:defe:ff2 with SMTP id 70-20020ab003cc000000b00384defe0ff2mr13612320uau.71.1660231727143;
 Thu, 11 Aug 2022 08:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220810210656.2799243-1-eranian@google.com> <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com> <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
In-Reply-To: <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 11 Aug 2022 18:28:35 +0300
Message-ID: <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel/lbr: fix branch type encoding
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kan.liang@intel.com, ak@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 5:42 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-11 10:17 a.m., Stephane Eranian wrote:
> > On Thu, Aug 11, 2022 at 3:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
> >>> With architected LBR, the procesosr can record the type of each sampled taken
> >>> branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
> >>>
> >>> The branch type must then extracted and saved in the perf_branch_entry in the
> >>> perf_events sampling buffer. With the current code, the raw Intel encoding of
> >>> the branch is exported to user tools.
> >>
> >> In the intel_pmu_lbr_filter(), the raw encoding will be converted into
> >> the X86_BR_* format via arch_lbr_br_type_map[]. Then the
> >> common_branch_type() will convert the X86_BR_* format to the generic
> >> PERF_BR_* type and expose to user tools.
> >>
> >> I double check the existing arch_lbr_br_type_map[] and branch_map[].
> >> They should generate the same PERF_BR_* type as your arch_lbr_type_map[].
> >>
> >> Is there a test case which I can use to reproduce the problem?
> >>
> > I was doing a simple:
> > $ perf record -b -e cpu/event=0xc4/ ....
> > $ perf report -D
> > Looking at the LBR information and the BR type, many entries has no branch type.
> > What I see is a function where you do: e->type = get_lbr_br_type() and
> > that is what
> > is then saved in the buffer. Unless I am missing a later patch.
> >
>
> To get the LBR type, the save_type filter option must be applied. See
> 60f83fa6341d ("perf record: Create a new option save_type in
> --branch-filter").
>
That seems overly complicated. I don't recall having to pass a new option
to get the LBR latency. It showed up automatically. So why for branch_type?

> The -b only include the ANY option. Maybe we should extend the -b option
> to ANY|SAVE_TYPE.
>
Ok, that explains it then. I think we need to simplify.


> Thanks,
> Kan
>
> >
> >> Thanks,
> >> Kan
> >>
> >>> Yet tools, such as perf, expected the
> >>> branch type to be encoded using perf_events branch type enum
> >>> (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
> >>> perf report -D shows bogus branch types.
> >>>
> >>> Fix the problem by converting the Intel raw encoding into the perf_events
> >>> branch type enum values. With that in place and with no changes to the tools,
> >>> the branch types are now reported properly.
> >>>
> >>> Signed-off-by: Stephane Eranian <eranian@google.com>
> >>> ---
> >>>  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
> >>>  1 file changed, 32 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> >>> index 4f70fb6c2c1e..ef63d4d46b50 100644
> >>> --- a/arch/x86/events/intel/lbr.c
> >>> +++ b/arch/x86/events/intel/lbr.c
> >>> @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
> >>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
> >>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
> >>>
> >>> -static __always_inline int get_lbr_br_type(u64 info)
> >>> +/*
> >>> + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
> >>> + * as per Intel SDM Vol3b Branch Types section
> >>> + */
> >>> +static const int arch_lbr_type_map[]={
> >>> +     [0] = PERF_BR_COND,
> >>> +     [1] = PERF_BR_IND,
> >>> +     [2] = PERF_BR_UNCOND,
> >>> +     [3] = PERF_BR_IND_CALL,
> >>> +     [4] = PERF_BR_CALL,
> >>> +     [5] = PERF_BR_RET,
> >>> +};
> >>> +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
> >>> +
> >>> +static __always_inline u16 get_lbr_br_type(u64 info)
> >>>  {
> >>> -     int type = 0;
> >>> +     u16 type = 0;
> >>>
> >>>       if (static_branch_likely(&x86_lbr_type))
> >>>               type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
> >>> @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
> >>>       return type;
> >>>  }
> >>>
> >>> +/*
> >>> + * The kernel cannot expose raw Intel branch type encodings because they are
> >>> + * not generic. Instead, the function below  maps the encoding to the
> >>> + * perf_events user visible branch types.
> >>> + */
> >>> +static __always_inline int get_lbr_br_type_mapping(u64 info)
> >>> +{
> >>> +     if (static_branch_likely(&x86_lbr_type)) {
> >>> +             u16 raw_type = get_lbr_br_type(info);
> >>> +             if (raw_type < ARCH_LBR_TYPE_COUNT)
> >>> +                     return arch_lbr_type_map[raw_type];
> >>> +     }
> >>> +     return PERF_BR_UNKNOWN;
> >>> +}
> >>> +
> >>>  static __always_inline bool get_lbr_mispred(u64 info)
> >>>  {
> >>>       bool mispred = 0;
> >>> @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
> >>>               e->in_tx        = !!(info & LBR_INFO_IN_TX);
> >>>               e->abort        = !!(info & LBR_INFO_ABORT);
> >>>               e->cycles       = get_lbr_cycles(info);
> >>> -             e->type         = get_lbr_br_type(info);
> >>> +             e->type         = get_lbr_br_type_mapping(info);
> >>>       }
> >>>
> >>>       cpuc->lbr_stack.nr = i;

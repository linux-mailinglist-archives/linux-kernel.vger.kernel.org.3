Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CD4590011
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiHKPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiHKPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:36:10 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CDD9DF83
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:33:15 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j2so18657298vsp.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Dvm3ia13p7LjxVkMgvy5ZlGi63NJFPIo0HdPXDl6r38=;
        b=P86ZlgbVWwFgMpdgFk8WYZNaMX5S2zQBu0r3xeKlJrUx9xcd0EspmOClhF4+LmfHP/
         VpYlXjX6HGYq91PMJz6kyVt6P2NcaFGtff5INQHJVY8TdO2XbiYgnU30dBuNu+DEhnFb
         MGk/Ae4zjhDyybuBYiPJSG9N4fXvAggP4PRpleAWat9V4Pz2tOqEn61KTQ4JDFKoK/n+
         kMCyZ+1ZwJg/GdMqW4FcYyAlzzsicoigj3z+Blkd8kb/QbfKtUkCKV4RuJVysCPHbAu6
         e7PEqQvTzKY2F4+xncFhXuDpJpBQCq3iJnineXp2APH2fuuicWLOYELADimLDJTP0IaO
         ePdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Dvm3ia13p7LjxVkMgvy5ZlGi63NJFPIo0HdPXDl6r38=;
        b=lLu8ShVDApTQMNQn2YdTHXvT3vg5GtW9pO7WLZ0rmUt9EqTZ5f+35AOVzOba+o2rE5
         AtArQffn7xO9VjtPIDlSdaSzmAhYHPf4TO62/zhQTXtPO0qH1fkEB3pf47sJJlL4TLvN
         tf2NUdQy7SRbK5bRD8lfs5zxvoCFBZKzz6Uko6D86/5lI1GfRJRwnLsUq3+RnZ8BfUu3
         Y97w7v8PltcIWm1FwLP1bQEOjSEKtXH3DViI7CqdLJd8zQRTl9qh8Tc3aVUv/OeQbi68
         rb92uK5awmJHFCQXLE6H6+WDaV4DxNoNimVfWo8qU/ZuK+XkDyxkTohJBAN9Eg+UBkVE
         bzog==
X-Gm-Message-State: ACgBeo0Xe95WXN5Jss2fJph/PNGz+TtrmQ1AkDnV/7umE/vdgp9fOE2d
        ChHC9fPH0vEyAVAKZ84Cuy8QEfpwu+BqYG+rZFV0rK7jVGI=
X-Google-Smtp-Source: AA6agR6MaSMlLxw/gmTas3OsiCNaI1xxiwkk+27SEdqJM09NamKo62hVu8XKvL4tnvchgXB2RPjhWIBWy9L/kfPfSI0=
X-Received: by 2002:a05:6102:3ec7:b0:356:cbdf:122d with SMTP id
 n7-20020a0561023ec700b00356cbdf122dmr13430514vsv.9.1660231994065; Thu, 11 Aug
 2022 08:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220810210656.2799243-1-eranian@google.com> <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
 <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
 <48297c1e-6e44-53f1-da7d-4437ed87cf6f@linux.intel.com> <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
In-Reply-To: <CABPqkBSUkUTXxS4PwDXYwvTCZ-abY41qyedRGFVoWE9ERtmwsQ@mail.gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 11 Aug 2022 18:33:02 +0300
Message-ID: <CABPqkBRKpUOEwhbu+YsGTx=bWu6DaeTxcCkcKbx5tkCONnJnRw@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 6:28 PM Stephane Eranian <eranian@google.com> wrote:
>
> On Thu, Aug 11, 2022 at 5:42 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2022-08-11 10:17 a.m., Stephane Eranian wrote:
> > > On Thu, Aug 11, 2022 at 3:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > >>
> > >>
> > >>
> > >> On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
> > >>> With architected LBR, the procesosr can record the type of each sampled taken
> > >>> branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
> > >>>
> > >>> The branch type must then extracted and saved in the perf_branch_entry in the
> > >>> perf_events sampling buffer. With the current code, the raw Intel encoding of
> > >>> the branch is exported to user tools.
> > >>
> > >> In the intel_pmu_lbr_filter(), the raw encoding will be converted into
> > >> the X86_BR_* format via arch_lbr_br_type_map[]. Then the
> > >> common_branch_type() will convert the X86_BR_* format to the generic
> > >> PERF_BR_* type and expose to user tools.
> > >>
> > >> I double check the existing arch_lbr_br_type_map[] and branch_map[].
> > >> They should generate the same PERF_BR_* type as your arch_lbr_type_map[].
> > >>
> > >> Is there a test case which I can use to reproduce the problem?
> > >>
> > > I was doing a simple:
> > > $ perf record -b -e cpu/event=0xc4/ ....
> > > $ perf report -D
> > > Looking at the LBR information and the BR type, many entries has no branch type.
> > > What I see is a function where you do: e->type = get_lbr_br_type() and
> > > that is what
> > > is then saved in the buffer. Unless I am missing a later patch.
> > >
> >
> > To get the LBR type, the save_type filter option must be applied. See
> > 60f83fa6341d ("perf record: Create a new option save_type in
> > --branch-filter").
> >
> That seems overly complicated. I don't recall having to pass a new option
> to get the LBR latency. It showed up automatically. So why for branch_type?
>
> > The -b only include the ANY option. Maybe we should extend the -b option
> > to ANY|SAVE_TYPE.
> >
> Ok, that explains it then. I think we need to simplify.
>
In fact, I don't see a case where you would not benefit from the branch type.
Furthermore, not having the branch type DOES NOT save any space in the
branch record (given we have a reserved field). So I think I prefer not having
to specify yet another cmdline option to get the branch type. In fact, if you do
not pass the option, then perf report -D reports some bogus branch types, i.e.,
not all entries have empty types.


> > >
> > >> Thanks,
> > >> Kan
> > >>
> > >>> Yet tools, such as perf, expected the
> > >>> branch type to be encoded using perf_events branch type enum
> > >>> (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
> > >>> perf report -D shows bogus branch types.
> > >>>
> > >>> Fix the problem by converting the Intel raw encoding into the perf_events
> > >>> branch type enum values. With that in place and with no changes to the tools,
> > >>> the branch types are now reported properly.
> > >>>
> > >>> Signed-off-by: Stephane Eranian <eranian@google.com>
> > >>> ---
> > >>>  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
> > >>>  1 file changed, 32 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> > >>> index 4f70fb6c2c1e..ef63d4d46b50 100644
> > >>> --- a/arch/x86/events/intel/lbr.c
> > >>> +++ b/arch/x86/events/intel/lbr.c
> > >>> @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
> > >>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
> > >>>  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
> > >>>
> > >>> -static __always_inline int get_lbr_br_type(u64 info)
> > >>> +/*
> > >>> + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
> > >>> + * as per Intel SDM Vol3b Branch Types section
> > >>> + */
> > >>> +static const int arch_lbr_type_map[]={
> > >>> +     [0] = PERF_BR_COND,
> > >>> +     [1] = PERF_BR_IND,
> > >>> +     [2] = PERF_BR_UNCOND,
> > >>> +     [3] = PERF_BR_IND_CALL,
> > >>> +     [4] = PERF_BR_CALL,
> > >>> +     [5] = PERF_BR_RET,
> > >>> +};
> > >>> +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
> > >>> +
> > >>> +static __always_inline u16 get_lbr_br_type(u64 info)
> > >>>  {
> > >>> -     int type = 0;
> > >>> +     u16 type = 0;
> > >>>
> > >>>       if (static_branch_likely(&x86_lbr_type))
> > >>>               type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
> > >>> @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
> > >>>       return type;
> > >>>  }
> > >>>
> > >>> +/*
> > >>> + * The kernel cannot expose raw Intel branch type encodings because they are
> > >>> + * not generic. Instead, the function below  maps the encoding to the
> > >>> + * perf_events user visible branch types.
> > >>> + */
> > >>> +static __always_inline int get_lbr_br_type_mapping(u64 info)
> > >>> +{
> > >>> +     if (static_branch_likely(&x86_lbr_type)) {
> > >>> +             u16 raw_type = get_lbr_br_type(info);
> > >>> +             if (raw_type < ARCH_LBR_TYPE_COUNT)
> > >>> +                     return arch_lbr_type_map[raw_type];
> > >>> +     }
> > >>> +     return PERF_BR_UNKNOWN;
> > >>> +}
> > >>> +
> > >>>  static __always_inline bool get_lbr_mispred(u64 info)
> > >>>  {
> > >>>       bool mispred = 0;
> > >>> @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
> > >>>               e->in_tx        = !!(info & LBR_INFO_IN_TX);
> > >>>               e->abort        = !!(info & LBR_INFO_ABORT);
> > >>>               e->cycles       = get_lbr_cycles(info);
> > >>> -             e->type         = get_lbr_br_type(info);
> > >>> +             e->type         = get_lbr_br_type_mapping(info);
> > >>>       }
> > >>>
> > >>>       cpuc->lbr_stack.nr = i;

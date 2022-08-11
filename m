Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33A258FE26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbiHKORu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiHKORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:17:34 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCC56E2C0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:17:31 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 125so18390922vsd.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2NeZZjDJWotFhgWXGi2t7rTsS7wfJEMt3rWNlfc2Wfs=;
        b=PGPZIGm1RyJZc0PoZANglmRNAqlWqrpESwh4Bq8gurEyrkpLsfZpuv78Ic5Qnn7y5G
         1ER0BIghcsUFiuYyKsG39sB1ZWX3HHOrw6zLWHCjAzOfOh7uBi1y9A7dDZsN68QF/QEd
         kxHvoP+cCysw6Pwr7c7Pn8uexo9vEtgTarlCADR1BajhalgeNq3m9syWUrvRY0t45Ryr
         /Hc6C9ir+Mj5LYZpn2x1HRx2y7lX5Tlk0hyjD5+V3E3Xycmj45SNdCtwo7s/8EMhXwY/
         ETkB8u4Giy2dzEel3nDZf/O5k7GNNqapqGqAaDrftDteQXtWdMGGl335sX2ZTlnAiYC1
         4N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2NeZZjDJWotFhgWXGi2t7rTsS7wfJEMt3rWNlfc2Wfs=;
        b=nozB0DD0DqQ4wv2SlrAqs8/IXDrsCwzPYuN2LFfasRU6KVFgb3vyzrZAH4U+Ni0MT5
         oWKOWtyOQxDdufKsWkTTsi2Nih0ytchfGELjSDus70twK3r9oiH5WSJ7eBpggPWUW1qD
         LD20kimaQYv20elnZgSHNEq5fG27fVK4pHxUZ8idUuyJ1eIYQRFK8yA+ptYDQUo3qqOH
         PGrsYouY/qDZtdTt/Ku/e91LhjVrpoLCJauL/GEZ3W7gflncTcbZC3G1rZ8i3C319yjX
         nEC7ew1nYja6CrYdSwVJ8Hjr6K7IrTtzT1FbV95EyzLbfW85rfF8yZd8qGbTpgxh1bTu
         ACQA==
X-Gm-Message-State: ACgBeo2+2Q71VV80i0ai1ubWKa4+ApA0OkIaywumwrmU8S96f/ssnKV7
        lQZeOUIqt2RxG4RJ4mVObm7z8NG/W1S5XIVrcd28hcAHh+8=
X-Google-Smtp-Source: AA6agR41LH2wW+qe9a+sEZak55HzTyK+217217nqw47R4Gst1QPqkySzMY/88G08eTCBge959h851CJDN1xe5qTW+FY=
X-Received: by 2002:a05:6102:3d07:b0:38a:a029:baca with SMTP id
 i7-20020a0561023d0700b0038aa029bacamr493734vsv.12.1660227450057; Thu, 11 Aug
 2022 07:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220810210656.2799243-1-eranian@google.com> <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
In-Reply-To: <0267c94e-7989-ca92-4175-d820d1d63a0c@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 11 Aug 2022 17:17:18 +0300
Message-ID: <CABPqkBSD5xg=sEkWU01RQ5+aj1X1dtzt2e7FbZBzrcE8dxqM=A@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 3:23 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2022-08-10 5:06 p.m., Stephane Eranian wrote:
> > With architected LBR, the procesosr can record the type of each sampled taken
> > branch. The type is encoded in 4-bit field in the LBR_INFO MSR of each entry.
> >
> > The branch type must then extracted and saved in the perf_branch_entry in the
> > perf_events sampling buffer. With the current code, the raw Intel encoding of
> > the branch is exported to user tools.
>
> In the intel_pmu_lbr_filter(), the raw encoding will be converted into
> the X86_BR_* format via arch_lbr_br_type_map[]. Then the
> common_branch_type() will convert the X86_BR_* format to the generic
> PERF_BR_* type and expose to user tools.
>
> I double check the existing arch_lbr_br_type_map[] and branch_map[].
> They should generate the same PERF_BR_* type as your arch_lbr_type_map[].
>
> Is there a test case which I can use to reproduce the problem?
>
I was doing a simple:
$ perf record -b -e cpu/event=0xc4/ ....
$ perf report -D
Looking at the LBR information and the BR type, many entries has no branch type.
What I see is a function where you do: e->type = get_lbr_br_type() and
that is what
is then saved in the buffer. Unless I am missing a later patch.


> Thanks,
> Kan
>
> > Yet tools, such as perf, expected the
> > branch type to be encoded using perf_events branch type enum
> > (see tools/perf/util/branch.c). As a result of the discrepancy, the output of
> > perf report -D shows bogus branch types.
> >
> > Fix the problem by converting the Intel raw encoding into the perf_events
> > branch type enum values. With that in place and with no changes to the tools,
> > the branch types are now reported properly.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/events/intel/lbr.c | 35 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> > index 4f70fb6c2c1e..ef63d4d46b50 100644
> > --- a/arch/x86/events/intel/lbr.c
> > +++ b/arch/x86/events/intel/lbr.c
> > @@ -894,9 +894,23 @@ static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
> >  static DEFINE_STATIC_KEY_FALSE(x86_lbr_cycles);
> >  static DEFINE_STATIC_KEY_FALSE(x86_lbr_type);
> >
> > -static __always_inline int get_lbr_br_type(u64 info)
> > +/*
> > + * Array index encodes IA32_LBR_x_INFO Branch Type Encodings
> > + * as per Intel SDM Vol3b Branch Types section
> > + */
> > +static const int arch_lbr_type_map[]={
> > +     [0] = PERF_BR_COND,
> > +     [1] = PERF_BR_IND,
> > +     [2] = PERF_BR_UNCOND,
> > +     [3] = PERF_BR_IND_CALL,
> > +     [4] = PERF_BR_CALL,
> > +     [5] = PERF_BR_RET,
> > +};
> > +#define ARCH_LBR_TYPE_COUNT ARRAY_SIZE(arch_lbr_type_map)
> > +
> > +static __always_inline u16 get_lbr_br_type(u64 info)
> >  {
> > -     int type = 0;
> > +     u16 type = 0;
> >
> >       if (static_branch_likely(&x86_lbr_type))
> >               type = (info & LBR_INFO_BR_TYPE) >> LBR_INFO_BR_TYPE_OFFSET;
> > @@ -904,6 +918,21 @@ static __always_inline int get_lbr_br_type(u64 info)
> >       return type;
> >  }
> >
> > +/*
> > + * The kernel cannot expose raw Intel branch type encodings because they are
> > + * not generic. Instead, the function below  maps the encoding to the
> > + * perf_events user visible branch types.
> > + */
> > +static __always_inline int get_lbr_br_type_mapping(u64 info)
> > +{
> > +     if (static_branch_likely(&x86_lbr_type)) {
> > +             u16 raw_type = get_lbr_br_type(info);
> > +             if (raw_type < ARCH_LBR_TYPE_COUNT)
> > +                     return arch_lbr_type_map[raw_type];
> > +     }
> > +     return PERF_BR_UNKNOWN;
> > +}
> > +
> >  static __always_inline bool get_lbr_mispred(u64 info)
> >  {
> >       bool mispred = 0;
> > @@ -957,7 +986,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
> >               e->in_tx        = !!(info & LBR_INFO_IN_TX);
> >               e->abort        = !!(info & LBR_INFO_ABORT);
> >               e->cycles       = get_lbr_cycles(info);
> > -             e->type         = get_lbr_br_type(info);
> > +             e->type         = get_lbr_br_type_mapping(info);
> >       }
> >
> >       cpuc->lbr_stack.nr = i;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6C58177D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbiGZQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbiGZQeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:34:12 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2770237F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:34:10 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so8477320wmm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNuHcN01lk0zD77Guzu6nAd1WQIrupT+rckkvnxcSjk=;
        b=cNY2dYLaXmzLvhUIi81qOUbXAxvu5GpvbtfvNiPIYJd9whNae8VPqYDF4zN5I93JlG
         UQdxo8KfIx1BXAkwY4pnm3g0NAA7Jv5241bYaKvSIcnnTTH42kSciIR8aytPE4ZDYdCx
         rAV2eFlgz2zLue0UToN+POdT/c42RzEOu1tyRX4YCANdaOu7Dg24CpDHOhm26ds0bZnC
         H23EaNc2w5EujYUlkAQX/Jb3whyHtUT0Z149O6NrOW6T6yL7b8SIBW/+0NyQq5aI9yL/
         buwJK1r926ak/oaIMYheIwl1NHusT3v3LPjLcwbNO44O3LCwnQijflohrAKrKrVg3cNO
         e3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNuHcN01lk0zD77Guzu6nAd1WQIrupT+rckkvnxcSjk=;
        b=eKum9p8NLGYGynlQyGCaExgT96YxohfL/SB9GUUHb9m7vq8F+0TqCZVJQlkw2vzODB
         day4QlzKLdDokhVr1yWkNnQrjWme5c4Ij5Z9frcxOeFMGt4n0ls4foB1jDidGlS2YyEM
         0Ws7dHx1I8QUM5lB368xDuYGwLIKi5ZnDwjshNtceNJc1AlS9VRqPB/O8OtNRLye2Bb/
         oZovb+LTsNEZDpD7b0DRg5sd2AV+puHqzUrXdbtJCFT5LgbvydqUapz1i8VeDeGJRF4J
         /4wluKkWn0cmhJ5hDQbGd0VPDG9seTCjuwQVYOt2QmDsgVm2pU+Oj8/IkoByqTh8us8v
         ouvw==
X-Gm-Message-State: AJIora+78JEd3DNWWKXoEyYPmEFnhu0+Yl9ctC7ckDJHGboMsc192ctY
        PSFF+KSVspzJCoR9esywSIhthVUq1cHx5hxD20eHBA==
X-Google-Smtp-Source: AGRyM1sIcVwhPJOd+33POtj3o7l5afK54GdWG7FskWi6ARFNvOwNJkHL7C83CoFNPy9lzsn5GTWu5FlWHFJ0ZWfLwZs=
X-Received: by 2002:a1c:7213:0:b0:3a3:155a:dd5d with SMTP id
 n19-20020a1c7213000000b003a3155add5dmr26489wmc.178.1658853249048; Tue, 26 Jul
 2022 09:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220726073750.3219117-1-kaleshsingh@google.com>
 <20220726073750.3219117-3-kaleshsingh@google.com> <878rofyibe.wl-maz@kernel.org>
In-Reply-To: <878rofyibe.wl-maz@kernel.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Tue, 26 Jul 2022 09:33:57 -0700
Message-ID: <CAC_TJvehHBr9Qa5akpgLB6GGNzRKPdx855a89Aq8HWnvuGN0rg@mail.gmail.com>
Subject: Re: [PATCH v6 02/17] arm64: stacktrace: Factor out on_accessible_stack_common()
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Fuad Tabba <tabba@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>, android-mm@google.com,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 9:01 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 26 Jul 2022 08:37:35 +0100,
> Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > Move common on_accessible_stack checks to stacktrace/common.h. This is
> > used in the implementation of the nVHE hypervisor unwinder later in
> > this series.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Reviewed-by: Mark Brown <broonie@kernel.org>
> > Tested-by: Fuad Tabba <tabba@google.com>
> > ---
> >
> > Changes in v6:
> >   - Add Fuad's Tested-by tag
> >
> > Changes in v5:
> >   - Add Reviewed-by tags from Mark Brown and Fuad
> >   - Remove random whitespace change, per Mark Brown
> >
> >  arch/arm64/include/asm/stacktrace.h        |  6 ++----
> >  arch/arm64/include/asm/stacktrace/common.h | 18 ++++++++++++++++++
> >  2 files changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
> > index 79f455b37c84..43f4b4a6d383 100644
> > --- a/arch/arm64/include/asm/stacktrace.h
> > +++ b/arch/arm64/include/asm/stacktrace.h
> > @@ -65,8 +65,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
> >                                      unsigned long sp, unsigned long size,
> >                                      struct stack_info *info)
> >  {
> > -     if (info)
> > -             info->type = STACK_TYPE_UNKNOWN;
> > +     if (on_accessible_stack_common(tsk, sp, size, info))
> > +             return true;
> >
> >       if (on_task_stack(tsk, sp, size, info))
> >               return true;
> > @@ -74,8 +74,6 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
> >               return false;
> >       if (on_irq_stack(sp, size, info))
> >               return true;
> > -     if (on_overflow_stack(sp, size, info))
> > -             return true;
> >       if (on_sdei_stack(sp, size, info))
> >               return true;
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> > index 64ae4f6b06fe..f58b786460d3 100644
> > --- a/arch/arm64/include/asm/stacktrace/common.h
> > +++ b/arch/arm64/include/asm/stacktrace/common.h
> > @@ -62,6 +62,9 @@ struct unwind_state {
> >       struct task_struct *task;
> >  };
> >
> > +static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
> > +                                  struct stack_info *info);
> > +
> >  static inline bool on_stack(unsigned long sp, unsigned long size,
> >                           unsigned long low, unsigned long high,
> >                           enum stack_type type, struct stack_info *info)
> > @@ -80,6 +83,21 @@ static inline bool on_stack(unsigned long sp, unsigned long size,
> >       return true;
> >  }
> >
> > +static inline bool on_accessible_stack_common(const struct task_struct *tsk,
> > +                                           unsigned long sp,
> > +                                           unsigned long size,
> > +                                           struct stack_info *info)
> > +{
> > +     if (info)
> > +             info->type = STACK_TYPE_UNKNOWN;
> > +
> > +     /*
> > +      * Both the kernel and nvhe hypervisor make use of
> > +      * an overflow_stack
> > +      */
> > +     return on_overflow_stack(sp, size, info);
> > +}
>
> on_accessible_stack has the following comment:
>
> /*
>  * We can only safely access per-cpu stacks from current in a non-preemptible
>  * context.
>  */
>
> With this change, I don't think we satisfy this requirement anymore,
> as we're checking the overflow stack *before* the preemptible check,
> which is a big change in behaviour.
>
> The hypervisor doesn't have this requirement: the unwinding is either
> done out of context (nVHE, where EL1 unwinds EL2) or in a
> non-preemptible section (pKVM, where the whole thing is
> non-preemptible). But the kernel is usually preemptible, so this patch
> needs fixing.
>
> I'll see if I can address it locally (I'm currently moving things
> around, stay tuned).

Hi Marc,

You are right it changes the order of the checks. I think the simplest
way then is to drop this patch, and replace uses of on_accessible
_stack_common().

Thanks,
Kalesh

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

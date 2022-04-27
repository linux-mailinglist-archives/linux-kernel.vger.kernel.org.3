Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018E85117A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiD0Maz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiD0Mas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:30:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A74AE12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:27:35 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id w187so3086160ybe.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjpx2T5yzcLE2/+jTUfdNrrPpOB1Xc2EmCzrb/sNyOE=;
        b=GltEs0HXUJeHcltZXUcpiLVY64+1cp8pFtNVvPFE+16mhnWjwVDe5r3tTMSC1YrE4T
         xEttLAk+6PuoRUyJO3lf1IwiSZHT3/+IlVGcTPOHXVDUeo9JYElTD2AWISIAnMEc0HGv
         iYfUChIsQ0Gx4ir6nq4UYk4M/v2DpdumA3I+egZwPbQAMqKFntVwO/HaeZCxVmo1J+Rg
         Q0qqrhIkEnuSwW5BEX/qi+aL6BTN8bqqFPKVLU8cmzOUN7StRfL3KkqqqnyjRS6zmaiU
         AhV2cPuD2viI9JuOdwuLX4Eou9sGmFI8Y1wncgNtpbL3r1XlTL79TQ7sP/qvOCehAEea
         GxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjpx2T5yzcLE2/+jTUfdNrrPpOB1Xc2EmCzrb/sNyOE=;
        b=kGlegyM68lyFFQ8/exj5nBzIXTDvaz8vM6/3wvRaeXGr/rVQ7hqQWxgmDFmo+sd2Wr
         9zCHtSvD7CNKViblVYZQVxk8CK4+gmkcGbA3WhpDC207Zhgm2YQ9lnB6/R77u/ZBYpwV
         kY6m059v5mmnFXDJAVral+aWQCFqJ8A7EpVGA+F3zqp3tdc4R7FPCXOpsEO1ZsOJBM42
         jxvXe4t8F73qNiyRNuHdJTb95tRcpjJAbJi8oaRovrNMrCkTYl43QsmXCDGN+wJ1Vodm
         fIF4+b8VSTP0kDEpsGgBa6bzWcJr03TBY3b747g+Y2DuQTaN8bUvYus8pfZeYa+S+TMw
         PUMw==
X-Gm-Message-State: AOAM532DlWb89VpdV5RfP2UL+TkioMOe+Hc6XZm/Ba86W24FzXNKs+l2
        qNTYO8W1BSSeT+ouIh+llGcnkIxVRWHATGMxmuqb6+7gkNTJ5w==
X-Google-Smtp-Source: ABdhPJyi/3RI8z7glyPjoKrS1UhyF9TcvF3SdGh5H5K5LoiWzNRrg19aDAFifM6Mk8TUJJSGfPHg7GZaESPrqs4lS78=
X-Received: by 2002:a5b:5c4:0:b0:644:dec5:53d1 with SMTP id
 w4-20020a5b05c4000000b00644dec553d1mr26476481ybp.1.1651062454334; Wed, 27 Apr
 2022 05:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220426134924.736104-1-jun.miao@intel.com> <9c951fe6-d354-5870-e91b-83d8346ac162@intel.com>
In-Reply-To: <9c951fe6-d354-5870-e91b-83d8346ac162@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 27 Apr 2022 14:26:58 +0200
Message-ID: <CANpmjNNxOX12NcMjXJr3XWcoe6d+Dp74pR+2naVW0anwcYfmoQ@mail.gmail.com>
Subject: Re: [PATCH] irq_work: Make irq_work_queue_on() NMI-safe again
To:     Jun Miao <jun.miao@intel.com>
Cc:     ryabinin.a.a@gmail.com, Dmitry Vyukov <dvyukov@google.com>,
        bigeasy@linutronix.de, qiang1.zhang@intel.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        andreyknvl@gmail.com, ying.huang@intel.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
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

On Wed, 27 Apr 2022 at 03:49, Jun Miao <jun.miao@intel.com> wrote:
>
> Add  To/Cc : KASAN/MEM , since I only used the scripts/get_maintainer.pl
> to irq_work.c file.
>
> Thanks
> Jun Miao
>
>
> On 2022/4/26 21:49, Jun Miao wrote:
> > We should not put NMI unsafe code in irq_work_queue_on().
> >
> > The KASAN of kasan_record_aux_stack_noalloc() is not NMI safe. Because which
> > will call the spinlock. While the irq_work_queue_on() is also very carefully
> > carafted to be exactly that.

"crafted"

> > When unable CONFIG_SM or local CPU, the irq_work_queue_on() is even same to

CONFIG_SM -> CONFIG_SMP

> > irq_work_queue(). So delete KASAN instantly.
> >
> > Fixes: e2b5bcf9f5ba ("irq_work: record irq_work_queue() call stack")
> > Suggested by: "Huang, Ying" <ying.huang@intel.com>
> > Signed-off-by: Jun Miao <jun.miao@intel.com>

I thought this had already been removed, but apparently there were 2
places: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=156172a13ff0626d8e23276e741c7e2cb2f3b572

Acked-by: Marco Elver <elver@google.com>

> > ---
> >   kernel/irq_work.c | 3 ---
> >   1 file changed, 3 deletions(-)
> >
> > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > index 7afa40fe5cc4..e7f48aa8d8af 100644
> > --- a/kernel/irq_work.c
> > +++ b/kernel/irq_work.c
> > @@ -20,7 +20,6 @@
> >   #include <linux/smp.h>
> >   #include <linux/smpboot.h>
> >   #include <asm/processor.h>
> > -#include <linux/kasan.h>
> >
> >   static DEFINE_PER_CPU(struct llist_head, raised_list);
> >   static DEFINE_PER_CPU(struct llist_head, lazy_list);
> > @@ -137,8 +136,6 @@ bool irq_work_queue_on(struct irq_work *work, int cpu)
> >       if (!irq_work_claim(work))
> >               return false;
> >
> > -     kasan_record_aux_stack_noalloc(work);
> > -
> >       preempt_disable();
> >       if (cpu != smp_processor_id()) {
> >               /* Arch remote IPI send/receive backend aren't NMI safe */
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/9c951fe6-d354-5870-e91b-83d8346ac162%40intel.com.

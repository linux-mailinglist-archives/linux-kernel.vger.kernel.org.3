Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE460523E43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbiEKUCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbiEKUCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:02:11 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B16350A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:02:10 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so1217674ote.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=ZiUnLeYbAAtBNeslKJ9kDfYPeiKddn2ujL9ZO9dbSss=;
        b=bD2jJUxhWqh1lySszIE6XLnaP0Rc3hQKNhJYPj+1QAWKz166Ne05+bVaF9Ip0b6RNp
         39+W5UNlxspOsU6LgoLlexDdWL8RmmShTWAPFeqztyIjMs6ce3dbUqnfajF+meUDTiBj
         mgkc3OkV+pyIX2EXl8ByYXT+ExNA+K16yEWXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=ZiUnLeYbAAtBNeslKJ9kDfYPeiKddn2ujL9ZO9dbSss=;
        b=452Xo4yd1dn5tryrlf5Sa0D4ZWKObOUSWeCXU+101Rh3BaXveVAydr9K3pOAO/m6Xn
         3N/SAqQWY3COvGUSkK2t6NHRdDT0FsZ4qazyhTNSXRmfd7qAHGMRzKm+qZ+M+XO8fjSa
         qCZ6qZ6gCUqrBhdIAlB84Q2TYfXpUoTz2ADVeNsqSzjqL8wTFLgg2/w7rjojuvlHiWNU
         PnAd6PgolqF/uzPJSQg++mjoeh0sUZghFUnfFqtuOnz6DyWRQzwzh8h+/pHFXw2hkUE3
         ZC22htdsWoe6qTZS7KwnfE0spuQCCIbMm9hZhZRtZb+45vtNZl1lu7824UGtejtCndv3
         iJ6A==
X-Gm-Message-State: AOAM5337JDOF8uDlUeOAbyDoxfoS6oPX/KkeD9vnqJMythDHNWL28i37
        PYo5XZ0dlq6qbcvX01RAGv/ZXvG5WXlcU2nHVjuc7Q==
X-Google-Smtp-Source: ABdhPJzQSi37hJE4uy4An6c89r8omucO8AAe2OanTEc2+fADtdfeWbzQmb0Q/jsDaV/PniOYPvDHQ45PkpNAOpxBjrQ=
X-Received: by 2002:a05:6830:13ce:b0:606:702b:87f0 with SMTP id
 e14-20020a05683013ce00b00606702b87f0mr8503289otq.159.1652299330101; Wed, 11
 May 2022 13:02:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 May 2022 13:02:09 -0700
MIME-Version: 1.0
In-Reply-To: <87sfphpwvy.ffs@tglx>
References: <20220504223148.644228-1-swboyd@chromium.org> <87sfphpwvy.ffs@tglx>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 11 May 2022 13:02:09 -0700
Message-ID: <CAE-0n51KTiQjVqJgFe3S9qCiTM+2jdqyVZ1trNO1KanbQJccyA@mail.gmail.com>
Subject: Re: [PATCH] timers: Provide a better debugobjects hint for delayed works
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Gleixner (2022-05-10 02:20:01)
> On Wed, May 04 2022 at 15:31, Stephen Boyd wrote:
> > ---
> > I have an alternative approach which is to treat delayed works with a
> > different debug_obj_descr structure but it basically boils down to
> > another version of timer debugobjects in the workqueue code. The idea is
> > to make the delayed work active once the timer is queued and then
> > convert it over from a delayed work descriptor to a work descriptor once
> > the timer runs delayed_work_timer_fn() or when we pull it off to flush
> > out.
>
> Nah.

:)

>
> >  #include <linux/uaccess.h>
> >  #include <asm/unistd.h>
> > @@ -617,7 +618,17 @@ static const struct debug_obj_descr timer_debug_descr;
> >
> >  static void *timer_debug_hint(void *addr)
> >  {
> > -     return ((struct timer_list *) addr)->function;
> > +     struct timer_list *timer = addr;
> > +
> > +     if (timer->function == delayed_work_timer_fn) {
> > +             struct delayed_work *dwork;
> > +
> > +             dwork = container_of(timer, struct delayed_work, timer);
> > +
> > +             return dwork->work.func;
> > +     }
>
> The same issue exists for kthread_delayed_work_timer_fn.
>
> So maybe something like the uncompiled/untested below.

Cool. Looks good to me. One problem below.

>
> Thanks,
>
>         tglx
> ---
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -638,9 +638,35 @@ static void internal_add_timer(struct ti
>
>  static const struct debug_obj_descr timer_debug_descr;
>
> +struct timer_hint {
> +       void    (*function)(struct timer_list *);
> +       long    offset;
> +};
> +
> +#define TIMER_HINT(fn, container, timr, hintfn)                        \
> +       {                                                       \
> +               .function = fn,                                 \
> +               .offset   = offsetof(container, hintfn) -       \
> +                           offsetof(container, timr)   \
> +       }
> +
> +static const struct timer_hint timer_hints[] = {
> +       TIMER_HINT(delayed_work_timer_fn,
> +                  struct delayed_work, timer, work.func),
> +       TIMER_HINT(kthread_delayed_work_timer_fn,
> +                  struct kthread_delayed_work, timer, work.func),
> +};
> +
>  static void *timer_debug_hint(void *addr)
>  {
> -       return ((struct timer_list *) addr)->function;
> +       struct timer_list *timer = addr;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(timer_hints); i++) {
> +               if (timer_hints[i].function == timer->function)
> +                       return addr + timer_hints[i].offset;

This locates the correct address of the function pointer 'work.func' but
it needs to be dereferenced to return the function's address instead of
the pointer to the function. We don't really care about the function
signature so we could cast it to a void function pointer and deref:

                      void (**fn)(void) = addr + timer_hints[i].offset;

		      return *fn;

I'll send this version of the patch.

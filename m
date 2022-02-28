Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7AD4C6E29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbiB1N25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiB1N2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:28:54 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F094436303
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:28:15 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u7so17350078ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z95cF48vKkHrrcUfc8C+R6WNLcHc8VGni046CUf80ko=;
        b=EuLfa53u8OUzG+YbGwJE+kA+/HV7IWKx5amvI/SrfXXY4XwAAoEJ32CYLBx+Vdmq5H
         k066NxXDATnP3H7xqKbq7xMFs7e0GCQCG3bAxIsH3vmROv4Ls+cnpdLtuJbFB/HprhFR
         jW+N0OHOYji/PcDdbwhoWNe3fErvzOQtqfqwj19YnLpmzjEeJkXW9MuJ/jH5kXe9zj5w
         Ps/oXr/ULMKkr9p9+PT8huh3FEbEjCXrDCCEyiztgRy5iQCddARFIZUMZEX+5IiK3+Qq
         sD2rZ6sxF2S1oVw1XgMIOuDq33ObIlThjsoC9ghq5IbFpgLz9Twcj8jjTk13qmEB0ccP
         wohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z95cF48vKkHrrcUfc8C+R6WNLcHc8VGni046CUf80ko=;
        b=Ue6aXmoGHSR1VRzCuv1/W5EFVGdfj08TST43DOKcw3QzVmPT5rM1F/z13NTKG2Nn2a
         HtievYF7DRlSFtntvqHaCRRyn2pm97yJgEhDSS2d+991zk97Oi4UQMpSUQbwQhY2tI01
         Mw+ShTYaihMrATVbCgUepKwbainGm3jryhgJpURPyM930YKyH4OmkhPtPz65MUYVrpyS
         IkWcHxYpbRd+8flY/PocJ4EI7BWdcM5Uj63oDFASk5YzFkECwL28XzRFe7muK0FArZQl
         V0zxJt5EWGpdQqPXkcVvBwUjt47GOLrGAL5qweUT2/YD9BKDmOtBp/gpfee8zFc7c0Ey
         d8Aw==
X-Gm-Message-State: AOAM5302WBEqzpx9zY2lrmF1DvWFkytF5VdeCbuPnB0QO3ARpCVArrca
        sQpOBHXztz/0DGxV6uXyiQiWI8woWlK02POa1/WwKg==
X-Google-Smtp-Source: ABdhPJwaUVVHNGdaO/Krh/XriRHNGuiNqCYK9mJmJyceWKMVKRYCq5S6hcUkZlOyPEWYg0mbqLpEPwwACXwZohGYh+U=
X-Received: by 2002:a05:651c:b8c:b0:246:c5c:84d7 with SMTP id
 bg12-20020a05651c0b8c00b002460c5c84d7mr14053716ljb.15.1646054894256; Mon, 28
 Feb 2022 05:28:14 -0800 (PST)
MIME-Version: 1.0
References: <20220228075351.1412452-1-sumit.garg@linaro.org> <Yhy7AnwEMqbcKsEg@hirez.programming.kicks-ass.net>
In-Reply-To: <Yhy7AnwEMqbcKsEg@hirez.programming.kicks-ass.net>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 28 Feb 2022 18:58:03 +0530
Message-ID: <CAFA6WYN1XOxuVZscd1=oovE7Cf8UZxySYq4Lp=QSsFDndYSNUA@mail.gmail.com>
Subject: Re: [RFT v2] tty/sysrq: Make sysrq handler NMI aware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-serial@vger.kernel.org, hasegawa-hitomi@fujitsu.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thanks for your review.

On Mon, 28 Feb 2022 at 17:37, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 01:23:51PM +0530, Sumit Garg wrote:
> > Allow a magic sysrq to be triggered from an NMI context. This is done
>
> *why* though?
>

I should have copied the reasoning from v1 cover letter [1] to this
single patch as well. Will do it in v3. The basic idea is to enhance
kernel's NMI debuggability for CPUs stuck in hard lockups. As an
example, one should be able to launch kdb as well as other diagnostics
offered by magic sysrq in NMI context.

[1] https://lore.kernel.org/linux-arm-kernel/1595333413-30052-1-git-send-email-sumit.garg@linaro.org/

>
> > +#define SYSRQ_NMI_FIFO_SIZE  2
> > +static DEFINE_KFIFO(sysrq_nmi_fifo, int, SYSRQ_NMI_FIFO_SIZE);
> > +
> > +static void sysrq_do_nmi_work(struct irq_work *work)
>
> That naming don't make sense, it does the !NMI work, from IRQ context.
>

Will rename it to sysrq_do_irq_work().

> > +{
> > +     const struct sysrq_key_op *op_p;
> > +     int orig_suppress_printk;
> > +     int key;
> > +
> > +     orig_suppress_printk = suppress_printk;
> > +     suppress_printk = 0;
> > +
> > +     rcu_sysrq_start();
> > +     rcu_read_lock();
> > +
> > +     if (kfifo_peek(&sysrq_nmi_fifo, &key)) {
> > +             op_p = __sysrq_get_key_op(key);
> > +             if (op_p)
> > +                     op_p->handler(key);
> > +     }
> > +
> > +     rcu_read_unlock();
> > +     rcu_sysrq_end();
> > +
> > +     suppress_printk = orig_suppress_printk;
> > +
> > +     kfifo_reset_out(&sysrq_nmi_fifo);
> > +}
> > +
> > +static DEFINE_IRQ_WORK(sysrq_nmi_work, sysrq_do_nmi_work);
> > +
> >  void __handle_sysrq(int key, bool check_mask)
> >  {
> >       const struct sysrq_key_op *op_p;
> > @@ -573,6 +612,10 @@ void __handle_sysrq(int key, bool check_mask)
> >       int orig_suppress_printk;
> >       int i;
> >
> > +     /* Skip sysrq handling if one already in progress */
> > +     if (!kfifo_is_empty(&sysrq_nmi_fifo))
> > +             return;
> > +
> >       orig_suppress_printk = suppress_printk;
> >       suppress_printk = 0;
> >
> > @@ -596,7 +639,13 @@ void __handle_sysrq(int key, bool check_mask)
> >               if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
> >                       pr_info("%s\n", op_p->action_msg);
> >                       console_loglevel = orig_log_level;
> > -                     op_p->handler(key);
> > +
> > +                     if (in_nmi() && !op_p->nmi_safe) {
> > +                             kfifo_put(&sysrq_nmi_fifo, key);
> > +                             irq_work_queue(&sysrq_nmi_work);
> > +                     } else {
> > +                             op_p->handler(key);
> > +                     }
> >               } else {
> >                       pr_info("This sysrq operation is disabled.\n");
> >                       console_loglevel = orig_log_level;
>
> I'm missing the point of that kfifo stuff; afaict it only ever buffers
> _1_ key, might as well use a simple variable, no?

Yeah you are right, using a single key buffer should also suffice. The
original idea was to queue multiple sysrq and handle them one by one
but that turned out to be unsafe.

-Sumit

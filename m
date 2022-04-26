Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668B650FB26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344376AbiDZKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349269AbiDZKmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:42:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D730A46148;
        Tue, 26 Apr 2022 03:32:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v4so9212388ljd.10;
        Tue, 26 Apr 2022 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP7qNcE96rh3aiNPjgVaxIOFTXHJAqHcEpaQTLvanoI=;
        b=Y59N8y17Vbl4NhX0BsB33EV/X+rvpk/NNSugoP5njpF5uQjXhsNgWY2harTHY/tMF2
         P3//Fpb1MgAh50xD3+IMALsfMW+Ky/5LlY8BECBihqaEwCAlaSyflzhjEmX3fkZv8oPj
         9ske0pePjn1aqsTsT5WoThPOte7PJV5/1e6ZduSFQ082vSJQumCE8Y64Gvf6qh0nyrL1
         bNLV+7fz1rehudTTXcmoT6SLHkNyumQbmsJAxJPmER8Ssnyhu+nnH8r1QRbjGeoOzhU5
         wEtBLdeqHLaphKK+CoqKMrBJ56bUhfv9R7GUnFjXPeUhZlkx6ToVusAaGb+RIfB/YKZm
         fAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP7qNcE96rh3aiNPjgVaxIOFTXHJAqHcEpaQTLvanoI=;
        b=sx1chbvDx/gVV2AQc+0HN1i4itN0DgP1P+qYGvVQeGMEStCtk+oYxb/ZWEj19W/Iqb
         7DaapZSyXKR54lSmWXVD2eYhGkSWG79ooMX0nvm4+0ZJm3Q/bIDifmgpSkEnmzsucTQj
         cenuZjJktZjUlMjv+gOvBxAU9llyNJUP5rUc4XIAzBK8Ur+KNtnqmrIFpCvdkWOkPPn9
         8s+ulbs5j/UNPzQqWLTUjOiNZY+SDRZvQ1NxmMN4/g/prC6Lpb6ZjkKfFLXLYzjDDDVu
         o+22P9vHQswirX3Kc2Y2gcaGTJAnnCSihVvZcpRYHo+Jw0+ry8O8Wd7QXv0N7Ns2DlH8
         EPIA==
X-Gm-Message-State: AOAM5324zp0BWC/4QG+csw3BnMhsUm9dMQvBYs8veqVo+oUWu1nOmk21
        7kegcp8euNcy5yRwoGp5kB77y0P6QeV9/IigHbcotaoW
X-Google-Smtp-Source: ABdhPJzc+weA3nqtPRODDnqfI0mQewWDwH5gcmcewkNJO2LGeK46hVKvJ71mJbsWACMlww+puXyaBk2U5lSFDPvyO1U=
X-Received: by 2002:a05:651c:889:b0:24f:2336:1b95 with SMTP id
 d9-20020a05651c088900b0024f23361b95mr728186ljq.345.1650969135974; Tue, 26 Apr
 2022 03:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220423102844.1371595-1-patrick.wang.shcn@gmail.com> <20220425105600.722b1345@gandalf.local.home>
In-Reply-To: <20220425105600.722b1345@gandalf.local.home>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Tue, 26 Apr 2022 18:32:04 +0800
Message-ID: <CAGcnep_L0EFaRwEXN-wdt5pGDrFK2Vi3j42GCJscUtLcXXFa7Q@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: ftrace: avoid tracing a few functions executed in
 stop machine
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 10:56 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 23 Apr 2022 18:28:44 +0800
> Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
>
> > Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> > ---
> > v1->v2:
> >  - Modify log message.
> >
> >  kernel/rcu/tree_plugin.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index c8ba0fe17267..971bb6a00ede 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -460,7 +460,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
> >   * be quite short, for example, in the case of the call from
> >   * rcu_read_unlock_special().
> >   */
> > -static void
> > +notrace static void
>
> I'm fine with the change, but to be consistent with the rest of the kernel,
> static needs to come before notrace.
>
> Either:
>
>  static notrace void
>
> or even (some places have):
>
>   static void notrace
>
> but "static" should always be first.
>

Thank you for the detailed advice. I will move "notrace" to behind "static".

Thanks,
Patrick

>
>
> >  rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >  {
> >       bool empty_exp;
> > @@ -581,7 +581,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
> >   * is disabled.  This function cannot be expected to understand these
> >   * nuances, so the caller must handle them.
> >   */
> > -static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> > +notrace static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> >  {
> >       return (__this_cpu_read(rcu_data.cpu_no_qs.b.exp) ||
> >               READ_ONCE(t->rcu_read_unlock_special.s)) &&
> > @@ -595,7 +595,7 @@ static bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> >   * evaluate safety in terms of interrupt, softirq, and preemption
> >   * disabling.
> >   */
> > -static void rcu_preempt_deferred_qs(struct task_struct *t)
> > +notrace static void rcu_preempt_deferred_qs(struct task_struct *t)
> >  {
> >       unsigned long flags;
> >
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7D5483F8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbiFMJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239330AbiFMJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:47:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC42C17E0D;
        Mon, 13 Jun 2022 02:47:28 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g2so5558450ljk.5;
        Mon, 13 Jun 2022 02:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ei/MAvv0B3gDXqpc/eelqxW8j2ocxW4IcrNXCdHzmoc=;
        b=nLtgU8NhLHMO0esraVqskYzuHwgdIbAedhpn0gBuCDAMYv6RrCVwov5K1Rb76fkM91
         +IUWu7X9iZn0OFM7GXHTUT493v+KeBR5dkdr2P3Isuw7VjAVqE7uMSRxrUk7nQq5lHHC
         15lNx9pkycYpyjSYczY2Mx4AedEbGanBnjWUNv+KCkVSkkqHbl2MM9mmP+AuMSYiUvtJ
         9lEcuoKNbPKJEjWEpjTyzXQGSPKsyw4NT1mxK+WuFgnLaF4Pd1FfQSSArgnu8FpAQ7CW
         vWFPUdV2K2bdF5aq0XkIOsA0BpMUAw+hco0CRHryeCgOk16PU+SD1TTh8s784yKVeZ9+
         6PcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ei/MAvv0B3gDXqpc/eelqxW8j2ocxW4IcrNXCdHzmoc=;
        b=wk4xPstpzSDUUFeHoxsOmfIf/9hmHf2+Nles2v/kgl4WK2a/4SdP7fiAFmKGLc35u3
         Sj/ATKE4ajwh229QwrFsn/2f9wFD55ZfixaQtYuz98/L6aRWzUPG8klGGfFaMKmNcnhm
         R9OF5IeM6O1DhkY8aiyuiivm8bOCJVvxbMM24XRCJgXfHesfRJ6+OyI0OxVWTlrs30Vt
         vYglUTtOLQXm4AtE2Z1wW8Mih/B9oIP+GAKjYyEUh0YyDGGEAgxMpC+7omAhj2iGE3Hb
         a9eettgwzfYYJRUHEJs15uT6H/lDUlonWmmYqPhZBKbEs+V1WouLqEvMdNuTJaWlA6sS
         MmRg==
X-Gm-Message-State: AOAM530QblfK3RFQqjPRF8qqBQy+ug0FUybjsEJw8+eRtFqEFg4af3VI
        wFI8i2Vk1BAp3hI+JQ719xM=
X-Google-Smtp-Source: ABdhPJzyR3KFaZinkQleKOAwDelKko+1gehs2RlAAHdpUf4tAGOqz9KddIXsOmxwafkLLWranQUugg==
X-Received: by 2002:a05:651c:b10:b0:255:7bfa:6b5d with SMTP id b16-20020a05651c0b1000b002557bfa6b5dmr26703808ljr.226.1655113646865;
        Mon, 13 Jun 2022 02:47:26 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id e27-20020a19691b000000b00479025bafb5sm920519lfc.301.2022.06.13.02.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 02:47:26 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 13 Jun 2022 11:47:24 +0200
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN]
 interval
Message-ID: <YqcHrIMefthWe0t4@pc638.lan>
References: <20220602080644.432156-1-urezki@gmail.com>
 <20220602080644.432156-2-urezki@gmail.com>
 <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpxzB3/HRN/EEHa8@pc638.lan>
 <20220607034710.GE1790663@paulmck-ThinkPad-P17-Gen-1>
 <CA+KHdyXU1apQQbVVZ_zX7o86Qp-AQnif2u8aJFULqHNtfCGcSA@mail.gmail.com>
 <YqN1QqRmPpchDm/k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqN1QqRmPpchDm/k@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Joel, Paul.

> Hi Vlad, Paul,
> 
> On Thu, Jun 09, 2022 at 03:10:57PM +0200, Uladzislau Rezki wrote:
> > On Tue, Jun 7, 2022 at 5:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Jun 05, 2022 at 11:10:31AM +0200, Uladzislau Rezki wrote:
> > > > > On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > > > > > Currently the monitor work is scheduled with a fixed interval that
> > > > > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > > > > a low utilization of page slot in some scenarios. The page can store
> > > > > > up to 512 records. For example on Android system it can look like:
> > > > > >
> > > > > > <snip>
> > > > > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > > > > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > > > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > > > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > > > > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > > > > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > > > > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > > > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > > > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > > > > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > > > > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > > > > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > > > > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > > > > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > > > > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > > > > <snip>
> > > > > >
> > > > > > where a page only carries few records to reclaim a memory. In order to
> > > > > > improve batching and make utilization more efficient the patch introduces
> > > > > > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > > > > > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > > > > > case a memory reclaim occurs more often whereas in mostly idle cases the
> > > > > > interval is set to its maximum timeout that improves the utilization of
> > > > > > page slots.
> > > > > >
> > > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > >
> > > > > That does look like a problem well worth solving!
> > > > >
> > > > Agree, better ideas make better final solution :)
> > > >
> > > > >
> > > > > But I am missing one thing. If we are having a callback flood, why do we
> > > > > need a shorter timeout?
> > > > >
> > > > To offload faster, because otherwise we run into classical issue, it is a low
> > > > memory condition state resulting in OOM.
> > >
> > > But doesn't each callback queued during the flood give us an opportunity
> > > to react to the flood?  That will be way more fine-grained than any
> > > reasonable timer, right?  Or am I missing something?
> > >
> > We can set the timer to zero or to current "jiffies" to initiate the
> > offloading if the
> > page is full. In that sense probably it make sense to propagate those two attr.
> > to user space, so the user can configure min/max drain interval.
> > 
> > Or we can only deal with fixed interval exposed via sysfs to control it by user.
> > In that case we can get rid of MIN one and just trigger a timer if the page is
> > full. I think this approach is better.
> 
> Yes I also think triggering timer with zero-timeout is better. Can you (Vlad)
> accomplish that by just calling the timer callback inline, instead of queuing
> a timer? I imagine you would just do queue_work() instead of
> queue_delayed_work() in this scenario.
> 
> > > I do agree that the action would often need to be indirect to avoid the
> > > memory-allocation-state hassles, but we already can do that, either via
> > > an extremely short-term hrtimer or something like irq-work.
> > >
> > > > > Wouldn't a check on the number of blocks queued be simpler, more direct,
> > > > > and provide faster response to the start of a callback flood?
> > > > >
> > > > I rely on krcp->count because not always we can store the pointer in the page
> > > > slots. We can not allocate a page in the caller context thus we use page-cache
> > > > worker that fills the cache in normal context. While it populates the cache,
> > > > pointers temporary are queued to the linked-list.
> > > >
> > > > Any thoughts?
> > >
> > > There are a great many ways to approach this.  One of them is to maintain
> > > a per-CPU free-running counter of kvfree_rcu() calls, and to reset this
> > > counter each jiffy.
> > >
> > > Or am I missing a trick here?
> > >
> > Do you mean to have a per-cpu timer that checks the per-cpu-freed counter
> > and schedule the work when if it is needed? Or i have missed your point?
> 
> I think he (Paul) is describing the way 'flood detection' can work similar to how the
> bypass list code is implemented. There he maintains a count which only if
> exceeds a limit, will queue on to the bypass list.
> 
OK, i see that. We also do similar thing. We say it is a flood - when a
page becomes full, so it is kind of threshold that we pass.

> This code:
> 
>         // If we have advanced to a new jiffy, reset counts to allow
>         // moving back from ->nocb_bypass to ->cblist.
>         if (j == rdp->nocb_nobypass_last) {
>                 c = rdp->nocb_nobypass_count + 1;
>         } else {
>                 WRITE_ONCE(rdp->nocb_nobypass_last, j);
>                 c = rdp->nocb_nobypass_count - nocb_nobypass_lim_per_jiffy;
>                 if (ULONG_CMP_LT(rdp->nocb_nobypass_count,
>                                  nocb_nobypass_lim_per_jiffy))
>                         c = 0;
>                 else if (c > nocb_nobypass_lim_per_jiffy)
>                         c = nocb_nobypass_lim_per_jiffy;
>         }
>         WRITE_ONCE(rdp->nocb_nobypass_count, c);
> 
> 
> Your (Vlad's) approach OTOH is also fine to me, you check if page is full and
> make that as a 'flood is happening' detector.
> 
OK, thank you Joel. I also think, that way we improve batching and utilization
of the page what is actually an intention of the patch in question.

--
Uladzislau Rezki

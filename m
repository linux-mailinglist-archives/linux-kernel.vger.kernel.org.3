Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC6B544D30
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiFINLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244104AbiFINLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:11:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3383113392C;
        Thu,  9 Jun 2022 06:11:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o7so14094048eja.1;
        Thu, 09 Jun 2022 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wAwQz6C+ZpVqaDsOvtWkiMwlkZyhViIBwL5COqW1+Y=;
        b=DfxxG8+SFT1aRPK8Tf6WWRloDCFsXBHC4HaWPyvJeqzEtPjs+G8TMtrYGSkwP4k2AG
         X2ggQhZIyK0peDiA8p9DnEwZGEJGSzjulxAvJR1Y8++Fb/C7l9w5hOxyiSvJmjYCeZRa
         E2ea+jdtqu87sZFGo5tGQRi/zVGBCFI2057zo5pV8liUF646b2WmsAY0n9DA0pnwi1LC
         E2gw71/oo29WuxTysApvrnh2i5m329H2te/xzjQv1Pb7u1HDdyGau5xWr6Mmeui9W3pL
         lX+NgaBZGCuolnCz4xG82wnO7H9uarEEPUjXdT251CBXIGq1DR0SwoMf85ISFqZ47rLV
         VaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wAwQz6C+ZpVqaDsOvtWkiMwlkZyhViIBwL5COqW1+Y=;
        b=hNaTu2QMnRKAyQl8T81WgoDRjCd9J+0t8xBv+2xYywpCXFq9M1/8KbX4lzV+Jn+7iZ
         5bqRgHaPF1nPcgeAuiPv7Q1u/DUIR7ytjL9TftUYNAr2KmENGZNKQj/csnC6pgb8JL74
         0trpon0eBy86nu3KzYS6pBKOhXXs84VYLeJqGCnu2klO60jy0Ti/cnTfDbxcHITzB6zc
         KRElfg34vaDBRReJo0QZqRGBjIsx/2uwbaMU/L1Hw3oP3sf7lx7Ci52aS8+D24bNbtjM
         mYEsjxof9l8hUcShGWRzcIoxcKpxWCSygOB0EjHkNs59Z1qqoWkMwli6COR53JnPCsCF
         r8sA==
X-Gm-Message-State: AOAM533pzMRMUe+vheDGjNhXjBgmaFjKqpH/PZlX/xM8JnXYg11vC8tu
        qBVnHaJi1tb+qYJKsEM90XGegNpPe/p7giY4ZBsPyvZo3H8=
X-Google-Smtp-Source: ABdhPJw8MLZ71B+p+qbmLV3tlwFIf9HSGvoui9iRj+sWl6mfjkGmIkFa83qvzO2sUT8F9LhUjx+p57vLlPmJk/4k2dM=
X-Received: by 2002:a17:906:c302:b0:6fe:a216:20a4 with SMTP id
 s2-20020a170906c30200b006fea21620a4mr36999962ejz.556.1654780268695; Thu, 09
 Jun 2022 06:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220602080644.432156-1-urezki@gmail.com> <20220602080644.432156-2-urezki@gmail.com>
 <20220604155108.GU1790663@paulmck-ThinkPad-P17-Gen-1> <YpxzB3/HRN/EEHa8@pc638.lan>
 <20220607034710.GE1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220607034710.GE1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Thu, 9 Jun 2022 15:10:57 +0200
Message-ID: <CA+KHdyXU1apQQbVVZ_zX7o86Qp-AQnif2u8aJFULqHNtfCGcSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu/kvfree: Introduce KFREE_DRAIN_JIFFIES_[MAX/MIN] interval
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 5:47 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jun 05, 2022 at 11:10:31AM +0200, Uladzislau Rezki wrote:
> > > On Thu, Jun 02, 2022 at 10:06:44AM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Currently the monitor work is scheduled with a fixed interval that
> > > > is HZ/20 or each 50 milliseconds. The drawback of such approach is
> > > > a low utilization of page slot in some scenarios. The page can store
> > > > up to 512 records. For example on Android system it can look like:
> > > >
> > > > <snip>
> > > >   kworker/3:0-13872   [003] .... 11286.007048: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=1
> > > >   kworker/3:0-13872   [003] .... 11286.015638: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > >   kworker/1:2-20434   [001] .... 11286.051230: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > >   kworker/1:2-20434   [001] .... 11286.059322: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=2
> > > >   kworker/0:1-20052   [000] .... 11286.095295: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=2
> > > >   kworker/0:1-20052   [000] .... 11286.103418: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=1
> > > >   kworker/2:3-14372   [002] .... 11286.135155: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=2
> > > >   kworker/2:3-14372   [002] .... 11286.135198: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000044872ffd nr_records=1
> > > >   kworker/1:2-20434   [001] .... 11286.155377: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=5
> > > >   kworker/2:3-14372   [002] .... 11286.167181: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000026522604 nr_records=5
> > > >   kworker/1:2-20434   [001] .... 11286.179202: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x000000008ef95e14 nr_records=1
> > > >   kworker/2:3-14372   [002] .... 11286.187398: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000c597d297 nr_records=6
> > > >   kworker/3:0-13872   [003] .... 11286.187445: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000050bf92e2 nr_records=3
> > > >   kworker/1:2-20434   [001] .... 11286.198975: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x00000000cbcf05db nr_records=4
> > > >   kworker/1:2-20434   [001] .... 11286.207203: rcu_invoke_kfree_bulk_callback: rcu_preempt bulk=0x0000000095ed6fca nr_records=4
> > > > <snip>
> > > >
> > > > where a page only carries few records to reclaim a memory. In order to
> > > > improve batching and make utilization more efficient the patch introduces
> > > > a drain interval that can be set either to KFREE_DRAIN_JIFFIES_MAX or
> > > > KFREE_DRAIN_JIFFIES_MIN. It is adjusted if a flood is detected, in this
> > > > case a memory reclaim occurs more often whereas in mostly idle cases the
> > > > interval is set to its maximum timeout that improves the utilization of
> > > > page slots.
> > > >
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > >
> > > That does look like a problem well worth solving!
> > >
> > Agree, better ideas make better final solution :)
> >
> > >
> > > But I am missing one thing. If we are having a callback flood, why do we
> > > need a shorter timeout?
> > >
> > To offload faster, because otherwise we run into classical issue, it is a low
> > memory condition state resulting in OOM.
>
> But doesn't each callback queued during the flood give us an opportunity
> to react to the flood?  That will be way more fine-grained than any
> reasonable timer, right?  Or am I missing something?
>
We can set the timer to zero or to current "jiffies" to initiate the
offloading if the
page is full. In that sense probably it make sense to propagate those two attr.
to user space, so the user can configure min/max drain interval.

Or we can only deal with fixed interval exposed via sysfs to control it by user.
In that case we can get rid of MIN one and just trigger a timer if the page is
full. I think this approach is better.

>
> I do agree that the action would often need to be indirect to avoid the
> memory-allocation-state hassles, but we already can do that, either via
> an extremely short-term hrtimer or something like irq-work.
>
> > > Wouldn't a check on the number of blocks queued be simpler, more direct,
> > > and provide faster response to the start of a callback flood?
> > >
> > I rely on krcp->count because not always we can store the pointer in the page
> > slots. We can not allocate a page in the caller context thus we use page-cache
> > worker that fills the cache in normal context. While it populates the cache,
> > pointers temporary are queued to the linked-list.
> >
> > Any thoughts?
>
> There are a great many ways to approach this.  One of them is to maintain
> a per-CPU free-running counter of kvfree_rcu() calls, and to reset this
> counter each jiffy.
>
> Or am I missing a trick here?
>
Do you mean to have a per-cpu timer that checks the per-cpu-freed counter
and schedule the work when if it is needed? Or i have missed your point?

-- 
Uladzislau Rezki

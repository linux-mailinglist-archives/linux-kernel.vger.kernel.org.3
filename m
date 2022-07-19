Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5E5793D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbiGSHIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGSHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:08:29 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7984525C54
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:08:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u13so23250057lfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lessconfused.com; s=lessconfused;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P9ndUylbEEHTjHoq28en556dJRdIZ+/y+Hnq9BsY9H8=;
        b=S5XBWENqM3vl6OFYWkoaOajSjTRKxRmONkoJRKlfRQh5vvzNQq5fmcazdaunOs9tLw
         vpUT94KcdLDM09FISHAYqwdZx/Vp+uUQV0l57l4FxzJCzKfqpDH2H+GaChxbWAN66tkX
         k5AkXfMw7wUWHDpZgfILZlCrR7hOD4QhaXsgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9ndUylbEEHTjHoq28en556dJRdIZ+/y+Hnq9BsY9H8=;
        b=6i89duUCkHscquJXAWJpP54fJxLc+8NY63uOPkebADJqawbQjR+h4f1C87zcpWn+JY
         7eBJriO/bAekvFKb1iCxSQ4LUVbs4rIfAb7tNgBtysQeRXQRg6ioRsfqo73v9ihnWPa+
         PBWytcfluaQhfcUtwZBJIWYLpj8nDTZyOQf1dhWQQqCDGalaC71VimDcd80B34AdPZo5
         z6qEZ3oyg+hDmrMvlpTI7ebUixcvn0VpjnciHQw7L98xO/x7quKPFM5affWqLQDMeXJZ
         2yteLp7aPtjwoKKUMRnDvxX8qZPCAjmGIpWdQYE0izMiQQzDU63lzYxiA0zF7FAGUkq1
         47vQ==
X-Gm-Message-State: AJIora99N5nmzcYrDMZ46FOkwwe1PEY0xMyByuu2/8DP2277XaEWcjSP
        v/34J/eYlkyHAUt2datVfXAjKB9CdU62ty7mzqdHYUHOHizDKZCe
X-Google-Smtp-Source: AGRyM1twKswr6HDu7WxsBe4AnEcqM4vYeP435q5Aai/PK4Px2Y1R87/qd991XfNzPT1RVlmNqXYvHhyNBatOfAiIJ/k=
X-Received: by 2002:a05:6512:2623:b0:47d:ace7:c804 with SMTP id
 bt35-20020a056512262300b0047dace7c804mr17607942lfb.647.1658214506722; Tue, 19
 Jul 2022 00:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200923123916.1115962-1-jbrunet@baylibre.com>
 <20201015134628.GA11989@arm.com> <1jlfg7k2ux.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY1-MBac0e6xQwWkHRo3bqJNMWb4xQzdaGdrYT=n5zRvtw@mail.gmail.com>
 <20201016085217.GA12323@arm.com> <1jk0vqk0ju.fsf@starbuckisacylon.baylibre.com>
 <CABb+yY0pDxQ7B+NPsEz325-_X2nSJngnfER7uOLVyoBLoH37cA@mail.gmail.com>
 <1jft6ej91c.fsf@starbuckisacylon.baylibre.com> <CABb+yY0Ktj9O9YxGDM0q_6MnKPBCopm+RzQa6SM64Pn_60a2pA@mail.gmail.com>
In-Reply-To: <CABb+yY0Ktj9O9YxGDM0q_6MnKPBCopm+RzQa6SM64Pn_60a2pA@mail.gmail.com>
From:   Da Xue <da@lessconfused.com>
Date:   Tue, 19 Jul 2022 03:08:14 -0400
Message-ID: <CACdvmAi=4qneshSgZ8ApD-uwH-JSe5xcO-qOyvFOvoYQ9Nk=mQ@mail.gmail.com>
Subject: Re: [PATCH] mailbox: cancel timer before starting it
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Da Xue <da@libre.computer>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qi Duan <qi.duan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 3:27 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Fri, Oct 16, 2020 at 1:54 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> >
> >
> > On Fri 16 Oct 2020 at 19:33, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >
> > > On Fri, Oct 16, 2020 at 4:00 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > >>
> > >>
> > >> On Fri 16 Oct 2020 at 10:52, Ionela Voinescu <ionela.voinescu@arm.com> wrote:
> > >>
> > >> > On Thursday 15 Oct 2020 at 13:45:54 (-0500), Jassi Brar wrote:
> > >> > [..]
> > >> >> > >> --- a/drivers/mailbox/mailbox.c
> > >> >> > >> +++ b/drivers/mailbox/mailbox.c
> > >> >> > >> @@ -82,9 +82,13 @@ static void msg_submit(struct mbox_chan *chan)
> > >> >> > >>  exit:
> > >> >> > >>      spin_unlock_irqrestore(&chan->lock, flags);
> > >> >> > >>
> > >> >> > >> -    if (!err && (chan->txdone_method & TXDONE_BY_POLL))
> > >> >> > >> -            /* kick start the timer immediately to avoid delays */
> > >> >> > >> +    if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
> > >> >> > >> +            /* Disable the timer if already active ... */
> > >> >> > >> +            hrtimer_cancel(&chan->mbox->poll_hrt);
> > >> >> > >> +
> > >> >> > >> +            /* ... and kick start it immediately to avoid delays */
> > >> >> > >>              hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
> > >> >> > >> +    }
> > >> >> > >>  }
> > >> >> > >>
> > >> >> > >>  static void tx_tick(struct mbox_chan *chan, int r)
> > >> >> > >
> > >> >> > > I've tracked a regression back to this commit. Details to reproduce:
> > >> >> >
> > >> >> > Hi Ionela,
> > >> >> >
> > >> >> > I don't have access to your platform and I don't get what is going on
> > >> >> > from the log below.
> > >> >> >
> > >> >> > Could you please give us a bit more details about what is going on ?
> > >> >> >
> > >> >> > All this patch does is add hrtimer_cancel().
> > >> >> > * It is needed if the timer had already been started, which is
> > >> >> >   appropriate AFAIU
> > >> >> > * It is a NO-OP is the timer is not active.
> > >> >> >
> > >> >> Can you please try using hrtimer_try_to_cancel() instead ?
> > >> >>
> > >> >
> > >> > Yes, using hrtimer_try_to_cancel() instead works for me. But doesn't
> > >> > this limit how effective this change is? AFAIU, this will possibly only
> > >> > reduce the chances for the race condition, but not solve it.
> > >> >
> > >>
> > >> It is also my understanding, hrtimer_try_to_cancel() would remove a
> > >> timer which as not already started but would return withtout doing
> > >> anything if the callback is already running ... which is the original
> > >> problem
> > >>
> > > If we are running in the callback path, hrtimer_try_to_cancel will
> > > return -1, in which case we could skip hrtimer_start.
> > > Anyways, I think simply checking for hrtimer_active should effect the same.
> > > I have submitted a patch, of course not tested.
> >
> > Yes it sloves this race but ...
> >
> Thanks for confirmation.
>
> > If a race is possible between a timer callback rescheduling itself (which
> > is not that uncommon) and another thread trying to cancel it
> >
> In our case, we should not be cancelling+restarting the timer in the
> first place, because txdone_hrtimer will take care of it via
> hrtimer_forward_now.
>
> >, maybe
> > there is something worth fixing in hrtimer ? Also, mailbox calls
> > hrtimer_cancel() in unregister ... are we confident this would work ?
> >
> Yes. After unregister() every channel is supposed to die and so must
> its resources.
>
> -jassi

Hi,

I'm running into an issue where I get "rcu: INFO: rcu_preempt detected
stalls on CPUs/tasks" when booting Linux distributions once every 5 or
so reboots. The system sticks on systemd starting for ~20 seconds
before rcu_preempt prints a message. This only happens on Amlogic (I
tested S805X/S905X/S905D) and I do not get this problem on my
Allwinner or Rockchip boards with the same kernel and image. I have
tried 5.15, 5.18, and 5.19. I dumped a bunch of logs here from the
three kernel versions but the content is the same.
https://github.com/libre-computer-project/libretech-linux/issues/5

+ mount -n -o move /sys /root/sys
+ mount -n -o move /proc /root/proc
+ exec run-init /root /sbin/init
[   26.485689] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   26.486217] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-3): P1
[   26.492332]  (detected by 3, t=5252 jiffies, g=-315, q=546)
[   26.497846] task:run-init        state:R  running task     stack:
 0 pid:    1 ppid:     0 flags:0x00000004
[   26.507719] Call trace:
[   26.510063]  dump_backtrace.part.6+0xdc/0xe8
[   26.514306]  show_stack+0x18/0x68
[   26.517574]  sched_show_task+0x154/0x198
[   26.521461]  rcu_sched_clock_irq+0xd10/0xdd8
[   26.525690]  update_process_times+0x9c/0xd0
[   26.529829]  tick_sched_handle.isra.19+0x34/0x58
[   26.534405]  tick_sched_timer+0x4c/0xa8
[   26.538192]  __hrtimer_run_queues+0x120/0x1b8
[   26.542510]  hrtimer_interrupt+0xd8/0x238
[   26.546474]  arch_timer_handler_phys+0x2c/0x50
[   26.550877]  handle_percpu_devid_irq+0x84/0x138
[   26.555363]  generic_handle_domain_irq+0x2c/0x48
[   26.559935]  gic_handle_irq+0xa4/0xc0
[   26.563549]  call_on_irq_stack+0x2c/0x58
[   26.567432]  do_interrupt_handler+0x80/0x88
[   26.571574]  el1_interrupt+0x38/0x70
[   26.575105]  el1h_64_irq_handler+0x18/0x28
[   26.582437]  el1h_64_irq+0x64/0x68
[   26.585712]  xas_descend+0x0/0x88
[   26.588947]  xas_find+0x190/0x1d8
[   26.592182]  find_lock_entries+0x7c/0x280
[   26.596121]  truncate_inode_pages_range+0xa8/0x490
[   26.600843]  truncate_inode_pages_final+0x58/0x78
[   26.605453]  evict+0x144/0x150
[   26.608471]  iput+0x128/0x190
[   26.611442]  do_unlinkat+0x17c/0x2a8
[   26.614817]  __arm64_sys_unlinkat+0x40/0x88
[   26.618928]  invoke_syscall+0x44/0x100
[   26.622599]  el0_svc_common.constprop.3+0x6c/0xf0
[   26.627237]  do_el0_svc+0x24/0x88
[   26.630473]  el0_svc+0x20/0x60
[   26.633447]  el0t_64_sync_handler+0x90/0xb8
[   26.637562]  el0t_64_sync+0x170/0x174
[   33.757714] VCC_CARD: disabling

I have turned on systemd debug and it does not print anything. The
message is the same every time and I rebuilt the filesystem multiple
times with both ext4 and btrfs roots across the devices.

I'm not sure if this is an extension or corner case of the origin
hr_timer problem. Any ideas?

Best,
Da

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7399580E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbiGZHlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbiGZHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:40:44 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3C2B27F;
        Tue, 26 Jul 2022 00:40:05 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id w22so5337188uau.7;
        Tue, 26 Jul 2022 00:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8kecoQLLBjyBQpahsjlaZYQQejkQugBDOMuuSI4ryNA=;
        b=JR1jd3s+SVEphiA3rb1ouwu/oQWtkFmoBIgpFziPnA8E4IMpkJ/ucnDajAL5QrHgrK
         GwDGN9EukKeY2MqRngiA5WiXP9yn0P8CcipbFapkZ1kcO81PonEFOVfVNGaiwET1OlFx
         PVSbR5WMhG9DSFp56U1EWA6otNudASNMd5V2twIKE2h6/IO01kk8sUWR6anWkpwc9Q9X
         D+tgFROW9GIBcswI2OoN9OearW7LptD/zv1OGsHhqM98Siqs8UfAHnBqn2eqYj8ee4/L
         XeoRF/jHCricSQIZJeLelwW/I0M7/BW9H6qqE/wEUA4uofJHFGw4gnALHQInMBKZjN/U
         JvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8kecoQLLBjyBQpahsjlaZYQQejkQugBDOMuuSI4ryNA=;
        b=NcnExKTj/5E5LrkJqPBfjNKwXvT+/TPEIEhjvMAxIhAw2se2sMLZQ0F70FmkNPkdo5
         UrTTJz7ezxqtE2hxunvtgv8RDZeluemajr/dCcwri4H3+yE7tpS2ojnmZQ0aT+uPUOC6
         Fb5upDVYtFLBRPGkOxxO0lfy/ITmMS4uztueNyW5xK6U2nadpJhC/mkZQPEkHXyahOt7
         JXd9BFludKDV0ninnbgLvOp8m0P/23LVF3SfiGGXhauU7Ejo8UVY926jUDawuuoCFxS+
         ONqNEsyq1xZJ1F9rSPAI+/j0/qQAkA9nmKiuD0ewMXEgWKoJ6Y4PyQQD7IeEZ+M2q8ZA
         TrDg==
X-Gm-Message-State: AJIora9+oJY6qYpuSlM/cayZ3IfQgAkMc+THtdQ7cWWvayCd+wcs3Uor
        zTl2I+thYbVGrEeARd0171SsHmobWG04y2q0h2k=
X-Google-Smtp-Source: AGRyM1uQ9+Q6OJmwpCJxLaiXLP8BFkiRhd9WBYzsiYkAIjWE8nJl8ZwSH2tXtHYFBj0W6GiRc6zgxHB0tK2WWSVYTSg=
X-Received: by 2002:ab0:6183:0:b0:384:7919:f757 with SMTP id
 h3-20020ab06183000000b003847919f757mr4604312uan.25.1658821204135; Tue, 26 Jul
 2022 00:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084314.17816-1-di.shen@unisoc.com> <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
 <12043680.O9o76ZdvQC@kreacher>
In-Reply-To: <12043680.O9o76ZdvQC@kreacher>
From:   Di Shen <cindygm567@gmail.com>
Date:   Tue, 26 Jul 2022 15:39:53 +0800
Message-ID: <CAHYJL4r85vyJ9GukmhVki8EHt2VTAr0549-DA4ND0WGQHWpGqA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group
 before initialized
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Di Shen <di.shen@unisoc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeson.gao@unisoc.com, xuewen.yan@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 2:42 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Friday, July 22, 2022 7:18:42 PM CEST Rafael J. Wysocki wrote:
> > On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
> > >
> > > There's a space allocated for cooling_device_stats_attr_group
> > > within cooling_device_attr_groups. This space is shared by all
> > > cooling devices.
> >
> > That's correct.
> >
> > > If the stats structure of one cooling device successfully
> > > creates stats sysfs. After that, another cooling device fails
> > > to get max_states in cooling_device_stats_setup(). It can
> > > return directly without initializing the stats structure, but
> > > the cooling_device_stats_attr_group is still the attribute
> > > group of the last cooling device.
> >
> > I cannot parse the above, sorry.
> >
> > For example, how can a "stats structure of one cooling device" create
> > anything?   As a data structure, it is a passive entity, so it doesn't
> > carry out any actions.
> >
> > I think (but I am not sure) that you are referring to the error code
> > path in which the ->get_max_state() callback fails for a cooling
> > device after cooling_device_stats_setup() has completed successfully
> > for another one.
> >
> > > At this time, read or write stats sysfs nodes can cause kernel
> > > crash. Like the following, kernel crashed when
> > > 'cat time_in_state_ms'.
> > >
> > > [<5baac8d4>] panic+0x1b4/0x3c8
> > > [<9d287b0f>] arm_notify_die+0x0/0x78
> > > [<094fc22c>] __do_kernel_fault+0x94/0xa4
> > > [<3b4b69a4>] do_page_fault+0xd4/0x364
> > > [<23793e7a>] do_translation_fault+0x38/0xc0
> > > [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> > > [<a28c16b8>] __dabt_svc+0x5c/0xa0
> > > [<747516ae>] _raw_spin_lock+0x20/0x60
> > > [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> > > [<cb78325e>] dev_attr_show+0x38/0x64
> > > [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> > > [<c0a843ab>] seq_read+0x244/0x620
> > > [<b316b374>] vfs_read+0xd8/0x218
> > > [<3aebf5fa>] sys_read+0x80/0xe4
> > > [<7cf100f5>] ret_fast_syscall+0x0/0x28
> > > [<08cbe22f>] 0xbe8c1198
> > >
> > > stats sysfs:
> > > phone:/sys/class/thermal/cooling_device2/stats # ls
> > > reset  time_in_state_ms  total_trans  trans_table
> > >
> > > The same as cat total_trans, trans_table, and echo reset.
>
> So does the (untested) patch below work too?
>

Yes, I agree with you. I will test it on our platform and give
a reply later. Thanks.

> ---
>  drivers/thermal/thermal_sysfs.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> Index: linux-pm/drivers/thermal/thermal_sysfs.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_sysfs.c
> +++ linux-pm/drivers/thermal/thermal_sysfs.c
> @@ -813,12 +813,13 @@ static const struct attribute_group cool
>
>  static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>  {
> +       const struct attribute_group *stats_attr_group = NULL;
>         struct cooling_dev_stats *stats;
>         unsigned long states;
>         int var;
>
>         if (cdev->ops->get_max_state(cdev, &states))
> -               return;
> +               goto out;
>
>         states++; /* Total number of states is highest state + 1 */
>
> @@ -828,7 +829,7 @@ static void cooling_device_stats_setup(s
>
>         stats = kzalloc(var, GFP_KERNEL);
>         if (!stats)
> -               return;
> +               goto out;
>
>         stats->time_in_state = (ktime_t *)(stats + 1);
>         stats->trans_table = (unsigned int *)(stats->time_in_state + states);
> @@ -838,9 +839,12 @@ static void cooling_device_stats_setup(s
>
>         spin_lock_init(&stats->lock);
>
> +       stats_attr_group = &cooling_device_stats_attr_group;
> +
> +out:
>         /* Fill the empty slot left in cooling_device_attr_groups */
>         var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> -       cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
> +       cooling_device_attr_groups[var] = stats_attr_group;
>  }
>
>  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
>
>
>
--
Best regards,

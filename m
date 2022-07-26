Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2C580DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238046AbiGZHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbiGZHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:34:22 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCD2DA9E;
        Tue, 26 Jul 2022 00:31:59 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id f3so5330024uaq.2;
        Tue, 26 Jul 2022 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyyVAdF3KM6mtQMtcMn31iCQDsAAlD2jZ8xWGRIv5PU=;
        b=IwyEOKsAA76Fy60siGlK0OwG8HyHG8TayGCD0MG+It7DGC/TaW22V0Qg9KLviTx2zm
         CLfl70Qm0rbWLCrvG3+yb8Znr/oHPjPAihh/6hjyEyRwtHXE3iE+MRjnRwvJhXoc9/zp
         imGWu08NIOzF0DmKfWYudtUITdDpW0oT8TGlo9O6WXztlzJLZu+H6DXhyraUNQKJkZPF
         9jFuRYnILPDQ+UzR3khZJuICnZ4fSWHh0dTGaou0m0BeKMoAskD74b6k/lywfZW5epxZ
         zyUkyR2Fqa75hIHbzcNySLLqSTLSC3+U1AvqOUcr72HuQyg8njUV4iZZE6VUUo5qhxzG
         7T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyyVAdF3KM6mtQMtcMn31iCQDsAAlD2jZ8xWGRIv5PU=;
        b=rLJRSV5TlXy35S8C5n/Mdm2wTFQF4zuTz8eo1YlASbLwvlMyrDpKLdn+ddIDzzlKLr
         LnDlw2nmNr8RdDfXuzTyKP8IuNBYTLYvFC5l5ez7txBbSxu/ri0peNhLX/pi6vj4areY
         ZCkbYoboWy0HtseBF681/obN5WK961t+j/B7LR9fIbTl/F6EK5t1dVdyyRXdO9LX7NMc
         iHofAYoNXip04vMDC7VExvMePDeJ2cGX29hJW2pEuZOmVpycVvZprGyVOSgk5+uA76U3
         5WGN9/yL5varIMi/oXzNgthwsx39jU4szkxRDzo3hbppOfBy9He8kMDw1hdpHM2/vGey
         hQ9Q==
X-Gm-Message-State: AJIora9t17IysK8nAVX2cTCIwBNUXsgMO1Uhf3uAL6tvN1tG030K350m
        EReqs0vWGe7TOqWfpETI6tbNQsmTLVMjCKL1uOQ=
X-Google-Smtp-Source: AGRyM1sOUurMoHVkUEPC703t4XC62MULs3Qkjb2anwLDjiHhkS5w/lQ+BLJ6ItS1xeJxPsM/cCJAjsJQv7ByZ6S/6Mk=
X-Received: by 2002:ab0:2b06:0:b0:384:c4af:107c with SMTP id
 e6-20020ab02b06000000b00384c4af107cmr1423097uar.77.1658820719003; Tue, 26 Jul
 2022 00:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084314.17816-1-di.shen@unisoc.com> <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Tue, 26 Jul 2022 15:31:48 +0800
Message-ID: <CAHYJL4qTL8Znw9c1EJGteidh4LWcZe1ei9mOgKtdBfisSKUdmw@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group
 before initialized
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Di Shen <di.shen@unisoc.com>,
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

On Sat, Jul 23, 2022 at 1:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
> >
> > There's a space allocated for cooling_device_stats_attr_group
> > within cooling_device_attr_groups. This space is shared by all
> > cooling devices.
>
> That's correct.
>
> > If the stats structure of one cooling device successfully
> > creates stats sysfs. After that, another cooling device fails
> > to get max_states in cooling_device_stats_setup(). It can
> > return directly without initializing the stats structure, but
> > the cooling_device_stats_attr_group is still the attribute
> > group of the last cooling device.
>
> I cannot parse the above, sorry.
>
> For example, how can a "stats structure of one cooling device" create
> anything?   As a data structure, it is a passive entity, so it doesn't
> carry out any actions.
>

Sorry, I didn't describe it properly. I mean 'if it has been called back
cooling_device_stats_setup() successfully for a cooling device'.

> I think (but I am not sure) that you are referring to the error code
> path in which the ->get_max_state() callback fails for a cooling
> device after cooling_device_stats_setup() has completed successfully
> for another one.
>

That's it. As you say, ->get_max_state() callback fails for a cooling
device after cooling_device_stats_setup() has completed successfully
for another one.

> > At this time, read or write stats sysfs nodes can cause kernel
> > crash. Like the following, kernel crashed when
> > 'cat time_in_state_ms'.
> >
> > [<5baac8d4>] panic+0x1b4/0x3c8
> > [<9d287b0f>] arm_notify_die+0x0/0x78
> > [<094fc22c>] __do_kernel_fault+0x94/0xa4
> > [<3b4b69a4>] do_page_fault+0xd4/0x364
> > [<23793e7a>] do_translation_fault+0x38/0xc0
> > [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> > [<a28c16b8>] __dabt_svc+0x5c/0xa0
> > [<747516ae>] _raw_spin_lock+0x20/0x60
> > [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> > [<cb78325e>] dev_attr_show+0x38/0x64
> > [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> > [<c0a843ab>] seq_read+0x244/0x620
> > [<b316b374>] vfs_read+0xd8/0x218
> > [<3aebf5fa>] sys_read+0x80/0xe4
> > [<7cf100f5>] ret_fast_syscall+0x0/0x28
> > [<08cbe22f>] 0xbe8c1198
> >
> > stats sysfs:
> > phone:/sys/class/thermal/cooling_device2/stats # ls
> > reset  time_in_state_ms  total_trans  trans_table
> >
> > The same as cat total_trans, trans_table, and echo reset.
> >
> > To avoid kernel crash, this patch set clears the
> > cooling_device_attr_groups before stats structure is initialized.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index 1c4aac8464a7..e3fae63fa0f7 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -817,6 +817,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >         unsigned long states;
> >         int var;
> >
> > +       var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> > +       cooling_device_attr_groups[var] = NULL;
> > +
> >         if (cdev->ops->get_max_state(cdev, &states))
> >                 return;
> >
> > --

--
Best regards,
Di



Di

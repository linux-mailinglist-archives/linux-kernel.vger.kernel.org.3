Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE72B557405
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiFWHeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFWHeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:34:22 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54E546658;
        Thu, 23 Jun 2022 00:34:21 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id o13so7259071vsn.4;
        Thu, 23 Jun 2022 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9RiEF1NADhGx2PxZs/J3A5vAnWg7/apg6YcfbCSXo8=;
        b=DZlI8+5UMZ590PJRriJ8e4ClwY1ENK+glrsTUOLzgRYCDJ1ribd0hKS3nht40xRxXW
         p1PXsopchvpzS0xrUjkggItcvVlayXU37uaWXr9Il3piSb8km5QNKz0ZuDQFijACfrYY
         iYbRgs5fnQ/PnR6FgrX9RhdunamTjRdpbFsDBy1iZO00BFhbSQDOonm5pHOTUUisY307
         hyAK46/buxmCSoZgQnU+MNvcVoE/xpU3bAMjmZ2OXBbenPX9gvwd7tq7TLay/wyugl5I
         cLCppWHTk4WkH2p8BS/vB3PBmiTfGq4afIEP95a5CRiAP7mfG3RkRrC/dwePoxfeudjR
         6PtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9RiEF1NADhGx2PxZs/J3A5vAnWg7/apg6YcfbCSXo8=;
        b=oVjzZdwosrNRdQcI6TIA46u9s8QeqkWzWtuLNGyuq2XcENpxHSdtDpgHh4c0yd30px
         XhD+XjziUNXVTxSFI4aWZo+Co3GAXsYehF28zVcOEim07BvrqR1mC+S25+UWrUscoBHl
         N2mNxi/OE22Cnu9bVXuNCi/OCSMVbmxVOUGBj1VeRWdSWuTmU9T3PXqfibSNHrLX0ZoA
         oPDEJq+ZGotACYRTnuBWUZ9tvqIn6M54fvWKki+0RHKFaxRpmxvGaQH5MG0OseEMCmKH
         RgLmgTeZhFqUEM/IwniJgYG5mCZY3omNGhIZlcMNnhYzPul8YHVZavOZz88eTrz2CPvt
         zKhg==
X-Gm-Message-State: AJIora9gDk1nwl0CZnGPRok7cvshmvRll2AOAPavwXt8xIW25iSK9K8f
        zkFCWkiIoGIFrXdUg2yQ7ysWNKfRmKiOcNYCLkPwjZIfepl2zQ==
X-Google-Smtp-Source: AGRyM1vBqJeJTPhynUoDu1+0J1ZVdF+TN1DWWaAqEFy7DurWfQ/vYlx1pf9jOnn8m0RAc5tGG5v7LuIuO8WqywHrhvs=
X-Received: by 2002:a05:6102:34f1:b0:354:64b4:157b with SMTP id
 bi17-20020a05610234f100b0035464b4157bmr3084628vsb.26.1655969660897; Thu, 23
 Jun 2022 00:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220620131953.16575-1-di.shen@unisoc.com> <CAJZ5v0j380_UEsy6qJ_KuRf8YbL3KtiY-h+RdkSsfd8SRCLy_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0j380_UEsy6qJ_KuRf8YbL3KtiY-h+RdkSsfd8SRCLy_A@mail.gmail.com>
From:   Di Shen <cindygm567@gmail.com>
Date:   Thu, 23 Jun 2022 15:34:09 +0800
Message-ID: <CAHYJL4qOeRyqaZS+uijNM7xQUY1y2kVxq-h6q1WECRCAtJ+GFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal/sysfs: Clear the slot left in cooling_device_attr_groups
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Di Shen <di.shen@unisoc.com>, "Zhang, Rui" <rui.zhang@intel.com>,
        xuewen.yan@unisoc.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>, jeson.gao@unisoc.com,
        zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 9:55 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Jun 20, 2022 at 3:20 PM Di Shen <di.shen@unisoc.com> wrote:
> >
> > There's a space allocated for cooling_device_stats_attr_group within co-
>
> Please don't break words in the changelog (and variable names in
> particular) like this.
Ok, thank you. I will pay attention to it.
>
> > oling_device_attr_groups. This space is shared by all cooling devices.
> >
> > If not clear this space before cooling_device_stats_attr_group is initi-
> > alized, the next cooling device will still create stats sysfs file nodes.
> > At this time, read or write related nodes will cause kernel crash.
>
> A bit more of an explanation here wouldn't hurt IMV.  In particular,
> what does "the next cooling device" mean and what are "related nodes"?

There are some cooling devices in thermal management. During the
registration of these
cooling devices, they will create "stats" sysfs.

s9863a:/sys/class/thermal/cooling_device2 # cd stats/
s9863a:/sys/class/thermal/cooling_device2/stats # ls
reset  time_in_state_ms  total_trans  trans_table

Reading or writing these property nodes may cause kernel_crash.
For example, cat time_in_state_ms caused a crash because stats is NULL.

The reason why stats is NULL is "failed to get_max_state in
cooling_device_stats_setup()", and
then cooling_device_stats_setup() returned directly without
initializing stats structure.

static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
{
        //.....
        if (cdev->ops->get_max_state(cdev, &states))
                return;
        //.....
        stats = kzalloc(var, GFP_KERNEL);
        //...
        /* Fill the empty slot left in cooling_device_attr_groups */
        var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
        cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
}

static ssize_t
time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
     char *buf)
{
        //......
        spin_lock(&stats->lock); // stats is NULL. Failed to get lock here.
        //....
        spin_unlock(&stats->lock);

        return len;
}
The same as reset_store(), trans_table_show(), total_trans_show().
>
> > [exception_reboot_reason]: kernel_crash
> > [exception_panic_reason]: Fatal exception
> > [exception_time]: 2022-06-07_06-32-25
> > [exception_file_info]: not-bugon
> > [exception_task_id]: 3154
> > [exception_task_family]: [cat, 3154][sh, 2597][sh, 2362][adbd, 1804]
> > [exception_pc_symbol]: [<747516ae>] _raw_spin_lock+0x20/0x60
> > [exception_stack_info]: [<4cbe9ac1>] prepare_exception_info+0x19c/0x1a4
> > [<03041be7>] sysdump_panic_event+0x57c/0x6f4
> > [<b16f865e>] atomic_notifier_call_chain+0x48/0x7c
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

Actually, if succeed to get max state, it will not crash when cat
time_in_state_ms. But it is worth
noting that even if one of the cooling devices failed to get max
state(which means stats structure
will not be initialized), the stats sysfs was still created.

The property nodes of stats sysfs are created according to the
attribute group, like:

static const struct attribute_group *cooling_device_attr_groups[] = {
        &cooling_device_attr_group,
        NULL, /* Space allocated for cooling_device_stats_attr_group */
        NULL,                                   |
};                                                   |
                                                     v
There's a space allocated for cooling_device_stats_attr_group within
cooling_device_attr_groups. This space is shared by all cooling
devices.

static struct attribute *cooling_device_stats_attrs[] = {
        &dev_attr_total_trans.attr,
        &dev_attr_time_in_state_ms.attr,
        &dev_attr_reset.attr,
        &dev_attr_trans_table.attr,
        NULL
};

static const struct attribute_group cooling_device_stats_attr_group = {
        .attrs = cooling_device_stats_attrs,
        .name = "stats"
};

Suppose there are two cooling devices: cooling_device0 and cooling_device1.
The stats structure of cooling_device0 is firstly initialized
successfully, the space allocated for cooling_device_stats_attr_group
will be filled.
And then cooling_device1 fails to initialize stats structure, the
space now still remains the cooling_device_stats_attr_group of
cooling_device0.
The initialization has failed, so why create sysfs? It is
inappropriate to create the sysfs at this time.

> > So clear the slot left in cooling_device_attr_groups before cooling_dev-
> > ice_stats_attr_group is initialized to avoid kernel crash.
> >
> > Signed-off-by: Di Shen <di.shen@unisoc.com>
> > ---
> >  drivers/thermal/thermal_sysfs.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> > index 1c4aac8464a7..fbc3dbc85841 100644
> > --- a/drivers/thermal/thermal_sysfs.c
> > +++ b/drivers/thermal/thermal_sysfs.c
> > @@ -817,6 +817,11 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
> >         unsigned long states;
> >         int var;
> >
> > +       /* Clear the slot left in cooling_device_attr_groups */
>
> The comment is a bit too vague IMO.  In particular, what slot do you mean?

Well, I will remove it. (Slot means a space allocated for
cooling_device_stats_attr_group in cooling_device_attr_groups[])

>
> > +       var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> > +       if (cooling_device_attr_groups[var])
> > +               cooling_device_attr_groups[var] = NULL;
>
> The NULL check above is redundant (it can be cleared even if it is
> NULL already) and it all can be done in one code line.

OK. I will fix it in the next patchset.

>
> > +
> >         if (cdev->ops->get_max_state(cdev, &states))
> >                 return;
> >
> > --

Thanks!
Di

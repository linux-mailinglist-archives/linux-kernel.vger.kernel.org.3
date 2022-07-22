Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDDF57E53F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiGVRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiGVRS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:18:57 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DD31CFDD;
        Fri, 22 Jul 2022 10:18:57 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id r3so9115324ybr.6;
        Fri, 22 Jul 2022 10:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XPCuVtxNHlRTKlO2xHRASVydOgpgbtbD+QagU1qAmdw=;
        b=E0nwYNvI+c9quWZTSwOlaQIz4pxQSrj+7jYBh82UKaXW4U+LszwK/gzPXV3ppfwDTs
         UdLeecCLIFFy6c1yIYvTmC0ix6HUwvFcUxe2GL6zD8T/mNce6rF3dEZn8xHAT464e3lQ
         s8c+XW6KEnrhQWPKj4hXpJ8y+7nwhs/c1UWgNcdjnx46QlhNasDHnG8Lht36LW1qP8eG
         BUemZgjvIsGIQJ4CseeW7SGdwyFTYzeN87PlQ6df8fk9gf4V2pO0i1G83gdSazQ04hD7
         VD8g4HU4FovGlgJWL07HLmJnr/rBFhdSqzewGUGASupHko8Z+EorrmVparToIyDG0/A2
         9wow==
X-Gm-Message-State: AJIora+WYj9MFP/NYbPMVI31yxJU794LzFTY5aTPEHdym8ww7VOyAxYJ
        sW3c9qHSf+NtsR2zw9sSq+EDCdBJ1ytKAye3CgA=
X-Google-Smtp-Source: AGRyM1u/k29rH+6mfzpP04mnE9lq4/p8jyPsJI0js3/dd3ZYQr8IymakHorHfnCiVLMkno5891dJtRYcDioDw+Vq7E4=
X-Received: by 2002:a25:828f:0:b0:670:22f9:f7eb with SMTP id
 r15-20020a25828f000000b0067022f9f7ebmr879346ybk.137.1658510336244; Fri, 22
 Jul 2022 10:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220722084314.17816-1-di.shen@unisoc.com>
In-Reply-To: <20220722084314.17816-1-di.shen@unisoc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 19:18:42 +0200
Message-ID: <CAJZ5v0iKWH2QkztewmJXiqGwnzBxCo5MWni9Q3VODwV+huvuQA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] thermal/sysfs: Clear cooling_device_stats_attr_group
 before initialized
To:     Di Shen <di.shen@unisoc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jeson.gao@unisoc.com, xuewen.yan@unisoc.com, cindygm567@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 10:44 AM Di Shen <di.shen@unisoc.com> wrote:
>
> There's a space allocated for cooling_device_stats_attr_group
> within cooling_device_attr_groups. This space is shared by all
> cooling devices.

That's correct.

> If the stats structure of one cooling device successfully
> creates stats sysfs. After that, another cooling device fails
> to get max_states in cooling_device_stats_setup(). It can
> return directly without initializing the stats structure, but
> the cooling_device_stats_attr_group is still the attribute
> group of the last cooling device.

I cannot parse the above, sorry.

For example, how can a "stats structure of one cooling device" create
anything?   As a data structure, it is a passive entity, so it doesn't
carry out any actions.

I think (but I am not sure) that you are referring to the error code
path in which the ->get_max_state() callback fails for a cooling
device after cooling_device_stats_setup() has completed successfully
for another one.

> At this time, read or write stats sysfs nodes can cause kernel
> crash. Like the following, kernel crashed when
> 'cat time_in_state_ms'.
>
> [<5baac8d4>] panic+0x1b4/0x3c8
> [<9d287b0f>] arm_notify_die+0x0/0x78
> [<094fc22c>] __do_kernel_fault+0x94/0xa4
> [<3b4b69a4>] do_page_fault+0xd4/0x364
> [<23793e7a>] do_translation_fault+0x38/0xc0
> [<6e5cc52a>] do_DataAbort+0x4c/0xd0
> [<a28c16b8>] __dabt_svc+0x5c/0xa0
> [<747516ae>] _raw_spin_lock+0x20/0x60
> [<9a9e4cd4>] time_in_state_ms_show+0x28/0x148
> [<cb78325e>] dev_attr_show+0x38/0x64
> [<aea3e364>] sysfs_kf_seq_show+0x8c/0xf0
> [<c0a843ab>] seq_read+0x244/0x620
> [<b316b374>] vfs_read+0xd8/0x218
> [<3aebf5fa>] sys_read+0x80/0xe4
> [<7cf100f5>] ret_fast_syscall+0x0/0x28
> [<08cbe22f>] 0xbe8c1198
>
> stats sysfs:
> phone:/sys/class/thermal/cooling_device2/stats # ls
> reset  time_in_state_ms  total_trans  trans_table
>
> The same as cat total_trans, trans_table, and echo reset.
>
> To avoid kernel crash, this patch set clears the
> cooling_device_attr_groups before stats structure is initialized.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..e3fae63fa0f7 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -817,6 +817,9 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         unsigned long states;
>         int var;
>
> +       var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> +       cooling_device_attr_groups[var] = NULL;
> +
>         if (cdev->ops->get_max_state(cdev, &states))
>                 return;
>
> --

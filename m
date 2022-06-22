Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD14554BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357754AbiFVNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357744AbiFVNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:55:13 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296434641;
        Wed, 22 Jun 2022 06:55:12 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id t1so30318853ybd.2;
        Wed, 22 Jun 2022 06:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+Te2BnivL/GDh47o/VHeU0l1HC9J0+Yk21/+4/HIRE=;
        b=bd+szFrvexwX4QF3e367hnx8NGTV/mWXSaeOcmfsedAiRMEs8rvhv8EKyt7f+/wDsT
         WFaAGUpcyDa6TZERpP2NGGJL2whYEvfZuhY0W/eqsapWKDMsOE/TNKZVqpMucTDEMwxS
         MEfQknukqDPaXSSdlG4ypsyybbyM3af90mmkjdYUM4SCuciwlY0Cs5rhDHrdhztNuIW3
         TJaIiH2r4hlrDTMQq1NE5vSZl/btBU079kRHVcP6mY0fgL4iacPLmXqPhBvzx1gPLwU5
         yelxGjagk/cRyrrxEWJO69TLYDA6/ata3zliMAdg54dfZLmjiSaVUfpx5EkTAGNpu9ip
         FXKg==
X-Gm-Message-State: AJIora9Rk1dTPkJ7SjwGWTqAy0Bmn+/w1p+mamWSH8vD4/GmhQDZfLrp
        Z/W82ZSokj4Bp5UZbg6ekcV23iCtOrHr7UnmLnk=
X-Google-Smtp-Source: AGRyM1tvapLMkiK2jTWM8/8nhIRYdhtY7A1W5pRXs/vQD0eLsIOlkR/goPIutaoplkt+REApSulMtqh7Id6MzyM+6aI=
X-Received: by 2002:a25:d841:0:b0:668:ab2f:7b01 with SMTP id
 p62-20020a25d841000000b00668ab2f7b01mr3854953ybg.482.1655906111500; Wed, 22
 Jun 2022 06:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220620131953.16575-1-di.shen@unisoc.com>
In-Reply-To: <20220620131953.16575-1-di.shen@unisoc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Jun 2022 15:55:00 +0200
Message-ID: <CAJZ5v0j380_UEsy6qJ_KuRf8YbL3KtiY-h+RdkSsfd8SRCLy_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] thermal/sysfs: Clear the slot left in cooling_device_attr_groups
To:     Di Shen <di.shen@unisoc.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>, xuewen.yan@unisoc.com,
        cindygm567@gmail.com, Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 3:20 PM Di Shen <di.shen@unisoc.com> wrote:
>
> There's a space allocated for cooling_device_stats_attr_group within co-

Please don't break words in the changelog (and variable names in
particular) like this.

> oling_device_attr_groups. This space is shared by all cooling devices.
>
> If not clear this space before cooling_device_stats_attr_group is initi-
> alized, the next cooling device will still create stats sysfs file node.
> At this time, read or write related nodes will cause kernel crash.

A bit more of an explanation here wouldn't hurt IMV.  In particular,
what does "the next cooling device" mean and what are "related nodes"?

> [exception_reboot_reason]: kernel_crash
> [exception_panic_reason]: Fatal exception
> [exception_time]: 2022-06-07_06-32-25
> [exception_file_info]: not-bugon
> [exception_task_id]: 3154
> [exception_task_family]: [cat, 3154][sh, 2597][sh, 2362][adbd, 1804]
> [exception_pc_symbol]: [<747516ae>] _raw_spin_lock+0x20/0x60
> [exception_stack_info]: [<4cbe9ac1>] prepare_exception_info+0x19c/0x1a4
> [<03041be7>] sysdump_panic_event+0x57c/0x6f4
> [<b16f865e>] atomic_notifier_call_chain+0x48/0x7c
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
> So clear the slot left in cooling_device_attr_groups before cooling_dev-
> ice_stats_attr_group is initialized to avoid kernel crash.
>
> Signed-off-by: Di Shen <di.shen@unisoc.com>
> ---
>  drivers/thermal/thermal_sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index 1c4aac8464a7..fbc3dbc85841 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -817,6 +817,11 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         unsigned long states;
>         int var;
>
> +       /* Clear the slot left in cooling_device_attr_groups */

The comment is a bit too vague IMO.  In particular, what slot do you mean?

> +       var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
> +       if (cooling_device_attr_groups[var])
> +               cooling_device_attr_groups[var] = NULL;

The NULL check above is redundant (it can be cleared even if it is
NULL already) and it all can be done in one code line.

> +
>         if (cdev->ops->get_max_state(cdev, &states))
>                 return;
>
> --

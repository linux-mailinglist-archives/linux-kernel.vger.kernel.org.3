Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C004C359B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiBXTRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiBXTRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:17:12 -0500
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0569465A5;
        Thu, 24 Feb 2022 11:16:41 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-2d646fffcc2so9150657b3.4;
        Thu, 24 Feb 2022 11:16:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IUBHyJhD/KgAkIiV2RaqQW67XtJAXXd9nyxXUgBYd+8=;
        b=xmCxb8EJfK76+POmTfYM9mbNTC6pWjh/VVrtDD+BfLpp6NagHDrdRO6fYHSwOWtvO/
         RQc+JXnIG/DvKyKu6xobmfyE90zRFaVTiMlQvh5YUiZ+Z9ywSkSYapY63Z7EQiHgh8LC
         umUNRohsJLoIHpZqCYVPX1cf6tSCcfSojB5XY2ciWtEE7W9qaUBkOIbtE/u16WyAaMtc
         aG2tPkeUmh4rWj8QEQvhytZSUg2b55zsL16sRrUwvWcHgZUFTEjUimlNZFUXRwUSlU74
         +vs5lXxx5aRwF7IaINgTf2UJgVn91Fy8ovYMx/v3NwXAR4kFZXt6AnJqiPoNrhnzZkoF
         ZaDw==
X-Gm-Message-State: AOAM533uuuDCkYXCk4Vs5pBW5YXLtJZNkihEzH6liBKtanDZmujWYkTA
        39puREbC93yuYXiAfbZWyB6KbqlEMcMhKsMM1bv2JnAD
X-Google-Smtp-Source: ABdhPJwlZGubhCnX68XVrLcLN4c3fJbq3VhKaQJBE+UAKi1zMOMeO+k7nAQqhyZlc6X/07qpRK2LmjQnSSIWQ+Btda0=
X-Received: by 2002:a81:b65f:0:b0:2d6:d29c:63fd with SMTP id
 h31-20020a81b65f000000b002d6d29c63fdmr4053544ywk.196.1645730201257; Thu, 24
 Feb 2022 11:16:41 -0800 (PST)
MIME-Version: 1.0
References: <20220223002024.55026-1-chuansheng.liu@intel.com>
In-Reply-To: <20220223002024.55026-1-chuansheng.liu@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 24 Feb 2022 20:16:30 +0100
Message-ID: <CAJZ5v0iAkRQuoA+TDU46fR+Xek5rB=tiMNTJ-M28RSyHz2RKiQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: fix memory leak in int3400_notify()
To:     Chuansheng Liu <chuansheng.liu@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Feb 23, 2022 at 1:33 AM Chuansheng Liu <chuansheng.liu@intel.com> wrote:
>
> It is easy to hit the below memory leaks in my TigerLake platform:
>
> --
> unreferenced object 0xffff927c8b91dbc0 (size 32):
>   comm "kworker/0:2", pid 112, jiffies 4294893323 (age 83.604s)
>   hex dump (first 32 bytes):
>     4e 41 4d 45 3d 49 4e 54 33 34 30 30 20 54 68 65  NAME=INT3400 The
>     72 6d 61 6c 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  rmal.kkkkkkkkkk.
>   backtrace:
>     [<ffffffff9c502c3e>] __kmalloc_track_caller+0x2fe/0x4a0
>     [<ffffffff9c7b7c15>] kvasprintf+0x65/0xd0
>     [<ffffffff9c7b7d6e>] kasprintf+0x4e/0x70
>     [<ffffffffc04cb662>] int3400_notify+0x82/0x120 [int3400_thermal]
>     [<ffffffff9c8b7358>] acpi_ev_notify_dispatch+0x54/0x71
>     [<ffffffff9c88f1a7>] acpi_os_execute_deferred+0x17/0x30
>     [<ffffffff9c2c2c0a>] process_one_work+0x21a/0x3f0
>     [<ffffffff9c2c2e2a>] worker_thread+0x4a/0x3b0
>     [<ffffffff9c2cb4dd>] kthread+0xfd/0x130
>     [<ffffffff9c201c1f>] ret_from_fork+0x1f/0x30
> ---
>
> Fix it by calling kfree() accordingly.
>
> Fixes: 38e44da59130 ("thermal: int3400_thermal: process "thermal table
> changed" event")
>
> Cc: linux-pm@vger.kernel.org
> Cc: stable@vger.kernel.org
> Cc: rafael@kernel.org
> Cc: srinivas.pandruvada@linux.intel.com
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>

Applied as a fix for 5.17-rc, thanks!

Srinivas, any concerns?

> ---
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 72acb1f61849..4f478812cb51 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -404,6 +404,10 @@ static void int3400_notify(acpi_handle handle,
>         thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", therm_event);
>         thermal_prop[4] = NULL;
>         kobject_uevent_env(&priv->thermal->device.kobj, KOBJ_CHANGE, thermal_prop);
> +       kfree(thermal_prop[0]);
> +       kfree(thermal_prop[1]);
> +       kfree(thermal_prop[2]);
> +       kfree(thermal_prop[3]);
>  }
>
>  static int int3400_thermal_get_temp(struct thermal_zone_device *thermal,
> --
> 2.25.0.rc2
>

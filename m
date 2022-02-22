Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC494BF819
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiBVMfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiBVMfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:35:01 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4D2120E81
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:34:32 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id u12so26752977ybd.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQTOgc/LLcovnMJ3XI2DYar0j+/5XSpX89mzJAqEmDk=;
        b=sAaFGaFjLJfBS8vPGvEwmtO5K9v6ZYgkxfPjpFUdQN+YVpF9JXvuhs7d6wHh74HI2U
         ODXwCeRex8cm6P59sFwCaQNN39sToLTxSVEVxLUWmi0NAtZetz4QQT7ce8cGYys2kkOR
         2hxNm6vhkNQLfmD6pmo/mquA01BZihKcDr0QkBEhixo7boNYIAnfyPWd5csCLjhY5FB7
         W5jxTrUTvxzv8q42vPmFhOFWI1/iMk7dkjSeoRk0CVvgvrx9Ra5t5gXlJ9nepwm28LN+
         Hm3sACTXlX13B+VREuQm0Uf9IrL57ROnB9adwdHazaKVqhUsu88SRKlhtIgv6WK9CYQU
         lxmA==
X-Gm-Message-State: AOAM530QlfRkz0RLgXrWZN9InhBUwwHFhgFuGnZ8e5NBnuk6nrQ9vnCH
        rYoTEgwN9n2nrKwbT7gW5tFZsIMf8XkOnqWm4H4=
X-Google-Smtp-Source: ABdhPJw7uQG6yBKichLPQ3CDTufYxTtlsyfaMjI9aGfrueGe3PuCKtQXY/GY4HunKd5+WFrhI5dbRxMj5md/H6eQJSI=
X-Received: by 2002:a25:da16:0:b0:624:64e1:35b with SMTP id
 n22-20020a25da16000000b0062464e1035bmr13124544ybf.153.1645533271376; Tue, 22
 Feb 2022 04:34:31 -0800 (PST)
MIME-Version: 1.0
References: <20220222020021.19640-1-chuansheng.liu@intel.com>
In-Reply-To: <20220222020021.19640-1-chuansheng.liu@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Feb 2022 13:34:19 +0100
Message-ID: <CAJZ5v0hziz4Eyk7qFgYMM4YYEZTpd_faukMczg7hnou9yP9yiQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: int340x: fix memory leak in int3400_notify()
To:     Chuansheng Liu <chuansheng.liu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
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

Please resend this with a CC to linux-pm@vger.kernel.org.  Thanks!

On Tue, Feb 22, 2022 at 3:13 AM Chuansheng Liu <chuansheng.liu@intel.com> wrote:
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
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7255AC090
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiICSQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiICSQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:16:11 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C01C5245D;
        Sat,  3 Sep 2022 11:16:08 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 11so7541637ybu.0;
        Sat, 03 Sep 2022 11:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WsXpPsNzAIChBGXGbRDY3v5GUv3oVNKXQrqzZsrRpwU=;
        b=cvmb5eBwQXo5J5Scpp9LhIyP7ZC8WrQOm9Jg4WaMBXm5xusI6sWdNRpiiVpMup3I9Q
         gggtOuUJ0Xd07LJtFchqVcaylNQ348gf2a3H+jOl9uCQ0b2LTQi0nUtRcAKcIHcep0xw
         M0tSsc4KlBEDR3Xr8pORWcWsxgzWU2FHfKvOeZF3zGIX/k3eBZzRwi+BrUYKfVo9DRxk
         lacYAK+du+xx1ZJB70abo4BeiEJfrhJgXL6b/yIyue49Bt43vASKhHB5xWZLorE2ycit
         gy5z5FBzJQ1lKdJibtys/PQsSsw4vvbNqyW9GIo85rTxIkVXkzjbsTZdlWylY2vKG1Wm
         bwOQ==
X-Gm-Message-State: ACgBeo2ZDlq73ulPqELKvk3Y9Y2K+htqecfXF/026/uNvsjwL/m5ptBT
        SH+O78qJVpw95JuDAIKUIpP4lProwSTp8itZS1zaCr/6
X-Google-Smtp-Source: AA6agR6zKn8owv9r/toH6xpZc4AH+cvxq83Tk+TSiWnWtoIXNSznm7xAocbNlnWPIhwGpoLkw1p8O8qwcOzgigp5BA4=
X-Received: by 2002:a25:664a:0:b0:695:e7cc:9a20 with SMTP id
 z10-20020a25664a000000b00695e7cc9a20mr27900449ybm.153.1662228967356; Sat, 03
 Sep 2022 11:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220829011534.445092-1-liaoyu15@huawei.com>
In-Reply-To: <20220829011534.445092-1-liaoyu15@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:15:56 +0200
Message-ID: <CAJZ5v0jfgHNeA=tARWtMT5v8w5QKpwvo0n_LDJPgX34yk7gDUw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: remove redundant check in cpuidle_switch_governor
To:     Yu Liao <liaoyu15@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        liwei391@huawei.com
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

On Mon, Aug 29, 2022 at 3:08 AM Yu Liao <liaoyu15@huawei.com> wrote:
>
> gov has already been NULL checked at the beginning of
> cpuidle_switch_governor, so remove redundant check.
>
> And use pr_info instead printk to fix the following checkpatch warning.
>
> WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then
> dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
>
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/cpuidle/governor.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index 29acaf48e575..9e6865edb942 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -63,12 +63,10 @@ int cpuidle_switch_governor(struct cpuidle_governor *gov)
>
>         cpuidle_curr_governor = gov;
>
> -       if (gov) {
> -               list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> -                       cpuidle_enable_device(dev);
> -               cpuidle_install_idle_handler();
> -               printk(KERN_INFO "cpuidle: using governor %s\n", gov->name);
> -       }
> +       list_for_each_entry(dev, &cpuidle_detected_devices, device_list)
> +               cpuidle_enable_device(dev);
> +       cpuidle_install_idle_handler();
> +       pr_info("cpuidle: using governor %s\n", gov->name);
>
>         return 0;
>  }
> --

Applied (with some minor modifications) as 6.1 material, thanks!

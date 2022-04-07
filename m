Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E114F7D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244583AbiDGK4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244568AbiDGK4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:56:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CEA199;
        Thu,  7 Apr 2022 03:54:08 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 32so2514149pgl.4;
        Thu, 07 Apr 2022 03:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M+3WC6K2v2Rew5+KY4Zz7SR5Z7lL3sysPR2qoBAMEGg=;
        b=dzBjnduRmPzY2Trf1omhPW2ulIytv7bkAMJp1DfmstQ+eE+XlzZ6NiIPfM1ARC/87l
         Y7+fI784U5iGH0UuuiOArn89Hs6SUb3Wo1TtBHA7Um3NvBKhebIY8wrwWrXanBDzjFH7
         mlbTMk88/fzd6RFcafPuepnlZp+EZh+DUiBjti5JdNnEJEUXSjc/QdClesam25s0qXKy
         L3T9ujxtXRxD8+50NlSfhAzRr+jPO6pS01TNlwBlm5pb9ckRjB/isfv4r3sQAZ4bp7ZB
         X6KFhK6dN7gzJMFb9aN2dMEwyqE+d+tjjBFyFjatL5D+FVCTyHkT3LJeH89jkdDiXEKB
         YIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M+3WC6K2v2Rew5+KY4Zz7SR5Z7lL3sysPR2qoBAMEGg=;
        b=xUG2/YM9kJmVD/4Qca46yIkKSkZ9HplxXiIAXuuICnl/QqFAgIi+gdg8+vssPkZAOv
         o0fvmGs8ph+on4gm7DJ4qxEweipvm1MPsOQjS45BnCPegwW2wZCSYxaZ891nTKwWaJvE
         ntZ60tGMuhRcP6pp7Zk67D5Syny/2RU8bjYn/2MWa2S/+n5ecsHHKB0F/E/DsMVugJUF
         jfqhyuVOZHBwe1UYCSlYshxrLiCqE/sq+VaLEFXKgrZCrOQ5c0z6NS+sDfplq2vpD76a
         la6VqVdlyqJ0vArVjw+3JJadY79Ti+HQVHcq5ZH9KfGvbV0A7gfgeopQHHQxBeWLiOhH
         OWmg==
X-Gm-Message-State: AOAM5335641Ozp9iY2d5USX9VMF/NpTCu6ZHXyPoBH1bay78JfiLg4GC
        DD+VYv8KwEn/yhPsYzUVCY6ZSzHYmignbg37/ByU84QuhwKrOHw=
X-Google-Smtp-Source: ABdhPJxPiwJ2BCfhujOIhEiLhZm2SfdJWu+Xy4GKQ/HXJX7x1cQo7Tuy1FxzPkpoQPGOr0ZYH8+MN7VPD4zw/8S+wtY=
X-Received: by 2002:a05:6a00:1897:b0:505:6e58:4a2c with SMTP id
 x23-20020a056a00189700b005056e584a2cmr895665pfh.2.1649328847784; Thu, 07 Apr
 2022 03:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220407101312.13331-1-W_Armin@gmx.de>
In-Reply-To: <20220407101312.13331-1-W_Armin@gmx.de>
From:   Zheyu Ma <zheyuma97@gmail.com>
Date:   Thu, 7 Apr 2022 18:53:56 +0800
Message-ID: <CAMhUBj=66_snYzC09DxEy8r0EwOQSGeJAtQ37y51SUWXKcWh=w@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (adt7470) Fix warning on module removal
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Apr 7, 2022 at 6:13 PM Armin Wolf <W_Armin@gmx.de> wrote:
>
> When removing the adt7470 module, a warning might be printed:
>
> do not call blocking ops when !TASK_RUNNING; state=1
> set at [<ffffffffa006052b>] adt7470_update_thread+0x7b/0x130 [adt7470]
>
> This happens because adt7470_update_thread() can leave the kthread in
> TASK_INTERRUPTIBLE state when the kthread is being stopped before
> the call of set_current_state(). Since kthread_exit() might sleep in
> exit_signals(), the warning is printed.
> Fix that by using schedule_timeout_interruptible() and removing
> the call of set_current_state().
> This causes TASK_INTERRUPTIBLE to be set after kthread_should_stop()
> which might cause the kthread to exit.
>
> Compile-tested only.
>
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Fixes: 93cacfd41f82 (hwmon: (adt7470) Allow faster removal)
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/hwmon/adt7470.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
> index fb6d14d213a1..c67cd037a93f 100644
> --- a/drivers/hwmon/adt7470.c
> +++ b/drivers/hwmon/adt7470.c
> @@ -19,6 +19,7 @@
>  #include <linux/log2.h>
>  #include <linux/kthread.h>
>  #include <linux/regmap.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/util_macros.h>
>
> @@ -294,11 +295,10 @@ static int adt7470_update_thread(void *p)
>                 adt7470_read_temperatures(data);
>                 mutex_unlock(&data->lock);
>
> -               set_current_state(TASK_INTERRUPTIBLE);
>                 if (kthread_should_stop())
>                         break;
>
> -               schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
> +               schedule_timeout_interruptible(msecs_to_jiffies(data->auto_update_interval));
>         }
>
>         return 0;
> --
> 2.30.2
>

Tested-by: Zheyu Ma <zheyuma97@gmail.com>

Thanks,
Zheyu Ma

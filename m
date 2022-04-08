Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737804F99A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiDHPlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiDHPlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:41:19 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E82286E3;
        Fri,  8 Apr 2022 08:39:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so6329441otj.10;
        Fri, 08 Apr 2022 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJkMiY5MRtcxuQKthWd6Y5lY7ndKbY+OeERDaDIJqOo=;
        b=jFOJx+q4Zt4u1lJcDiOp1VLNrxGZSfiKCbV6YNKIB/RJV6ry3KrS01DZ4sqG3zpyM5
         b2C5OdwOpnlqUFxp8fSRhb9+5qICpIgAxcu3bup1QL5/QV6akHuK8+pCR6AcSFVj9Hyz
         jqkiqpbUEkeMphwmjK4dJqewAPu/vvHNPzyn2zySLiWdg+fxnVWp9MRiZv6DxyrUM3QP
         v/AmSVjtmxlsKFxsvqX0u+TocrOvUUdq/Ulz+oAd91y3VSNJG+EIfXaOs4JKlkcbT94P
         SHyRTcDEhimN/XVexoDB2AwrZBYq7rFQYR5p6CwWLbm24cm2QkACnZGdpRRFFCaljZ5p
         GxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HJkMiY5MRtcxuQKthWd6Y5lY7ndKbY+OeERDaDIJqOo=;
        b=7Oc3FQxF3+ySPJG9bDIrRFqbWbXOi1+qXtHlXiDIRAvdLQpncnN7GK/sMOk5p51Zgv
         2Wz5s97IjTHqrJDQ+og59c3EItjyK3Aova9R9tG5YB5xdkwzGjuWxQUmgGcuSVCbbi7Y
         fUTxygYVeCw6U4xcZvsfkSRtrYEDkOdRZfIIMvEMqbdyp1rIqUrDNUOM2RjeaUIIVI2O
         trTtx0ZjOTnQWixzdPUu+E2Y9+yNEYobCXvn/SJ7RBySSufxDwUQYzCPsa/8sOdjs0EH
         ryp/vSykvO96J20H+c3cJ21PP35z/1gwUtrBP+WvJzaMBHxTRvpul96T0Yo6tvAjBR62
         UDoA==
X-Gm-Message-State: AOAM5321md87eoaYqU5+huLtUNfmiQaSnq8VFCgDtQrJ7oH93t9r9YM/
        nido2OTT3bQvBuVJXvNE7Zk=
X-Google-Smtp-Source: ABdhPJwERHX0Pdnxfba2PC3ATgsU43ZA/ZVFRBrpqnZR6EyNfI52/S0jTQVtzGOMIi8uuxsrVFxBbw==
X-Received: by 2002:a05:6830:1341:b0:5cd:b7d1:65f8 with SMTP id r1-20020a056830134100b005cdb7d165f8mr6566254otq.266.1649432354617;
        Fri, 08 Apr 2022 08:39:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m3-20020a4ae3c3000000b00320d7c78b01sm8506843oov.20.2022.04.08.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:38:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 8 Apr 2022 08:38:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     zheyuma97@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (adt7470) Fix warning on module removal
Message-ID: <20220408153835.GA104977@roeck-us.net>
References: <20220407101312.13331-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407101312.13331-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 12:13:12PM +0200, Armin Wolf wrote:
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
> Tested-by: Zheyu Ma <zheyuma97@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/adt7470.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --
> 2.30.2
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
>  		adt7470_read_temperatures(data);
>  		mutex_unlock(&data->lock);
> 
> -		set_current_state(TASK_INTERRUPTIBLE);
>  		if (kthread_should_stop())
>  			break;
> 
> -		schedule_timeout(msecs_to_jiffies(data->auto_update_interval));
> +		schedule_timeout_interruptible(msecs_to_jiffies(data->auto_update_interval));
>  	}
> 
>  	return 0;

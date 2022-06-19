Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102CA550D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiFSXRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiFSXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:17:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EE86170
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:17:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655680624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BG6XKZcyT6u9naDi/hB11yO1y7Nfe/RiMW8gRti8Q+g=;
        b=2MKhmE8E2Gtb6FmgEe3l9soIja0kk+bKsX2xOoUKVAUC4lSW/qX8YUW1sBiio5IVtrk0Dp
        RMHFrw9UGxfbNo37dnVRkzTGYYgMg7XM2TgLQczDV3zhI3DwXlWfUBph89cNCoIqDrkEmX
        St9opcTT+0JBhtyxGyO/Ui4rSK6TUhxbJa922F6DLR+QHK+eqBSE05jxcD6lNnJON9i8VK
        0F+T7sVU3k0wKWwO7Ve1xisURUVAwpL2a7xytakQh+o9Ime5RCD+o27oXpv6NUx+LkwQ/9
        YU0XK3R9w/z2EM7/6vIKDq4Vdx6p3msM4Hcay5p2kzOsgZiaExcqPzq9xlRctg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655680624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BG6XKZcyT6u9naDi/hB11yO1y7Nfe/RiMW8gRti8Q+g=;
        b=LcO/ZbataAR0HxAaNC0kKjcLpLqgCwbADTznnbkFFE1898dCx/1N1F+KeRCZiMo+1HF+7O
        XtXM6bWV6fs58+CQ==
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
In-Reply-To: <20220619204326.556923-1-Jason@zx2c4.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
Date:   Mon, 20 Jun 2022 01:23:04 +0206
Message-ID: <87letsw8en.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-19, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index c7900e8975f1..47466aa2b0e8 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig

Sorry, I missed this in your v1. But I think this config belongs in
lib/Kconfig.debug under the "printk and dmesg options" menu.

> @@ -798,6 +798,18 @@ config PRINTK_INDEX
>  
>  	  There is no additional runtime cost to printk with this enabled.
>  
> +config PRINTK_DIRECT
> +	bool "Attempt to flush printk output immediately"
> +	depends on PRINTK
> +	help
> +	  Rather than using kthreads for printk output, always attempt to write
> +	  to the console immediately. This has performance implications, but
> +	  will result in a more faithful ordering and interleaving with other
> +	  processes writing to the console.
> +
> +	  Say N here unless you really need this. This may also be controlled
> +	  at boot time with printk.direct=0/1.
> +
>  #
>  # Architectures with an unreliable sched_clock() should select this:
>  #
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..43f8a0074ed6 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -178,6 +178,14 @@ static int __init control_devkmsg(char *str)
>  }
>  __setup("printk.devkmsg=", control_devkmsg);
>  
> +static bool printk_direct = IS_ENABLED(CONFIG_PRINTK_DIRECT);

I understand why you would name the variable to match the boot arg. But
I would prefer the _internal_ variable had a name that makes it clear
(to us developers) that it is a permanent setting. Perhaps
printk_direct_only or printk_direct_always?

The reason is because when kthreads are active, direct printing is
turned on and off dynamically (using @printk_prefer_direct). And if this
new variable is named @printk_direct, one could easily mistake its
meaning to be related to the dynamic turning on and off.

> +
> +static int __init control_printk_direct(char *str)
> +{
> +	return kstrtobool(str, &printk_direct);
> +}
> +__setup("printk.direct=", control_printk_direct);
> +
>  char devkmsg_log_str[DEVKMSG_STR_MAX_SIZE] = "ratelimit";
>  #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
>  int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> @@ -3602,6 +3610,9 @@ static int __init printk_activate_kthreads(void)
>  {
>  	struct console *con;
>  
> +	if (printk_direct)

I'm wondering if we should output a message here. My suggestion is:

pr_info("printing threads disabled, using direct printing\n");

> +		return 0;
> +
>  	console_lock();
>  	printk_kthreads_available = true;
>  	for_each_console(con)

Otherwise it looks OK to me. But you may want to wait on a response from
Petr, Sergey, or Steven before sending a v3. You are adding a kernel
config and a boot argument. Both of these are sensitive topics that
require more feedback from others.

John Ogness

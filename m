Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C9457CEEB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiGUPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGUPaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:30:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32980497;
        Thu, 21 Jul 2022 08:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C314BB8253C;
        Thu, 21 Jul 2022 15:29:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A0C0C3411E;
        Thu, 21 Jul 2022 15:29:55 +0000 (UTC)
Date:   Thu, 21 Jul 2022 11:29:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH V6 15/16] rv/reactor: Add the printk reactor
Message-ID: <20220721112953.12828bd5@gandalf.local.home>
In-Reply-To: <ad355eb25b933124e6e24045f6331ada5bf7adb3.1658244826.git.bristot@kernel.org>
References: <cover.1658244826.git.bristot@kernel.org>
        <ad355eb25b933124e6e24045f6331ada5bf7adb3.1658244826.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Including the printk folks ]

On Tue, 19 Jul 2022 19:27:20 +0200
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> A reactor that printks the reaction message.
> 
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Gabriele Paoloni <gpaoloni@redhat.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: Tao Zhou <tao.zhou@linux.dev>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  kernel/trace/rv/Kconfig          |  8 ++++++
>  kernel/trace/rv/Makefile         |  3 ++-
>  kernel/trace/rv/reactor_printk.c | 42 ++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/trace/rv/reactor_printk.c
> 
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index d8c40fd67e88..f1d92d431130 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -63,3 +63,11 @@ config RV_REACTORS
>  	  on the model's execution. By default, the monitors have
>  	  tracing reactions, printing the monitor output via tracepoints,
>  	  but other reactions can be added (on-demand) via this interface.
> +
> +config RV_REACT_PRINTK
> +	bool "Printk reactor"
> +	depends on RV_REACTORS
> +	default y
> +	help
> +	  Enables the printk reactor. The printk reactor emits a printk()
> +	  message if an exception is found.
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index af0ff9a46418..a13c750a35c1 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_RV) += rv.o
> -obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>  obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
>  obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
> +obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
> +obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
> diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
> new file mode 100644
> index 000000000000..8b5c70b05634
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
> + *
> + * Printk RV reactor:
> + *   Prints the exception msg to the kernel message log.
> + */
> +#include <linux/ftrace.h>
> +#include <linux/tracepoint.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/rv.h>
> +
> +static void rv_printk_reaction(char *msg)
> +{
> +	printk_deferred(msg);

I added the printk folks just so that they are aware of another
printk_deferred() being added to the kernel.

-- Steve


> +}
> +
> +static struct rv_reactor rv_printk = {
> +	.name = "printk",
> +	.description = "prints the exception msg to the kernel message log",
> +	.react = rv_printk_reaction
> +};
> +
> +static int register_react_printk(void)
> +{
> +	rv_register_reactor(&rv_printk);
> +	return 0;
> +}
> +
> +static void unregister_react_printk(void)
> +{
> +	rv_unregister_reactor(&rv_printk);
> +}
> +
> +module_init(register_react_printk);
> +module_exit(unregister_react_printk);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Daniel Bristot de Oliveira");
> +MODULE_DESCRIPTION("printk rv reactor: printk if an exception is hit");


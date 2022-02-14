Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3239D4B5872
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357070AbiBNRZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:25:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357066AbiBNRZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:25:38 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E39D652FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:25:30 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id p63so20667408iod.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uHo9ifNLQ09Yp1i6Bp5KrefO3r8lTgQpaEZz0iuYjms=;
        b=LKNxKFJUqhbFk4Qe/pRRegw9Y64INugoyZedczfCDrP9t+fKS3dPmVaiVWKgRh5oKj
         203ONOj5nFUp9ItEmeM/YxjKI5cWbnseHJC7WtE+OZwGAy4Mux24tI3jcNm6RDywmH6+
         wRWhu5cEXokeKhAkW/nbDjSadLfJ6UJlGDhAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uHo9ifNLQ09Yp1i6Bp5KrefO3r8lTgQpaEZz0iuYjms=;
        b=y4PCSWTF/l07s0BC/f3dc0KbWpR/96Iu8hhOe3dWL37kxbfL0vs+u8d/Tv5Vm7nOXR
         bcBcaaAElbO7C16PVcDvPV52oh7EAdJCvlKodyyBYO7n+y/4Y1KV9JnBNWVDbVK5VXGc
         Av7crobT6RlW/bR1zybgo7On79smDA/wtoBSRNlnCV35KljQ9PyksQwMvP+pvbrzJRqf
         Z9SK/8ndB3uWu1oqg2F/uh3K0cNSP7FYehKOfqTRGu3/FWVe42+A/ta2p8r0yY8XpkLF
         DOtZvhLXuZJTNP84uTTB1nUl4GTqZAQe+05KdXDqaqmdlg3xDYHdu0622NxHzWp5E8bQ
         NoXw==
X-Gm-Message-State: AOAM530h/JXdkiXS+JbjJvB5QUhMa7zB/hWl9RbyENLVm7UuoCfENe+R
        8zZgx8u0LzTEEAqV80m2LwvVwg==
X-Google-Smtp-Source: ABdhPJzGAtxpCzuVfwe2bYFOH31SGAUKp7VPjUtMbOWWF94SuYwjfTqzPEUgrkR1TKUAXYNHpYGEYw==
X-Received: by 2002:a05:6638:1350:: with SMTP id u16mr455419jad.260.1644859529967;
        Mon, 14 Feb 2022 09:25:29 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id 193sm12353004iob.17.2022.02.14.09.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:25:29 -0800 (PST)
Subject: Re: [RFC V2 12/21] rv/reactor: Add the printk reactor
To:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <10cf6003-6d2b-056b-11bb-3ae9c342a369@linuxfoundation.org>
Date:   Mon, 14 Feb 2022 10:25:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <fad2d358d57dfffc084d482684ecc1d13b62b262.1644830251.git.bristot@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 3:45 AM, Daniel Bristot de Oliveira wrote:
> Sample reactor that printks the reaction message.
> 

Who is supposed to take action on this message and how do they
get notified?

> Note: do not use this reactor with rq_lock taken, it will lock the
> system until printk can handle that.

Please give more details on "lock the system" and how locking
would impact users and system operation

> 
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
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>   kernel/trace/rv/Kconfig          |  8 ++++++
>   kernel/trace/rv/Makefile         |  3 ++-
>   kernel/trace/rv/reactor_printk.c | 43 ++++++++++++++++++++++++++++++++
>   3 files changed, 53 insertions(+), 1 deletion(-)
>   create mode 100644 kernel/trace/rv/reactor_printk.c
> 
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index f2d0bed05a55..490f1417def9 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -37,4 +37,12 @@ config RV_REACTORS
>   	  tracing reactions, printing the monitor output via tracepoints,
>   	  but other reactions can be added (on-demand) via this interface.
>   
> +config RV_REACT_PRINTK
> +	tristate "Printk reactor"
> +	depends on RV_REACTORS
> +	default y if RV_REACTORS
> +	help
> +	  Enables the printk reactor. The printk reactor emmits a printk()
> +	  message if an exception is found.
> +
>   endif # RV
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index edad01bb2b5d..d86ceb103ef2 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -1,6 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0
>   
>   obj-$(CONFIG_RV) += rv.o
> -obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>   obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
>   obj-$(CONFIG_RV_MON_WWNR) += monitor_wwnr/wwnr.o
> +obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
> +obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
> diff --git a/kernel/trace/rv/reactor_printk.c b/kernel/trace/rv/reactor_printk.c
> new file mode 100644
> index 000000000000..9f9c9bb2d304
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_printk.c
> @@ -0,0 +1,43 @@
> +/*
> + * Printk RV reactor:
> + *   Prints the exception msg to the kernel message log.
> + *
> + * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
> + *
> + * SPDX-License-Identifier: GPL-2.0
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
> +	printk(msg);
> +}
> +
> +struct rv_reactor rv_printk = {
> +	.name = "printk",
> +	.description = "prints the exception msg to the kernel message log",
> +	.react = rv_printk_reaction
> +};
> +
> +int register_react_printk(void)
> +{
> +	rv_register_reactor(&rv_printk);
> +	return 0;
> +}
> +
> +void unregister_react_printk(void)
> +{
> +	rv_unregister_reactor(&rv_printk);
> +}
> +
> +module_init(register_react_printk);
> +module_exit(unregister_react_printk);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Daniel Bristot de Oliveira");
> +MODULE_DESCRIPTION("printk rv reactor: printk if an exception is hit");
> 


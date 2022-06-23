Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1D6558694
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiFWSPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiFWSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:14:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8669A877
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:21:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q15so11414342wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L5rVpiSBD6bHrgBbtOmsPeL7WjLPbqmPTnPwPerx3Is=;
        b=vbtD2FZDG3XohdsHpK60LexpnW+hZCYEHreA264cxYeVivWYaDcm0zb1Huzfez0fjQ
         o32V0KP/x69JAJxE0jvMYFRIRo1acdALwZhSKmTRoCRpVwjrRgIqrCNeqZIeE0jKjZkg
         pJjD/hZhxxYNMnLQ/EFS/QTyMU9KwfBp9cqytDZYFluHN9AY5U9mOZ9KL40yfq3vB1H/
         xNDFQ0MB/p2gjHHzYDI+r0nB+h9IRuel8guBd0fSjSvfgiQy7RxY4dlH5JB14OkOnoEy
         sBl5M8F9EunKpreLdXteAy3X3ZlsZt8OkkZXH5vn+iXZCKODl1mmi/jrhV50Bl8RwF66
         BdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=L5rVpiSBD6bHrgBbtOmsPeL7WjLPbqmPTnPwPerx3Is=;
        b=wlzxzKH4vhoC51emdhvq/k+xG8M5ScMTNmzJlRgc0r6BvR+D6jGj8PjixgV2W/llOF
         WqbNfFxPam8vL65py9yHcqL7jtCuKI2xdFpouo0M5sY2eImaz95f/eh0onZpmTxzkHJQ
         vnL1CvV3rlMAO0s9KIsoYWckLajSL7fb8oJ3/glwJMmj9adn/jLgL0sTPqD8C9uaPMpE
         jXpwsFymuZ/spAetDzewTyDBTU0THcB+UhhFWeBBrPib9/V9AhX3Iblvd2o6KXfQWd83
         uYFp8ADZb37KFtZYsNvKvswm5Mig6MijzMi5Jl+ayH1RDp7vngZK73mlFqe8mqW7xTzx
         qcIg==
X-Gm-Message-State: AJIora+G6yLoMhWxIJxBxatRiLbyfRdI+ltNQ3Rqh7F2B3ED76U0j83t
        2BY4QD3zBT9ixQwnapk1wmA3MA==
X-Google-Smtp-Source: AGRyM1uW7ezE3RjDBrd+dlkQkVXAVdDjKKoY4iGLl68odcrGDz/V5+RroxuGNGlOorVYSQnn/3nXdA==
X-Received: by 2002:a05:600c:35d2:b0:39c:8490:abbf with SMTP id r18-20020a05600c35d200b0039c8490abbfmr5463860wmq.86.1656004876835;
        Thu, 23 Jun 2022 10:21:16 -0700 (PDT)
Received: from localhost ([109.180.234.132])
        by smtp.gmail.com with ESMTPSA id e18-20020a05600c219200b003a0279f5935sm3999965wme.9.2022.06.23.10.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:21:16 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
References: <cover.1655368610.git.bristot@kernel.org>
        <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
Date:   Thu, 23 Jun 2022 18:21:15 +0100
In-Reply-To: <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
        (Daniel Bristot de Oliveira's message of "Thu, 16 Jun 2022 10:44:43
        +0200")
Message-ID: <87tu8bmh2s.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

A few flyby issues I noticed while going through the patches to
understand what RV offers.

For the typos, I wonder if it isn't better to use a spellcheck - they
unnecessarily detract from the review. Sorry for the annoyance!

Daniel Bristot de Oliveira <bristot@kernel.org> writes:

> RV is a lightweight (yet rigorous) method that complements classical
> exhaustive verification techniques (such as model checking and
> theorem proving) with a more practical approach to complex systems.
>
> RV works by analyzing the trace of the system's actual execution,
> comparing it against a formal specification of the system behavior.
> RV can give precise information on the runtime behavior of the
> monitored system while enabling the reaction for unexpected
> events, avoiding, for example, the propagation of a failure on
> safety-critical systems.
>
> The development of this interface roots in the development of the
> paper:
>
> DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
> Silva. Efficient formal verification for the Linux kernel. In:
> International Conference on Software Engineering and Formal Methods.
> Springer, Cham, 2019. p. 315-332.
>
> And:
>
> DE OLIVEIRA, Daniel Bristot, et al. Automata-based formal analysis
> and verification of the real-time Linux kernel. PhD Thesis, 2020.
>
> The RV interface resembles the tracing/ interface on purpose. The current
> path for the RV interface is /sys/kernel/tracing/rv/.
>
> It presents these files:
>
>  "available_monitors"
>    - List the available monitors, one per line.
>
>    For example:
>    [root@f32 rv]# cat available_monitors
>    wip
>    wwnr
>
>  "enabled_monitors"
>    - Lists the enabled monitors, one per line;
>    - Writing to it enables a given monitor;
>    - Writing a monitor name with a '-' prefix disables it;
>    - Truncating the file disables all enabled monitors.
>
>    For example:
>    [root@f32 rv]# cat enabled_monitors
>    [root@f32 rv]# echo wip > enabled_monitors
>    [root@f32 rv]# echo wwnr >> enabled_monitors
>    [root@f32 rv]# cat enabled_monitors
>    wip
>    wwnr
>    [root@f32 rv]# echo !wip >> enabled_monitors
>    [root@f32 rv]# cat enabled_monitors
>    wwnr
>    [root@f32 rv]# echo > enabled_monitors
>    [root@f32 rv]# cat enabled_monitors
>    [root@f32 rv]#
>
>    Note that more than one monitor can be enabled concurrently.
>
>  "monitoring_on"
>    - It is an on/off general switcher for monitoring. Note
>    that it does not disable enabled monitors, but stop the per-entity
>    monitors of monitoring the events received from the system.
>    It resambles the "tracing_on" switcher.

        resembles
>
>  "monitors/"
>    Each monitor will have its one directory inside "monitors/". There
>    the monitor specific files will be presented.
>    The "monitors/" directory resambles the "events" directory on

                               resembles

... and in the rest of the file.

>    tracefs.
>
>    For example:
>    [root@f32 rv]# cd monitors/wip/
>    [root@f32 wip]# ls
>    desc  enable
>    [root@f32 wip]# cat desc
>    auto-generated wakeup in preemptive monitor.
>    [root@f32 wip]# cat enable
>    0
>
> For further information, see the comments in the header of
> kernel/trace/rv/rv.c from this patch.
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
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  include/linux/rv.h       |  23 ++
>  include/linux/sched.h    |  11 +
>  include/rv/rv.h          |  23 ++
>  kernel/fork.c            |  14 +
>  kernel/trace/Kconfig     |   2 +
>  kernel/trace/Makefile    |   2 +
>  kernel/trace/rv/Kconfig  |  12 +
>  kernel/trace/rv/Makefile |   3 +
>  kernel/trace/rv/rv.c     | 738 +++++++++++++++++++++++++++++++++++++++
>  kernel/trace/rv/rv.h     |  34 ++
>  kernel/trace/trace.c     |   4 +
>  kernel/trace/trace.h     |   2 +
>  12 files changed, 868 insertions(+)
>  create mode 100644 include/linux/rv.h
>  create mode 100644 include/rv/rv.h
>  create mode 100644 kernel/trace/rv/Kconfig
>  create mode 100644 kernel/trace/rv/Makefile
>  create mode 100644 kernel/trace/rv/rv.c
>  create mode 100644 kernel/trace/rv/rv.h

[...]

> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> new file mode 100644
> index 000000000000..43af7b13187e
> --- /dev/null
> +++ b/kernel/trace/rv/rv.c
> @@ -0,0 +1,738 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This is the online Runtime Verification (RV) interface.
> + *
> + * RV is a lightweight (yet rigorous) method that complements classical
> + * exhaustive verification techniques (such as model checking and
> + * theorem proving) with a more practical approach to complex systems.
> + *
> + * RV works by analyzing the trace of the system's actual execution,
> + * comparing it against a formal specification of the system behavior.
> + * RV can give precise information on the runtime behavior of the
> + * monitored system while enabling the reaction for unexpected
> + * events, avoiding, for example, the propagation of a failure on
> + * safety-critical systems.
> + *
> + * The development of this interface roots in the development of the
> + * paper:
> + *
> + * DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
> + * Silva. Efficient formal verification for the Linux kernel. In:
> + * International Conference on Software Engineering and Formal Methods.
> + * Springer, Cham, 2019. p. 315-332.
> + *
> + * And:
> + *
> + * DE OLIVEIRA, Daniel Bristot, et al. Automata-based formal analysis
> + * and verification of the real-time Linux kernel. PhD Thesis, 2020.
> + *
> + * == Runtime monitor interface ==
> + *
> + * A monitor is the central part of the runtime verification of a system.
> + *
> + * The monitor stands in between the formal specification of the desired
> + * (or undesired) behavior, and the trace of the actual system.
> + *
> + * In Linux terms, the runtime verification monitors are encapsulated
> + * inside the "RV monitor" abstraction. A RV monitor includes a reference
> + * model of the system, a set of instances of the monitor (per-cpu monitor,
> + * per-task monitor, and so on), and the helper functions that glue the
> + * monitor to the system via trace. Generally, a monitor includes some form
> + * of trace output as a reaction for event parsing and exceptions,
> + * as depicted bellow:
> + *
> + * Linux  +----- RV Monitor ----------------------------------+ Formal
> + *  Realm |                                                   |  Realm
> + *  +-------------------+     +----------------+     +-----------------+
> + *  |   Linux kernel    |     |     Monitor    |     |     Reference   |
> + *  |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
> + *  | (instrumentation) |     | (verification) |     | (specification) |
> + *  +-------------------+     +----------------+     +-----------------+
> + *         |                          |                       |
> + *         |                          V                       |
> + *         |                     +----------+                 |
> + *         |                     | Reaction |                 |
> + *         |                     +--+--+--+-+                 |
> + *         |                        |  |  |                   |
> + *         |                        |  |  +-> trace output ?  |
> + *         +------------------------|--|----------------------+
> + *                                  |  +----> panic ?
> + *                                  +-------> <user-specified>
> + *
> + * This file implements the interface for loading RV monitors, and
> + * to control the verification session.
> + *
> + * == Registering monitors ==
> + *
> + * The struct rv_monitor defines a set of callback functions to control
> + * a verification session. For instance, when a given monitor is enabled,
> + * the "start" callback function is called to hook the instrumentation
> + * functions to the kernel trace events. The "stop" function is called
> + * when disabling the verification session.
> + *
> + * A RV monitor is registered via:
> + *   int rv_register_monitor(struct rv_monitor *monitor);
> + * And unregistered via:
> + *   int rv_unregister_monitor(struct rv_monitor *monitor);
> + *
> + * These functions are exported to modules, enabling verification monitors
> + * to be dynamically loaded.
> + *
> + * == User interface ==
> + *
> + * The user interface resembles kernel tracing interface. It presents
> + * these files:
> + *
> + *  "available_monitors"
> + *    - List the available monitors, one per line.
> + *
> + *    For example:
> + *    [root@f32 rv]# cat available_monitors
> + *    wip
> + *    wwnr
> + *
> + *  "enabled_monitors"
> + *    - Lists the enabled monitors, one per line;
> + *    - Writing to it enables a given monitor;
> + *    - Writing a monitor name with a '-' prefix disables it;
> + *    - Truncating the file disables all enabled monitors.
> + *
> + *    For example:
> + *    [root@f32 rv]# cat enabled_monitors
> + *    [root@f32 rv]# echo wip > enabled_monitors
> + *    [root@f32 rv]# echo wwnr >> enabled_monitors
> + *    [root@f32 rv]# cat enabled_monitors
> + *    wip
> + *    wwnr
> + *    [root@f32 rv]# echo !wip >> enabled_monitors
> + *    [root@f32 rv]# cat enabled_monitors
> + *    wwnr
> + *    [root@f32 rv]# echo > enabled_monitors
> + *    [root@f32 rv]# cat enabled_monitors
> + *    [root@f32 rv]#
> + *
> + *    Note that more than one monitor can be enabled concurrently.
> + *
> + *  "monitoring_on"
> + *    - It is an on/off general switcher for monitoring. Note
> + *    that it does not disable enabled monitors, but stop the per-entity
> + *    monitors of monitoring the events received from the system.
> + *    It resambles the "tracing_on" switcher.
> + *
> + *  "monitors/"
> + *    Each monitor will have its one directory inside "monitors/". There
> + *    the monitor specific files will be presented.
> + *    The "monitors/" directory resambles the "events" directory on
> + *    tracefs.
> + *
> + *    For example:
> + *    [root@f32 rv]# cd monitors/wip/
> + *    [root@f32 wip]# ls
> + *    desc  enable
> + *    [root@f32 wip]# cat desc
> + *    auto-generated wakeup in preemptive monitor.
> + *    [root@f32 wip]# cat enable
> + *    0
> + *
> + * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <rv/rv.h>
> +
> +#include "rv.h"
> +
> +DEFINE_MUTEX(rv_interface_lock);
> +struct rv_interface rv_root;
> +
> +struct dentry *get_monitors_root(void)
> +{
> +	return rv_root.monitors_dir;
> +}
> +
> +/*
> + * Monitoring on global switcher!
> + */
> +bool __read_mostly monitoring_on;
> +
> +/*
> + * Interface for the monitor register.
> + */
> +LIST_HEAD(rv_monitors_list);
> +
> +static int task_monitor_count;
> +static bool task_monitor_slots[RV_PER_TASK_MONITORS];
> +
> +int get_task_monitor_slot(void)
> +{
> +	int i;
> +
> +	lockdep_assert_held(&rv_interface_lock);
> +
> +	if (task_monitor_count == RV_PER_TASK_MONITORS)
> +		return -EBUSY;
> +
> +	task_monitor_count++;
> +
> +	for (i = 0; i < RV_PER_TASK_MONITORS; i++) {
> +		if (task_monitor_slots[i] == false) {
> +			task_monitor_slots[i] = true;
> +			return i;
> +		}
> +	}
> +
> +	WARN_ONCE(1, "RV task_monitor_cout and slots are out of sync\n");

                         task_monitor_count
> +
> +	return -EINVAL;
> +}
> +
> +void put_task_monitor_slot(int slot)
> +{
> +	lockdep_assert_held(&rv_interface_lock);
> +
> +	if (slot < 0 || slot > RV_PER_TASK_MONITORS) {
> +		WARN_ONCE(1, "RV releasing an invlid slot!: %d\n", slot);

                                              invalid
                                              
> +		return;
> +	}
> +
> +	WARN_ONCE(!task_monitor_slots[slot], "RV releasing unsused task_monitor_slots: %d\n",

                                                           unused

> +		  slot);
> +
> +	task_monitor_count--;
> +	task_monitor_slots[slot] = false;
> +}
> +
> +/*
> + * This section collects the monitor/ files and folders.
> + */
> +static ssize_t monitor_enable_read_data(struct file *filp,
> +					char __user *user_buf,
> +					size_t count, loff_t *ppos)
> +{
> +	struct rv_monitor_def *mdef = filp->private_data;
> +	char buff[4];
> +
> +	memset(buff, 0, sizeof(buff));

Not sure if the generated code is different, but the memset can be
rolled into buff declaration as -

char buff[4] = { 0 };

> +
> +	mutex_lock(&rv_interface_lock);
> +	sprintf(buff, "%x\n", mdef->monitor->enabled);
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return simple_read_from_buffer(user_buf, count, ppos,
> +				       buff, strlen(buff)+1);
> +}
> +
> +/*
> + * Disable a given runtime monitor.
> + */
> +static int disable_monitor(struct rv_monitor_def *mdef)
> +{
> +	if (mdef->monitor->enabled) {
> +		mdef->monitor->enabled = 0;
> +		mdef->monitor->stop();
> +	}
> +
> +	mdef->enabled = 0;
> +	return 0;
> +}
> +
> +/*
> + * Enable a given monitor.
> + */
> +static int enable_monitor(struct rv_monitor_def *mdef)
> +{
> +	int retval;
> +
> +	/*
> +	 * Reset all internal monitors before starting.
> +	 */
> +	mdef->monitor->reset();
> +	if (!mdef->monitor->enabled) {
> +		retval = mdef->monitor->start();
> +		if (retval)
> +			return retval;
> +	}
> +
> +	mdef->monitor->enabled = 1;
> +	mdef->enabled = 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * interface for enabling/disabling a monitor.
> + */
> +static ssize_t monitor_enable_write_data(struct file *filp,
> +					 const char __user *user_buf,
> +					 size_t count, loff_t *ppos)
> +{
> +	struct rv_monitor_def *mdef = filp->private_data;
> +	int retval;
> +	u64 val;
> +
> +	retval = kstrtoull_from_user(user_buf, count, 10, &val);

IIUC, kstrtobool_from_user() is better suited here.

Thanks,
Punit

> +	if (retval)
> +		return retval;
> +
> +	retval = count;
> +
> +	mutex_lock(&rv_interface_lock);
> +
> +	switch (val) {
> +	case 0:
> +		retval = disable_monitor(mdef);
> +		break;
> +	case 1:
> +		retval = enable_monitor(mdef);
> +		break;
> +	default:
> +		retval = -EINVAL;
> +	}
> +
> +	mutex_unlock(&rv_interface_lock);
> +
> +	return retval;
> +}
> +

[...]


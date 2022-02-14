Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551CE4B53DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355476AbiBNO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:57:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiBNO5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:57:51 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81362C4C;
        Mon, 14 Feb 2022 06:57:42 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s24so17659239oic.6;
        Mon, 14 Feb 2022 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=RU+P+XAzAbJhRHumUmSdEa9uqO+At7iottnaoJejHa0=;
        b=QuWvWjelv2SUTUerd43MaSrB1RMVEWz++FLF8IvemTb9qv5v5+8l5QVK9LfHchXnZt
         xAyqZAlBHn+SkdaAmW4wVmw/bt82I37CFz13uZtL87FoPFQwFRh4FHh8kOAOutq9dW4v
         P5GmbeF7ffUOy62HXFQnEOlNHLgBp9JBtUzViyER02OMJgNUZTVmg6fJK/w4PQ4evm3g
         JuhemSbJePmPJ1pNU1VQ0jM5BZvKaQbGEnF0Vi8/hiTwnZTz7Yg+zpjFYNucAlWil/Dv
         7FPtDBMYp7SynjXWigrm/UUNTx77+MruX4xYRLON/i3JWuT8wWMtYAzcrLenQnb3uoOa
         wmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=RU+P+XAzAbJhRHumUmSdEa9uqO+At7iottnaoJejHa0=;
        b=CjCwdD9NFwOl5ImH9JOrC7BD2Lzz+YoYuzwoHuBIkLqtKAghPF/Z2I9wr0B1eC4emb
         0ojxi3kDj6JtiZjMKG5bOdOxla8+G18Z7Qgm312jVg2u038JY9xNnbA/vPzO6rfJAz5K
         mVSwdxUlu61MZe8nOYkTLByUcxsyghOSx0pU/qSJR3u2axc4BGIsBI9dME5mFiJ36rpa
         UnfR1uEaJJ5HVvJK5FHbiizH2aOEZXC+KQWjO2Lq2dDvM7+UaeteTkl1DYbhK+7gAoGi
         +XNfg+wZM0wdENlQGqrvLII7U7EUK/cqqWld8H657nOI7eRm3h8ma2x0IEbqNP0GGGv9
         BJjg==
X-Gm-Message-State: AOAM532uCJxXYRsPEO8WSExN6bDOW6Xmb2N7l1NcaD3BI3hXybB9EORs
        ftlmcQGiVyFGO1uV0z04/h4=
X-Google-Smtp-Source: ABdhPJyvtt77epgA+MfRUazK9tlX1zaNoxCjY4HUiJ2IsOmSIiQS7/wZ10oJwcvnlEWWeJLQc9oK1w==
X-Received: by 2002:a05:6808:f93:: with SMTP id o19mr5653443oiw.201.1644850661828;
        Mon, 14 Feb 2022 06:57:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cm18sm4487976oab.7.2022.02.14.06.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:57:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6ead3577-75ec-1b9a-0c27-213a3a186c57@roeck-us.net>
Date:   Mon, 14 Feb 2022 06:57:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
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
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <cover.1644830251.git.bristot@kernel.org>
 <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC V2 17/21] watchdog/dev: Add tracepoints
In-Reply-To: <e67874c8b676ea8dfe38679efa25363889bb1e76.1644830251.git.bristot@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 02:45, Daniel Bristot de Oliveira wrote:
> Add a set of tracepoints, enabling the observability of the watchdog
> device interactions with user-space.
> 
> The events are:
> 	watchdog:watchdog_open
> 	watchdog:watchdog_close
> 	watchdog:watchdog_start
> 	watchdog:watchdog_stop
> 	watchdog:watchdog_set_timeout
> 	watchdog:watchdog_ping
> 	watchdog:watchdog_nowayout
> 	watchdog:watchdog_set_keep_alive
> 	watchdog:watchdog_keep_alive
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
>   drivers/watchdog/watchdog_dev.c |  41 ++++++++++++-
>   include/linux/watchdog.h        |   7 +--
>   include/trace/events/watchdog.h | 103 ++++++++++++++++++++++++++++++++
>   3 files changed, 142 insertions(+), 9 deletions(-)
>   create mode 100644 include/trace/events/watchdog.h
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 3a3d8b5c7ad5..0beeac5d4541 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -44,6 +44,9 @@
>   #include <linux/watchdog.h>	/* For watchdog specific items */
>   #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
>   
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/watchdog.h>
> +
>   #include "watchdog_core.h"
>   #include "watchdog_pretimeout.h"
>   
> @@ -130,9 +133,11 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd)
>   	if (watchdog_need_worker(wdd)) {
>   		ktime_t t = watchdog_next_keepalive(wdd);
>   
> -		if (t > 0)
> +		if (t > 0) {
>   			hrtimer_start(&wd_data->timer, t,
>   				      HRTIMER_MODE_REL_HARD);
> +			trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
> +		}
>   	} else {
>   		hrtimer_cancel(&wd_data->timer);
>   	}
> @@ -149,14 +154,16 @@ static int __watchdog_ping(struct watchdog_device *wdd)
>   	now = ktime_get();
>   
>   	if (ktime_after(earliest_keepalive, now)) {
> -		hrtimer_start(&wd_data->timer,
> -			      ktime_sub(earliest_keepalive, now),
> +		ktime_t t = ktime_sub(earliest_keepalive, now);

I am quite sure this line creates a checkpatch warning.

> +		hrtimer_start(&wd_data->timer, t,
>   			      HRTIMER_MODE_REL_HARD);
> +		trace_watchdog_set_keep_alive(wdd, ktime_to_ms(t));
>   		return 0;
>   	}
>   
>   	wd_data->last_hw_keepalive = now;
>   
> +	trace_watchdog_ping(wdd);
>   	if (wdd->ops->ping)
>   		err = wdd->ops->ping(wdd);  /* ping the watchdog */
>   	else
> @@ -215,6 +222,7 @@ static void watchdog_ping_work(struct kthread_work *work)
>   	wd_data = container_of(work, struct watchdog_core_data, work);
>   
>   	mutex_lock(&wd_data->lock);
> +	trace_watchdog_keep_alive(wd_data->wdd);
>   	if (watchdog_worker_should_ping(wd_data))
>   		__watchdog_ping(wd_data->wdd);
>   	mutex_unlock(&wd_data->lock);
> @@ -252,6 +260,8 @@ static int watchdog_start(struct watchdog_device *wdd)
>   
>   	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
>   
> +	trace_watchdog_start(wdd);
> +
>   	started_at = ktime_get();
>   	if (watchdog_hw_running(wdd) && wdd->ops->ping) {
>   		err = __watchdog_ping(wdd);
> @@ -298,6 +308,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
>   		return -EBUSY;
>   	}
>   
> +	trace_watchdog_stop(wdd);
>   	if (wdd->ops->stop) {
>   		clear_bit(WDOG_HW_RUNNING, &wdd->status);
>   		err = wdd->ops->stop(wdd);
> @@ -370,6 +381,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
>   	if (watchdog_timeout_invalid(wdd, timeout))
>   		return -EINVAL;
>   
> +	trace_watchdog_set_timeout(wdd, timeout);
>   	if (wdd->ops->set_timeout) {
>   		err = wdd->ops->set_timeout(wdd, timeout);
>   	} else {
> @@ -432,6 +444,23 @@ static int watchdog_get_timeleft(struct watchdog_device *wdd,
>   	return 0;
>   }
>   
> +/*

/** ?

> + * watchdog_set_nowayout - set nowaout bit
> + * @wdd:	The watchdog device to set nowayoutbit
> + * @nowayout	A boolean on/off switcher
> + *
> + * If nowayout boolean is true, the nowayout option is set. No action is
> + * taken if nowayout is false.
> + */
> +void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
> +{
> +	if (nowayout) {
> +		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
> +		trace_watchdog_nowayout(wdd);
> +	}
> +}
> +EXPORT_SYMBOL(watchdog_set_nowayout);
> +
>   #ifdef CONFIG_WATCHDOG_SYSFS
>   static ssize_t nowayout_show(struct device *dev, struct device_attribute *attr,
>   				char *buf)
> @@ -457,6 +486,7 @@ static ssize_t nowayout_store(struct device *dev, struct device_attribute *attr,
>   	/* nowayout cannot be disabled once set */
>   	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status) && !value)
>   		return -EPERM;
> +
>   	watchdog_set_nowayout(wdd, value);
>   	return len;
>   }
> @@ -858,6 +888,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
>   		goto out_clear;
>   	}
>   
> +	trace_watchdog_open(wdd);
> +
>   	err = watchdog_start(wdd);
>   	if (err < 0)
>   		goto out_mod;
> @@ -880,6 +912,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
>   	return stream_open(inode, file);
>   
>   out_mod:
> +	trace_watchdog_close(wdd);
>   	module_put(wd_data->wdd->ops->owner);
>   out_clear:
>   	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
> @@ -940,6 +973,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>   	/* make sure that /dev/watchdog can be re-opened */
>   	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
>   
> +	trace_watchdog_close(wdd);
>   done:
>   	running = wdd && watchdog_hw_running(wdd);
>   	mutex_unlock(&wd_data->lock);
> @@ -952,6 +986,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
>   		module_put(wd_data->cdev.owner);
>   		put_device(&wd_data->dev);
>   	}
> +

You may disagree with current empty lines or other cosmetics, but that is not an
acceptable reason for such changes. Please drop this change and the similar change
further up.

Guenter

>   	return 0;
>   }
>   
> diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
> index 99660197a36c..11d93407e492 100644
> --- a/include/linux/watchdog.h
> +++ b/include/linux/watchdog.h
> @@ -139,12 +139,7 @@ static inline bool watchdog_hw_running(struct watchdog_device *wdd)
>   	return test_bit(WDOG_HW_RUNNING, &wdd->status);
>   }
>   
> -/* Use the following function to set the nowayout feature */
> -static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
> -{
> -	if (nowayout)
> -		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
> -}
> +void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout);
>   
>   /* Use the following function to stop the watchdog on reboot */
>   static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
> diff --git a/include/trace/events/watchdog.h b/include/trace/events/watchdog.h
> new file mode 100644
> index 000000000000..5d5617ab611a
> --- /dev/null
> +++ b/include/trace/events/watchdog.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM watchdog
> +
> +#if !defined(_TRACE_WATCHDOG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_WATCHDOG_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(dev_operations_template,
> +
> +	TP_PROTO(struct watchdog_device *wdd),
> +
> +	TP_ARGS(wdd),
> +
> +	TP_STRUCT__entry(
> +		__field(__u32, id)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id = wdd->id;
> +	),
> +
> +	TP_printk("id=%d",
> +		  __entry->id)
> +);
> +
> +/*
> + * Add a comment
> + */
> +DEFINE_EVENT(dev_operations_template, watchdog_open,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_close,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_start,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_stop,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_ping,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_keep_alive,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +DEFINE_EVENT(dev_operations_template, watchdog_nowayout,
> +	     TP_PROTO(struct watchdog_device *wdd),
> +	     TP_ARGS(wdd));
> +
> +
> +TRACE_EVENT(watchdog_set_timeout,
> +
> +	TP_PROTO(struct watchdog_device *wdd, u64 timeout),
> +
> +	TP_ARGS(wdd, timeout),
> +
> +	TP_STRUCT__entry(
> +		__field(__u32, id)
> +		__field(__u64, timeout)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id		= wdd->id;
> +		__entry->timeout	= timeout;
> +	),
> +
> +	TP_printk("id=%d timeout=%llus",
> +		  __entry->id, __entry->timeout)
> +);
> +
> +TRACE_EVENT(watchdog_set_keep_alive,
> +
> +	TP_PROTO(struct watchdog_device *wdd, u64 timeout),
> +
> +	TP_ARGS(wdd, timeout),
> +
> +	TP_STRUCT__entry(
> +		__field(__u32, id)
> +		__field(__u64, timeout)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->id		= wdd->id;
> +		__entry->timeout	= timeout;
> +	),
> +
> +	TP_printk("id=%d keep_alive=%llums",
> +		  __entry->id, __entry->timeout)
> +);
> +
> +#endif /* _TRACE_WATCHDOG_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>


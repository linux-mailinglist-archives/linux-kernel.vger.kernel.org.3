Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0998D54FBE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382877AbiFQRHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382738AbiFQRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:06:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7607624BFF;
        Fri, 17 Jun 2022 10:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B18B82A3D;
        Fri, 17 Jun 2022 17:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88A5C3411B;
        Fri, 17 Jun 2022 17:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655485613;
        bh=TWRf9S0DkkNFAspAto5zRXm7MFZZZj7/c7f6uHAItdU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UR3gR07gwdSiUw3b7eyx+MTNahy1S/V5ouACcGPoOmaymAxktgRy8t3HfzW4AOjbn
         QQpTf8/eB7Ib0pLRps5zGwk3fzhTopGtSKqkL+U9AE39oW2wWji/dMRjtyeyllYtPX
         M2hwem6Fl4milyX602ysyf9vpbccbo8L4kzWeRqobhDleNsmpnH3jzZPxir/0OLnfE
         9aI7nm8Ukpqp1vgAEYSRvgIiWQhtKQYoGio2s71mHb4I1ajE+lBV2nMoKAE8ox+Exo
         S9WSSj4knzMw5h6FGXwcvruXKmK3eE0xOhbm3JydPdr3zwIPMzmUqF7i2UZBtD2ZcM
         Ljdxten3yizwg==
Message-ID: <9003420b-a74b-dfa4-37b5-ed7bb952a816@kernel.org>
Date:   Fri, 17 Jun 2022 19:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH V4 18/20] rv/monitor: Add safe watchdog monitor
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Gabriele Paoloni <gpaoloni@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <6366fdc89d65b8d9b14ccd1e42fa0d793fbe9f73.1655368610.git.bristot@kernel.org>
 <168af019-70d1-3237-dc9c-56a82beb5990@roeck-us.net>
 <04ca385b-47dc-5535-419e-1b814a383d1a@kernel.org>
 <CA+wEVJbvcMZbCroO2_rdVxLvYkUo-ePxCwsp5vbDpoqys4HGWQ@mail.gmail.com>
 <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <17ade9e2-8fbe-ea80-93c1-9f1e291805b6@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 01:53, Guenter Roeck wrote:
>>
>>     struct watchdog_device {
>>     ...
>>              #ifdef CONFIG_RV_MON_SAFE_WTD
>>              struct da_monitor da_mon;
>>              #endif
>>     ...
>>     }
>>
> 
> In my opinion shis should be dynamically allocated and not waste space in driver
> code if unused.

ack

>>     A simplified version of the the "per task" monitor, in the patch 01, changes in
>>
>>     include/linux/sched.h.
>>
>>      >> +
>>      >> +static void handle_nowayout(void *data, struct watchdog_device *wdd)
>>      >> +{
>>      >> +    if (wdd->id != watchdog_id)
>>      >> +        return;
>>      >> +
>>      >> +    da_handle_init_run_event_safe_wtd(nowayout_safe_wtd);
>>      >> +}
>>      >> +
>>      >> +static void handle_close(void *data, struct watchdog_device *wdd)
>>      >> +{
>>      >> +    if (wdd->id != watchdog_id)
>>      >> +        return;
>>      >> +
>>      >> +    if (open_pid && current->pid != open_pid) {
>>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>>      >> +    } else {
>>      >> +        da_handle_event_safe_wtd(close_safe_wtd);
>>      >> +        open_pid = 0;
>>      >> +    }
>>      >> +}
>>      >> +
>>      >> +static void handle_open(void *data, struct watchdog_device *wdd)
>>      >> +{
>>      >> +    if (wdd->id != watchdog_id)
>>      >> +        return;
>>      >> +
>>      >> +    if (open_pid && current->pid != open_pid) {
>>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>>      >> +    } else {
>>      >> +        da_handle_init_run_event_safe_wtd(open_safe_wtd);
>>      >> +        open_pid = current->pid;
>>      >> +    }
>>      >> +}
>>      >> +
>>      >> +static void blocked_events(void *data, struct watchdog_device *wdd)
>>      >> +{
>>      >> +    if (wdd->id != watchdog_id)
>>      >> +        return;
>>      >> +
>>      >> +    if (open_pid && current->pid != open_pid) {
>>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>>      >> +        return;
>>      >> +    }
>>      >> +    da_handle_event_safe_wtd(other_threads_safe_wtd);
>>      >> +}
>>      >> +
>>      >> +static void blocked_events_timeout(void *data, struct watchdog_device *wdd,
>>
>>      >> u64 timeout)
>>      >> +{
>>      >> +    blocked_events(data, wdd);
>>      >> +}
>>      >> +
>>      >> +static void handle_ping(void *data, struct watchdog_device *wdd)
>>      >> +{
>>      >> +    char msg[128];
>>      >> +    unsigned int timeout;
>>      >> +
>>      >> +    if (wdd->id != watchdog_id)
>>      >> +        return;
>>      >> +
>>      >> +    if (open_pid && current->pid != open_pid) {
>>      >> +        da_handle_init_run_event_safe_wtd(other_threads_safe_wtd);
>>      >> +        return;
>>      >> +    }
>>      >> +
>>      >> +    da_handle_event_safe_wtd(ping_safe_wtd);
>>      >> +
>>      >> +    if (!check_timeout)
>>      >> +        return;
>>      >> +
>>      >> +    if (wdd->ops->get_timeleft) {
>>      >> +        timeout = wdd->ops->get_timeleft(wdd);
>>      >> +        if (timeout > last_timeout_set) {
>>      >> +            snprintf(msg, 128,
>>      >> +                 "watchdog timeout is %u > than previously set (%d)\n",
>>      >> +                 timeout, last_timeout_set);
>>      >> +            cond_react(msg);
>>      >> +        }
>>      >> +    } else {
>>      >> +        snprintf(msg, 128, "error getting timeout: option not supported\n");
>>
>>      >
>>      > This is not an error. The get_timeleft callback is optional.
>>
>>     Right... but this part of the code is only reachable if the user explicitly
>>     asked to check the timeout (if (!check_timeout)...return before this code).
>>
>>     So, if the user only considers the system safe if the monitor also checks the
>>     written timeout, but the watchdog is one of those that do not have the callback
>>
>>     implemented (which is ok for a Linux watchdog), the monitor captures this
>>     "undesired" behavior.
>>
>>     This monitor is not checking if the watchdog subsystem is correct at its
>>     plenitude, it is checking if the watchdog usage is following a set of
>>     specifications (raised by people in the LF Elisa workgroup).
>>
> 
> The kernel is not intended for special use cases. The callback is optional,
> period. The test for check_timeout is way too late. A check like this should
> be made when the check is requested, not when it is executed - in other words,
> when the user requests it. That request should fail.
> 
>>      >> +        cond_react(msg);
>>      >> +    }

[...]

>>      >
>>      > I find this event table all but impossible to verify.
>>
>>     It is a matrix. Lines are states, and columns are events.
>>
>>     On a given state/line, receiving a given event/column, the data is the next
>>     state/row.
>>
> 
> I am aware of that, and I did program state machines before.
> 
>>     For instance, let's say "init" (row 0), event "nwo" (column 1), and the next
>>     state is the "nwo" (row 3).
>>
>>     -1 means invalid/blocked state (yeah, maybe it is better to have an #define
>>     INVALID_STATE -1).
>>
>>     This is the C representation of an automaton, following the formal definition of
>>
>>     a deterministic automaton. I've added an explanation of this representation in
>>
>>     the documentation (patch 15, file da_monitor_synthesis.rst).
>>
>>     A deeper look into this subject is here (peer-reviewed conference paper at
>>     Software Engineer and Formal Methods 2019):
>>     https://bristot.me/wp-content/uploads/2019/09/paper.pdf <https://bristot.me/wp-content/uploads/2019/09/paper.pdf>
>>
>>
>>     One could translate it back to the automaton's graphical format... to a format
>>
>>     of by a tool used to analyze automaton properties... that is the good point of
>>
>>     using a well-established formalism. (The bad part is that they are often
>>     boring... c'est la vie :-)).
>>
> 
> If the above state machine fails, no one but the authors will be able to even
> remotely figure out what happened, and if the watchdog driver is at fault or
> its monitor.

That is a point we can improve. If we look only for the matrix, yes, it is not
the best way to try to understand what is going on. I agree.

The idea here is that one can describe the expected behavior and check. But we fail
to explain the reasons for these choices... 

The patch "20/20 Documentation/rv: Add watchdog-monitor documentation" attempts
to explain the idea behind the monitor, and includes the ASCII representation
of the monitor. But indeed, it fails on explaining why those assumptions were
made, what it is trying to monitor, and what it is not...

It is a state machine making assumptions about state transitions,
> sure, but who knows if those asssumptions are even remotely correct or match
> reality. For example, I have no idea if the lack of a 'ping' function is handled
> correctly,  if the lack of a 'stop' function is handled correctly, or what
> happens if any of the driver functions returns an error.
> 
> I already found three assumptions which do not or not necessarily match
> reality:
> 
> - The function to read the remaining timeout is optional and must not be
>   used unconditionally, and its lack is not an error.

Ack, that can be removed.

> - The requested timeout (and pretimeout) do not have to match the actually
>   configured timeout, and userspace must not rely on the assumption that
>   the values match.

I agree, the model is lacking that, and it needs it.

> - The code assumes that the process opening the watchdog and the process
>   accessing it are the same. While that is in general the case, it might
>   well be that some application opens the watchdog and then handles it
>   from a child process.

What is not clear on our documentation are the reasons behind these choices.
They are based on a hazard analysis made by people safety experts in the
Elisa group, that need to be clarified.

/me looks at people from Elisa...

-- Daniel

> And that is just after briefly browsing through the code> I am open to suggestions from others, but at this point I have serious doubts
> that this code is maintainable in the kernel.
> 
> Guenter


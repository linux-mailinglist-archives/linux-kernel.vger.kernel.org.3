Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDA34CB56F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiCCDXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiCCDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:23:36 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3A26553
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:22:42 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id c18so4325767ioc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 19:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KK9Ei6yMR+T5N5uCRbXdDdVbW21hbJY4s9I7wLm75CA=;
        b=E6jApVxHZvA5/FjKggfs7TxTxfLoRsh6nxRGdZYfo7u61E5OLSMUayDQ/T7Od8Byel
         Yb82torzgsPcjiLIfkX2tKP4reQkjbPsFErFn3aXg37JrCo8OUB4c6OoOGlCnUkIfKTg
         /h1uaiIMJEYTAvQP9HXY4ZvggTDHuEZjB4Tkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KK9Ei6yMR+T5N5uCRbXdDdVbW21hbJY4s9I7wLm75CA=;
        b=ydMfJqNWYs88ud4Fc9aPgeTIDSIS75RQ8G4uGWvyn/OqOSMSySsUPXbrYV7KP/WZ12
         UhlEEW36M1wQkijNv8gJa6vEfARWoFMsrfQYj7obrDpLw6hiEcUuKBLdif1VBk33msTV
         iRnb7zm62l+8AdKbli5zvC9g2B8Y5IR1GHce+Bi7lFkZCcsAG+/1UB1aG7DReWlFdSBO
         SqMgmie0lpeRU/x1PvmHVYsIxGIskA8cfYshwprM8NdnrfNyxa0SKw25c+3+aYy6DdJT
         w3EdcZT6JEafFIvXnTAESdY3r3dpnLY8TooZM7T0/jzlauzvIF3jtUFzlFqy7Ep7+nmL
         KSTg==
X-Gm-Message-State: AOAM531V5sIX9gGZGV+NjT+or8MdBG2rNi17DCQcwqaoK4j+hp7EVzs2
        wBSx8z/D5OOh5jL3LZPPOiQ5V/duIzvTvRbKbSRb3A==
X-Google-Smtp-Source: ABdhPJymhjuNfr7ZpoHlQZL4N3doEeceqatQU4Jjmti0YQ73IJyD4kmyGvBXLUWDvT1jTbsj+Nn431LBxRhP3AExu5w=
X-Received: by 2002:a05:6638:4784:b0:315:2bd5:8202 with SMTP id
 cq4-20020a056638478400b003152bd58202mr26610481jab.257.1646277761682; Wed, 02
 Mar 2022 19:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20220302032414.503960863@goodmis.org> <20220302032820.877781830@goodmis.org>
In-Reply-To: <20220302032820.877781830@goodmis.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 2 Mar 2022 22:22:30 -0500
Message-ID: <CAEXW_YQ4id4-GOgYzP_U2BLx8VVKy=RRLQgmV-npHETG5SqL2g@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: Add sample code for custom trace events
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Tue, Mar 1, 2022 at 10:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> Add sample code to show how to create custom trace events in the tracefs
> directory that can be enabled and modified like any event in tracefs
> (including triggers, histograms, synthetic events and event probes).
>
> The example is creating a custom sched_switch and a sched_waking to limit
> what is recorded:
>
> If the custom sched switch only records the prev_prio, next_prio and
> next_pid, it can bring the size from 64 bytes per event, down to just 16
> bytes!
>
> If sched_waking only records the prio and pid of the woken event, it will
> bring the size down from 36 bytes to 12 bytes per event.
>
> This will allow for a much smaller footprint into the ring buffer and keep
> more events from dropping.
>
> Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Just 2 event fields related comments below, but other than that I
tested and it works quite well so:
Tested-By: Joel Fernandes <joel@joelfernandes.org>

> ---
[..]
> diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
> new file mode 100644
> index 000000000000..5271a567d99b
> --- /dev/null
> +++ b/samples/trace_events/trace_custom_sched.c
> @@ -0,0 +1,280 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * event tracer
> + *
> + * Copyright (C) 2022 Google Inc, Steven Rostedt <rostedt@goodmis.org>
> + */
> +
> +#define pr_fmt(fmt) fmt
> +
> +#include <linux/trace_events.h>
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/sched.h>
> +#include <trace/events/sched.h>
> +
> +#define THIS_SYSTEM "custom_sched"
> +
> +#define SCHED_PRINT_FMT                                                        \
> +       C("prev_prio=%d next_pid=%d next_prio=%d", REC->prev_prio, REC->next_pid, \

Probably prev_pid should be included so we know what the previous task was?

Or are you expecting that a prior sched_switch would have that
information? If so, then prev_prio is also not needed as the previous
sched_switch's next_prio would have the prio. That would save even
more space too..

> +         REC->next_prio)
> +
> +#define SCHED_WAKING_FMT                               \
> +       C("pid=%d prio=%d", REC->pid, REC->prio)
> +

I think including the target_cpu of a wake up is also really important
to show where the task is going to be awakened, and maybe we can drop
prio since a subsequent sched_switch will have the priority in
next_prio.

[..]
> +static void __exit trace_sched_exit(void)
> +{
> +       trace_set_clr_event(THIS_SYSTEM, "sched_switch", 0);
> +       trace_set_clr_event(THIS_SYSTEM, "sched_waking", 0);
> +
> +       trace_remove_event_call(&sched_switch_call);
> +       trace_remove_event_call(&sched_waking_call);
> +}
> +
> +module_init(trace_sched_init);
> +module_exit(trace_sched_exit);
> +
> +MODULE_AUTHOR("Steven Rostedt");
> +MODULE_DESCRIPTION("Custom scheduling events");
> +MODULE_LICENSE("GPL");
> +

Remove extra lines from the end of the file?

Thanks,
            Joel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7050C57CE59
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiGUO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiGUO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:57:27 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358686C39;
        Thu, 21 Jul 2022 07:57:23 -0700 (PDT)
Date:   Thu, 21 Jul 2022 22:57:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658415441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HnJf3a3R/WDtkPI32iClfgBxpOQWUhxqHOYGsZd26QY=;
        b=GdErNbbWgx1K8NgDU1VOOBBzhzkydujCEG+dIXTO5rqjXdQ4uALRBFSQIlECtB0b10E0n1
        l3bxbzSgFHWEgMf1CePnOVqX+Qt9nNFm6PeKldh63AQdTpGSfflTCK9+De5fgf/QoHknF1
        0Q7yHEiFdotNEEqfXVNPX4ergSGbLms=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH V6 11/16] Documentation/rv: Add deterministic automata
 instrumentation documentation
Message-ID: <YtlpSGp590YJXT22@geo.homenetwork>
References: <cover.1658244826.git.bristot@kernel.org>
 <3c915ffd00f033d57dbac2f69e56a87b7b80adba.1658244826.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c915ffd00f033d57dbac2f69e56a87b7b80adba.1658244826.git.bristot@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:27:16PM +0200, Daniel Bristot de Oliveira wrote:

> +Looking at the automata definition, it is possible to see that the system
> +and the model are expected to return to the initial state after the
> +preempt_enable execution. Hence, it can be used to synchronize the
> +system and the model at the initialization of the monitoring section.
> +
> +The start is informed via a special handle function, the
> +"da_handle_start_event_MONITOR_event)", in this case::

da_handle_start_event_$MONITOR(event) the same as the previous version
should be right.

> +
> +  da_handle_start_event_wip(preempt_disable_wip);

I didn't see this in last version that the event should be preempt_enable_wip.

> +
> +So, the callback function will look like::
> +
> +  void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
> +  {
> +        da_handle_start_event_wip(preempt_enable_wip);
> +  }
> +
> +Finally, the "handle_sched_waking()" will look like::
> +
> +  void handle_sched_waking(void *data, struct task_struct *task)
> +  {
> +        da_handle_event_wip(sched_waking_wip);
> +  }
> +
> +And the explanation is left for the reader as an exercise.
> +
> +Start and Stop functions

Start and Stop functions are changed to enable and disable functions.

> +------------------------
> +
> +dot2k automatically creates two special functions::
> +
> +  enable_MONITOR()
> +  disable_MONITOR()
> +
> +These functions are called when the monitor is enabled and disabled,
> +respectively.
> +
> +They should be used to *attach* and *detach* the instrumentation to the running
> +system. The developer must add to the relative function all that is needed to
> +*attach* and *detach* its monitor to the system.
> +
> +For the wip case, these functions were named::
> +
> + enable_wip()
> + disable_wip()
> +
> +But no change was required because: by default, these functions *attach* and
> +*detach* the tracepoints_to_attach, which was enough for this case.

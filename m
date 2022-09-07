Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF125B0FFE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIGWov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiIGWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:44:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26E128E38
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:44:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C7A61AF5
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 22:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691B1C433C1;
        Wed,  7 Sep 2022 22:44:44 +0000 (UTC)
Date:   Wed, 7 Sep 2022 18:45:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220907184524.0dfb3a8a@gandalf.local.home>
In-Reply-To: <YxkS5uzouv2bn6ZB@google.com>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
        <20220907174604.06809ff2@gandalf.local.home>
        <20220907174813.182df339@gandalf.local.home>
        <YxkS5uzouv2bn6ZB@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Sep 2022 14:53:42 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Try these:
> 
>   umount /sys/kernel/debug/tracing/
>   grep tracefs /proc/mounts
>   stat /sys/kernel/debug/tracing/.
>   grep tracefs /proc/mounts
> 
> The first and the second grep will give you different results.

How about this:

  # grep tracefs /proc/mounts
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
tracefs /sys/kernel/debug/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0

 # umount /sys/kernel/debug/tracing 
 # grep tracefs /proc/mounts
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0

 # ls /sys/kernel/debug/tracing
available_events            hwlat_detector       set_event_notrace_pid   trace_clock
available_filter_functions  instances            set_event_pid           trace_marker
available_tracers           kprobe_events        set_ftrace_filter       trace_marker_raw
buffer_percent              kprobe_profile       set_ftrace_notrace      trace_options
buffer_size_kb              max_graph_depth      set_ftrace_notrace_pid  trace_pipe
buffer_total_size_kb        options              set_ftrace_pid          trace_stat
current_tracer              osnoise              set_graph_function      tracing_cpumask
dynamic_events              per_cpu              set_graph_notrace       tracing_max_latency
dyn_ftrace_total_info       printk_formats       snapshot                tracing_on
enabled_functions           README               stack_max_size          tracing_thresh
error_log                   recursed_functions   stack_trace             uprobe_events
eval_map                    saved_cmdlines       stack_trace_filter      uprobe_profile
events                      saved_cmdlines_size  synthetic_events        user_events_data
free_buffer                 saved_tgids          timestamp_mode          user_events_status
function_profile_enabled    set_event            trace

 # grep tracefs /proc/mounts
tracefs /sys/kernel/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0
tracefs /sys/kernel/debug/tracing tracefs rw,nosuid,nodev,noexec,relatime 0 0

So it appears that accessing debugfs/tracing will automatically remount it.

Lean something new everyday! ;-)

-- Steve

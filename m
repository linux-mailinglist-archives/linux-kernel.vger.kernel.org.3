Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760A95B0F61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiIGVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiIGVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:45:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51947539A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D93B81F29
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 21:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6990CC433D6;
        Wed,  7 Sep 2022 21:45:24 +0000 (UTC)
Date:   Wed, 7 Sep 2022 17:46:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracefs: Only clobber mode/uid/gid on remount if
 asked
Message-ID: <20220907174604.06809ff2@gandalf.local.home>
In-Reply-To: <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
References: <20220826174353.1.Icbd40fce59f55ad74b80e5d435ea233579348a78@changeid>
        <20220826174353.2.Iab6e5ea57963d6deca5311b27fb7226790d44406@changeid>
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

On Fri, 26 Aug 2022 17:44:17 -0700
Brian Norris <briannorris@chromium.org> wrote:

> Users may have explicitly configured their tracefs permissions; we
> shouldn't overwrite those just because a second mount appeared.
> 
> Only clobber if the options were provided at mount time.
> 
> Note: the previous behavior was especially surprising in the presence of
> automounted /sys/kernel/debug/tracing/.
> 
>   # Don't change /sys/kernel/tracing/ permissions on automount.
>   umount /sys/kernel/debug/tracing/

BTW, I noticed that the above doesn't do anything. That is,
you cannot unmount tracefs from /sys/kernel/debug/tracing.

 # ls /sys/kernel/debug/tracing/
available_events            buffer_total_size_kb   error_log                 hwlat_detector   options         recursed_functions   set_event_notrace_pid   set_ftrace_pid      stack_trace         trace_clock       trace_stat           uprobe_events
available_filter_functions  current_tracer         eval_map                  instances        osnoise         saved_cmdlines       set_event_pid           set_graph_function  stack_trace_filter  trace_marker      tracing_cpumask      uprobe_profile
available_tracers           dynamic_events         events                    kprobe_events    per_cpu         saved_cmdlines_size  set_ftrace_filter       set_graph_notrace   synthetic_events    trace_marker_raw  tracing_max_latency  user_events_data
buffer_percent              dyn_ftrace_total_info  free_buffer               kprobe_profile   printk_formats  saved_tgids          set_ftrace_notrace      snapshot            timestamp_mode      trace_options     tracing_on           user_events_status
buffer_size_kb              enabled_functions      function_profile_enabled  max_graph_depth  README          set_event            set_ftrace_notrace_pid  stack_max_size      trace               trace_pipe        tracing_thresh

  # umount /sys/kernel/debug/tracing/

  # ls /sys/kernel/debug/tracing/
available_events            buffer_total_size_kb   error_log                 hwlat_detector   options         recursed_functions   set_event_notrace_pid   set_ftrace_pid      stack_trace         trace_clock       trace_stat           uprobe_events
available_filter_functions  current_tracer         eval_map                  instances        osnoise         saved_cmdlines       set_event_pid           set_graph_function  stack_trace_filter  trace_marker      tracing_cpumask      uprobe_profile
available_tracers           dynamic_events         events                    kprobe_events    per_cpu         saved_cmdlines_size  set_ftrace_filter       set_graph_notrace   synthetic_events    trace_marker_raw  tracing_max_latency  user_events_data
buffer_percent              dyn_ftrace_total_info  free_buffer               kprobe_profile   printk_formats  saved_tgids          set_ftrace_notrace      snapshot            timestamp_mode      trace_options     tracing_on           user_events_status
buffer_size_kb              enabled_functions      function_profile_enabled  max_graph_depth  README          set_event            set_ftrace_notrace_pid  stack_max_size      trace               trace_pipe        tracing_thresh


-- Steve



>   stat /sys/kernel/debug/tracing/.
> 
>   # Don't change /sys/kernel/tracing/ permissions.
>   mount -t tracefs none /mnt/foo
> 
>   # Change /sys/kernel/tracing/ mode and uid, but not gid.
>   mount -t tracefs -o uid=bar,mode=0750 none /mnt/baz
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>

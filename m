Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8C4C2008
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbiBWXkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244999AbiBWXkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:40:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296845AEE2;
        Wed, 23 Feb 2022 15:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19D10CE1CF0;
        Wed, 23 Feb 2022 23:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5055CC340F5;
        Wed, 23 Feb 2022 23:39:41 +0000 (UTC)
Date:   Wed, 23 Feb 2022 18:39:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-trace-devel@vger.kernel.org" 
        <linux-trace-devel@vger.kernel.org>,
        Linux-trace Users <linux-trace-users@vger.kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Zamir SUN <sztsian@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, zsun@redhat.com,
        Vitaly Chikunov <vt@altlinux.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Yordan Karadzhov <ykaradzhov@vmware.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tony Jones <tonyj@suse.de>, John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Al Stone <ahs3@debian.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jes Sorensen <jes.sorensen@gmail.com>
Subject: [ANNOUNCE] libtracefs 1.3
Message-ID: <20220223183939.3650aabd@rorschach.local.home>
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

Long over due, but libtracefs 1.3 has finally been released!

With 90 new interfaces, it makes accessing tracefs much simpler.

Official release notes:

libtracefs 1.3

Critical:
 - Optimized string list handling. It was always stated that some string
   lists must be freed with tracefs_list_free(), and now it is mandatory, as
   metadata is used to store the size, and normal freeing of the list will
   cause memory issues.

Fixes:
 - More consistency with errno values

Notes:
 - sqlhist is now officially built
 - make samples creates executables in bin/ from examples in the man pages.

New methods:

 - New methods for setting and reading affinity
    tracefs_instance_set_affinity_set()
    tracefs_instance_set_affinity_raw()
    tracefs_instance_set_affinity()
    tracefs_instance_get_affinity()
    tracefs_instance_get_affinity_raw()
    tracefs_instance_get_affinity_set()

 - New method to see the system tracers
    tracefs_instances()

 - New methods to read and clear the error log
    tracefs_error_last()
    tracefs_error_all()
    tracefs_error_clear()

 - New methods to modify the string lists
    tracefs_list_add()
    tracefs_list_size()

 - New method to stop the iterator over raw events
    tracefs_iterate_stop()

 - New methods to make it easier to access event files
    tracefs_event_get_file()
    tracefs_event_file_read()
    tracefs_event_file_write()
    tracefs_event_file_append()
    tracefs_event_file_clear()
    tracefs_event_file_exists()

 - New method to get the available filter functions
    tracefs_filter_functions()

 - New methods to enable or disable tracers
    tracefs_tracer_set()
    tracefs_tracer_clear()

 - New methods for streaming the trace_pipe file
    tracefs_trace_pipe_stream()
    tracefs_trace_pipe_print()
    tracefs_trace_pipe_stop()

 - New methods for creating, modifying and destroying dynamic events
    tracefs_dynevent_create()
    tracefs_dynevent_destroy()
    tracefs_dynevent_destroy_all()
    tracefs_dynevent_free()
    tracefs_dynevent_list_free()
    tracefs_dynevent_get_all()
    tracefs_dynevent_get()
    tracefs_dynevent_info()
    tracefs_dynevent_get_event()

 - New method to create an event probe (then use dynamic methods above)
    tracefs_eprobe_alloc()

 - New methods to create kprobes and kretprobes
    tracefs_kprobe_alloc()
    tracefs_kretprobe_alloc()
    tracefs_kprobe_raw()
    tracefs_kretprobe_raw()

 - New methods for creating, modifying and destroying histograms
    tracefs_hist_free()
    tracefs_hist_alloc()
    tracefs_hist_alloc_2d()
    tracefs_hist_alloc_nd()
    tracefs_hist_get_name()
    tracefs_hist_get_event()
    tracefs_hist_get_system()
    tracefs_hist_add_key()
    tracefs_hist_add_value()
    tracefs_hist_add_sort_key()
    tracefs_hist_set_sort_key()
    tracefs_hist_sort_key_direction()
    tracefs_hist_add_name()
    tracefs_hist_append_filter()
    tracefs_hist_echo_cmd()
    tracefs_hist_command()
    tracefs_hist_start()
    tracefs_hist_pause()
    tracefs_hist_continue()
    tracefs_hist_reset()
    tracefs_hist_destroy()

 - New methods for creating, modifying and destroying synthetic events
    tracefs_synth_get_name()
    tracefs_synth *tracefs_synth_alloc()
    tracefs_synth_add_match_field()
    tracefs_synth_add_compare_field()
    tracefs_synth_add_start_field()
    tracefs_synth_add_end_field()
    tracefs_synth_append_start_filter()
    tracefs_synth_append_end_filter()
    tracefs_synth_trace()
    tracefs_synth_snapshot()
    tracefs_synth_save()
    tracefs_synth_complete()
    tracefs_synth_get_start_hist()
    tracefs_synth_create()
    tracefs_synth_destroy()
    tracefs_synth_free()
    tracefs_synth_echo_cmd()
    tracefs_synth_raw_fmt()
    tracefs_synth_show_event()
    tracefs_synth_show_start_hist()
    tracefs_synth_show_end_hist()
    tracefs_synth_get_event()

 - New methods to modify event filters
    tracefs_filter_string_append()
    tracefs_filter_string_verify()
    tracefs_event_filter_apply()
    tracefs_event_filter_clear()
    tracefs_event_append_filter()
    tracefs_event_verify_filter()

 - New method to create a synthetic event via a SQL string
    tracefs_sql()
    The man page comes with its own program (sqlhist).

Enjoy!

-- Steve


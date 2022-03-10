Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8427B4D53C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 22:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344046AbiCJVpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 16:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343994AbiCJVp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:45:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61028158E81;
        Thu, 10 Mar 2022 13:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75D161A39;
        Thu, 10 Mar 2022 21:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9424CC340E8;
        Thu, 10 Mar 2022 21:44:23 +0000 (UTC)
Date:   Thu, 10 Mar 2022 16:44:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        "linux-trace-users@vger.kernel.org" 
        <linux-trace-users@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Changbin Du <changbin.du@gmail.com>,
        Patrick McLean <chutzpah@gentoo.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        John Kacur <jkacur@redhat.com>, Tony Jones <tonyj@suse.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Wagner <wagi@monom.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Josef Bacik <jbacik@fb.com>, troyengel@gmail.com,
        Behan Webster <behanw@converseincode.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [ANNOUNCE] trace-cmd 3.0
Message-ID: <20220310164422.41c57c7c@gandalf.local.home>
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

[ Resending without corrupted email headers ]

I'm happy to announce that after over a year, we finally are able to
release trace-cmd version 3.0!

The two biggest changes:

1) Updated trace.dat to version 7 (not compatible with older versions of
   trace-cmd). But now supports compression.

2) Better synchronization between host and guest kernel tracing.


Features and user visible updates since 2.9:

- Relies on upstream repos for libtraceevent and libtracefs:
    * Removed libtraceevent code (Upstream minimum version 1.5)
    * Removed libtracefs code (Upstream minimum version 1.3)

- KernelShark is no longer installed in the trace-cmd repo.

- Some perf support

- trace-cmd dump updates:
   * Display the clock used in the file

- New trace-cmd clock: tsc2nsec to use the tsc clock in the ring buffer but
  to display it as nanoseconds. Requires architecture support, but trace-cmd
  list -C will show if it supported or not.

- New option --raw-ts for trace-cmd report to show raw timestamps without any
  modifications.

- New timestamp synchronization between host and guests.
   * P2P : timing back and forth of host and guest
   * KVM : queries the kernel for the multiplier, offset and shift for exact
           synchronization of host and guest timestamps.

- tracecmd_warning() API for writing error messages in libtracecmd library.

- Better bash tab completion.

- Plugins now go into /usr/[local/]lib/trace-cmd instead of traceevent
  directory.

- New option --full for trace-cmd list to show "print fmt" of event formats
  specified by -e <event> -F

- trace-cmd list now shows ftrace events as well as events that can be
  enabled.

- Supports non qemu VM host/guest tracing.

- New option --align-ts for trace-cmd report that will make the timestamps of
  all events a delta from the first event. (0.000003 instead of 16292.633984)

- New option -V for trace-cmd report to change verbosity.

- New option --verbose for a bunch of commands to trace-cmd.

- New option --poll for trace-cmd record to poll which makes trace-cmd check
  the buffers with O_NONBLOCK instead of relying on IPIs to wake it up. This
  reduces latency on recording tasks that trace-cmd is not running on.

- trace.dat output has been updated to Version 7 (incompatible with older
  trace-cmd, but trace-cmd convert can convert back to version 6, with
  possible lost of features).
   * The file is broken up into sections (defined as options) just like an ELF
     file.
   * Allows for sections to be compressed.
      .  Supports zlib compression
      .  Supports ZSTD compression
   * Will allow for new types of data to be added
      . Target for perf data to be included (still in development)

- New command: trace-cmd convert, to convert between trace-cmd 7 and 6 files.

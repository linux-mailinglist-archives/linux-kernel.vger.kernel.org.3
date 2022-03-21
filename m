Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B064E2AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349409AbiCUOfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349857AbiCUOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC8B99
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 550E560AF7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 14:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E53C340E8;
        Mon, 21 Mar 2022 14:30:37 +0000 (UTC)
Date:   Mon, 21 Mar 2022 10:30:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [GIT PULL] tracing/rtla: Updates to the RTLA tool
Message-ID: <20220321103035.564a1df5@gandalf.local.home>
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


Linus,

I'm sending this as a separate pull request from my normal tracing tree, as
it had dependencies to commits in your tree but not in my development
branch. As it only affects the tools/ directory, I kept it separate as it
has no changes to the kernel itself.

Real Time Linux Analysis Tool updates for 5.18

Changes to RTLA:

 - Support for adjusting tracing_threashold

 - Add -a (auto) option to make it easier for users to debug in the field

 - Add -e option to add more events to the trace

 - Add --trigger option to add triggers to events

 - Add --filter option to filter events

 - Add support to save histograms to the file

 - Add --dma-latency to set /dev/cpu_dma_latency

 - Other fixes and cleanups

Please pull the latest trace-rtla-v5.18 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-rtla-v5.18

Tag SHA1: cc921ea64d6df1bb8955ff5762dbcdc408e34264
Head SHA1: 75016ca3acd0de79868ef5b0694195fe05288ade


Daniel Bristot de Oliveira (15):
      rtla/osnoise: Add support to adjust the tracing_thresh
      rtla/osnoise: Add an option to set the threshold
      rtla/osnoise: Add the automatic trace option
      rtla/timerlat: Add the automatic trace option
      rtla/trace: Add trace events helpers
      rtla: Add -e/--event support
      rtla/trace: Add trace event trigger helpers
      rtla: Add --trigger support
      rtla/trace: Add trace event filter helpers
      rtla: Add --filter support
      rtla/trace: Save event histogram output to a file
      rtla: Check for trace off also in the trace instance
      rtla/osnoise: Fix osnoise hist stop tracing message
      rtla/timerlat: Add --dma-latency option
      rtla: Tools main loop cleanup

----
 Documentation/tools/rtla/common_options.rst        |  19 ++
 .../tools/rtla/common_osnoise_options.rst          |  10 +
 .../tools/rtla/common_timerlat_options.rst         |  12 +
 tools/tracing/rtla/src/osnoise.c                   |  83 +++++
 tools/tracing/rtla/src/osnoise.h                   |   8 +
 tools/tracing/rtla/src/osnoise_hist.c              |  95 +++++-
 tools/tracing/rtla/src/osnoise_top.c               |  91 +++++-
 tools/tracing/rtla/src/timerlat_hist.c             | 108 ++++++-
 tools/tracing/rtla/src/timerlat_top.c              | 103 +++++-
 tools/tracing/rtla/src/trace.c                     | 345 +++++++++++++++++++++
 tools/tracing/rtla/src/trace.h                     |  23 ++
 tools/tracing/rtla/src/utils.c                     |  33 ++
 tools/tracing/rtla/src/utils.h                     |   1 +
 13 files changed, 903 insertions(+), 28 deletions(-)
---------------------------

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE5B5122DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiD0Tj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiD0Tjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BDA25F3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FBE960E06
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97B2C385A9;
        Wed, 27 Apr 2022 19:36:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSp-002Io6-Ii;
        Wed, 27 Apr 2022 15:36:39 -0400
Message-ID: <20220427193623.529296556@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/21] tracing: Updates for 5.19
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next-core

Head SHA1: 6621a7004684bfcff5af4c8e4d37989941f42a6b


Ammar Faizi (2):
      tracing: Return -EINVAL if WARN_ON(!glob) triggered in event_hist_trigger_parse()
      tracing: Change `if (strlen(glob))` to `if (glob[0])`

Christophe Leroy (1):
      MAINTAINERS: Enlarge coverage of TRACING inside architectures

Guo Zhengkui (1):
      tracing: Use WARN instead of printk and WARN_ON

Jeff Xie (1):
      tracing: Make tp_printk work on syscall tracepoints

Jiapeng Chong (1):
      tracing: Fix kernel-doc

Jun Miao (1):
      tracing: Fix sleeping function called from invalid context on RT kernel

Mark-PK Tsai (2):
      tracing: Avoid adding tracer option before update_tracer_options
      tracing: make tracer_init_tracefs initcall asynchronous

Masami Hiramatsu (4):
      bootconfig: Make the bootconfig.o as a normal object file
      bootconfig: Check the checksum before removing the bootconfig from initrd
      bootconfig: Support embedding a bootconfig file in kernel
      docs: bootconfig: Add how to embed the bootconfig into kernel

Oscar Shiang (1):
      tracing: Fix inconsistent style of mini-HOWTO

Tom Rix (1):
      tracing: Cleanup double word in comment

Tom Zanussi (4):
      tracing: Remove logic for registering multiple event triggers at a time
      tracing: Remove redundant trigger_ops params
      tracing: Have existing event_command.parse() implementations use helpers
      tracing: Separate hist state updates from hist registration

Wan Jiabing (1):
      ring-buffer: Simplify if-if to if-else

Yang Li (1):
      tracing: Fix tracing_map_sort_entries() kernel-doc comment

----
 Documentation/admin-guide/bootconfig.rst |  31 +++-
 MAINTAINERS                              |   5 +-
 include/linux/bootconfig.h               |  10 ++
 init/Kconfig                             |  21 ++-
 init/main.c                              |  38 ++--
 kernel/trace/pid_list.c                  |   4 +-
 kernel/trace/ring_buffer.c               |   4 +-
 kernel/trace/trace.c                     |  51 ++++--
 kernel/trace/trace.h                     |  26 ++-
 kernel/trace/trace_eprobe.c              |  10 +-
 kernel/trace/trace_events_hist.c         | 171 +++++++++---------
 kernel/trace/trace_events_trigger.c      | 292 ++++++++++---------------------
 kernel/trace/trace_output.c              |  12 +-
 kernel/trace/trace_syscalls.c            |  35 ++--
 kernel/trace/tracing_map.c               |   3 +-
 lib/.gitignore                           |   1 +
 lib/Makefile                             |  10 +-
 lib/bootconfig-data.S                    |  10 ++
 lib/bootconfig.c                         |  13 ++
 19 files changed, 364 insertions(+), 383 deletions(-)
 create mode 100644 lib/bootconfig-data.S

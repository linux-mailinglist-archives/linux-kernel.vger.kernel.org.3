Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9601F4F0A2E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359033AbiDCOdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358998AbiDCOdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:33:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9460C2FFE2
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C975B80D56
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 14:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB9AC3410F;
        Sun,  3 Apr 2022 14:31:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nb1GV-001EfC-Dh;
        Sun, 03 Apr 2022 10:31:39 -0400
Message-ID: <20220403142500.388473000@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 03 Apr 2022 10:25:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/7] tracing: Updates to the last pull request for 5.18
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Updates to Tracing:

- Rename the staging files to give them some meaning.
  Just stage1,stag2,etc, does not show what they are for

- Check for NULL from allocation in bootconfig

- Hold event mutex for dyn_event call in user events

- Mark user events to broken (to work on the API)

- Remove eBPF updates from user events

- Remove user events from uapi header to keep it from being installed.

- Move ftrace_graph_is_dead() into inline as it is called from hot paths
  and also convert it into a static branch.


Beau Belgrave (2):
      tracing/user_events: Hold event_mutex during dyn_event_add
      tracing/user_events: Remove eBPF interfaces

Christophe Leroy (1):
      ftrace: Make ftrace_graph_is_dead() a static branch

Lv Ruyi (1):
      proc: bootconfig: Add null pointer check

Steven Rostedt (Google) (3):
      tracing: Rename the staging files for trace_events
      tracing: Set user_events to BROKEN
      tracing: Move user_events.h temporarily out of include/uapi

----
 Documentation/trace/user_events.rst                | 14 +---
 fs/proc/bootconfig.c                               |  2 +
 include/linux/ftrace.h                             | 16 +++-
 include/{uapi => }/linux/user_events.h             | 53 -------------
 .../{stage1_defines.h => stage1_struct_define.h}   |  0
 .../{stage2_defines.h => stage2_data_offsets.h}    |  0
 .../{stage3_defines.h => stage3_trace_output.h}    |  0
 .../{stage4_defines.h => stage4_event_fields.h}    |  0
 .../{stage5_defines.h => stage5_get_offsets.h}     |  0
 .../{stage6_defines.h => stage6_event_callback.h}  |  0
 .../{stage7_defines.h => stage7_class_define.h}    |  0
 include/trace/trace_custom_events.h                | 14 ++--
 include/trace/trace_events.h                       | 14 ++--
 kernel/trace/Kconfig                               |  1 +
 kernel/trace/fgraph.c                              | 17 +----
 kernel/trace/trace_events_user.c                   | 86 +++-------------------
 16 files changed, 50 insertions(+), 167 deletions(-)
 rename include/{uapi => }/linux/user_events.h (58%)
 rename include/trace/stages/{stage1_defines.h => stage1_struct_define.h} (100%)
 rename include/trace/stages/{stage2_defines.h => stage2_data_offsets.h} (100%)
 rename include/trace/stages/{stage3_defines.h => stage3_trace_output.h} (100%)
 rename include/trace/stages/{stage4_defines.h => stage4_event_fields.h} (100%)
 rename include/trace/stages/{stage5_defines.h => stage5_get_offsets.h} (100%)
 rename include/trace/stages/{stage6_defines.h => stage6_event_callback.h} (100%)
 rename include/trace/stages/{stage7_defines.h => stage7_class_define.h} (100%)

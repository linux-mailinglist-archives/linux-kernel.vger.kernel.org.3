Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379057530C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiGNQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiGNQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95F4A83C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDDD462044
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F576C34115;
        Thu, 14 Jul 2022 16:43:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w0-004lKe-2F;
        Thu, 14 Jul 2022 12:43:28 -0400
Message-ID: <20220714164256.403842845@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:42:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/23] tracing: Updates for 5.20
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linyu Yuan (4):
      tracing: eprobe: Add missing log index
      tracing: eprobe: Remove duplicate is_good_name() operation
      tracing: Auto generate event name when creating a group of events
      selftests/ftrace: Add test case for GRP/ only input

Steven Rostedt (Google) (17):
      tracing: devlink: Use static array for string in devlink_trap_report even
      tracing/ipv4/ipv6: Use static array for name field in fib*_lookup_table event
      neighbor: tracing: Have neigh_create event use __string()
      tracing/events: Add __vstring() and __assign_vstr() helper macros
      tracing/IB/hfi1: Use the new __vstring() helper
      tracing/ath: Use the new __vstring() helper
      tracing/brcm: Use the new __vstring() helper
      tracing/iwlwifi: Use the new __vstring() helper
      usb: chipidea: tracing: Use the new __vstring() helper
      xhci: tracing: Use the new __vstring() helper
      USB: mtu3: tracing: Use the new __vstring() helper
      usb: musb: tracing: Use the new __vstring() helper
      scsi: iscsi: tracing: Use the new __vstring() helper
      scsi: qla2xxx: tracing: Use the new __vstring() helper
      batman-adv: tracing: Use the new __vstring() helper
      mac80211: tracing: Use the new __vstring() helper
      selftests/kprobe: Do not test for GRP/ without event failures

Xiang wangx (1):
      tracing/user_events: Fix syntax errors in comments

Zheng Yejian (1):
      tracing/histograms: Simplify create_hist_fields()

----
 Documentation/trace/kprobetrace.rst                |  8 +++----
 Documentation/trace/uprobetracer.rst               |  8 +++----
 drivers/infiniband/hw/hfi1/trace_dbg.h             |  8 ++-----
 drivers/net/wireless/ath/ath10k/trace.h            | 14 ++++-------
 drivers/net/wireless/ath/ath11k/trace.h            |  7 ++----
 drivers/net/wireless/ath/ath6kl/trace.h            | 14 ++++-------
 drivers/net/wireless/ath/trace.h                   |  7 ++----
 drivers/net/wireless/ath/wil6210/trace.h           |  7 ++----
 .../broadcom/brcm80211/brcmfmac/tracepoint.h       | 12 ++++------
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h  | 12 ++++------
 .../net/wireless/intel/iwlwifi/iwl-devtrace-msg.h  | 12 ++++------
 drivers/usb/chipidea/trace.h                       |  4 ++--
 drivers/usb/host/xhci-trace.h                      |  4 ++--
 drivers/usb/mtu3/mtu3_trace.h                      |  4 ++--
 drivers/usb/musb/musb_trace.h                      |  4 ++--
 include/linux/trace_events.h                       | 18 ++++++++++++++
 include/trace/events/devlink.h                     |  7 +++---
 include/trace/events/fib.h                         |  6 ++---
 include/trace/events/fib6.h                        |  8 +++----
 include/trace/events/iscsi.h                       |  4 ++--
 include/trace/events/neigh.h                       |  2 +-
 include/trace/events/qla.h                         |  4 ++--
 include/trace/stages/stage1_struct_define.h        |  3 +++
 include/trace/stages/stage2_data_offsets.h         |  3 +++
 include/trace/stages/stage4_event_fields.h         |  3 +++
 include/trace/stages/stage5_get_offsets.h          |  4 ++++
 include/trace/stages/stage6_event_callback.h       |  7 ++++++
 kernel/trace/trace.c                               |  8 +++----
 kernel/trace/trace_dynevent.c                      |  2 +-
 kernel/trace/trace_eprobe.c                        | 28 +++++++++++-----------
 kernel/trace/trace_events_hist.c                   |  5 ++--
 kernel/trace/trace_events_user.c                   |  2 +-
 kernel/trace/trace_kprobe.c                        | 16 ++++++++-----
 kernel/trace/trace_probe.c                         |  4 ++++
 kernel/trace/trace_uprobe.c                        | 12 ++++++----
 net/batman-adv/trace.h                             |  7 ++----
 net/mac80211/trace_msg.h                           |  6 ++---
 .../ftrace/test.d/dynevent/add_remove_eprobe.tc    |  9 ++++++-
 .../ftrace/test.d/dynevent/add_remove_kprobe.tc    |  7 ++++++
 .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |  1 -
 40 files changed, 160 insertions(+), 141 deletions(-)

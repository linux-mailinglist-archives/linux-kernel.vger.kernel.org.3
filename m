Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C047178C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhLLB0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhLLB0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3020EC061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 17:26:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F206DB80BFA
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE647C004DD;
        Sun, 12 Dec 2021 01:26:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdU-000kC2-NF;
        Sat, 11 Dec 2021 20:26:44 -0500
Message-ID: <20211212012617.690710310@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/11] tracing: More updates for 5.17
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: 85c62c8c3749eec02ba81217bdcac26867dc262e


Beau Belgrave (1):
      tracing: Do not let synth_events block other dyn_event systems during create

Jiri Olsa (1):
      tracing: Iterate trace_[ku]probe objects directly

John Keeping (1):
      tracing: Make trace_marker{,_raw} stream-like

Steven Rostedt (VMware) (2):
      tracefs: Use d_inode() helper function to get the dentry inode
      tracing: Use trace_iterator_reset() in tracing_read_pipe()

Tom Zanussi (4):
      tracing: Change event_command func() to parse()
      tracing: Change event_trigger_ops func() to trigger()
      tracing: Add helper functions to simplify event_command.parse() callback handling
      tracing: Have existing event_command.parse() implementations use helpers

Xiu Jianfeng (1):
      tracing: Use memset_startat helper in trace_iterator_reset()

Yinan Liu (1):
      script/sorttable: Code style improvements

----
 fs/tracefs/inode.c                  |  24 +-
 kernel/trace/trace.c                |  21 +-
 kernel/trace/trace.h                |  72 +++--
 kernel/trace/trace_eprobe.c         |  11 +-
 kernel/trace/trace_events_hist.c    | 109 +++----
 kernel/trace/trace_events_synth.c   |  13 +-
 kernel/trace/trace_events_trigger.c | 558 ++++++++++++++++++++++++++----------
 kernel/trace/trace_kprobe.c         |  13 +-
 kernel/trace/trace_uprobe.c         |  23 +-
 scripts/sorttable.h                 |   4 +-
 10 files changed, 558 insertions(+), 290 deletions(-)

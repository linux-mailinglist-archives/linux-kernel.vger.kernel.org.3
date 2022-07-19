Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E5B57A9B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiGSWUR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jul 2022 18:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiGSWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:20:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464346431;
        Tue, 19 Jul 2022 15:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09998B81D95;
        Tue, 19 Jul 2022 22:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79915C341C6;
        Tue, 19 Jul 2022 22:20:06 +0000 (UTC)
Date:   Tue, 19 Jul 2022 18:20:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arun Easi <aeasi@marvell.com>, Daniel Wagner <dwagner@suse.de>,
        Nilesh Javali <njavali@marvell.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>, <bhazarika@marvell.com>,
        <agurumurthy@marvell.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] tracing: Use a copy of the va_list for __assign_vstr()
Message-ID: <20220719182004.21daa83e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If an instance of tracing enables the same trace event as another
instance, or the top level instance, or even perf, then the va_list passed
into some tracepoints can be used more than once.

As va_list can only be traversed once, this can cause issues:

 # cat /sys/kernel/tracing/instances/qla2xxx/trace
             cat-56106   [012] ..... 2419873.470098: ql_dbg_log: qla2xxx [0000:05:00.0]-1054:14:  Entered (null).
             cat-56106   [012] ..... 2419873.470101: ql_dbg_log: qla2xxx [0000:05:00.0]-1000:14:  Entered ×+<96>²Ü<98>^H.
             cat-56106   [012] ..... 2419873.470102: ql_dbg_log: qla2xxx [0000:05:00.0]-1006:14:  Prepare to issue mbox cmd=0xde589000.

 # cat /sys/kernel/tracing/trace
             cat-56106   [012] ..... 2419873.470097: ql_dbg_log: qla2xxx [0000:05:00.0]-1054:14:  Entered qla2x00_get_firmware_state.
             cat-56106   [012] ..... 2419873.470100: ql_dbg_log: qla2xxx [0000:05:00.0]-1000:14:  Entered qla2x00_mailbox_command.
             cat-56106   [012] ..... 2419873.470102: ql_dbg_log: qla2xxx [0000:05:00.0]-1006:14:  Prepare to issue mbox cmd=0x69.

The instance version is corrupted because the top level instance iterated
the va_list first.

Use va_copy() in the __assign_vstr() macro to make sure that each trace
event for each use case gets a fresh va_list.

Link: https://lore.kernel.org/all/259d53a5-958e-6508-4e45-74dba2821242@marvell.com/

Reported-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

 This means that the __vstring/__assign_vstr() series, with this patch is
 actually a bug fix and not a clean up. These will probably need to go
 to stable after they hit Linus's tree. I'll still wait till the merge
 window as it's not far away and I'd like these to sit in linux-next
 for a bit too.

 include/trace/stages/stage6_event_callback.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index 0f51f6b3ab70..3c554a585320 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -40,7 +40,12 @@
 
 #undef __assign_vstr
 #define __assign_vstr(dst, fmt, va)					\
-	vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, *(va))
+	do {								\
+		va_list __cp_va;					\
+		va_copy(__cp_va, *(va));				\
+		vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, __cp_va); \
+		va_end(__cp_va);					\
+	} while (0)
 
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
-- 
2.35.1


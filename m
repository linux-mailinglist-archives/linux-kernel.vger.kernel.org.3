Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADD5463CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 18:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbhK3RlB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 30 Nov 2021 12:41:01 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41048 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbhK3RlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 12:41:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9288B81A8D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:37:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C70C53FCC;
        Tue, 30 Nov 2021 17:37:37 +0000 (UTC)
Date:   Tue, 30 Nov 2021 12:37:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] tracing/histograms: String compares should not care about
 signed values
Message-ID: <20211130123736.7c3cab27@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 95f7262b44dc54fed8007cc3db8b39cbd16999c6 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Tue, 30 Nov 2021 12:31:23 -0500
Subject: [PATCH] tracing/histograms: String compares should not care about
 signed values

When comparing two strings for the "onmatch" histogram trigger, fields
that are strings use string comparisons, which do not care about being
signed or not.

Do not fail to match two string fields if one is unsigned char array and
the other is a signed char array.

Link: https://lore.kernel.org/all/20211129123043.5cfd687a@gandalf.local.home/

Cc: stable@vgerk.kernel.org
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>
Fixes: b05e89ae7cf3b ("tracing: Accept different type for synthetic event fields")
Reported-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9555b8e1d1e3..319f9c8ca7e7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3757,7 +3757,7 @@ static int check_synth_field(struct synth_event *event,
 
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
-		    field->is_signed != hist_field->is_signed)
+		    (!field->is_string && field->is_signed != hist_field->is_signed))
 			return -EINVAL;
 	}
 
-- 
2.31.1


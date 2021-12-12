Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008AD471790
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 02:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbhLLB06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 20:26:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43712 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhLLB0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 20:26:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63AB0B80C6D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 01:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71604C341D3;
        Sun, 12 Dec 2021 01:26:46 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mwDdV-000kEp-L6;
        Sat, 11 Dec 2021 20:26:45 -0500
Message-ID: <20211212012645.494928680@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 11 Dec 2021 20:26:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 05/11] tracing: Do not let synth_events block other dyn_event systems during
 create
References: <20211212012617.690710310@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

synth_events is returning -EINVAL if the dyn_event create command does
not contain ' \t'. This prevents other systems from getting called back.
synth_events needs to return -ECANCELED in these cases when the command
is not targeting the synth_event system.

Link: https://lore.kernel.org/linux-trace-devel/20210930223821.11025-1-beaub@linux.microsoft.com

Fixes: c9e759b1e8456 ("tracing: Rework synthetic event command parsing")
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 98e002648994..149011e34ad9 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -2053,6 +2053,13 @@ static int create_synth_event(const char *raw_command)
 
 	last_cmd_set(raw_command);
 
+	name = raw_command;
+
+	/* Don't try to process if not our system */
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
+	name += 2;
+
 	p = strpbrk(raw_command, " \t");
 	if (!p) {
 		synth_err(SYNTH_ERR_INVALID_CMD, 0);
@@ -2061,12 +2068,6 @@ static int create_synth_event(const char *raw_command)
 
 	fields = skip_spaces(p);
 
-	name = raw_command;
-
-	if (name[0] != 's' || name[1] != ':')
-		return -ECANCELED;
-	name += 2;
-
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-- 
2.33.0

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5A46510D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhLAPPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:15:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35450 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242368AbhLAPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:14:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 856E3B82014;
        Wed,  1 Dec 2021 15:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4966BC53FCD;
        Wed,  1 Dec 2021 15:11:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1msRGh-000d2d-FF;
        Wed, 01 Dec 2021 10:11:35 -0500
Message-ID: <20211201151135.303922837@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Dec 2021 10:10:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vgerk.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [for-linus][PATCH 1/2] tracing/histograms: String compares should not care about signed
 values
References: <20211201150959.545092970@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

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
2.33.0

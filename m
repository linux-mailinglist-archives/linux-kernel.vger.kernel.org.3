Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112B949FDFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350166AbiA1QYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350084AbiA1QXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA5C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:23:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F253B82647
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0016C340F5;
        Fri, 28 Jan 2022 16:23:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2K-00AT0F-55;
        Fri, 28 Jan 2022 11:23:44 -0500
Message-ID: <20220128162343.987732028@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Subject: [for-linus][PATCH 04/10] tracing/perf: Avoid -Warray-bounds warning for __rel_loc macro
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

As done for trace_events.h, also fix the __rel_loc macro in perf.h,
which silences the -Warray-bounds warning:

In file included from ./include/linux/string.h:253,
                 from ./include/linux/bitmap.h:11,
                 from ./include/linux/cpumask.h:12,
                 from ./include/linux/mm_types_task.h:14,
                 from ./include/linux/mm_types.h:5,
                 from ./include/linux/buildid.h:5,
                 from ./include/linux/module.h:14,
                 from samples/trace_events/trace-events-sample.c:2:
In function '__fortify_strcpy',
    inlined from 'perf_trace_foo_rel_loc' at samples/trace_events/./trace-events-sample.h:519:1:
./include/linux/fortify-string.h:47:33: warning: '__builtin_strcpy' offset 12 is out of the bounds [
0, 4] [-Warray-bounds]
   47 | #define __underlying_strcpy     __builtin_strcpy
      |                                 ^
./include/linux/fortify-string.h:445:24: note: in expansion of macro '__underlying_strcpy'
  445 |                 return __underlying_strcpy(p, q);
      |                        ^~~~~~~~~~~~~~~~~~~

Also make __data struct member a proper flexible array to avoid future
problems.

Link: https://lkml.kernel.org/r/20220125220037.2738923-1-keescook@chromium.org

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 55de2c0b5610c ("tracing: Add '__rel_loc' using trace event macros")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/perf.h         | 5 +++--
 include/trace/trace_events.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/perf.h b/include/trace/perf.h
index ea4405de175a..5d48c46a3008 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -23,8 +23,9 @@
 
 #undef __get_rel_dynamic_array
 #define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+		((void *)__entry +					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 65d927e059d3..3d29919045af 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -128,7 +128,7 @@ TRACE_MAKE_SYSTEM_STR();
 	struct trace_event_raw_##name {					\
 		struct trace_entry	ent;				\
 		tstruct							\
-		char			__data[0];			\
+		char			__data[];			\
 	};								\
 									\
 	static struct trace_event_class event_class_##name;
-- 
2.33.0

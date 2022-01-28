Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178349FDF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350095AbiA1QXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350062AbiA1QXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:23:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CAC061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:23:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D21661F23
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0759C340EA;
        Fri, 28 Jan 2022 16:23:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nDU2J-00ASzh-VI;
        Fri, 28 Jan 2022 11:23:43 -0500
Message-ID: <20220128162343.802534491@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Jan 2022 11:18:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 03/10] tracing: Avoid -Warray-bounds warning for __rel_loc macro
References: <20220128161802.711119424@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since -Warray-bounds checks the destination size from the type of given
pointer, __assign_rel_str() macro gets warned because it passes the
pointer to the 'u32' field instead of 'trace_event_raw_*' data structure.
Pass the data address calculated from the 'trace_event_raw_*' instead of
'u32' __rel_loc field.

Link: https://lkml.kernel.org/r/20220125233154.dac280ed36944c0c2fe6f3ac@kernel.org

Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
[ This did not fix the warning, but is still a nice clean up ]
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 8c6f7c433518..65d927e059d3 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -318,9 +318,10 @@ TRACE_MAKE_SYSTEM_STR();
 #define __get_str(field) ((char *)__get_dynamic_array(field))
 
 #undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)	\
-		((void *)(&__entry->__rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +		\
+#define __get_rel_dynamic_array(field)					\
+		((void *)__entry + 					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
 		 (__entry->__rel_loc_##field & 0xffff))
 
 #undef __get_rel_dynamic_array_len
-- 
2.33.0

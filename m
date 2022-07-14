Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDB575345
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 18:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238929AbiGNQoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 12:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiGNQnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEBE263
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA75B8273D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A762C341D7;
        Thu, 14 Jul 2022 16:43:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w1-004lO2-5l;
        Thu, 14 Jul 2022 12:43:29 -0400
Message-ID: <20220714164329.013262074@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:43:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Antonio Quartulli <a@unstable.cc>,
        Sven Eckelmann <sven@narfation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [for-next][PATCH 06/23] tracing/events: Add __vstring() and __assign_vstr() helper macros
References: <20220714164256.403842845@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's several places that open code the following logic:

  TP_STRUCT__entry(__dynamic_array(char, msg, MSG_MAX)),
  TP_fast_assign(vsnprintf(__get_str(msg), MSG_MAX, vaf->fmt, *vaf->va);)

To load a string created by variable array va_list.

The main issue with this approach is that "MSG_MAX" usage in the
__dynamic_array() portion. That actually just reserves the MSG_MAX in the
event, and even wastes space because there's dynamic meta data also saved
in the event to denote the offset and size of the dynamic array. It would
have been better to just use a static __array() field.

Instead, create __vstring() and __assign_vstr() that work like __string
and __assign_str() but instead of taking a destination string to copy,
take a format string and a va_list pointer and fill in the values.

It uses the helper:

 #define __trace_event_vstr_len(fmt, va)	\
 ({						\
	va_list __ap;				\
	int __ret;				\
						\
	va_copy(__ap, *(va));			\
	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
	va_end(__ap);				\
						\
	min(__ret, TRACE_EVENT_STR_MAX);	\
 })

To figure out the length to store the string. It may be slightly slower as
it needs to run the vsnprintf() twice, but it now saves space on the ring
buffer.

Link: https://lkml.kernel.org/r/20220705224749.053570613@goodmis.org

Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Peter Chen <peter.chen@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Bin Liu <b-liu@ti.com>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jim Cromie <jim.cromie@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h                 | 18 ++++++++++++++++++
 include/trace/stages/stage1_struct_define.h  |  3 +++
 include/trace/stages/stage2_data_offsets.h   |  3 +++
 include/trace/stages/stage4_event_fields.h   |  3 +++
 include/trace/stages/stage5_get_offsets.h    |  4 ++++
 include/trace/stages/stage6_event_callback.h |  7 +++++++
 6 files changed, 38 insertions(+)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6e95a9f07a5..e6f8ba52a958 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -916,6 +916,24 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
 
 #endif
 
+#define TRACE_EVENT_STR_MAX	512
+
+/*
+ * gcc warns that you can not use a va_list in an inlined
+ * function. But lets me make it into a macro :-/
+ */
+#define __trace_event_vstr_len(fmt, va)		\
+({						\
+	va_list __ap;				\
+	int __ret;				\
+						\
+	va_copy(__ap, *(va));			\
+	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
+	va_end(__ap);				\
+						\
+	min(__ret, TRACE_EVENT_STR_MAX);	\
+})
+
 #endif /* _LINUX_TRACE_EVENT_H */
 
 /*
diff --git a/include/trace/stages/stage1_struct_define.h b/include/trace/stages/stage1_struct_define.h
index a16783419687..1b7bab60434c 100644
--- a/include/trace/stages/stage1_struct_define.h
+++ b/include/trace/stages/stage1_struct_define.h
@@ -26,6 +26,9 @@
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __vstring
+#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
diff --git a/include/trace/stages/stage2_data_offsets.h b/include/trace/stages/stage2_data_offsets.h
index 42fd1e8813ec..1b7a8f764fdd 100644
--- a/include/trace/stages/stage2_data_offsets.h
+++ b/include/trace/stages/stage2_data_offsets.h
@@ -32,6 +32,9 @@
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __vstring
+#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
diff --git a/include/trace/stages/stage4_event_fields.h b/include/trace/stages/stage4_event_fields.h
index e80cdc397a43..c3790ec7a453 100644
--- a/include/trace/stages/stage4_event_fields.h
+++ b/include/trace/stages/stage4_event_fields.h
@@ -38,6 +38,9 @@
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __vstring
+#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index 7ee5931300e6..fba4c24ed9e6 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -39,6 +39,10 @@
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
 
+#undef __vstring
+#define __vstring(item, fmt, ap) __dynamic_array(char, item,		\
+		      __trace_event_vstr_len(fmt, ap))
+
 #undef __rel_dynamic_array
 #define __rel_dynamic_array(type, item, len)				\
 	__item_length = (len) * sizeof(type);				\
diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
index e1724f73594b..0f51f6b3ab70 100644
--- a/include/trace/stages/stage6_event_callback.h
+++ b/include/trace/stages/stage6_event_callback.h
@@ -24,6 +24,9 @@
 #undef __string_len
 #define __string_len(item, src, len) __dynamic_array(char, item, -1)
 
+#undef __vstring
+#define __vstring(item, fmt, ap) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
@@ -35,6 +38,10 @@
 		__get_str(dst)[len] = '\0';				\
 	} while(0)
 
+#undef __assign_vstr
+#define __assign_vstr(dst, fmt, va)					\
+	vsnprintf(__get_str(dst), TRACE_EVENT_STR_MAX, fmt, *(va))
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
-- 
2.35.1

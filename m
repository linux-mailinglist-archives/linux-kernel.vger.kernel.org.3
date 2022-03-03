Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D759D4CC891
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiCCWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbiCCWHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80F171EE0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AE7561D9D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE0BC340EC;
        Thu,  3 Mar 2022 22:06:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtab-00ESXS-NC;
        Thu, 03 Mar 2022 17:06:25 -0500
Message-ID: <20220303220625.553406495@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 17:05:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/4 v3] tracing: Move the defines to create TRACE_EVENTS into their own files
References: <20220303220530.058538533@goodmis.org>
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

In an effort to add custom event macros that can be used to create your
own custom events based on existing tracepoints, move the defines of the
special macros used in TRACE_EVENT() into their own files such that they
can be reused for TRACE_CUSTOM_EVENT().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/stages/init.h           |  37 ++
 include/trace/stages/stage1_defines.h |  46 +++
 include/trace/stages/stage2_defines.h |  48 +++
 include/trace/stages/stage3_defines.h | 129 +++++++
 include/trace/stages/stage4_defines.h |  57 +++
 include/trace/stages/stage5_defines.h |  83 +++++
 include/trace/stages/stage6_defines.h |  86 +++++
 include/trace/stages/stage7_defines.h |  34 ++
 include/trace/trace_events.h          | 499 +-------------------------
 9 files changed, 528 insertions(+), 491 deletions(-)
 create mode 100644 include/trace/stages/init.h
 create mode 100644 include/trace/stages/stage1_defines.h
 create mode 100644 include/trace/stages/stage2_defines.h
 create mode 100644 include/trace/stages/stage3_defines.h
 create mode 100644 include/trace/stages/stage4_defines.h
 create mode 100644 include/trace/stages/stage5_defines.h
 create mode 100644 include/trace/stages/stage6_defines.h
 create mode 100644 include/trace/stages/stage7_defines.h

diff --git a/include/trace/stages/init.h b/include/trace/stages/init.h
new file mode 100644
index 000000000000..000bcfc8dd2e
--- /dev/null
+++ b/include/trace/stages/init.h
@@ -0,0 +1,37 @@
+
+#define __app__(x, y) str__##x##y
+#define __app(x, y) __app__(x, y)
+
+#define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
+
+#define TRACE_MAKE_SYSTEM_STR()				\
+	static const char TRACE_SYSTEM_STRING[] =	\
+		__stringify(TRACE_SYSTEM)
+
+TRACE_MAKE_SYSTEM_STR();
+
+#undef TRACE_DEFINE_ENUM
+#define TRACE_DEFINE_ENUM(a)				\
+	static struct trace_eval_map __used __initdata	\
+	__##TRACE_SYSTEM##_##a =			\
+	{						\
+		.system = TRACE_SYSTEM_STRING,		\
+		.eval_string = #a,			\
+		.eval_value = a				\
+	};						\
+	static struct trace_eval_map __used		\
+	__section("_ftrace_eval_map")			\
+	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
+
+#undef TRACE_DEFINE_SIZEOF
+#define TRACE_DEFINE_SIZEOF(a)				\
+	static struct trace_eval_map __used __initdata	\
+	__##TRACE_SYSTEM##_##a =			\
+	{						\
+		.system = TRACE_SYSTEM_STRING,		\
+		.eval_string = "sizeof(" #a ")",	\
+		.eval_value = sizeof(a)			\
+	};						\
+	static struct trace_eval_map __used		\
+	__section("_ftrace_eval_map")			\
+	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
diff --git a/include/trace/stages/stage1_defines.h b/include/trace/stages/stage1_defines.h
new file mode 100644
index 000000000000..2efabb6f09a9
--- /dev/null
+++ b/include/trace/stages/stage1_defines.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 1 definitions for creating trace events */
+
+#undef __field
+#define __field(type, item)		type	item;
+
+#undef __field_ext
+#define __field_ext(type, item, filter_type)	type	item;
+
+#undef __field_struct
+#define __field_struct(type, item)	type	item;
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)	type	item;
+
+#undef __array
+#define __array(type, item, len)	type	item[len];
+
+#undef __dynamic_array
+#define __dynamic_array(type, item, len) u32 __data_loc_##item;
+
+#undef __string
+#define __string(item, src) __dynamic_array(char, item, -1)
+
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
+
+#undef TP_STRUCT__entry
+#define TP_STRUCT__entry(args...) args
+
diff --git a/include/trace/stages/stage2_defines.h b/include/trace/stages/stage2_defines.h
new file mode 100644
index 000000000000..9f2341df40da
--- /dev/null
+++ b/include/trace/stages/stage2_defines.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 2 definitions for creating trace events */
+
+#undef TRACE_DEFINE_ENUM
+#define TRACE_DEFINE_ENUM(a)
+
+#undef TRACE_DEFINE_SIZEOF
+#define TRACE_DEFINE_SIZEOF(a)
+
+#undef __field
+#define __field(type, item)
+
+#undef __field_ext
+#define __field_ext(type, item, filter_type)
+
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)
+
+#undef __array
+#define __array(type, item, len)
+
+#undef __dynamic_array
+#define __dynamic_array(type, item, len)	u32 item;
+
+#undef __string
+#define __string(item, src) __dynamic_array(char, item, -1)
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)	u32 item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
diff --git a/include/trace/stages/stage3_defines.h b/include/trace/stages/stage3_defines.h
new file mode 100644
index 000000000000..0bc131993b7a
--- /dev/null
+++ b/include/trace/stages/stage3_defines.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 3 definitions for creating trace events */
+
+#undef __entry
+#define __entry field
+
+#undef TP_printk
+#define TP_printk(fmt, args...) fmt "\n", args
+
+#undef __get_dynamic_array
+#define __get_dynamic_array(field)	\
+		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
+
+#undef __get_dynamic_array_len
+#define __get_dynamic_array_len(field)	\
+		((__entry->__data_loc_##field >> 16) & 0xffff)
+
+#undef __get_str
+#define __get_str(field) ((char *)__get_dynamic_array(field))
+
+#undef __get_rel_dynamic_array
+#define __get_rel_dynamic_array(field)					\
+		((void *)__entry + 					\
+		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
+		 sizeof(__entry->__rel_loc_##field) +			\
+		 (__entry->__rel_loc_##field & 0xffff))
+
+#undef __get_rel_dynamic_array_len
+#define __get_rel_dynamic_array_len(field)	\
+		((__entry->__rel_loc_##field >> 16) & 0xffff)
+
+#undef __get_rel_str
+#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
+
+#undef __get_bitmask
+#define __get_bitmask(field)						\
+	({								\
+		void *__bitmask = __get_dynamic_array(field);		\
+		unsigned int __bitmask_size;				\
+		__bitmask_size = __get_dynamic_array_len(field);	\
+		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
+	})
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field)						\
+	({								\
+		void *__bitmask = __get_rel_dynamic_array(field);		\
+		unsigned int __bitmask_size;				\
+		__bitmask_size = __get_rel_dynamic_array_len(field);	\
+		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
+	})
+
+#undef __print_flags
+#define __print_flags(flag, delim, flag_array...)			\
+	({								\
+		static const struct trace_print_flags __flags[] =	\
+			{ flag_array, { -1, NULL }};			\
+		trace_print_flags_seq(p, delim, flag, __flags);	\
+	})
+
+#undef __print_symbolic
+#define __print_symbolic(value, symbol_array...)			\
+	({								\
+		static const struct trace_print_flags symbols[] =	\
+			{ symbol_array, { -1, NULL }};			\
+		trace_print_symbols_seq(p, value, symbols);		\
+	})
+
+#undef __print_flags_u64
+#undef __print_symbolic_u64
+#if BITS_PER_LONG == 32
+#define __print_flags_u64(flag, delim, flag_array...)			\
+	({								\
+		static const struct trace_print_flags_u64 __flags[] =	\
+			{ flag_array, { -1, NULL } };			\
+		trace_print_flags_seq_u64(p, delim, flag, __flags);	\
+	})
+
+#define __print_symbolic_u64(value, symbol_array...)			\
+	({								\
+		static const struct trace_print_flags_u64 symbols[] =	\
+			{ symbol_array, { -1, NULL } };			\
+		trace_print_symbols_seq_u64(p, value, symbols);	\
+	})
+#else
+#define __print_flags_u64(flag, delim, flag_array...)			\
+			__print_flags(flag, delim, flag_array)
+
+#define __print_symbolic_u64(value, symbol_array...)			\
+			__print_symbolic(value, symbol_array)
+#endif
+
+#undef __print_hex
+#define __print_hex(buf, buf_len)					\
+	trace_print_hex_seq(p, buf, buf_len, false)
+
+#undef __print_hex_str
+#define __print_hex_str(buf, buf_len)					\
+	trace_print_hex_seq(p, buf, buf_len, true)
+
+#undef __print_array
+#define __print_array(array, count, el_size)				\
+	({								\
+		BUILD_BUG_ON(el_size != 1 && el_size != 2 &&		\
+			     el_size != 4 && el_size != 8);		\
+		trace_print_array_seq(p, array, count, el_size);	\
+	})
+
+#undef __print_hex_dump
+#define __print_hex_dump(prefix_str, prefix_type,			\
+			 rowsize, groupsize, buf, len, ascii)		\
+	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
+				 rowsize, groupsize, buf, len, ascii)
+
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(value)			\
+	({						\
+		u64 ____val = (u64)(value);		\
+		do_div(____val, NSEC_PER_SEC);		\
+		____val;				\
+	})
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(value)			\
+	({						\
+		u64 ____val = (u64)(value);		\
+		(u32) do_div(____val, NSEC_PER_SEC);	\
+	})
diff --git a/include/trace/stages/stage4_defines.h b/include/trace/stages/stage4_defines.h
new file mode 100644
index 000000000000..780a10fa5279
--- /dev/null
+++ b/include/trace/stages/stage4_defines.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 4 definitions for creating trace events */
+
+#undef __field_ext
+#define __field_ext(_type, _item, _filter_type) {			\
+	.type = #_type, .name = #_item,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	.is_signed = is_signed_type(_type), .filter_type = _filter_type },
+
+#undef __field_struct_ext
+#define __field_struct_ext(_type, _item, _filter_type) {		\
+	.type = #_type, .name = #_item,					\
+	.size = sizeof(_type), .align = __alignof__(_type),		\
+	0, .filter_type = _filter_type },
+
+#undef __field
+#define __field(type, item)	__field_ext(type, item, FILTER_OTHER)
+
+#undef __field_struct
+#define __field_struct(type, item) __field_struct_ext(type, item, FILTER_OTHER)
+
+#undef __array
+#define __array(_type, _item, _len) {					\
+	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
+	.size = sizeof(_type[_len]), .align = __alignof__(_type),	\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+
+#undef __dynamic_array
+#define __dynamic_array(_type, _item, _len) {				\
+	.type = "__data_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = 4,						\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+
+#undef __string
+#define __string(item, src) __dynamic_array(char, item, -1)
+
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(_type, _item, _len) {			\
+	.type = "__rel_loc " #_type "[]", .name = #_item,		\
+	.size = 4, .align = 4,						\
+	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
diff --git a/include/trace/stages/stage5_defines.h b/include/trace/stages/stage5_defines.h
new file mode 100644
index 000000000000..fb15394aae31
--- /dev/null
+++ b/include/trace/stages/stage5_defines.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 5 definitions for creating trace events */
+
+/*
+ * remember the offset of each array from the beginning of the event.
+ */
+
+#undef __entry
+#define __entry entry
+
+#undef __field
+#define __field(type, item)
+
+#undef __field_ext
+#define __field_ext(type, item, filter_type)
+
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __field_struct_ext
+#define __field_struct_ext(type, item, filter_type)
+
+#undef __array
+#define __array(type, item, len)
+
+#undef __dynamic_array
+#define __dynamic_array(type, item, len)				\
+	__item_length = (len) * sizeof(type);				\
+	__data_offsets->item = __data_size +				\
+			       offsetof(typeof(*entry), __data);	\
+	__data_offsets->item |= __item_length << 16;			\
+	__data_size += __item_length;
+
+#undef __string
+#define __string(item, src) __dynamic_array(char, item,			\
+		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__item_length = (len) * sizeof(type);				\
+	__data_offsets->item = __data_size +				\
+			       offsetof(typeof(*entry), __data) -	\
+			       offsetof(typeof(*entry), __rel_loc_##item) -	\
+			       sizeof(u32);				\
+	__data_offsets->item |= __item_length << 16;			\
+	__data_size += __item_length;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item,			\
+		    strlen((src) ? (const char *)(src) : "(null)") + 1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)
+/*
+ * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
+ * num_possible_cpus().
+ */
+#define __bitmask_size_in_bytes_raw(nr_bits)	\
+	(((nr_bits) + 7) / 8)
+
+#define __bitmask_size_in_longs(nr_bits)			\
+	((__bitmask_size_in_bytes_raw(nr_bits) +		\
+	  ((BITS_PER_LONG / 8) - 1)) / (BITS_PER_LONG / 8))
+
+/*
+ * __bitmask_size_in_bytes is the number of bytes needed to hold
+ * num_possible_cpus() padded out to the nearest long. This is what
+ * is saved in the buffer, just to be consistent.
+ */
+#define __bitmask_size_in_bytes(nr_bits)				\
+	(__bitmask_size_in_longs(nr_bits) * (BITS_PER_LONG / 8))
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
+					 __bitmask_size_in_longs(nr_bits))
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
+					 __bitmask_size_in_longs(nr_bits))
diff --git a/include/trace/stages/stage6_defines.h b/include/trace/stages/stage6_defines.h
new file mode 100644
index 000000000000..b3a1f26026be
--- /dev/null
+++ b/include/trace/stages/stage6_defines.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 6 definitions for creating trace events */
+
+#undef __entry
+#define __entry entry
+
+#undef __field
+#define __field(type, item)
+
+#undef __field_struct
+#define __field_struct(type, item)
+
+#undef __array
+#define __array(type, item, len)
+
+#undef __dynamic_array
+#define __dynamic_array(type, item, len)				\
+	__entry->__data_loc_##item = __data_offsets.item;
+
+#undef __string
+#define __string(item, src) __dynamic_array(char, item, -1)
+
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
+#undef __assign_str
+#define __assign_str(dst, src)						\
+	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
+
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)					\
+	do {								\
+		memcpy(__get_str(dst), (src), (len));			\
+		__get_str(dst)[len] = '\0';				\
+	} while(0)
+
+#undef __bitmask
+#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
+
+#undef __get_bitmask
+#define __get_bitmask(field) (char *)__get_dynamic_array(field)
+
+#undef __assign_bitmask
+#define __assign_bitmask(dst, src, nr_bits)					\
+	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
+#undef __rel_dynamic_array
+#define __rel_dynamic_array(type, item, len)				\
+	__entry->__rel_loc_##item = __data_offsets.item;
+
+#undef __rel_string
+#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
+
+#undef __rel_string_len
+#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
+
+#undef __assign_rel_str
+#define __assign_rel_str(dst, src)					\
+	strcpy(__get_rel_str(dst), (src) ? (const char *)(src) : "(null)");
+
+#undef __assign_rel_str_len
+#define __assign_rel_str_len(dst, src, len)				\
+	do {								\
+		memcpy(__get_rel_str(dst), (src), (len));		\
+		__get_rel_str(dst)[len] = '\0';				\
+	} while (0)
+
+#undef __rel_bitmask
+#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+
+#undef __get_rel_bitmask
+#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
+
+#undef __assign_rel_bitmask
+#define __assign_rel_bitmask(dst, src, nr_bits)					\
+	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
+
+#undef TP_fast_assign
+#define TP_fast_assign(args...) args
+
+#undef __perf_count
+#define __perf_count(c)	(c)
+
+#undef __perf_task
+#define __perf_task(t)	(t)
diff --git a/include/trace/stages/stage7_defines.h b/include/trace/stages/stage7_defines.h
new file mode 100644
index 000000000000..d65445328f18
--- /dev/null
+++ b/include/trace/stages/stage7_defines.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Stage 7 definitions for creating trace events */
+
+#undef __entry
+#define __entry REC
+
+#undef __print_flags
+#undef __print_symbolic
+#undef __print_hex
+#undef __print_hex_str
+#undef __get_dynamic_array
+#undef __get_dynamic_array_len
+#undef __get_str
+#undef __get_bitmask
+#undef __get_rel_dynamic_array
+#undef __get_rel_dynamic_array_len
+#undef __get_rel_str
+#undef __get_rel_bitmask
+#undef __print_array
+#undef __print_hex_dump
+
+/*
+ * The below is not executed in the kernel. It is only what is
+ * displayed in the print format for userspace to parse.
+ */
+#undef __print_ns_to_secs
+#define __print_ns_to_secs(val) (val) / 1000000000UL
+
+#undef __print_ns_without_secs
+#define __print_ns_without_secs(val) (val) % 1000000000UL
+
+#undef TP_printk
+#define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 3d29919045af..8a8cd66cc6d5 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -24,42 +24,7 @@
 #define TRACE_SYSTEM_VAR TRACE_SYSTEM
 #endif
 
-#define __app__(x, y) str__##x##y
-#define __app(x, y) __app__(x, y)
-
-#define TRACE_SYSTEM_STRING __app(TRACE_SYSTEM_VAR,__trace_system_name)
-
-#define TRACE_MAKE_SYSTEM_STR()				\
-	static const char TRACE_SYSTEM_STRING[] =	\
-		__stringify(TRACE_SYSTEM)
-
-TRACE_MAKE_SYSTEM_STR();
-
-#undef TRACE_DEFINE_ENUM
-#define TRACE_DEFINE_ENUM(a)				\
-	static struct trace_eval_map __used __initdata	\
-	__##TRACE_SYSTEM##_##a =			\
-	{						\
-		.system = TRACE_SYSTEM_STRING,		\
-		.eval_string = #a,			\
-		.eval_value = a				\
-	};						\
-	static struct trace_eval_map __used		\
-	__section("_ftrace_eval_map")			\
-	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
-
-#undef TRACE_DEFINE_SIZEOF
-#define TRACE_DEFINE_SIZEOF(a)				\
-	static struct trace_eval_map __used __initdata	\
-	__##TRACE_SYSTEM##_##a =			\
-	{						\
-		.system = TRACE_SYSTEM_STRING,		\
-		.eval_string = "sizeof(" #a ")",	\
-		.eval_value = sizeof(a)			\
-	};						\
-	static struct trace_eval_map __used		\
-	__section("_ftrace_eval_map")			\
-	*TRACE_SYSTEM##_##a = &__##TRACE_SYSTEM##_##a
+#include "stages/init.h"
 
 /*
  * DECLARE_EVENT_CLASS can be used to add a generic function
@@ -80,48 +45,7 @@ TRACE_MAKE_SYSTEM_STR();
 			     PARAMS(print));		       \
 	DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
 
-
-#undef __field
-#define __field(type, item)		type	item;
-
-#undef __field_ext
-#define __field_ext(type, item, filter_type)	type	item;
-
-#undef __field_struct
-#define __field_struct(type, item)	type	item;
-
-#undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)	type	item;
-
-#undef __array
-#define __array(type, item, len)	type	item[len];
-
-#undef __dynamic_array
-#define __dynamic_array(type, item, len) u32 __data_loc_##item;
-
-#undef __string
-#define __string(item, src) __dynamic_array(char, item, -1)
-
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
-
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
-
-#undef __rel_dynamic_array
-#define __rel_dynamic_array(type, item, len) u32 __rel_loc_##item;
-
-#undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_bitmask
-#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(char, item, -1)
-
-#undef TP_STRUCT__entry
-#define TP_STRUCT__entry(args...) args
+#include "stages/stage1_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(name, proto, args, tstruct, assign, print)	\
@@ -185,50 +109,7 @@ TRACE_MAKE_SYSTEM_STR();
  * The size of an array is also encoded, in the higher 16 bits of <item>.
  */
 
-#undef TRACE_DEFINE_ENUM
-#define TRACE_DEFINE_ENUM(a)
-
-#undef TRACE_DEFINE_SIZEOF
-#define TRACE_DEFINE_SIZEOF(a)
-
-#undef __field
-#define __field(type, item)
-
-#undef __field_ext
-#define __field_ext(type, item, filter_type)
-
-#undef __field_struct
-#define __field_struct(type, item)
-
-#undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)
-
-#undef __array
-#define __array(type, item, len)
-
-#undef __dynamic_array
-#define __dynamic_array(type, item, len)	u32 item;
-
-#undef __string
-#define __string(item, src) __dynamic_array(char, item, -1)
-
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
-
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
-
-#undef __rel_dynamic_array
-#define __rel_dynamic_array(type, item, len)	u32 item;
-
-#undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_bitmask
-#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+#include "stages/stage2_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -300,131 +181,7 @@ TRACE_MAKE_SYSTEM_STR();
  * in binary.
  */
 
-#undef __entry
-#define __entry field
-
-#undef TP_printk
-#define TP_printk(fmt, args...) fmt "\n", args
-
-#undef __get_dynamic_array
-#define __get_dynamic_array(field)	\
-		((void *)__entry + (__entry->__data_loc_##field & 0xffff))
-
-#undef __get_dynamic_array_len
-#define __get_dynamic_array_len(field)	\
-		((__entry->__data_loc_##field >> 16) & 0xffff)
-
-#undef __get_str
-#define __get_str(field) ((char *)__get_dynamic_array(field))
-
-#undef __get_rel_dynamic_array
-#define __get_rel_dynamic_array(field)					\
-		((void *)__entry + 					\
-		 offsetof(typeof(*__entry), __rel_loc_##field) +	\
-		 sizeof(__entry->__rel_loc_##field) +			\
-		 (__entry->__rel_loc_##field & 0xffff))
-
-#undef __get_rel_dynamic_array_len
-#define __get_rel_dynamic_array_len(field)	\
-		((__entry->__rel_loc_##field >> 16) & 0xffff)
-
-#undef __get_rel_str
-#define __get_rel_str(field) ((char *)__get_rel_dynamic_array(field))
-
-#undef __get_bitmask
-#define __get_bitmask(field)						\
-	({								\
-		void *__bitmask = __get_dynamic_array(field);		\
-		unsigned int __bitmask_size;				\
-		__bitmask_size = __get_dynamic_array_len(field);	\
-		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
-	})
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field)						\
-	({								\
-		void *__bitmask = __get_rel_dynamic_array(field);		\
-		unsigned int __bitmask_size;				\
-		__bitmask_size = __get_rel_dynamic_array_len(field);	\
-		trace_print_bitmask_seq(p, __bitmask, __bitmask_size);	\
-	})
-
-#undef __print_flags
-#define __print_flags(flag, delim, flag_array...)			\
-	({								\
-		static const struct trace_print_flags __flags[] =	\
-			{ flag_array, { -1, NULL }};			\
-		trace_print_flags_seq(p, delim, flag, __flags);	\
-	})
-
-#undef __print_symbolic
-#define __print_symbolic(value, symbol_array...)			\
-	({								\
-		static const struct trace_print_flags symbols[] =	\
-			{ symbol_array, { -1, NULL }};			\
-		trace_print_symbols_seq(p, value, symbols);		\
-	})
-
-#undef __print_flags_u64
-#undef __print_symbolic_u64
-#if BITS_PER_LONG == 32
-#define __print_flags_u64(flag, delim, flag_array...)			\
-	({								\
-		static const struct trace_print_flags_u64 __flags[] =	\
-			{ flag_array, { -1, NULL } };			\
-		trace_print_flags_seq_u64(p, delim, flag, __flags);	\
-	})
-
-#define __print_symbolic_u64(value, symbol_array...)			\
-	({								\
-		static const struct trace_print_flags_u64 symbols[] =	\
-			{ symbol_array, { -1, NULL } };			\
-		trace_print_symbols_seq_u64(p, value, symbols);	\
-	})
-#else
-#define __print_flags_u64(flag, delim, flag_array...)			\
-			__print_flags(flag, delim, flag_array)
-
-#define __print_symbolic_u64(value, symbol_array...)			\
-			__print_symbolic(value, symbol_array)
-#endif
-
-#undef __print_hex
-#define __print_hex(buf, buf_len)					\
-	trace_print_hex_seq(p, buf, buf_len, false)
-
-#undef __print_hex_str
-#define __print_hex_str(buf, buf_len)					\
-	trace_print_hex_seq(p, buf, buf_len, true)
-
-#undef __print_array
-#define __print_array(array, count, el_size)				\
-	({								\
-		BUILD_BUG_ON(el_size != 1 && el_size != 2 &&		\
-			     el_size != 4 && el_size != 8);		\
-		trace_print_array_seq(p, array, count, el_size);	\
-	})
-
-#undef __print_hex_dump
-#define __print_hex_dump(prefix_str, prefix_type,			\
-			 rowsize, groupsize, buf, len, ascii)		\
-	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
-				 rowsize, groupsize, buf, len, ascii)
-
-#undef __print_ns_to_secs
-#define __print_ns_to_secs(value)			\
-	({						\
-		u64 ____val = (u64)(value);		\
-		do_div(____val, NSEC_PER_SEC);		\
-		____val;				\
-	})
-
-#undef __print_ns_without_secs
-#define __print_ns_without_secs(value)			\
-	({						\
-		u64 ____val = (u64)(value);		\
-		(u32) do_div(____val, NSEC_PER_SEC);	\
-	})
+#include "stages/stage3_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -479,59 +236,7 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#undef __field_ext
-#define __field_ext(_type, _item, _filter_type) {			\
-	.type = #_type, .name = #_item,					\
-	.size = sizeof(_type), .align = __alignof__(_type),		\
-	.is_signed = is_signed_type(_type), .filter_type = _filter_type },
-
-#undef __field_struct_ext
-#define __field_struct_ext(_type, _item, _filter_type) {		\
-	.type = #_type, .name = #_item,					\
-	.size = sizeof(_type), .align = __alignof__(_type),		\
-	0, .filter_type = _filter_type },
-
-#undef __field
-#define __field(type, item)	__field_ext(type, item, FILTER_OTHER)
-
-#undef __field_struct
-#define __field_struct(type, item) __field_struct_ext(type, item, FILTER_OTHER)
-
-#undef __array
-#define __array(_type, _item, _len) {					\
-	.type = #_type"["__stringify(_len)"]", .name = #_item,		\
-	.size = sizeof(_type[_len]), .align = __alignof__(_type),	\
-	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
-
-#undef __dynamic_array
-#define __dynamic_array(_type, _item, _len) {				\
-	.type = "__data_loc " #_type "[]", .name = #_item,		\
-	.size = 4, .align = 4,						\
-	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
-
-#undef __string
-#define __string(item, src) __dynamic_array(char, item, -1)
-
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
-
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
-
-#undef __rel_dynamic_array
-#define __rel_dynamic_array(_type, _item, _len) {			\
-	.type = "__rel_loc " #_type "[]", .name = #_item,		\
-	.size = 4, .align = 4,						\
-	.is_signed = is_signed_type(_type), .filter_type = FILTER_OTHER },
-
-#undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_bitmask
-#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
+#include "stages/stage4_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
@@ -544,85 +249,7 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-/*
- * remember the offset of each array from the beginning of the event.
- */
-
-#undef __entry
-#define __entry entry
-
-#undef __field
-#define __field(type, item)
-
-#undef __field_ext
-#define __field_ext(type, item, filter_type)
-
-#undef __field_struct
-#define __field_struct(type, item)
-
-#undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)
-
-#undef __array
-#define __array(type, item, len)
-
-#undef __dynamic_array
-#define __dynamic_array(type, item, len)				\
-	__item_length = (len) * sizeof(type);				\
-	__data_offsets->item = __data_size +				\
-			       offsetof(typeof(*entry), __data);	\
-	__data_offsets->item |= __item_length << 16;			\
-	__data_size += __item_length;
-
-#undef __string
-#define __string(item, src) __dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)
-
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
-
-#undef __rel_dynamic_array
-#define __rel_dynamic_array(type, item, len)				\
-	__item_length = (len) * sizeof(type);				\
-	__data_offsets->item = __data_size +				\
-			       offsetof(typeof(*entry), __data) -	\
-			       offsetof(typeof(*entry), __rel_loc_##item) -	\
-			       sizeof(u32);				\
-	__data_offsets->item |= __item_length << 16;			\
-	__data_size += __item_length;
-
-#undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item,			\
-		    strlen((src) ? (const char *)(src) : "(null)") + 1)
-
-#undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, (len) + 1)
-/*
- * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
- * num_possible_cpus().
- */
-#define __bitmask_size_in_bytes_raw(nr_bits)	\
-	(((nr_bits) + 7) / 8)
-
-#define __bitmask_size_in_longs(nr_bits)			\
-	((__bitmask_size_in_bytes_raw(nr_bits) +		\
-	  ((BITS_PER_LONG / 8) - 1)) / (BITS_PER_LONG / 8))
-
-/*
- * __bitmask_size_in_bytes is the number of bytes needed to hold
- * num_possible_cpus() padded out to the nearest long. This is what
- * is saved in the buffer, just to be consistent.
- */
-#define __bitmask_size_in_bytes(nr_bits)				\
-	(__bitmask_size_in_longs(nr_bits) * (BITS_PER_LONG / 8))
-
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item,	\
-					 __bitmask_size_in_longs(nr_bits))
-
-#undef __rel_bitmask
-#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item,	\
-					 __bitmask_size_in_longs(nr_bits))
+#include "stages/stage5_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -745,88 +372,7 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #define _TRACE_PERF_INIT(call)
 #endif /* CONFIG_PERF_EVENTS */
 
-#undef __entry
-#define __entry entry
-
-#undef __field
-#define __field(type, item)
-
-#undef __field_struct
-#define __field_struct(type, item)
-
-#undef __array
-#define __array(type, item, len)
-
-#undef __dynamic_array
-#define __dynamic_array(type, item, len)				\
-	__entry->__data_loc_##item = __data_offsets.item;
-
-#undef __string
-#define __string(item, src) __dynamic_array(char, item, -1)
-
-#undef __string_len
-#define __string_len(item, src, len) __dynamic_array(char, item, -1)
-
-#undef __assign_str
-#define __assign_str(dst, src)						\
-	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
-
-#undef __assign_str_len
-#define __assign_str_len(dst, src, len)					\
-	do {								\
-		memcpy(__get_str(dst), (src), (len));			\
-		__get_str(dst)[len] = '\0';				\
-	} while(0)
-
-#undef __bitmask
-#define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
-
-#undef __get_bitmask
-#define __get_bitmask(field) (char *)__get_dynamic_array(field)
-
-#undef __assign_bitmask
-#define __assign_bitmask(dst, src, nr_bits)					\
-	memcpy(__get_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
-
-#undef __rel_dynamic_array
-#define __rel_dynamic_array(type, item, len)				\
-	__entry->__rel_loc_##item = __data_offsets.item;
-
-#undef __rel_string
-#define __rel_string(item, src) __rel_dynamic_array(char, item, -1)
-
-#undef __rel_string_len
-#define __rel_string_len(item, src, len) __rel_dynamic_array(char, item, -1)
-
-#undef __assign_rel_str
-#define __assign_rel_str(dst, src)					\
-	strcpy(__get_rel_str(dst), (src) ? (const char *)(src) : "(null)");
-
-#undef __assign_rel_str_len
-#define __assign_rel_str_len(dst, src, len)				\
-	do {								\
-		memcpy(__get_rel_str(dst), (src), (len));		\
-		__get_rel_str(dst)[len] = '\0';				\
-	} while (0)
-
-#undef __rel_bitmask
-#define __rel_bitmask(item, nr_bits) __rel_dynamic_array(unsigned long, item, -1)
-
-#undef __get_rel_bitmask
-#define __get_rel_bitmask(field) (char *)__get_rel_dynamic_array(field)
-
-#undef __assign_rel_bitmask
-#define __assign_rel_bitmask(dst, src, nr_bits)					\
-	memcpy(__get_rel_bitmask(dst), (src), __bitmask_size_in_bytes(nr_bits))
-
-#undef TP_fast_assign
-#define TP_fast_assign(args...) args
-
-#undef __perf_count
-#define __perf_count(c)	(c)
-
-#undef __perf_task
-#define __perf_task(t)	(t)
+#include "stages/stage6_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
@@ -872,36 +418,7 @@ static inline void ftrace_test_probe_##call(void)			\
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-#undef __entry
-#define __entry REC
-
-#undef __print_flags
-#undef __print_symbolic
-#undef __print_hex
-#undef __print_hex_str
-#undef __get_dynamic_array
-#undef __get_dynamic_array_len
-#undef __get_str
-#undef __get_bitmask
-#undef __get_rel_dynamic_array
-#undef __get_rel_dynamic_array_len
-#undef __get_rel_str
-#undef __get_rel_bitmask
-#undef __print_array
-#undef __print_hex_dump
-
-/*
- * The below is not executed in the kernel. It is only what is
- * displayed in the print format for userspace to parse.
- */
-#undef __print_ns_to_secs
-#define __print_ns_to_secs(val) (val) / 1000000000UL
-
-#undef __print_ns_without_secs
-#define __print_ns_without_secs(val) (val) % 1000000000UL
-
-#undef TP_printk
-#define TP_printk(fmt, args...) "\"" fmt "\", "  __stringify(args)
+#include "stages/stage7_defines.h"
 
 #undef DECLARE_EVENT_CLASS
 #define DECLARE_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
-- 
2.34.1

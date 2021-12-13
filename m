Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEA472814
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 11:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242711AbhLMKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 05:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241302AbhLMKDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 05:03:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA30C09CE4C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so49646485edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=fjH0gFq35qvD8QCzf6V/IuCOgjlo8sNBDuRd696f9afLBXTvDtcgNA7wEhxTRPfgNv
         Wc4U5Ewbp9GrYvyCNuR0XrAuUifoLFrKoywA1D9FNiVhCNpghwlT4IKqjqWv8O5hjjBa
         JtG3LIgVdtV2zZiT8pzv3Hch7EFWwPaAzfKDl9/6AqkZ9gj/RwO1sl8qXc8CoRAfZXSg
         6PNi1j2mB2V1EUnBiu5rJGeglxuUq3xU2fRbn3cdg6GE4eNWV7sP+0jLHs2HVBqk2z8l
         OQUFaDBFbJwDWlJQi/x6jqSTRxs3kIOgWU1fjMzfJw7smQW/MaOsFM1yZFcp01q2/dKP
         EcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhRx6ewN7MwnNiVVmf6uS+ga/E3172l7ca+KEv51r0c=;
        b=eDWTAwLlx9zMhVuveYm2MgyV0FqqZP8gm0MeodYLOHDuN2Ah5dZ9GOp+Plt3PoAtgF
         a7kcg9Iq4h0vpf5mnECzRF3RTtdSZzDurr5SQWeTO7thpfxO0ys1eCK5JbcdgpTCLsrB
         6PMaP8StI1xp/9qPDZ0D31X9RHVwQ6BmKjYFob2T7pHnRlZRKMt8ZCWjUUcIFTos68Xq
         s3Q6QJr9XR1K670xIa9KUv0mNe8lL2JFWQi4TvnWVvBaTyNlxoDAUq6Op6Cuj1qMlsES
         uYfMJNb/mZl6OW/A68AZE2hH8RBERv0yIlO3imzA1klCNIVQDc2SEqkXlnw0i7VZJiql
         4yiQ==
X-Gm-Message-State: AOAM532fCPY+xt9Nclm4G2xIKAIUQaQpZBBObS+u3LXjgVoJ1RFy4CrS
        EIjS6C3e1dDdKkg46LN3Ycx2fPDTrw4=
X-Google-Smtp-Source: ABdhPJwmofVfODGa33fjiKgXRYZ/kFcg7z2pwWlqH0dSd2tDojHMrOiXfyq75+GmqbKjswyoG+pcMw==
X-Received: by 2002:a17:906:7310:: with SMTP id di16mr41462199ejc.92.1639389004911;
        Mon, 13 Dec 2021 01:50:04 -0800 (PST)
Received: from oberon.zico.biz.zico.biz ([83.222.187.186])
        by smtp.gmail.com with ESMTPSA id qb21sm5789774ejc.78.2021.12.13.01.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:50:04 -0800 (PST)
From:   "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] [RFC] tracing: Refactor ring buffer implementation
Date:   Mon, 13 Dec 2021 11:49:58 +0200
Message-Id: <20211213095002.62110-2-tz.stoyanov@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211213095002.62110-1-tz.stoyanov@gmail.com>
References: <20211213095002.62110-1-tz.stoyanov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to introduce sub-buffer size per ring buffer, some internal
refactoring is needed. As ring_buffer_print_page_header() will depend on
the trace_buffer structure, it is moved after the structure definition.

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
---
 kernel/trace/ring_buffer.c | 59 +++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2699e9e562b1..cc34dbfdd29b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -371,35 +371,6 @@ static inline int test_time_stamp(u64 delta)
 /* Max payload is BUF_PAGE_SIZE - header (8bytes) */
 #define BUF_MAX_DATA_SIZE (BUF_PAGE_SIZE - (sizeof(u32) * 2))
 
-int ring_buffer_print_page_header(struct trace_seq *s)
-{
-	struct buffer_data_page field;
-
-	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
-			 "offset:0;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)sizeof(field.time_stamp),
-			 (unsigned int)is_signed_type(u64));
-
-	trace_seq_printf(s, "\tfield: local_t commit;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 (unsigned int)sizeof(field.commit),
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
-			 1,
-			 (unsigned int)is_signed_type(long));
-
-	trace_seq_printf(s, "\tfield: char data;\t"
-			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)BUF_PAGE_SIZE,
-			 (unsigned int)is_signed_type(char));
-
-	return !trace_seq_has_overflowed(s);
-}
 
 struct rb_irq_work {
 	struct irq_work			work;
@@ -559,6 +530,36 @@ struct ring_buffer_iter {
 	int				missed_events;
 };
 
+int ring_buffer_print_page_header(struct trace_seq *s)
+{
+	struct buffer_data_page field;
+
+	trace_seq_printf(s, "\tfield: u64 timestamp;\t"
+			 "offset:0;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)sizeof(field.time_stamp),
+			 (unsigned int)is_signed_type(u64));
+
+	trace_seq_printf(s, "\tfield: local_t commit;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)sizeof(field.commit),
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: int overwrite;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), commit),
+			 1,
+			 (unsigned int)is_signed_type(long));
+
+	trace_seq_printf(s, "\tfield: char data;\t"
+			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
+			 (unsigned int)offsetof(typeof(field), data),
+			 (unsigned int)BUF_PAGE_SIZE,
+			 (unsigned int)is_signed_type(char));
+
+	return !trace_seq_has_overflowed(s);
+}
+
 #ifdef RB_TIME_32
 
 /*
-- 
2.31.1


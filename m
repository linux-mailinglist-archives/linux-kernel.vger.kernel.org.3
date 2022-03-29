Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092D4EB1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiC2Qlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239716AbiC2Qlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:41:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F8FDA0AA
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:40:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c23so18170330plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bY4yoSxK19Dtv/Qi8ChzxOAQ2XrcNZsR1mA3eXn+KCA=;
        b=SjIFPOQOeYzdLloArY51xqeWUzTrssM2d7IsP/MqClZEUugvZ66Ph3KpLWYGhgkgK1
         e9WR9MN3M3ZlCVufHpEm9iCNy9iYfydQb0zskFruQQEG/x5YDoL2kCk/+IiaoZfLY8AX
         Fvm5vkf5Zz4cbKMlYXEESlqoJRk9oWAskufD1Hi4Ji91iPVTn99CyDe+zMQdJAsXHK5+
         SU3kCSYhL8pXPXllmys45XC3T/AOc8b+1ekmQ5Cze7wMrWpVdZJ5eQ6RS2DZd2SeaqWy
         3PmQbPyA326+7gKLT6PKc0IPacLNt+rvzyaAideoFUTVe0pn2qzg7TUmfR0Pwzo7tsAn
         5QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bY4yoSxK19Dtv/Qi8ChzxOAQ2XrcNZsR1mA3eXn+KCA=;
        b=lcLfGZYPdlmz9DuQXAyW3Yy+XEsVBS5rJ4VtDTg94GNx++bsKE27AouzHHjSK7XD2+
         oRcy/uMGZDNVV4K2o2vgy/iAuXsZ1pLH18j4sdo9/Iel/dk/HAwapGHRiU6cOmQZzEhl
         FXiKuY6ohMppU8JxPtn3ov+HBwoZI+7fnMGnUs07oMNZh23lCoMR6aExb/Z+IKFvGM16
         cq6JBDWmLPXi4RsvXU1sI8NxpHqDE0Qggk9oIh1yRYelpG56xwU7IVE3u3pB46AFaxYW
         Usn7uUr1BYEruhRa64dVbzQPnqlyzb0+eP14ZlpETUKAjbJ6QrBM4ZREU9khOUQOgb/9
         MBLg==
X-Gm-Message-State: AOAM531aVSyNFyl160xNqwHXM38pyJQ0nv9Dvs7y/qtk/VobCqdeTq9X
        AKLtgb5pFVpulKXvbN34Kvo=
X-Google-Smtp-Source: ABdhPJxBkSIPLYad0oKjzpBuMYmlICuVylSZ3I0YzFxmXwwHpF8D3NHNdq1nhfAQ3+xaTp2YrOKvxA==
X-Received: by 2002:a17:903:1204:b0:156:29c3:d9d with SMTP id l4-20020a170903120400b0015629c30d9dmr4803013plh.28.1648571999956;
        Tue, 29 Mar 2022 09:39:59 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090a178700b001c97d3614e5sm3382093pja.33.2022.03.29.09.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 09:39:59 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH 3/3] tracing: make tp_printk work on syscall tracepoints
Date:   Wed, 30 Mar 2022 00:39:31 +0800
Message-Id: <20220329163931.710555-4-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329163931.710555-1-xiehuan09@gmail.com>
References: <20220329163931.710555-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding printk for syscall tracepoints for the tp_printk work.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index f755bde42fd0..9798122166d3 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -290,6 +290,25 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
 	return ret;
 }
 
+static void syscall_output_printk(struct trace_entry *ent,
+		struct trace_event_file *trace_file, struct trace_array *tr)
+{
+	unsigned long flags;
+	struct trace_iterator *iter = tracepoint_print_iter;
+	struct trace_event *event = &trace_file->event_call->event;
+
+	spin_lock_irqsave(&tracepoint_iter_lock, flags);
+
+	trace_seq_init(&iter->seq);
+	iter->ent = ent;
+	iter->tr = tr;
+	event->funcs->trace(iter, 0, event);
+	trace_seq_putc(&iter->seq, 0);
+	pr_info("%s", iter->seq.buffer);
+
+	spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
+}
+
 static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 {
 	struct trace_array *tr = data;
@@ -333,6 +352,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	syscall_get_arguments(current, regs, args);
 	memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
 
+	if (static_key_false(&tracepoint_printk_key.key))
+		syscall_output_printk(&entry->ent, trace_file, tr);
+
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    trace_ctx);
 }
@@ -376,6 +398,9 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	entry->nr = syscall_nr;
 	entry->ret = syscall_get_return_value(current, regs);
 
+	if (static_key_false(&tracepoint_printk_key.key))
+		syscall_output_printk(&entry->ent, trace_file, tr);
+
 	event_trigger_unlock_commit(trace_file, buffer, event, entry,
 				    trace_ctx);
 }
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D64A4051
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiAaKfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358234AbiAaKeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:34:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48019C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:34:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e130-20020a255088000000b006126feb051eso25994591ybb.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 02:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gQiXNhpWeE3w8plSrWyGvN1lrZy07A1L66IKLC7CKbA=;
        b=jBeNywyuEOrcXul646YOTEnDNkvf2B21oUP/1LvS6MfqUeLNbH4ecLDYPUWeYJBghY
         z3i5ILdvdOG+3+CnkALg8SHprnIucGpcnCQgkDxUIoyEtUk08H/S4biUQfAdMcF4RcDi
         rm6Tp4txIJN4G18FTdqFDJeQZMu2zGr5Kb72KOMCnErupl+0AsPpFtL/eUu+TekxggYV
         8WHC9X3E3y8J3Sjg4TWSGzvFUP0F/8Gj/82MlWlodrZo4F++MQ8Y9k3vTM9BY5EPj0Aj
         5dES73C/VqfnNoLUtMrRSADU3rAktKKtrGALulf1IYdQkDnW/POpci29EY4pLJrtmKCI
         Ovpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gQiXNhpWeE3w8plSrWyGvN1lrZy07A1L66IKLC7CKbA=;
        b=vJy45Fjox/xVjhxo/iHBP2AnvnE66U2Wo69lQUsO5xjfPf9p1O4xfGGY08cxmCpG7q
         zEhjsgubipkduxYn/tkkuXPH0bfeNEMRtqlmWzbvRRx7brfy7T/wptmLFFlhP451eaf8
         AaAk6RAvJ48UEX8o2gtY3UpNx2QZzhFcWn7G7AumYGudNPLhh0na0Bt0a+AFod0yl6Uy
         lzwSxn2SLeeI2Idlz/YEVPyhDhwASPtsPrKj7wFRL59BvZswIczA8N1lLK8jelgJ77fw
         reztXghBHstCbG2X7L3hEdsSB6ny8JAEmdfz/U9X5+sfqzXYgBCgteoLsnaKpAMHB0qp
         R5LA==
X-Gm-Message-State: AOAM53346AGNfNWFJauuyngCZxYvGErQnjh9bRae08MTVb7HY+O6o+dm
        rVKwUDmtvdFt6Azjcm6CUQySov10Zw==
X-Google-Smtp-Source: ABdhPJzRQW4bKXsoVEcga7CM6u0Cngds+b22neL6Ay7g8PWBHgbN0WFRt59W7RFofatRiHhJVZXVszx0sQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:76:dcf3:95f9:db8b])
 (user=elver job=sendgmr) by 2002:a81:6fc5:: with SMTP id k188mr1653ywc.507.1643625254572;
 Mon, 31 Jan 2022 02:34:14 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:34:05 +0100
Message-Id: <20220131103407.1971678-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH 1/3] perf: Copy perf_event_attr::sig_data on modification
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent has always been that perf_event_attr::sig_data should also be
modifiable along with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, because it is
observable by user space if SIGTRAP on events is requested.

Currently only PERF_TYPE_BREAKPOINT is modifiable, and explicitly copies
relevant breakpoint-related attributes in hw_breakpoint_copy_attr().
This misses copying perf_event_attr::sig_data.

Since sig_data is not specific to PERF_TYPE_BREAKPOINT, introduce a
helper to copy generic event-type-independent attributes on
modification.

Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc18664f49b0..db0d85a85f1b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3197,6 +3197,15 @@ static int perf_event_modify_breakpoint(struct perf_event *bp,
 	return err;
 }
 
+/*
+ * Copy event-type-independent attributes that may be modified.
+ */
+static void perf_event_modify_copy_attr(struct perf_event_attr *to,
+					const struct perf_event_attr *from)
+{
+	to->sig_data = from->sig_data;
+}
+
 static int perf_event_modify_attr(struct perf_event *event,
 				  struct perf_event_attr *attr)
 {
@@ -3219,10 +3228,17 @@ static int perf_event_modify_attr(struct perf_event *event,
 	WARN_ON_ONCE(event->ctx->parent_ctx);
 
 	mutex_lock(&event->child_mutex);
+	/*
+	 * Event-type-independent attributes must be copied before event-type
+	 * modification, which will validate that final attributes match the
+	 * source attributes after all relevant attributes have been copied.
+	 */
+	perf_event_modify_copy_attr(&event->attr, attr);
 	err = func(event, attr);
 	if (err)
 		goto out;
 	list_for_each_entry(child, &event->child_list, child_list) {
+		perf_event_modify_copy_attr(&child->attr, attr);
 		err = func(child, attr);
 		if (err)
 			goto out;
-- 
2.35.0.rc2.247.g8bbb082509-goog


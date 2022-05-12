Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A996525017
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355394AbiELOeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355339AbiELOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:33:53 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC3D625F79E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:33:36 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4F9681E80D6B;
        Thu, 12 May 2022 22:28:00 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 00T1VVAvSilP; Thu, 12 May 2022 22:27:57 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 0C7141E80D22;
        Thu, 12 May 2022 22:27:57 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, hukun@nfschina.com,
        qixu@nfschina.com, yuzhe@nfschina.com, renyu@nfschina.com,
        liqiong <liqiong@nfschina.com>
Subject: [PATCH 2/2] kernel/trace: change "char *" string form to "char []"
Date:   Thu, 12 May 2022 22:32:30 +0800
Message-Id: <20220512143230.28796-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "char []" string form declares a single variable. It is better
than "char *" which creates two variables in the final assembly.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 kernel/trace/trace.c             | 2 +-
 kernel/trace/trace_events_hist.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..62a3451be0e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4249,7 +4249,7 @@ static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "            ";
+	static const char space[] = "            ";
 	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 44db5ba9cabb..6925ea1b08e7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4161,7 +4161,7 @@ static int create_val_field(struct hist_trigger_data *hist_data,
 	return __create_val_field(hist_data, val_idx, file, NULL, field_str, 0);
 }
 
-static const char *no_comm = "(no comm)";
+static const char no_comm[] = "(no comm)";
 
 static u64 hist_field_execname(struct hist_field *hist_field,
 			       struct tracing_map_elt *elt,
-- 
2.25.1


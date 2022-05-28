Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57468536A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355670AbiE1CxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355554AbiE1Cwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFE12E30C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9BA9B82637
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A468FC341C4;
        Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZN-000LMd-O0;
        Fri, 27 May 2022 22:52:49 -0400
Message-ID: <20220528025249.577189376@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [for-next][PATCH 05/23] tracing: Use strim() to remove whitespace instead of doing it
 manually
References: <20220528025028.850906216@goodmis.org>
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

From: Yuntao Wang <ytcoode@gmail.com>

The tracing_set_trace_write() function just removes the trailing whitespace
from the user supplied tracer name, but the leading whitespace should also
be removed.

In addition, if the user supplied tracer name contains only a few
whitespace characters, the first one will not be removed using the current
method, which results it a single whitespace character left in the buf.

To fix all of these issues, we use strim() to correctly remove both the
leading and trailing whitespace.

Link: https://lkml.kernel.org/r/20220121095623.1826679-1-ytcoode@gmail.com

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 087740f63d92..498ae22d4ffa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6461,7 +6461,7 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	char buf[MAX_TRACER_SIZE+1];
-	int i;
+	char *name;
 	size_t ret;
 	int err;
 
@@ -6475,11 +6475,9 @@ tracing_set_trace_write(struct file *filp, const char __user *ubuf,
 
 	buf[cnt] = 0;
 
-	/* strip ending whitespace. */
-	for (i = cnt - 1; i > 0 && isspace(buf[i]); i--)
-		buf[i] = 0;
+	name = strim(buf);
 
-	err = tracing_set_tracer(tr, buf);
+	err = tracing_set_tracer(tr, name);
 	if (err)
 		return err;
 
-- 
2.35.1

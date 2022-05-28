Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FAB536A65
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355682AbiE1Cxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355583AbiE1Cwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E62A880C6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 539DFB8268C
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1203AC34114;
        Sat, 28 May 2022 02:52:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZP-000LR9-6U;
        Fri, 27 May 2022 22:52:51 -0400
Message-ID: <20220528025251.039864974@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        liqiong <liqiong@nfschina.com>
Subject: [for-next][PATCH 13/23] tracing: Cleanup code by removing init "char *name"
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

From: liqiong <liqiong@nfschina.com>

The pointer is assigned to "type->name" anyway. no need to
initialize with "preemption".

Link: https://lkml.kernel.org/r/20220513075221.26275-1-liqiong@nfschina.com

Signed-off-by: liqiong <liqiong@nfschina.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e38a7ca4cdd0..f400800bc910 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4276,9 +4276,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	struct tracer *type = iter->trace;
 	unsigned long entries;
 	unsigned long total;
-	const char *name = "preemption";
-
-	name = type->name;
+	const char *name = type->name;
 
 	get_total_entries(buf, &total, &entries);
 
-- 
2.35.1

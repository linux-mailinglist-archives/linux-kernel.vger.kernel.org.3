Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF658618A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiGaVJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiGaVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD79DF59
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 410F261137
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE4C43140;
        Sun, 31 Jul 2022 21:09:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIGBv-007GjO-2O;
        Sun, 31 Jul 2022 17:09:39 -0400
Message-ID: <20220731210939.578899044@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 17:09:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Andreas Schwab <schwab@suse.de>
Subject: [for-next][PATCH 3/4] rtla: Fix double free
References: <20220731210918.097591536@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Schwab <schwab@suse.de>

Avoid double free by making trace_instance_destroy indempotent.  When
trace_instance_init fails, it calls trace_instance_destroy, but its only
caller osnoise_destroy_tool calls it again.

Link: https://lkml.kernel.org/r/mvmilnlkyzx.fsf_-_@suse.de

Fixes: 0605bf009f18 ("rtla: Add osnoise tool")
Signed-off-by: Andreas Schwab <schwab@suse.de>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/trace.c b/tools/tracing/rtla/src/trace.c
index 5784c9f9e570..e1ba6d9f4265 100644
--- a/tools/tracing/rtla/src/trace.c
+++ b/tools/tracing/rtla/src/trace.c
@@ -134,13 +134,18 @@ void trace_instance_destroy(struct trace_instance *trace)
 	if (trace->inst) {
 		disable_tracer(trace->inst);
 		destroy_instance(trace->inst);
+		trace->inst = NULL;
 	}
 
-	if (trace->seq)
+	if (trace->seq) {
 		free(trace->seq);
+		trace->seq = NULL;
+	}
 
-	if (trace->tep)
+	if (trace->tep) {
 		tep_free(trace->tep);
+		trace->tep = NULL;
+	}
 }
 
 /*
-- 
2.35.1

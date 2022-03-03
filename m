Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F20E4CC893
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiCCWHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiCCWHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C60D171ECF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40D161D9B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAC4C340EF;
        Thu,  3 Mar 2022 22:06:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtab-00ESWM-BK;
        Thu, 03 Mar 2022 17:06:25 -0500
Message-ID: <20220303220625.186988045@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 17:05:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 1/4 v3] tracing: Allow custom events to be added to the tracefs directory
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

Allow custom events to be added to the events directory in the tracefs
file system. For example, a module could be installed that attaches to an
event and wants to be enabled and disabled via the tracefs file system. It
would use trace_add_event_call() to add the event to the tracefs
directory, and trace_remove_event_call() to remove it.

Make both those functions EXPORT_SYMBOL_GPL().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 3147614c1812..38afd66d80e3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2758,6 +2758,7 @@ int trace_add_event_call(struct trace_event_call *call)
 	mutex_unlock(&trace_types_lock);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(trace_add_event_call);
 
 /*
  * Must be called under locking of trace_types_lock, event_mutex and
@@ -2819,6 +2820,7 @@ int trace_remove_event_call(struct trace_event_call *call)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(trace_remove_event_call);
 
 #define for_each_event(event, start, end)			\
 	for (event = start;					\
-- 
2.34.1

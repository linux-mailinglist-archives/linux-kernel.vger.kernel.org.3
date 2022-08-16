Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C6D596314
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237114AbiHPTYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237109AbiHPTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:24:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7926BCF4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04C67B816A4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 19:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEABBC433C1;
        Tue, 16 Aug 2022 19:24:03 +0000 (UTC)
Date:   Tue, 16 Aug 2022 15:24:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/1] tracing: fix a WARN from trace_event_dyn_put_ref
Message-ID: <20220816152411.086ce631@gandalf.local.home>
In-Reply-To: <20220816185418.GA2004@templeofstupid.com>
References: <cover.1660347763.git.kjlx@templeofstupid.com>
        <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
        <20220816122559.17869abc@gandalf.local.home>
        <20220816185418.GA2004@templeofstupid.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 11:54:18 -0700
Krister Johansen <kjlx@templeofstupid.com> wrote:

> What do you think, would either of these be a solution that you would
> find acceptable?

Actually, I think the issue is that the unreg() calls trace_event_put_ref()
but the reg() does not do the try_get_ref(), but the perf_trace_init()
does. Which is the broken symmetry.

I think if we pull out the trace_event_put_ref() from the unreg() function,
we fix the bug and also put back the symmetry.

Does this patch work?

[ Untested, and not even compiled ]

-- Steve

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a114549720d6..61e3a2620fa3 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -157,7 +157,7 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 	int i;
 
 	if (--tp_event->perf_refcount > 0)
-		goto out;
+		return;
 
 	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
 
@@ -176,8 +176,6 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 			perf_trace_buf[i] = NULL;
 		}
 	}
-out:
-	trace_event_put_ref(tp_event);
 }
 
 static int perf_trace_event_open(struct perf_event *p_event)
@@ -241,6 +239,7 @@ void perf_trace_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 }
 
@@ -292,6 +291,7 @@ void perf_kprobe_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 
 	destroy_local_trace_kprobe(p_event->tp_event);
@@ -347,6 +347,7 @@ void perf_uprobe_destroy(struct perf_event *p_event)
 	mutex_lock(&event_mutex);
 	perf_trace_event_close(p_event);
 	perf_trace_event_unreg(p_event);
+	trace_event_put_ref(p_event->tp_event);
 	mutex_unlock(&event_mutex);
 	destroy_local_trace_uprobe(p_event->tp_event);
 }

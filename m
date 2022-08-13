Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6B5917B7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 02:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiHMACc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 20:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiHMAC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 20:02:29 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EC682859
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:02:25 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 155C1121429
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:02:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B0230121D41
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 00:02:21 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1660348941; a=rsa-sha256;
        cv=none;
        b=181nFGYMrJeFifC2hirBOKNoOYMjojdF1JgsvKxf2cEAAC5JXnX8NG0yb9zURbCi9bKeDQ
        xISveRmGVS5I+Fg2SrTVGsy/ZCVgG3pVI1Ypmbz8Bens+wx8VMscmp2blYlGF4mAIpVCmS
        X9ptf5FgOWuBv+g4icrlYpyZXURYODHXvZG4017cEVOdQiETbHkujFhiwhEDYwbt0IGILy
        RRtNNiL76atxiSxh8fglhIkXynQZdfYMWugFrBJfc5RzdAY+bps1MNHnK0UP5KHsLjiM1v
        cDF63soXlq7WbWQkSnFGVnsqk1wQY6/tfTphgMTfWQg49tbfFeoC0CbZizKIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1660348941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=KGaBVS8gSer1bvv93JlfF8uSuMQ+TPpS4Qvmn7fs+FQ=;
        b=QsPo/Iq/0McB2gLsOac+2syO5F296yXMl30cm5V83URWcVE4i4XzUsx8wDt+3QCn5CAFRp
        pifK9iey1mPszTqO4Yi0jjE8GwoEymOJgT207BZ1zTxj6XFNLyvB0Fe7ZugpaNgmSkqsS6
        uUWLStiZrCsDugfBbUdUZ4tvnhhGjYae9vFxbfrEMwvWNx51Cj+b9CXDimGCPHFICMgOT/
        j4hZWDjHZX2VXB5b6IbMdrbBFkJ2Ji1FRf15tmNFuIzAOC0EjPR/DLp6khE4ezzaAqDhHA
        bHD1ppRP7Gzx9Q6SjMM5XIdIpQLSyzK+HxhbXo7uvGi40Q/oNPGSMOOgogTXrQ==
ARC-Authentication-Results: i=1;
        rspamd-7c478d8c66-rbs6k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Coil-Trade: 0c4366c12a92d520_1660348941937_1497495729
X-MC-Loop-Signature: 1660348941937:61849340
X-MC-Ingress-Time: 1660348941936
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.124.238.80 (trex/6.7.1);
        Sat, 13 Aug 2022 00:02:21 +0000
Received: from kmjvbox (unknown [98.42.138.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4M4LMK2h51zRT
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 17:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1660348941;
        bh=KGaBVS8gSer1bvv93JlfF8uSuMQ+TPpS4Qvmn7fs+FQ=;
        h=Date:From:To:Subject:Content-Type;
        b=jWBswiW2TDl3sY4FkUtlL/vjAVSzlw1HA/S00a0dzqTwfNZdTUYWY+it2jNu7QaA4
         NPMnJbLljgbPiaU7UWJNanAN8Qjr30bzFiTEPHqW5ghde6m7CeWiT/fltjaxN/12q/
         71igvrArOVDzKYaYonCZ7zJlI4dOulJe2q2dv/Kg=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00ce
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 12 Aug 2022 17:02:20 -0700
Date:   Fri, 12 Aug 2022 17:02:20 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Reaver <me@davidreaver.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tracing: fix a WARN from trace_event_dyn_put_ref
Message-ID: <4e43a4eece5f382d1636397fb3c0208f2afe81fc.1660347763.git.kjlx@templeofstupid.com>
References: <cover.1660347763.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1660347763.git.kjlx@templeofstupid.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in perf_trace_init takes a reference on a trace_event_call that is
looked up as part of the function call.  If perf_trace_event_int fails,
however, perf_trace_event_unreg can decrement that refcount from underneath
perf_trace_init.  This means that in some failure cases, perf_trace_init
can trigger the WARN in trace_dynevent.c which attempts to guard against
zero reference counts going negative.

The author can reproduce this problem readily by running perf record in a
loop against a series of uprobes with no other users.  Killing the record
process before it can finish its setup is enough to trigger this warn
within a few seconds.

This patch leaves the behavior in perf_trace_event_unreg unchanged, but
moves most of the code in that function to perf_trace_event_cleanup.  The
unreg function retains the ability to drop the refcount on the tp_event,
but cleanup does not.  This modification is based upon the observation that
all of the other callers of perf_trace_event_init don't bother with
manipulating a reference count on the tp_events that they create.  For
those callers, the trace_event_put_ref was already a no-op.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Reviewed-by: David Reaver <me@davidreaver.com>
Fixes: 1d18538e6a092 "tracing: Have dynamic events have a ref counter"
CC: stable@vger.kernel.org # 5.15, 5.18, 5.19
---
 kernel/trace/trace_event_perf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a114549720d6..7762bfd268cd 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -151,13 +151,13 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
 	return ret;
 }
 
-static void perf_trace_event_unreg(struct perf_event *p_event)
+static void perf_trace_event_cleanup(struct perf_event *p_event)
 {
 	struct trace_event_call *tp_event = p_event->tp_event;
 	int i;
 
 	if (--tp_event->perf_refcount > 0)
-		goto out;
+		return;
 
 	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
 
@@ -176,7 +176,13 @@ static void perf_trace_event_unreg(struct perf_event *p_event)
 			perf_trace_buf[i] = NULL;
 		}
 	}
-out:
+}
+
+static void perf_trace_event_unreg(struct perf_event *p_event)
+{
+	struct trace_event_call *tp_event = p_event->tp_event;
+
+	perf_trace_event_cleanup(p_event);
 	trace_event_put_ref(tp_event);
 }
 
@@ -207,7 +213,7 @@ static int perf_trace_event_init(struct trace_event_call *tp_event,
 
 	ret = perf_trace_event_open(p_event);
 	if (ret) {
-		perf_trace_event_unreg(p_event);
+		perf_trace_event_cleanup(p_event);
 		return ret;
 	}
 
-- 
2.25.1


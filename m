Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7854CB55C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbiCCDSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiCCDSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:18:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDE6488BD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 19:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KmisOVaF/pydeRjPJ8LAOTaqZu2uZJoN0GlHrJ3jTgk=; b=ebHEJWpGVJe764hVenPrKMqYDl
        xybnOjh9Ho0f26P+hLskJ3TyyvwnFvv/bWsiWUxyQkv1e/gtRg7d23qbYMcwiTt790A3bx7JNvWJL
        b2wfKZ24AaCyvmUDgb8/aviLy/k2A8dWwUO3zt0KUC1STHdRbDVrhLsUu6n+fhQqk9W1ysz+wNgi4
        uxPr58G/S4Qmr3p7Bguv0kNGI0a2kdVXf2edOp5cx7XT3A3dFGte3xzOyC7ZuvXja1/gvkFcXR5qe
        O2y7LE6mB9zvZkX3yTg4V05Y4vBb+oZcPWDGoVRkMK/g18Ejent0Z2PGEj2gjmM8OGVGSb7FRQhnx
        jlZezlYQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPbyL-0055ao-NU; Thu, 03 Mar 2022 03:17:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Igor Zhbanov <i.zhbanov@omprussia.ru>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] trace: fix return value of __setup handlers
Date:   Wed,  2 Mar 2022 19:17:44 -0800
Message-Id: <20220303031744.32356-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__setup() handlers should generally return 1 to indicate that the
boot options have been handled.

Using invalid option values causes the entire kernel boot option
string to be reported as Unknown and added to init's environment
strings, polluting it.

  Unknown kernel command line parameters "BOOT_IMAGE=/boot/bzImage-517rc6
    kprobe_event=p,syscall_any,$arg1 trace_options=quiet
    trace_clock=jiffies", will be passed to user space.

 Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
     BOOT_IMAGE=/boot/bzImage-517rc6
     kprobe_event=p,syscall_any,$arg1
     trace_options=quiet
     trace_clock=jiffies

Return 1 from the __setup() handlers so that init's environment is not
polluted with kernel boot options.

Fixes: 7bcfaf54f591 ("tracing: Add trace_options kernel command line parameter")
Fixes: e1e232ca6b8f ("tracing: Add trace_clock=<clock> kernel parameter")
Fixes: 970988e19eb0 ("tracing/kprobe: Add kprobe_event= boot parameter")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
"trace_clock=" reports invalid parameter usage later, when it tries
to use the value:
  Trace clock jiffies not defined, going back to default

 kernel/trace/trace.c        |    4 ++--
 kernel/trace/trace_kprobe.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20220302.orig/kernel/trace/trace.c
+++ linux-next-20220302/kernel/trace/trace.c
@@ -235,7 +235,7 @@ static char trace_boot_options_buf[MAX_T
 static int __init set_trace_boot_options(char *str)
 {
 	strlcpy(trace_boot_options_buf, str, MAX_TRACER_SIZE);
-	return 0;
+	return 1;
 }
 __setup("trace_options=", set_trace_boot_options);
 
@@ -246,7 +246,7 @@ static int __init set_trace_boot_clock(c
 {
 	strlcpy(trace_boot_clock_buf, str, MAX_TRACER_SIZE);
 	trace_boot_clock = trace_boot_clock_buf;
-	return 0;
+	return 1;
 }
 __setup("trace_clock=", set_trace_boot_clock);
 
--- linux-next-20220302.orig/kernel/trace/trace_kprobe.c
+++ linux-next-20220302/kernel/trace/trace_kprobe.c
@@ -32,7 +32,7 @@ static int __init set_kprobe_boot_events
 	strlcpy(kprobe_boot_events_buf, str, COMMAND_LINE_SIZE);
 	disable_tracing_selftest("running kprobe events");
 
-	return 0;
+	return 1;
 }
 __setup("kprobe_event=", set_kprobe_boot_events);
 

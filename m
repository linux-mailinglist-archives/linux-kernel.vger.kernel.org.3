Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD5548B3FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344771AbiAKRcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiAKRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB195C061212;
        Tue, 11 Jan 2022 09:31:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A2BEB81C53;
        Tue, 11 Jan 2022 17:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35839C36AEB;
        Tue, 11 Jan 2022 17:31:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzO-0032JW-Cu;
        Tue, 11 Jan 2022 12:31:18 -0500
Message-ID: <20220111173118.234471647@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:30:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tao Zhou <tao.zhou@linux.dev>, Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [for-next][PATCH 27/31] rtla: Add rtla timerlat documentation
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Man page for rtla timerlat tool.

Link: https://lkml.kernel.org/r/644599d0041c53a2d0646ca72eaa783100dc32a2.1638182284.git.bristot@kernel.org

Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: linux-rt-users@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../rtla/common_timerlat_description.rst      | 10 ++++
 Documentation/tools/rtla/rtla-timerlat.rst    | 57 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/tools/rtla/common_timerlat_description.rst
 create mode 100644 Documentation/tools/rtla/rtla-timerlat.rst

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.rst
new file mode 100644
index 000000000000..321201cb8597
--- /dev/null
+++ b/Documentation/tools/rtla/common_timerlat_description.rst
@@ -0,0 +1,10 @@
+The **rtla timerlat** tool is an interface for the *timerlat* tracer. The
+*timerlat* tracer dispatches a kernel thread per-cpu. These threads
+set a periodic timer to wake themselves up and go back to sleep. After
+the wakeup, they collect and generate useful information for the
+debugging of operating system timer latency.
+
+The *timerlat* tracer outputs information in two ways. It periodically
+prints the timer latency at the timer *IRQ* handler and the *Thread*
+handler. It also enable the trace of the most relevant information via
+**osnoise:** tracepoints.
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
new file mode 100644
index 000000000000..44a49e6f302b
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -0,0 +1,57 @@
+================
+rtla-timerlat
+================
+-------------------------------------------
+Measures the operating system timer latency
+-------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla timerlat** [*MODE*] ...
+
+DESCRIPTION
+===========
+
+.. include:: common_timerlat_description.rst
+
+The *timerlat* tracer outputs information in two ways. It periodically
+prints the timer latency at the timer *IRQ* handler and the *Thread* handler.
+It also provides information for each noise via the **osnoise:** tracepoints.
+The **rtla timerlat top** mode displays a summary of the periodic output
+from the *timerlat* tracer. The **rtla hist hist** mode displays a histogram
+of each tracer event occurrence. For further details, please refer to the
+respective man page.
+
+MODES
+=====
+**top**
+
+        Prints the summary from *timerlat* tracer.
+
+**hist**
+
+        Prints a histogram of timerlat samples.
+
+If no *MODE* is given, the top mode is called, passing the arguments.
+
+OPTIONS
+=======
+**-h**, **--help**
+
+        Display the help text.
+
+For other options, see the man page for the corresponding mode.
+
+SEE ALSO
+========
+**rtla-timerlat-top**\(1), **rtla-timerlat-hist**\(1)
+
+*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.33.0

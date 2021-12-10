Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A0470842
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245274AbhLJSSC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 13:18:02 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:35623 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245251AbhLJSRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:17:51 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-Az7YC6fuO6iEpALkR6pXxw-1; Fri, 10 Dec 2021 13:14:12 -0500
X-MC-Unique: Az7YC6fuO6iEpALkR6pXxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CAE981EE62;
        Fri, 10 Dec 2021 18:14:11 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8A9760BF4;
        Fri, 10 Dec 2021 18:14:06 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tao Zhou <tao.zhou@linux.dev>
Subject: [PATCH V9 12/14] rtla: Add rtla timerlat documentation
Date:   Fri, 10 Dec 2021 19:11:31 +0100
Message-Id: <78678b8d024bf5a3a79f831ac9441b96e8d2f56e.1639158831.git.bristot@kernel.org>
In-Reply-To: <cover.1639158831.git.bristot@kernel.org>
References: <cover.1639158831.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Man page for rtla timerlat tool.

Cc: Steven Rostedt <rostedt@goodmis.org>
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
2.31.1


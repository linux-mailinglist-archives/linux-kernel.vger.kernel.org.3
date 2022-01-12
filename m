Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D1748CCC7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357775AbiALUCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357271AbiALUAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:00:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB25C034009;
        Wed, 12 Jan 2022 12:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A2AFB820EE;
        Wed, 12 Jan 2022 20:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2904EC36AF4;
        Wed, 12 Jan 2022 20:00:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7jnP-003ESc-BZ;
        Wed, 12 Jan 2022 15:00:35 -0500
Message-ID: <20220112200035.187441514@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 12 Jan 2022 14:58:54 -0500
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
Subject: [for-next][PATCH 11/14] rtla: Add rtla osnoise hist documentation
References: <20220112195843.098894945@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Man page for rtla osnoise hist mode.

Link: https://lkml.kernel.org/r/d43cc5d516b8db180575c4b66c4aa67c6a724a8d.1639158831.git.bristot@kernel.org

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
 .../tools/rtla/common_hist_options.rst        | 23 +++++++
 .../tools/rtla/rtla-osnoise-hist.rst          | 66 +++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/tools/rtla/common_hist_options.rst
 create mode 100644 Documentation/tools/rtla/rtla-osnoise-hist.rst

diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.rst
new file mode 100644
index 000000000000..0266cd08a6c9
--- /dev/null
+++ b/Documentation/tools/rtla/common_hist_options.rst
@@ -0,0 +1,23 @@
+**-b**, **--bucket-size** *N*
+
+        Set the histogram bucket size (default *1*).
+
+**-e**, **--entries** *N*
+
+        Set the number of entries of the histogram (default 256).
+
+**--no-header**
+
+        Do not print header.
+
+**--no-summary**
+
+        Do not print summary.
+
+**--no-index**
+
+        Do not print index.
+
+**--with-zeros**
+
+        Print zero only entries.
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
new file mode 100644
index 000000000000..52298ddd8701
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -0,0 +1,66 @@
+===================
+rtla-osnoise-hist
+===================
+------------------------------------------------------
+Display a histogram of the osnoise tracer samples
+------------------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla osnoise hist** [*OPTIONS*]
+
+DESCRIPTION
+===========
+.. include:: common_osnoise_description.rst
+
+The **rtla osnoise hist** tool collects all **osnoise:sample_threshold**
+occurrence in a histogram, displaying the results in a user-friendly way.
+The tool also allows many configurations of the *osnoise* tracer and the
+collection of the tracer output.
+
+OPTIONS
+=======
+.. include:: common_osnoise_options.rst
+
+.. include:: common_hist_options.rst
+
+.. include:: common_options.rst
+
+EXAMPLE
+=======
+In the example below, *osnoise* tracer threads are set to run with real-time
+priority *FIFO:1*, on CPUs *0-11*, for *900ms* at each period (*1s* by
+default). The reason for reducing the runtime is to avoid starving the
+**rtla** tool. The tool is also set to run for *one minute*. The output
+histogram is set to group outputs in buckets of *10us* and *25* entries::
+
+  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -e 25
+  # RTLA osnoise histogram
+  # Time unit is microseconds (us)
+  # Duration:   0 00:01:00
+  Index   CPU-000   CPU-001   CPU-002   CPU-003   CPU-004   CPU-005   CPU-006   CPU-007   CPU-008   CPU-009   CPU-010   CPU-011
+  0         42982     46287     51779     53740     52024     44817     49898     36500     50408     50128     49523     52377
+  10        12224      8356      2912       878      2667     10155      4573     18894      4214      4836      5708      2413
+  20            8         5        12         2        13        24        20        41        29        53        39        39
+  30            1         1         0         0        10         3         6        19        15        31        30        38
+  40            0         0         0         0         0         4         2         7         2         3         8        11
+  50            0         0         0         0         0         0         0         0         0         1         1         2
+  over:         0         0         0         0         0         0         0         0         0         0         0         0
+  count:    55215     54649     54703     54620     54714     55003     54499     55461     54668     55052     55309     54880
+  min:          0         0         0         0         0         0         0         0         0         0         0         0
+  avg:          0         0         0         0         0         0         0         0         0         0         0         0
+  max:         30        30        20        20        30        40        40        40        40        50        50        50
+
+SEE ALSO
+========
+**rtla-osnoise**\(1), **rtla-osnoise-top**\(1)
+
+*osnoise* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
+
+.. include:: common_appendix.rst
-- 
2.33.0

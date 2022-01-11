Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997F348B3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344819AbiAKRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344252AbiAKRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:31:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EFCC061245;
        Tue, 11 Jan 2022 09:31:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF7A0B81C3C;
        Tue, 11 Jan 2022 17:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E73AC36AF7;
        Tue, 11 Jan 2022 17:31:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n7KzO-0032Kf-Oa;
        Tue, 11 Jan 2022 12:31:18 -0500
Message-ID: <20220111173118.601019285@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 11 Jan 2022 12:31:00 -0500
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
Subject: [for-next][PATCH 29/31] rtla: Add rtla timerlat hist documentation
References: <20220111173030.999527342@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Man page for rtla timerlat hist mode.

Link: https://lkml.kernel.org/r/0e2bd067f32d9da3244396741d37c09278a04f91.1638182284.git.bristot@kernel.org

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
 .../tools/rtla/rtla-timerlat-hist.rst         | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/tools/rtla/rtla-timerlat-hist.rst

diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
new file mode 100644
index 000000000000..e12eae1f3301
--- /dev/null
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -0,0 +1,106 @@
+=====================
+rtla-timerlat-hist
+=====================
+------------------------------------------------
+Histograms of the operating system timer latency
+------------------------------------------------
+
+:Manual section: 1
+
+SYNOPSIS
+========
+**rtla timerlat hist** [*OPTIONS*] ...
+
+DESCRIPTION
+===========
+
+.. include:: common_timerlat_description.rst
+
+The **rtla timerlat hist** displays a histogram of each tracer event
+occurrence. This tool uses the periodic information, and the
+**osnoise:** tracepoints are enabled when using the **-T** option.
+
+OPTIONS
+=======
+
+.. include:: common_timerlat_options.rst
+
+.. include:: common_hist_options.rst
+
+.. include:: common_options.rst
+
+EXAMPLE
+=======
+In the example below, **rtla timerlat hist** is set to run for *10* minutes,
+in the cpus *0-4*, *skipping zero* only lines. Moreover, **rtla timerlat
+hist** will change the priority of the *timelat* threads to run under
+*SCHED_DEADLINE* priority, with a *10us* runtime every *1ms* period. The
+*1ms* period is also passed to the *timerlat* tracer::
+
+  [root@alien ~]# timerlat hist -d 10m -c 0-4 -P d:100us:1ms -p 1ms
+  # RTLA timerlat histogram
+  # Time unit is microseconds (us)
+  # Duration:   0 00:10:00
+  Index   IRQ-000   Thr-000   IRQ-001   Thr-001   IRQ-002   Thr-002   IRQ-003   Thr-003   IRQ-004   Thr-004
+  0        276489         0    206089         0    466018         0    481102         0    205546         0
+  1        318327     35487    388149     30024     94531     48382     83082     71078    388026     55730
+  2          3282    122584      4019    126527     28231    109012     23311     89309      4568     98739
+  3           940     11815       837      9863      6209     16227      6895     17196       910      9780
+  4           444     17287       424     11574      2097     38443      2169     36736       462     13476
+  5           206     43291       255     25581      1223    101908      1304    101137       236     28913
+  6           132    101501        96     64584       635    213774       757    215471        99     73453
+  7            74    169347        65    124758       350     57466       441     53639        69    148573
+  8            53     85183        31    156751       229      9052       306      9026        39    139907
+  9            22     10387        12     42762       161      2554       225      2689        19     26192
+  10           13      1898         8      5770       114      1247       128      1405        13      3772
+  11            9       560         9       924        71       686        76       765         8       713
+  12            4       256         2       360        50       411        64       474         3       278
+  13            2       167         2       172        43       256        53       350         4       180
+  14            1        88         1       116        15       198        42       223         0       115
+  15            2        63         3        94        11       139        20       150         0        58
+  16            2        37         0        56         5        78        10       102         0        39
+  17            0        18         0        28         4        57         8        80         0        15
+  18            0         8         0        17         2        50         6        56         0        12
+  19            0         9         0         5         0        19         0        48         0        18
+  20            0         4         0         8         0        11         2        27         0         4
+  21            0         2         0         3         1         9         1        18         0         6
+  22            0         1         0         3         1         7         0         3         0         5
+  23            0         2         0         4         0         2         0         7         0         2
+  24            0         2         0         2         1         3         0         3         0         5
+  25            0         0         0         1         0         1         0         1         0         3
+  26            0         1         0         0         0         2         0         2         0         0
+  27            0         0         0         3         0         1         0         0         0         1
+  28            0         0         0         3         0         0         0         1         0         0
+  29            0         0         0         2         0         2         0         1         0         3
+  30            0         1         0         0         0         0         0         0         0         0
+  31            0         1         0         0         0         0         0         2         0         2
+  32            0         0         0         1         0         2         0         0         0         0
+  33            0         0         0         2         0         0         0         0         0         1
+  34            0         0         0         0         0         0         0         0         0         2
+  35            0         1         0         1         0         0         0         0         0         1
+  36            0         1         0         0         0         1         0         1         0         0
+  37            0         0         0         1         0         0         0         0         0         0
+  40            0         0         0         0         0         1         0         1         0         0
+  41            0         0         0         0         0         0         0         0         0         1
+  42            0         0         0         0         0         0         0         0         0         1
+  44            0         0         0         0         0         1         0         0         0         0
+  46            0         0         0         0         0         0         0         1         0         0
+  47            0         0         0         0         0         0         0         0         0         1
+  50            0         0         0         0         0         0         0         0         0         1
+  54            0         0         0         1         0         0         0         0         0         0
+  58            0         0         0         1         0         0         0         0         0         0
+  over:         0         0         0         0         0         0         0         0         0         0
+  count:   600002    600002    600002    600002    600002    600002    600002    600002    600002    600002
+  min:          0         1         0         1         0         1         0         1         0         1
+  avg:          0         5         0         5         0         4         0         4         0         5
+  max:         16        36        15        58        24        44        21        46        13        50
+
+SEE ALSO
+========
+**rtla-timerlat**\(1), **rtla-timerlat-top**\(1)
+
+*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+
+AUTHOR
+======
+Written by Daniel Bristot de Oliveira <bristot@kernel.org>
-- 
2.33.0

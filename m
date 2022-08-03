Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16F588EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbiHCOtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 10:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiHCOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 10:49:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811619C07
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 07:49:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B82EB822CC
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493CCC433C1;
        Wed,  3 Aug 2022 14:49:38 +0000 (UTC)
Date:   Wed, 3 Aug 2022 10:49:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        jianchunfu <jianchunfu@cmss.chinamobile.com>
Subject: [GIT PULL] rtla: Updates for 5.20/6.0
Message-ID: <20220803104936.7df810fd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Real Time Analysis Tool updates for 5.20 / 6.0

Changes to RTLA:

 - Fix a double free

 - Define syscall numbers for RISCV

 - Fix Makefile when called from -C tools

 - Use calloc() to check for memory allocation failures


Please pull the latest trace-rtla-v5.20 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-rtla-v5.20

Tag SHA1: ae546e8855f305db853d17a6509e267286dc5b2d
Head SHA1: dd0b15bda48f59eb7dee17fab91eda8389f0e98d


Andreas Schwab (2):
      rtla: Fix double free
      rtla: Define syscall numbers for riscv

Daniel Bristot de Oliveira (1):
      rtla: Fix Makefile when called from -C tools/

jianchunfu (1):
      rtla/utils: Use calloc and check the potential memory allocation failure

----
 tools/tracing/rtla/Makefile    | 2 +-
 tools/tracing/rtla/src/trace.c | 9 +++++++--
 tools/tracing/rtla/src/utils.c | 7 ++++---
 3 files changed, 12 insertions(+), 6 deletions(-)
---------------------------
diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 3822f4ea5f49..1bea2d16d4c1 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -1,6 +1,6 @@
 NAME	:=	rtla
 # Follow the kernel version
-VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
+VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
 
 # From libtracefs:
 # Makefiles suck: This macro sets a default value of $(2) for the
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
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 5352167a1e75..663a047f794d 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -106,8 +106,9 @@ int parse_cpu_list(char *cpu_list, char **monitored_cpus)
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
-	mon_cpus = malloc(nr_cpus * sizeof(char));
-	memset(mon_cpus, 0, (nr_cpus * sizeof(char)));
+	mon_cpus = calloc(nr_cpus, sizeof(char));
+	if (!mon_cpus)
+		goto err;
 
 	for (p = cpu_list; *p; ) {
 		cpu = atoi(p);
@@ -224,7 +225,7 @@ long parse_ns_duration(char *val)
 #elif __arm__
 # define __NR_sched_setattr	380
 # define __NR_sched_getattr	381
-#elif __aarch64__
+#elif __aarch64__ || __riscv
 # define __NR_sched_setattr	274
 # define __NR_sched_getattr	275
 #elif __powerpc__

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0B8497004
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 06:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiAWFZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 00:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiAWFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 00:25:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D754DC06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 21:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB4346113A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 05:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82DDC340E3;
        Sun, 23 Jan 2022 05:25:20 +0000 (UTC)
Date:   Sun, 23 Jan 2022 00:25:19 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>
Subject: [GIT PULL] ftrace: Fix of s390 breakage
Message-ID: <20220123002519.6f693e08@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

ftrace: Fix s390 breakage from sorting mcount tables

The latest merge of the tracing tree sorts the mcount table at build time.
But s390 appears to do things differently (like always) and replaces the
sorted table back to the original unsorted one. As the ftrace algorithm
depends on it being sorted, bad things happen when it is not, and s390
experienced those bad things.

Add a new config to tell the boot if the mcount table is sorted or not,
and allow s390 to opt out of it.


Please pull the latest trace-v5.17-3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-3

Tag SHA1: d749b00c1ef5fb0ea77fd9f28350b32d27faafde
Head SHA1: 6b9b6413700e104934734b72a3be622a76923b98


Steven Rostedt (Google) (1):
      ftrace: Fix assuming build time sort works for s390

----
 kernel/trace/Kconfig  | 9 ++++++++-
 kernel/trace/ftrace.c | 4 ++--
 2 files changed, 10 insertions(+), 3 deletions(-)
---------------------------
commit 6b9b6413700e104934734b72a3be622a76923b98
Author: Steven Rostedt (Google) <rostedt@goodmis.org>
Date:   Sat Jan 22 09:17:10 2022 -0500

    ftrace: Fix assuming build time sort works for s390
    
    To speed up the boot process, as mcount_loc needs to be sorted for ftrace
    to work properly, sorting it at build time is more efficient than boot up
    and can save milliseconds of time. Unfortunately, this change broke s390
    as it will modify the mcount_loc location after the sorting takes place
    and will put back the unsorted locations. Since the sorting is skipped at
    boot up if it is believed that it was sorted at run time, ftrace can crash
    as its algorithms are dependent on the list being sorted.
    
    Add a new config BUILDTIME_MCOUNT_SORT that is set when
    BUILDTIME_TABLE_SORT but not if S390 is set. Use this config to determine
    if sorting should take place at boot up.
    
    Link: https://lore.kernel.org/all/yt9dee51ctfn.fsf@linux.ibm.com/
    
    Fixes: 72b3942a173c ("scripts: ftrace - move the sort-processing in ftrace_init")
    Reported-by: Sven Schnelle <svens@linux.ibm.com>
    Tested-by: Heiko Carstens <hca@linux.ibm.com>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index f468767bc287..752ed89a293b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -70,6 +70,13 @@ config HAVE_C_RECORDMCOUNT
 	help
 	  C version of recordmcount available?
 
+config BUILDTIME_MCOUNT_SORT
+       bool
+       default y
+       depends on BUILDTIME_TABLE_SORT && !S390
+       help
+         Sort the mcount_loc section at build time.
+
 config TRACER_MAX_TRACE
 	bool
 
@@ -918,7 +925,7 @@ config EVENT_TRACE_TEST_SYSCALLS
 config FTRACE_SORT_STARTUP_TEST
        bool "Verify compile time sorting of ftrace functions"
        depends on DYNAMIC_FTRACE
-       depends on BUILDTIME_TABLE_SORT
+       depends on BUILDTIME_MCOUNT_SORT
        help
 	 Sorting of the mcount_loc sections that is used to find the
 	 where the ftrace knows where to patch functions for tracing
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 403e485bf091..b01e1fa62193 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6429,10 +6429,10 @@ static int ftrace_process_locs(struct module *mod,
 
 	/*
 	 * Sorting mcount in vmlinux at build time depend on
-	 * CONFIG_BUILDTIME_TABLE_SORT, while mcount loc in
+	 * CONFIG_BUILDTIME_MCOUNT_SORT, while mcount loc in
 	 * modules can not be sorted at build time.
 	 */
-	if (!IS_ENABLED(CONFIG_BUILDTIME_TABLE_SORT) || mod) {
+	if (!IS_ENABLED(CONFIG_BUILDTIME_MCOUNT_SORT) || mod) {
 		sort(start, count, sizeof(*start),
 		     ftrace_cmp_ips, NULL);
 	} else {

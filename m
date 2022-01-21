Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B60B4964D6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382057AbiAUSLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:11:54 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49590 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351822AbiAUSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:11:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16742B81F69;
        Fri, 21 Jan 2022 18:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA999C340E1;
        Fri, 21 Jan 2022 18:11:49 +0000 (UTC)
Date:   Fri, 21 Jan 2022 13:11:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>, peterz@infradead.org,
        mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v8] scripts: ftrace - move the sort-processing in
 ftrace_init
Message-ID: <20220121131148.2025bc5b@gandalf.local.home>
In-Reply-To: <YeqOFHNfxKcNXNrn@osiris>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211212113358.34208-1-yinan@linux.alibaba.com>
        <20211212113358.34208-2-yinan@linux.alibaba.com>
        <yt9dee51ctfn.fsf@linux.ibm.com>
        <YeqOFHNfxKcNXNrn@osiris>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 11:42:28 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> This really should be addressed before rc1 is out, otherwise s390 is
> broken if somebody enables ftrace.
> Where "broken" translates to random crashes as soon as ftrace is
> enabled, which again is nowadays quite common.

Instead of reverting, should we just add this patch?

-- Steve

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

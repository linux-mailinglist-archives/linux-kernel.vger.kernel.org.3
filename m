Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869EC46A6C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349486AbhLFUWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349098AbhLFUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:22:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973BEC061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 12:19:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D0CACCE180E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62231C341C1;
        Mon,  6 Dec 2021 20:19:00 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:18:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     peterz@infradead.org, mark-pk.tsai@mediatek.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v6 1/2] scripts: ftrace - move the sort-processing in
 ftrace_init
Message-ID: <20211206151858.4d21a24d@gandalf.local.home>
In-Reply-To: <20211202125800.7b346733@gandalf.local.home>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
        <20211202021606.48812-1-yinan@linux.alibaba.com>
        <20211202021606.48812-2-yinan@linux.alibaba.com>
        <20211202125800.7b346733@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2021 12:58:00 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  2 Dec 2021 10:16:05 +0800
> Yinan Liu <yinan@linux.alibaba.com> wrote:
> 
> > When the kernel starts, the initialization of ftrace takes
> > up a portion of the time (approximately 6~8ms) to sort mcount
> > addresses. We can save this time by moving mcount-sorting to
> > compile time.
> > 
> > Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> > Reported-by: kernel test robot <lkp@intel.com>  
> 
> After applying this, I get a failure on the kprobe self tests at boot up:
> 
>  Testing ftrace filter: OK
>  trace_kprobe: Testing kprobe tracing: 
>  trace_kprobe: Could not probe notrace function kprobe_trace_selftest_target
>  ------------[ cut here ]------------
>  WARNING: CPU: 2 PID: 1 at kernel/trace/trace_kprobe.c:1973 kprobe_trace_self_tests_init+0x5c/0x497
>  Modules linked in:

And I added the below patch, and it shows that the section is not properly
sorted. Something went wrong with your sorting.

I plan on keeping this check, at least as a compile option, to make sure
that the output is sorted, otherwise things will silently fail if they are
not.

This patch produced:

[    1.315419] ftrace: allocating 43510 entries in 170 pages
[    1.320638] ------------[ cut here ]------------
[    1.325227] [3] x86_pnpbios_disabled+0x0/0x1c at 8a51c707 is not sorted with __traceiter_initcall_level+0x0/0x60 at 87000660

I'm dropping the patches until this is "sorted out" :-)

-- Steve

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9ca63df6553a..b112d00ba534 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6388,6 +6388,19 @@ static int ftrace_cmp_ips(const void *a, const void
*b) return 0;
 }
 
+static void test_is_sorted(unsigned long *start, unsigned long count)
+{
+	int i;
+
+	for (i = 1; i < count; i++) {
+		if (WARN(start[i - 1] > start[i],
+			 "[%d] %pS at %x is not sorted with %pS at %x\n",
i,
+			 (void *)start[i - 1], start[i - 1],
+			 (void *)start[i], start[i]))
+			break;
+	}
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6414,6 +6427,8 @@ static int ftrace_process_locs(struct module *mod,
 	if (!IS_ENABLED(CONFIG_BUILDTIME_TABLE_SORT) || mod) {
 		sort(start, count, sizeof(*start),
 		     ftrace_cmp_ips, NULL);
+	} else {
+		test_is_sorted(start, count);
 	}
 
 	start_pg = ftrace_allocate_pages(count);

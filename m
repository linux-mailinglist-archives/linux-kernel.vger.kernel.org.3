Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51791465C07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 03:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352074AbhLBCPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 21:15:52 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:60834 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbhLBCPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 21:15:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0653CE2152
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE2FC00446;
        Thu,  2 Dec 2021 02:12:20 +0000 (UTC)
Date:   Wed, 1 Dec 2021 21:12:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chen Jun <chenjun102@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [GIT PULL] tracing: Minor fixes for 5.16-rc3
Message-ID: <20211201211218.5f9e8ae8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Three tracing fixes:

- Allow compares of strings when using signed and unsigned characters

- Fix kmemleak false positive for histogram entries.

- Handle negative numbers for user defined kretprobe data sizes


Please pull the latest trace-v5.16-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.16-rc3

Tag SHA1: a9213711ec6377e609967c5752305298b3c9ce60
Head SHA1: 6bbfa44116689469267f1a6e3d233b52114139d2


Chen Jun (1):
      tracing: Fix a kmemleak false positive in tracing_map

Masami Hiramatsu (1):
      kprobes: Limit max data_size of the kretprobe instances

Steven Rostedt (VMware) (1):
      tracing/histograms: String compares should not care about signed values

----
 include/linux/kprobes.h          | 2 ++
 kernel/kprobes.c                 | 3 +++
 kernel/trace/trace_events_hist.c | 2 +-
 kernel/trace/tracing_map.c       | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)
---------------------------
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e974caf39d3e..8c8f7a4d93af 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -153,6 +153,8 @@ struct kretprobe {
 	struct kretprobe_holder *rph;
 };
 
+#define KRETPROBE_MAX_DATA_SIZE	4096
+
 struct kretprobe_instance {
 	union {
 		struct freelist_node freelist;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e9db0c810554..21eccc961bba 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2086,6 +2086,9 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	if (rp->data_size > KRETPROBE_MAX_DATA_SIZE)
+		return -E2BIG;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9555b8e1d1e3..319f9c8ca7e7 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3757,7 +3757,7 @@ static int check_synth_field(struct synth_event *event,
 
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
-		    field->is_signed != hist_field->is_signed)
+		    (!field->is_string && field->is_signed != hist_field->is_signed))
 			return -EINVAL;
 	}
 
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 39bb56d2dcbe..9628b5571846 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -15,6 +15,7 @@
 #include <linux/jhash.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/kmemleak.h>
 
 #include "tracing_map.h"
 #include "trace.h"
@@ -307,6 +308,7 @@ static void tracing_map_array_free(struct tracing_map_array *a)
 	for (i = 0; i < a->n_pages; i++) {
 		if (!a->pages[i])
 			break;
+		kmemleak_free(a->pages[i]);
 		free_page((unsigned long)a->pages[i]);
 	}
 
@@ -342,6 +344,7 @@ static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!a->pages[i])
 			goto free;
+		kmemleak_alloc(a->pages[i], PAGE_SIZE, 1, GFP_KERNEL);
 	}
  out:
 	return a;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27C6487EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiAGWZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiAGWZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:25:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68FFC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 14:25:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA2C61FDA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 22:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4F2C36AE5;
        Fri,  7 Jan 2022 22:25:32 +0000 (UTC)
Date:   Fri, 7 Jan 2022 17:25:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 3/3] tracing/filter: make filter_pred_pchar() survive
 the access to user space
Message-ID: <20220107172531.508ddbf1@gandalf.local.home>
In-Reply-To: <20220107044951.22080-4-kernelfans@gmail.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
        <20220107044951.22080-4-kernelfans@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 12:49:51 +0800
Pingfan Liu <kernelfans@gmail.com> wrote:

> When
>   echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
>   echo 1 > events/syscalls/sys_enter_at/enable

So this is definitely a bug. Thanks for reporting this.

> 
> Then the following #PF is observed:
>     kvm-03-guest16 login: [72198.026181] BUG: unable to handle page fault for address: 00007fffaae8ef60
>     [72198.027625] #PF: supervisor read access in kernel mode
>     [72198.028627] #PF: error_code(0x0001) - permissions violation
>     [72198.029708] PGD 80000001008b7067 P4D 80000001008b7067 PUD 2393f1067 PMD 2393ec067 PTE 8000000108f47867
>     [72198.031588] Oops: 0001 [#1] PREEMPT SMP PTI
>     [72198.032410] CPU: 1 PID: 1 Comm: systemd Kdump: loaded Not tainted 5.14.0-32.el9.x86_64 #1
>     [72198.034021] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
>     [72198.035190] RIP: 0010:strlen+0x0/0x20
>     [72198.035914] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
>     [72198.039576] RSP: 0018:ffffb5b900013e48 EFLAGS: 00010246
>     [72198.040593] RAX: 0000000000000018 RBX: ffff8fc1c49ede00 RCX: 0000000000000000
>     [72198.041991] RDX: 0000000000000020 RSI: ffff8fc1c02d601c RDI: 00007fffaae8ef60
>     [72198.043419] RBP: 00007fffaae8ef60 R08: 0005034f4ddb8ea4 R09: 0000000000000000
>     [72198.044800] R10: ffff8fc1c02d601c R11: 0000000000000000 R12: ffff8fc1c8a6e380
>     [72198.046185] R13: 0000000000000000 R14: ffff8fc1c02d6010 R15: ffff8fc1c00453c0
>     [72198.047610] FS:  00007fa86123db40(0000) GS:ffff8fc2ffd00000(0000) knlGS:0000000000000000
>     [72198.049206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [72198.050332] CR2: 00007fffaae8ef60 CR3: 0000000102880001 CR4: 00000000007706e0
>     [72198.051760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     [72198.053168] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     [72198.054550] PKRU: 55555554
>     [72198.055114] Call Trace:
>     [72198.055616]  filter_pred_pchar+0x18/0x40
>     [72198.056421]  filter_match_preds+0x31/0x70
>     [72198.057210]  ftrace_syscall_enter+0x27a/0x2c0
>     [72198.058088]  syscall_trace_enter.constprop.0+0x1aa/0x1d0
>     [72198.059163]  do_syscall_64+0x16/0x90
>     [72198.059898]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>     [72198.060904] RIP: 0033:0x7fa861d88664
> 
> Apparently, it is caused by supervisor read access in kernel mode.
> 
> To tackle this issue caused by event_class_syscall_enter, using the pair
> of user_access_{begin/end}() may be an efficient method, but it means to
> stir up _ASM_EXTABLE. Hence this patch picks up the road of
> copy_from_user(). This is achieved by introducing a field 'uaccess' in
> ftrace_event_field, and run regex.match on the copied buffer.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/trace/trace.h               |  1 +
>  kernel/trace/trace_events_filter.c | 29 ++++++++++++++++++++++++++---
>  2 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 38715aa6cfdf..81a263a060e8 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1281,6 +1281,7 @@ struct ftrace_event_field {
>  	int			offset;
>  	int			size;
>  	int			is_signed;
> +	int			uaccess;
>  };
>  
>  struct prog_entry;
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 2a05315127f9..9af268b98c61 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -10,6 +10,7 @@
>  #include <linux/mutex.h>
>  #include <linux/perf_event.h>
>  #include <linux/slab.h>
> +#include <linux/syscalls.h>
>  
>  #include "trace.h"
>  #include "trace_output.h"
> @@ -672,12 +673,30 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
>  static int filter_pred_pchar(struct filter_pred *pred, void *event)
>  {
>  	char *addr = (char *)(event + pred->offset);
> +	char *udata, *cmp_buff;
>  	int cmp, match;
> -	int len = strlen(addr) + 1;	/* including tailing '\0' */
> +	int len, poffset;
> +
> +	if (unlikely(pred->field->uaccess)) {
> +		udata = kmalloc(PAGE_SIZE, GFP_KERNEL);

This is called within a tracepoint, thus you can not call kmalloc.

> +		if (!udata)
> +			return -ENOMEM;
> +		poffset = (ulong)addr & (PAGE_SIZE - 1);
> +		cmp_buff = udata + poffset;
> +		if (copy_from_user(cmp_buff, addr, PAGE_SIZE - poffset)) {
> +			kfree(udata);
> +			return -EFAULT;
> +		}
> +	} else {
> +		cmp_buff = addr;
> +	}
> +	len = strlen(cmp_buff) + 1;	/* including tailing '\0' */
>  
> -	cmp = pred->regex.match(addr, &pred->regex, len);
> +	cmp = pred->regex.match(cmp_buff, &pred->regex, len);
>  
>  	match = cmp ^ pred->not;
> +	if (unlikely(pred->field->uaccess))
> +		kfree(udata);
>  
>  	return match;
>  }
> @@ -1220,6 +1239,7 @@ static int parse_pred(const char *str, struct trace_event_call *data,
>  		return -ENOMEM;
>  
>  	pred->field = field;
> +	field->uaccess = 0;
>  	pred->offset = field->offset;
>  	pred->op = op;
>  
> @@ -1321,8 +1341,11 @@ static int parse_pred(const char *str, struct trace_event_call *data,
>  
>  		} else if (field->filter_type == FILTER_DYN_STRING)
>  			pred->fn = filter_pred_strloc;
> -		else
> +		else {
>  			pred->fn = filter_pred_pchar;
> +			if (data->class == &event_class_syscall_enter)
> +				pred->field->uaccess = 1;
> +		}
>  		/* go past the last quote */
>  		i++;
>  

This is not the right way to fix it. Simply check if the string is user
space and copy it into a temp per cpu buffer. In fact, kernel space strings
should be tested as well.

I wrote this up. Can you make sure it works for you?

Thanks,

-- Steve

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracing: Add test for user space strings when filtering on
 string pointers

Pingfan reported that the following causes a fault:

  echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
  echo 1 > events/syscalls/sys_enter_at/enable

The reason is that trace event filter treats the user space pointer
defined by "filename" as a normal pointer to compare against the "cpu"
string. If the string is not loaded into memory yet, it will trigger a
fault in kernel space:

 kvm-03-guest16 login: [72198.026181] BUG: unable to handle page fault for address: 00007fffaae8ef60
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0001) - permissions violation
 PGD 80000001008b7067 P4D 80000001008b7067 PUD 2393f1067 PMD 2393ec067 PTE 8000000108f47867
 Oops: 0001 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 1 Comm: systemd Kdump: loaded Not tainted 5.14.0-32.el9.x86_64 #1
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:strlen+0x0/0x20
 Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11
       48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8
       48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
 RSP: 0018:ffffb5b900013e48 EFLAGS: 00010246
 RAX: 0000000000000018 RBX: ffff8fc1c49ede00 RCX: 0000000000000000
 RDX: 0000000000000020 RSI: ffff8fc1c02d601c RDI: 00007fffaae8ef60
 RBP: 00007fffaae8ef60 R08: 0005034f4ddb8ea4 R09: 0000000000000000
 R10: ffff8fc1c02d601c R11: 0000000000000000 R12: ffff8fc1c8a6e380
 R13: 0000000000000000 R14: ffff8fc1c02d6010 R15: ffff8fc1c00453c0
 FS:  00007fa86123db40(0000) GS:ffff8fc2ffd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007fffaae8ef60 CR3: 0000000102880001 CR4: 00000000007706e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  filter_pred_pchar+0x18/0x40
  filter_match_preds+0x31/0x70
  ftrace_syscall_enter+0x27a/0x2c0
  syscall_trace_enter.constprop.0+0x1aa/0x1d0
  do_syscall_64+0x16/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7fa861d88664

To be even more robust, test both kernel and user space strings. If the
string fails to read, then simply have the filter fail.

Link: https://lore.kernel.org/all/20220107044951.22080-1-kernelfans@gmail.com/

Cc: stable@vger.kernel.org
Reported-by: Pingfan Liu <kernelfans@gmail.com>
Fixes: 87a342f5db69d ("tracing/filters: Support filtering for char * strings")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 79 +++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 996920ed1812..cf0fa9a785c7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2009 Tom Zanussi <tzanussi@gmail.com>
  */
 
+#include <linux/uaccess.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/mutex.h>
@@ -654,12 +655,50 @@ DEFINE_EQUALITY_PRED(32);
 DEFINE_EQUALITY_PRED(16);
 DEFINE_EQUALITY_PRED(8);
 
+/* user space strings temp buffer */
+#define USTRING_BUF_SIZE	512
+
+struct ustring_buffer {
+	char		buffer[USTRING_BUF_SIZE];
+};
+
+static __percpu struct ustring_buffer *ustring_per_cpu;
+
+static __always_inline char *test_string(char *str)
+{
+	struct ustring_buffer *ubuf;
+	char __user *ustr;
+	char *kstr;
+
+	if (!ustring_per_cpu)
+		return NULL;
+
+	ubuf = this_cpu_ptr(ustring_per_cpu);
+	kstr = ubuf->buffer;
+
+	if (likely((unsigned long)str >= TASK_SIZE)) {
+		/* For safety, do not trust the string pointer */
+		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+			return NULL;
+	} else {
+		/* user space address? */
+		ustr = str;
+		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+			return NULL;
+	}
+	return kstr;
+}
+
 /* Filter predicate for fixed sized arrays of characters */
 static int filter_pred_string(struct filter_pred *pred, void *event)
 {
 	char *addr = (char *)(event + pred->offset);
 	int cmp, match;
 
+	addr = test_string(addr);
+	if (!addr)
+		return 0;
+
 	cmp = pred->regex.match(addr, &pred->regex, pred->regex.field_len);
 
 	match = cmp ^ pred->not;
@@ -671,10 +710,16 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 static int filter_pred_pchar(struct filter_pred *pred, void *event)
 {
 	char **addr = (char **)(event + pred->offset);
+	char *str;
 	int cmp, match;
-	int len = strlen(*addr) + 1;	/* including tailing '\0' */
+	int len;
+
+	str = test_string(*addr);
+	if (!str)
+		return 0;
 
-	cmp = pred->regex.match(*addr, &pred->regex, len);
+	len = strlen(str) + 1;	/* including tailing '\0' */
+	cmp = pred->regex.match(str, &pred->regex, len);
 
 	match = cmp ^ pred->not;
 
@@ -784,6 +829,10 @@ static int filter_pred_none(struct filter_pred *pred, void *event)
 
 static int regex_match_full(char *str, struct regex *r, int len)
 {
+	str = test_string(str);
+	if (!str)
+		return 0;
+
 	/* len of zero means str is dynamic and ends with '\0' */
 	if (!len)
 		return strcmp(str, r->pattern) == 0;
@@ -793,6 +842,10 @@ static int regex_match_full(char *str, struct regex *r, int len)
 
 static int regex_match_front(char *str, struct regex *r, int len)
 {
+	str = test_string(str);
+	if (!str)
+		return 0;
+
 	if (len && len < r->len)
 		return 0;
 
@@ -801,6 +854,10 @@ static int regex_match_front(char *str, struct regex *r, int len)
 
 static int regex_match_middle(char *str, struct regex *r, int len)
 {
+	str = test_string(str);
+	if (!str)
+		return 0;
+
 	if (!len)
 		return strstr(str, r->pattern) != NULL;
 
@@ -811,6 +868,10 @@ static int regex_match_end(char *str, struct regex *r, int len)
 {
 	int strlen = len - 1;
 
+	str = test_string(str);
+	if (!str)
+		return 0;
+
 	if (strlen >= r->len &&
 	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
 		return 1;
@@ -819,6 +880,10 @@ static int regex_match_end(char *str, struct regex *r, int len)
 
 static int regex_match_glob(char *str, struct regex *r, int len __maybe_unused)
 {
+	str = test_string(str);
+	if (!str)
+		return 0;
+
 	if (glob_match(r->pattern, str))
 		return 1;
 	return 0;
@@ -1335,6 +1400,13 @@ static int parse_pred(const char *str, void *data,
 		strncpy(pred->regex.pattern, str + s, len);
 		pred->regex.pattern[len] = 0;
 
+		if (!ustring_per_cpu) {
+			/* Once allocated, keep it around for good */
+			ustring_per_cpu = alloc_percpu(struct ustring_buffer);
+			if (!ustring_per_cpu)
+				goto err_mem;
+		}
+
 		filter_build_regex(pred);
 
 		if (field->filter_type == FILTER_COMM) {
@@ -1415,6 +1487,9 @@ static int parse_pred(const char *str, void *data,
 err_free:
 	kfree(pred);
 	return -EINVAL;
+err_mem:
+	kfree(pred);
+	return -ENOMEM;
 }
 
 enum {
-- 
2.33.0




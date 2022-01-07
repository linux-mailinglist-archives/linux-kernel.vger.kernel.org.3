Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4E84871E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 05:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbiAGEuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 23:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346115AbiAGEuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 23:50:11 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CECC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 20:50:11 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 200so4483761pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 20:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KYTEnCm6vjR29UvMkQ2hmvarpkcMAexSrfASlmBt0go=;
        b=fN62roF2eakvVGrEpE7LJ0/FwaGrYDkPdHHW386RRMsN4RMXv/oUGs74+KPpc1wSns
         mIH2Qjog3/h25kaPUoWAnqHi1HjSEfS2w27D7oSUY6fTTHJZqsLVURc8Zd0CeiHSZnmg
         aAQBcEwJoDrc9MMGu9m6/mcksnuaZroUGgDcuQjdc7th0RNulrpvjHqgyuQdRwF5yNlk
         UlUeHOBs2Vd+6/Yz5KRji3fiFTWWMxZfV7sotUBX2yPNqQwUDwgabDLk881/5vN4fY1b
         u5rJaUmpuJknj+z2vmyBbEp5YtpcRQ0MDD3gjpeqRqkyE8MBuRGms5kc2KIRasgeReur
         8rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KYTEnCm6vjR29UvMkQ2hmvarpkcMAexSrfASlmBt0go=;
        b=6r/FpDDV1MASTn7Kbb5bMrJXlK4XTjIIo5LVq3FxAYQsMu5WbZyqzotdwuBQoifGDb
         W5IcQU6X3xKsHo6hAU2KsiylhzopeHJVLSeuQpdXt4OqyA/WtzrbNMiifAL6bkY1/8fj
         1aFlF8Xfdd3lagiG4i+qy9pCUCkkW8UnlRBb+bWcSIX8glHBBUxepX5PGZ4CXJjUEtzR
         mMMRKO7FnmaL1veBIBWbHhpdnGT+AmKVWhAOvTXxU/IKUV9KwB0MnJlK4emCZr6mKavU
         xw7yMAjnCSnmLlxMOGoUPRgHal1eEYznDrOQHViZ9faoFhS2hvT+4vAfiMSazIVZiJht
         Cc9Q==
X-Gm-Message-State: AOAM5303tCTyAY15EX1JcCVqK2XFU+nGGvTB86Tqpi10vtBF8csmpp8R
        w3exZeZaOyGJFV0I+AK3z5rRkpyjhA==
X-Google-Smtp-Source: ABdhPJx6aN1DuzUxFuThfk7K4UWCSI0QTBXl1J0BpF57AwS7y/+KDIEVDljDtdwfYdbl0gIVcdo9tg==
X-Received: by 2002:a63:1346:: with SMTP id 6mr54425264pgt.147.1641531010502;
        Thu, 06 Jan 2022 20:50:10 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id lp6sm8456115pjb.55.2022.01.06.20.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 20:50:10 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 3/3] tracing/filter: make filter_pred_pchar() survive the access to user space
Date:   Fri,  7 Jan 2022 12:49:51 +0800
Message-Id: <20220107044951.22080-4-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107044951.22080-1-kernelfans@gmail.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When
  echo "filename ~ \"cpu\"" > events/syscalls/sys_enter_openat/filter
  echo 1 > events/syscalls/sys_enter_at/enable

Then the following #PF is observed:
    kvm-03-guest16 login: [72198.026181] BUG: unable to handle page fault for address: 00007fffaae8ef60
    [72198.027625] #PF: supervisor read access in kernel mode
    [72198.028627] #PF: error_code(0x0001) - permissions violation
    [72198.029708] PGD 80000001008b7067 P4D 80000001008b7067 PUD 2393f1067 PMD 2393ec067 PTE 8000000108f47867
    [72198.031588] Oops: 0001 [#1] PREEMPT SMP PTI
    [72198.032410] CPU: 1 PID: 1 Comm: systemd Kdump: loaded Not tainted 5.14.0-32.el9.x86_64 #1
    [72198.034021] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
    [72198.035190] RIP: 0010:strlen+0x0/0x20
    [72198.035914] Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 38 00 75 f7 48 29 f8 c3 31
    [72198.039576] RSP: 0018:ffffb5b900013e48 EFLAGS: 00010246
    [72198.040593] RAX: 0000000000000018 RBX: ffff8fc1c49ede00 RCX: 0000000000000000
    [72198.041991] RDX: 0000000000000020 RSI: ffff8fc1c02d601c RDI: 00007fffaae8ef60
    [72198.043419] RBP: 00007fffaae8ef60 R08: 0005034f4ddb8ea4 R09: 0000000000000000
    [72198.044800] R10: ffff8fc1c02d601c R11: 0000000000000000 R12: ffff8fc1c8a6e380
    [72198.046185] R13: 0000000000000000 R14: ffff8fc1c02d6010 R15: ffff8fc1c00453c0
    [72198.047610] FS:  00007fa86123db40(0000) GS:ffff8fc2ffd00000(0000) knlGS:0000000000000000
    [72198.049206] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [72198.050332] CR2: 00007fffaae8ef60 CR3: 0000000102880001 CR4: 00000000007706e0
    [72198.051760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
    [72198.053168] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
    [72198.054550] PKRU: 55555554
    [72198.055114] Call Trace:
    [72198.055616]  filter_pred_pchar+0x18/0x40
    [72198.056421]  filter_match_preds+0x31/0x70
    [72198.057210]  ftrace_syscall_enter+0x27a/0x2c0
    [72198.058088]  syscall_trace_enter.constprop.0+0x1aa/0x1d0
    [72198.059163]  do_syscall_64+0x16/0x90
    [72198.059898]  entry_SYSCALL_64_after_hwframe+0x44/0xae
    [72198.060904] RIP: 0033:0x7fa861d88664

Apparently, it is caused by supervisor read access in kernel mode.

To tackle this issue caused by event_class_syscall_enter, using the pair
of user_access_{begin/end}() may be an efficient method, but it means to
stir up _ASM_EXTABLE. Hence this patch picks up the road of
copy_from_user(). This is achieved by introducing a field 'uaccess' in
ftrace_event_field, and run regex.match on the copied buffer.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
To: linux-kernel@vger.kernel.org
---
 kernel/trace/trace.h               |  1 +
 kernel/trace/trace_events_filter.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 38715aa6cfdf..81a263a060e8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1281,6 +1281,7 @@ struct ftrace_event_field {
 	int			offset;
 	int			size;
 	int			is_signed;
+	int			uaccess;
 };
 
 struct prog_entry;
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2a05315127f9..9af268b98c61 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/perf_event.h>
 #include <linux/slab.h>
+#include <linux/syscalls.h>
 
 #include "trace.h"
 #include "trace_output.h"
@@ -672,12 +673,30 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 static int filter_pred_pchar(struct filter_pred *pred, void *event)
 {
 	char *addr = (char *)(event + pred->offset);
+	char *udata, *cmp_buff;
 	int cmp, match;
-	int len = strlen(addr) + 1;	/* including tailing '\0' */
+	int len, poffset;
+
+	if (unlikely(pred->field->uaccess)) {
+		udata = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!udata)
+			return -ENOMEM;
+		poffset = (ulong)addr & (PAGE_SIZE - 1);
+		cmp_buff = udata + poffset;
+		if (copy_from_user(cmp_buff, addr, PAGE_SIZE - poffset)) {
+			kfree(udata);
+			return -EFAULT;
+		}
+	} else {
+		cmp_buff = addr;
+	}
+	len = strlen(cmp_buff) + 1;	/* including tailing '\0' */
 
-	cmp = pred->regex.match(addr, &pred->regex, len);
+	cmp = pred->regex.match(cmp_buff, &pred->regex, len);
 
 	match = cmp ^ pred->not;
+	if (unlikely(pred->field->uaccess))
+		kfree(udata);
 
 	return match;
 }
@@ -1220,6 +1239,7 @@ static int parse_pred(const char *str, struct trace_event_call *data,
 		return -ENOMEM;
 
 	pred->field = field;
+	field->uaccess = 0;
 	pred->offset = field->offset;
 	pred->op = op;
 
@@ -1321,8 +1341,11 @@ static int parse_pred(const char *str, struct trace_event_call *data,
 
 		} else if (field->filter_type == FILTER_DYN_STRING)
 			pred->fn = filter_pred_strloc;
-		else
+		else {
 			pred->fn = filter_pred_pchar;
+			if (data->class == &event_class_syscall_enter)
+				pred->field->uaccess = 1;
+		}
 		/* go past the last quote */
 		i++;
 
-- 
2.31.1


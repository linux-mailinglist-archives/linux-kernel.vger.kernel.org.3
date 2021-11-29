Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30004621FF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbhK2UUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhK2URW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:22 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7CFC08ED53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y8so12665028plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kGlHZ5cGJWVppzLgI9slJfj6H2y630BV3sf2C/YjZM=;
        b=XCgg2M8Kyy8Bs1rLniC6fUWRycczsAHorHBPF0fKEQ5I28EoY6fJ+8Pgpi1ro+i7Dj
         sdNAI/YsAAkfNsCZovaLRVoYbKNzCdf7OrVPjlb7to7VaKq6Vs/fY8CjfKgto2PZk6J1
         FarpJXI+APnGRC8u/gaaEhOuihdoY0wAEi4yg+9oU3M4gbJeRFgTHCt4MubFQ4hi+bMa
         fUWpJ4WqbOTkd6+KaCCxl5hLuN/3FWe5uHtI/vc4vCJA1bUL6argKzQxsbIYvFZE2QUe
         nDJwneqj/THuuV3pKNPwknVVdFjUYp6EsL7Oz7oRKwMhcNy0qg5/kZoBS64kG4PugmI9
         XdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kGlHZ5cGJWVppzLgI9slJfj6H2y630BV3sf2C/YjZM=;
        b=NsG2k4mtWyqhpssqR2UYT5P0z6GuDHJHhoXhGLRGgrlxmKJbFSkgOm6CHTyw7aPdRN
         YVC9oa/Ow+VKEA/tOvEx5hsAkajBGfEFSdb08blqyo4/5oT5ArMeAaBswIt3vXhTPepM
         iHAD6S6bkdMuuWlUrI/qs1QpvUZjUcTOkpmPSMfEopS+jiBhC7ALl0JNKjx0EtowDBVQ
         vjWfxC4BSm4XUkdpIHZsgpPINw3/IWU0JGtIKKv8o0uBU/tjiyR1ywfWvhIleXp8s+Ha
         tTCNa8ctXVnX3F/Gu9TZA5iYk3JeTKO0d4i6U0FqPnPoXp3u9FKfroZ5wW1C5RtODr4K
         /JLQ==
X-Gm-Message-State: AOAM533TMF94E4dpnmv7ivknGjpFUftLJLNYtI1WyNRhMuTgXGMcX10P
        wePzW9mTnP+IYlrpb6DnYfc=
X-Google-Smtp-Source: ABdhPJww9zBCLjLYd6rxMdab0htaPK7I7zfXznU3wIXMsqom8DMSU6F/sPLaASer+T+zUFAqQ4+img==
X-Received: by 2002:a17:902:ee95:b0:141:f28f:7296 with SMTP id a21-20020a170902ee9500b00141f28f7296mr62516337pld.50.1638204627807;
        Mon, 29 Nov 2021 08:50:27 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id mr2sm14044211pjb.25.2021.11.29.08.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:50:27 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v6 5/5] trace/objtrace: Add documentation for objtrace
Date:   Tue, 30 Nov 2021 00:49:51 +0800
Message-Id: <20211129164951.220511-6-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129164951.220511-1-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation explaining how to use objtrace trigger to get the value
of the object.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 Documentation/trace/events.rst | 114 +++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 8ddb9b09451c..a6d8313ba24e 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -527,6 +527,120 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
+- objtrace
+
+  This command provides a way to get the value of any object, The object
+  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
+  static event(tracepoint).
+
+  Usage:
+  When using the kprobe event, only need to set the objtrace(a new trigger),
+  we can get the value of the object. The object is from the setting of the
+  kprobe event.
+
+  For example:
+  For the function bio_add_page():
+
+  int bio_add_page(struct bio *bio, struct page *page,
+	unsigned int len, unsigned int offset)
+
+  Firstly, we can set the base of the object, thus the first string "arg1"
+  stands for the value of the first parameter of this function bio_add_gage(),
+
+  # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+
+  Secondly, we can get the value dynamically base the above object.
+
+  find the offset of the bi_size in struct bio:
+  $ gdb vmlinux
+  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+  $1 = (unsigned int *) 0x28
+
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
+	p_bio_add_page_0/trigger
+
+  The best way to use this is that we can set the entrance event and exit
+  event, for example, the following example is to set the read_papes as
+  the entrance event, and set the __blk_account_io_start as the exit event.
+
+  # cd /sys/kernel/debug/tracing/
+  # echo 0 > ./tracing_on
+  # echo 'p read_pages' >> ./kprobe_events
+  # echo 'p __blk_account_io_start' >> ./kprobe_events
+  # echo 'traceon if comm == "cat"' > ./events/kprobes/p_read_pages_0/trigger
+  # echo 'traceoff if comm == "cat"' > ./events/kprobes/p___blk_account_io_start_0/trigger
+  # echo 'p bio_add_page arg1=$arg1' >> ./kprobe_events
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+
+  # du -sh /test.txt
+  12.0K   /test.txt
+
+  # cat  /test.txt > /dev/null
+  # cat ./trace
+
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 50/50   #P:1
+  #
+  #                                _-----=> irqs-off
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+             cat-95      [000] .....     1.412065: _raw_spin_unlock_irqrestore <-event_triggers_call object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x0
+             cat-95      [000] .....     1.412066: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412066: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: __bio_add_page <-bio_add_page object:0xffff888108af6328 value:0x1000
+             cat-95      [000] .....     1.412067: rcu_read_unlock_strict <-xa_load object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: bio_add_page <-ext4_mpage_readpages object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412067: __bio_try_merge_page <-bio_add_page object:0xffff888108af6328 value:0x2000
+             cat-95      [000] .....     1.412068: submit_bio <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_noacct <-ext4_mpage_readpages object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __submit_bio <-submit_bio_noacct object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: blk_try_enter_queue <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_read_unlock_strict <-blk_try_enter_queue object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: submit_bio_checks <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: __cond_resched <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: rcu_all_qs <-__cond_resched object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412068: should_fail_bio <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: create_task_io_context <-submit_bio_checks object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: kmem_cache_alloc_node <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: should_failslab <-kmem_cache_alloc_node object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: _raw_spin_lock <-create_task_io_context object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_mq_submit_bio <-__submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: __blk_queue_split <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: bvec_split_segs <-__blk_queue_split object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412069: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_bio_merge <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: _raw_spin_lock <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: blk_mq_sched_try_merge <-dd_bio_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rqhash_find <-elv_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: dd_request_merge <-blk_mq_sched_try_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: elv_rb_find <-dd_request_merge object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412070: __blk_mq_alloc_request <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_limit_depth <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_get_tag <-__blk_mq_alloc_request object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: __blk_mq_get_tag <-blk_mq_get_tag object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: blk_mq_rq_ctx_init.isra.0 <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: ktime_get <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: dd_prepare_request <-blk_mq_rq_ctx_init.isra.0 object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: __blk_account_io_start <-blk_mq_submit_bio object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: kprobe_ftrace_handler <-ftrace_ops_list_func object:0xffff888108af6328 value:0x3000
+             cat-95      [000] .....     1.412071: get_kprobe <-kprobe_ftrace_handler object:0xffff888108af6328 value:0x3000
+
 7. In-kernel trace event API
 ============================
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA904A92DE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 04:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356891AbiBDD5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 22:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356883AbiBDD5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:57:15 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F37C06173E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:57:15 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id x11so4072105plg.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 19:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=Und4MgI6NSGJyfDIEDMUVl6dQVuLuW8aIUfA6RNo/dnXNEI1klN/+DJFL57J/qJJE/
         09cG8yNUxPkfTKJtNYNkNoc6RBf9vlzHEYLIVIR6utl8z57x430573w8jsV7k8xW8Gkw
         HlsXHrskEdSqrzPp1a+uRx9gaG/XuYfZOSTIJe/lxubomLmzAt3537oxhPCpKWKcuUL+
         /OHZJ9xnnw9YX8Qsj5Hhm9apzdW64H1/vbxLxHWHLjMsM/WdrG1LOZ/V0anF9neUg7vn
         e+4ZksPLG6jOt3I+iZDrECRLfWTdGEsQMA0EtP38bSE4ZPHdb+SRSoXjJdKQPd1zU1vi
         Er6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=upcE/WAtdJr9Cpthp+gQj4JkXsR8Z1njilcf3+4nHriCyVgdacROGUU1kCKcxyLd9H
         lJ2KHqMNVNtPo3Bb16KAQb+1UtWmj4qTV45w6OzaNjJAciYYgXT9m5gDJnCFKCNiL0wr
         k/scwZIlZvhCXTI4gYEqHoFojk+DrrPCwCeyl6r9Dg9L7ecenoVkWRy6AoafFW/b70Dr
         sv3kES+5WnxdNuSKC4hnX/G6k9I1a7wGjVyqxsaxCCbBo9PbDZbSkUWwxvZL3WjYYON1
         q7cUiNNiDJNOCPNrE6MiBwliKNE+z4Wk1+1l7DH9NyfSwarWrOpdze2AaFVJ5I2sk2Ni
         1iKw==
X-Gm-Message-State: AOAM532TyBGolZwFw6cF+JNG2Lu2iyL0no8khUzKAxBXon8P6vVZv4Bz
        T/3MzTl3zn4kJxvqEkXa5kzviNDHFCo=
X-Google-Smtp-Source: ABdhPJwa7oYr69h3LKDsg9zzXwc50Ddh8Oo4oBrL/VxVbo0wLHkpzn+jN8ZsZw5g+IF+FXzIGzrmxA==
X-Received: by 2002:a17:90a:d343:: with SMTP id i3mr1048267pjx.104.1643947035352;
        Thu, 03 Feb 2022 19:57:15 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id 204sm506229pfu.91.2022.02.03.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:57:14 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v9 4/4] trace/objtrace: Add documentation for objtrace
Date:   Fri,  4 Feb 2022 11:56:44 +0800
Message-Id: <20220204035644.734878-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204035644.734878-1-xiehuan09@gmail.com>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation explaining how to use objtrace trigger to get the value
of the object.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 Documentation/trace/events.rst | 83 ++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..0dc475160133 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -546,6 +546,89 @@ The following commands are supported:
 
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
+  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+
+  Secondly, we can get the value dynamically based on above object.
+
+  find the offset of the bi_size in struct bio:
+  $ gdb vmlinux
+  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+  $1 = (unsigned int *) 0x28
+
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
+	p_bio_add_page_0/trigger
+
+  # cd /sys/kernel/debug/tracing/
+  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+
+  # du -sh /test.txt
+  12.0K   /test.txt
+
+  # cat  /test.txt > /dev/null
+  # cat ./trace
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 128/128   #P:4
+  #
+  #                                _-----=> irqs-off/BH-disabled
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
+               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
+               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
+            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+             ...
+
 7. In-kernel trace event API
 ============================
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE855E7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiF1O4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiF1O4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 10:56:42 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE72B3335E;
        Tue, 28 Jun 2022 07:56:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so12944014pjb.2;
        Tue, 28 Jun 2022 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ejGWeAFgEA+ok2503tmhm0ExoFnyPJd66F9hUUqWubQ=;
        b=ecpN/UeOfXt6qtVag5bsnOZPgLtT16e2gxYvHZEbBfYxvv3J/6C2Y1Afy24+MpnKWV
         m/TZABVYtefFNlCx7FrI6gGuO8jkbUNfsh5A3hguvfALuTNBMT8kZJut0GHQ9cnVcm4P
         Mba0/8e0iM+YkbkKU0/TQsIM4WXGYkh3LzyhK12upVy1p4e2N6eg6SKPGr2F5j0Jr6hp
         +3fPNZPVh733WfRspZgNh2mzYJOppO4QBoObSFx81T/jrnw6CTJT7HExWg5c596VOBXM
         xwp3pO5BxxHFJ3gTMmTBvtPlj618ktjJ5Z4LLCpERBr0EfkYrheeD7FlX2DYCVmhHBb/
         mjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ejGWeAFgEA+ok2503tmhm0ExoFnyPJd66F9hUUqWubQ=;
        b=3LPFas6WfpiL5WQpWcKUeJ4We2cBqNHUd3DRc91yap8PVYZFS8227OtXHEI6l3EWU5
         O+fvRoZ+R+Cn7uf5GmFk+Jtq2gofRYRD+DDecrPBue7codgh7Y7XQvv7sk9qyql3vUxV
         u6EtNCipMiVHsSmgpt9HB8gwIsivSE5q7c3Gua/6H/m9vTzciBET5izIVkM/DVme5SfV
         Cbzv6EgWY/8t/i20Ikljv7PDitgkCoKZ1SS3/+ySHNfFMYjNRTg6cYwtia+yljzjkSkY
         iuVfef8gQLx1xkN2TvAugCIpm7QfOPqNhde26zhVbY1pp0uPAo7XaAtzLo0S90sJITqu
         x4/g==
X-Gm-Message-State: AJIora+Uobdyh6c3upJn2GjlI6x2Ce2JMZ4VoiGkwyllh4VubdbaAz7G
        A4Z9o1r9h6mJsd2yrZ8VhCY=
X-Google-Smtp-Source: AGRyM1ttV9hmcNYDLwJtS/XW4naMtVdkf4VOqqWLApAFyhRBjR2/zOEPg7hTh+0tizhf3ZhJ/8lAGA==
X-Received: by 2002:a17:902:cf4a:b0:169:a894:3465 with SMTP id e10-20020a170902cf4a00b00169a8943465mr4077498plg.56.1656428201400;
        Tue, 28 Jun 2022 07:56:41 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b0016909678e2csm9502549ple.292.2022.06.28.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 07:56:41 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Subject: [PATCH v14 4/4] Documentation: trace/objtrace: Add documentation for objtrace
Date:   Tue, 28 Jun 2022 22:55:52 +0800
Message-Id: <20220628145552.349839-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628145552.349839-1-xiehuan09@gmail.com>
References: <20220628145552.349839-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation explaining how to use objtrace trigger to get the value
of the object.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changelog:
v14:
- make documentation more readable and fix literal code block by Bagas Sanjaya

 Documentation/trace/events.rst | 87 ++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..c15f1d25d4a0 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -546,6 +546,93 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
+- objtrace
+
+  This command provides a way to get the value of any object, The object
+  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
+  static event (tracepoint).
+
+  Usage:
+  When using the kprobe event, by only need to set the objtrace (a new
+  trigger), we can get the value of object that is set by kprobe event.
+
+  For example, for the function bio_add_page():
+
+  .. code-block:: c
+
+     int bio_add_page(struct bio *bio, struct page *page,
+	              unsigned int len, unsigned int offset)
+
+  Firstly, we can set the base of the object as first parameter (arg1) to
+  to the function:
+
+  .. code-block::
+
+     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+
+  Secondly, we can get the value dynamically based on the object:
+
+  .. code-block::
+
+     find the offset of the bi_size in struct bio:
+     $ gdb vmlinux
+     (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
+     $1 = (unsigned int *) 0x28
+
+     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
+       p_bio_add_page_0/trigger
+
+     # cd /sys/kernel/debug/tracing/
+     # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
+     # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
+
+     # du -sh /test.txt
+     12.0K   /test.txt
+
+     # cat  /test.txt > /dev/null
+     # cat ./trace
+     # tracer: nop
+     #
+     # entries-in-buffer/entries-written: 128/128   #P:4
+     #
+     #                                _-----=> irqs-off/BH-disabled
+     #                               / _----=> need-resched
+     #                              | / _---=> hardirq/softirq
+     #                              || / _--=> preempt-depth
+     #                              ||| / _-=> migrate-disable
+     #                              |||| /     delay
+     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+     #              | |         |   |||||     |         |
+                  cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+                  cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
+                  cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
+                  cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
+                  cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+                  cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
+               <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
+               <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
+                ...
+
 7. In-kernel trace event API
 ============================
 
-- 
2.25.1


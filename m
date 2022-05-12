Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7E7525321
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356796AbiELRBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356768AbiELRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:00:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA003B548
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:00:48 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id i1so5479404plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=f5IqLmz12k/A5y/HILvzizzg5UZ4Xo+oPXyab7LROvRiERsd1dO3gaJTB4blXyX16d
         a4sANvf65uub2a+/f5LHxWZ50u60S5qRyYpGcrrKicFwzUdUOysUVYkg93TA3ChY7p8C
         3GFuNLm3fbXb2H9eFMG5JXK8hkzGeJRDVJ6fuUxviBCsAe4Y2FVxpf1uDWgFt1tHtoyO
         6FoIVtDufRl9BdWzCWP4yL6KLSgLPORwixoU4fe1jDTH61mWIwjJXWWDDxnG2ZsDXmVZ
         K/RfcJ3k+HMX3w57SBA0cRgDQbOPwgDjCtBE2rborWOqPL66soELs1wO0gAtXRphJMx6
         6oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=cTpmKIhqfyx+aypYK4bh4F0n0qkiGzKChZCyaEe2mjtJWjcaYRZR9XeA8qCoOStF5R
         7W8MfVjF0jDijlRenwBLmOCqTd87xtaZd6LWOupAawNimgjSWGoptc3h9AOLLV9Lyajp
         ZRMfQMw/9MNQAEZ62e0wjdQS0xpj7cvUBtdkYn0faA8ENi/TeKN6IaWrgpVk2TNrsHc4
         rPPoKOZZjhVmHBaBuSVdv5GrbXHLDNpJFx8ZsR3xbGwpKgt5JeQhefPSi0eJaE4hcbkJ
         TZGprxCsu3fBlTZQX6tt3mcwH43fyAWYBReNn2R4N5gTAj+l7iPX2cX1chce+Kr7t5FY
         E0pw==
X-Gm-Message-State: AOAM533wNFAOQJ8MV4JK0QehJnRPmLeyNDqlo34IrbB5Qr3PelZ/5I+6
        K6rKFzgN9fIrDbn+z92Eb0CEHLyWxgs=
X-Google-Smtp-Source: ABdhPJzKKpeK66hB/TVR0aX0f41KqAxlOXi/iGKlAsl3QNixXAQ1XXdLKowdHap30CXSS2sIwugFIQ==
X-Received: by 2002:a17:90a:c797:b0:1d9:2764:a83b with SMTP id gn23-20020a17090ac79700b001d92764a83bmr11609475pjb.5.1652374847650;
        Thu, 12 May 2022 10:00:47 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id u10-20020a63234a000000b003c14af50605sm2119374pgm.29.2022.05.12.10.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:00:47 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v10 4/4] trace/objtrace: Add documentation for objtrace
Date:   Fri, 13 May 2022 01:00:08 +0800
Message-Id: <20220512170008.1301613-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220512170008.1301613-1-xiehuan09@gmail.com>
References: <20220512170008.1301613-1-xiehuan09@gmail.com>
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


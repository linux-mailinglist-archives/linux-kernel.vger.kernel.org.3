Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93994599380
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344394AbiHSD2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245469AbiHSD1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:27:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F704DF66C;
        Thu, 18 Aug 2022 20:27:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x15so2359011pfp.4;
        Thu, 18 Aug 2022 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=abditIbeCMAlg4Lgjtnw6BuqzTgkBra7/BZ++TtmQH0=;
        b=FoR4esG3naAZvD5ET0fIP7JoscoSZEe2D9CdGwLFqnn8sACiGaIL3eRxZeHBe2dnim
         L9yy8LF0Ar1gbh3psPQ3bvF5v2pgI/8n0Mkq30m+F4/3GdBABLYzz1RweFCsYqrE+ofp
         jBg+Xe7diJQgt9hcOQ5vg3YlVF6k5Cf56QDUfoBMTj/VUvegBcmCmutGH34jmPw+dAca
         bJR4d1CewkruvRewgn7hNVX3P+Z2BYie936cMuqo1QfoaexoK5eSSu/y/eWSscucFvv7
         As4fgf7aIz5gI3o941VTB7q/jCRfjQTuL02bviT/VKIvwLzj3VtVHPDn2QBJxS0ZBYF1
         HDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=abditIbeCMAlg4Lgjtnw6BuqzTgkBra7/BZ++TtmQH0=;
        b=lGsUGnc2QBModhldUpxul4uA8uEUQliRhFLLkcxp8Dd4Ey6fXJyVFRZY9pY1qwKUQ/
         A8lM8CEXE2E8KLaKnvqLgepKaMqI5HiI8iuEqbhUxIM6YN9II9aHTLUQe/w6/iI/cpkj
         03GGbfVTTnZCpPK9DlKvX4PCFAW7cemjIgeQl3rh21XOVc8u3a9ZqzMtaL+AyP+yq4qv
         +mjEptbXf6Re5FRBYtmBrv+l9SEPP9oDrQwaTnHWKF47P0qK8sSYIemdZpDddP/P2VSX
         5r5RzzCma+dRcpi6oQxBpMSdosVzlKiWJvhyCSIwa1/5OAhLSHKUApGHhaqVZ7y1k/+c
         GdJA==
X-Gm-Message-State: ACgBeo3I7W/DD/pjSldUllB5j98EYcMWi8Z/2ivk5rnbw23+XC6t+/Mt
        TTk/uOCBF6LhbeYJTKCbn4A=
X-Google-Smtp-Source: AA6agR4ydE9Jdft06fHaVL5VcjIHMZdpBuzj28WisXtAQ2xWPuaoXKSadlaBrCf3Ecr9vuI/Xei1VQ==
X-Received: by 2002:a63:d847:0:b0:41a:dbc4:ef9e with SMTP id k7-20020a63d847000000b0041adbc4ef9emr4726043pgj.379.1660879669947;
        Thu, 18 Aug 2022 20:27:49 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016befc83c6bsm2101032plb.165.2022.08.18.20.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 20:27:49 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Subject: [PATCH v15 4/4] Documentation: trace/objtrace: Add documentation for objtrace
Date:   Fri, 19 Aug 2022 11:27:06 +0800
Message-Id: <20220819032706.695212-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819032706.695212-1-xiehuan09@gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
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

Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changelog:
V15:
- Add syntax suggested by Joel for usage of objtrace

 Documentation/trace/events.rst | 90 ++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index c47f381d0c00..1209f3cd8f1d 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -546,6 +546,96 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
+- objtrace
+
+  This command provides a way to get the value of any object, The object
+  can be obtained from the dynamic event (kprobe_event/uprobe_event) or the
+  static event (tracepoint).
+
+  Syntax:
+        objtrace:add:obj[,offset][:type][:count][if <filter>]
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


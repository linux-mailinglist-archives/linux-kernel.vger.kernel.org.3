Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC753BCB9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiFBQqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 12:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiFBQqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 12:46:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384502B1953
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 09:45:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so6776414pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=dWoQ4xXtrk4zLRUdUjqH6XadKcCTCK63ubYy64J66VPqatn9slPSYCcNgf7DnuSypP
         VGvUkfKKX2GR7LQ8sZqoTR2ZDxof7kVV7l42svKhr8S91gdhVLI2wu4eyaDc+pzajiAV
         8K/1DZBIPz5j7J+eCIae6YU5GsrQWuGR08OlWRnVY1Z04WFjFz+1l6Ka1B7NCVN6NFVY
         3WM5z4bsHMNIgg/WuvBv6/iwdiE9V2pP2vymNVQ4i6A36iTCOSIn4GirtTzukdKTWtY6
         u0Wn4EBiBNArJnsZpN6+0SgfvwzECN5WfIwZ2U+1+HOWwYwUYpiU0dDnEt9+Xb0t1rTM
         DsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DekJ8UcrLNS24H0kwzTpTKU7qq2O3Iea6VLoLOi4nfQ=;
        b=1iE8mX+QHGqdgt1yNRevB80MLDLFGMEDPV6dv+YfEPPa8Im24SCajHKtRIQzRPwOsl
         qsxZGFpgycBtjVTVusEX/Fxye5Hm9jXisvibXl68FFiHHDr0zCpNBdB3i2RlOKeNFZa2
         o8hgV+XlvK6eVIE3Rr2xxlAcJuBjdJieRkhDE/beHXuYo4JPpqmfZ1fMXDo2yiCILy3m
         mD+HZBe0oGMF3nkZW6JTXq50FNrjSQ+T6C2vmS6XKZWBkImZ8hOhKTEW4VyejTqezLGJ
         7cA3/OwupVhF7Hzq5ScGOpV794H4ces5oO0sgx5f3Y51i3+myQkv0gnRwY0/a0fbHVX3
         j8ew==
X-Gm-Message-State: AOAM531lQD/HoNcV2/wwikV19c5u61pWRZT9y9bAjp7kHt1MGUKhZQLP
        Y8pfyjuKe6lgqSc7EeO1f8c=
X-Google-Smtp-Source: ABdhPJwGvE10kr1E7Sn91N7cF5w070mejvdYb4ZbjhFE8UuvNodabtqRacGAeA7VfxMqHBJBD6j2Bg==
X-Received: by 2002:a17:902:6505:b0:163:b040:829b with SMTP id b5-20020a170902650500b00163b040829bmr5672167plk.173.1654188357189;
        Thu, 02 Jun 2022 09:45:57 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id b127-20020a62cf85000000b0051b9c02e4a3sm3821888pfg.178.2022.06.02.09.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 09:45:56 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v11 4/4] trace/objtrace: Add documentation for objtrace
Date:   Fri,  3 Jun 2022 00:45:18 +0800
Message-Id: <20220602164518.286295-5-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220602164518.286295-1-xiehuan09@gmail.com>
References: <20220602164518.286295-1-xiehuan09@gmail.com>
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


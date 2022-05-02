Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DFC5176B6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbiEBSpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbiEBSol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:44:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD24CF71
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:41:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 15so12302721pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ky0MEvXpm39NcrzucQHp70smIiw6DLihko8P5JGPfNM=;
        b=QIku27bWUkSEGWT8oQUpsOXy8xsPr6pyS06whMjEWtcMB8VDjFspIws8/dsTbBe9Fk
         G4L4x07Pl/lLjv3NzlSGWFTzGP2Um/yYZlOo7H0kmiDWMXTjiI2/INBhFv8tKONbUmb1
         SFKvMxDtHhJNVvwGIY16eOzX2zmJ/XE/9EaySUCyi+Y+QdgnvZLKlTCAP/DxsiDRkabr
         lq+ik7pzaD+lXYv+10xFfZM2qAcEAvIuEP82lumDF+nHP6lpOrI5pIYlwzc41nOaALQq
         K+d9pDlKgdjb1Qnz25kLBimzTFyUFmYadu/6B6MurHnFcQo9YDP9ro6+pu6zML4imjLT
         zZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ky0MEvXpm39NcrzucQHp70smIiw6DLihko8P5JGPfNM=;
        b=0aRr9699QV+Rpnu8KPdCYaSZPZY/uJRUnd1QbaTR4OfIUrPWO4E44bAhYzZGg+cOyY
         iKj0/AMLpWLjtOrqKoaiEhQT+bcaGEJ2y3KF1ERvov4Zp8ghPbykhM+fewBPnlth6pQG
         t03RezbfC8xeU35Dmns89HHrrNn3jAgAlki/vH580C6sH/Dq3oUQo3RnHVFNs//Nh3EH
         fG209UaJYnUmtgkktnYqx+9oiGcqDrIDv/1hUmrxgv9XZDPVhefhmKm4WIt2FViz5VUn
         1kAcVLFmSJNlfnjtyvM42ooZu84JdN8MByKrhxlBpKL8Xt5ajUfrnVGMhhnTqsB+MvJc
         bYWg==
X-Gm-Message-State: AOAM532ul91MMWF7X2fdFZMDIJM5BwEqvZecrvi0lANcKFJmTxw2MzE/
        /guxkGkdqr3jarxOTE3XXQax9YEo1iE=
X-Google-Smtp-Source: ABdhPJxTllHfJoTgHGa5K6JpFb9oLng7vH1Wl64mlwuWTeTX1rzSLQpClBfq28heG7S8HoZAwDlNEQ==
X-Received: by 2002:a65:6149:0:b0:3a9:7e8f:6429 with SMTP id o9-20020a656149000000b003a97e8f6429mr10757017pgv.613.1651516872044;
        Mon, 02 May 2022 11:41:12 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:8d9f:cb26:e2f0:4a8a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b0015e8d4eb22dsm4966660plg.119.2022.05.02.11.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:41:11 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] kprobes: fix build with CONFIG_KRETPROBES=n
Date:   Mon,  2 May 2022 11:40:50 -0700
Message-Id: <20220502184050.1792743-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building kernel with CONFIG_KRETPROBES=n kernel/kprobes.c
compilation fails with the following messages:

  kernel/kprobes.c: In function ‘recycle_rp_inst’:
  kernel/kprobes.c:1273:32: error: implicit declaration of function
                                   ‘get_kretprobe’

  kernel/kprobes.c: In function ‘kprobe_flush_task’:
  kernel/kprobes.c:1299:35: error: ‘struct task_struct’ has no member
                                   named ‘kretprobe_instances’

Make references to kretprobe-specific structures and functions
conditional.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 kernel/kprobes.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..95ce4d16e63e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1258,6 +1258,7 @@ void kprobe_busy_end(void)
 }
 
 #if !defined(CONFIG_KRETPROBE_ON_RETHOOK)
+#ifdef CONFIG_KRETPROBES
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
@@ -1279,21 +1280,11 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
-/*
- * This function is called from delayed_put_task_struct() when a task is
- * dead and cleaned up to recycle any kretprobe instances associated with
- * this task. These left over instances represent probed functions that
- * have been called but will never return.
- */
-void kprobe_flush_task(struct task_struct *tk)
+static void kretprobe_flush_task(struct task_struct *tk)
 {
 	struct kretprobe_instance *ri;
 	struct llist_node *node;
 
-	/* Early boot, not yet initialized. */
-	if (unlikely(!kprobes_initialized))
-		return;
-
 	kprobe_busy_begin();
 
 	node = __llist_del_all(&tk->kretprobe_instances);
@@ -1306,6 +1297,25 @@ void kprobe_flush_task(struct task_struct *tk)
 
 	kprobe_busy_end();
 }
+NOKPROBE_SYMBOL(kretprobe_flush_task);
+#endif
+
+/*
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any kretprobe instances associated with
+ * this task. These left over instances represent probed functions that
+ * have been called but will never return.
+ */
+void kprobe_flush_task(struct task_struct *tk)
+{
+	/* Early boot, not yet initialized. */
+	if (unlikely(!kprobes_initialized))
+		return;
+
+#ifdef CONFIG_KRETPROBES
+	kretprobe_flush_task(tk);
+#endif
+}
 NOKPROBE_SYMBOL(kprobe_flush_task);
 
 static inline void free_rp_inst(struct kretprobe *rp)
-- 
2.30.2


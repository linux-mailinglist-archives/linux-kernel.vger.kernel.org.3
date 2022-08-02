Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3F58802B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbiHBQWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiHBQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:22:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CE4F1658D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659457358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3tsEKvxskgi9In/Fyj4bXLYVphFO38qknn8fDGj1Oo=;
        b=N+gp68eQPFsDxv/fBQQS2cR90L0+qplQgLCBs7+OnlA4vfkCTOomFPl5TfqlPJPb0PDm8o
        LXd3JOAP/nvNMZ64KJ4ceH72GVsD4v5fSanmFBh+KrWGbHggdIzzTERPIaL4CwSJuLaKnQ
        HZYoX/96gbd1HBOPB07pem8NPjqDg/s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-4hjQWIN6NWSnWYR0iteYJg-1; Tue, 02 Aug 2022 12:22:37 -0400
X-MC-Unique: 4hjQWIN6NWSnWYR0iteYJg-1
Received: by mail-pj1-f72.google.com with SMTP id f16-20020a17090a4a9000b001f234757bbbso6371051pjh.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 09:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=O3tsEKvxskgi9In/Fyj4bXLYVphFO38qknn8fDGj1Oo=;
        b=3Hf06HyrxUio5lK9U6ZZbAFbSS0tT5aKHH41r24Kx7jR4v4QWcdIShA0ArdFpj75zh
         ZT3sqF7ykZ6dVlyMIMI7KcZt2u6JcRz8/lPlz+rlThjMz7r6+LEHEuHw8BTpQtySFzjS
         9xJpCXWSh/mAJ4aC5fkjKk2+MOP8H0zwSW3VV4QquhTCY6I3Yx/+o33c7sT9JjcWQDR0
         1y01Bs+6FeyT1cvZiVFC3BDu6r3D2z2mhpnil3gXwMSAqes0I0p5JKxsaK1cYslMQlDX
         xEtefnQdv7O/2PMjxnIYXTo6xoS8kuRfB9bPwLfxiaOHJ6uNWbU/+SyGcEQfy9eNMY3V
         nXdA==
X-Gm-Message-State: ACgBeo29O9YYlwZbQSEggoMuwaq2hv/tQ3v1vorZWTPdkLsLWYznhTPH
        QiXx0GWGf+dquT0vSkS32FDRuKMt5cHVUXmx/8YPiSoxwuncEbT6fJ7xYLOXXsXuS3leBdXNSNT
        O1Dy8vsTiwSakQkKkVixKD0hs
X-Received: by 2002:a17:90b:390d:b0:1f2:4dbe:5f44 with SMTP id ob13-20020a17090b390d00b001f24dbe5f44mr253339pjb.27.1659457355671;
        Tue, 02 Aug 2022 09:22:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5r2Bfnmi/4f+Rd86nVyGuOIS5NmcCw3g6A/n5mcpUzWsdYZwfrpmAg/dDCyUCILR43VvmE5w==
X-Received: by 2002:a17:90b:390d:b0:1f2:4dbe:5f44 with SMTP id ob13-20020a17090b390d00b001f24dbe5f44mr253317pjb.27.1659457355413;
        Tue, 02 Aug 2022 09:22:35 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id z21-20020a630a55000000b00419ab8f8d2csm9342299pgk.20.2022.08.02.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:22:34 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     paulmck@kernel.org, frederic@kernel.org, neeraju@quicinc.com,
        josh@joshtriplett.org
Cc:     rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] rcu-tasks: Avoid pr_info() with spin lock in cblist_init_generic()
Date:   Wed,  3 Aug 2022 01:22:05 +0900
Message-Id: <20220802162205.817796-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
pr_info() calls printk() that might sleep, this will result in BUG
like below:

[    0.206455] cblist_init_generic: Setting adjustable number of callback queues.
[    0.206463]
[    0.206464] =============================
[    0.206464] [ BUG: Invalid wait context ]
[    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
[    0.206466] -----------------------------
[    0.206466] swapper/0/1 is trying to lock:
[    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x327/0x4a0
[    0.206473] other info that might help us debug this:
[    0.206473] context-{5:5}
[    0.206474] 3 locks held by swapper/0/1:
[    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
[    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: _printk+0x63/0x7e
[    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at: console_emit_next_record.constprop.0+0x111/0x330
[    0.206485] stack backtrace:
[    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428-g9de1f9c8ca51 #5
[    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[    0.206489] Call Trace:
[    0.206490]  <TASK>
[    0.206491]  dump_stack_lvl+0x6a/0x9f
[    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
[    0.206496]  ? stack_trace_save+0x46/0x70
[    0.206497]  lock_acquire+0xd1/0x2f0
[    0.206499]  ? serial8250_console_write+0x327/0x4a0
[    0.206500]  ? __lock_acquire+0x5c7/0x2720
[    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
[    0.206504]  ? serial8250_console_write+0x327/0x4a0
[    0.206506]  serial8250_console_write+0x327/0x4a0
[    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
[    0.206511]  console_unlock+0xf7/0x1f0
[    0.206512]  vprintk_emit+0xf7/0x330
[    0.206514]  _printk+0x63/0x7e
[    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
[    0.206518]  rcu_init_tasks_generic+0x5/0xd9
[    0.206522]  kernel_init_freeable+0x15b/0x2a2
[    0.206523]  ? rest_init+0x160/0x160
[    0.206526]  kernel_init+0x11/0x120
[    0.206527]  ret_from_fork+0x1f/0x30
[    0.206530]  </TASK>
[    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.

This patch moves pr_info() so that it is called without
rtp->cbs_gbl_lock locked.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 kernel/rcu/tasks.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3925e32159b5..d46dd970bf22 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -227,7 +227,6 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
 	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
 	}
@@ -256,6 +255,10 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+
+	if (rcu_task_cb_adjust)
+		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+
 	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
 }
 
-- 
2.37.1


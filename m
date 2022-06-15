Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E7C54CBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbiFOOyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiFOOyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9D9C192A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655304848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6x2wDLFKAMC+cvpWaWg3NnJOz7CCiXHw7aQV5dSHT7k=;
        b=SzFxWeGqqCygkbdjYFnVmf5xbGc4RKsnRBawholEUzQnsWtYmz8a997W6ZlTS6nAjyl/on
        FdaefV3Nc3nhJFizVnrfqjT9/ZxVTOTOL2prQBbF0VBJBBhfsqEyxhIOEHFFNCA4dCZkDg
        9kG08bfqxcW8lfZwnQwx7/jDECokGGw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-QSKnnfK5NbOD9QYun2KTXg-1; Wed, 15 Jun 2022 10:54:07 -0400
X-MC-Unique: QSKnnfK5NbOD9QYun2KTXg-1
Received: by mail-qt1-f198.google.com with SMTP id a16-20020a05622a02d000b00304eb488a71so8968459qtx.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6x2wDLFKAMC+cvpWaWg3NnJOz7CCiXHw7aQV5dSHT7k=;
        b=omNPqk/nZJDWAHls+WcBtzoW6eRt/TMsZAo2HDaIU/3uBtbo17VXnlhsmhhFTgh1OZ
         0Q99pACQ/nWkbDIvD6oRKosTFE5sjl6gjdJwC1K1YShXPcq8GvAxzoo+1afOx9bjHv8C
         +sUgV2uv50tLGBJOKxoawsKb5vpseMz+bGMdz6H7Sg8a9QqPCuGdbmPfBkMdEdDHhXYm
         8xwU0BQoggOFXrde0C9E0GBgn+Czjh87yiyvajQ+ZnV8rs+V8EomJqsJ6VmGCiuBDU0D
         LmcOAl1Cr4RgTw/4Ns/5DQ2Vi6BW+IPTo5w/fNdqslIu76bEJaIF20TIiVsQcQlSd9ll
         57Jw==
X-Gm-Message-State: AJIora9QhPTFsgaCjS90ZcffNuUaFij7mSQt40M/u/G3whwhLBZfpJf/
        Ck5lhVDXR0lBToR8rFKZ8rZrNRlFKU56T6Qq7nyxA5gYg+240FoRiBKk/7HJKxtZzdeb2xrPyb+
        ZpBBxdTGhX/qlTKUTpcpEgM7S
X-Received: by 2002:a05:620a:c52:b0:6a7:8cf2:6c4e with SMTP id u18-20020a05620a0c5200b006a78cf26c4emr19364qki.614.1655304845888;
        Wed, 15 Jun 2022 07:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sWc8U0S3kRZShguD6f/aQSwHw4ETrVTUN7umlzZXqRL7eZCR0QzPiPXvOONuFI0ylC2IBkmg==
X-Received: by 2002:a05:620a:c52:b0:6a7:8cf2:6c4e with SMTP id u18-20020a05620a0c5200b006a78cf26c4emr19348qki.614.1655304845556;
        Wed, 15 Jun 2022 07:54:05 -0700 (PDT)
Received: from localhost.localdomain ([151.29.54.194])
        by smtp.gmail.com with ESMTPSA id br27-20020a05622a1e1b00b0030515e3a3b9sm9044173qtb.79.2022.06.15.07.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:54:04 -0700 (PDT)
Date:   Wed, 15 Jun 2022 16:53:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RT] WARNING at hrtimer_start_range_ns
Message-ID: <YqnygxNWOztakt8+@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

QE reported splats with signatures similar to the following (edited)
when running blktests/nvmeof-mp [1] cases.

--->8---
[  329.284321] WARNING: CPU: 0 PID: 4830 at kernel/time/hrtimer.c:1294 hrtimer_start_range_ns+0xa0/0xb0
[  329.286298] Modules linked in: nvme_rdma(E) nvme_fabrics(E) nvme(E) nvmet_rdma(E) ...
[  329.286354] Unloaded tainted modules: intel_uncore_frequency(E):2 isst_if_mbox_msr(E):2 ...
[  329.296991] CPU: 0 PID: 4830 Comm: multipathd Kdump: loaded Tainted: G            E    --------  ---  5.19.0-0.rc1.9886142c7a22.16.test.eln120.x86_64+rt #2
[  329.298861] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[  329.299798] RIP: 0010:hrtimer_start_range_ns+0xa0/0xb0
[  329.300533] Code: 41 5d 41 5e 41 5f e9 df b4 94 00 be 01 00 00 00 48 89 df e8 82 f0 ff ff eb d8 49 8b 7d 00 48 89 c6 e8 c4 b4 94 00 f3 90 eb 91 <0f> 0b eb 8d 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 80
[  329.303087] RSP: 0018:ffffb4c180a1bd18 EFLAGS: 00010202
[  329.303817] RAX: 0000000000000001 RBX: ffffb4c180a1bd80 RCX: 0000000000000001
[  329.304828] RDX: 000000000000c300 RSI: 00000000000003e8 RDI: ffffb4c180a1bd80
[  329.305759] RBP: 00000000000003e8 R08: 00000000000003e8 R09: 0000000000000000
[  329.306637] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000c350
[  329.307510] R13: 00007efd462b3540 R14: 0000000000000001 R15: 0000000000000000
[  329.308384] FS:  00007efd462b5600(0000) GS:ffff8d30bbc00000(0000) knlGS:0000000000000000
[  329.309368] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  329.310071] CR2: 00007efd4628f000 CR3: 000000011ba62004 CR4: 00000000007706f0
[  329.310939] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  329.311811] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  329.312680] PKRU: 55555554
[  329.313022] Call Trace:
[  329.313352]  <TASK>
[  329.313632]  read_events+0xd5/0x180
[  329.314086]  ? fget+0x79/0xa0
[  329.314519]  ? __hrtimer_init+0xe0/0xe0
[  329.315056]  do_io_getevents+0x71/0xd0
[  329.315580]  __x64_sys_io_getevents+0x58/0xc0
[  329.316130]  do_syscall_64+0x5b/0x80
[  329.316590]  ? syscall_exit_to_user_mode+0x12/0x30
[  329.317192]  ? do_syscall_64+0x67/0x80
[  329.317669]  ? do_syscall_64+0x67/0x80
[  329.318139]  ? do_syscall_64+0x67/0x80
[  329.318666]  ? syscall_exit_to_user_mode+0x12/0x30
[  329.319337]  ? do_syscall_64+0x67/0x80
[  329.319851]  ? do_syscall_64+0x67/0x80
[  329.320396]  ? syscall_exit_to_user_mode+0x12/0x30
[  329.321062]  ? do_syscall_64+0x67/0x80
[  329.321540]  ? __irq_exit_rcu+0x72/0x160
[  329.322042]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  329.322671] RIP: 0033:0x7efd477feecd
[  329.323128] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 23 7f 1b 00 f7 d8 64 89 01 48
[  329.325462] RSP: 002b:00007efd462b34b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d0
[  329.326388] RAX: ffffffffffffffda RBX: 00007efd462b5300 RCX: 00007efd477feecd
[  329.326962] nvme nvme0: Removing ctrl: NQN "nvme-test"
[  329.327885] RDX: 0000000000000080 RSI: 0000000000000001 RDI: 00007efd4628f000
[  329.328760] RBP: 00007efd4628f000 R08: 00007efd462b45a0 R09: 0000000000000000
[  329.329631] R10: 00007efd462b3540 R11: 0000000000000246 R12: 0000000000000001
[  329.330506] R13: 0000000000000000 R14: 0000000000000080 R15: 00007efd462b3540
[  329.331390]  </TASK>
--->8---

My understanding is that we have

fs/aio.c::read_events
  wait_event_interruptible_hrtimeout
    __wait_event_hrtimeout
      hrtimer_init_sleeper_on_stack <- this might mode |=HRTIMER_MODE_HARD on RT
        hrtimer_start_range_ns
	  WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
	  fires since the latter doesn't see the change of mode done by
	  init_sleeper

The attached patch seems to cure the problem, although I'm not entirely
sure it's the cleanest fix (if I'm right at all about it :).

Thanks,
Juri

1 - https://github.com/yizhanglinux/blktests/tree/nvme-rdma-tcp/tests/nvmeof-mp

--->8---
From c7bb856eef8293c3a027f63ec3dc4fec93807227 Mon Sep 17 00:00:00 2001
From: Juri Lelli <juri.lelli@redhat.com>
Date: Tue, 14 Jun 2022 10:58:51 +0200
Subject: [PATCH] time/hrtimer: Embed hrtimer mode into hrtimer_sleeper

Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper() on
PREEMPT_RT) are not visible to do_nanosleep(), thus not accounted for
by hrtimer_start_expires() call paths.

Embed hrtimer mode into hrtimer_sleeper struct, so that the same mode is
used by code following hrtimer_sleeper initialization.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 block/blk-mq.c          | 2 +-
 include/linux/hrtimer.h | 1 +
 include/linux/wait.h    | 2 +-
 kernel/futex/pi.c       | 2 +-
 kernel/time/hrtimer.c   | 7 ++++---
 net/core/pktgen.c       | 2 +-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 03235ed3a792..429d5f08a7c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4672,7 +4672,7 @@ static bool blk_mq_poll_hybrid(struct request_queue *q, blk_qc_t qc)
 		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		hrtimer_sleeper_start_expires(&hs, mode);
+		hrtimer_sleeper_start_expires(&hs, hs.mode);
 		if (hs.task)
 			io_schedule();
 		hrtimer_cancel(&hs.timer);
diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index d22418264bec..90f79b4e20c8 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -140,6 +140,7 @@ struct hrtimer {
 struct hrtimer_sleeper {
 	struct hrtimer timer;
 	struct task_struct *task;
+	enum hrtimer_mode mode;
 };
 
 #ifdef CONFIG_64BIT
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 2d0df57c9902..b7499818f2c7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -521,7 +521,7 @@ do {										\
 	if ((timeout) != KTIME_MAX)						\
 		hrtimer_start_range_ns(&__t.timer, timeout,			\
 				       current->timer_slack_ns,			\
-				       HRTIMER_MODE_REL);			\
+				       __t.mode);				\
 										\
 	__ret = ___wait_event(wq_head, condition, state, 0, 0,			\
 		if (!__t.task) {						\
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 183b28c32c83..c576e84d96c9 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -1034,7 +1034,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	}
 
 	if (unlikely(to))
-		hrtimer_sleeper_start_expires(to, HRTIMER_MODE_ABS);
+		hrtimer_sleeper_start_expires(to, to->mode);
 
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 0ea8702eb516..0019c802e2e8 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1996,6 +1996,7 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 	__hrtimer_init(&sl->timer, clock_id, mode);
 	sl->timer.function = hrtimer_wakeup;
 	sl->task = current;
+	sl->mode = mode;
 }
 
 /**
@@ -2075,7 +2076,7 @@ static long __sched hrtimer_nanosleep_restart(struct restart_block *restart)
 	hrtimer_init_sleeper_on_stack(&t, restart->nanosleep.clockid,
 				      HRTIMER_MODE_ABS);
 	hrtimer_set_expires_tv64(&t.timer, restart->nanosleep.expires);
-	ret = do_nanosleep(&t, HRTIMER_MODE_ABS);
+	ret = do_nanosleep(&t, t.mode);
 	destroy_hrtimer_on_stack(&t.timer);
 	return ret;
 }
@@ -2094,7 +2095,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
 
 	hrtimer_init_sleeper_on_stack(&t, clockid, mode);
 	hrtimer_set_expires_range_ns(&t.timer, rqtp, slack);
-	ret = do_nanosleep(&t, mode);
+	ret = do_nanosleep(&t, t.mode);
 	if (ret != -ERESTART_RESTARTBLOCK)
 		goto out;
 
@@ -2299,7 +2300,7 @@ schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 
 	hrtimer_init_sleeper_on_stack(&t, clock_id, mode);
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
-	hrtimer_sleeper_start_expires(&t, mode);
+	hrtimer_sleeper_start_expires(&t, t.mode);
 
 	if (likely(t.task))
 		schedule();
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 82c016e8c196..51eddba28c03 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2169,7 +2169,7 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 	} else {
 		do {
 			set_current_state(TASK_INTERRUPTIBLE);
-			hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_ABS);
+			hrtimer_sleeper_start_expires(&t, t.mode);
 
 			if (likely(t.task))
 				schedule();
-- 
2.36.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2344D0600
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbiCGSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbiCGSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BBAD1D30F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 10:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646676468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HRhAzQcQYqAgXDZFipbuCqYFVLJ86zZ1vZNKzsiIMFU=;
        b=a5I7IXs0BfaGOMogI3ZTxuoJQnfBp/ASLXWK/X8+iYVWgY9ByZg2Y1vvSIssvWkte260s1
        dEube89p/N8vw2lKJGOeoLZIWu4jahvt2OGPfCY/PDCm0kzZkzsf4XDLQ5X5fE0APW2wuD
        oVADjZ/F4o1q6E6in/t4MeuKmqBSk8Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-rkfiSFG5NIGs6tub7Sc4GA-1; Mon, 07 Mar 2022 13:07:46 -0500
X-MC-Unique: rkfiSFG5NIGs6tub7Sc4GA-1
Received: by mail-wm1-f71.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso8171461wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 10:07:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRhAzQcQYqAgXDZFipbuCqYFVLJ86zZ1vZNKzsiIMFU=;
        b=u3BjCjZLiDptZyeb1i/lzI3gEo277ZigbXJ5AVwTP/3f6UFjHzOgWacT3En74Z3JM+
         qRHS+4E8lqlPAlXUIVS9BfD9i+erG+3GSl1NEo7QUK2tLFyH6RX5X3y9SadPYuxWLzwI
         sk33ebiiGko2RYEEbAcfvqXkdTtj0rEUH3iBHH/Rf3uijHKok51DO88qO/osV73NHrpS
         4X6KKRXLXQJyfSnDyqlR7sgsur3o8WHC2ob43Xdv2T2cp2ULuadXKaMhZvh9D3/Pu170
         LRIT/1HfvxTfOWHtU/j02+kkEtgJ0gBGdbPNV0RFq/ghF8SBYchpaRP0ZQBFysOt3M9A
         WMww==
X-Gm-Message-State: AOAM5339sLIdN23HCsq1lL9YIlUUUtL8dTWgKA8eubDeiP5cBQ+l6MLE
        e+Nfx5wyJzfBHKGEnWRkmC2JlC9JneOdxDicHUMhEByAkKG9loULDnMG7uHS0BgAn9E+RGQ0dTT
        /ox+Yb8Lut5e7PX1wGn3HK6KW
X-Received: by 2002:a1c:f409:0:b0:381:500b:ad90 with SMTP id z9-20020a1cf409000000b00381500bad90mr136460wma.42.1646676465654;
        Mon, 07 Mar 2022 10:07:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCDO7OoW0HzedZVT8zI1KgbSMVqIE1/ablNuIiqFi6s/LnIWLao4bMgaXFChB8sH4ABx7x6Q==
X-Received: by 2002:a1c:f409:0:b0:381:500b:ad90 with SMTP id z9-20020a1cf409000000b00381500bad90mr136444wma.42.1646676465420;
        Mon, 07 Mar 2022 10:07:45 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm50125wmq.35.2022.03.07.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:07:44 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     rostedt@goodmis.org, bristot@kernel.org, paulmck@kernel.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2] tracing/osnoise: Force quiescent states while tracing
Date:   Mon,  7 Mar 2022 19:07:40 +0100
Message-Id: <20220307180740.577607-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment running osnoise on a nohz_full CPU or uncontested FIFO
priority and a PREEMPT_RCU kernel might have the side effect of
extending grace periods too much. This will entice RCU to force a
context switch on the wayward CPU to end the grace period, all while
introducing unwarranted noise into the tracer. This behaviour is
unavoidable as overly extending grace periods might exhaust the system's
memory.

This same exact problem is what extended quiescent states (EQS) were
created for, conversely, rcu_momentary_dyntick_idle() emulates them by
performing a zero duration EQS. So let's make use of it.

In the common case rcu_momentary_dyntick_idle() is fairly inexpensive:
atomically incrementing a local per-CPU counter and doing a store. So it
shouldn't affect osnoise's measurements (which has a 1us granularity),
so we'll call it unanimously.

The uncommon case involve calling rcu_momentary_dyntick_idle() after
having the osnoise process:

 - Receive an expedited quiescent state IPI with preemption disabled or
   during an RCU critical section. (activates rdp->cpu_no_qs.b.exp
   code-path).

 - Being preempted within in an RCU critical section and having the
   subsequent outermost rcu_read_unlock() called with interrupts
   disabled. (t->rcu_read_unlock_special.b.blocked code-path).

Neither of those are possible at the moment, and are unlikely to be in
the future given the osnoise's loop design. On top of this, the noise
generated by the situations described above is unavoidable, and if not
exposed by rcu_momentary_dyntick_idle() will be eventually seen in
subsequent rcu_read_unlock() calls or schedule operations.

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---

Changes since v1:
 - Use local_irq_{enable,disable}()
 - Update commit message and comments to better explain RCU's behaviour
 - Get rid of nohz_full and tick checks
 - Comment on rcu_momentary_dyntick_idle()'s eventual execution cost

 kernel/trace/trace_osnoise.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a96d777350fa..ae5e314d7083 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1388,6 +1388,26 @@ static int run_osnoise(void)
 					osnoise_stop_tracing();
 		}
 
+		/*
+		 * In some cases, notably when running on a nohz_full CPU with
+		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
+		 * This will eventually cause unwarranted noise as PREEMPT_RCU
+		 * will force preemption as the means of ending the current
+		 * grace period. We avoid this problem by calling
+		 * rcu_momentary_dyntick_idle(), which performs a zero duration
+		 * EQS allowing PREEMPT_RCU to end the current grace period.
+		 * This call shouldn't be wrapped inside an RCU critical
+		 * section.
+		 *
+		 * Note that in non PREEMPT_RCU kernels QSs are handled through
+		 * cond_resched()
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
+			local_irq_disable();
+			rcu_momentary_dyntick_idle();
+			local_irq_enable();
+		}
+
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
 		 * they so wish.
-- 
2.35.1


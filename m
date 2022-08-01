Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9286C58705A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiHASZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbiHASZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:25:34 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FE3286DF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:25:33 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x193-20020a6286ca000000b0052d47405364so1243620pfd.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=3ngPVFbWLrNVJ91bCrd9T752zLcOTxZPhTLYHqaFcYE=;
        b=ebYFDd/GgVOBe+QvOvCevnyUH1nc4rURICgSapFdHelYdD/z4J31GhJgQjpdGFKg8q
         UiI51K30y8baUw7vd9DbjIgsuy5oVkQY0UdEHUIok/NjrC+HeE994jqnbfQWKDUv7MmA
         hOf2qnD69491ZGU7QHDrCee1ZDhEi+1MaoDj2RTIK/ogF30kQVSQ91fuTPrqkZ9DtaRj
         O8UjcKs3NtGyJ4KyDZ0NhXQYjR9Uh+tTa/ixGFrAoi+2sGIPa1hNk6qCN4WcRYauPO7v
         2+pJpfHeAuEgaP45nDDJpHiuF34opsqpjxxgwYL71KGilofqRLpb8Hzzr4fc0glLtFI+
         Tz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=3ngPVFbWLrNVJ91bCrd9T752zLcOTxZPhTLYHqaFcYE=;
        b=vvn62PEV6mSYwOy3zC1i8YQp+BNXg45x4qZZ1SBRRgxEPnbayLPcsuvYzycgRUxu4b
         BR/D4EVHvJRs4u/9XVKqqr0XvqONz3VbvGEiwHGHRoUtRd6q3GcY/+v03+1u0/53fVu7
         1aVNnE1A1QwYdG9xlV44+Sp41AZSCSDtyMNL44Q2J6+KloqajQQShj7ms2FEYQzlbpYa
         ntAbpc3p6yos3Y9vF4IG93/JdrMgp6JiEjj4V/b+nlzmN8btRPFy0bKMgoQyj56vgI78
         yLd2e8nm5/Pj8cir1UyPYo5/+ixflQqkBfMt6w3TfCjB4NKz2JRmdn8OxuRb1J0ExgKR
         HKYg==
X-Gm-Message-State: AJIora/TOGsloXZKKnkunUA8MDs9rkdNmFCNKraQNbq9v8aoholVetwU
        8HGDkGvsORoudr2wxfG2fxpGxOo2rNjtNg==
X-Google-Smtp-Source: AGRyM1uzSNxcGnj8jzcFfCx0ct2wm/QGuxQ8s+CT7r9NxsfM3tFH8d74S5zEw3l4d8hBSkgt7o5foqP0XeuamA==
X-Received: from zllamas.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c])
 (user=cmllamas job=sendgmr) by 2002:a63:f74e:0:b0:41a:716c:bfc4 with SMTP id
 f14-20020a63f74e000000b0041a716cbfc4mr14157055pgk.14.1659378333093; Mon, 01
 Aug 2022 11:25:33 -0700 (PDT)
Date:   Mon,  1 Aug 2022 18:25:11 +0000
Message-Id: <20220801182511.3371447-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH] binder: fix UAF of ref->proc caused by race condition
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A transaction of type BINDER_TYPE_WEAK_HANDLE can fail to increment the
reference for a node. In this case, the target proc normally releases
the failed reference upon close as expected. However, if the target is
dying in parallel the call will race with binder_deferred_release(), so
the target could have released all of its references by now leaving the
cleanup of the new failed reference unhandled.

The transaction then ends and the target proc gets released making the
ref->proc now a dangling pointer. Later on, ref->node is closed and we
attempt to take spin_lock(&ref->proc->inner_lock), which leads to the
use-after-free bug reported below. Let's fix this by cleaning up the
failed reference on the spot instead of relying on the target to do so.

  ==================================================================
  BUG: KASAN: use-after-free in _raw_spin_lock+0xa8/0x150
  Write of size 4 at addr ffff5ca207094238 by task kworker/1:0/590

  CPU: 1 PID: 590 Comm: kworker/1:0 Not tainted 5.19.0-rc8 #10
  Hardware name: linux,dummy-virt (DT)
  Workqueue: events binder_deferred_func
  Call trace:
   dump_backtrace.part.0+0x1d0/0x1e0
   show_stack+0x18/0x70
   dump_stack_lvl+0x68/0x84
   print_report+0x2e4/0x61c
   kasan_report+0xa4/0x110
   kasan_check_range+0xfc/0x1a4
   __kasan_check_write+0x3c/0x50
   _raw_spin_lock+0xa8/0x150
   binder_deferred_func+0x5e0/0x9b0
   process_one_work+0x38c/0x5f0
   worker_thread+0x9c/0x694
   kthread+0x188/0x190
   ret_from_fork+0x10/0x20

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 362c0deb65f1..9d42afe60180 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -1361,6 +1361,18 @@ static int binder_inc_ref_for_node(struct binder_proc *proc,
 	}
 	ret = binder_inc_ref_olocked(ref, strong, target_list);
 	*rdata = ref->data;
+	if (ret && ref == new_ref) {
+		/*
+		 * Cleanup the failed reference here as the target
+		 * could now be dead and have already released its
+		 * references by now. Calling on the new reference
+		 * with strong=0 and a tmp_refs will not decrement
+		 * the node. The new_ref gets kfree'd below.
+		 */
+		binder_cleanup_ref_olocked(new_ref);
+		ref = NULL;
+	}
+
 	binder_proc_unlock(proc);
 	if (new_ref && ref != new_ref)
 		/*
-- 
2.37.1.455.g008518b4e5-goog


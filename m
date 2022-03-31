Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98784ED454
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiCaHEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiCaHEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:04:14 -0400
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 31 Mar 2022 00:02:27 PDT
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EDC1EE8FF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1648710147;
  x=1680246147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZGUlNEDgfhKPqk9GYADNZofauGboqQ59TxpOJKUhBBo=;
  b=L26D9z/cE29l9ai1BgDDgCz2IHla5fTwKrQZ7eoaeex5Jac50lpsfEZ8
   bk4HQxBgY855yLBZVLxQ6uWVWa5QnBPsjWJY6mbCyfPxn5qtF6Uv2hBA9
   J9oJdcO7MKl9YHypwfFnhmoM5K/wI9n+Qkc/5CCHKsYwblFHhQ6pTKh6X
   m7fHgqEqy+SCOrtYvr+2IhxEfMaVWLHJvwOUWA/me2oy1gpdnVcU2L/qE
   x5jNmeRblxNCu1Qzkc7LjNZLCk0g/kpjI3LlBzHEq3eLoYbFQTVf3z6KQ
   MPBJj1LxK+kBGHMDE9DiPDgxWQ4Qu/mZFuBUIjsT5B+Ug4gy82Tv7p1C2
   Q==;
From:   =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <kernel@axis.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mailbox: forward the hrtimer if not queued and under a lock
Date:   Thu, 31 Mar 2022 09:01:15 +0200
Message-ID: <20220331070115.29421-1-bjorn.ardo@axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit c7dacf5b0f32957b24ef29df1207dc2cd8307743,
"mailbox: avoid timer start from callback"

The previous commit was reverted since it lead to a race that
caused the hrtimer to not be started at all. The check for
hrtimer_active() in msg_submit() will return true if the
callback function txdone_hrtimer() is currently running. This
function could return HRTIMER_NORESTART and then the timer
will not be restarted, and also msg_submit() will not start
the timer. This will lead to a message actually being submitted
but no timer will start to check for its compleation.

The original fix that added checking hrtimer_active() was added to
avoid a warning with hrtimer_forward. Looking in the kernel
another solution to avoid this warning is to check hrtimer_is_queued()
before calling hrtimer_forward_now() instead. This however requires a
lock so the timer is not started by msg_submit() inbetween this check
and the hrtimer_forward() call.

Signed-off-by: Björn Ardö <bjorn.ardo@axis.com>
---
 drivers/mailbox/mailbox.c          | 19 +++++++++++++------
 include/linux/mailbox_controller.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..4229b9b5da98 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -82,11 +82,11 @@ static void msg_submit(struct mbox_chan *chan)
 exit:
 	spin_unlock_irqrestore(&chan->lock, flags);
 
-	/* kick start the timer immediately to avoid delays */
 	if (!err && (chan->txdone_method & TXDONE_BY_POLL)) {
-		/* but only if not already active */
-		if (!hrtimer_active(&chan->mbox->poll_hrt))
-			hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+		/* kick start the timer immediately to avoid delays */
+		spin_lock_irqsave(&chan->mbox->poll_hrt_lock, flags);
+		hrtimer_start(&chan->mbox->poll_hrt, 0, HRTIMER_MODE_REL);
+		spin_unlock_irqrestore(&chan->mbox->poll_hrt_lock, flags);
 	}
 }
 
@@ -120,20 +120,26 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 		container_of(hrtimer, struct mbox_controller, poll_hrt);
 	bool txdone, resched = false;
 	int i;
+	unsigned long flags;
 
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
 		if (chan->active_req && chan->cl) {
-			resched = true;
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
+			else
+				resched = true;
 		}
 	}
 
 	if (resched) {
-		hrtimer_forward_now(hrtimer, ms_to_ktime(mbox->txpoll_period));
+		spin_lock_irqsave(&mbox->poll_hrt_lock, flags);
+		if (!hrtimer_is_queued(hrtimer))
+			hrtimer_forward_now(hrtimer, ms_to_ktime(mbox->txpoll_period));
+		spin_unlock_irqrestore(&mbox->poll_hrt_lock, flags);
+
 		return HRTIMER_RESTART;
 	}
 	return HRTIMER_NORESTART;
@@ -500,6 +506,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 		hrtimer_init(&mbox->poll_hrt, CLOCK_MONOTONIC,
 			     HRTIMER_MODE_REL);
 		mbox->poll_hrt.function = txdone_hrtimer;
+		spin_lock_init(&mbox->poll_hrt_lock);
 	}
 
 	for (i = 0; i < mbox->num_chans; i++) {
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 36d6ce673503..6fee33cb52f5 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -83,6 +83,7 @@ struct mbox_controller {
 				      const struct of_phandle_args *sp);
 	/* Internal to API */
 	struct hrtimer poll_hrt;
+	spinlock_t poll_hrt_lock;
 	struct list_head node;
 };
 
-- 
2.20.1


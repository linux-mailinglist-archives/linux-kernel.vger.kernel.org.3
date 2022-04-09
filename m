Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D6A4FA53C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiDIFyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiDIFyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:54:02 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FCAE2D1E4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:51:54 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app4 (Coremail) with SMTP id cS_KCgDHPKTnHlFieTn3AA--.58552S2;
        Sat, 09 Apr 2022 13:51:39 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-xtensa@linux-xtensa.org, kuba@kernel.org,
        alexander.deucher@amd.com, gregkh@linuxfoundation.org,
        davem@davemloft.net, jcmvbkbc@gmail.com, chris@zankel.net,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V2 10/11] arch: xtensa: platforms: Fix deadlock in iss_net_close()
Date:   Sat,  9 Apr 2022 13:51:35 +0800
Message-Id: <20220409055135.54921-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgDHPKTnHlFieTn3AA--.58552S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1DWFyDKr4xXFWUGFy8Krg_yoW8ArW3pr
        WYgry3tF48Wr4Iga1DA3WDu3y7ua1ktr1UGrZxG3y8uas7Xry3XF4Utw4rWF47KFZFqFZ3
        Crn5X345AFs8Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
        1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHUDUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgQPAVZdtZGjxwA3s0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in iss_net_close(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | iss_net_open()
iss_net_close()            |  mod_timer()
 spin_lock_bh() //(1)      |  (wait a time)
 ...                       | iss_net_timer()
 del_timer_sync()          |  spin_lock() //(2)
 (wait timer to stop)      |  ...

We hold lp->lock in position (1) of thread 1 and use
del_timer_sync() to wait timer to stop, but timer handler
also need lp->lock in position (2) of thread 2. As a result,
iss_net_close() will block forever.

This patch extracts del_timer_sync() from the protection of
spin_lock_bh(), which could let timer handler to obtain
the needed lock. What`s more, we should remove spin_lock()
in iss_net_timer(), because there is no resource need to
protect and spin_lock() may cause deadlock in timer handler.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V2:
  - Remove spin_lock() in iss_net_timer().

 arch/xtensa/platforms/iss/network.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index be3aaaad8be..1ae39c18c6e 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -352,9 +352,7 @@ static void iss_net_timer(struct timer_list *t)
 	struct iss_net_private *lp = from_timer(lp, t, timer);
 
 	iss_net_poll();
-	spin_lock(&lp->lock);
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
-	spin_unlock(&lp->lock);
 }
 
 
@@ -403,7 +401,9 @@ static int iss_net_close(struct net_device *dev)
 	list_del(&opened);
 	spin_unlock(&opened_lock);
 
+	spin_unlock_bh(&lp->lock);
 	del_timer_sync(&lp->timer);
+	spin_lock_bh(&lp->lock);
 
 	lp->tp.close(lp);
 
-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3377C4F83F8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiDGPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345190AbiDGPrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:47:07 -0400
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B4FBC6B7A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:44:56 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app3 (Coremail) with SMTP id cC_KCgBHFfDfBk9iCaqVAQ--.52587S2;
        Thu, 07 Apr 2022 23:44:35 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-xtensa@linux-xtensa.org, jirislaby@kernel.org,
        alexander.deucher@amd.com, gregkh@linuxfoundation.org,
        davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
        s.shtylyov@omp.ru, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V2 11/11] arch: xtensa: platforms: Fix deadlock in rs_close()
Date:   Thu,  7 Apr 2022 23:44:30 +0800
Message-Id: <20220407154430.22387-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgBHFfDfBk9iCaqVAQ--.52587S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1kWFy8CF48JrWxXw45GFg_yoW8uryrpF
        45KrsxGF4DWr40ga1Dta1kury7Ca1kK347XryrG39Yv3Zaqr1agFnrJ3yYvFW3tFZ2qrsx
        Xr10qry5AFsxZw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgYNAVZdtZE+egAGsl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in rs_close(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | rs_open()
rs_close()                 |  mod_timer()
 spin_lock_bh() //(1)      |  (wait a time)
 ...                       | rs_poll()
 del_timer_sync()          |  spin_lock() //(2)
 (wait timer to stop)      |  ...

We hold timer_lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need timer_lock in position (2) of thread 2.
As a result, rs_close() will block forever.

This patch deletes the redundant timer_lock in order to
prevent the deadlock. Because there is no race condition
between rs_close, rs_open and rs_poll.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V2:
  - Remove the timer_lock.

 arch/xtensa/platforms/iss/console.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 81d7c7e8f7e..10b79d3c74e 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -36,24 +36,19 @@ static void rs_poll(struct timer_list *);
 static struct tty_driver *serial_driver;
 static struct tty_port serial_port;
 static DEFINE_TIMER(serial_timer, rs_poll);
-static DEFINE_SPINLOCK(timer_lock);
 
 static int rs_open(struct tty_struct *tty, struct file * filp)
 {
-	spin_lock_bh(&timer_lock);
 	if (tty->count == 1)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	spin_unlock_bh(&timer_lock);
 
 	return 0;
 }
 
 static void rs_close(struct tty_struct *tty, struct file * filp)
 {
-	spin_lock_bh(&timer_lock);
 	if (tty->count == 1)
 		del_timer_sync(&serial_timer);
-	spin_unlock_bh(&timer_lock);
 }
 
 
@@ -73,8 +68,6 @@ static void rs_poll(struct timer_list *unused)
 	int rd = 1;
 	unsigned char c;
 
-	spin_lock(&timer_lock);
-
 	while (simc_poll(0)) {
 		rd = simc_read(0, &c, 1);
 		if (rd <= 0)
@@ -87,7 +80,6 @@ static void rs_poll(struct timer_list *unused)
 		tty_flip_buffer_push(port);
 	if (rd)
 		mod_timer(&serial_timer, jiffies + SERIAL_TIMER_VALUE);
-	spin_unlock(&timer_lock);
 }
 
 
-- 
2.17.1


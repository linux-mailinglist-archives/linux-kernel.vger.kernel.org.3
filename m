Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39055562F37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiGAI4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiGAIz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:55:57 -0400
Received: from azure-sdnproxy-1.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E78301DA50
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:55:50 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [221.192.178.118])
        by mail-app3 (Coremail) with SMTP id cC_KCgDHPPCItr5ioIhGAQ--.26109S2;
        Fri, 01 Jul 2022 16:55:45 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org,
        edumazet@google.com, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] timers: fix synchronization rules in comments of del_timer_sync
Date:   Fri,  1 Jul 2022 16:55:35 +0800
Message-Id: <20220701085535.17018-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgDHPPCItr5ioIhGAQ--.26109S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWrtFyUtryrWF1xJFW5ZFb_yoW8Kr1fpw
        srKrn3Jr4DXFs0kFW0vF4ktry3Crs5Jry3CFs7K3yYyr1Sqw1rZFWjq348ZFW7GrZ7XFsr
        ZF1Fgw1Ykrn8G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnjjgUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgYSAVZdtafE3QBMsb
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The del_timer_sync() could stop the timer that restart itself
in the timer's handler. So the synchronization rules should be
changed to "Callers must prevent restarting of the timer in
other places except for the timer's handler".

The root cause is shown below which is a part of code in
del_timer_sync:

	do {
		ret = try_to_del_timer_sync(timer);

		if (unlikely(ret < 0)) {
			del_timer_wait_running(timer);
			cpu_relax();
		}
	} while (ret < 0);

If the timer's handler is running, the try_to_del_timer_sync will
return -1. Then, it will loop until the timer is not queued and
the timer's handler is not running on any CPU.

Although the timer may restart itself in timer's handler, the
del_timer_sync could also stop it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 kernel/time/timer.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14..823e45c1235 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1374,12 +1374,13 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  * the timer it also makes sure the handler has finished executing on other
  * CPUs.
  *
- * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's
- * handler. The timer's handler must not call add_timer_on(). Upon exit the
- * timer is not queued and the handler is not running on any CPU.
+ * Synchronization rules: Callers must prevent restarting of the timer in
+ * other places except for the timer's handler, otherwise this function is
+ * meaningless. It must not be called from interrupt contexts unless the
+ * timer is an irqsafe one. The caller must not hold locks which would
+ * prevent completion of the timer's handler. The timer's handler must
+ * not call add_timer_on(). Upon exit the timer is not queued and the
+ * handler is not running on any CPU.
  *
  * Note: For !irqsafe timers, you must not hold locks that are held in
  *   interrupt context while calling this function. Even if the lock has
-- 
2.17.1


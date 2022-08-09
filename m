Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4658D1AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244652AbiHIBQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiHIBQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:16:25 -0400
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 13791C1B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:16:21 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [218.12.17.53])
        by mail-app2 (Coremail) with SMTP id by_KCgDX3PROtfFidi1+Ag--.40181S2;
        Tue, 09 Aug 2022 09:16:05 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     jstultz@google.com, sboyd@kernel.org, edumazet@google.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] timers: fix synchronization rules in comments of del_timer_sync
Date:   Tue,  9 Aug 2022 09:15:57 +0800
Message-Id: <20220809011557.6472-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgDX3PROtfFidi1+Ag--.40181S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1DKrWDJw1xtw4xAF4fXwb_yoW8ZFyrp3
        y7Krn3GFs5XF4YkFW0vF4ktry3Gws3Jry5CFs7C3y5Zwn2qw1rXF4jqry8ZF47JrWkWFZr
        ZF1rZr4Ykrn8G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6w4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoUDGUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAggRAVZdta+OfgAAs7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The del_timer_sync() could stop the periodic timer. The root cause
is shown below which is a part of code in del_timer_sync:

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

Although the periodic timer may restart itself in timer's handler,
the del_timer_sync could also stop it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Make commit messages clearer.
  - Change the annotations about del_timer_sync.

 kernel/time/timer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 717fcb9fb14..dd623018dbc 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1375,11 +1375,11 @@ static inline void del_timer_wait_running(struct timer_list *timer) { }
  * CPUs.
  *
  * Synchronization rules: Callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts unless the timer is an irqsafe one. The caller must
- * not hold locks which would prevent completion of the timer's
- * handler. The timer's handler must not call add_timer_on(). Upon exit the
- * timer is not queued and the handler is not running on any CPU.
+ * otherwise this function is meaningless. It could also stop periodic timer.
+ * It must not be called from interrupt contexts unless the timer is an irqsafe
+ * one. The caller must not hold locks which would prevent completion of the
+ * timer's handler. Upon exit the timer is not queued and the handler is not
+ * running on any CPU.
  *
  * Note: For !irqsafe timers, you must not hold locks that are held in
  *   interrupt context while calling this function. Even if the lock has
-- 
2.17.1


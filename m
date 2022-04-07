Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1DB4F823D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbiDGO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiDGO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:57:04 -0400
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5766A1EE9ED;
        Thu,  7 Apr 2022 07:54:53 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [10.15.192.164])
        by mail-app4 (Coremail) with SMTP id cS_KCgBnKRAy+05iuezlAA--.612S2;
        Thu, 07 Apr 2022 22:54:46 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        gregkh@linuxfoundation.org, Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH V2 01/11] drivers: tty: serial: Fix deadlock in sa1100_set_termios()
Date:   Thu,  7 Apr 2022 22:54:41 +0800
Message-Id: <20220407145441.16253-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBnKRAy+05iuezlAA--.612S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy3AFW3Jr17Jr17ZFy8uFg_yoW8WF1rpF
        4qyr9xtFWkZr4293WDtw4DZF4ruwsrurW7CFWxG39Y9Fn5JryqgFn7K3s0vFW2vFsrXr9F
        vF1Fq3y3AF48A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxF
        aVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
        4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxG
        rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
        CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
        z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUq38nUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgYNAVZdtZE+eQAAsg
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a deadlock in sa1100_set_termios(), which is shown
below:

   (Thread 1)              |      (Thread 2)
                           | sa1100_enable_ms()
sa1100_set_termios()       |  mod_timer()
 spin_lock_irqsave() //(1) |  (wait a time)
 ...                       | sa1100_timeout()
 del_timer_sync()          |  spin_lock_irqsave() //(2)
 (wait timer to stop)      |  ...

We hold sport->port.lock in position (1) of thread 1 and
use del_timer_sync() to wait timer to stop, but timer handler
also need sport->port.lock in position (2) of thread 2. As a result,
sa1100_set_termios() will block forever.

This patch moves del_timer_sync() before spin_lock_irqsave()
in order to prevent the deadlock.

Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in V2:
  - Move del_timer_sync() before spin_lock_irqsave().

 drivers/tty/serial/sa1100.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index 5fe6cccfc1a..041e6bca0dc 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -445,7 +445,7 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 	 */
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16); 
 	quot = uart_get_divisor(port, baud);
-
+	del_timer_sync(&sport->timer);
 	spin_lock_irqsave(&sport->port.lock, flags);
 
 	sport->port.read_status_mask &= UTSR0_TO_SM(UTSR0_TFS);
@@ -476,8 +476,6 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 				UTSR1_TO_SM(UTSR1_ROR);
 	}
 
-	del_timer_sync(&sport->timer);
-
 	/*
 	 * Update the per-port timeout.
 	 */
-- 
2.17.1


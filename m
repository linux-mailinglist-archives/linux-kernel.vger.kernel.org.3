Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA14F4DB0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582608AbiDEXsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443899AbiDEPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBD214DFC5;
        Tue,  5 Apr 2022 07:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2E30B81BA9;
        Tue,  5 Apr 2022 14:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBD4C385A0;
        Tue,  5 Apr 2022 14:02:02 +0000 (UTC)
Date:   Tue, 5 Apr 2022 10:02:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220405100200.64f56e50@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

While looking at a crash report on a timer list being corrupted, which
usually happens when a timer is freed while still active. This is
commonly triggered by code calling del_timer() instead of
del_timer_sync() just before freeing.

One possible culprit is the hci_qca driver, which does exactly that.

Eric mentioned that wake_retrans_timer could be rearmed via the work
queue, so also move the destruction of the work queue before
del_timer_sync().

Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: stable@vger.kernel.org
Fixes: 0ff252c1976da ("Bluetooth: hciuart: Add support QCA chipset for UART")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lkml.kernel.org/r/20220404182236.1caa174e@rorschach.local.home
 - Moved destroy_workqueue() before del_timer_sync() calls (Eric Dumazet).

 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f6e91fb432a3..eab34e24d944 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -696,9 +696,9 @@ static int qca_close(struct hci_uart *hu)
 	skb_queue_purge(&qca->tx_wait_q);
 	skb_queue_purge(&qca->txq);
 	skb_queue_purge(&qca->rx_memdump_q);
-	del_timer(&qca->tx_idle_timer);
-	del_timer(&qca->wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
+	del_timer_sync(&qca->tx_idle_timer);
+	del_timer_sync(&qca->wake_retrans_timer);
 	qca->hu = NULL;
 
 	kfree_skb(qca->rx_skb);
-- 
2.35.1


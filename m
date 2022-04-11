Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716E94FC02C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbiDKPTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347726AbiDKPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:49 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11980B1DA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 580DC6C2F38;
        Mon, 11 Apr 2022 15:16:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7617B6C2210;
        Mon, 11 Apr 2022 15:16:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690190; a=rsa-sha256;
        cv=none;
        b=1w7t/NTBQ48D7hVdmupDPmDxHWaeTFxYb6pzN9ubC71YUxrLByEaZNFyeP0+MGA+pvT9yS
        /qzzdkb0bfJ8l2JEoienKYWR4ted8L6WKaxieFT5uOivsjVJmyNwcW5lgva+xieVD+SAOg
        ua//t4quX31z5mqhXhKY52n5AzGMSCIfxCB6WUW6nHtEDM8l3d55Ba5MInWQBRx0o+e3yi
        cZqmLHUajUq0kiW2tJ4FSQZQ+8YvPCmYutaTaGG3nvQGvA5xXMz7shxVc2OLaxpKsSbSd5
        RknaKVWFdhX1umubWAQjtAg6c18Y9520L+y0SxP0KUJaTekuRAJQjC2FEyBebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=gtD9/3R3fsIE1iOjF+WezkBbCL5lnD7f+xJAJilt+Nw=;
        b=8F+08J+WusnXOkwRDsHCfEWUNLn4MvwSqBoqaFR9l9tW1v3F+d/MdHQSd36Nt2sF3pzVIj
        KjaCWFF8UZLnIAPfZJoBf60KLEfF0m2huEfzOc1sp9KtMZ75uemeCNUuIQJHARetUAcb9D
        lRT2/x57L/VAKvDtPgOxaY30RxliMTPuSO1EegsRrW7FcZX2Bl87o5SeI2Hw++Vf0tCYkO
        2f/yUcnttWdjxynNgjUM+/lsd7UHW1yadZoelNJsUB6sufl5ZXqwuOq/GHRBIfsAzRnDyj
        EsUDvohF4hKpIRz6yN0c5/mjferPQqxdegBVFV4QvZ9EK1lJtjwBFSDJjjzRXA==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-2ngq6;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.255.155 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eyes-Hook: 360b6eb66c74954e_1649690190844_3488285450
X-MC-Loop-Signature: 1649690190844:1245218366
X-MC-Ingress-Time: 1649690190844
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWK6dnqz1dl;
        Mon, 11 Apr 2022 08:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690190;
        bh=gtD9/3R3fsIE1iOjF+WezkBbCL5lnD7f+xJAJilt+Nw=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=USChZilcn++JiMdYmi5woxFIzghtZKkNISt7OySSiCWOyrPZkbFGyAxtg2P2UgiPx
         L/H8/P8LmQL456TiTwN+HqkbiW/PHMELA1ud0hiRTc1o4fakgNhLaSWD0eIu2lJe9X
         twdDW2Hzm3uQghA+DLBHaHfNTXiew2DfmQDmgZmVNhl1UDlfXix1ZYYABCSx+t8de8
         GulYvpuhC9KLF73AcQmfPU5ZqCtiLvAnxhAw95xAaye7/M/zJST73yTcFM5pTXxx+O
         t8+SfqFRdR4WJ/MmunC7b3q+9iloc9T3UCPiq84NkeBys9jc+saFu0jWDW42T9+gF7
         sBkN4EyiWa3jg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 2/6] staging/wlan-ng, prism2usb: replace reaper_bh tasklet with work
Date:   Mon, 11 Apr 2022 08:16:16 -0700
Message-Id: <20220411151620.129178-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411151620.129178-1-dave@stgolabs.net>
References: <20220411151620.129178-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

The reaper_bh tasklet will now run in process context and have further
concurrency (tasklets being serialized among themselves), but this
is done holding the ctlxq.lock, so it should be fine.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/wlan-ng/hfa384x.h     |  2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c | 14 +++++++-------
 drivers/staging/wlan-ng/prism2usb.c   |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 98c154a8d8c1..7480d808e946 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1227,7 +1227,7 @@ struct hfa384x {
 
 	struct timer_list throttle;
 
-	struct tasklet_struct reaper_bh;
+	struct work_struct reaper_bh;
 	struct tasklet_struct completion_bh;
 
 	struct work_struct usb_work;
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 938e11a1a0b6..4000c321cb3a 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -193,7 +193,7 @@ static void hfa384x_usb_throttlefn(struct timer_list *t);
 
 static void hfa384x_usbctlx_completion_task(struct tasklet_struct *t);
 
-static void hfa384x_usbctlx_reaper_task(struct tasklet_struct *t);
+static void hfa384x_usbctlx_reaper_task(struct work_struct *work);
 
 static int hfa384x_usbctlx_submit(struct hfa384x *hw,
 				  struct hfa384x_usbctlx *ctlx);
@@ -539,7 +539,7 @@ void hfa384x_create(struct hfa384x *hw, struct usb_device *usb)
 	/* Initialize the authentication queue */
 	skb_queue_head_init(&hw->authq);
 
-	tasklet_setup(&hw->reaper_bh, hfa384x_usbctlx_reaper_task);
+	INIT_WORK(&hw->reaper_bh, hfa384x_usbctlx_reaper_task);
 	tasklet_setup(&hw->completion_bh, hfa384x_usbctlx_completion_task);
 	INIT_WORK(&hw->link_bh, prism2sta_processing_defer);
 	INIT_WORK(&hw->usb_work, hfa384x_usb_defer);
@@ -2585,7 +2585,7 @@ void hfa384x_tx_timeout(struct wlandevice *wlandev)
 /*----------------------------------------------------------------
  * hfa384x_usbctlx_reaper_task
  *
- * Tasklet to delete dead CTLX objects
+ * Deferred work to delete dead CTLX objects
  *
  * Arguments:
  *	data	ptr to a struct hfa384x
@@ -2593,12 +2593,12 @@ void hfa384x_tx_timeout(struct wlandevice *wlandev)
  * Returns:
  *
  * Call context:
- *	Interrupt
+ *      Task
  *----------------------------------------------------------------
  */
-static void hfa384x_usbctlx_reaper_task(struct tasklet_struct *t)
+static void hfa384x_usbctlx_reaper_task(struct work_struct *work)
 {
-	struct hfa384x *hw = from_tasklet(hw, t, reaper_bh);
+	struct hfa384x *hw = container_of(work, struct hfa384x, reaper_bh);
 	struct hfa384x_usbctlx *ctlx, *temp;
 	unsigned long flags;
 
@@ -2686,7 +2686,7 @@ static void hfa384x_usbctlx_completion_task(struct tasklet_struct *t)
 	spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
 
 	if (reap)
-		tasklet_schedule(&hw->reaper_bh);
+		schedule_work(&hw->reaper_bh);
 }
 
 /*----------------------------------------------------------------
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index dc0749b8eff7..36340f36b0cb 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -182,7 +182,7 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		usb_kill_urb(&hw->ctlx_urb);
 
 		tasklet_kill(&hw->completion_bh);
-		tasklet_kill(&hw->reaper_bh);
+		cancel_work_sync(&hw->reaper_bh);
 
 		cancel_work_sync(&hw->link_bh);
 		cancel_work_sync(&hw->commsqual_bh);
-- 
2.26.2


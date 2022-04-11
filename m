Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5803B4FC024
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347733AbiDKPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347717AbiDKPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:49 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176FB1D9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 0DF182A1AA4;
        Mon, 11 Apr 2022 15:16:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 440782A0660;
        Mon, 11 Apr 2022 15:16:31 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690191; a=rsa-sha256;
        cv=none;
        b=R3Qy7j2CxCeHE33za07uHVO9smPjxoQPWj9jAsGI+kG6ouxaqJa+qZxL/KfKM6vZi9HaRx
        k8qtollpAVrlK4TGC0ML64p8vUpClO87ao/eBOApECEYFoQJJUCvODMi53eUGZLCUUTt7T
        6SK1gkzbj7hDWS2Qin6PQzs5p7rJIgr+HbZPgUd7T4Vcqfe2HTM5+E3XDwvjg7Ttu+PM1T
        IOofzls6FNX6iwu0y6sbMo8AdK+kiPZUyR5ajviy35hQQtC+OxkMOdmv6KJKCpSuaiBVQO
        rN7+luYcEOyPgpelT32UlZM44SyscoYHbGphXIxyCz6MgzmMS/398ILt8fDyXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=87rjyv1fYVQxYjTypozOdzalmHJuGl6PHh8Q3KobcEk=;
        b=M/y+FdQ4Tc4sUtXHezQ/D44aWWrLa+s8abZdRgW6QypZIa0IAdjOrHqXGYvXHwGavVVuBC
        PkiWc37e7fR5zeHZX38MLkRtfLUvZEQa+2QSMaApD8Oep5Vkb74YLbrI6iKMQDLfY9XGIk
        fZROUSTQhFh0kObt1MIc292UlkMsAUA8znNfhHWQmLXr5ZU4naOqeczJ9mXceUMHtzKKw9
        7Cl+7reZF0TeaN8+6/Dw8hyC49DGSQcvTKuPktuq7cIfE0Plb+U48V0+KmsB88O6MXqZ7X
        ENsRBE56oJZ/ezXaMY6G9mvJvxCTG1XRFYx9r9sLpdE/95Ri0ad5qsien3oNKA==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-f7pqt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.210.137 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Harbor: 66e32e3c11eaf707_1649690191792_2463292124
X-MC-Loop-Signature: 1649690191791:3362250161
X-MC-Ingress-Time: 1649690191791
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWL3S74z1f0;
        Mon, 11 Apr 2022 08:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690190;
        bh=87rjyv1fYVQxYjTypozOdzalmHJuGl6PHh8Q3KobcEk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=fmOqCt+sUZYt4VcH9xHkIXdUKd6Ka4/vh+oG5MBfco2H3oin0Pn6BltKg4yNLjE57
         wQEbd+lJovFAuCNYt+qGUjW3L8vg7/Si/f9NyVBRDCox8ZVD8L21Flo3Ox2KTdD1RM
         vvesHy0EYAqa35/lZxB35En0dHZHt3U6bua0AhmnqBFxSL/PcijH2To1D0NrYgChZh
         fMkle/S5IkSjXZItDBxEnbJwlR14lR98JCujQ4pZ0Kji+vv4iySfDBdgw6uvXG4MSO
         saszd8+zr0v/WVznu+30WgWdSTRoNG4LzLTTNUa2iaA+EfDGRlr5sHDu76r6m0MFAm
         etw8BWGrH9W4A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 3/6] staging/wlan-ng, prism2usb: replace completion_bh tasklet with work
Date:   Mon, 11 Apr 2022 08:16:17 -0700
Message-Id: <20220411151620.129178-4-dave@stgolabs.net>
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

The completion_bh tasklet will now run in process context and have
further concurrency (tasklets being serialized among themselves),
but this is done holding the ctlxq.lock, so it should be fine.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/wlan-ng/hfa384x.h     |  2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c | 22 +++++++++++-----------
 drivers/staging/wlan-ng/prism2usb.c   |  6 +++---
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/wlan-ng/hfa384x.h b/drivers/staging/wlan-ng/hfa384x.h
index 7480d808e946..0611e37df6ac 100644
--- a/drivers/staging/wlan-ng/hfa384x.h
+++ b/drivers/staging/wlan-ng/hfa384x.h
@@ -1228,7 +1228,7 @@ struct hfa384x {
 	struct timer_list throttle;
 
 	struct work_struct reaper_bh;
-	struct tasklet_struct completion_bh;
+	struct work_struct completion_bh;
 
 	struct work_struct usb_work;
 
diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 4000c321cb3a..33844526c797 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -191,7 +191,7 @@ static void hfa384x_usbctlx_resptimerfn(struct timer_list *t);
 
 static void hfa384x_usb_throttlefn(struct timer_list *t);
 
-static void hfa384x_usbctlx_completion_task(struct tasklet_struct *t);
+static void hfa384x_usbctlx_completion_task(struct work_struct *work);
 
 static void hfa384x_usbctlx_reaper_task(struct work_struct *work);
 
@@ -540,7 +540,7 @@ void hfa384x_create(struct hfa384x *hw, struct usb_device *usb)
 	skb_queue_head_init(&hw->authq);
 
 	INIT_WORK(&hw->reaper_bh, hfa384x_usbctlx_reaper_task);
-	tasklet_setup(&hw->completion_bh, hfa384x_usbctlx_completion_task);
+	INIT_WORK(&hw->completion_bh, hfa384x_usbctlx_completion_task);
 	INIT_WORK(&hw->link_bh, prism2sta_processing_defer);
 	INIT_WORK(&hw->usb_work, hfa384x_usb_defer);
 
@@ -2585,10 +2585,10 @@ void hfa384x_tx_timeout(struct wlandevice *wlandev)
 /*----------------------------------------------------------------
  * hfa384x_usbctlx_reaper_task
  *
- * Deferred work to delete dead CTLX objects
+ * Deferred work callback to delete dead CTLX objects
  *
  * Arguments:
- *	data	ptr to a struct hfa384x
+ *	work	contains ptr to a struct hfa384x
  *
  * Returns:
  *
@@ -2618,21 +2618,21 @@ static void hfa384x_usbctlx_reaper_task(struct work_struct *work)
 /*----------------------------------------------------------------
  * hfa384x_usbctlx_completion_task
  *
- * Tasklet to call completion handlers for returned CTLXs
+ * Deferred work callback to call completion handlers for returned CTLXs
  *
  * Arguments:
- *	data	ptr to struct hfa384x
+ *	work	contains ptr to a struct hfa384x
  *
  * Returns:
  *	Nothing
  *
  * Call context:
- *	Interrupt
+ *      Task
  *----------------------------------------------------------------
  */
-static void hfa384x_usbctlx_completion_task(struct tasklet_struct *t)
+static void hfa384x_usbctlx_completion_task(struct work_struct *work)
 {
-	struct hfa384x *hw = from_tasklet(hw, t, completion_bh);
+	struct hfa384x *hw = container_of(work, struct hfa384x, reaper_bh);
 	struct hfa384x_usbctlx *ctlx, *temp;
 	unsigned long flags;
 
@@ -2743,7 +2743,7 @@ static int unlocked_usbctlx_cancel_async(struct hfa384x *hw,
  * aren't active and the timers should have been stopped.
  *
  * The CTLX is migrated to the "completing" queue, and the completing
- * tasklet is scheduled.
+ * work is scheduled.
  *
  * Arguments:
  *	hw		ptr to a struct hfa384x structure
@@ -2766,7 +2766,7 @@ static void unlocked_usbctlx_complete(struct hfa384x *hw,
 	 * queue.
 	 */
 	list_move_tail(&ctlx->list, &hw->ctlxq.completing);
-	tasklet_schedule(&hw->completion_bh);
+	schedule_work(&hw->completion_bh);
 
 	switch (ctlx->state) {
 	case CTLX_COMPLETE:
diff --git a/drivers/staging/wlan-ng/prism2usb.c b/drivers/staging/wlan-ng/prism2usb.c
index 36340f36b0cb..e13da7fadfff 100644
--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -165,8 +165,8 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		spin_unlock_irqrestore(&hw->ctlxq.lock, flags);
 
 		/* There's no hardware to shutdown, but the driver
-		 * might have some tasks or tasklets that must be
-		 * stopped before we can tear everything down.
+		 * might have some tasks that must be stopped before
+		 * we can tear everything down.
 		 */
 		prism2sta_ifstate(wlandev, P80211ENUM_ifstate_disable);
 
@@ -181,7 +181,7 @@ static void prism2sta_disconnect_usb(struct usb_interface *interface)
 		usb_kill_urb(&hw->tx_urb);
 		usb_kill_urb(&hw->ctlx_urb);
 
-		tasklet_kill(&hw->completion_bh);
+		cancel_work_sync(&hw->completion_bh);
 		cancel_work_sync(&hw->reaper_bh);
 
 		cancel_work_sync(&hw->link_bh);
-- 
2.26.2


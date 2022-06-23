Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286A5572C0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiFWF7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFWF7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:59:41 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 889B34475D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:59:37 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [106.117.82.161])
        by mail-app3 (Coremail) with SMTP id cC_KCgCHV8gwAbRiBPKyAA--.23207S2;
        Thu, 23 Jun 2022 13:59:20 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org
Cc:     davem@davemloft.net, alexander.deucher@amd.com, kuba@kernel.org,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] staging: rtl8192u: Fix sleep in atomic context bug in dm_fsync_timer_callback
Date:   Thu, 23 Jun 2022 13:59:12 +0800
Message-Id: <20220623055912.84138-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgCHV8gwAbRiBPKyAA--.23207S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF15Wr15trykGw1fAry5urg_yoW7Kry3p3
        ya9w1xAr4UZF4jk3WDAa1DZF1rK3ykGas3G3WkJw4FvrnavF1DXa4vyryUJFW5XrZ09w13
        Z348ZF43u3WDKr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUka14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GrWl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUP5rcUUUUU=
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgsKAVZdtaW8yQAKsm
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are sleep in atomic context bugs when dm_fsync_timer_callback is
executing. The root cause is that the memory allocation functions with
GFP_KERNEL or GFP_NOIO parameters are called in dm_fsync_timer_callback
which is a timer handler. The call paths that could trigger bugs are
shown below:

    (interrupt context)
dm_fsync_timer_callback
  write_nic_byte
    kzalloc(sizeof(data), GFP_KERNEL); //may sleep
    usb_control_msg
      kmalloc(.., GFP_NOIO); //may sleep
  write_nic_dword
    kzalloc(sizeof(data), GFP_KERNEL); //may sleep
    usb_control_msg
      kmalloc(.., GFP_NOIO); //may sleep

This patch uses delayed work to replace timer and moves the operations
that may sleep into the delayed work in order to mitigate bugs.

Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Use delayed work to replace timer.

 drivers/staging/rtl8192u/r8192U.h    |  2 +-
 drivers/staging/rtl8192u/r8192U_dm.c | 38 +++++++++++++---------------
 drivers/staging/rtl8192u/r8192U_dm.h |  2 +-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 14ca00a2789..1942cb84937 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -1013,7 +1013,7 @@ typedef struct r8192_priv {
 	bool		bis_any_nonbepkts;
 	bool		bcurrent_turbo_EDCA;
 	bool		bis_cur_rdlstate;
-	struct timer_list fsync_timer;
+	struct delayed_work fsync_work;
 	bool bfsync_processing;	/* 500ms Fsync timer is active or not */
 	u32	rate_record;
 	u32	rateCountDiffRecord;
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 725bf5ca9e3..0fcfcaa6500 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2578,19 +2578,20 @@ static void dm_init_fsync(struct net_device *dev)
 	priv->ieee80211->fsync_seconddiff_ratethreshold = 200;
 	priv->ieee80211->fsync_state = Default_Fsync;
 	priv->framesyncMonitor = 1;	/* current default 0xc38 monitor on */
-	timer_setup(&priv->fsync_timer, dm_fsync_timer_callback, 0);
+	INIT_DELAYED_WORK(&priv->fsync_work, dm_fsync_work_callback);
 }
 
 static void dm_deInit_fsync(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
-	del_timer_sync(&priv->fsync_timer);
+	cancel_delayed_work_sync(&priv->fsync_work);
 }
 
-void dm_fsync_timer_callback(struct timer_list *t)
+void dm_fsync_work_callback(struct work_struct *work)
 {
-	struct r8192_priv *priv = from_timer(priv, t, fsync_timer);
+	struct r8192_priv *priv =
+	    container_of(work, struct r8192_priv, fsync_work.work);
 	struct net_device *dev = priv->ieee80211->dev;
 	u32 rate_index, rate_count = 0, rate_count_diff = 0;
 	bool		bSwitchFromCountDiff = false;
@@ -2657,17 +2658,16 @@ void dm_fsync_timer_callback(struct timer_list *t)
 			}
 		}
 		if (bDoubleTimeInterval) {
-			if (timer_pending(&priv->fsync_timer))
-				del_timer_sync(&priv->fsync_timer);
-			priv->fsync_timer.expires = jiffies +
-				msecs_to_jiffies(priv->ieee80211->fsync_time_interval*priv->ieee80211->fsync_multiple_timeinterval);
-			add_timer(&priv->fsync_timer);
+			cancel_delayed_work_sync(&priv->fsync_work);
+			schedule_delayed_work(&priv->fsync_work,
+					      msecs_to_jiffies(priv
+					      ->ieee80211->fsync_time_interval *
+					      priv->ieee80211->fsync_multiple_timeinterval));
 		} else {
-			if (timer_pending(&priv->fsync_timer))
-				del_timer_sync(&priv->fsync_timer);
-			priv->fsync_timer.expires = jiffies +
-				msecs_to_jiffies(priv->ieee80211->fsync_time_interval);
-			add_timer(&priv->fsync_timer);
+			cancel_delayed_work_sync(&priv->fsync_work);
+			schedule_delayed_work(&priv->fsync_work,
+					      msecs_to_jiffies(priv
+					      ->ieee80211->fsync_time_interval));
 		}
 	} else {
 		/* Let Register return to default value; */
@@ -2695,7 +2695,7 @@ static void dm_EndSWFsync(struct net_device *dev)
 	struct r8192_priv *priv = ieee80211_priv(dev);
 
 	RT_TRACE(COMP_HALDM, "%s\n", __func__);
-	del_timer_sync(&(priv->fsync_timer));
+	cancel_delayed_work_sync(&priv->fsync_work);
 
 	/* Let Register return to default value; */
 	if (priv->bswitch_fsync) {
@@ -2736,11 +2736,9 @@ static void dm_StartSWFsync(struct net_device *dev)
 		if (priv->ieee80211->fsync_rate_bitmap &  rateBitmap)
 			priv->rate_record += priv->stats.received_rate_histogram[1][rateIndex];
 	}
-	if (timer_pending(&priv->fsync_timer))
-		del_timer_sync(&priv->fsync_timer);
-	priv->fsync_timer.expires = jiffies +
-			msecs_to_jiffies(priv->ieee80211->fsync_time_interval);
-	add_timer(&priv->fsync_timer);
+	cancel_delayed_work_sync(&priv->fsync_work);
+	schedule_delayed_work(&priv->fsync_work,
+			      msecs_to_jiffies(priv->ieee80211->fsync_time_interval));
 
 	write_nic_dword(dev, rOFDM0_RxDetector2, 0x465c12cd);
 }
diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 0b2a1c68859..2159018b4e3 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -166,7 +166,7 @@ void dm_force_tx_fw_info(struct net_device *dev,
 void dm_init_edca_turbo(struct net_device *dev);
 void dm_rf_operation_test_callback(unsigned long data);
 void dm_rf_pathcheck_workitemcallback(struct work_struct *work);
-void dm_fsync_timer_callback(struct timer_list *t);
+void dm_fsync_work_callback(struct work_struct *work);
 void dm_cck_txpower_adjust(struct net_device *dev, bool  binch14);
 void dm_shadow_init(struct net_device *dev);
 void dm_initialize_txpower_tracking(struct net_device *dev);
-- 
2.17.1


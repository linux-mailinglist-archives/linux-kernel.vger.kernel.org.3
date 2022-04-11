Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255D54FC02B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347759AbiDKPTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347734AbiDKPSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:53 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C88CB1DA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:39 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CB78F1201C0;
        Mon, 11 Apr 2022 15:16:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B7E4E122217;
        Mon, 11 Apr 2022 15:16:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690193; a=rsa-sha256;
        cv=none;
        b=X4rWZFVBMBfxg8Pn/oaJdQdhYLNjJtHEFSrhh/q73L4EXnnizdhAGmoRcEvImAf74qC5Bl
        wghtv0TNusA5hgwy1tIZq8dNslUd804sFGkajj55fGozcGT6Mb+baVdWgFVX57kQ6pxZUd
        mPgWbE/8AJXsQc0gpqEC/Fw4AkgOp+QXUt18h+nTLrAUZQ3/jau06oF6q+03MbHMFqSblt
        fX9FsGAi0rl6/REijWk+HNpdKUfNqwc8tbbIIHIf/IDzo4wtqZrsOT4KMcAd3EhOITJOHq
        cbXjcPkOVNY8BWKLiyByq7NNOm4NhBpYYjh9w89ryZJcnjt4wQjankbN4hqJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=glvS6H62LOxTf50dKKy8gsnW9R6qwIoCaN+LjX09TeE=;
        b=3M+RMLcD/3KPIj4MQ06hrgutOTGoFlP/1jlWUrVtwr955FGkNGZgF7/XYOlTfuoUwGhau6
        cQ5htMPxEZJfcv+VflxbP6ve/mbLFo7270xmuWxw5lJFQeoYQzww6GzURlk7cwSGSTKBaY
        ZOlvwhVkPrMETIy9etLHlAl2v5A+6VJBQ51T+FCJcpqs2jkDcjlSkuieNkRdZ4mmE0R7Vy
        QQZ71OXC7c68p5Dli3xncsSYgZbNUXIweUMvukmjx8+86ozN0rIj3oZFOFi+Oz3eW7nnex
        Beis4MCAuJCRpo9Vb5om4ICUjfVK9kZI64TwLxnmGPQxrOJkeXTEdmthVHloxA==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-89cjg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.54 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:35 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whistle-Attack: 599df652677b6d7b_1649690194051_3611693520
X-MC-Loop-Signature: 1649690194051:518113923
X-MC-Ingress-Time: 1649690194051
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWN4HHRz1f0;
        Mon, 11 Apr 2022 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690193;
        bh=glvS6H62LOxTf50dKKy8gsnW9R6qwIoCaN+LjX09TeE=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ieC7sQWunu4PHGVDWwKxxQ25telHBI6DA41iy98wOrVy1OaYcAWfw9gSMC+0Z6iOe
         ASxiojBJeh4WCydNEXZWRSYDgGkbjsMtI4CKozcj1V47jg0wsTr3DauCfE3pqXRBGU
         aozM4WzrGjC8o0GeGMyed5XBSSX6hXdSdPWM7KeH7catyWlZOgLGwCaVrdBosxZMk7
         t9LfYLJYp8X0+CbIZgTfLYl06NsZKUCDgJnqmqB1G5Gf1vQoj7aqNgpW7kdliNrdao
         5IkL0ajcI2kDR/n6X0sqbnRgZKn4GOUApvsYEVaO4jgOeFzZ272E6FJHgL5nLR6tIj
         SCZDo3kW/NZ0A==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 6/6] staging/rtl8192e,ieee80211: replace ps tasklet with work
Date:   Mon, 11 Apr 2022 08:16:20 -0700
Message-Id: <20220411151620.129178-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411151620.129178-1-dave@stgolabs.net>
References: <20220411151620.129178-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tasklets have long been deprecated as being too heavy on the system
by running in irq context - and this is not a performance critical
path. If a higher priority process wants to run, it must wait for
the tasklet to finish before doing so.

rtllib_sta_ps() and ieee80211_sta_ps() will now run in process context
and have further concurrency (tasklets being serialized among themselves),
but this is done holding the ieee->lock, so it should be fine.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/rtl8192e/rtllib.h                 |  2 +-
 drivers/staging/rtl8192e/rtllib_rx.c              |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c         | 12 ++++++++----
 drivers/staging/rtl8192u/ieee80211/ieee80211.h    |  2 +-
 .../rtl8192u/ieee80211/ieee80211_softmac.c        | 15 +++++++++------
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c985e4ebc545..0ecd81a81866 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1585,7 +1585,7 @@ struct rtllib_device {
 	short sta_sleep;
 	int ps_timeout;
 	int ps_period;
-	struct tasklet_struct ps_task;
+	struct work_struct ps_task;
 	u64 ps_time;
 	bool polling;
 
diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index eb904b42f9c6..f5a44bc6d4e4 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -2721,7 +2721,7 @@ static void rtllib_rx_mgt(struct rtllib_device *ieee,
 		if (ieee->sta_sleep || (ieee->ps != RTLLIB_PS_DISABLED &&
 		    ieee->iw_mode == IW_MODE_INFRA &&
 		    ieee->state == RTLLIB_LINKED))
-			tasklet_schedule(&ieee->ps_task);
+			schedule_work(&ieee->ps_task);
 
 		break;
 
diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 4b6c2295a3cf..82bf05eb1cbf 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2042,13 +2042,17 @@ static short rtllib_sta_ps_sleep(struct rtllib_device *ieee, u64 *time)
 
 }
 
-static inline void rtllib_sta_ps(struct tasklet_struct *t)
+static inline void rtllib_sta_ps(struct work_struct *work)
 {
-	struct rtllib_device *ieee = from_tasklet(ieee, t, ps_task);
+	struct rtllib_device *ieee;
 	u64 time;
 	short sleep;
 	unsigned long flags, flags2;
 
+	ieee = container_of(work, struct rtllib_device, ps_task);
+	if (!ieee)
+		return;
+
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	if ((ieee->ps == RTLLIB_PS_DISABLED ||
@@ -3028,7 +3032,7 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 	spin_lock_init(&ieee->mgmt_tx_lock);
 	spin_lock_init(&ieee->beacon_lock);
 
-	tasklet_setup(&ieee->ps_task, rtllib_sta_ps);
+	INIT_WORK(&ieee->ps_task, rtllib_sta_ps);
 
 	return 0;
 }
@@ -3050,8 +3054,8 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 	cancel_work_sync(&ieee->associate_complete_wq);
 	cancel_work_sync(&ieee->ips_leave_wq);
 	cancel_work_sync(&ieee->wx_sync_scan_wq);
+	cancel_work_sync(&ieee->ps_task);
 	mutex_unlock(&ieee->wx_mutex);
-	tasklet_kill(&ieee->ps_task);
 }
 
 static inline struct sk_buff *
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index 68c0bf9a191a..b577f9c81f85 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -1790,7 +1790,7 @@ struct ieee80211_device {
 	short sta_sleep;
 	int ps_timeout;
 	int ps_period;
-	struct tasklet_struct ps_task;
+	struct work_struct ps_task;
 	u32 ps_th;
 	u32 ps_tl;
 
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 1a43979939a8..4e8fbd2410a1 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1687,14 +1687,17 @@ static short ieee80211_sta_ps_sleep(struct ieee80211_device *ieee, u32 *time_h,
 	return 1;
 }
 
-static inline void ieee80211_sta_ps(struct tasklet_struct *t)
+static inline void ieee80211_sta_ps(struct work_struct *work)
 {
-	struct ieee80211_device *ieee = from_tasklet(ieee, t, ps_task);
+	struct ieee80211_device *ieee;
 	u32 th, tl;
 	short sleep;
-
 	unsigned long flags, flags2;
 
+	ieee = container_of(work, struct ieee80211_device, ps_task);
+	if (!ieee)
+		return;
+
 	spin_lock_irqsave(&ieee->lock, flags);
 
 	if ((ieee->ps == IEEE80211_PS_DISABLED ||
@@ -1897,7 +1900,7 @@ ieee80211_rx_frame_softmac(struct ieee80211_device *ieee, struct sk_buff *skb,
 	if (ieee->sta_sleep || (ieee->ps != IEEE80211_PS_DISABLED &&
 				ieee->iw_mode == IW_MODE_INFRA &&
 				ieee->state == IEEE80211_LINKED))
-		tasklet_schedule(&ieee->ps_task);
+		schedule_work(&ieee->ps_task);
 
 	if (WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_PROBE_RESP &&
 	    WLAN_FC_GET_STYPE(header->frame_ctl) != IEEE80211_STYPE_BEACON)
@@ -2602,7 +2605,7 @@ void ieee80211_softmac_init(struct ieee80211_device *ieee)
 	spin_lock_init(&ieee->mgmt_tx_lock);
 	spin_lock_init(&ieee->beacon_lock);
 
-	tasklet_setup(&ieee->ps_task, ieee80211_sta_ps);
+	INIT_WORK(&ieee->ps_task, ieee80211_sta_ps);
 }
 
 void ieee80211_softmac_free(struct ieee80211_device *ieee)
@@ -2613,7 +2616,7 @@ void ieee80211_softmac_free(struct ieee80211_device *ieee)
 	del_timer_sync(&ieee->associate_timer);
 
 	cancel_delayed_work(&ieee->associate_retry_wq);
-
+	cancel_work_sync(&ieee->ps_task);
 	mutex_unlock(&ieee->wx_mutex);
 }
 
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F36E4757A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236993AbhLOLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 06:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbhLOLS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 06:18:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EACC061574;
        Wed, 15 Dec 2021 03:18:56 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id i63so32790480lji.3;
        Wed, 15 Dec 2021 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFWfeevTa7CdrnyD5XW53LU9ZJeNJmiufxH04mm98PA=;
        b=pNEF0X34RlSq8GfUyJ39VPds2Ixzn5FStJmIop/AzKIxKBB4ufecMIiAiai+EBZcm5
         /J/6LUX61XTG4ouX1WwCgTV0QA8Wq8Dm5ne/NaYiKK7Au1WSbCOYqyldw7yixfOn6+N6
         8oAVKZ5/O9LNYLCEfLPXwH+sjJY4n8tLdWMaHwD7bSNggyjtUwnkbDwHch+pmqyTv2Eq
         Ff1OKOqPcP/z6TK04I0vn5VauoI4qdWrgkRX35hWESfG1CZiLMFkixTFb2wd5LQzPrLN
         6fygCq9Edvr6XZSqoHN3TIQApUJCPQ8DGmLBNfaX8fbpDw+DHimg/zz0gsp6wb+nZxzk
         dczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JFWfeevTa7CdrnyD5XW53LU9ZJeNJmiufxH04mm98PA=;
        b=L0AirUX78USAaD3rGv1ruC1lR99WK/Nv0qHUo6F5oJAfv39dHm8rIsfVmvoxEAErDf
         Flu0gauvw7/piRRo+Ttc2GqNSwHTswq8SOx/YW7i7CuXx3hUKGBX+7p7hCS3S7i9dYG2
         JF9R7vyYQm6Nkii4wK4sm/ijP4uJY8Am/66KLSPYrkczeXjKMThyJ8YYAHcwYWKyuS06
         Us5Xb3D0+kJA1NF9av/ty5gpZiFrBSXqRVkKm6vSAI3sctCVjjqRq5M3VLHy7gFFBf3B
         ywdFdPUJixoU/sHfnrncVDx1jQhZxA+Di2GYDwBx3hk9SiAS3TGmnm0GZPS+2jUKoftq
         NOZA==
X-Gm-Message-State: AOAM533PUtBCISI1go0gOV/x4mP6M0LxPttDIxfYPBJAHSy2JlfT4y2q
        vkRC41AT5FxRLw8Cj3SO8+Nf2l5u7nJmJuo5
X-Google-Smtp-Source: ABdhPJxoUTvNToOsgLSqFiP9ArAxNu+GLzgTv2e86d7hOZ9CvBMwZ7st7mNSbyo1dVJSn612xZ6NPg==
X-Received: by 2002:a2e:3012:: with SMTP id w18mr9453431ljw.344.1639567134417;
        Wed, 15 Dec 2021 03:18:54 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id n17sm383906ljg.128.2021.12.15.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 03:18:53 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: [PATCH] drdb: Switch to kvfree_rcu() API
Date:   Wed, 15 Dec 2021 12:18:37 +0100
Message-Id: <20211215111845.2514-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of invoking a synchronize_rcu() to free a pointer
after a grace period we can directly make use of new API
that does the same but in more efficient way.

TO: Jens Axboe <axboe@kernel.dk>
TO: Philipp Reisner <philipp.reisner@linbit.com>
TO: Jason Gunthorpe <jgg@nvidia.com>
TO: drbd-dev@lists.linbit.com
TO: linux-block@vger.kernel.org
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 drivers/block/drbd/drbd_nl.c       | 9 +++------
 drivers/block/drbd/drbd_receiver.c | 6 ++----
 drivers/block/drbd/drbd_state.c    | 3 +--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 44ccf8b4f4b2..28f4d84945fd 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1679,8 +1679,7 @@ int drbd_adm_disk_opts(struct sk_buff *skb, struct genl_info *info)
 			drbd_send_sync_param(peer_device);
 	}
 
-	synchronize_rcu();
-	kfree(old_disk_conf);
+	kvfree_rcu(old_disk_conf);
 	kfree(old_plan);
 	mod_timer(&device->request_timer, jiffies + HZ);
 	goto success;
@@ -2511,8 +2510,7 @@ int drbd_adm_net_opts(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_unlock(&connection->resource->conf_update);
 	mutex_unlock(&connection->data.mutex);
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 
 	if (connection->cstate >= C_WF_REPORT_PARAMS) {
 		struct drbd_peer_device *peer_device;
@@ -2925,8 +2923,7 @@ int drbd_adm_resize(struct sk_buff *skb, struct genl_info *info)
 		new_disk_conf->disk_size = (sector_t)rs.resize_size;
 		rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 		mutex_unlock(&device->resource->conf_update);
-		synchronize_rcu();
-		kfree(old_disk_conf);
+		kvfree_rcu(old_disk_conf);
 		new_disk_conf = NULL;
 	}
 
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 1f740e42e457..d73a53242a75 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -3799,8 +3799,7 @@ static int receive_protocol(struct drbd_connection *connection, struct packet_in
 		drbd_info(connection, "peer data-integrity-alg: %s\n",
 			  integrity_alg[0] ? integrity_alg : "(none)");
 
-	synchronize_rcu();
-	kfree(old_net_conf);
+	kvfree_rcu(old_net_conf);
 	return 0;
 
 disconnect_rcu_unlock:
@@ -4168,8 +4167,7 @@ static int receive_sizes(struct drbd_connection *connection, struct packet_info
 
 			rcu_assign_pointer(device->ldev->disk_conf, new_disk_conf);
 			mutex_unlock(&connection->resource->conf_update);
-			synchronize_rcu();
-			kfree(old_disk_conf);
+			kvfree_rcu(old_disk_conf);
 
 			drbd_info(device, "Peer sets u_size to %lu sectors (old: %lu)\n",
 				 (unsigned long)p_usize, (unsigned long)my_usize);
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index b8a27818ab3f..826e496821c7 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -2071,8 +2071,7 @@ static int w_after_conn_state_ch(struct drbd_work *w, int unused)
 		conn_free_crypto(connection);
 		mutex_unlock(&connection->resource->conf_update);
 
-		synchronize_rcu();
-		kfree(old_conf);
+		kvfree_rcu(old_conf);
 	}
 
 	if (ns_max.susp_fen) {
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F794D9634
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbiCOIb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345825AbiCOIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:31:22 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3154BFF3;
        Tue, 15 Mar 2022 01:30:07 -0700 (PDT)
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 01:30:07 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 01:30:05 -0700
X-QCInternal: smtphost
Received: from unknown (HELO youghand-linux.qualcomm.com) ([10.206.66.115])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 Mar 2022 13:59:56 +0530
Received: by youghand-linux.qualcomm.com (Postfix, from userid 2370257)
        id B717F227E3; Tue, 15 Mar 2022 13:59:54 +0530 (IST)
From:   Youghandhar Chintala <youghand@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        pillair@codeaurora.org, dianders@chromium.org, kuabhs@chromium.org,
        briannorris@chromium.org, mpubbise@codeaurora.org,
        Youghandhar Chintala <youghand@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] mac80211: Add support to trigger sta disconnect on  hardware restart
Date:   Tue, 15 Mar 2022 13:59:43 +0530
Message-Id: <20220315082944.12406-2-youghand@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220315082944.12406-1-youghand@codeaurora.org>
References: <20220315082944.12406-1-youghand@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently in case of target hardware restart, we just reconfig and
re-enable the security keys and enable the network queues to start
data traffic back from where it was interrupted.

Many ath10k wifi chipsets have sequence numbers for the data
packets assigned by firmware and the mac sequence number will
restart from zero after target hardware restart leading to mismatch
in the sequence number expected by the remote peer vs the sequence
number of the frame sent by the target firmware.

This mismatch in sequence number will cause out-of-order packets
on the remote peer and all the frames sent by the device are dropped
until we reach the sequence number which was sent before we restarted
the target hardware

In order to fix this, we trigger a sta disconnect, in case of target
hw restart. After this there will be a fresh connection and thereby
avoiding the dropping of frames by remote peer.

The right fix would be to pull the entire data path into the host
which is not feasible or would need lots of complex changes and
will still be inefficient.

Tested on ath10k using WCN3990, QCA6174

Reviewed-by: Brian Norris <briannorris@chromium.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Youghandhar Chintala <youghand@codeaurora.org>
---
 include/net/mac80211.h     | 10 ++++++++++
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/mlme.c        | 14 +++++++++++++-
 net/mac80211/util.c        | 33 ++++++++++++++++++++++++++++++---
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index bd6912d0292b..2f9236e8e33d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6064,6 +6064,16 @@ void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect);
  */
 void ieee80211_resume_disconnect(struct ieee80211_vif *vif);
 
+/**
+ * ieee80211_hw_restart_disconnect - disconnect from AP after
+ * hardware restart
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ *
+ * Instructs mac80211 to disconnect from the AP after
+ * hardware restart.
+ */
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif);
+
 /**
  * ieee80211_cqm_rssi_notify - inform a configured connection quality monitoring
  *	rssi threshold triggered
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index da35791b8378..7819cdf7ddfa 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -765,6 +765,8 @@ struct ieee80211_if_mesh {
  *	back to wireless media and to the local net stack.
  * @IEEE80211_SDATA_DISCONNECT_RESUME: Disconnect after resume.
  * @IEEE80211_SDATA_IN_DRIVER: indicates interface was added to driver
+ * @IEEE80211_SDATA_DISCONNECT_HW_RESTART: Disconnect after hardware restart
+ *  recovery
  */
 enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_ALLMULTI		= BIT(0),
@@ -772,6 +774,7 @@ enum ieee80211_sub_if_data_flags {
 	IEEE80211_SDATA_DONT_BRIDGE_PACKETS	= BIT(3),
 	IEEE80211_SDATA_DISCONNECT_RESUME	= BIT(4),
 	IEEE80211_SDATA_IN_DRIVER		= BIT(5),
+	IEEE80211_SDATA_DISCONNECT_HW_RESTART	= BIT(6),
 };
 
 /**
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 20b57ddf149c..182a5d477c43 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -4842,6 +4842,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 
 	sdata_unlock(sdata);
 }
+#endif
 
 void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 {
@@ -4863,9 +4864,20 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		sdata_unlock(sdata);
 		return;
 	}
+
+	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_HW_RESTART) {
+		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_HW_RESTART;
+		mlme_dbg(sdata, "driver requested disconnect after hardware restart\n");
+		ieee80211_sta_connection_lost(sdata,
+					      ifmgd->associated->bssid,
+					      WLAN_REASON_UNSPECIFIED,
+					      true);
+		sdata_unlock(sdata);
+		return;
+	}
+
 	sdata_unlock(sdata);
 }
-#endif
 
 /* interface setup */
 void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index abc29df6834c..4b791f94751f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2321,6 +2321,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	struct cfg80211_sched_scan_request *sched_scan_req;
 	bool sched_scan_stopped = false;
 	bool suspended = local->suspended;
+	bool in_reconfig = false;
 
 	/* nothing to do if HW shouldn't run */
 	if (!local->open_count)
@@ -2672,6 +2673,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		drv_reconfig_complete(local, IEEE80211_RECONFIG_TYPE_RESTART);
 
 	if (local->in_reconfig) {
+		in_reconfig = local->in_reconfig;
 		local->in_reconfig = false;
 		barrier();
 
@@ -2689,6 +2691,15 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 					IEEE80211_QUEUE_STOP_REASON_SUSPEND,
 					false);
 
+	if (in_reconfig) {
+		list_for_each_entry(sdata, &local->interfaces, list) {
+			if (!ieee80211_sdata_running(sdata))
+				continue;
+			if (sdata->vif.type == NL80211_IFTYPE_STATION)
+				ieee80211_sta_restart(sdata);
+		}
+	}
+
 	if (!suspended)
 		return 0;
 
@@ -2718,7 +2729,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	return 0;
 }
 
-void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+static void ieee80211_reconfig_disconnect(struct ieee80211_vif *vif, u8 flag)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_local *local;
@@ -2730,19 +2741,35 @@ void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
 	sdata = vif_to_sdata(vif);
 	local = sdata->local;
 
-	if (WARN_ON(!local->resuming))
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_RESUME &&
+		    !local->resuming))
+		return;
+
+	if (WARN_ON(flag & IEEE80211_SDATA_DISCONNECT_HW_RESTART &&
+		    !local->in_reconfig))
 		return;
 
 	if (WARN_ON(vif->type != NL80211_IFTYPE_STATION))
 		return;
 
-	sdata->flags |= IEEE80211_SDATA_DISCONNECT_RESUME;
+	sdata->flags |= flag;
 
 	mutex_lock(&local->key_mtx);
 	list_for_each_entry(key, &sdata->key_list, list)
 		key->flags |= KEY_FLAG_TAINTED;
 	mutex_unlock(&local->key_mtx);
 }
+
+void ieee80211_hw_restart_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_HW_RESTART);
+}
+EXPORT_SYMBOL_GPL(ieee80211_hw_restart_disconnect);
+
+void ieee80211_resume_disconnect(struct ieee80211_vif *vif)
+{
+	ieee80211_reconfig_disconnect(vif, IEEE80211_SDATA_DISCONNECT_RESUME);
+}
 EXPORT_SYMBOL_GPL(ieee80211_resume_disconnect);
 
 void ieee80211_recalc_smps(struct ieee80211_sub_if_data *sdata)
-- 
2.29.0


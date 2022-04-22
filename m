Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7400650B71D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447341AbiDVMVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447285AbiDVMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:21:01 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9798455222
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:18:06 -0700 (PDT)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220422121802epoutp02408d5bc9707ddec6a40789b8b6f11607~oNyH677an3046530465epoutp02c
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:18:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220422121802epoutp02408d5bc9707ddec6a40789b8b6f11607~oNyH677an3046530465epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650629882;
        bh=rsCa61hE44w6ByVM4dSvf0XuZA9wqQ14iNuB+xJ97hw=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=MLVyh0YmvTolpReXn1xBKd6LB1yKOCypS9fRZhKgUBaXoIRxIWGLHjt71D1azCODo
         NwNaWP3xFxA5zpi1n/hhOGWZW0qFfaEEEJVURyRoMeZTIHVmGQic0z+fcWtIX27Rih
         FwvF5niS2KVnAaHNDyHD6daaTGzkqp4Xxcxrjv6w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p4.samsung.com (KnoxPortal) with ESMTP id
        20220422121801epcas3p47414609a6d991cb91e0e4cfd8c4bcf65~oNyGvpFbN1864618646epcas3p4M;
        Fri, 22 Apr 2022 12:18:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4KlD2K1X5tz4x9Q5; Fri, 22 Apr 2022 12:18:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle
 functions
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01650629881201.JavaMail.epsvc@epcpadp4>
Date:   Fri, 22 Apr 2022 21:14:52 +0900
X-CMS-MailID: 20220422121452epcms2p19528693c66f4c2afaf685e30b2d27e10
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2
References: <CGME20220422120240epcms2p24bdcb416becf76b417f7c39006aa40f2@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the following quirk to bypass "WB Manual Flush" in Write
Booster.

  - UFSHCD_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

If this quirk is not set, there is no knob that can controll "WB Manual Flush".

	There are three flags that control Write Booster Feature.
		1. WB ON/OFF
		2. WB Hibern Flush ON/OFF
		3. WB Flush ON/OFF

	The sysfs that controls the WB was implemented. (1)

	In the case of "Hibern Flush", it is always good to turn on.
	Control may not be required. (2)

	Finally, "Manual flush" may be determined that it can affect
	performance or power consumption.
	So the sysfs that controls this may be necessary. (3)

In addition, toggle functions for controlling the above flags are cleaned.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/ufs/ufs-sysfs.c | 46 ++++++++++++++++++-
 drivers/scsi/ufs/ufs.h       |  2 +-
 drivers/scsi/ufs/ufshcd.c    | 86 +++++++++++++++++-------------------
 drivers/scsi/ufs/ufshcd.h    |  7 +++
 4 files changed, 94 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 5c405ff7b6ea..6bbb56152708 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -229,7 +229,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
 		 * on/off will be done while clock scaling up/down.
 		 */
-		dev_warn(dev, "To control WB through wb_on is not allowed!\n");
+		dev_warn(dev, "To control Write Booster is not allowed!\n");
 		return -EOPNOTSUPP;
 	}
 
@@ -253,6 +253,48 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t wb_flush_on_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.wb_flush_enabled);
+}
+
+static ssize_t wb_flush_on_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_flush_enable;
+	ssize_t res;
+
+	if (!ufshcd_is_wb_flush_allowed(hba)) {
+		dev_warn(dev, "To control WB Flush is not allowed!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtouint(buf, 0, &wb_flush_enable))
+		return -EINVAL;
+
+	if (wb_flush_enable != 0 && wb_flush_enable != 1)
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		res = -EBUSY;
+		goto out;
+	}
+
+	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_wb_toggle_flush(hba, wb_flush_enable);
+	ufshcd_rpm_put_sync(hba);
+out:
+	up(&hba->host_sem);
+	return res < 0 ? res : count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -261,6 +303,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RW(wb_flush_on);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -271,6 +314,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_wb_flush_on.attr,
 	NULL
 };
 
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 4a00c24a3209..6c85f512f82f 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -611,7 +611,7 @@ struct ufs_dev_info {
 
 	/* UFS WB related flags */
 	bool    wb_enabled;
-	bool    wb_buf_flush_enabled;
+	bool    wb_flush_enabled;
 	u8	wb_dedicated_lu;
 	u8      wb_buffer_type;
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3f9caafa91bf..7bd510582471 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -249,7 +249,6 @@ static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
@@ -269,7 +268,7 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 	}
 }
 
-static inline void ufshcd_wb_config(struct ufs_hba *hba)
+static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
 {
 	if (!ufshcd_is_wb_allowed(hba))
 		return;
@@ -277,7 +276,7 @@ static inline void ufshcd_wb_config(struct ufs_hba *hba)
 	ufshcd_wb_toggle(hba, true);
 
 	ufshcd_wb_toggle_flush_during_h8(hba, true);
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+	if (ufshcd_is_wb_flush_allowed(hba))
 		ufshcd_wb_toggle_flush(hba, true);
 }
 
@@ -608,7 +607,7 @@ static void ufshcd_device_reset(struct ufs_hba *hba)
 		ufshcd_set_ufs_dev_active(hba);
 		if (ufshcd_is_wb_allowed(hba)) {
 			hba->dev_info.wb_enabled = false;
-			hba->dev_info.wb_buf_flush_enabled = false;
+			hba->dev_info.wb_flush_enabled = false;
 		}
 	}
 	if (err != -EOPNOTSUPP)
@@ -5689,74 +5688,70 @@ static void ufshcd_temp_exception_event_handler(struct ufs_hba *hba, u16 status)
 	 */
 }
 
-static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
+static int __ufshcd_wb_toggle(struct ufs_hba *hba, const char *knob,
+			      bool set, enum flag_idn idn)
 {
+	int ret;
 	u8 index;
 	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
-				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
+		UPIU_QUERY_OPCODE_CLEAR_FLAG;
+
+	if (!ufshcd_is_wb_allowed(hba))
+		return -EPERM;
 
 	index = ufshcd_wb_get_query_index(hba);
-	return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
+
+	ret = ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
+	if (ret) {
+		dev_err(hba->dev, "%s: %s %s failed %d\n",
+			__func__, knob, set ? "enable" : "disable", ret);
+		return ret;
+	}
+
+	dev_dbg(hba->dev, "%s: %s %s\n",
+		 __func__, knob, set ? "enabled" : "disabled");
+
+	return ret;
 }
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba))
+	if (hba->dev_info.wb_enabled == enable)
 		return 0;
 
-	if (!(enable ^ hba->dev_info.wb_enabled))
-		return 0;
-
-	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
-	if (ret) {
-		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
-			__func__, enable ? "enable" : "disable", ret);
+	ret = __ufshcd_wb_toggle(hba, "Write Booster", enable,
+				 QUERY_FLAG_IDN_WB_EN);
+	if (ret)
 		return ret;
-	}
 
 	hba->dev_info.wb_enabled = enable;
-	dev_info(hba->dev, "%s Write Booster %s\n",
-			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
 }
 
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set)
+static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool enable)
 {
-	int ret;
-
-	ret = __ufshcd_wb_toggle(hba, set,
-			QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
-	if (ret) {
-		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
-			__func__, set ? "enable" : "disable", ret);
-		return;
-	}
-	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
-			__func__, set ? "enabled" : "disabled");
+	__ufshcd_wb_toggle(hba, "WB-Buf Flush during H8", enable,
+			   QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
 }
 
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
+int ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    hba->dev_info.wb_buf_flush_enabled == enable)
-		return;
+	if (hba->dev_info.wb_flush_enabled == enable)
+		return 0;
 
-	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
-	if (ret) {
-		dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
-			enable ? "enable" : "disable", ret);
-		return;
-	}
+	ret = __ufshcd_wb_toggle(hba, "WB-Buf Flush", enable,
+				 QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
+	if (ret)
+		return ret;
 
-	hba->dev_info.wb_buf_flush_enabled = enable;
+	hba->dev_info.wb_flush_enabled = enable;
 
-	dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
-			__func__, enable ? "enabled" : "disabled");
+	return ret;
 }
 
 static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
@@ -5790,7 +5785,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+	if (ufshcd_is_wb_flush_allowed(hba))
 		ufshcd_wb_toggle_flush(hba, false);
 
 	ufshcd_wb_toggle_flush_during_h8(hba, false);
@@ -8178,7 +8173,8 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 */
 	ufshcd_set_active_icc_lvl(hba);
 
-	ufshcd_wb_config(hba);
+	ufshcd_wb_set_default_flags(hba);
+
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 94f545be183a..abd2be248dc5 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -991,6 +991,12 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
+static inline bool ufshcd_is_wb_flush_allowed(struct ufs_hba *hba)
+{
+	return ufshcd_is_wb_allowed(hba) &&
+		!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
+}
+
 static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
 {
 	return !hba->shutting_down;
@@ -1209,6 +1215,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     enum query_opcode desc_op);
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
-- 
2.25.1

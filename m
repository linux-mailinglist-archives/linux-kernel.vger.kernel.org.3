Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1883C562CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiGAHrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiGAHrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:47:01 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8F053EC0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:47:00 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220701074655epoutp022ba45f282b73086d60326fec2b91fa8c~9pPZCsdyZ1343213432epoutp02M
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:46:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220701074655epoutp022ba45f282b73086d60326fec2b91fa8c~9pPZCsdyZ1343213432epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656661615;
        bh=li0Fm7jz9++tP4h0OZi8Lif529Oa18Wa4gYGeXZesVw=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=YhJIRcLGxoNt4m9M/O0vVYPv0b0z8ZgWWQa8sOgzN96xSJ7er9Jto6KA8kpIxoLe8
         f69iSWch4f+iawo4J5vvulFgyeXk1vx5cZpe68Hv22nQnK74pNYcuW9JSdVr1WlNf3
         Sv+K1KNdJkQy3kVPRIfVWUy9U4kPeLmUqKQ7Rww8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220701074655epcas2p3e7054afe48c45b02a4e82c93b4569431~9pPYoLr-j2225622256epcas2p3A;
        Fri,  1 Jul 2022 07:46:55 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.98]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LZ6jB3cWPz4x9Q0; Fri,  1 Jul
        2022 07:46:54 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-30-62bea66ec42d
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.92.09650.E66AEB26; Fri,  1 Jul 2022 16:46:54 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 1/2] scsi: ufs: wb: renaming & cleanups functions
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220701074654epcms2p5fcc0a8abe766fa00851b00dff98ad3c7@epcms2p5>
Date:   Fri, 01 Jul 2022 16:46:54 +0900
X-CMS-MailID: 20220701074654epcms2p5fcc0a8abe766fa00851b00dff98ad3c7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmmW7esn1JBr92SFmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZE29tYi+YaF2xbsJ9lgbGTsMuRk4O
        CQETiV071zB2MXJxCAnsYJQ48HgekMPBwSsgKPF3hzBIjbCAi8S/zl3sILaQgJLEuTWzwEqE
        BQwkbvWag4TZBPQkfi6ZwQYyRkTgLLPEwodTmCDm80rMaH/KAmFLS2xfvpURxOYU8JM4P2kN
        I0RcQ+LHsl5mCFtU4ubqt+ww9vtj86FqRCRa752FqhGUePBzN1RcUuLQoa9sIPdICORLbDgQ
        CBGukXi7/ABUib7EtY6NYCfwCvhKvGjaAhZnEVCV+Dv5BStEjYvE6o/XwE5mFpCX2P52DjPI
        SGYBTYn1u/QhpitLHLnFAvNUw8bf7OhsZgE+iY7Df+HiO+Y9YYJoVZNY1GQEEZaR+Hp4PvsE
        RqVZiFCehWTtLIS1CxiZVzGKpRYU56anFhsVGMEjNjk/dxMjOKVque1gnPL2g94hRiYOxkOM
        EhzMSiK8bPP2JgnxpiRWVqUW5ccXleakFh9iNAV6eCKzlGhyPjCp55XEG5pYGpiYmRmaG5ka
        mCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi4JRqYEp597DoqGTvsvnbneSuJrnPqTi+XK1P7I31
        q2tTF/1mZbLNfHQl+1LzxeXddmF65jN3dH/gPDjvj+fTaT4FxbaVpjKGuZN+OLw+/MIwNDRt
        0qkHm94fucLO8LmqeYZi7+VpT3dc4vv9Vcngl9geiYNclhmyvren/wxedyNWWp/9xI8PrM7W
        LTw71bIYm/r5owxW6uQXaNpk7fee197HIePHdzS5r/QtX6n0GceVMVYKiUdZTaTfJuSFPr7K
        4xee9u7Ri2k3T6gUmJeXTZo9ge3DXJG7z/U7hHcGaW5zzuD99ss1IU34kEXyms0Vj9T6BNz2
        uFnIOK/mX//Vb1L8it/bN669UJpQkHNiwdKLhkosxRmJhlrMRcWJAJNAkJ8yBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95
References: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
        <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p5>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Function names were changed clearly, and the location of the
comments was modified and added properly.

In addition, the conditional test of the toggle functions was
different, so it was modified.

Unnecessary logs were removed and modified appropriately.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c |  2 +-
 drivers/ufs/core/ufshcd.c    | 69 +++++++++++++++++-------------------
 include/ufs/ufshcd.h         |  7 ++++
 3 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..6253606b93b4 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -230,7 +230,7 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 		 * If the platform supports UFSHCD_CAP_CLK_SCALING, turn WB
 		 * on/off will be done while clock scaling up/down.
 		 */
-		dev_warn(dev, "To control WB through wb_on is not allowed!\n");
+		dev_warn(dev, "It is not allowed to control WB!\n");
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 1d3214e6b364..f98d023e44ae 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -268,8 +268,7 @@ static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
 static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 					 struct ufs_vreg *vreg);
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set);
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable);
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba, bool set);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
@@ -289,16 +288,16 @@ static inline void ufshcd_disable_irq(struct ufs_hba *hba)
 	}
 }
 
-static inline void ufshcd_wb_config(struct ufs_hba *hba)
+static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
 {
 	if (!ufshcd_is_wb_allowed(hba))
 		return;
 
 	ufshcd_wb_toggle(hba, true);
+	ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
 
-	ufshcd_wb_toggle_flush_during_h8(hba, true);
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
-		ufshcd_wb_toggle_flush(hba, true);
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
+		ufshcd_wb_toggle_buf_flush(hba, true);
 }
 
 static void ufshcd_scsi_unblock_requests(struct ufs_hba *hba)
@@ -1289,9 +1288,10 @@ static int ufshcd_devfreq_scale(struct ufs_hba *hba, bool scale_up)
 		}
 	}
 
-	/* Enable Write Booster if we have scaled up else disable it */
 	downgrade_write(&hba->clk_scaling_lock);
 	is_writelock = false;
+
+	/* Enable Write Booster if we have scaled up else disable it */
 	ufshcd_wb_toggle(hba, scale_up);
 
 out_unprepare:
@@ -5715,6 +5715,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
 	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
 				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
 
+	if (!ufshcd_is_wb_allowed(hba))
+		return -EPERM;
+
 	index = ufshcd_wb_get_query_index(hba);
 	return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
 }
@@ -5723,60 +5726,50 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba))
-		return 0;
-
-	if (!(enable ^ hba->dev_info.wb_enabled))
+	if (hba->dev_info.wb_enabled == enable)
 		return 0;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_EN);
 	if (ret) {
-		dev_err(hba->dev, "%s Write Booster %s failed %d\n",
+		dev_err(hba->dev, "%s: failed to %s WB %d\n",
 			__func__, enable ? "enable" : "disable", ret);
 		return ret;
 	}
 
 	hba->dev_info.wb_enabled = enable;
-	dev_info(hba->dev, "%s Write Booster %s\n",
-			__func__, enable ? "enabled" : "disabled");
 
 	return ret;
 }
 
-static void ufshcd_wb_toggle_flush_during_h8(struct ufs_hba *hba, bool set)
+static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
+						 bool enable)
 {
 	int ret;
 
-	ret = __ufshcd_wb_toggle(hba, set,
-			QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
-	if (ret) {
-		dev_err(hba->dev, "%s: WB-Buf Flush during H8 %s failed: %d\n",
-			__func__, set ? "enable" : "disable", ret);
-		return;
-	}
-	dev_dbg(hba->dev, "%s WB-Buf Flush during H8 %s\n",
-			__func__, set ? "enabled" : "disabled");
+	ret = __ufshcd_wb_toggle(hba, enable,
+				 QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8);
+	if (ret)
+		dev_err(hba->dev, "%s: failed to %s WB buf flush during H8 %d\n",
+			__func__, enable ? "enable" : "disable", ret);
 }
 
-static inline void ufshcd_wb_toggle_flush(struct ufs_hba *hba, bool enable)
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    hba->dev_info.wb_buf_flush_enabled == enable)
-		return;
+	if (hba->dev_info.wb_buf_flush_enabled == enable)
+		return 0;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
 	if (ret) {
-		dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
-			enable ? "enable" : "disable", ret);
-		return;
+		dev_err(hba->dev, "%s: failed to %s WB buf flush %d\n",
+			__func__, enable ? "enable" : "disable", ret);
+		return ret;
 	}
 
 	hba->dev_info.wb_buf_flush_enabled = enable;
 
-	dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
-			__func__, enable ? "enabled" : "disabled");
+	return ret;
 }
 
 static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
@@ -5807,10 +5800,10 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
-		ufshcd_wb_toggle_flush(hba, false);
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
+		ufshcd_wb_toggle_buf_flush(hba, false);
 
-	ufshcd_wb_toggle_flush_during_h8(hba, false);
+	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
 	ufshcd_wb_toggle(hba, false);
 	hba->caps &= ~UFSHCD_CAP_WB_EN;
 
@@ -8197,7 +8190,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	 */
 	ufshcd_set_active_icc_lvl(hba);
 
-	ufshcd_wb_config(hba);
+	/* Enable UFS Write Booster if supported */
+	ufshcd_wb_set_default_flags(hba);
+
 	if (hba->ee_usr_mask)
 		ufshcd_write_ee_control(hba);
 	/* Enable Auto-Hibernate if configured */
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a926cd99..78adc556444a 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1017,6 +1017,12 @@ static inline bool ufshcd_is_wb_allowed(struct ufs_hba *hba)
 	return hba->caps & UFSHCD_CAP_WB_EN;
 }
 
+static inline bool ufshcd_is_wb_buf_flush_allowed(struct ufs_hba *hba)
+{
+	return ufshcd_is_wb_allowed(hba) &&
+		!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
+}
+
 #define ufshcd_writel(hba, val, reg)	\
 	writel((val), (hba)->mmio_base + (reg))
 #define ufshcd_readl(hba, reg)	\
@@ -1211,6 +1217,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     enum query_opcode desc_op);
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
-- 
2.25.1

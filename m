Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585E95593B8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 08:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiFXGsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 02:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFXGso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 02:48:44 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05F4DF70
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 23:48:41 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220624064838epoutp045e8daef6ae1803678470cc5e1cfc09d4~7e7gZrZLa1351013510epoutp04B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:48:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220624064838epoutp045e8daef6ae1803678470cc5e1cfc09d4~7e7gZrZLa1351013510epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656053318;
        bh=9FoUPkEwHiudPdR4HoXMM3C6AwVfUb8mHuNiKPJapog=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=FTqhLetZr0xGew7nwJ337+dRdaz7JEQ/6kT8yoh29qXe9ebcultCUNCOkClD5cBd7
         PCv9z+4Yn9zK8qseleXwJKKKhxJnwLw7IiWz01Jzu7nP81Hym5RiVp+W4ekKefQeIO
         7F5wiTrCKN4P/9pxl6nUuMRO1UdOI3nxm8oizQtA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220624064838epcas2p3504427893ac1272a504f7d78f9c24f41~7e7f2f5NJ1745717457epcas2p31;
        Fri, 24 Jun 2022 06:48:38 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LTnl94y1Kz4x9Q7; Fri, 24 Jun
        2022 06:48:37 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-1b-62b55e45e2a1
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.F4.09650.54E55B26; Fri, 24 Jun 2022 15:48:37 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] scsi: ufs: wb: Add Manual Flush sysfs and cleanup toggle
 functions
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
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220624064837epcms2p8f8589cd0fe02ae50cb4d81538c629363@epcms2p8>
Date:   Fri, 24 Jun 2022 15:48:37 +0900
X-CMS-MailID: 20220624064837epcms2p8f8589cd0fe02ae50cb4d81538c629363
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmua5r3NYkg1935C1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtHt1+xmjR27+VzWLRjW1MFpd3zWGz6L6+g81i+fF/TA48
        HpeveHss3vOSyWPCogOMHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q82g90MwVwRGXbZKQmpqQWKaTm
        JeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAdq6RQlphTChQKSCwuVtK3
        synKLy1JVcjILy6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIzuhpm85WsMev4vGD
        vUwNjG8cuhg5OSQETCRe/VzE2sXIxSEksINR4vre2+xdjBwcvAKCEn93CIPUCAtESMw5fZkV
        xBYSUJI4t2YWI0iJsICBxK1ec5Awm4CexM8lM9hAxogInGWWWPhwChPEfF6JGe1PWSBsaYnt
        y7cyQtgaEj+W9TJD2KISN1e/ZYex3x+bD1UjItF67yxUjaDEg5+7oeKSEocOfWUDuUFCIF9i
        w4FAiHCNxNvlB6BK9CWudWwEW8sr4CvR9PgImM0ioCrxvr8ZapWLxLRXS8HizALyEtvfzmEG
        GcksoCmxfpc+xHRliSO3WGAeadj4mx2dzSzAJ9Fx+C9cfMe8J0wQrWoSi5qMIMIyEl8Pz4cq
        8ZB40LibaQKj4ixEKM9CcsIshBMWMDKvYhRLLSjOTU8tNiowgkdscn7uJkZwmtVy28E45e0H
        vUOMTByMhxglOJiVRHhf/N+cJMSbklhZlVqUH19UmpNafIjRFOj5icxSosn5wESfVxJvaGJp
        YGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBKabkbSVD9jPFlTFFmza+/bVz
        Ca/LTu0Ow0T7e09XpMdKF5xIcZ90t1lz+hM3tg/3V7MKqCao7Ei/vmtD2rHylD+fwvetK9uW
        tvhu55+V4i8+urh9O9CYeOXvq2urGkz8Tur0hf7WXF95w+Ts/c8WJ59u2V1+wV7m/dODHDZm
        6zjuKQc9jJKPmMqiLvrJd0L/5tUm81O2LbuseuNfl7NtrlTS+d+nkqVsMzs/X3VoXiy281h8
        491tmdN3+odHl+t9CjJ/WhpVk5xTdmiLRvDqxH97q4ybnz1305A+wDU7M/b+5U1mS7QNA1ZF
        5Nyxevz7mp6XqkHNqp2Vu01Yfqqu/Hco//VFMc+l7IkB3K21cUosxRmJhlrMRcWJADTDcbQ8
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220624064837epcms2p8f8589cd0fe02ae50cb4d81538c629363
References: <CGME20220624064837epcms2p8f8589cd0fe02ae50cb4d81538c629363@epcms2p8>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the following quirk to bypass "WB Manual Flush" in Write Booster.

	- UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

If this quirk is not set, there is no knob that can control "WB Manual Flush".

There are three flags that control Write Booster Feature.
	1. WB ON/OFF
	2. WB Hibern Flush ON/OFF
	3. WB Flush ON/OFF

The sysfs that controls the WB was implemented. (1)

In the case of "Hibern Flush", it is always good to turn on.
Control may not be required. (2)

Finally, "Manual flush" may be necessary because the Auto-Hibern8 is not
supported in a specific environment.
So the sysfs that controls this is necessary. (3)

In addition, toggle functions for controlling the above flags are cleaned.

V2:
	- modify commit message
	- move & modify err messages
	- remove unnesscessary debug messages

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c | 46 +++++++++++++++++++++++-
 drivers/ufs/core/ufshcd.c    | 69 +++++++++++++++++-------------------
 include/ufs/ufshcd.h         |  7 ++++
 3 files changed, 84 insertions(+), 38 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..b1c51d8df9f4 100644
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
 
@@ -254,6 +254,48 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t wb_buf_flush_en_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.wb_buf_flush_enabled);
+}
+
+static ssize_t wb_buf_flush_en_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int wb_buf_flush_en;
+	ssize_t res;
+
+	if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
+		dev_warn(dev, "It is not allowed to control WB buf flush!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtouint(buf, 0, &wb_buf_flush_en))
+		return -EINVAL;
+
+	if (wb_buf_flush_en != 0 && wb_buf_flush_en != 1)
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		res = -EBUSY;
+		goto out;
+	}
+
+	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_wb_toggle_buf_flush(hba, wb_buf_flush_en);
+	ufshcd_rpm_put_sync(hba);
+out:
+	up(&hba->host_sem);
+	return res < 0 ? res : count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -262,6 +304,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RW(wb_buf_flush_en);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -272,6 +315,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_wb_buf_flush_en.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f5d5dde497ac..439f6cb15084 100644
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
@@ -5714,6 +5714,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba *hba, bool set, enum flag_idn idn)
 	enum query_opcode opcode = set ? UPIU_QUERY_OPCODE_SET_FLAG :
 				   UPIU_QUERY_OPCODE_CLEAR_FLAG;
 
+	if (!ufshcd_is_wb_allowed(hba))
+		return -EPERM;
+
 	index = ufshcd_wb_get_query_index(hba);
 	return ufshcd_query_flag_retry(hba, opcode, idn, index, NULL);
 }
@@ -5722,60 +5725,50 @@ int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable)
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
@@ -5806,10 +5799,10 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
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
 
@@ -8195,7 +8188,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
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
index b5c9064a11d9..8c9461d45606 100644
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

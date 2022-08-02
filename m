Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCA5878B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbiHBIHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiHBIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:07:45 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B55192B2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:07:43 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220802080741epoutp04d0f4144c28f40516697ca3d5bedfb450~HeKqVHBUL0148601486epoutp04P
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:07:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220802080741epoutp04d0f4144c28f40516697ca3d5bedfb450~HeKqVHBUL0148601486epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427661;
        bh=J8oz7SvYuq/cVltUXxXmeGSSf6xdti5kDUnkXIW6RE4=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=ZCrgD2ertiNZwuGL1Lz98lZH2xTq/mgT26elxmguRnL7HPG5oTpGbp7J079Cya3os
         FDb0p3wt2YJJ4AlFnOvA2g5qvdAeGfp4leIXhOBsdcGF/KGPyLlfDcXkwLtjp5tmGU
         g7RpxIdv3S46Svvwyfi7STH3L+Sr5tvlPdunWDtw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220802080741epcas2p4891b9a178d4a2b44847449b3193af78c~HeKp5mFfU0715207152epcas2p4f;
        Tue,  2 Aug 2022 08:07:41 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LxnfN5qvWz4x9Q4; Tue,  2 Aug
        2022 08:07:40 +0000 (GMT)
X-AuditID: b6c32a45-45bff700000025c2-59-62e8db4c096d
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.6B.09666.C4BD8E26; Tue,  2 Aug 2022 17:07:40 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 3/6] scsi: ufs: wb: Add explicit flush sysfs attribute
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220802080740epcms2p3893fd9cfb765d4addbbfe58c68cf5af3@epcms2p3>
Date:   Tue, 02 Aug 2022 17:07:40 +0900
X-CMS-MailID: 20220802080740epcms2p3893fd9cfb765d4addbbfe58c68cf5af3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOJsWRmVeSWpSXmKPExsWy7bCmqa7P7RdJBi+n61qcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/JYunWm4wO3B6Xr3h7
        LN7zksljwqIDjB4tJ/ezeHxf38Hm8fHpLRaPvi2rGD0+b5LzaD/QzRTAGZVtk5GamJJapJCa
        l5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0rJJCWWJOKVAoILG4WEnf
        zqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pzv6/sBV8MKw7u
        +MvWwLhXs4uRg0NCwETi5z7DLkYuDiGBHYwSvZtPsYHEeQUEJf7uEAYxhQU8Jd5PD+li5AQq
        UZI4t2YWI0TYQOJWrzlImE1AT+LnkhlsIFNEBNpYJI51bmUGSUgI8ErMaH/KAmFLS2xfvpUR
        xOYU8JOYeOMDVI2GxI9lvVC2qMTN1W/ZYez3x+YzQtgiEq33zkLVCEo8+LkbKi4pcejQVzaI
        T/IlNhwIhAjXSLxdfgCqRF/iWsdGsBN4BXwlth95BRZnEVCVuPZmO1SNi8TirsNgNrOAvMT2
        t3OYQUYyC2hKrN+lDzFdWeLILRaYpxo2/mZHZzML8El0HP4LF98x7wkTRKuaxKImI4iwjMTX
        w/PZJzAqzUIE8iwka2chrF3AyLyKUSy1oDg3PbXYqMAQHq3J+bmbGMEpVst1B+Pktx/0DjEy
        cTAeYpTgYFYS4b3j8jxJiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBST6vJN7QxNLAxMzM
        0NzI1MBcSZzXK2VDopBAemJJanZqakFqEUwfEwenVAMT16T6KdUrvnBOvB5vWbBf81/n4gsb
        D23xvq5ftunQB8+vN6e+DilbsuGey4V1jRmvDlwzCG1ofOt9uufbw92H5ZK1Pt+4mX1DWW7J
        55XbDsp0PnHlm7p4wxIXuQVXbs++zhbjuW9602+2jtdvN5bY/7ogIb7HNF1t7ZbZvB8O3Hsl
        yXG6ddW/01uTSo563Apk1LGqnfjtd9qjbYKtURMmRnGvvvJZ8h5PkfOj9IQ3oSL83llaXx2s
        +k9afIjfZbp0p/qP6vun5/OU/6noE+H0X2lQuFzgX7tszIX4U1o/o9+4V6YpMzYo35U9wXRD
        zXhJt84ftoeNwnM3La0w+fMhPOt76dGbe75Or3Xacnler7ISS3FGoqEWc1FxIgB721FAOgQA
        AA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p3>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the following quirk to bypass "WB Flush" in Write Booster.

	- UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

If this quirk is not set, there is no knob that can control "WB Flush".

There are three flags that control Write Booster Feature.
	1. WB ON/OFF
	2. WB Hibern Flush ON/OFF (implicitly)
	3. WB Flush ON/OFF (explicit)

The sysfs attribute that controls the WB was implemented. (1)

In the case of "Hibern Flush", it is always good to turn on.
Control may not be required. (2)

Finally, "Flush" may be necessary because the Auto-Hibern8 is not
supported in a specific environment.
So the sysfs attribute that controls this is necessary. (3)

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 Documentation/ABI/testing/sysfs-driver-ufs |  9 +++++
 drivers/ufs/core/ufs-sysfs.c               | 46 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  |  9 +++--
 include/ufs/ufshcd.h                       |  1 +
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6b248abb1bd7..1255cbda0ac9 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1417,6 +1417,15 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
 		disable/enable WriteBooster through this sysfs node.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
+Date:		July 2022
+Contact:	Jinyoung Choi <j-young.choi@samsung.com>
+Description:	This entry shows the status of WriteBooster buffer flushing
+		and it can be used to allow or disallow the flushing.
+		If the flushing is allowed, the device executes the flush
+		operation when the command queue is empty.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_version
 Date:		June 2021
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..69cc9b26c762 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -254,6 +254,50 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
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
+	if (!ufshcd_is_wb_allowed(hba) ||
+	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+		dev_warn(dev, "It is not allowed to configure WB buf flushing!\n");
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
+
+out:
+	up(&hba->host_sem);
+	return res < 0 ? res : count;
+}
+
 static DEVICE_ATTR_RW(rpm_lvl);
 static DEVICE_ATTR_RO(rpm_target_dev_state);
 static DEVICE_ATTR_RO(rpm_target_link_state);
@@ -262,6 +306,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RW(wb_buf_flush_en);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -272,6 +317,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_wb_buf_flush_en.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index df00441f89a1..b7b8efd17659 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -267,7 +267,6 @@ static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 						 bool enable);
-static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
@@ -5765,25 +5764,27 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 			__func__, enable ? "enabled" : "disabled");
 }
 
-static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
 	if (!ufshcd_is_wb_allowed(hba) ||
 	    hba->dev_info.wb_buf_flush_enabled == enable)
-		return;
+		return 0;
 
 	ret = __ufshcd_wb_toggle(hba, enable, QUERY_FLAG_IDN_WB_BUFF_FLUSH_EN);
 	if (ret) {
 		dev_err(hba->dev, "%s WB-Buf Flush %s failed %d\n", __func__,
 			enable ? "enable" : "disable", ret);
-		return;
+		return ret;
 	}
 
 	hba->dev_info.wb_buf_flush_enabled = enable;
 
 	dev_dbg(hba->dev, "%s WB-Buf Flush %s\n",
 			__func__, enable ? "enabled" : "disabled");
+
+	return ret;
 }
 
 static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 7fe1a926cd99..94bcfec98fb8 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -1211,6 +1211,7 @@ int ufshcd_exec_raw_upiu_cmd(struct ufs_hba *hba,
 			     enum query_opcode desc_op);
 
 int ufshcd_wb_toggle(struct ufs_hba *hba, bool enable);
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 int ufshcd_suspend_prepare(struct device *dev);
 int __ufshcd_suspend_prepare(struct device *dev, bool rpm_ok_for_spm);
 void ufshcd_resume_complete(struct device *dev);
-- 
2.25.1

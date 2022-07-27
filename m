Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283825820B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiG0HIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiG0HIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:08:45 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5694F32DBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:08:44 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220727070842epoutp01ea0c5213085fe48392da243d4a1cd158~FnfciABer1817718177epoutp01c
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220727070842epoutp01ea0c5213085fe48392da243d4a1cd158~FnfciABer1817718177epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905722;
        bh=kE5ExXSvw6fqt9zPwb7EORYse8FtwZoVjEh3xB9n0C0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=YEIc68ecIl0VBnlF09hJ/xYhEzUQIU7tI29juoXyIzKnN9HiFsUDfgS74DctQ76Yc
         RAp4rsMQKrzTttsh0IClYy4Nna89DZ/3VOvuvMVgOBLrLwmAYjdUzzKLl9YygucTXQ
         ZqSTr5B6xBIA7zFXU7t3pyKtoY+M7/uGSrq0feTA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220727070842epcas2p11f795dedb46f6256ec7e3053fa07bf98~FnfcGHI4m2410824108epcas2p1n;
        Wed, 27 Jul 2022 07:08:42 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lt4d552GFz4x9QB; Wed, 27 Jul
        2022 07:08:41 +0000 (GMT)
X-AuditID: b6c32a47-5f7ff700000025aa-3f-62e0e479e8f9
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.45.09642.974E0E26; Wed, 27 Jul 2022 16:08:41 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 4/7] scsi: ufs: wb: Add explicit flush sysfs attribute
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
In-Reply-To: <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
Date:   Wed, 27 Jul 2022 16:08:41 +0900
X-CMS-MailID: 20220727070841epcms2p5e212d617dd0f985555fa052f099013f0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmuW7lkwdJBvd2KlucfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZT9s7mArOalTMW2TVwPhAsYuRk0NC
        wETi+vw1bF2MXBxCAjsYJTpONDF1MXJw8AoISvzdIQxSIyzgKTG78zUbiC0koCRxbs0sRpAS
        YQEDiVu95iBhNgE9iZ9LZoCNERE4yyyx8OEUJoj5vBIz2p+yQNjSEtuXb2UEsTkF/CRa575k
        hYhrSPxY1ssMYYtK3Fz9lh3Gfn9sPiOELSLReu8sVI2gxIOfu6HikhKHDn1lA7lHQiBfYsOB
        QIhwjcTb5QegSvQlrnVsBDuBV8BXYuvsV2AfsgioSvRfs4IocZG49+8w2HRmAXmJ7W/nMIOU
        MAtoSqzfpQ8xXFniyC0WmJ8aNv5mR2czC/BJdBz+CxffMe8JE0SrmsSiJiOIsIzE18Pz2Scw
        Ks1CBPIsJGtnIaxdwMi8ilEstaA4Nz212KjAGB6tyfm5mxjB6VTLfQfjjLcf9A4xMnEwHmKU
        4GBWEuFNiL6fJMSbklhZlVqUH19UmpNafIjRFOjficxSosn5wISeVxJvaGJpYGJmZmhuZGpg
        riTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBye8+Q3Dxk+iDjCwvAnkOBWxa7VHkku+yKGfL
        k2zrieWOhmyrWRb8fP58H4NvY5PsnVeW9ts3Lag087L5+oHNe2ZicHX1HcHpGlwTnzvmLYxU
        vvp36pdW3rQ1jAev5RYltbf8nKFbvWBLUFyxhaG4zp/r22cYuXZ0/l+g4eV+bInH5EKWvOzo
        3Xl+GpI9HE0i+9ateHV1i8PysEsi9W4ZClIFeT0qK7SF+PYsedcTqfEx/NTZtEtrc3T4lPbL
        JjxLT9pZE2tyanP1k1mqqnd6Ledu+ngvy+ofq6PltNu21+LKN9caJemw8NZt+TpD5LDC46M/
        GJ8uKdR1kd3NcW6K/vb3VwVX85255DTFwTxFiaU4I9FQi7moOBEAxc1ldzAEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
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
 drivers/ufs/core/ufs-sysfs.c | 45 ++++++++++++++++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c    |  9 ++++----
 include/ufs/ufshcd.h         |  1 +
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..e7800e49998a 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -254,6 +254,49 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
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
+	if (ufshcd_is_wb_allowed(hba) &&
+	   !(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+		dev_warn(dev, "It is not allowed to configure WB buf flush!\n");
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
@@ -262,6 +305,7 @@ static DEVICE_ATTR_RO(spm_target_dev_state);
 static DEVICE_ATTR_RO(spm_target_link_state);
 static DEVICE_ATTR_RW(auto_hibern8);
 static DEVICE_ATTR_RW(wb_on);
+static DEVICE_ATTR_RW(wb_buf_flush_en);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -272,6 +316,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_wb_buf_flush_en.attr,
 	NULL
 };
 
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 52377fedae49..a8a797e0033d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -267,7 +267,6 @@ static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
 static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 						 bool enable);
-static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable);
 static void ufshcd_hba_vreg_set_lpm(struct ufs_hba *hba);
 static void ufshcd_hba_vreg_set_hpm(struct ufs_hba *hba);
 
@@ -5767,24 +5766,26 @@ static void ufshcd_wb_toggle_buf_flush_during_h8(struct ufs_hba *hba,
 			__func__, enable ? "enabled" : "disabled");
 }
 
-static void ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
+int ufshcd_wb_toggle_buf_flush(struct ufs_hba *hba, bool enable)
 {
 	int ret;
 
 	if (hba->dev_info.wb_buf_flush_enabled == enable)
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

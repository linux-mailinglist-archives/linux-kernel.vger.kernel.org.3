Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B188F5898BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 09:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbiHDHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238870AbiHDHx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 03:53:59 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E4B65556
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 00:53:58 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220804075355epoutp046edd32746ff11d3c11d768c19c118fb7~IFRNoGMMm2137421374epoutp04p
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:53:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220804075355epoutp046edd32746ff11d3c11d768c19c118fb7~IFRNoGMMm2137421374epoutp04p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659599635;
        bh=2Aj9LQQGUiSL9my/m380DKw4bgy1r+fQHsa+dspiku8=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=Hkhr1Uzs6POLGNtfG8kHRp0v+mqhYLC2vbGsbQrsNQqh2XRlQYYC1QQqqsjhgSWbz
         +jFd7by94IpfWkIy1wmiJ7Qi+9DcU2kLMQX64rdRC1gTsng331YL1D6+sDR7VIIV05
         JqnHktqL8U9Xfa5rYOmvg7VvrdtSZRqgomL81DVY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220804075355epcas2p2bdc5cd7790be0bd52e970ac4147bc438~IFRNPy55O0044800448epcas2p21;
        Thu,  4 Aug 2022 07:53:55 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.101]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Lz1Fb088Nz4x9Q9; Thu,  4 Aug
        2022 07:53:55 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-be-62eb7b12a2b7
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.F3.09650.21B7BE26; Thu,  4 Aug 2022 16:53:54 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v7 3/6] scsi: ufs: wb: Add explicit flush sysfs attribute
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
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220804075354epcms2p8c21c894b4e28840c5fc651875b7f435f@epcms2p8>
Date:   Thu, 04 Aug 2022 16:53:54 +0900
X-CMS-MailID: 20220804075354epcms2p8c21c894b4e28840c5fc651875b7f435f
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmqa5Q9eskg/cbrCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbHv/mSWgjlGFS9f
        LWRpYHym2cXIySEhYCJxvLePrYuRi0NIYAejxOSOPpYuRg4OXgFBib87hEFqhAU8JX5vucMG
        YgsJKEmcWzOLEaREWMBA4lavOUiYTUBP4ueSGWAlIgJtLBLrT7NDjOeVmNH+lAXClpbYvnwr
        WCungJ/E/cNZEGENiR/LepkhbFGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9s
        ICMlBPIlNhwIhAjXSLxdfgCqRF/iWsdGsAt4BXwlZh5fBzaGRUBVYtaHXkaIVheJ7S+DQcLM
        AvIS29/OYQYJMwtoSqzfpQ9RoSxx5BYLzEsNG3+zo7OZBfgkOg7/hYvvmPeECaJVTWJRkxFE
        WEbi6+H57BMYlWYhgngWkrWzENYuYGRexSiWWlCcm55abFRgBI/V5PzcTYzgBKvltoNxytsP
        eocYmTgYDzFKcDArifCusHydJMSbklhZlVqUH19UmpNafIjRFOjficxSosn5wBSfVxJvaGJp
        YGJmZmhuZGpgriTO65WyIVFIID2xJDU7NbUgtQimj4mDU6qBSUWbTbnxpMS6sjXm2x3TPKX0
        CiK3hm7fIuQYWWL45YrCCU9/3R1hEhUZB0W5zy/7OuFdbOW/Wx/1z71MK7ysNnnrqeU75umG
        u5pEHz0lFPX7/7GuF+wXll59rHbO/Hzw2V9bFk669jNf4KnAoesqe5eb/Pi/r31JdqfciwNz
        JacxJWxOYNiU4aJwYO/J92e4mrgnzL336snkGxsfNTFpiC6aPSdh6Z0aLhapDiHWsgz+aWEX
        Zj5M5rjtvad84+TWnSFV7lt7RGXDrNRr/20+9vz7cfsyAbvepVc7j22PzF6Xefc1X84hUS3O
        /wEO73lrXXN63snF2uw3mFXv+8C4kV10S+RdoS+ev/uKGoM/dymxFGckGmoxFxUnAgBS9V2E
        OQQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866
References: <20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p1>
        <CGME20220804074224epcms2p18f0ac2f92073aeed981718a9cab23866@epcms2p8>
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
index 6b248abb1bd7..91de786f9a71 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1417,6 +1417,15 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
 		disable/enable WriteBooster through this sysfs node.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/enable_wb_buf_flush
+What:		/sys/bus/platform/devices/*.ufs/enable_wb_buf_flush
+Date:		July 2022
+Contact:	Jinyoung Choi <j-young.choi@samsung.com>
+Description:	This entry shows the status of WriteBooster buffer flushing
+		and it can be used to enable or disable the flushing.
+		If flushing is enabled, the device executes the flush
+		operation when the command queue is empty.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_version
 Date:		June 2021
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..8fe3d6e51cc8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -254,6 +254,50 @@ static ssize_t wb_on_store(struct device *dev, struct device_attribute *attr,
 	return res < 0 ? res : count;
 }
 
+static ssize_t enable_wb_buf_flush_show(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", hba->dev_info.wb_buf_flush_enabled);
+}
+
+static ssize_t enable_wb_buf_flush_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct ufs_hba *hba = dev_get_drvdata(dev);
+	unsigned int enable_wb_buf_flush;
+	ssize_t res;
+
+	if (!ufshcd_is_wb_allowed(hba) ||
+	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+		dev_warn(dev, "It is not allowed to configure WB buf flushing!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (kstrtouint(buf, 0, &enable_wb_buf_flush))
+		return -EINVAL;
+
+	if (enable_wb_buf_flush != 0 && enable_wb_buf_flush != 1)
+		return -EINVAL;
+
+	down(&hba->host_sem);
+	if (!ufshcd_is_user_access_allowed(hba)) {
+		res = -EBUSY;
+		goto out;
+	}
+
+	ufshcd_rpm_get_sync(hba);
+	res = ufshcd_wb_toggle_buf_flush(hba, enable_wb_buf_flush);
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
+static DEVICE_ATTR_RW(enable_wb_buf_flush);
 
 static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_rpm_lvl.attr,
@@ -272,6 +317,7 @@ static struct attribute *ufs_sysfs_ufshcd_attrs[] = {
 	&dev_attr_spm_target_link_state.attr,
 	&dev_attr_auto_hibern8.attr,
 	&dev_attr_wb_on.attr,
+	&dev_attr_enable_wb_buf_flush.attr,
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

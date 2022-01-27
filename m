Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDC49D8C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 04:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiA0DFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 22:05:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:34389 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiA0DFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 22:05:04 -0500
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220127030502epoutp02e58d4c14d064a029ef01b7d565260597~OAaBYhyL10802808028epoutp02D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:05:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220127030502epoutp02e58d4c14d064a029ef01b7d565260597~OAaBYhyL10802808028epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643252702;
        bh=rmq0WeKn7swhKm1q4O2Sd9F8V8oI2TUlmainr8ll46Y=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=Ik9ie0y30R8pzid3G03USLhxxEjEg8c0/4iRpqA06+NIQEg6OTxzBnYNng39uhsP7
         hFzVct17MQoswJfn0BXv27k81jdXm/FApk3Zag+GfljgUe7TZw+Hi7lznummm8Zi9z
         4N2lKbYeE4DYISYO2dSBK9H91llyerBNi7ICEA/U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220127030501epcas3p16bb082ab22bb7a72d9a8afb48da5c449~OAaA-M4Rg0329203292epcas3p1B;
        Thu, 27 Jan 2022 03:05:01 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4JklnT5Q3hz4x9Ps; Thu, 27 Jan 2022 03:05:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for
 WriteBooster
Reply-To: j-young.choi@samsung.com
Sender: Jinyoung CHOI <j-young.choi@samsung.com>
From:   Jinyoung CHOI <j-young.choi@samsung.com>
To:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "huobean@gmail.com" <huobean@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
Date:   Thu, 27 Jan 2022 12:00:25 +0900
X-CMS-MailID: 20220127030025epcms2p3dccc36d5f89c6f68add690265016e8f0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94
References: <CGME20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94@epcms2p3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because WB performs write in SLC mode, it is difficult to use WB
infinitely.

Vendors can set the Lifetime limit value to the device.
If Lifetime exceeds the limit value, the device itself can disable the
WB feature.

WB feature supports "bWriteBoosterBufferLifeTimeEst (IDN = 1E)" attribute.

With Lifetime exceeding the limit value,
the current driver continuously performs the following query.

	- Write Flag: WB_ENABLE / DISABLE
	- Read attr: Available Buffer Size
	- Read attr: Current Buffer Size

This patch recognizes that WriteBooster is no longer supported by the device,
and prevent unnecessary query issues.

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/scsi/ufs/ufs.h    |  6 +++++
 drivers/scsi/ufs/ufshcd.c | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 0bfdca3e648e..4a00c24a3209 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -43,6 +43,12 @@
 /* WriteBooster buffer is available only for the logical unit from 0 to 7 */
 #define UFS_UPIU_MAX_WB_LUN_ID	8
 
+/*
+ * WriteBooster buffer lifetime has a limit setted by vendor.
+ * If it is over the limit, WriteBooster feature will be disabled.
+ */
+#define UFS_WB_EXCEED_LIFETIME		0x0B
+
 /* Well known logical unit id in LUN field of UPIU */
 enum {
 	UFS_UPIU_REPORT_LUNS_WLUN	= 0x81,
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b440d2e..41d85b69fa50 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5778,6 +5778,47 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 	return false;
 }
 
+static void ufshcd_wb_force_disable(struct ufs_hba *hba)
+{
+	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+		ufshcd_wb_toggle_flush(hba, false);
+
+	ufshcd_wb_toggle_flush_during_h8(hba, false);
+	ufshcd_wb_toggle(hba, false);
+	hba->caps &= ~UFSHCD_CAP_WB_EN;
+
+	dev_info(hba->dev, "%s: WB force disabled\n", __func__);
+}
+
+static bool ufshcd_is_wb_buf_lifetime_available(struct ufs_hba *hba)
+{
+	u32 lifetime;
+	int ret;
+	u8 index;
+
+	index = ufshcd_wb_get_query_index(hba);
+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+				      QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST,
+				      index, 0, &lifetime);
+	if (ret) {
+		dev_err(hba->dev,
+			"%s: bWriteBoosterBufferLifeTimeEst read failed %d\n",
+			__func__, ret);
+		return false;
+	}
+
+	if (lifetime == UFS_WB_EXCEED_LIFETIME) {
+		dev_err(hba->dev, "%s: WB buf lifetime is exhausted 0x%02X\n",
+			__func__, lifetime);
+		return false;
+	}
+
+	dev_dbg(hba->dev, "%s: WB buf lifetime is 0x%02X\n",
+		__func__, lifetime);
+
+	return true;
+}
+
 static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
 {
 	int ret;
@@ -5786,6 +5827,12 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
 
 	if (!ufshcd_is_wb_allowed(hba))
 		return false;
+
+	if (!ufshcd_is_wb_buf_lifetime_available(hba)) {
+		ufshcd_wb_force_disable(hba);
+		return false;
+	}
+
 	/*
 	 * The ufs device needs the vcc to be ON to flush.
 	 * With user-space reduction enabled, it's enough to enable flush
@@ -7486,6 +7533,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
 
 	if (!ufshcd_is_wb_allowed(hba))
 		return;
+
 	/*
 	 * Probe WB only for UFS-2.2 and UFS-3.1 (and later) devices or
 	 * UFS devices with quirk UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES
@@ -7537,6 +7585,10 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
 		if (!d_lu_wb_buf_alloc)
 			goto wb_disabled;
 	}
+
+	if (!ufshcd_is_wb_buf_lifetime_available(hba))
+		goto wb_disabled;
+
 	return;
 
 wb_disabled:
-- 
2.25.1

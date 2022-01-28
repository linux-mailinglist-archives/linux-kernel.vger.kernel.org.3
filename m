Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4949FD99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiA1QFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:05:05 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:48084 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234788AbiA1QFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:05:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643385904; x=1674921904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=or411cjleC+Ihl7R1QhLwHpbJvcXh16tO4SAHIDvYjA=;
  b=CPFQI2n8642Pz3jTHC7jwPXlCkFjN+6JQ70HuOOsiv6Moq/SZ1YcyU2U
   Mh9heG30KZwyC6FDmlT/eLmG+iFNvg9h5BJhHxWZvdxq/d73sAfFW/m+k
   eW72dHDKBMVyqEeZ403LPRSBWPeA0jm+PpB9TsmRFS/yYhbvodyb+AYsG
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jan 2022 08:05:04 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 08:05:03 -0800
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 28 Jan 2022 08:05:03 -0800
Date:   Fri, 28 Jan 2022 08:05:02 -0800
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
CC:     ALIM AKHTAR <alim.akhtar@samsung.com>,
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
Subject: Re: [PATCH RESEND] scsi: ufs: Add checking lifetime attribute for
 WriteBooster
Message-ID: <20220128160502.GA24908@asutoshd-linux1.qualcomm.com>
References: <CGME20220126104125epcms2p50afb250190ffc3f2dc7b16df31757c94@epcms2p3>
 <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <1891546521.01643252701746.JavaMail.epsvc@epcpadp3>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27 2022 at 19:07 -0800, Jinyoung CHOI wrote:
>Because WB performs write in SLC mode, it is difficult to use WB
>infinitely.
>
>Vendors can set the Lifetime limit value to the device.
>If Lifetime exceeds the limit value, the device itself can disable the
>WB feature.
>
>WB feature supports "bWriteBoosterBufferLifeTimeEst (IDN = 1E)" attribute.
>
>With Lifetime exceeding the limit value,
>the current driver continuously performs the following query.
>
>	- Write Flag: WB_ENABLE / DISABLE
>	- Read attr: Available Buffer Size
>	- Read attr: Current Buffer Size
>
>This patch recognizes that WriteBooster is no longer supported by the device,
>and prevent unnecessary query issues.
>
>Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
>---

LGTM.

Reviewed-by: Asutosh Das <quic_asutoshd@quicinc.com>

> drivers/scsi/ufs/ufs.h    |  6 +++++
> drivers/scsi/ufs/ufshcd.c | 52 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 58 insertions(+)
>
>diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>index 0bfdca3e648e..4a00c24a3209 100644
>--- a/drivers/scsi/ufs/ufs.h
>+++ b/drivers/scsi/ufs/ufs.h
>@@ -43,6 +43,12 @@
> /* WriteBooster buffer is available only for the logical unit from 0 to 7 */
> #define UFS_UPIU_MAX_WB_LUN_ID	8
>
>+/*
>+ * WriteBooster buffer lifetime has a limit setted by vendor.
>+ * If it is over the limit, WriteBooster feature will be disabled.
>+ */
>+#define UFS_WB_EXCEED_LIFETIME		0x0B
>+
> /* Well known logical unit id in LUN field of UPIU */
> enum {
> 	UFS_UPIU_REPORT_LUNS_WLUN	= 0x81,
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>index 460d2b440d2e..41d85b69fa50 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -5778,6 +5778,47 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
> 	return false;
> }
>
>+static void ufshcd_wb_force_disable(struct ufs_hba *hba)
>+{
>+	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
>+		ufshcd_wb_toggle_flush(hba, false);
>+
>+	ufshcd_wb_toggle_flush_during_h8(hba, false);
>+	ufshcd_wb_toggle(hba, false);
>+	hba->caps &= ~UFSHCD_CAP_WB_EN;
>+
>+	dev_info(hba->dev, "%s: WB force disabled\n", __func__);
>+}
>+
>+static bool ufshcd_is_wb_buf_lifetime_available(struct ufs_hba *hba)
>+{
>+	u32 lifetime;
>+	int ret;
>+	u8 index;
>+
>+	index = ufshcd_wb_get_query_index(hba);
>+	ret = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
>+				      QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST,
>+				      index, 0, &lifetime);
>+	if (ret) {
>+		dev_err(hba->dev,
>+			"%s: bWriteBoosterBufferLifeTimeEst read failed %d\n",
>+			__func__, ret);
>+		return false;
>+	}
>+
>+	if (lifetime == UFS_WB_EXCEED_LIFETIME) {
>+		dev_err(hba->dev, "%s: WB buf lifetime is exhausted 0x%02X\n",
>+			__func__, lifetime);
>+		return false;
>+	}
>+
>+	dev_dbg(hba->dev, "%s: WB buf lifetime is 0x%02X\n",
>+		__func__, lifetime);
>+
>+	return true;
>+}
>+
> static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
> {
> 	int ret;
>@@ -5786,6 +5827,12 @@ static bool ufshcd_wb_need_flush(struct ufs_hba *hba)
>
> 	if (!ufshcd_is_wb_allowed(hba))
> 		return false;
>+
>+	if (!ufshcd_is_wb_buf_lifetime_available(hba)) {
>+		ufshcd_wb_force_disable(hba);
>+		return false;
>+	}
>+
> 	/*
> 	 * The ufs device needs the vcc to be ON to flush.
> 	 * With user-space reduction enabled, it's enough to enable flush
>@@ -7486,6 +7533,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
>
> 	if (!ufshcd_is_wb_allowed(hba))
> 		return;
>+
> 	/*
> 	 * Probe WB only for UFS-2.2 and UFS-3.1 (and later) devices or
> 	 * UFS devices with quirk UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES
>@@ -7537,6 +7585,10 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, u8 *desc_buf)
> 		if (!d_lu_wb_buf_alloc)
> 			goto wb_disabled;
> 	}
>+
>+	if (!ufshcd_is_wb_buf_lifetime_available(hba))
>+		goto wb_disabled;
>+
> 	return;
>
> wb_disabled:
>-- 
>2.25.1

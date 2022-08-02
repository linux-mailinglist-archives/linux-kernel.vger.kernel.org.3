Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22AC5878BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiHBIIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236388AbiHBIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:08:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609DD4D827
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:08:36 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220802080832epoutp01273d2551ac6e73716de5ccc66d366074~HeLZ9UoHn2524325243epoutp01M
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:08:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220802080832epoutp01273d2551ac6e73716de5ccc66d366074~HeLZ9UoHn2524325243epoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659427712;
        bh=oszOItcMjMeNHkWQ68yMN7/6C0T1+pTNlDcShYoGYbg=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=J1vG3ytQMIun0b3JMQZrHmzmUeDCS8F8sRXn0wVc1Qa3Gpf63qpe7+xF93s8uQK+X
         1ZJ/UfVxgJEdgod8UmsMGCi4QdCggvbs6b3pAQSDTmjX+OQXzBZ908BBE6Fonj8KPO
         oHTaCm+zVjBHLwRnLL/h2MSo0ay625U/cm8WNWVo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220802080832epcas2p293fd0586ea433a8e1e69772c24da0566~HeLZuprL00074300743epcas2p2B;
        Tue,  2 Aug 2022 08:08:32 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.68]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LxngN0QZ9z4x9Pw; Tue,  2 Aug
        2022 08:08:32 +0000 (GMT)
X-AuditID: b6c32a47-5e1ff700000025aa-ef-62e8db7f677a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.06.09642.F7BD8E26; Tue,  2 Aug 2022 17:08:31 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v6 4/6] scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
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
Message-ID: <20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650@epcms2p2>
Date:   Tue, 02 Aug 2022 17:08:31 +0900
X-CMS-MailID: 20220802080831epcms2p2c2b9f94e2f450a6a772a193d9720b650
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhW797RdJBgt6zS1OPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8dksXTrTUYHbo/LV7w9
        Fu95yeQxYdEBRo+Wk/tZPL6v72Dz+Pj0FotH35ZVjB6fN8l5tB/oZgrgjMq2yUhNTEktUkjN
        S85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAE6VkmhLDGnFCgUkFhcrKRv
        Z1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQndH++xNzwUKRivN/
        d7I2MO4U7GLk5JAQMJHYs62dpYuRi0NIYAejxJkNbaxdjBwcvAKCEn93CIPUCAt4S3QvPcUK
        YgsJKEmcWzOLEaREWMBA4lavOUiYTUBP4ueSGWwgY0QE2lgkjnVuZYaYzysxo/0pC4QtLbF9
        +VZGEJtTwE9i4o0PUDUaEj+W9ULZohI3V79lh7HfH5vPCGGLSLTeOwtVIyjx4OduqLikxKFD
        X9lA7pEQyJfYcCAQIlwj8Xb5AagSfYlrHRvBTuAV8JWYNeEmWJxFQFVi9+dmJogaF4ltHR/B
        XmQWkJfY/nYOM8hIZgFNifW79CGmK0scucUC81TDxt/s6GxmAT6JjsN/4eI75j1hgmhVk1jU
        ZAQRlpH4eng++wRGpVmIUJ6FZO0shLULGJlXMYqlFhTnpqcWGxUYwyM2OT93EyM4zWq572Cc
        8faD3iFGJg7GQ4wSHMxKIrx3XJ4nCfGmJFZWpRblxxeV5qQWH2I0BXp4IrOUaHI+MNHnlcQb
        mlgamJiZGZobmRqYK4nzeqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgaly+/qapt5/p/tTvJ7lD
        NHTPaU9mEJi7cc3Nk1Gydh2H30vlpQpsiOiaZ/vHQlG3XKD/SvMrlbXxJ9+eentc0aEnf71M
        ZcH+qbMexz6/6VPydOfxxB8+W/eEL5G/cW1jranu/2dKxRdZX07/Kbonm/2QkX7okp8BR5dV
        L13zXHj9lTsXvFo7F/Grqz+0PXRpn9qhyj+bQ9cfcdG8afLfSzvSdNvsp9M/7DbWtvnf/f1+
        CKvhh8MaO0X6Dv5Kt7jp0GyZf57X19hMsDh4H8db1v4/i1Zx+Z7gPzL5nfEEqeQXvCtVt147
        3fs0Pu/Hy8Kgd55v/D0FhUu+cpRsfd+cHa7ctcZificD+9fJ/FMObVFiKc5INNRiLipOBAA6
        UzIIPAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce
References: <20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
        <CGME20220802080146epcms2p24b86bfce3d3c09c79b91d861cb3b2cce@epcms2p2>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The explicit flushing should check the following.
	- UFSHCD_CAP_WB_EN
	- UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL

Changed to improve readability.

Acked-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c   | 3 +--
 drivers/ufs/core/ufshcd-priv.h | 6 ++++++
 drivers/ufs/core/ufshcd.c      | 5 +++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 69cc9b26c762..2c0b7f45de4b 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -271,8 +271,7 @@ static ssize_t wb_buf_flush_en_store(struct device *dev,
 	unsigned int wb_buf_flush_en;
 	ssize_t res;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+	if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
 		dev_warn(dev, "It is not allowed to configure WB buf flushing!\n");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 8f67db202d7b..d00dba17297d 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -26,6 +26,12 @@ static inline u8 ufshcd_wb_get_query_index(struct ufs_hba *hba)
 	return 0;
 }
 
+static inline bool ufshcd_is_wb_buf_flush_allowed(struct ufs_hba *hba)
+{
+	return ufshcd_is_wb_allowed(hba) &&
+		!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL);
+}
+
 #ifdef CONFIG_SCSI_UFS_HWMON
 void ufs_hwmon_probe(struct ufs_hba *hba, u8 mask);
 void ufs_hwmon_remove(struct ufs_hba *hba);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index b7b8efd17659..5099d161f115 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -294,7 +294,8 @@ static void ufshcd_configure_wb(struct ufs_hba *hba)
 	ufshcd_wb_toggle(hba, true);
 
 	ufshcd_wb_toggle_buf_flush_during_h8(hba, true);
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, true);
 }
 
@@ -5815,7 +5816,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, false);
 
 	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
-- 
2.25.1

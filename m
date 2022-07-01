Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F3562D02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 09:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiGAHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235615AbiGAHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 03:48:18 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D484BC16
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 00:48:16 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220701074815epoutp040e055cce4b594d347359893671515d5d~9pQjKQQ4r0056500565epoutp04K
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:48:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220701074815epoutp040e055cce4b594d347359893671515d5d~9pQjKQQ4r0056500565epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656661695;
        bh=oGukSB9O0xN7U7M7TwsNAjEPd9DF7wPXjNhAN7q1AFw=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=rYfvEORACJTVzRgQOmH+hill4AHgZXaExFEKCP1TFk+Uhb9B8+DKDTaKyazpiSkB1
         bvFOqBObH8vtfsWFu5gxcPf/SW7zax6/MTEL5dQQfMDDm8WQqcQGB2GFU68JArGLeJ
         jlBqGgK439no6A8bWS+a1dbYxRBz3wtQGDkioVxM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220701074814epcas2p19da3e47416f37090e4183eed9a8231f4~9pQivnzrB2588925889epcas2p1S;
        Fri,  1 Jul 2022 07:48:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4LZ6kk2RNcz4x9QL; Fri,  1 Jul
        2022 07:48:14 +0000 (GMT)
X-AuditID: b6c32a46-0a3ff700000025b2-a6-62bea6be2374
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.D3.09650.EB6AEB26; Fri,  1 Jul 2022 16:48:14 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v3 2/2] scsi: ufs: wb: Add Manual Flush sysfs
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
Message-ID: <20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22@epcms2p8>
Date:   Fri, 01 Jul 2022 16:48:14 +0900
X-CMS-MailID: 20220701074814epcms2p8bfb6c00d7364aa704e2d6e60088e6a22
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsWy7bCmhe6+ZfuSDNbtF7Q4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1eHtK0WHRjG5PF5V1z2Cy6r+9gs1h+/B+TA5fH5SveHov3vGTy
        mLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7IzXh//xV7wQKzixpnPrA2Mj4S6GDk5
        JARMJD6cmMLUxcjFISSwg1HiettXIIeDg1dAUOLvDmGQGmEBW4kWoB4QW0hASeLcmlmMICXC
        AgYSt3rNQcJsAnoSP5fMYAMZIyJwllli4UOQmSDzeSVmtD9lgbClJbYv38oIYnMK+Emcn7SG
        ESKuIfFjWS8zhC0qcXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKXHo0Fc2kHskBPIlNhwI
        hAjXSLxdfgCqRF/iWsdGsBN4BXwl5m+ZAzaGRUBV4mfPfKiRLhINjc/B1jILyEtsfwtSwwFk
        a0qs36UPMV1Z4sgtFpinGjb+ZkdnMwvwSXQc/gsX3zHvCRNEq5rEoiYjiLCMxNfD89knMCrN
        QoTyLCRrZyGsXcDIvIpRLLWgODc9tdiowAgescn5uZsYwSlVy20H45S3H/QOMTJxMB5ilOBg
        VhLhZZu3N0mINyWxsiq1KD++qDQntfgQoynQwxOZpUST84FJPa8k3tDE0sDEzMzQ3MjUwFxJ
        nNcrZUOikEB6YklqdmpqQWoRTB8TB6dUA9OJbzotBZeb9h2vFJ1meP3ypWLxOyc+Kv4v25m4
        4n2oxAeBy3djT1YlhkbU62wQtllksPPrt5m1Cx2zJ7xwlbRYIh5y8FBOYVzidV/TzTvCjtRW
        NL9WN9u+6C9H6t2Ix9XapQa6r1O/qmapmz/8FuH/ZlrRn+nqE07bR+vfy9p1JP9i3oLjP459
        sokx65vBOmP+zfCrHEdzqz0OvvOfeODowi/r13CyP3800cPspo1OwR+FqJlsda2L/z7tPym/
        YEZFl3BVdlm/27K6Ry5y3gV7TtsJG/TvWSsW2CoYaVCquo/juMDqGM6PvT3mubv3/VXZkG9R
        5rGGrfh4tCL37Zz1Tu6TC2c8NL2xxLotVl2JpTgj0VCLuag4EQDY0PYMMgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95
References: <20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p4>
        <CGME20220701074420epcms2p4c4a6a016c7070d5dfa279fc4607caa95@epcms2p8>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c | 44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 6253606b93b4..b1c51d8df9f4 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
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
 
-- 
2.25.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5465584ADD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiG2E4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiG2E4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:56:05 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B46D2CC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:56:03 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220729045601epoutp0211280557f8a18e5c70386efbb049d8b6~GM_LJvAxz0801108011epoutp02o
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:56:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220729045601epoutp0211280557f8a18e5c70386efbb049d8b6~GM_LJvAxz0801108011epoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070561;
        bh=Qvj+FjBZQ2kYi8uDEb/na+Sp3kglKa834J/4CaXXPjs=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=FzBdpK/LwipzPdpQZNl8Q+SM4vEkTp5n9GeQ5ijLHwxf6IoT55lczLfOlJGdkZyMi
         GDA8DIi/zjaS6yg681nhplBpAKvsqchUtK0+wrsCbzz5zqQlcGaOB2rYsHfIUvLnOj
         alWYYQJHh8mGtcppMBHNo8we7xGy9iwufW1Kj3S4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220729045601epcas2p3585e66e5eb57a184fff29a5640276d80~GM_Kp_UEU2566625666epcas2p3F;
        Fri, 29 Jul 2022 04:56:01 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4LvFb46m4dz4x9Q1; Fri, 29 Jul
        2022 04:56:00 +0000 (GMT)
X-AuditID: b6c32a46-0b9ff700000025b2-69-62e3686067df
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.80.09650.06863E26; Fri, 29 Jul 2022 13:56:00 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 3/6] scsi: ufs: wb: Add explicit flush sysfs attribute
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
In-Reply-To: <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
Date:   Fri, 29 Jul 2022 13:56:00 +0900
X-CMS-MailID: 20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmqW5CxuMkg31vNCxOPlnDZvFg3jY2
        i5c/r7JZHHzYyWIx7cNPZouXhzQtFt3YxmRxedccNovu6zvYLJYf/8fkwOVx+Yq3x+I9L5k8
        Jiw6wOjxfX0Hm8fHp7dYPPq2rGL0+LxJzqP9QDdTAEdUtk1GamJKapFCal5yfkpmXrqtkndw
        vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
        Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMP3PmMxZsM6p4cP0AUwPjN80uRk4O
        CQETie4Xy5m7GLk4hAR2MEpMXPGHpYuRg4NXQFDi7w5hkBphAU+Jma/2MYHYQgJKEufWzGIE
        KREWMJC41WsOEmYT0JP4uWQGG8gYEYGzzBILH05hgpjPKzGj/SkLhC0tsX35VkYQm1PAT6J9
        8wI2iLiGxI9lvcwQtqjEzdVv2WHs98fmM0LYIhKt985C1QhKPPi5GyouKXHo0Fc2kHskBPIl
        NhwIhAjXSLxdfgCqRF/iWsdGsBN4BXwlTh09AbaWRUBVovXoAmaIVheJE8/AXmEWkJfY/nYO
        WJhZQFNi/S59iApliSO3WGB+atj4mx2dzSzAJ9Fx+C9cfMe8J0wQrWoSi5qMIMIyEl8Pz2ef
        wKg0CxHIs5CsnYWwdgEj8ypGsdSC4tz01GKjAiN4vCbn525iBCdULbcdjFPeftA7xMjEwXiI
        UYKDWUmEVyDgcZIQb0piZVVqUX58UWlOavEhRlOgfycyS4km5wNTel5JvKGJpYGJmZmhuZGp
        gbmSOK9XyoZEIYH0xJLU7NTUgtQimD4mDk6pBqZgI/OfjtHGlYXvXORWaW988vPGNx+1xAd/
        l3oonXy6oUNcJVppXsOh+ZtumuWvDTViZj01+biPsO2OY7PYO/5M4Va+d2P5AZPbZwP73p48
        6brUbN33Hac4a7t1W6fcYm/wOu7g1838alrcAceNbBePPHVuadswd5q52hnN23lbjolt5Nv1
        RjrWfmf2xCtqHHVt3pJc1exrL77/vKX+2vNSbb/Jm1IiX7GztxxYMvvbqW/1r3f3e6gv5GKP
        yzuiZlNlrfpcvu5cT24b9/O3joZP579iWHOsgNMv02h30a5GofWRG+6uOdwn/thMMeL0R4uN
        u261LWmovvz6Ib+XxerolnamU/XNP52EDC9Zmu9WYinOSDTUYi4qTgQAz3x4zTEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p4>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 Documentation/ABI/testing/sysfs-driver-ufs | 10 +++++
 drivers/ufs/core/ufs-sysfs.c               | 45 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  |  9 +++--
 include/ufs/ufshcd.h                       |  1 +
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6b248abb1bd7..7e9e1db55d60 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -1417,6 +1417,16 @@ Description:	This node is used to set or display whether UFS WriteBooster is
 		platform that doesn't support UFSHCD_CAP_CLK_SCALING, we can
 		disable/enable WriteBooster through this sysfs node.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/wb_buf_flush_en
+What:		/sys/bus/platform/devices/*.ufs/wb_buf_flush_en
+Date:		July 2022
+Contact:	Jinyoung Choi <j-young.choi@samsung.com>
+Description:	This node is used to set or display whether WriteBooster
+		buffer flusing is enabled. The data written in the WriteBooster
+		Buffer can be flushed by an explicit host command or
+		implicitly while in hibernate (HIBERN8) state. We can control
+		the explicit flushing through this sysfs node.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/hpb_version
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/hpb_version
 Date:		June 2021
diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 0a088b47d557..920094665f4d 100644
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
+	if (!ufshcd_is_wb_allowed(hba) ||
+	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
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
index a14d3fe39570..36d4708eaee0 100644
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

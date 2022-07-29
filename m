Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC48584AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiG2E5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiG2E5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:57:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C57AC10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 21:57:00 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220729045658epoutp04b98f2b869a167c59e0d0f914fb4686ee~GM-ACqU7q2636826368epoutp04K
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:56:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220729045658epoutp04b98f2b869a167c59e0d0f914fb4686ee~GM-ACqU7q2636826368epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1659070618;
        bh=gW7j82RhlhznlAP4QTs59f+Tb5vwBEAzdSOhNq4apdk=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=BWegHYhXI2qrzsl3iUTt5sa45WC6fCtz53W2W4Iuum57RlVEU7zZginU98lh2da4T
         GxbqkOHaK1FP7Ig53dinRVFn5Gm3ZCtlANtXAdYS5UZQ6B245+WjVH9MGG0y6vX+lI
         +qs0iynAke+qnnF6vN4ixEMlQ83W8M9z1XQTVIwc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220729045657epcas2p1c2447fe304552907a3ea0ec4c05574f4~GM__2Ndvl1958819588epcas2p1j;
        Fri, 29 Jul 2022 04:56:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4LvFc85zYGz4x9Q8; Fri, 29 Jul
        2022 04:56:56 +0000 (GMT)
X-AuditID: b6c32a48-9f7ff700000025be-e8-62e36898d73c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.63.09662.89863E26; Fri, 29 Jul 2022 13:56:56 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v5 4/6] scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
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
In-Reply-To: <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c@epcms2p1>
Date:   Fri, 29 Jul 2022 13:56:56 +0900
X-CMS-MailID: 20220729045656epcms2p1e6912ae09ca2122d4d04854878e19b2c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhe6MjMdJBn/vaVmcfLKGzeLBvG1s
        Fi9/XmWzOPiwk8Vi2oefzBYvD2laLLqxjcni8q45bBbd13ewWSw//o/Jgcvj8hVvj8V7XjJ5
        TFh0gNHj+/oONo+PT2+xePRtWcXo8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoBOVFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZKqQUpOQXmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZszf/Zi74LFwx+fBRtgbGiYJdjJwc
        EgImEpP+bGbrYuTiEBLYwSjx/M9Jxi5GDg5eAUGJvzuEQWqEBbwlus60s4PYQgJKEufWzAIr
        ERYwkLjVaw4SZhPQk/i5ZAbYGBGBs8wSCx9OYYKYzysxo/0pC4QtLbF9+VZGEJtTwE9izYSZ
        zBBxDYkfy3qhbFGJm6vfssPY74/NZ4SwRSRa752FqhGUePBzN1RcUuLQoa9sIPdICORLbDgQ
        CBGukXi7/ABUib7EtY6NLBBf+Ups/hgPEmYRUJWY9mwJK0SJi8Tnh9/ApjMLyEtsfzuHGaSc
        WUBTYv0ufYjhyhJHbrHA/NSw8Tc7OptZgE+i4/BfuPiOeU+YIFrVJBY1GUGEZSS+Hp7PPoFR
        aRYikGchWTsLYe0CRuZVjGKpBcW56anFRgUm8HhNzs/dxAhOqFoeOxhnv/2gd4iRiYPxEKME
        B7OSCK9AwOMkId6UxMqq1KL8+KLSnNTiQ4ymQA9PZJYSTc4HpvS8knhDE0sDEzMzQ3MjUwNz
        JXFer5QNiUIC6YklqdmpqQWpRTB9TBycUg1MdfZFS6derjDkPJQVPyH87sUJc3b2P36n9vP3
        Ed3T5W0+/MEb/q7tbn51e27osey+02dkv75M53vYrfA3gWXuwVgnLWnOS2ImlbkLe/d4xV+c
        Oqeu/Z2A7n79tS5v/oVFMxo9apn3+bW0ZOnPdfe8GV6UdbCu2ckjqpkoUn3FlW3fx7MLNnYx
        nLyzYO6pDz9Mo/nvFpi6LdFlZeoOW/LOcsVtU8u+O5FrHwsZqP0JOxpnEtJw2PaPxdzayk1l
        62oYuT5qN33YHORszV/AxPqXfdecn/r+7SG+vjukhT8+uRnq/fY5S9fmjFW85etv3avmCnta
        rvM48VNsyKmrXZYv54cuFlCxX/aHyz7w3b51SizFGYmGWsxFxYkA5sFQwDEEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368
References: <20220729045600epcms2p45c0f8a5a0a76c7fe85b0961570de89ce@epcms2p4>
        <20220729045433epcms2p77ff2cdde6ddffd9ab0b0810ebe84f0e5@epcms2p7>
        <20220729045252epcms2p7fee5c1cdca5e4bef02a833e40f80649b@epcms2p7>
        <20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p8>
        <CGME20220729045045epcms2p8caf00317889ed4da8531b7466ec6e368@epcms2p1>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c   | 3 +--
 drivers/ufs/core/ufshcd-priv.h | 6 ++++++
 drivers/ufs/core/ufshcd.c      | 5 +++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index 920094665f4d..63b02b2541c8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -271,8 +271,7 @@ static ssize_t wb_buf_flush_en_store(struct device *dev,
 	unsigned int wb_buf_flush_en;
 	ssize_t res;
 
-	if (!ufshcd_is_wb_allowed(hba) ||
-	    (hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+	if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
 		dev_warn(dev, "It is not allowed to configure WB buf flush!\n");
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
index 36d4708eaee0..584e246c769a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -294,7 +294,8 @@ static void ufshcd_wb_set_default_flags(struct ufs_hba *hba)
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

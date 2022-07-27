Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9675820BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiG0HKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiG0HK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:10:29 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB61B3D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:10:27 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220727071026epoutp04b7775a271917a857aa668c608831eb8b~Fng879ktk2635526355epoutp04i
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:10:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220727071026epoutp04b7775a271917a857aa668c608831eb8b~Fng879ktk2635526355epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1658905826;
        bh=yAjYthTYZ1VyQYto1gO6QWEcENXGTa9Eb2Hnw6HNmz0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=IATVFzNG57C5SWtHwqD6uoLNgBrR6gOuHyT3y4UNJ+tn4bVknZC1KAFLpx3tNKZKI
         ebUNs+jmQYh+NSXRvL6yQN5BhZVz0rGozXV5fzFI5I3bLNeavLFmAwIoYXs+TdnPGJ
         u1YGWj9m6sfrjgTgVKzlFvIjK20IZ6sPAbsDr8NE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220727071025epcas2p291524394ff894074012c809c4472ef65~Fng8ecihB1321913219epcas2p2R;
        Wed, 27 Jul 2022 07:10:25 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Lt4g51fryz4x9Pv; Wed, 27 Jul
        2022 07:10:25 +0000 (GMT)
X-AuditID: b6c32a48-9e1ff700000025be-ed-62e0e4e1d6e9
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.47.09662.1E4E0E26; Wed, 27 Jul 2022 16:10:25 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v4 5/7] scsi: ufs: wb: Add ufshcd_is_wb_buf_flush_allowed()
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
In-Reply-To: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
Date:   Wed, 27 Jul 2022 16:10:24 +0900
X-CMS-MailID: 20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmme7DJw+SDD4fYbM4+WQNm8WDedvY
        LF7+vMpmcfBhJ4vFtA8/mS1eHtK0WHRjG5PF5V1z2Cy6r+9gs1h+/B+TA5fH5SveHov3vGTy
        mLDoAKPH9/UdbB4fn95i8ejbsorR4/MmOY/2A91MARxR2TYZqYkpqUUKqXnJ+SmZeem2St7B
        8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QCcqKZQl5pQChQISi4uV9O1sivJLS1IVMvKL
        S2yVUgtScgrMC/SKE3OLS/PS9fJSS6wMDQyMTIEKE7Izbt6+wl6wWrji5ffUBsbjAl2MnBwS
        AiYSs1s+MYPYQgI7GCVWfNXsYuTg4BUQlPi7QxgkLCzgLfHv2WUWiBIliXNrZjGClAgLGEjc
        6jUHCbMJ6En8XDKDrYuRi0NE4CyzxMKHU5ggxvNKzGh/ygJhS0tsX76VEcTmFPCTeDJzPitE
        XEPix7JeZghbVOLm6rfsMPb7Y/MZIWwRidZ7Z6FqBCUe/NwNFZeUOHToKxvIPRIC+RIbDgRC
        hGsk3i4/AFWiL3GtYyMLxFe+EvcmxIOEWQRUJU6svwtV4iLxafk3MJtZQF5i+9s5zCDlzAKa
        Eut36UMMV5Y4cosF5qeGjb/Z0dnMAnwSHYf/wsV3zHvCBNGqJrGoyQgiLCPx9fB89gmMSrMQ
        gTwLydpZCGsXMDKvYhRLLSjOTU8tNiowgcdqcn7uJkZwMtXy2ME4++0HvUOMTByMhxglOJiV
        RHgTou8nCfGmJFZWpRblxxeV5qQWH2I0BXp4IrOUaHI+MJ3nlcQbmlgamJiZGZobmRqYK4nz
        eqVsSBQSSE8sSc1OTS1ILYLpY+LglGpgckxn+v89mn21VGdx2sFN/yZ9LQ44LvnuP1shT/8u
        oc7001JKwifP/Y8+Mvmr4+QlHv6fLoTbZDxrfqByX3LHmRXXpz/pMn812f/NkRdKr6cwitxX
        VkirvtUdHDvTNvDKj8zHEz6JzGH059p1btXV2erLdnuVsPZ07ouO/nJO2WatyVdOJ/aCzpyL
        5RLLXJnd3Y7vXXiCKc6jUeF63GrbHYuNlJ5Y+V7YZpvKrnonLjFp/bSFFglybd9Un+iETI3p
        87nwMMWu4q5hrMzx0ms8EbMdT5cVPl98PatdUye+u/jCv8jtT9qZZhXGqmvKn2XqrVfcG+zY
        fbjd+oNm8xvtdr7bf+aUNlXNn3zX/fp8JZbijERDLeai4kQATm7UfS8EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d
References: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
        <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
        <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
        <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
        <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p7>
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

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
---
 drivers/ufs/core/ufs-sysfs.c | 3 +--
 drivers/ufs/core/ufshcd.c    | 5 +++--
 include/ufs/ufshcd.h         | 6 ++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.c
index e7800e49998a..63b02b2541c8 100644
--- a/drivers/ufs/core/ufs-sysfs.c
+++ b/drivers/ufs/core/ufs-sysfs.c
@@ -271,8 +271,7 @@ static ssize_t wb_buf_flush_en_store(struct device *dev,
 	unsigned int wb_buf_flush_en;
 	ssize_t res;
 
-	if (ufshcd_is_wb_allowed(hba) &&
-	   !(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL)) {
+	if (!ufshcd_is_wb_buf_flush_allowed(hba)) {
 		dev_warn(dev, "It is not allowed to configure WB buf flush!\n");
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index a8a797e0033d..17a14b046c44 100644
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
 
@@ -5816,7 +5817,7 @@ static bool ufshcd_wb_presrv_usrspc_keep_vcc_on(struct ufs_hba *hba,
 
 static void ufshcd_wb_force_disable(struct ufs_hba *hba)
 {
-	if (!(hba->quirks & UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL))
+	if (ufshcd_is_wb_buf_flush_allowed(hba))
 		ufshcd_wb_toggle_buf_flush(hba, false);
 
 	ufshcd_wb_toggle_buf_flush_during_h8(hba, false);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 94bcfec98fb8..78adc556444a 100644
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
-- 
2.25.1

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6607D4AA75D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 08:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379601AbiBEHlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 02:41:35 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:25133 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiBEHld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 02:41:33 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220205074131epoutp04fbea7b071419eb27279d8b2b3c9007ba~Q0_-v7xrX0305103051epoutp04y
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 07:41:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220205074131epoutp04fbea7b071419eb27279d8b2b3c9007ba~Q0_-v7xrX0305103051epoutp04y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644046891;
        bh=Z6M+dfMopclig4NKfROarEUPiNhyq+VID9hbdnT6TFU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=iXlueJeo9TmOmbMn6AKNbwMTDFyC7uKT//ZEFgkZHrwZcBHSW/gbcg+hGVS3KXz4r
         eYfE1+T3EXXHCWAsIv0cC7IHBAlpfpwHVS4czImV85oQrn459349FkczCVWXFp3lDu
         RcFS3w6PI7sLFgMBmMDq6GvFMGBM+dM7aGB5Sphc=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220205074130epcas2p2255aefe3fd092519611b94c32ec6ac4b~Q0_-IEfdr0419704197epcas2p2D;
        Sat,  5 Feb 2022 07:41:30 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.90]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JrPVK2Hhrz4x9Pw; Sat,  5 Feb
        2022 07:41:29 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.41.10018.A492EF16; Sat,  5 Feb 2022 16:37:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220205074128epcas2p40901c37a7328e825d8697f8d3269edba~Q0_9JRrJO1874818748epcas2p4n;
        Sat,  5 Feb 2022 07:41:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220205074128epsmtrp2ddc66177b0322d1997beda37f9b553fd~Q0_9Ex9dD1972219722epsmtrp2m;
        Sat,  5 Feb 2022 07:41:28 +0000 (GMT)
X-AuditID: b6c32a46-a25ff70000002722-df-61fe294a9c86
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.73.08738.82A2EF16; Sat,  5 Feb 2022 16:41:28 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220205074128epsmtip20cc86693488816c39065618fe7f185c9~Q0_84dX9k1888118881epsmtip2f;
        Sat,  5 Feb 2022 07:41:28 +0000 (GMT)
From:   Kiwoong Kim <kwmad.kim@samsung.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        cang@codeaurora.org, adrian.hunter@intel.com, sc.suh@samsung.com,
        hy50.seo@samsung.com, sh425.lee@samsung.com,
        bhoon95.kim@samsung.com, vkumar.1997@samsung.com
Cc:     Kiwoong Kim <kwmad.kim@samsung.com>
Subject: [PATCH v1] scsi: ufs: remove clk_scaling_lock when clkscaling isn't
 supported.
Date:   Sat,  5 Feb 2022 16:39:20 +0900
Message-Id: <1644046760-83345-1-git-send-email-kwmad.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVNdb81+iwZt9jBYnn6xhs3gwbxub
        xcufV9ksDj7sZLH4uvQZq8Wn9ctYLVYvfsBisejGNiaLm1uOslhc3jWHzaL7+g42i+XH/zFZ
        dN29wWix9N9bFos79z+yOPB7XO7rZfJYvOclk8eERQcYPb6v72Dz+Pj0FotH35ZVjB6fN8l5
        tB/oZgrgiMq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXL
        zAG6XkmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhg
        YGQKVJiQnbFofi9LwXLJihMHrjA2MC4Q7WLk5JAQMJE4eugwYxcjF4eQwA5GibV9jcwQzidG
        ial3OtkhnM+MEq37WllhWj73LGOCSOxilFj+5SALhPODUeLG7zOMIFVsApoST29OZQKxRQSu
        M0nM254BYjMLqEvsmnACLC4sECmxccJ9sHoWAVWJNd+ugtm8Aq4Sf5a/hdomJ3HzXCczhN3K
        IXH5lRmE7SIx7ctUFghbWOLV8S3sELaUxOd3e9m6GDmA7GKJTfvkQW6TEGhglFjyaTNUvbHE
        rGftjCA1zEB3rt+lD1GuLHHkFgvElXwSHYf/skOEeSU62oQgGpUlfk2azAhhS0rMvHkHqsRD
        onNRFkhYSCBW4u2+fYwTGGVnIYxfwMi4ilEstaA4Nz212KjACB5Fyfm5mxjByVHLbQfjlLcf
        9A4xMnEwHmKU4GBWEuHNnvY7UYg3JbGyKrUoP76oNCe1+BCjKTCwJjJLiSbnA9NzXkm8oYml
        gYmZmaG5kamBuZI4r1fKhkQhgfTEktTs1NSC1CKYPiYOTqkGJhmprmMna86JrOX9umT+nx9P
        du7bKr0wc+vfWwIee7o6xGLbGLZ8Wh7DMFfyfOuEHzIiqYbFySbvJ4bd/byEefJiY763TouS
        Hwgrzlr1yrWXVcOObePTZsvnsbJKUzeVnZL4XhBzN7XyjlYiW1Vdm2Xvi+xZp03ZfPzzNtz0
        2rXe5SeHdTiHReCM5S63As/FKm8w23K83WrjwQTJ2SZJMjVK55/cX1I6YWvf076e9rsrdP5E
        i1w5qd2uZdb/Jbja3Pm529Tq1Xv7tsZVPPgRfKf5sPadGeeOued1yWtsW85+sD9FPt34h8Rb
        XXEDBe3bCU+XqSoftVN5eNTVXqdtaxvj6QNdDyYqlxy/9OxHjBJLcUaioRZzUXEiANLNBQoX
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvK6G1r9Eg8YueYuTT9awWTyYt43N
        4uXPq2wWBx92slh8XfqM1eLT+mWsFqsXP2CxWHRjG5PFzS1HWSwu75rDZtF9fQebxfLj/5gs
        uu7eYLRY+u8ti8Wd+x9ZHPg9Lvf1Mnks3vOSyWPCogOMHt/Xd7B5fHx6i8Wjb8sqRo/Pm+Q8
        2g90MwVwRHHZpKTmZJalFunbJXBlLJrfy1KwXLLixIErjA2MC0S7GDk5JARMJD73LGMCsYUE
        djBKzGzlgohLSpzY+ZwRwhaWuN9yhLWLkQuo5hujxOyTzcwgCTYBTYmnN6cygSREBF4ySbyY
        s4YNJMEsoC6xa8IJsKnCAuESvas2soDYLAKqEmu+XQWbyivgKvFn+VtWiA1yEjfPdTJPYORZ
        wMiwilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOGi1tHYw7ln1Qe8QIxMH4yFGCQ5m
        JRHe7Gm/E4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        qj3Q8GbvBlGvM6YdT/r3PzwYyiDCs3PflOuXLe/7ipwSLFXdop3EUx6U+Ee3hFf3zytZhmd3
        H/5MXCcT1LJs6cslH0pD+LY5bJ3Lfk5t+7SY1jjfgooV/2qm3Xq/SZxvx2zbFerzF6/dllez
        LPjs1fIkA75vLJoOK5RnsMlMubZ3f929e1aTbq8+cazrfvvqVfeuqNgt2GT6+kUa64GjL7v+
        123YsKB0luiHCRLGHEyTeZf/vndchbn1/7Wp0dcviK9uMZScd1Dr2bpP9dbbP3geuqZuFFUt
        1ZSyKcpMY4HL7lO5DREpKtVmwX5zFO5qfm6Xc8hwqW3dP/nuZG0Zs7VVprHbG37sumPteX1K
        83MlluKMREMt5qLiRAB1qHgjyQIAAA==
X-CMS-MailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220205074128epcas2p40901c37a7328e825d8697f8d3269edba
References: <CGME20220205074128epcas2p40901c37a7328e825d8697f8d3269edba@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_scaling_lock is to prevent from running clkscaling related operations
with others which might be affected by the operations concurrently.
I think it looks hardware specific.
If the feature isn't supported, I think there is no reasonto prevent from
running other functions, such as ufshcd_queuecommand and
ufshcd_exec_dev_cmd, concurrently.

So I add a condition at some points protecting with clk_scaling_lock.

Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
---
 drivers/scsi/ufs/ufshcd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b4..8471c90 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2980,7 +2980,8 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
+	if (ufshcd_is_clkscaling_supported(hba))
+		down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
 	WARN_ON(lrbp->cmd);
@@ -2998,7 +2999,8 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
 out:
-	up_read(&hba->clk_scaling_lock);
+	if (ufshcd_is_clkscaling_supported(hba))
+		up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
@@ -6014,7 +6016,8 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
 		if (ufshcd_is_clkscaling_supported(hba) &&
 		    hba->clk_scaling.is_enabled)
 			ufshcd_suspend_clkscaling(hba);
-		ufshcd_clk_scaling_allow(hba, false);
+		if (ufshcd_is_clkscaling_supported(hba))
+			ufshcd_clk_scaling_allow(hba, false);
 	}
 	ufshcd_scsi_block_requests(hba);
 	/* Drain ufshcd_queuecommand() */
@@ -6247,7 +6250,8 @@ static void ufshcd_err_handler(struct work_struct *work)
 		 * Hold the scaling lock just in case dev cmds
 		 * are sent via bsg and/or sysfs.
 		 */
-		down_write(&hba->clk_scaling_lock);
+		if (ufshcd_is_clkscaling_supported(hba))
+			down_write(&hba->clk_scaling_lock);
 		hba->force_pmc = true;
 		pmc_err = ufshcd_config_pwr_mode(hba, &(hba->pwr_info));
 		if (pmc_err) {
@@ -6257,7 +6261,8 @@ static void ufshcd_err_handler(struct work_struct *work)
 		}
 		hba->force_pmc = false;
 		ufshcd_print_pwr_info(hba);
-		up_write(&hba->clk_scaling_lock);
+		if (ufshcd_is_clkscaling_supported(hba))
+			up_write(&hba->clk_scaling_lock);
 		spin_lock_irqsave(hba->host->host_lock, flags);
 	}
 
@@ -6753,7 +6758,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	/* Protects use of hba->reserved_slot. */
 	lockdep_assert_held(&hba->dev_cmd.lock);
 
-	down_read(&hba->clk_scaling_lock);
+	if (ufshcd_is_clkscaling_supported(hba))
+		down_read(&hba->clk_scaling_lock);
 
 	lrbp = &hba->lrb[tag];
 	WARN_ON(lrbp->cmd);
@@ -6822,7 +6828,8 @@ static int ufshcd_issue_devman_upiu_cmd(struct ufs_hba *hba,
 	ufshcd_add_query_upiu_trace(hba, err ? UFS_QUERY_ERR : UFS_QUERY_COMP,
 				    (struct utp_upiu_req *)lrbp->ucd_rsp_ptr);
 
-	up_read(&hba->clk_scaling_lock);
+	if (ufshcd_is_clkscaling_supported(hba))
+		up_read(&hba->clk_scaling_lock);
 	return err;
 }
 
-- 
2.7.4


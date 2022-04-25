Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF39650D6CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 04:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbiDYCGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 22:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236668AbiDYCGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:06:08 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490321D0DF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 19:03:05 -0700 (PDT)
Received: from epcas3p1.samsung.com (unknown [182.195.41.19])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220425020302epoutp0452c65309fd2bb07ae922f614a3cc2123~pAVAu4xOl1490314903epoutp04X
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:03:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220425020302epoutp0452c65309fd2bb07ae922f614a3cc2123~pAVAu4xOl1490314903epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650852182;
        bh=5EKRymzxC5Y24lGXxfIm4R/GuoFHPSZl5W8D6LBGYmA=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=He9QXoteCUweiuvEFaM4lohaE7IFwVW31TzJu/fhn8XQqVsUpBJY8rd1o8plLPBgJ
         niBuB74mXNvBRHX2sRau9n356g94i+rF0LWOx6VrHvakcOleZ1DCg1iDNV5ED0QBE3
         PD67ai3K0NL3fyM2euvKbwzlpnwcN75v1NSeCZ5Q=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p2.samsung.com (KnoxPortal) with ESMTP id
        20220425020301epcas3p28794e2186e7c53a1c105ce4c136461b4~pAVAImHx82393723937epcas3p2k;
        Mon, 25 Apr 2022 02:03:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4KmpFK4Q9fz4x9QK; Mon, 25 Apr 2022 02:03:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v3 1/6] scsi: ufshpb: Merge ufshpb_reset() and
 ufshpb_reset_host()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bean Huo <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220424220713.1253049-2-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01650852181605.JavaMail.epsvc@epcpadp4>
Date:   Mon, 25 Apr 2022 11:00:46 +0900
X-CMS-MailID: 20220425020046epcms2p1d8b984fc67793254397c4846010e1834
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220424220726epcas2p2a4824a1c187680fe519bfba447e23b32
References: <20220424220713.1253049-2-huobean@gmail.com>
        <20220424220713.1253049-1-huobean@gmail.com>
        <CGME20220424220726epcas2p2a4824a1c187680fe519bfba447e23b32@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

>From: Bean Huo <beanhuo@micron.com>
> 
>There is no functional change in this patch, just merge ufshpb_reset()
>and ufshpb_reset_host() into one function ufshpb_toggle_state().
> 
>Signed-off-by: Bean Huo <beanhuo@micron.com>
Looks good to me.

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong Park

>---
> drivers/scsi/ufs/ufshcd.c |  4 ++--
> drivers/scsi/ufs/ufshpb.c | 36 +++++++++++++-----------------------
> drivers/scsi/ufs/ufshpb.h |  6 ++----
> 3 files changed, 17 insertions(+), 29 deletions(-)
> 
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>index 3f9caafa91bf..62c7f5404353 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -7223,7 +7223,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
>          * Stop the host controller and complete the requests
>          * cleared by h/w
>          */
>-        ufshpb_reset_host(hba);
>+        ufshpb_toggle_state(hba, HPB_PRESENT, HPB_RESET);
>         ufshcd_hba_stop(hba);
>         hba->silence_err_logs = true;
>         ufshcd_complete_requests(hba);
>@@ -8184,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>         /* Enable Auto-Hibernate if configured */
>         ufshcd_auto_hibern8_enable(hba);
> 
>-        ufshpb_reset(hba);
>+        ufshpb_toggle_state(hba, HPB_RESET, HPB_PRESENT);
> out:
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         if (ret)
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index fd31e516e491..167643969165 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -2272,38 +2272,28 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
>         return flag_res;
> }
> 
>-void ufshpb_reset(struct ufs_hba *hba)
>+/**
>+ * ufshpb_toggle_state - switch HPB state of all LUs
>+ * @hba: per-adapter instance
>+ * @src: expected current HPB state
>+ * @dest: target HPB state to switch to
>+ */
>+void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest)
> {
>         struct ufshpb_lu *hpb;
>         struct scsi_device *sdev;
> 
>         shost_for_each_device(sdev, hba->host) {
>                 hpb = ufshpb_get_hpb_data(sdev);
>-                if (!hpb)
>-                        continue;
>-
>-                if (ufshpb_get_state(hpb) != HPB_RESET)
>-                        continue;
>-
>-                ufshpb_set_state(hpb, HPB_PRESENT);
>-        }
>-}
>-
>-void ufshpb_reset_host(struct ufs_hba *hba)
>-{
>-        struct ufshpb_lu *hpb;
>-        struct scsi_device *sdev;
> 
>-        shost_for_each_device(sdev, hba->host) {
>-                hpb = ufshpb_get_hpb_data(sdev);
>-                if (!hpb)
>+                if (!hpb || ufshpb_get_state(hpb) != src)
>                         continue;
>+                ufshpb_set_state(hpb, dest);
> 
>-                if (ufshpb_get_state(hpb) != HPB_PRESENT)
>-                        continue;
>-                ufshpb_set_state(hpb, HPB_RESET);
>-                ufshpb_cancel_jobs(hpb);
>-                ufshpb_discard_rsp_lists(hpb);
>+                if (dest == HPB_RESET) {
>+                        ufshpb_cancel_jobs(hpb);
>+                        ufshpb_discard_rsp_lists(hpb);
>+                }
>         }
> }
> 
>diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
>index b475dbd78988..7aa0dc58ee9f 100644
>--- a/drivers/scsi/ufs/ufshpb.h
>+++ b/drivers/scsi/ufs/ufshpb.h
>@@ -288,8 +288,7 @@ static int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) { return 0;
> static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) {}
> static void ufshpb_resume(struct ufs_hba *hba) {}
> static void ufshpb_suspend(struct ufs_hba *hba) {}
>-static void ufshpb_reset(struct ufs_hba *hba) {}
>-static void ufshpb_reset_host(struct ufs_hba *hba) {}
>+static void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest) {}
> static void ufshpb_init(struct ufs_hba *hba) {}
> static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
> static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
>@@ -303,8 +302,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
> void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
> void ufshpb_resume(struct ufs_hba *hba);
> void ufshpb_suspend(struct ufs_hba *hba);
>-void ufshpb_reset(struct ufs_hba *hba);
>-void ufshpb_reset_host(struct ufs_hba *hba);
>+void ufshpb_toggle_state(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest);
> void ufshpb_init(struct ufs_hba *hba);
> void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
> void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
>-- 
>2.34.1
> 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057695080BA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359442AbiDTFzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241337AbiDTFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:55:50 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC72BF74
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:53:04 -0700 (PDT)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220420055302epoutp0313e3e8ef9e570f98436648d2b9b578a1~nhPZmDX3q0160901609epoutp03t
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220420055302epoutp0313e3e8ef9e570f98436648d2b9b578a1~nhPZmDX3q0160901609epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650433982;
        bh=lcRQV78t3Jw2wIP2pxcHG8gRk4NGI/jXuQE0HrIpy4c=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=GLA3mmE8p5xTi2QQgb7tCJsvJtAYCzIwjkgV7dKUxjyEgRAuBYY5PpSlnUvfVQv7D
         zHH3mpWhh2+OUcEMI25gnrIYoP01sY4IYNy1GmRLb4FrpiqnJCDpyh/cVHYwQ4U6tU
         bZEjQ+TvynLQpKIe1zsxWI7Ip87JsM1XyGAx11oQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas3p2.samsung.com (KnoxPortal) with ESMTP id
        20220420055301epcas3p2d8bd2308bc8c2011be07177187d88aff~nhPZEC82m0546205462epcas3p2i;
        Wed, 20 Apr 2022 05:53:01 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp4.localdomain
        (Postfix) with ESMTP id 4Kjqb14TP8z4x9QJ; Wed, 20 Apr 2022 05:53:01 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v2 1/5] scsi: ufshpb: Merge ufshpb_reset() and
 ufshpb_reset_host()
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     Bean Huo <huobean@gmail.com>,
        ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20220419183044.789065-2-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1891546521.01650433981606.JavaMail.epsvc@epcpadp4>
Date:   Wed, 20 Apr 2022 11:47:22 +0900
X-CMS-MailID: 20220420024722epcms2p8f6db75c668cf6df9496ee9d309dfa73a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220419183926epcas2p4f529c4cc6bed9ba4b6536f3a5977c3f2
References: <20220419183044.789065-2-huobean@gmail.com>
        <20220419183044.789065-1-huobean@gmail.com>
        <CGME20220419183926epcas2p4f529c4cc6bed9ba4b6536f3a5977c3f2@epcms2p8>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

>From: Bean Huo <beanhuo@micron.com>
> 
>There is no functional change in this patch, just merge ufshpb_reset() and
>ufshpb_reset_host() into one function ufshpb_toggle()
> 
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>---
> drivers/scsi/ufs/ufshcd.c |  4 ++--
> drivers/scsi/ufs/ufshpb.c | 36 +++++++++++++-----------------------
> drivers/scsi/ufs/ufshpb.h |  6 ++----
> 3 files changed, 17 insertions(+), 29 deletions(-)
> 
>diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>index 0899d5b8cdad..de0bc53e3ac6 100644
>--- a/drivers/scsi/ufs/ufshcd.c
>+++ b/drivers/scsi/ufs/ufshcd.c
>@@ -7223,7 +7223,7 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
>          * Stop the host controller and complete the requests
>          * cleared by h/w
>          */
>-        ufshpb_reset_host(hba);
>+        ufshpb_toggle(hba, HPB_PRESENT, HPB_RESET);
>         ufshcd_hba_stop(hba);
>         hba->silence_err_logs = true;
>         ufshcd_complete_requests(hba);
>@@ -8184,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
>         /* Enable Auto-Hibernate if configured */
>         ufshcd_auto_hibern8_enable(hba);
> 
>-        ufshpb_reset(hba);
>+        ufshpb_toggle(hba, HPB_RESET, HPB_PRESENT);
> out:
>         spin_lock_irqsave(hba->host->host_lock, flags);
>         if (ret)
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index 3ca745ad616c..9df032e82ec3 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -2278,38 +2278,28 @@ static bool ufshpb_check_hpb_reset_query(struct ufs_hba *hba)
>         return flag_res;
> }
> 
>-void ufshpb_reset(struct ufs_hba *hba)
>+/**
>+ * ufshpb_toggle - switch HPB state of all LUs
>+ * @hba: per-adapter instance
>+ * @src: expected current HPB state
>+ * @dest: target HPB state to switch to
>+ */
>+void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest)
How about changing it to something like ufshpb_state_toggle()?

Best Regards,
Keoseong Park

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
>index b475dbd78988..2825ec69a6a6 100644
>--- a/drivers/scsi/ufs/ufshpb.h
>+++ b/drivers/scsi/ufs/ufshpb.h
>@@ -288,8 +288,7 @@ static int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) { return 0;
> static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp) {}
> static void ufshpb_resume(struct ufs_hba *hba) {}
> static void ufshpb_suspend(struct ufs_hba *hba) {}
>-static void ufshpb_reset(struct ufs_hba *hba) {}
>-static void ufshpb_reset_host(struct ufs_hba *hba) {}
>+static void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest) {}
> static void ufshpb_init(struct ufs_hba *hba) {}
> static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
> static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev) {}
>@@ -303,8 +302,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
> void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
> void ufshpb_resume(struct ufs_hba *hba);
> void ufshpb_suspend(struct ufs_hba *hba);
>-void ufshpb_reset(struct ufs_hba *hba);
>-void ufshpb_reset_host(struct ufs_hba *hba);
>+void ufshpb_toggle(struct ufs_hba *hba, enum UFSHPB_STATE src, enum UFSHPB_STATE dest);
> void ufshpb_init(struct ufs_hba *hba);
> void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev);
> void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);
>-- 
>2.34.1
> 
> 

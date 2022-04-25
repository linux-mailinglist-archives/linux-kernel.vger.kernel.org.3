Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2950D7A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 05:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240664AbiDYDlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiDYDlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 23:41:16 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2E1A81B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 20:38:09 -0700 (PDT)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220425033802epoutp03a5cfba1cd164148d7373962cb7250c71~pBn9rryAq1023310233epoutp03H
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220425033802epoutp03a5cfba1cd164148d7373962cb7250c71~pBn9rryAq1023310233epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650857882;
        bh=kLLPKOJheZoOZst7vOsZrRhAcfeNzU817A4tSgnfK0o=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=N8+1pfH+xTmEcOLEQ0R7cUIMBH84clMQLovgLoY6j5v65ymtD+OvaOvPk/Hxzmron
         yXTzWlV/ePr9dYvl5eu2+4alQR1VCDbBLyTPPqXHWrHghlA/ghN39gsP0kH2fkeOwz
         rfHeU0tCjZrdnad+Xem7QBXOQYpbQUtxXo0M1S8I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220425033802epcas3p15634c5ad5d04c529fc8c036a2dab9b25~pBn9Me9Ek1747617476epcas3p1K;
        Mon, 25 Apr 2022 03:38:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp2.localdomain
        (Postfix) with ESMTP id 4KmrLy1B7wz4x9Q0; Mon, 25 Apr 2022 03:38:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v3 3/6] scsi: ufshpb: Cleanup the handler when device
 reset HPB information
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
In-Reply-To: <20220424220713.1253049-4-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1889248251.21650857882164.JavaMail.epsvc@epcpadp4>
Date:   Mon, 25 Apr 2022 12:23:46 +0900
X-CMS-MailID: 20220425032346epcms2p17f067428de98f364f97be8eb5381d9dc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220424220758epcas2p1c518cbee68ebefaf1565909f60711561
References: <20220424220713.1253049-4-huobean@gmail.com>
        <20220424220713.1253049-1-huobean@gmail.com>
        <CGME20220424220758epcas2p1c518cbee68ebefaf1565909f60711561@epcms2p1>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Bean Huo <beanhuo@micron.com>
>=20
>"When the device is powered off by the host, the device may restore L2P ma=
p data
>upon power up or build from the host=E2=80=99s HPB READ command. In case d=
evice powered
>up and lost HPB information, device can signal to the host through HPB Sen=
se data,
>by setting HPB Operation as =E2=80=982=E2=80=99 which will inform the host=
 that device reset HPB
>information."
>=20
>This patch is to clean up the handler and make the intent of this handler =
more
>readable, no functional change.
>=20
>Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong Park

>---
> drivers/scsi/ufs/ufshpb.c | 35 +++++++++++++++++++++++------------
> 1 file changed, 23 insertions(+), 12 deletions(-)
>=20
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index 167643969165..f1f30d4c3d65 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -1225,7 +1225,10 @@ static void ufshpb_rsp_req_region_update(struct ufs=
hpb_lu *hpb,
>                 queue_work(ufshpb_wq, &hpb->map_work);
> }
>=20
>-static void ufshpb_dev_reset_handler(struct ufshpb_lu *hpb)
>+/*
>+ * Set the flags of all active regions to RGN_FLAG_UPDATE to let host sid=
e reload L2P entries later
>+ */
>+static void ufshpb_set_regions_update(struct ufshpb_lu *hpb)
> {
>         struct victim_select_info *lru_info =3D &hpb->lru_info;
>         struct ufshpb_region *rgn;
>@@ -1239,6 +1242,24 @@ static void ufshpb_dev_reset_handler(struct ufshpb_=
lu *hpb)
>         spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
> }
>=20
>+static void ufshpb_dev_reset_handler(struct ufs_hba *hba)
>+{
>+        struct scsi_device *sdev;
>+        struct ufshpb_lu *hpb;
>+
>+        __shost_for_each_device(sdev, hba->host) {
>+                hpb =3D ufshpb_get_hpb_data(sdev);
>+                if (hpb && hpb->is_hcm)
>+                        /*
>+                         * For the HPB host mode, in case device powered =
up and lost HPB
>+                         * information, we will set the region flag to be=
 RGN_FLAG_UPDATE,
>+                         * it will let host reload its L2P entries(re-act=
ivate the region
>+                         * in the UFS device).
>+                         */
>+                        ufshpb_set_regions_update(hpb);
>+        }
>+}
>+
> /*
>  * This function will parse recommended active subregion information in s=
ense
>  * data field of response UPIU with SAM_STAT_GOOD state.
>@@ -1313,17 +1334,7 @@ void ufshpb_rsp_upiu(struct ufs_hba *hba, struct uf=
shcd_lrb *lrbp)
>         case HPB_RSP_DEV_RESET:
>                 dev_warn(&hpb->sdev_ufs_lu->sdev_dev,
>                          "UFS device lost HPB information during PM.\n");
>-
>-                if (hpb->is_hcm) {
>-                        struct scsi_device *sdev;
>-
>-                        __shost_for_each_device(sdev, hba->host) {
>-                                struct ufshpb_lu *h =3D sdev->hostdata;
>-
>-                                if (h)
>-                                        ufshpb_dev_reset_handler(h);
>-                        }
>-                }
>+                ufshpb_dev_reset_handler(hba);
>=20
>                 break;
>         default:
>--=20
>2.34.1
>=20
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE185080BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359461AbiDTF4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 01:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359443AbiDTFzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 01:55:54 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3659DED7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 22:53:08 -0700 (PDT)
Received: from epcas3p4.samsung.com (unknown [182.195.41.22])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220420055302epoutp02b86766413fba097997de3607fbf94b40~nhPaQRNCo1974519745epoutp02I
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220420055302epoutp02b86766413fba097997de3607fbf94b40~nhPaQRNCo1974519745epoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650433983;
        bh=RFg2GFARn3OEAPm61BfWvSGMJNe57DN3zV3e1mXnTJg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=duPI7ypXhXqQTdxhz2tzd4XNrS+YgYhUvu77d8747C4kIjz5ISbgRVpi4/Da/jG3K
         k+O6qh8Qid4kkjphTi7ScWS0Vf5YJofOl0qyd0i+6ejNz99Pk2OuhcZA9/314sTxRD
         oW5rTtG08hei/pEKW2Kk9FQzl+4lkhNFBCMRo3r4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20220420055302epcas3p312c7c243e82ca629daaad8b747b44216~nhPZySKAr0579705797epcas3p3S;
        Wed, 20 Apr 2022 05:53:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4Kjqb232LYz4x9QW; Wed, 20 Apr 2022 05:53:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v2 4/5] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
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
In-Reply-To: <20220419183044.789065-5-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1381713434.41650433982422.JavaMail.epsvc@epcpadp4>
Date:   Wed, 20 Apr 2022 14:31:17 +0900
X-CMS-MailID: 20220420053117epcms2p72dd1a5dfcc6ab4ba72d46f84998259f6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220419183934epcas2p28272bfd9167253c2d9136c60f9050c5f
References: <20220419183044.789065-5-huobean@gmail.com>
        <20220419183044.789065-1-huobean@gmail.com>
        <CGME20220419183934epcas2p28272bfd9167253c2d9136c60f9050c5f@epcms2p7>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

>From: Bean Huo <beanhuo@micron.com>
>=20
>In UFS HPB Spec JESD220-3A,
>=20
>"5.8. Active and inactive information upon power cycle
>...
>When the device is powered off by the host, the device may restore L2P map=
 data
>upon power up or build from the host=E2=80=99s HPB READ command. In case d=
evice powered
>up and lost HPB information, device can signal to the host through HPB Sen=
se data,
>by setting HPB Operation as =E2=80=982=E2=80=99 which will inform the host=
 that device reset HPB
>information."
>=20
>Therefore, for HPB device control mode, if the UFS device is reset via the=
 RST_N
>pin, the active region information in the device will be reset. If the hos=
t side
>receives this notification from the device side, it is recommended to inac=
tivate
>all active regions in the host's HPB cache.
>=20
>Signed-off-by: Bean Huo <beanhuo@micron.com>
>---
> drivers/scsi/ufs/ufshpb.c | 73 ++++++++++++++++++++++++++++-----------
> 1 file changed, 53 insertions(+), 20 deletions(-)
>=20
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index 4538164fc493..4b15fa862beb 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -1143,6 +1143,39 @@ static int ufshpb_add_region(struct ufshpb_lu *hpb,=
 struct ufshpb_region *rgn)
>         spin_unlock_irqrestore(&hpb->rgn_state_lock, flags);
>         return ret;
> }
>+/**
>+ *ufshpb_submit_region_inactive() - submit a region to be inactivated lat=
er
>+ *@hpb: per-LU HPB instance
>+ *@region_index: the index associated with the region that will be inacti=
vated later
>+ */
>+static void ufshpb_submit_region_inactive(struct ufshpb_lu *hpb, int regi=
on_index)
>+{
>+        int subregion_index;
>+        struct ufshpb_region *rgn;
>+        struct ufshpb_subregion *srgn;
>+
>+        /*
>+         * Remove this region from active region list and add it to inact=
ive list
>+         */
>+        spin_lock(&hpb->rsp_list_lock);
>+        ufshpb_update_inactive_info(hpb, region_index);
How about separating the "hpb->stats.rb_inactive_cnt++" code from ufshpb_up=
date_inactive_info()?
Because I think this code should only be used in ufshpb_rsp_req_region_upda=
te().

>+        spin_unlock(&hpb->rsp_list_lock);
>+
>+        rgn =3D hpb->rgn_tbl + region_index;
>+
>+        /*
>+         * Set subregion state to be HPB_SRGN_INVALID, there will no HPB =
read on this subregion
>+         */
>+        spin_lock(&hpb->rgn_state_lock);
>+        if (rgn->rgn_state !=3D HPB_RGN_INACTIVE) {
>+                for (subregion_index =3D 0; subregion_index < rgn->srgn_c=
nt; subregion_index++) {
>+                        srgn =3D rgn->srgn_tbl + subregion_index;
>+                        if (srgn->srgn_state =3D=3D HPB_SRGN_VALID)
>+                                srgn->srgn_state =3D HPB_SRGN_INVALID;
>+                }
>+        }
>+        spin_unlock(&hpb->rgn_state_lock);
>+}
>=20
> static void ufshpb_rsp_req_region_update(struct ufshpb_lu *hpb,
>                                          struct utp_hpb_rsp *rsp_field)
>@@ -1202,25 +1235,8 @@ static void ufshpb_rsp_req_region_update(struct ufs=
hpb_lu *hpb,
>=20
>         for (i =3D 0; i < rsp_field->inactive_rgn_cnt; i++) {
>                 rgn_i =3D be16_to_cpu(rsp_field->hpb_inactive_field[i]);
>-                dev_dbg(&hpb->sdev_ufs_lu->sdev_dev,
>-                        "inactivate(%d) region %d\n", i, rgn_i);
>-
>-                spin_lock(&hpb->rsp_list_lock);
>-                ufshpb_update_inactive_info(hpb, rgn_i);
>-                spin_unlock(&hpb->rsp_list_lock);
>-
>-                rgn =3D hpb->rgn_tbl + rgn_i;
>-
>-                spin_lock(&hpb->rgn_state_lock);
>-                if (rgn->rgn_state !=3D HPB_RGN_INACTIVE) {
>-                        for (srgn_i =3D 0; srgn_i < rgn->srgn_cnt; srgn_i=
++) {
>-                                srgn =3D rgn->srgn_tbl + srgn_i;
>-                                if (srgn->srgn_state =3D=3D HPB_SRGN_VALI=
D)
>-                                        srgn->srgn_state =3D HPB_SRGN_INV=
ALID;
>-                        }
>-                }
>-                spin_unlock(&hpb->rgn_state_lock);
>-
>+                dev_dbg(&hpb->sdev_ufs_lu->sdev_dev, "inactivate(%d) regi=
on %d\n", i, rgn_i);
>+                ufshpb_submit_region_inactive(hpb, rgn_i);
>         }
>=20
> out:
>@@ -1255,7 +1271,10 @@ static void ufshpb_dev_reset_handler(struct ufs_hba=
 *hba)
>=20
>         __shost_for_each_device(sdev, hba->host) {
>                 hpb =3D ufshpb_get_hpb_data(sdev);
>-                if (hpb && hpb->is_hcm)
>+                if (!hpb)
>+                        continue;
>+
>+                if (hpb->is_hcm) {
>                         /*
>                          * For the HPB host mode, in case device powered =
up and lost HPB
For the HPB host control mode, ...

>                          * information, we will set the region flag to be=
 RGN_FLAG_UPDATE,
>@@ -1263,6 +1282,20 @@ static void ufshpb_dev_reset_handler(struct ufs_hba=
 *hba)
>                          * in the UFS device).
>                          */
>                         ufshpb_set_regions_update(hpb);
>+                } else {
>+                        /*
>+                         * For the HPB device mode, we add all active reg=
ions to inactive list,
For the HPB device control mode, ...

>+                         * they will be inactivated later in ufshpb_map_w=
ork_handler()
>+                         */
>+                        struct victim_select_info *lru_info =3D &hpb->lru=
_info;
>+                        struct ufshpb_region *rgn;
>+
>+                        list_for_each_entry(rgn, &lru_info->lh_lru_rgn, l=
ist_lru_rgn)
>+                                ufshpb_submit_region_inactive(hpb, rgn->r=
gn_idx);
>+
>+                        if (ufshpb_get_state(hpb) =3D=3D HPB_PRESENT)
>+                                queue_work(ufshpb_wq, &hpb->map_work);
>+                }
>         }
> }
>=20
>--=20
>2.34.1
>=20
>=20

Best Regards,
Keoseong Park

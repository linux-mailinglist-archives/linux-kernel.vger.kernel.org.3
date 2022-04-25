Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BB650D828
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 06:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiDYEMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 00:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238959AbiDYELV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 00:11:21 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0732118E10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 21:08:05 -0700 (PDT)
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220425040803epoutp04f6542046d4d83dfbb54fecfcb9fc4748~pCCKm5hJd0156401564epoutp04n
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:08:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220425040803epoutp04f6542046d4d83dfbb54fecfcb9fc4748~pCCKm5hJd0156401564epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650859683;
        bh=ysCeGAZbJmfIpJ2BTe1KDt+Ea1Y2UlSnlu5rWTG3AQg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=HEVcBLts9rhAXNnfG6CBOlPFDqMIcBIcTAcSwr0KRfl2TkUe4r41AcoRVGbY5n1wx
         d+/dZAba0EQZqUeDZvwaPHRQZsCLY5KyFhmot40kJ20Bit1WVWfzMkGPdS2Bht50mq
         kqlJauqEnqNQRm3TYTPe8GUctTsbrmKd2Of3hB5Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas3p1.samsung.com (KnoxPortal) with ESMTP id
        20220425040802epcas3p19682822a319aedd2870fa1aeffada508~pCCKJoJEb1934819348epcas3p1f;
        Mon, 25 Apr 2022 04:08:02 +0000 (GMT)
Received: from epcpadp4 (unknown [182.195.40.18]) by epsnrtp3.localdomain
        (Postfix) with ESMTP id 4Kms1Z5Ccbz4x9Q3; Mon, 25 Apr 2022 04:08:02 +0000
        (GMT)
Mime-Version: 1.0
Subject: RE: [PATCH v3 5/6] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
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
In-Reply-To: <20220424220713.1253049-6-huobean@gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <1796371666.21650859682732.JavaMail.epsvc@epcpadp4>
Date:   Mon, 25 Apr 2022 12:54:04 +0900
X-CMS-MailID: 20220425035404epcms2p49ec6b7202d89e665a93ff92c662d0519
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20220424220755epcas2p231c49e8ae1326d63429b0fdd31600733
References: <20220424220713.1253049-6-huobean@gmail.com>
        <20220424220713.1253049-1-huobean@gmail.com>
        <CGME20220424220755epcas2p231c49e8ae1326d63429b0fdd31600733@epcms2p4>
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
> drivers/scsi/ufs/ufshpb.c | 82 +++++++++++++++++++++++++++------------
> 1 file changed, 58 insertions(+), 24 deletions(-)
>=20
>diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
>index e7f311bb4401..7868412054bf 100644
>--- a/drivers/scsi/ufs/ufshpb.c
>+++ b/drivers/scsi/ufs/ufshpb.c
>@@ -1137,6 +1137,39 @@ static int ufshpb_add_region(struct ufshpb_lu *hpb,=
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
>@@ -1196,25 +1229,8 @@ static void ufshpb_rsp_req_region_update(struct ufs=
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
>@@ -1249,14 +1265,32 @@ static void ufshpb_dev_reset_handler(struct ufs_hb=
a *hba)
>=20
>         __shost_for_each_device(sdev, hba->host) {
>                 hpb =3D ufshpb_get_hpb_data(sdev);
>-                if (hpb && hpb->is_hcm)
>+                if (!hpb)
>+                        continue;
>+
>+                if (hpb->is_hcm) {
>                         /*
>-                         * For the HPB host mode, in case device powered =
up and lost HPB
>-                         * information, we will set the region flag to be=
 RGN_FLAG_UPDATE,
>-                         * it will let host reload its L2P entries(re-act=
ivate the region
>-                         * in the UFS device).
>+                         * For the HPB host control mode, in case device =
powered up and lost HPB
>+                         * information, we will set the region flag to be=
 RGN_FLAG_UPDATE, it will
>+                         * let host reload its L2P entries(reactivate reg=
ion in the UFS device).
>                          */
>                         ufshpb_set_regions_update(hpb);
>+                } else {
>+                        /*
>+                         * For the HPB device control mode, if host side =
receives 02h:HPB Operation
>+                         * in UPIU response, which means device recommend=
s the host side should
>+                         * inactivate all active regions. Here we add all=
 active regions to inactive
>+                         * list, they will be inactivated later in ufshpb=
_map_work_handler().
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
Looks good to me.

Reviewed-by: Keoseong Park <keosung.park@samsung.com>

Best Regards,
Keoseong Park

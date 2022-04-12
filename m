Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D5E4FE456
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356840AbiDLPIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiDLPIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:08:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9315C362;
        Tue, 12 Apr 2022 08:06:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bv19so14926898ejb.6;
        Tue, 12 Apr 2022 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=On6x4n5aVEZBUYriyh4Itpr/oxnyB3oIsnuoMQ6fdAo=;
        b=DXB30EkRvzrBh6ZH6ZmHCtoT7jsazmOtDBN7ieFDUsPgAgzUrDKXpDQhxEfAEwGJ8C
         BQCXHKHPy2//FojkJMa2AlscVJJoKWuR6Da0D1DfjZkCNPhlAGPjvut2Adw6W9afHRVH
         E+nIO4J30jZENSGFuVZkTNY6HhCtEq961/VlsyWpgRfM/Ys8Vdje1HPojgtdZoBRCY/I
         bQmSlZzUyAdU8fXoRYMnlsB9/99ghL7WCgAD8345Fnj2U3Khy8br1GliikH88YXsmmBx
         WtBxsQ0lQHUngUYa410+pD05iHX9gPT1Z/HFHXJUjGdCbs0Bue4yQSZmRvaw3bfzYxUC
         8k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=On6x4n5aVEZBUYriyh4Itpr/oxnyB3oIsnuoMQ6fdAo=;
        b=oZXm4II7qx4m1JR+hDcmSqlNKMOWf+LLU+XN1ep+7JXCvPMQy0s0+DWEeS3Dc9xYNu
         5OLzJ74CZJ6PV/mwtqaUbtnfEIZaPNsn5Ys62r5laC1qwhVmwZcFq1dT3QKKUzcnyEh3
         1l0fOZvKaZQ+0aN9AZbyZRKmlA/FvqQ3/JGWKaV8kOd3GTcZrauKMzPSiZdlst1jtM06
         zs2M4nND0AAEXcjj05ESNd9qr9+rSFRWoyFMMRUp4DY8cR1DsbWKb34BCfDAuq1TS9eY
         kTjUdjF3UMo1OMEVEN/lyJ7dkDrtjCooRv7SiZIoHtY5SWauFkinnCKcCAZifrtSxTnE
         9hPA==
X-Gm-Message-State: AOAM530MhIw5jKqv595JcCBgR45f3CeDuWeE65IDWx8frH2snUB1Yk9x
        XNA1KmfmWaKN1vsEG06oIJE=
X-Google-Smtp-Source: ABdhPJzR7mWeT6i+zXp188jOFrfIe5psN5Vd6PinMp5BKJfDAGiN3tkP1HiUL2tp5T6YSB1pyfYMYA==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr36400111ejo.523.1649775985927;
        Tue, 12 Apr 2022 08:06:25 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm16811031edv.65.2022.04.12.08.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:06:24 -0700 (PDT)
Message-ID: <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
From:   Bean Huo <huobean@gmail.com>
To:     Po-Wen Kao <powen.kao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        yohan.joung@sk.com, jason.li@sk.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Tue, 12 Apr 2022 17:06:23 +0200
In-Reply-To: <20220412073131.10644-1-powen.kao@mediatek.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-12 at 15:31 +0800, Po-Wen Kao wrote:
> Since the HPB mapping is already reset in ufshpb_init by setting
> flag QUERY_FLAG_IDN_HPB_RESET, there is no need doing so again in
> ufshpb_hpb_lu_prepared.
>=20
> This would also resolve the issue where HPB WRTIE BUFFER is issued
> before UAC being cleared.
>=20
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
> =C2=A0drivers/scsi/ufs/ufshpb.c | 7 -------
> =C2=A01 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
> index a86d0cc50de2..5c09d44c4bd5 100644
> --- a/drivers/scsi/ufs/ufshpb.c
> +++ b/drivers/scsi/ufs/ufshpb.c
> @@ -934,11 +934,6 @@ static int ufshpb_issue_umap_single_req(struct
> ufshpb_lu *hpb,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ufshpb_issue_umap_=
req(hpb, rgn, true);
> =C2=A0}
> =C2=A0
> -static int ufshpb_issue_umap_all_req(struct ufshpb_lu *hpb)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ufshpb_issue_umap_req(h=
pb, NULL, false);
> -}
> -
> =C2=A0static void __ufshpb_evict_region(struct ufshpb_lu *hpb,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ufshpb_region *rgn)
> =C2=A0{
> @@ -2459,8 +2454,6 @@ static void ufshpb_hpb_lu_prepared(struct
> ufs_hba *hba)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ufs=
hpb_set_state(hpb, HPB_PRESENT);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
((hpb->lu_pinned_end - hpb-
> >lu_pinned_start) > 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0queue_work(ufshpb_wq, &hpb-
> >map_work);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!hpb-=
>is_hcm)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ufshpb_issue_umap_all_req(hpb);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0} else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
_err(hba->dev, "destroy HPB lu %d\n", hpb-
> >lun);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ufs=
hpb_destroy_lu(hba, sdev);


Hi Po-Wen,
Yes, it is redundant in this flow, but it is needed in the reset flow,
I built this cleanup patch, but don't know if it can fix the issue
where HPB WRTIE BUFFER is issued before UAC being cleared. would you
test on your platform? I will verify it on our UFS later.



Subject: [PATCH] scsi: ufshpb: UFSHPB cleanup

Remove redundant ufshpb_reset*, and merge into a single helper
ufshbp_state_toggle().

Delete the redundant Inactivation code of all HPB Regions in the cold
boot stage, and add inactivating all HPB Regions when the HPP status
changes from HPB_RESET to HBP_PRESENT.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshcd.c |  4 ++--
 drivers/scsi/ufs/ufshpb.c | 38 +++++++++++++-------------------------
 drivers/scsi/ufs/ufshpb.h |  6 ++----
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 0899d5b8cdad..d8b59d017ce4 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7223,7 +7223,7 @@ static int ufshcd_host_reset_and_restore(struct
ufs_hba *hba)
 	 * Stop the host controller and complete the requests
 	 * cleared by h/w
 	 */
-	ufshpb_reset_host(hba);
+	ufshpb_state_toggle(hba, HPB_RESET);
 	ufshcd_hba_stop(hba);
 	hba->silence_err_logs =3D true;
 	ufshcd_complete_requests(hba);
@@ -8184,7 +8184,7 @@ static int ufshcd_probe_hba(struct ufs_hba *hba,
bool init_dev_params)
 	/* Enable Auto-Hibernate if configured */
 	ufshcd_auto_hibern8_enable(hba);
=20
-	ufshpb_reset(hba);
+	ufshpb_state_toggle(hba, HPB_PRESENT);
 out:
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	if (ret)
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 3ca745ad616c..4ed156031413 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2278,39 +2278,29 @@ static bool ufshpb_check_hpb_reset_query(struct
ufs_hba *hba)
 	return flag_res;
 }
=20
-void ufshpb_reset(struct ufs_hba *hba)
+void ufshpb_state_toggle(struct ufs_hba *hba, enum UFSHPB_STATE state)
 {
 	struct ufshpb_lu *hpb;
 	struct scsi_device *sdev;
=20
 	shost_for_each_device(sdev, hba->host) {
 		hpb =3D ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
=20
-		if (ufshpb_get_state(hpb) !=3D HPB_RESET)
+		if (!hpb || ufshpb_get_state(hpb) !=3D state)
 			continue;
=20
-		ufshpb_set_state(hpb, HPB_PRESENT);
-	}
-}
-
-void ufshpb_reset_host(struct ufs_hba *hba)
-{
-	struct ufshpb_lu *hpb;
-	struct scsi_device *sdev;
-
-	shost_for_each_device(sdev, hba->host) {
-		hpb =3D ufshpb_get_hpb_data(sdev);
-		if (!hpb)
-			continue;
-
-		if (ufshpb_get_state(hpb) !=3D HPB_PRESENT)
-			continue;
-		ufshpb_set_state(hpb, HPB_RESET);
-		ufshpb_cancel_jobs(hpb);
-		ufshpb_discard_rsp_lists(hpb);
+		ufshpb_set_state(hpb, state);
+		if (state =3D=3D HPB_RESET) {
+			ufshpb_cancel_jobs(hpb);
+			ufshpb_discard_rsp_lists(hpb);
+		}
 	}
+	/*
+	 * Inactivating all HPB Region in device side in case HPB
state changed
+	 * from HPB_RESET to HPB_PRESENT
+	 */
+	if (!hpb->is_hcm && state =3D=3D HPB_PRESENT)
+		ufshpb_issue_umap_all_req(hpb);
 }
=20
 void ufshpb_suspend(struct ufs_hba *hba)
@@ -2456,8 +2446,6 @@ static void ufshpb_hpb_lu_prepared(struct ufs_hba
*hba)
 			ufshpb_set_state(hpb, HPB_PRESENT);
 			if ((hpb->lu_pinned_end - hpb-
>lu_pinned_start) > 0)
 				queue_work(ufshpb_wq, &hpb->map_work);
-			if (!hpb->is_hcm)
-				ufshpb_issue_umap_all_req(hpb);
 		} else {
 			dev_err(hba->dev, "destroy HPB lu %d\n", hpb-
>lun);
 			ufshpb_destroy_lu(hba, sdev);
diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index b475dbd78988..a130f0b16c3e 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -288,8 +288,7 @@ static int ufshpb_prep(struct ufs_hba *hba, struct
ufshcd_lrb *lrbp) { return 0;
 static void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb
*lrbp) {}
 static void ufshpb_resume(struct ufs_hba *hba) {}
 static void ufshpb_suspend(struct ufs_hba *hba) {}
-static void ufshpb_reset(struct ufs_hba *hba) {}
-static void ufshpb_reset_host(struct ufs_hba *hba) {}
+static void ufshpb_state_toggle(struct ufs_hba *hba, enum UFSHPB_STATE
state) {}
 static void ufshpb_init(struct ufs_hba *hba) {}
 static void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device
*sdev) {}
 static void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device
*sdev) {}
@@ -303,8 +302,7 @@ int ufshpb_prep(struct ufs_hba *hba, struct
ufshcd_lrb *lrbp);
 void ufshpb_rsp_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp);
 void ufshpb_resume(struct ufs_hba *hba);
 void ufshpb_suspend(struct ufs_hba *hba);
-void ufshpb_reset(struct ufs_hba *hba);
-void ufshpb_reset_host(struct ufs_hba *hba);
+void ufshpb_state_toggle(struct ufs_hba *hba, enum UFSHPB_STATE
state);
 void ufshpb_init(struct ufs_hba *hba);
 void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device
*sdev);
 void ufshpb_destroy_lu(struct ufs_hba *hba, struct scsi_device *sdev);

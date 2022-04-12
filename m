Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41C4FE49C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356992AbiDLPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiDLPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:23:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDCF193EA;
        Tue, 12 Apr 2022 08:20:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bv19so15012805ejb.6;
        Tue, 12 Apr 2022 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=C8gQ8j7J3mbrIsGT3wWEzstlM9ttuL2uLWVEJNDgDtU=;
        b=U+2B4AySb2AJW2WsQk97IM5PVdMqEYljSRFy82erPIMX3QrfKI1O2HFcCjEcuQ8H/i
         i8lN7V9XWj2OKtHv4eIgfaAgZfDovMHl/774b/2Ola9SGfoFp1tUiocmVoga7QFRhjbR
         49FyBgx3iiTGIw7tFkEHTRIkwTupDKn6t21lqk5FmXY9KB4H7KYSSQmttFCva51eXf3m
         kIJt8ws/nZZt1W7AcMbDfVuhjRxUNBl31tjbogvESZqynC0A4xUDVp+bpho9EOfsGqXw
         Awe6lgA/EYGMpeOB8NZJphejEtaCp3BETVMKyadcxAJfEAhOETHLMYOZiKJ/HnjZz9Op
         R3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=C8gQ8j7J3mbrIsGT3wWEzstlM9ttuL2uLWVEJNDgDtU=;
        b=4X/fjbuSsDRddBCmPP3InYG868sOZWO/RueYAYXpD31QrABSlDYYwEufkxKx/CCnRs
         d0B4dNyGWIv4Pz6FKTAotfF21WJwRNWXoMEtwN3ExwMbpYn1kjK7F+ur/mjZvkViKx9O
         pysvY0Cko2rEdXYKgbNoWD82DpNAb559f/VdTmE9V8V5lSRwbqGHefmOwA/001vf4lSC
         qDAPa0zFKNmoIG0FfrxLSug5Vx02KqBLjzFJuaowJ58FaDTgnYAyuJp/24tB1RG6Y8Ma
         plxXjWQZK/1LfyiVKj6QPXsft+EV0yleOC34cTuV3hcyDhjPpLz3/McYZY18jcYRC6d2
         f6wg==
X-Gm-Message-State: AOAM533GaLiJcMPE2QsU1CKAu/wUxhW7Aor+BkI66iSlQRDKdteYphST
        Eeundv6fTRN7Abbyl3LQLyk=
X-Google-Smtp-Source: ABdhPJwmGQFhT5G6UCBt8KCHHVo0d5nomeF39Wy+JutCNEqwasMWoIS/uWxoC4C3MwExrMbUxxUWAA==
X-Received: by 2002:a17:906:7947:b0:6da:892f:2503 with SMTP id l7-20020a170906794700b006da892f2503mr34135770ejo.710.1649776855747;
        Tue, 12 Apr 2022 08:20:55 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id c4-20020a170906170400b006e87c7b8ffasm3676306eje.32.2022.04.12.08.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 08:20:55 -0700 (PDT)
Message-ID: <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
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
Date:   Tue, 12 Apr 2022 17:20:54 +0200
In-Reply-To: <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
         <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
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

Hi, Po-Wen,
Previous email did not properly append the patch, this one is better
for your review and test.




From: Bean Huo <beanhuo@micron.com>
Date: Tue, 12 Apr 2022 16:56:34 +0200
Subject: [PATCH] scsi: ufshpb: UFSHPB cleanup

Remove redundant ufshpb_reset*, and merge into a single helper
ufshbp_state_toggle().

Delete the redundant Inactivation code of all HPB Regions in the cold
boot stage,
and add inactivating all HPB Regions when the HPP status changes from
HPB_RESET
to HBP_PRESENT.

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
--=20
2.34.1


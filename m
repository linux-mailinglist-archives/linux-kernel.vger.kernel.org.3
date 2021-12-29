Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199194816D3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhL2Uwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhL2Uvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:49 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e5so13954759wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+UxjIrT6swfgTSxhu8aPxLX7kAkbbcpfwozdOXMAdSA=;
        b=Y2QSbrsXO1u9fPLtGs3DfN3SebBuLmfJB7WthIGZPXel/X8uDyj2ldPvtzU9z+DkCI
         vfjWE2dMdASwjJfzKkbosm2ws7EKozkWiK3KfGaB4/eQWBWQIPsFCnVF5NIxJxT1G+1F
         9xxii8TJ5OIt6fiM0iaKJmy2eWfyo/2u2FVsMEBmMugqOqkedLdztSNOOfC+S2ihVQuq
         bizVCs3otZMXmWWyVOAHG/EJJKGiMk7dr4xLNezIwpQz7sbeyKfdy8xqQX+ooWjiKoEL
         MtZ81rXiQdqMMmYxxv25HbW1Jrq5jIAPeb638c5onGyugkfTLPoyFxfw3HH9mSndedDD
         KCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+UxjIrT6swfgTSxhu8aPxLX7kAkbbcpfwozdOXMAdSA=;
        b=dNJqaml/Ib3+N4kgpHNp4ONbJZdTdVDgmw/76j1QrMfyM2u6ttha83w8gyszjGmQYp
         n5S/fmY/wzHs52yBYOCvIc9L8UfW/kJrRavkmyU3FcG2QcNdTU7wqPMEyYDeak+yZ7/x
         RlfpKj736gzZP7cWu8Ccy7LaQX6Rz8ZrNJx+j9V8/iUYmBE4xtVLPNz3wy8OZ5yaTwT9
         KYRDmmPwIwF1s/PiNt4Yi7fR7BdBl2pq1JMwfL2kQTyCG8rDRPLtfR07I6yimy7f7qNM
         HkNFvdGVjaBNmUAeA6ms4APMokGGnSdHk7l1h28Lp9XzufpI4elJo9dBi4ZHp8y71rdP
         LiBA==
X-Gm-Message-State: AOAM533E+SkIXZZT8sCV8vdlpVsPkk2/OdC/nr7Fo3GkxyDci/Lta1Gb
        jqV6XhX/X+7AHrbsLzEPRVU=
X-Google-Smtp-Source: ABdhPJwjl5BLwgM2YhwPkZv3wRu9jknhn0s69W/CReTYQ6cCzeOjyJwtIedKl7OPFH8dgw0Q8SgRiQ==
X-Received: by 2002:a05:600c:4f8d:: with SMTP id n13mr22938297wmq.43.1640811104335;
        Wed, 29 Dec 2021 12:51:44 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:44 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 25/32] staging: r8188eu: remove odm_TXPowerTrackingInit()
Date:   Wed, 29 Dec 2021 21:51:01 +0100
Message-Id: <20211229205108.26373-26-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

odm_TXPowerTrackingInit() is just a wrapper around
odm_TXPowerTrackingThermalMeterInit(). Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 7 +------
 drivers/staging/r8188eu/include/odm_precomp.h | 1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index a8b477f70c29..f2318ec812be 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -539,7 +539,7 @@ void ODM_DMInit(struct odm_dm_struct *pDM_Odm)
 	odm_RateAdaptiveMaskInit(pDM_Odm);
 
 	odm_DynamicBBPowerSavingInit(pDM_Odm);
-	odm_TXPowerTrackingInit(pDM_Odm);
+	odm_TXPowerTrackingThermalMeterInit(pDM_Odm);
 	ODM_EdcaTurboInit(pDM_Odm);
 	ODM_RAInfo_Init_all(pDM_Odm);
 	if ((pDM_Odm->AntDivType == CG_TRX_HW_ANTDIV)	||
@@ -829,11 +829,6 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 /* 3 Tx Power Tracking */
 /* 3============================================================ */
 
-void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm)
-{
-	odm_TXPowerTrackingThermalMeterInit(pDM_Odm);
-}
-
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm)
 {
 	pDM_Odm->RFCalibrateInfo.bTXPowerTracking = true;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index 9a22a9211d1c..92465e71b814 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegConfig8188E.h"
 #include "odm_RTL8188E.h"
 
-void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1


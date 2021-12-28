Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C8480841
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhL1KL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhL1KLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:48 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A2EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:48 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v11so37372776wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mt8uB8InKVSd7M1Zm7yP7T7TeRc65Jt+J/dhsCZjMMo=;
        b=dcTjK2Pvj/EejNH03RgYIAfrJE+aeYz78xbMM8wkdl29TrZHN56BYImT9LC76ZezGc
         CecKBq25JGqOCa4xkUZI9jPXE0vkzFM4O/8G2/namHfBsQTiP9mW7rKt2uOYZlxcgIhG
         ohgKw0bA6Z6rjx1TTgk8ChpSWhRRoqmnGpwc7a6/DuEGQ4Pqx1G4xETQK03IamT8V4xz
         3lgeVnel0ica3qi2LBt6Z6yOTulCaCgHNIEMpoclUAa5j7ltMYrZnIichs7ERdbGML/d
         p4X+YrHU1qcYEwFe69TCoHcKm8JT+Pdr0/KtG7tN9jlbEJ2U+LEGOYa+cFUEWPdwTr44
         2q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mt8uB8InKVSd7M1Zm7yP7T7TeRc65Jt+J/dhsCZjMMo=;
        b=3Z5FNxKAUKhg+ylF1V/Gqf89cporzmIX3oHTW/TRAFwYxkowDqJV9lCzmdXZ4rUbLX
         LopDZnfhACzkpZcu1cdE4BVYtDZ7NlRx7f1PZ/NhIL3FmnEH3bMLwbSBUKJNHw0J9AdT
         cWkC1L2OuScqHcyMZ46tApLaIoSxaqlECzA02iwJFGLFG8WjqYWRoJCdWz7fHMhDbocW
         LDNOnx3HIL9f/NxfHvj1ngAKLjZTS2nJcDEWHk2j9KdmNOoKVM1u18S5oab1kxQJvajD
         3ZVAyMtCgFR6CAonfMyoaPWHVyMnAizh7IgJWoCLNoVJPZPITiJaNSosGcCASO092WwQ
         YhHw==
X-Gm-Message-State: AOAM533x3azo+sBLpDX1acOfp3ggiC474jeBp9oCMjBqaskKnKLgbHIx
        Eo9RyRAtDgd1ewSqxgxV78g=
X-Google-Smtp-Source: ABdhPJwMNY3LTqwVY0YmTfHcJEtQ1xU3tYGpxwVxPTulidN87ehPxDy/PrduER3+tf8rCDR4WZShIQ==
X-Received: by 2002:adf:f48e:: with SMTP id l14mr16026826wro.88.1640686306631;
        Tue, 28 Dec 2021 02:11:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 05/10] staging: r8188eu: remove write-only fields from struct rtl_ps
Date:   Tue, 28 Dec 2021 11:11:15 +0100
Message-Id: <20211228101120.9120-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields pre_cca_state, cur_cca_state and rssi_val_min of struct
rtl_ps are set but never used. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c     |  3 ---
 drivers/staging/r8188eu/include/odm.h | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index afd208c3ba05..b1bb81c97c5c 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -574,11 +574,8 @@ void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm)
 {
 	struct rtl_ps *pDM_PSTable = &pDM_Odm->DM_PSTable;
 
-	pDM_PSTable->pre_cca_state = CCA_MAX;
-	pDM_PSTable->cur_cca_state = CCA_MAX;
 	pDM_PSTable->pre_rf_state = RF_MAX;
 	pDM_PSTable->cur_rf_state = RF_MAX;
-	pDM_PSTable->rssi_val_min = 0;
 	pDM_PSTable->initialize = 0;
 }
 
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 306640e92e6f..66dc93518628 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -48,14 +48,8 @@ struct rtw_dig {
 };
 
 struct rtl_ps {
-	u8		pre_cca_state;
-	u8		cur_cca_state;
-
 	u8		pre_rf_state;
 	u8		cur_rf_state;
-
-	int		rssi_val_min;
-
 	u8		initialize;
 	u32		reg_874;
 	u32		reg_c70;
@@ -543,12 +537,6 @@ enum odm_bb_config_type {
 /* 3 BB Power Save */
 /* 3=========================================================== */
 
-enum dm_1r_cca {
-	CCA_1R = 0,
-	CCA_2R = 1,
-	CCA_MAX = 2,
-};
-
 enum dm_rf {
 	RF_Save = 0,
 	RF_Normal = 1,
-- 
2.34.1


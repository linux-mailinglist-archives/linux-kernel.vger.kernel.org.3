Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A466466A64
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376868AbhLBT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376716AbhLBT0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:44 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B756EC061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:21 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id x15so2308197edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xhwx8vXXP2jRVaNAJdp6LaE6WxYb3sqcTElXoFdU/KU=;
        b=W72FhnXL/K/lcD8yW7MmEjlg62DzZBFo5seTaTceNzrR1E2XFqDb0tWDLx+9nBBxLH
         JlZU9nEbrKKJjtNyv3EmIiugEFm4DovJqCI+1ypdSTS1aERuJ/f+dtudR4iQAXckQOCy
         NefTYz7bx3LXqT0r+NISkemVgp8TRuuxXAbym/bWbF3xWG4TTQw6bVACt6pwU463hkNe
         d+8T7qFgkG48Kq6IOCsmUMvGfDjauMbKY1SaSwbd4SIwKQzQjotBcE0dS/ebCwmp0fhW
         rpBu2YYnMwOXnNP6yjK1nAMe1oTRtXILIi+VE2cudY64Jj4fg74kujQ4Vff4XWBelpFj
         R1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xhwx8vXXP2jRVaNAJdp6LaE6WxYb3sqcTElXoFdU/KU=;
        b=PMR9Gn2qZ++P4ke/5XTvBBo6UFcrOomSkem6an+y84r7QSpHoK1/DZzWCnWIOoY6Lj
         AFvGeNaPvqKmt1kW6HNXHRGizwA9G6bhTfvPohmy2/6HWDUAq0M9bJwpgJVblgBJWRKJ
         26z5IGX4YWcE8LFQrsKAm+uIWv5tJ//9/zNEUfyzyu39MRwn5KxQGdL07Ywfi66zJVMQ
         tikx23aAqVZVbe1Rg7LILrBv1UT9h3wWGeTHe/YiPjXGgVZxrGnZtvbzL8SsoqdZIVPM
         beAfEl/LD9IAw3JU4cw6Ht6I9CbrZgQX7Pz9gDv5+9QuvJ1k6Nc6rdV4U4Wgp0jqSFW3
         10tQ==
X-Gm-Message-State: AOAM530bTzRnyw6mAb4Dl6EUZO7fNoltOmnjxeIjsDtZyudLi5KzFPKg
        Nz05ax2G5JTnyKRLqG3NVm8=
X-Google-Smtp-Source: ABdhPJy3ZOjuR0typ10dceRtwpXPgpFsG9u7qHYjl4uR2hOlzBvNwgE0jI6Eyri9nP6CMV+gRRvQqA==
X-Received: by 2002:a05:6402:5246:: with SMTP id t6mr19653641edd.18.1638473000392;
        Thu, 02 Dec 2021 11:23:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:20 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: pNumRxBytesUnicast is set but never used
Date:   Thu,  2 Dec 2021 20:23:09 +0100
Message-Id: <20211202192309.9362-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pNumRxBytesUnicast in odm_dm_struct is set but never used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 86758a603cfc..4cce9bf215f4 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -225,9 +225,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	/*  */
 	switch	(CmnInfo) {
 	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_RX_UNI:
-		pDM_Odm->pNumRxBytesUnicast = (u64 *)pValue;
-		break;
 	case	ODM_CMNINFO_WM_MODE:
 		pDM_Odm->pWirelessMode = (u8 *)pValue;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 494175bb2739..75b438e1ce78 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -68,7 +68,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &Adapter->recvpriv.rx_bytes);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index ca8d60b515f4..df232867eac8 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -224,7 +224,6 @@ enum odm_common_info_def {
 
 	/*  Dynamic value: */
 /*  POINTER REFERENCE-----------  */
-	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
 	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
 	ODM_CMNINFO_BW,			/*  ODM_BW_E */
@@ -470,8 +469,6 @@ struct odm_dm_struct {
 
 	/*  Dynamic Value */
 /*  POINTER REFERENCE----------- */
-	/* RX Unicast byte count */
-	u64	*pNumRxBytesUnicast;
 	/*  Wireless mode B/G/A/N = BIT(0)/BIT(1)/BIT(2)/BIT(3) */
 	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
 	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
-- 
2.34.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7E4816C2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhL2Uvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbhL2Uvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:35 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1CC061747
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v7so46496563wrv.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6fS+2eegBAtD5WsPd2O7hyi+cJlS0d70hrcX0KBM1yU=;
        b=ATs2vrcihnSFZ8vkiQOK/xPw+q1wfM1KfwJAWt3anpzcWhaeDe3HYidXu7L7SYGdm+
         T854Wq2lENluTkDeXN6JkbZiphX/rEerRKIfraw7H5QbjQMfgG06X8dido62d1/QV9a+
         VVzDhyi1QGqB5S24UuuTP5N8r1leusaTPL9E0gbNdsC40YV/X7fTCbXdLq1m9+g06qvq
         sHZ9GF0oVxC7J7iNcMjzm4vKHaBh4n4IM9A0Izyfhp0KFV+VsPek7yyaluGjBhIJNRg8
         uHo3ft0VVa8nMehl8POYfRYjTR9SDP9UMrG+AVke3av6N53AFm+5e3hfvoca7gZzXiPJ
         BBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fS+2eegBAtD5WsPd2O7hyi+cJlS0d70hrcX0KBM1yU=;
        b=HwdXw6SwtoFH9HY/YkZChbYnuZiFJ6OlCVhhOJZfVD3jkzcCcKe6awsxk1q/TvNGUx
         2MB90XqnDvCtYmd8zDslEPKO03vOza0kl/xE144aUSZdJzB+ANV2xi7QlxqwljouTNpj
         I3jMrCtp51od9if+XDW5Ik4cl5zq3WdOipm4ENBykV3PJ++MImBggyMzWebJ6PHkjNXl
         TRvG+zmMeQHupc6EspHYihHB93TcZqsnMYOJ8vSWuCjNEjsKMAQpoH6qY2v8xA07QWKZ
         TjAitPMeTUFcvpl5pBRCYPoVGo2w8bdze0r+tS2L+P3fR/9BCcwHmeEP1RR3EJgIAG5k
         E+Hg==
X-Gm-Message-State: AOAM530+InLVd3iia09LRelxuIgKX5FCPGgSlRSNITJ1yoh/SvPleqen
        Pm1kziAynTWCfXPM/vtXKOk=
X-Google-Smtp-Source: ABdhPJx8IKzI6ayZURGMqvvbr91Yx8FDGEjVZoX285VF246Oya+zcLm6jCBFmoZpYfYvHciR4Dh3bw==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr22203006wre.283.1640811092913;
        Wed, 29 Dec 2021 12:51:32 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 09/32] staging: r8188eu: remove ODM_delay_us()
Date:   Wed, 29 Dec 2021 21:50:45 +0100
Message-Id: <20211229205108.26373-10-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_delay_us() is just a wrapper around udelay().
Remove ODM_delay_us() and call udelay() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/odm_RegConfig8188E.c  | 24 +++++++++----------
 drivers/staging/r8188eu/hal/odm_interface.c   |  5 ----
 .../staging/r8188eu/include/odm_interface.h   |  2 --
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
index 8a829190b752..20201353c14f 100644
--- a/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RegConfig8188E.c
@@ -14,15 +14,15 @@ void odm_ConfigRFReg_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	} else if (Addr == 0xfc) {
 		ODM_delay_ms(1);
 	} else if (Addr == 0xfb) {
-		ODM_delay_us(50);
+		udelay(50);
 	} else if (Addr == 0xfa) {
-		ODM_delay_us(5);
+		udelay(5);
 	} else if (Addr == 0xf9) {
-		ODM_delay_us(1);
+		udelay(1);
 	} else {
 		rtl8188e_PHY_SetRFReg(pDM_Odm->Adapter, RF_PATH, RegAddr, bRFRegOffsetMask, Data);
 		/*  Add 1us delay between BB/RF register setting. */
-		ODM_delay_us(1);
+		udelay(1);
 	}
 }
 
@@ -43,7 +43,7 @@ void odm_ConfigBB_AGC_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 {
 	rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
 	/*  Add 1us delay between BB/RF register setting. */
-	ODM_delay_us(1);
+	udelay(1);
 }
 
 void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
@@ -56,11 +56,11 @@ void odm_ConfigBB_PHY_REG_PG_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr,
 	else if (Addr == 0xfc)
 		ODM_delay_ms(1);
 	else if (Addr == 0xfb)
-		ODM_delay_us(50);
+		udelay(50);
 	else if (Addr == 0xfa)
-		ODM_delay_us(5);
+		udelay(5);
 	else if (Addr == 0xf9)
-		ODM_delay_us(1);
+		udelay(1);
 	else
 		storePwrIndexDiffRateOffset(pDM_Odm->Adapter, Addr, Bitmask, Data);
 }
@@ -74,17 +74,17 @@ void odm_ConfigBB_PHY_8188E(struct odm_dm_struct *pDM_Odm, u32 Addr, u32 Bitmask
 	} else if (Addr == 0xfc) {
 		ODM_delay_ms(1);
 	} else if (Addr == 0xfb) {
-		ODM_delay_us(50);
+		udelay(50);
 	} else if (Addr == 0xfa) {
-		ODM_delay_us(5);
+		udelay(5);
 	} else if (Addr == 0xf9) {
-		ODM_delay_us(1);
+		udelay(1);
 	} else {
 		if (Addr == 0xa24)
 			pDM_Odm->RFCalibrateInfo.RegA24 = Data;
 		rtl8188e_PHY_SetBBReg(pDM_Odm->Adapter, Addr, Bitmask, Data);
 
 		/*  Add 1us delay between BB/RF register setting. */
-		ODM_delay_us(1);
+		udelay(1);
 	}
 }
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 249577a9f867..ce9832ab7b13 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -15,8 +15,3 @@ void ODM_delay_ms(u32 ms)
 {
 	mdelay(ms);
 }
-
-void ODM_delay_us(u32 us)
-{
-	udelay(us);
-}
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index 183899e782b1..20c662628646 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -19,6 +19,4 @@ s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 /*  ODM Timer relative API. */
 void ODM_delay_ms(u32 ms);
 
-void ODM_delay_us(u32 us);
-
 #endif	/*  __ODM_INTERFACE_H__ */
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF874816BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhL2Uve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhL2Uv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:29 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34ED0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so15025218wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PJUVglEhyHJ5A34ADs1NDnAldN9uLVB0tu4PfBxFHTo=;
        b=BazYGDVsLG9VXKsXlwLAwQoa6dwH/IQHLOVGo6xuHjJ1lYbfpKAHZatoVymD7EYhzc
         7R+Nz8nhgPB65uvsoR26zOeAcng7mHh1Wjp84XtZY+bOdjM6rK3yxCYngx3nr4lpPYOH
         Lv/getiqo/XaNeqr/FAzoS6xb71sVT5D5yeXIupqrj030zRcMnjdRelqUoAF8e/V7jtS
         YE4tMboy/L+I2Bg97tQQxlWQskDQvRCiUYkSi+2q3gwzKmrYCEDNuh5f2MGTHdjPhz+k
         qWsuBIHH38hy5Y2azkpzri+Q0S6eKlrvTJyx3yOyCpF24gs8/49qR0+hYRbddYxmos5l
         IMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJUVglEhyHJ5A34ADs1NDnAldN9uLVB0tu4PfBxFHTo=;
        b=XClblxbRWYgZCLGfoWgajCD7lDYuKiM9g95UpOGXP/iBxZyKb7k1qAyblObP4dRSnp
         0zOJWORqMIvlUDOkOzrGB18wcfySstzhN4ij22RkCz3WE5p2kQuYkgxc4nt0rqWdy/y/
         mEKhcV49kMuVP8m+8EdktVmmcBzoDfruWsuOZZj9/ivFKAF0S6C4Gdqpb+gkwwfmNB9x
         2+p6KqOY9oKtBvcFz3doQf+jDtPE0KtWxBk8Es6WDZlmG5yO50dYSDlKexEyZY2aip9l
         +VV8T8j6RIXFihr05xMl0pMsgClKIwlyc07puH3C/Yv2QIXR/x+At6IU6nuD9JfC21oX
         eOPQ==
X-Gm-Message-State: AOAM530HWuemd5GiJZ9gR4PQoPMkB+jR+KOS8ws1DQsoxBktvSNAOFFp
        WZ0BygyIvGCb7jeBEFHNzeE=
X-Google-Smtp-Source: ABdhPJxjZOaH/fDltveIUB57Qruj8bqvrWMXFx7W7s9ZcZzpgoMNm34aci56JvLYGd/1jYUVkFLXIw==
X-Received: by 2002:a1c:2b42:: with SMTP id r63mr16508381wmr.80.1640811087762;
        Wed, 29 Dec 2021 12:51:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:27 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/32] staging: r8188eu: remove ODM_GetMACReg()
Date:   Wed, 29 Dec 2021 21:50:38 +0100
Message-Id: <20211229205108.26373-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_GetMACReg() is just a wrapper around rtl8188e_PHY_QueryBBReg().
Remove ODM_GetMACReg() and call rtl8188e_PHY_QueryBBReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c      | 8 ++++----
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 2 --
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 2fd7dee2d4b5..67d0009dcbc5 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -9,7 +9,7 @@ static void odm_RX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 	u32	value32;
 
 	/* MAC Setting */
-	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
+	value32 = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0	antsel antselb by HW */
@@ -31,7 +31,7 @@ static void odm_TRX_HWAntDivInit(struct odm_dm_struct *dm_odm)
 	u32	value32;
 
 	/* MAC Setting */
-	value32 = ODM_GetMACReg(dm_odm, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
+	value32 = rtl8188e_PHY_QueryBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, ODM_REG_ANTSEL_PIN_11N, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
 	/* Pin Settings */
 	ODM_SetBBReg(dm_odm, ODM_REG_PIN_CTRL_11N, BIT(9) | BIT(8), 0);/* Reg870[8]=1'b0, Reg870[9]=1'b0		antsel antselb by HW */
@@ -62,9 +62,9 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	u32	value32;
 
 	/* MAC Setting */
-	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
+	value32 = rtl8188e_PHY_QueryBBReg(adapter, 0x4c, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, 0x4c, bMaskDWord, value32 | (BIT(23) | BIT(25))); /* Reg4C[25]=1, Reg4C[23]=1 for pin output */
-	value32 = ODM_GetMACReg(dm_odm,  0x7B4, bMaskDWord);
+	value32 = rtl8188e_PHY_QueryBBReg(adapter,  0x7B4, bMaskDWord);
 	rtl8188e_PHY_SetBBReg(adapter, 0x7b4, bMaskDWord, value32 | (BIT(16) | BIT(17))); /* Reg7B4[16]=1 enable antenna training, Reg7B4[17]=1 enable A2 match */
 
 	/* Match MAC ADDR */
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index f40adfff7ab6..6c29122553b5 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -4,12 +4,6 @@
 #include "../include/odm_precomp.h"
 /*  ODM IO Relative API. */
 
-u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtl8188e_PHY_QueryBBReg(Adapter, RegAddr, BitMask);
-}
-
 void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask, u32 Data)
 {
 	struct adapter *Adapter = pDM_Odm->Adapter;
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index ab7f263f3f79..b4af86ac5bd4 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -12,8 +12,6 @@ typedef void (*RT_WORKITEM_CALL_BACK)(void *pContext);
 
 /*  =========== EXtern Function Prototype */
 
-u32 ODM_GetMACReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
-
 void ODM_SetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr,
 		  u32 BitMask, u32 Data);
 
-- 
2.34.1


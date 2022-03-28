Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B614E95B1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbiC1LwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243221AbiC1Loi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:44:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76C3206F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z92so16521340ede.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qG553Ox5SvZNbOwmvgj2C7wqTmOMsrin6nZQ0OLdRhk=;
        b=mag7SNiHcI1OBNON5LWx4sVOoFGlBn6IvWtxw8Hcn1iUDQu6gUgPS/E0vR+GP1qkxc
         ZjCGrSthW8otPXQT1UuuhbNNKV3Ft5VCLLf19bZ17MCLPk9PsVUVKHN90g+SK83dQpBv
         v/lh6j4SLEupfn41tbpWBzN6ES2OM8MCnnLqtZFeuuwKdN1MF1KYpTXy6czHvXaovz/X
         T1V0OZZpbHmN0elHmDNtYJyHwph0WO9qiWgRvAhu5NAJp1vbMfxPHlqOEPiVff3g4Sj1
         +Vh2xNNzXOzNKJPS6SZznl0Vrx3uS0HU8q8NbywEJPLvHYpgaFN7V100T3LLCstvP4/e
         ELOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qG553Ox5SvZNbOwmvgj2C7wqTmOMsrin6nZQ0OLdRhk=;
        b=IVhWKWyOEZSHnt+0/vyY8KJjGP2PAlz/sGp0+9P/vfuBeL3B9qzwS8RXYYuk6iJafK
         9ogp97NaEbJpdBlRBrbrH3hm2kEAECnjrRXvUbCW2U1RzFAkj65Vj7u+6d7YVMjV1I1f
         d6S7b86bX6bzjOocX1xQL7f0wwBj7JiaU9HqQy6ZezMgKR9dLFRiWx6L8UGL4RoZyfEL
         vpCy72/ShmyLLcV30br+OueJDE/rCrmGE9RBbE0NW/2tms9UPJxRvkD5FEk+6QauZNEZ
         j6kpGAr7EuWgSg0RMCfhUSTq0ldIT9osMdpzssokwmivRhnV7jBu8CArV7GqDCDSAboV
         6xlQ==
X-Gm-Message-State: AOAM532Uvjupo+GFOb0R/taAG+ZqyTb6xKKDYRI15ZQfEemvFf5lNXHZ
        XEJCn42sM4RfmgPsMUCjRyQ=
X-Google-Smtp-Source: ABdhPJwCP27hCzGJjut2KwjcDBo7p9NqLe44Yg7l52Ban8wu8q6W7R0m5Do8Oy/lRdEkyxsA7D/Ldw==
X-Received: by 2002:a50:9986:0:b0:413:bbdd:d5a1 with SMTP id m6-20020a509986000000b00413bbddd5a1mr15644705edb.26.1648467594671;
        Mon, 28 Mar 2022 04:39:54 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id hq39-20020a1709073f2700b006dfc58efab9sm5938556ejc.73.2022.03.28.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:39:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/9] staging: r8188eu: remove HW_VAR_ACM_CTRL from SetHwReg8188EU()
Date:   Mon, 28 Mar 2022 13:39:35 +0200
Message-Id: <20220328113940.6396-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328113940.6396-1-straube.linux@gmail.com>
References: <20220328113940.6396-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SetHwReg8188EU() is called with HW_VAR_ACM_CTRL only in one place.
Remove the HW_VAR_RESP_SIFS case from SetHwReg8188EU() and replace its
call with the code from that case. This is part of the ongoing effort
to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c | 27 +++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_halinit.c    | 26 -------------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index eda4e5f9a6af..cde3779ff21d 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -571,10 +571,31 @@ void WMMOnAssocRsp(struct adapter *padapter)
 		}
 	}
 
-	if (padapter->registrypriv.acm_method == 1)
-		SetHwReg8188EU(padapter, HW_VAR_ACM_CTRL, (u8 *)(&acm_mask));
-	else
+	if (padapter->registrypriv.acm_method == 1) {
+		u8 acmctrl = rtw_read8(padapter, REG_ACMHWCTRL);
+
+		if (acm_mask > 1)
+			acmctrl = acmctrl | 0x1;
+
+		if (acm_mask & BIT(3))
+			acmctrl |= ACMHW_VOQEN;
+		else
+			acmctrl &= (~ACMHW_VOQEN);
+
+		if (acm_mask & BIT(2))
+			acmctrl |= ACMHW_VIQEN;
+		else
+			acmctrl &= (~ACMHW_VIQEN);
+
+		if (acm_mask & BIT(1))
+			acmctrl |= ACMHW_BEQEN;
+		else
+			acmctrl &= (~ACMHW_BEQEN);
+
+		rtw_write8(padapter, REG_ACMHWCTRL, acmctrl);
+	} else {
 		padapter->mlmepriv.acm_mask = acm_mask;
+	}
 
 	inx[0] = 0; inx[1] = 1; inx[2] = 2; inx[3] = 3;
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 26a86b891aa1..86d8b603d4fa 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1143,32 +1143,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 		haldata->AcParam_BE = ((u32 *)(val))[0];
 		rtw_write32(Adapter, REG_EDCA_BE_PARAM, ((u32 *)(val))[0]);
 		break;
-	case HW_VAR_ACM_CTRL:
-		{
-			u8 acm_ctrl = *((u8 *)val);
-			u8 AcmCtrl = rtw_read8(Adapter, REG_ACMHWCTRL);
-
-			if (acm_ctrl > 1)
-				AcmCtrl = AcmCtrl | 0x1;
-
-			if (acm_ctrl & BIT(3))
-				AcmCtrl |= ACMHW_VOQEN;
-			else
-				AcmCtrl &= (~ACMHW_VOQEN);
-
-			if (acm_ctrl & BIT(2))
-				AcmCtrl |= ACMHW_VIQEN;
-			else
-				AcmCtrl &= (~ACMHW_VIQEN);
-
-			if (acm_ctrl & BIT(1))
-				AcmCtrl |= ACMHW_BEQEN;
-			else
-				AcmCtrl &= (~ACMHW_BEQEN);
-
-			rtw_write8(Adapter, REG_ACMHWCTRL, AcmCtrl);
-		}
-		break;
 	case HW_VAR_AMPDU_MIN_SPACE:
 		{
 			u8 MinSpacingToSet;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index a2c5724790f6..d0317f5b85ba 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -23,7 +23,6 @@ enum hw_variables {
 	HW_VAR_DM_FUNC_SET,
 	HW_VAR_DM_FUNC_CLR,
 	HW_VAR_AC_PARAM_BE,
-	HW_VAR_ACM_CTRL,
 	HW_VAR_AMPDU_MIN_SPACE,
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_RXDMA_AGG_PG_TH,
-- 
2.35.1


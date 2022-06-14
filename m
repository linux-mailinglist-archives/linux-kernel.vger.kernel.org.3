Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16C54B53B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344523AbiFNP7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243779AbiFNP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:59:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FC27B33
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x62so12279791ede.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GpSEw9c3r7sQWr+egbMOGl5Yu6roLaX7F/5rz4bUGTw=;
        b=ev+JeJYBY/IfjhesmJo4M5OfE/Tk8HXWwSSXslzrDH3gDLtzs9Wx/r8VU4c3UfEGTT
         oDbe0qvBT8zlehwyDLdzN7e18bs2pIA+L1R9iFDhmZAZYJfw69zDu1abw6YDhFt+BFIU
         Qi/sUrpCVV9amBgB1PXCdGa8mrfX2OXgMYE+spzfLHXu54cyibgMyg93sEslnEjF14bB
         EB5dN8/VFd1GnGnQ6Yj+kQJzk7+44J74ZTXTg7Qq729V/ObSHu5zgmFe8VzjqAeYXAkc
         VPzCk42L6QOHFxhp9hK/KMtiHsFDYBMwE6ZQtwqPaO5jcbz5HJS38Y+EoDxJYHkS4YhO
         7pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GpSEw9c3r7sQWr+egbMOGl5Yu6roLaX7F/5rz4bUGTw=;
        b=iRpuVT2gat8KgDScrGE8FD3ofaXGulY209Djjc7ivwM1OqbXD4e0aRO+xZaXD6zjbl
         gXNN4y0RwhwF3sRTvlJF69Ml4V9awqjPyakD/P+6R+bUXnaJR4NUDzO/RVMMIioAMgk6
         WMAK+5/8W/moHmYQy+Dy+LMGgpuvMDERxmqj/SvYUx0HGnvjSjRLSgTeSqLOl9c+TCU4
         697RYgFpZ7ulv6DxyenWjfO2tsIUhvzXMV4m2qfo+hBsjqCUMIcNEyHxWkKC5aYjAZtz
         zk18LHISkIIHeIeQoAytcGXKuo8noCYnjqqOm9lxwac1RgMmev1779MTEfPdpo8H7kH+
         yJyg==
X-Gm-Message-State: AJIora83o5O0LoE0UNLBH8be4s212yxMSNCpEomC/RL7INcBq1eZNVn1
        MLfxM/ri5x1tTzrP4ZbSyu0=
X-Google-Smtp-Source: ABdhPJwNoT0Ob31bmrxxQpJr7W+KbgZ1IHbwDtGK9fNKcqLLS7rk4rkGYk7XNfskl2zOx6xkHpFkPA==
X-Received: by 2002:a05:6402:350f:b0:42f:68f9:ae5 with SMTP id b15-20020a056402350f00b0042f68f90ae5mr7134117edd.36.1655222354856;
        Tue, 14 Jun 2022 08:59:14 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:c58b:f186:2720:bdac])
        by smtp.gmail.com with ESMTPSA id qk10-20020a170906d9ca00b006fed93bf71fsm5327928ejb.18.2022.06.14.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:59:14 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, namcaov@gmail.com,
        phil@philpotter.co.uk, Larry.Finger@lwfinger.net,
        paskripkin@gmail.com
Subject: [PATCH v3 1/2] staging: r8188eu: replace confusing macros
Date:   Tue, 14 Jun 2022 17:58:44 +0200
Message-Id: <e697e47aad21362f68d148d2351e6d49f4fa9eaf.1655220367.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655220367.git.namcaov@gmail.com>
References: <cover.1655220367.git.namcaov@gmail.com>
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

The macro GET_TX_REPORT_TYPE1_RERTY_0 and similar macros are not
obvious on what they are doing. Replace them with clearer codes.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c  | 12 ++++++------
 .../staging/r8188eu/include/Hal8188ERateAdaptive.h  | 13 -------------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
index 3cefdf90d6e0..1e04de3a6622 100644
--- a/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
+++ b/drivers/staging/r8188eu/hal/Hal8188ERateAdaptive.c
@@ -614,12 +614,12 @@ void ODM_RA_TxRPT2Handle_8188E(struct odm_dm_struct *dm_odm, u8 *TxRPT_Buf, u16
 
 		pRAInfo = &dm_odm->RAInfo[MacId];
 		if (valid) {
-			pRAInfo->RTY[0] = (u16)GET_TX_REPORT_TYPE1_RERTY_0(pBuffer);
-			pRAInfo->RTY[1] = (u16)GET_TX_REPORT_TYPE1_RERTY_1(pBuffer);
-			pRAInfo->RTY[2] = (u16)GET_TX_REPORT_TYPE1_RERTY_2((u8 *)pBuffer);
-			pRAInfo->RTY[3] = (u16)GET_TX_REPORT_TYPE1_RERTY_3(pBuffer);
-			pRAInfo->RTY[4] = (u16)GET_TX_REPORT_TYPE1_RERTY_4(pBuffer);
-			pRAInfo->DROP =   (u16)GET_TX_REPORT_TYPE1_DROP_0(pBuffer);
+			pRAInfo->RTY[0] = le16_to_cpup((__le16 *)pBuffer);
+			pRAInfo->RTY[1] = pBuffer[2];
+			pRAInfo->RTY[2] = pBuffer[3];
+			pRAInfo->RTY[3] = pBuffer[4];
+			pRAInfo->RTY[4] = pBuffer[5];
+			pRAInfo->DROP = pBuffer[6];
 			pRAInfo->TOTAL = pRAInfo->RTY[0] + pRAInfo->RTY[1] +
 					 pRAInfo->RTY[2] + pRAInfo->RTY[3] +
 					 pRAInfo->RTY[4] + pRAInfo->DROP;
diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
index 20d73ca781e8..c571ad9478ea 100644
--- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -22,19 +22,6 @@
 	le32_to_cpu((*(__le32 *)(__rxstatusdesc + 16))
 #define GET_TX_RPT2_DESC_MACID_VALID_2_88E(__rxstatusdesc)	\
 	le32_to_cpu((*(__le32 *)(__rxstatusdesc + 20))
-
-#define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
-	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
-#define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_2(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 3, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_3(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 4, 0, 8)
-#define GET_TX_REPORT_TYPE1_RERTY_4(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 5, 0, 8)
-#define GET_TX_REPORT_TYPE1_DROP_0(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 6, 0, 8)
 /*  End rate adaptive define */
 
 int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
-- 
2.25.1


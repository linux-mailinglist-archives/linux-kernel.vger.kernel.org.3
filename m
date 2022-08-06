Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117558B403
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 08:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241616AbiHFGJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 02:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbiHFGJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 02:09:49 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E02205D2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 23:09:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl27so8323894ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 23:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcLF/W8KMFIaSXXvb2UsBctV0hSOCapQFAQgo06eWCM=;
        b=mqZ/ZAOCMrjjGKRH/ewbc55oJAItb5npnHzzg3svEYlyQrRuBTWHpd1MYWMO21bU/h
         WJqNXMcgdUboGwAZ4doAL9KZani3z5Lhx2a3r9wzoa/vmVZn+h0HUsnqaRYZ4pnNnvaJ
         9aKihD5ZifPOTPT2n1dvmoSqOmETQrwSMKWUwqRr7FODOs50aPl1f0GNK65SXG6fT6aC
         cwOY7MIU5tk5qgMso97lqMRFB+LgqPd/ghtAlPzyZ8C7KWuBxiM48VnAXsYXrb8Io99e
         N0kyNbeXxcd0iph4zrBbYLXrITH7o/8vtAXYPB9v5ZWvzZAc3ezG26a/ElBvc9Nk6xVO
         uFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcLF/W8KMFIaSXXvb2UsBctV0hSOCapQFAQgo06eWCM=;
        b=fZDLxKOI7TxKww18u7kZCeOBrvGiZs3zEnWVI2+u5iQHCKPp1cEvJaBbtaXBYRauMW
         0aEP5mjx/BEHfM4iWa0u1sp0Sz+0DJyR6ss+Z5mcQ1P/dkpGYGRHfAtOzxngf3UEQkUB
         m1x3i9VdP8KvV30Mm5QGKqk6eyGMx9EtATqaSCGQal+qKocjIMCRBo4MV8aQoCrT1Bg+
         5tgq5vrNWnOl8VQSHWl5rRV+5/34NRlDIvAHrSAmWUx4HHVEXq6MNVDqUc1hVETzpN7s
         sGZnoV50rqozcAnUQCXdWaslooCVUhgbqfegpl/lLY7c24OadC1pxsC8hI84KK9Oy+g2
         iijw==
X-Gm-Message-State: ACgBeo0bkI21xsBPffqtlw9BDyxLvkLHLLg4fDV8FnQu3CUOrZEreMQR
        pZUsSt/pzDRc84d/+EiWeRV7pAMsF1E=
X-Google-Smtp-Source: AA6agR4td96QHPH8bB6zZWLnwKy3oZ8M0MJyA522BMox/A2/flPPk04ZrDVrBUW3AHdmlXxP36M/bA==
X-Received: by 2002:a17:906:847c:b0:730:b6a0:e0d with SMTP id hx28-20020a170906847c00b00730b6a00e0dmr7459809ejc.126.1659766187034;
        Fri, 05 Aug 2022 23:09:47 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abba5.dynamic.kabel-deutschland.de. [95.90.187.165])
        by smtp.gmail.com with ESMTPSA id p10-20020a05640243ca00b0043a7293a03dsm1002357edc.7.2022.08.05.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 23:09:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: avoid camel case in phy_CalculateBitShift()
Date:   Sat,  6 Aug 2022 08:09:28 +0200
Message-Id: <20220806060929.11022-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220806060929.11022-1-straube.linux@gmail.com>
References: <20220806060929.11022-1-straube.linux@gmail.com>
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

Rename the function phy_CalculateBitShift() and its parameter BitMask
to avoid camel case.

phy_CalculateBitShift -> phy_calculate_bit_shift
BitMask -> bitmask

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 3d8fcc1f0b6a..e9e24efabd76 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -23,9 +23,9 @@
 * Output:	none
 * Return:		u32		Return the shift bit bit position of the mask
 */
-static	u32 phy_CalculateBitShift(u32 BitMask)
+static u32 phy_calculate_bit_shift(u32 bitmask)
 {
-	u32 i = ffs(BitMask);
+	u32 i = ffs(bitmask);
 
 	return i ? i - 1 : 32;
 }
@@ -58,7 +58,7 @@ rtl8188e_PHY_QueryBBReg(
 	if (res)
 		return 0;
 
-	BitShift = phy_CalculateBitShift(BitMask);
+	BitShift = phy_calculate_bit_shift(BitMask);
 	ReturnValue = (OriginalValue & BitMask) >> BitShift;
 	return ReturnValue;
 }
@@ -91,7 +91,7 @@ void rtl8188e_PHY_SetBBReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u3
 		if (res)
 			return;
 
-		BitShift = phy_CalculateBitShift(BitMask);
+		BitShift = phy_calculate_bit_shift(BitMask);
 		Data = ((OriginalValue & (~BitMask)) | (Data << BitShift));
 	}
 
@@ -263,7 +263,7 @@ u32 rtl8188e_PHY_QueryRFReg(struct adapter *Adapter, u32 RegAddr, u32 BitMask)
 
 	Original_Value = phy_RFSerialRead(Adapter, RegAddr);
 
-	BitShift =  phy_CalculateBitShift(BitMask);
+	BitShift =  phy_calculate_bit_shift(BitMask);
 	Readback_Value = (Original_Value & BitMask) >> BitShift;
 	return Readback_Value;
 }
@@ -298,7 +298,7 @@ rtl8188e_PHY_SetRFReg(
 	/*  RF data is 12 bits only */
 	if (BitMask != bRFRegOffsetMask) {
 		Original_Value = phy_RFSerialRead(Adapter, RegAddr);
-		BitShift =  phy_CalculateBitShift(BitMask);
+		BitShift =  phy_calculate_bit_shift(BitMask);
 		Data = ((Original_Value & (~BitMask)) | (Data << BitShift));
 	}
 
-- 
2.37.1


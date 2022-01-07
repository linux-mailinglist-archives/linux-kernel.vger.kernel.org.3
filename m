Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B884875B1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346961AbiAGKhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346752AbiAGKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C6C06118C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:37 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id k15so20288470edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWGc25I9UHfLAvl83M8OVDS0k2GJV0r/8CZZ7jpKHXI=;
        b=nOAYZAqJKCBfbha4LmVid9XfWWPF8Hn+fLbU/aq7W/Q9JkhTZYcFZq4Q7RH/601qps
         IgSACDshJlwYL9A1jcY2HhwlME4gm7dqzsLXfRv9ioXSHBQYIsrwn5Blwqm94QXyoMC6
         JOq+fJGC84cDB3dtPdCBLwOQqNw8czucTW0LZwFsg6o6xymMOVugVWmeQy3lSe1rDMb7
         g4eQqg/pM8Nj1818gfdF0xxQxBlgzTUXZ9e4KnoIuPimi1U8mU+pN82Wc3RMBxjrqMlw
         +ToD4pkcxuqa79274Ft2Dcbr96pWkU5MbcOi1GCYAuMCZkwgRuL19SK89e5F20XWcySZ
         Rxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWGc25I9UHfLAvl83M8OVDS0k2GJV0r/8CZZ7jpKHXI=;
        b=63cpRlFsPya9w7PSHdhTrPyiUxFSjyerApPiGcazQ7bHvA6ejxqfFB1QIIdaieH9I7
         9lJ0KURn8g8V4KzdZWcDS0MEDF/ZyzdS6Vrfpe7hmFuSOWDxuFciPa1EpGexOQnsE1V3
         kTuFXwWYCf4Cm0oA5o0Bn/VHWGP2/OrUMvJ8dJAXxUda34ktWyBCliNaBDLSQ8vjWn35
         alPaxgDAqO/mo80WoJDypDAJDyu23JhznZyANbHWy/+rl5zNXWv0MiO21bC6/5vwc0GG
         92MLzl2GHJ3XNTOJy71W5A/VRSccubOBNkNjEMuWyGskTALpx8xI8OoamNgT5UHD7PyT
         SQwA==
X-Gm-Message-State: AOAM532s6uT1QwO53bVcdOXPxp0bQKqb5cyON4Bgdz2367B4AFC0pO4X
        DDicY12LFCrtL1p1MQkHcDtyGqb8/UQ=
X-Google-Smtp-Source: ABdhPJxqzWL2cC5MH8XEMhWW9Z+kpyjzXks3CJZar9/yFi9O7GPdogFMNanyVhXCmXNKxhVm/P4HJg==
X-Received: by 2002:a05:6402:4313:: with SMTP id m19mr63020648edc.326.1641551796090;
        Fri, 07 Jan 2022 02:36:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/19] staging: r8188eu: clean up rtw_reset_8051()
Date:   Fri,  7 Jan 2022 11:36:12 +0100
Message-Id: <20220107103620.15648-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the local variable u1bTmp in rtw_reset_8051() to avoid camel
case and remove a call to DBG_88E that contains no important
information.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index b1f2d349c33a..d219882fc4a2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -460,12 +460,11 @@ static int write_fw(struct adapter *padapter, void *buffer, u32 size)
 
 void rtw_reset_8051(struct adapter *padapter)
 {
-	u8 u1bTmp;
+	u8 val8;
 
-	u1bTmp = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
-	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
-	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
-	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
+	val8 = rtw_read8(padapter, REG_SYS_FUNC_EN + 1);
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 & (~BIT(2)));
+	rtw_write8(padapter, REG_SYS_FUNC_EN + 1, val8 | (BIT(2)));
 }
 
 static s32 fw_free_to_go(struct adapter *padapter)
-- 
2.34.1


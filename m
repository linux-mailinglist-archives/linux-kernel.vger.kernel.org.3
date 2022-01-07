Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B30487E83
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiAGVuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiAGVus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:50:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158EC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:50:47 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l10so13500564wrh.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+Jxam6E4Q5QnqvejI5GJgZU6fnINaepxI7ZTcYPB+Q=;
        b=f77GfOuz8rnN8Oty+x95W6xnQnMG6m8YG/w771iPkB14S3cAm0/pTuh0zllEPMhV/M
         19q5FLt0JCqkj/wBjo0LQSCPwqNGwTc0khk+Hw1tN99VVEzAl+XecJhCA6HikC68dRk0
         pLwvDbCeV4iBDDxaNd3EKiXEhaMCzphZkXhr+LuY+a1mRU4n7AvpeaDZMzgV/7myBJBE
         WhW4AbW4Mul9sZmKShklHLKTNc9NCrJ1GIFm/hvABB7w6M0f0nKZ7r47+qmSs3MQsW36
         Iif66/OAQ8vEyX0PWKtw0+ZaL/oIIVSYnK73jbiGyTUC+GF0G0uZYr0RwArb2QabbyM3
         /FjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+Jxam6E4Q5QnqvejI5GJgZU6fnINaepxI7ZTcYPB+Q=;
        b=siNWVQWYiAW8xwkHTYA87+NvVFAARfg9HTsZlWU4+M90ZGn59sm/k2hEpZ4PlfW4Zr
         vU1khZcTo6IaYTy646VTu4RjNRbBf8BFsvxQnsNdX7RXagIcC5YcBV7Q4iowQGTeLX1l
         xMNzjiAXFA6sWvFJFV2h6DM3wVC4EDDqy1IujX+snhmrQMq/DF89VE0CGd44kh2SHSOs
         bqnIcpI06p3eCj9o/LOiF0yJpntyVbSUkUSmYz6OULmA8ktDfLlxSgZN5QS+ZChUtgDa
         3eGAx92Z/6MGEfG3+J6tVwBgfju19nBo0LlLgGfBqhCzV6i4Qh/+IGumH6sav4z9KAIm
         mC5g==
X-Gm-Message-State: AOAM533WJUEBCCJQdwIU6QDrLE7DSqALY2Ex+xkO5dAopZC07nGog7LB
        eSKHU3H/oXDsV1N0HAA3xhA=
X-Google-Smtp-Source: ABdhPJw+sAvX14hiDTJsak7x7k5L4NYXxLRPBrbUwR5IdEiHe3TDRZyVwmQktoPhYgDFLhYZnlvZDQ==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr1086311wro.151.1641592246342;
        Fri, 07 Jan 2022 13:50:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id k14sm1729161wrn.59.2022.01.07.13.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:50:46 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/6] staging: r8188eu: remove HW_VAR_TXPAUSE
Date:   Fri,  7 Jan 2022 22:50:29 +0100
Message-Id: <20220107215033.12257-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107215033.12257-1-straube.linux@gmail.com>
References: <20220107215033.12257-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SetHwReg8188EU() and GetHwReg8188EU() are never called with
HW_VAR_TXPAUSE. Remove that case from both functions.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 6 ------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b996580b30ba..72b008a78d75 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1138,9 +1138,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, REG_INIRTS_RATE_SEL, RateIndex);
 		}
 		break;
-	case HW_VAR_TXPAUSE:
-		rtw_write8(Adapter, REG_TXPAUSE, *((u8 *)val));
-		break;
 	case HW_VAR_BCN_FUNC:
 		hw_var_set_bcn_func(Adapter, variable, val);
 		break;
@@ -1592,9 +1589,6 @@ void GetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	struct odm_dm_struct *podmpriv = &haldata->odmpriv;
 
 	switch (variable) {
-	case HW_VAR_TXPAUSE:
-		val[0] = rtw_read8(Adapter, REG_TXPAUSE);
-		break;
 	case HW_VAR_BCN_VALID:
 		/* BCN_VALID, BIT(16) of REG_TDECTRL = BIT(0) of REG_TDECTRL+2 */
 		val[0] = (BIT(0) & rtw_read8(Adapter, REG_TDECTRL + 2)) ? true : false;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index b4a7e0ce3116..77149eda7edf 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -16,7 +16,6 @@ enum hw_variables {
 	HW_VAR_BSSID,
 	HW_VAR_INIT_RTS_RATE,
 	HW_VAR_BASIC_RATE,
-	HW_VAR_TXPAUSE,
 	HW_VAR_BCN_FUNC,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_CHECK_BSSID,
-- 
2.34.1


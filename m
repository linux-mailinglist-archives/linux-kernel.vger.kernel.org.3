Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539624A385C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355808AbiA3TEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355801AbiA3TDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:44 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138AC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:44 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id s5so36072170ejx.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WNZPBbLkLD5BATZjpOdpNx2Pq3vxYoH7d33hip6I60=;
        b=YQXKzKee807KM9FTAvhayv2BpNZlHZa8mLsZsZHvifprAjUBsZKdMAg/gECaH6jb5E
         +8Xy9Mjuj1z1ZLl+0+pd5gE83wKGlYqMSSYooNqYHUED0is7yIC5i2b4Pvfbm5L2Gi/s
         T9sc3SPU99qfjlgrXPyITWtT9ZCYsO0RjnSJpMlpztiCVnPCaADtqZQMHV0wsR8GGupc
         buq7S+7rQyaTTYWStZFTX5z7icIDq2AYh/nVQoOj3KtNTCF9fdwMQgDh+W/rTNo+P7Tl
         QFlek6LSvWtU1LLJOjSJeEQNBf5WoUQI6WCsaKuW2RfRp90QRgpknfISCUxjavdGXbGl
         JExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WNZPBbLkLD5BATZjpOdpNx2Pq3vxYoH7d33hip6I60=;
        b=FMi48zC3YLfngOg3kJr3iuiE9ybmVV7FxW5Gm2Hu9bffZc9AkRxu4mEfHRMoz6BtGO
         D2CVH1TNp7cyf7zgeoUGcx4cZminYVPsaZQz1RL50oC7h1ER6vHRW0e6nFpODcyTrxR9
         aiBpGSEIsW4cKrW0MwGXBLqYolu4dKJxcNuEAjGzTaISaPATEiTXy9tkpKwgpLiczSy1
         Shm1Vx4Z/N7W/HCIXWIyIqqAAtV7Cpfb53Fm7dSrGHxZysaiZmlUHgpFeufVw0VGtdOY
         IbrNnsM4hcwEzeQCnzqjNzRZwE/ebiPGubcDeJbnbJvzQxGo3NfjEi5kw9NgV46urz28
         0ilg==
X-Gm-Message-State: AOAM533CURbWfXsqTi7ta0hmRLF7BpThVth6ZwISdOrsbHJnOtq+6nTR
        dHhNB3AccFtVkTIgtVgdlZY=
X-Google-Smtp-Source: ABdhPJxKQ3eirYKDmDkWO9d7T7Ayf2b5TuaNS8KPTNjVEKyDQgZUKPwF+yEm4osx7+v3JIQSNVooig==
X-Received: by 2002:a17:907:16a6:: with SMTP id hc38mr15249048ejc.291.1643569423221;
        Sun, 30 Jan 2022 11:03:43 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:42 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/12] staging: r8188eu: remove HW_VAR_CHECK_BSSID
Date:   Sun, 30 Jan 2022 20:03:20 +0100
Message-Id: <20220130190321.7172-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW_VAR_CHECK_BSSID case in SetHwReg8188EU() is not used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 13 -------------
 drivers/staging/r8188eu/include/hal_intf.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 796c898bfb8c..bab76a92ece5 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1122,19 +1122,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				ResumeTxBeacon(Adapter);
 		}
 		break;
-	case HW_VAR_CHECK_BSSID:
-		if (*((u8 *)val)) {
-			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
-		} else {
-			u32 val32;
-
-			val32 = rtw_read32(Adapter, REG_RCR);
-
-			val32 &= ~(RCR_CBSSID_DATA | RCR_CBSSID_BCN);
-
-			rtw_write32(Adapter, REG_RCR, val32);
-		}
-		break;
 	case HW_VAR_MLME_DISCONNECT:
 		/* Set RCR to not to receive data frame when NO LINK state */
 		/* reject all data frames */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 7be5eb2c4a9b..5add8d100da7 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -14,7 +14,6 @@ enum hw_variables {
 	HW_VAR_INIT_RTS_RATE,
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
-	HW_VAR_CHECK_BSSID,
 	HW_VAR_MLME_DISCONNECT,
 	HW_VAR_MLME_SITESURVEY,
 	HW_VAR_MLME_JOIN,
-- 
2.34.1


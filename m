Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695A549F8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348367AbiA1LzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348280AbiA1LzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:55:00 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13102C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:55:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p7so9307108edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FKIrVsgP7qkgx8/mcmXHMVQto71IG5bp6nnnHEWfchg=;
        b=pWaP34kNvTsQcN+oDrlM4c4s0Il+gObNztcFXhJmdIH+c0ej871IrQqI73lp2G3Py1
         JG446zAwBjiJNAoQJp6VvDEjYtgUDE9OdGrB2XdvK8a3hpgSgXeFM+gb0VXn91MddB/C
         O8ewlBqvkI23zM19fX3zc1gVXF/zYw+GFLXC3UNh+bQ5HY6mHmaYCWmyJ0Z/y6poKOtD
         Ec8bRpvXpl2duW2qH171Ah8DB5LE5/iMJwTQxxC3xn0520g9XaSsDXGB+KD3pqmOUPoD
         UnDzHmB4ZuIj+tidBvQFLSRNQwmQjUHyulwgWPNDNOlyHnRMxMpRyN2NGBnB2l9PxmXI
         M//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FKIrVsgP7qkgx8/mcmXHMVQto71IG5bp6nnnHEWfchg=;
        b=2Wve/PrVU2TXZQxpNgSMpulJrCplpd/Rxktn/EQ43sUCkNLDlCWr1MeuwbxC5mIoWJ
         HyYn2K+db26ERP2e03LNrK5yEIXiQw/HwYscxq1F05TqfvE3t15db/5/Z7xrQ2oyugNu
         +6Wt0g+Gq83sF4ITqE11OKNZXi/X5yMDlmw0Mqly09tXYbLQIt6NqDzB/gSKk7xsNlEd
         dXuUrd3A2FWulu3lkpfCNIHNMOusvdWneJDwVecmC7u6oAILs/iKmIqChRc/HA6yF4Pw
         zyWre15rnxO4Q2ejg5eNhDZ0qaNkq/OVujRYwfzbenm3lSOIml6PdaL40rOOxNdXuO2N
         hrbQ==
X-Gm-Message-State: AOAM530kT37VE40wcqertYgdUY3fCTPWDwOlnNfGQBObhzA5vUtc3A8S
        Aqf6YJIE8EOsp3tI8j32ucw=
X-Google-Smtp-Source: ABdhPJzbSKiV9EZtpifZQwcbMHhqaStOryZnGWPbNLNMnNnwz6ynifc2T8r15PkqFeScqwgLoiJYlQ==
X-Received: by 2002:aa7:cd08:: with SMTP id b8mr7592785edw.265.1643370898658;
        Fri, 28 Jan 2022 03:54:58 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id h20sm12494261eds.9.2022.01.28.03.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:54:58 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: remove IS_*_CUT macros
Date:   Fri, 28 Jan 2022 12:54:45 +0100
Message-Id: <20220128115445.6606-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128115445.6606-1-straube.linux@gmail.com>
References: <20220128115445.6606-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the IS_*_CUT macros from HalVerDef.h. They are not needed, we
can use a switch on chip_vers.CUTVersion directly in dump_chip_info()

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c       | 24 ++++++++++++++-------
 drivers/staging/r8188eu/include/HalVerDef.h | 18 ----------------
 2 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index ba5d027d765f..7f28fd08f0aa 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -20,19 +20,27 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 		       "Normal_Chip" : "Test_Chip");
 	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
 		       "TSMC" : "UMC");
-	if (IS_A_CUT(chip_vers))
+
+	switch (chip_vers.CUTVersion) {
+	case A_CUT_VERSION:
 		cnt += sprintf((buf + cnt), "A_CUT_");
-	else if (IS_B_CUT(chip_vers))
+		break;
+	case B_CUT_VERSION:
 		cnt += sprintf((buf + cnt), "B_CUT_");
-	else if (IS_C_CUT(chip_vers))
+		break;
+	case C_CUT_VERSION:
 		cnt += sprintf((buf + cnt), "C_CUT_");
-	else if (IS_D_CUT(chip_vers))
+		break;
+	case D_CUT_VERSION:
 		cnt += sprintf((buf + cnt), "D_CUT_");
-	else if (IS_E_CUT(chip_vers))
+		break;
+	case E_CUT_VERSION:
 		cnt += sprintf((buf + cnt), "E_CUT_");
-	else
-		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_",
-			       chip_vers.CUTVersion);
+		break;
+	default:
+		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
+		break;
+	}
 
 	cnt += sprintf((buf + cnt), "1T1R_");
 
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index f4816ac765e5..2bc18eabb55d 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -14,8 +14,6 @@ enum HAL_CUT_VERSION {
 	C_CUT_VERSION	=	2,
 	D_CUT_VERSION	=	3,
 	E_CUT_VERSION	=	4,
-	F_CUT_VERSION	=	5,
-	G_CUT_VERSION	=	6,
 };
 
 enum HAL_VENDOR {
@@ -33,27 +31,11 @@ struct HAL_VERSION {
 /*  Get element */
 #define GET_CVID_CHIP_TYPE(version)	(((version).ChipType))
 #define GET_CVID_MANUFACTUER(version)	(((version).VendorType))
-#define GET_CVID_CUT_VERSION(version)	(((version).CUTVersion))
-
-/* Common Macro. -- */
-/* HAL_VERSION VersionID */
 
 /* HAL_CHIP_TYPE_E */
 #define IS_NORMAL_CHIP(version)				\
 	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
 
-/* HAL_CUT_VERSION_E */
-#define IS_A_CUT(version)				\
-	((GET_CVID_CUT_VERSION(version) == A_CUT_VERSION) ? true : false)
-#define IS_B_CUT(version)				\
-	((GET_CVID_CUT_VERSION(version) == B_CUT_VERSION) ? true : false)
-#define IS_C_CUT(version)				\
-	((GET_CVID_CUT_VERSION(version) == C_CUT_VERSION) ? true : false)
-#define IS_D_CUT(version)				\
-	((GET_CVID_CUT_VERSION(version) == D_CUT_VERSION) ? true : false)
-#define IS_E_CUT(version)				\
-	((GET_CVID_CUT_VERSION(version) == E_CUT_VERSION) ? true : false)
-
 /* HAL_VENDOR_E */
 #define IS_CHIP_VENDOR_TSMC(version)			\
 	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
-- 
2.34.1


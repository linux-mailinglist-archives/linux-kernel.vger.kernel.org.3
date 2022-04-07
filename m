Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119DE4F881A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiDGTbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiDGTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A129AE37
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bg10so12976892ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vGCnlEHv9nw64WsEYjnHYKjP/dibbUbwl/jK2KIozQA=;
        b=AQq+1KHDxXa1zjrf8HoZKiXspUf+//Y+QDa+9qBI+z3L5VqeQtNEkcjwZhgdxo2SVp
         TKYNFLag/PTEpMecTsXAbVH8JteoQWPcjoZB9MokFO7oE15kZ4YrpfCsRqFmLtu8Dud6
         pWUTrPiyomAq18QmqaEGL0PKDZk5p/KqXsBdQD5Wl8vyskDgjYhTRcxp9hyHX15cd9Bh
         7m/1RPy8+Sw0Z0ruT18ogjT3HPw5o2gXA54LolBn4rnP+6cNw0mLswm/qshqqIZ0GgbY
         XoTuMbsUBPmjeMg0WqIzyPB2fVnr07rsTiMVq1JoE5GmdyqNxYS0jV/oGf0yp0vTBTLl
         UThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vGCnlEHv9nw64WsEYjnHYKjP/dibbUbwl/jK2KIozQA=;
        b=tcAEfB522eifi9DchGlBX3vfp/T7yigTf57uleKVgk4kVnqxJHbD6YqlStsRDcXHhP
         onMv5xIq8eX8IqL+KgnODQIzcXbFnHtARFrkFo8E4RbooHVCGbj3kYYvACV8FGi6tW4I
         DCqrQk/yMccqPXSu3v+LCMBy0WeMVz5dgt3dTTRdCBaiBV9nWn4EGod7Mcbag8zQNGQE
         xBHkJud0PYTlrDh0XvNIFWXpV0BJh0tKpY3kgNoraOKbHz2AtHOuPEwT7Jyngsy8e02A
         RFKItVojZRJ5nFxOeUQbbsE+UkcBwx5TiCQImpQOfF7N46erk8RXLDFPopI/3itXleIh
         imnw==
X-Gm-Message-State: AOAM532QxlMBSgVD5t9NVCR70W3Osw5gagOCbr8GATVmopTzhO0lhbmn
        KWyN53fAoD/JntUFYHQLAw4=
X-Google-Smtp-Source: ABdhPJzEFoHfdPqrpWj911wljIo/Sbv2TKeaYUCXMGhMI3KFyQrAccJqWJ7oaqqjx240JzkRsNUm6w==
X-Received: by 2002:a17:907:d8d:b0:6df:b214:392a with SMTP id go13-20020a1709070d8d00b006dfb214392amr15222921ejc.669.1649359705463;
        Thu, 07 Apr 2022 12:28:25 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: r8188eu: ROMVer is always zero
Date:   Thu,  7 Apr 2022 21:28:14 +0200
Message-Id: <20220407192819.10661-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

The variable ROMVer in struct HAL_VERSION is set to zero and never
changed. Remove it and replace its use with zero.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/hal_com.c           | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/HalVerDef.h     | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 7649f9919f67..910cc07f656c 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -44,7 +44,7 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 
 	cnt += sprintf((buf + cnt), "1T1R_");
 
-	cnt += sprintf((buf + cnt), "RomVer(%d)\n", chip_vers.ROMVer);
+	cnt += sprintf((buf + cnt), "RomVer(%d)\n", 0);
 
 	pr_info("%s", buf);
 }
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 6811be95da9a..609138887b25 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -505,7 +505,6 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
 	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
-	ChipVersion.ROMVer = 0;	/*  ROM code version. */
 
 	dump_chip_info(ChipVersion);
 
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 56dadadb1a0f..7a530c7d57eb 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -25,7 +25,6 @@ struct HAL_VERSION {
 	enum HAL_CHIP_TYPE	ChipType;
 	enum HAL_CUT_VERSION	CUTVersion;
 	enum HAL_VENDOR		VendorType;
-	u8			ROMVer;
 };
 
 /*  Get element */
-- 
2.35.1


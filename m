Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB2E49A8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbiAYDOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1318161AbiAYDEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:04:43 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AED6C0E5331
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o30-20020a05600c511e00b0034f4c3186f4so352652wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97GwBkpfkEyDXPs9Xg2PMr7/QxnDaM9vXKCUdcNdzlQ=;
        b=ch536Dq2+p5qGm7SDqd/7tTHbZh0/MFxbamVvJp4UwtA8hIEuzLVOkqNwojOiyNNvW
         l9lQ6Tt+02/My+3APjDxUWFMzpPRaRoQ3OFVuSD77hPQHfD66rGni0uTd0IlIX3k5tCx
         1alAT07eHhMe3THyARDSrF+cgxXvTeqQ4n4N/ivzVT7gU5nChQMBz7r3IOstkTyjO8oS
         6mpHk1SUFCDZ3mwfOVygBRiP/8DVdZHjArCgoaPOe/CS6q7RXs9fYXL5kr4OEesPmD5x
         jJKoSRgU5gVCOIc1SGwf07HiRfCMK4XlpuBmd+lGVoBx5KY4Zq3EymfcKQ0uHTgD9yDG
         Lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97GwBkpfkEyDXPs9Xg2PMr7/QxnDaM9vXKCUdcNdzlQ=;
        b=qp+qgGnl1iKUYqIpjU38VZTlNMj9CbdNCC/TNaueDfpPCScqnkstQM1mctLWysAfyo
         OoWcU3R6+4eo0xYOZgMocgt8ZLAv+3A604ngeAoNWCqH4ytMwz+NZqUsCDjG5qL6dqLq
         4/6916HfcUsy8Q9q4it1Rtuukekl/TUgtohY7F7Mfi//+2spdaGFpLOgyVaJg1WbWgQ8
         b1Eh49a0ec1XtbS/W2/xQLXu2jw7hDgSJ5Fs8NvO/eLS3eOpN6A2g3jvZUN27pjVetyY
         ujc7WmmapxSoQqnfAce7Q7euvbqeg+6nbwcX2rpC8mpGpB5ZxGpAP/GD+DqWJliFhXr8
         YbJA==
X-Gm-Message-State: AOAM5306p5SJicPrulLkaXmpk0OyoHbrDVi7oOReouzvVzGjGWHLXcCS
        gX4GtnNbm4Jz5j7uWGe8lBs5Uw==
X-Google-Smtp-Source: ABdhPJw1Pbz998Z2T97NBh6nX+rD2V4rXuGJTJn2mIfdxD5zRNSecpEGAL3kl6eKVmrz6OOv3S2pZg==
X-Received: by 2002:a1c:7303:: with SMTP id d3mr381891wmb.154.1643064280218;
        Mon, 24 Jan 2022 14:44:40 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:39 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 10/10] staging: r8188eu: remove GlobalDebugLevel flag
Date:   Mon, 24 Jan 2022 22:44:15 +0000
Message-Id: <20220124224415.831-11-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove hal/odm_debug.c, to get rid of the GlobalDebugLevel flag,
and remove the two other lines that reference GlobalDebugLevel, as
the last remaining user (DBG_88E) is now gone. Also modify Makefile
to no longer build hal/odm_debug.c.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/Makefile            | 1 -
 drivers/staging/r8188eu/hal/odm_debug.c     | 6 ------
 drivers/staging/r8188eu/include/rtw_debug.h | 2 --
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 1 -
 4 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/hal/odm_debug.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index a7a486cc16dd..ecd6fe5bd94c 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -10,7 +10,6 @@ r8188eu-y = \
 		hal/hal_intf.o \
 		hal/hal_com.o \
 		hal/odm.o \
-		hal/odm_debug.o \
 		hal/odm_HWConfig.o \
 		hal/odm_RegConfig8188E.o \
 		hal/odm_RTL8188E.o \
diff --git a/drivers/staging/r8188eu/hal/odm_debug.c b/drivers/staging/r8188eu/hal/odm_debug.c
deleted file mode 100644
index 7a134229fe39..000000000000
--- a/drivers/staging/r8188eu/hal/odm_debug.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#include "../include/rtw_debug.h"
-
-u32 GlobalDebugLevel;
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 959fb6bd25ca..01a7d987d6cc 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -52,6 +52,4 @@
 
 #define DRIVER_PREFIX	"R8188EU: "
 
-extern u32 GlobalDebugLevel;
-
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 17249b4fb7ad..8589de487289 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -155,7 +155,6 @@ static uint loadparam(struct adapter *padapter)
 {
 	struct registry_priv  *registry_par = &padapter->registrypriv;
 
-	GlobalDebugLevel = rtw_debug;
 	registry_par->chip_version = (u8)rtw_chip_version;
 	registry_par->rfintfs = (u8)rtw_rfintfs;
 	registry_par->lbkmode = (u8)rtw_lbkmode;
-- 
2.34.1


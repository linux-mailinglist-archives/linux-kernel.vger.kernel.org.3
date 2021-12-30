Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81724482020
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbhL3UBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242055AbhL3UBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:08 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973BCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:07 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v7so52257191wrv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5qh8kFRJCC9bZfIin5oq0yDXNUuQVM5WW/FTbxAj8HY=;
        b=lG2KQQ3txqqa0lLHdPi/YlgdiHwm2wAKRtp9EyOKp8DTPUS1sNEw541f1dkTyo9ETI
         aat8pK4nrISa9tfy9eVR7UQjfZ+u/kimEbuxMP+Zt/PgHEQmVcNSj45NZqe3Yj5HOqNR
         Pn5WPb0J7h3v+oCpM6bAavgJjW1wb0A+2kc7Mct1Kdcj15BcwnJghrs8AakjwUM+VovL
         tyneh59nWonun714/88im0UiYqykJPZ1L8Kdc7F1Y5wgzClNnqXH4dYLmPAIXAkJ1Jjp
         psly4Fb3jgX0HjBg9InQ32kHmOz7z7SjUmsmE0XaDyK5u0RzBQpBNVzSp53RzOp6jNp0
         /n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5qh8kFRJCC9bZfIin5oq0yDXNUuQVM5WW/FTbxAj8HY=;
        b=IMjbmcrLghdD3nv0lYPeTorF58ktbUx7ql7na6VuUXSNoc2ewMxqX49XBoS7EhqjIJ
         ZNeypn/So19Krp60C7A1tsYr6n3O8kdnKF0mR5TBJ2FlHtZUJ4dNIiewFJa1gc9oLES+
         eTzw0c+QfCyI3RA7yT5kLU4+Sn/LbwHLuy2GsGclsaxhKIy0zKs48K+MIfSueMPBRJj2
         C5uT/vdTYLL0tcQeBAuTmPYtsVmPwX7Vx+AVNnAm+Gl/qN0pVkxMSLoEL5K8ai1OoT7q
         itgbnhR+HpYgC/ue2/tXam1uwkoZx+1vS2GdFWm5zamuNTGe81NG+2rWkevhkupehgKi
         t+xg==
X-Gm-Message-State: AOAM530J3NOV+gNf1xVaegFuFY94wMAk0dcnlc37t/yo9BMtQC4lKg6D
        eNhvVMiKsAcghfJFSYsZtSg=
X-Google-Smtp-Source: ABdhPJx2vOFcp7rwJD0AiyjxDud9VUPgEdRTp9LjW6cTBvdjt63AEUnMhaPfrASGolEMwU/OXqdkIQ==
X-Received: by 2002:a05:6000:1865:: with SMTP id d5mr25335247wri.650.1640894466241;
        Thu, 30 Dec 2021 12:01:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: r8188eu: bRDGEnable is always false
Date:   Thu, 30 Dec 2021 21:00:53 +0100
Message-Id: <20211230200059.13406-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bRDGEnable in struct hal_data_8188e is never set. It stays
at its default value 0. Remove bRDGEnable and related dead code.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 10 ----------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d5c7e8bf1f38..104705ef170e 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -384,13 +384,6 @@ static void _InitEDCA(struct adapter *Adapter)
 	rtw_write32(Adapter, REG_EDCA_VO_PARAM, 0x002FA226);
 }
 
-static void _InitRDGSetting(struct adapter *Adapter)
-{
-	rtw_write8(Adapter, REG_RD_CTRL, 0xFF);
-	rtw_write16(Adapter, REG_RD_NAV_NXT, 0x200);
-	rtw_write8(Adapter, REG_RD_RESP_PKT_TH, 0x05);
-}
-
 static void _InitRetryFunction(struct adapter *Adapter)
 {
 	u8 value8;
@@ -712,9 +705,6 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 	value16 |= (MACTXEN | MACRXEN);
 	rtw_write8(Adapter, REG_CR, value16);
 
-	if (haldata->bRDGEnable)
-		_InitRDGSetting(Adapter);
-
 	/* Enable TX Report */
 	/* Enable Tx Report Timer */
 	value8 = rtw_read8(Adapter, REG_TX_RPT_CTRL);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index b42af86555cd..e8cb093abb62 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -236,9 +236,6 @@ struct hal_data_8188e {
 
 	u32	RfRegChnlVal[2];
 
-	/* RDG enable */
-	bool	 bRDGEnable;
-
 	/* for host message to fw */
 	u8	LastHMEBoxNum;
 
-- 
2.34.1


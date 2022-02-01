Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68074A58AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiBAIn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiBAInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:43:14 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52554C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 00:43:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id s5so51553054ejx.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vPQCFVUGDeDMouS1odhJlOYowD2BZ8XAZv0e1KiFcMo=;
        b=nJcTaD/F0+VZC2ybxywaJf7H0PwTo7aCzxgk9dVSrGKWlo20fo5rvndS+5shAyM7gq
         LreNSVdToXdQx4fcD84XRMJrjYloOdma44WtUODA9YqsIaEZAuwZ3vQ8dj42CkFEjmui
         bBrOqQKTM6Qqs/eQTxL0qWbrTj8XK/ZRLFRcJMgstRWD76y71PJF2XYmjOGJ8EWaC29P
         3GH5M9gplz37Iarer4/JB4eYQ8CstWfcYfcrdGpJMHMbuiJyo4iNAr0cDmLODUeQkvB6
         0iqYoHmh2J7AZ2TkyUxYWgLbgMzKhlTrGjjyElfwUAhl5TsU/Ad6fyXJtlFtu1ml9wuY
         4Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vPQCFVUGDeDMouS1odhJlOYowD2BZ8XAZv0e1KiFcMo=;
        b=k1NyDs0QN2oBGCMQXYQK2WGJ85bNNrZ7YQkD2L6QZEJKkN+IZEL1QpnRIBzwkEELsv
         9j4fr/d7jj/6yNUmeyuOU30FjKTD1YgsFCQ5L2+OCC2hSJ8N5mDI39s7Ecy6cOmdgp69
         nnPG3weDMOg+HqJvqyY39OcsCspL2VYJN1uJGwgepoARLquAK3BSdrBb9Y66qnT1p/T0
         BniDbECfFJl4XDOxoicVI8oqg5lir+N77f/nu8Yl4S1EyqUu7O3M1yfwq0vzK3+a1Ktd
         S463KXPCpX4+Try88iYuCJWZHJ78+O31k9juyULhADgJdPHVk9sNzoTex8PmQUIlnKaS
         EDig==
X-Gm-Message-State: AOAM5321Nf2kHq0QcgXNcif4Gn5Z7sMK7rNo9ogKI1hKwXu9wGhtH+fC
        cUDMVymVxg7JQu1N0mCcG/s=
X-Google-Smtp-Source: ABdhPJzLIKmai4++TF1kULNC15dnHMhxMezgP2z433alncp1QshFpkCsfuz6oLyJFtCEK/+j41WmpQ==
X-Received: by 2002:a17:907:6290:: with SMTP id nd16mr19760537ejc.33.1643704992960;
        Tue, 01 Feb 2022 00:43:12 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id c14sm19123431edy.66.2022.02.01.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 00:43:12 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/9] staging: r8188eu: remove ReceiveConfig from struct hal_data_8188e
Date:   Tue,  1 Feb 2022 09:42:53 +0100
Message-Id: <20220201084259.7497-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201084259.7497-1-straube.linux@gmail.com>
References: <20220201084259.7497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ReceiveConfig variable in struct hal_data_8188e is only used
to store a local value. Use a local variable instead and remove
ReceiveConfig from struct hal_data_8188e.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 12 +++++-------
 drivers/staging/r8188eu/include/rtl8188e_hal.h |  1 -
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 91b854c7b9a1..2252e8a1d55b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -324,15 +324,13 @@ static void _InitDriverInfoSize(struct adapter *Adapter, u8 drvInfoSize)
 
 static void _InitWMACSetting(struct adapter *Adapter)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
-	haldata->ReceiveConfig = RCR_AAP | RCR_APM | RCR_AM | RCR_AB |
-				  RCR_CBSSID_DATA | RCR_CBSSID_BCN |
-				  RCR_APP_ICV | RCR_AMF | RCR_HTC_LOC_CTRL |
-				  RCR_APP_MIC | RCR_APP_PHYSTS;
+	u32 receive_config = RCR_AAP | RCR_APM | RCR_AM | RCR_AB |
+			     RCR_CBSSID_DATA | RCR_CBSSID_BCN |
+			     RCR_APP_ICV | RCR_AMF | RCR_HTC_LOC_CTRL |
+			     RCR_APP_MIC | RCR_APP_PHYSTS;
 
 	/*  some REG_RCR will be modified later by phy_ConfigMACWithHeaderFile() */
-	rtw_write32(Adapter, REG_RCR, haldata->ReceiveConfig);
+	rtw_write32(Adapter, REG_RCR, receive_config);
 
 	/*  Accept all multicast address */
 	rtw_write32(Adapter, REG_MAR, 0xFFFFFFFF);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 661c447a0453..88246ef65f8a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -151,7 +151,6 @@ struct txpowerinfo24g {
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
 	/* current WIFI_PHY values */
-	u32	ReceiveConfig;
 	enum ht_channel_width CurrentChannelBW;
 	u8	CurrentChannel;
 	u8	nCur40MhzPrimeSC;/*  Control channel sub-carrier */
-- 
2.34.1


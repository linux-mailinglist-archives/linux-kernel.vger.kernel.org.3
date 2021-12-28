Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07541480846
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbhL1KMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbhL1KLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:52 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A6CC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:51 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s1so37457961wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oY9hSfkqZTFPqAFtoGBpdMUae0krMzwYjwLMqlw8+0I=;
        b=JHfloE24oleodZ3g+wWzd3v/hSXxLN6jmrsVGqZ/iN4MQYQsax2gGyFoQDuOrFUfyc
         Ft99f3nus0fTrbAguzYnQvwxtOluL5tSq3Hj+LRYnDQfk/ocIj+AO8z6hQ0KwLNQAtWA
         v7u38tHMUdHUHj2p8v1BbVBA5jkgsJnJ1tFYGJLfevlvQhkl2D7qi23VLPuXOouqYPaP
         Hf6LPMQL3kcQ3H/wA60+mrwaE84eIUS7XTZYY/C5SQSuPGM2xDk3PMXDI2rWKApidx9w
         MwXH47DYQoXWpzqNuN1hXSgw3JYWIGy9LkbMsqrtdTXaoyPx6S+gMvGL+mJra0aW3tyK
         ZsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oY9hSfkqZTFPqAFtoGBpdMUae0krMzwYjwLMqlw8+0I=;
        b=qliI3rt1EaqEy5xQ3wAX3z8fNd48aCNwWPq7838V24mCXp1t6A5EKbmriIxkO3k7zG
         I/6Ccd1Scqn+fM/afC8hBqQ/eVfkylYKXChf/DJ/N+YHSQa+8lYX4B160AtsiTz3L3Vi
         F7CWSURM5oDrRSyScoqPfpR1zQcxgHA07II+AzGPX7RsiSJlBuxqY9vo47g7qcAPPWGL
         JVgEBWaHg1G5I9YzBryBsRt1fzgdTCVBTxahCCTpR3aGKZvkwM7s0Kg7IFEoj2WpxOrT
         znZblGOeskSQzdIQp2ou87f2Idzch6i+Yxaj+sNn0vv50KVRhQwBc7E0Ls6OWBRXp6R+
         BH3A==
X-Gm-Message-State: AOAM530yuj56K4fgHsZWfGZoBWzxNhngdIyzrdXKlVJx1e3d0fUrKtX2
        DhR993pRimNESmprEUve+Ts5UH3YWwI=
X-Google-Smtp-Source: ABdhPJzNxtaG7srAogqMjSOtL5UgMh5WTzO8tfE7aTZKkZe08FODYcEuoKfzyHp5COgFsW/IaSs14Q==
X-Received: by 2002:a05:6000:2a9:: with SMTP id l9mr15786747wry.185.1640686310321;
        Tue, 28 Dec 2021 02:11:50 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/10] staging: r8188eu: merge _ReadLEDSetting() into ReadAdapterInfo8188EU()
Date:   Tue, 28 Dec 2021 11:11:20 +0100
Message-Id: <20211228101120.9120-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function _ReadLEDSetting() sets only a single variable and the only
user is ReadAdapterInfo8188EU(). Remove _ReadLEDSetting() and set the
variable in ReadAdapterInfo8188EU() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9edde72aebb2..b362c622ea8a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -914,12 +914,6 @@ unsigned int rtl8188eu_inirp_init(struct adapter *Adapter)
 /*	EEPROM/EFUSE Content Parsing */
 /*  */
 /*  */
-static void _ReadLEDSetting(struct adapter *Adapter, u8 *PROMContent, bool AutoloadFail)
-{
-	struct led_priv *pledpriv = &Adapter->ledpriv;
-
-	pledpriv->bRegUseLed = true;
-}
 
 static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool AutoLoadFail)
 {
@@ -939,6 +933,7 @@ static void Hal_EfuseParseMACAddr_8188EU(struct adapter *adapt, u8 *hwinfo, bool
 void ReadAdapterInfo8188EU(struct adapter *Adapter)
 {
 	struct eeprom_priv *eeprom = &Adapter->eeprompriv;
+	struct led_priv *ledpriv = &Adapter->ledpriv;
 	u8 eeValue;
 
 	/*  Read EEPROM size before call any EEPROM function */
@@ -966,7 +961,7 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	Hal_ReadAntennaDiversity88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 	Hal_ReadThermalMeter_88E(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
 
-	_ReadLEDSetting(Adapter, eeprom->efuse_eeprom_data, eeprom->bautoload_fail_flag);
+	ledpriv->bRegUseLed = true;
 }
 
 static void ResumeTxBeacon(struct adapter *adapt)
-- 
2.34.1


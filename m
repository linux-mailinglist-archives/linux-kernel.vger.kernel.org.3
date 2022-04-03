Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76574F0B5C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359515AbiDCQzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiDCQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:54:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D293915C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bq8so15381749ejb.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eX3bcVXRctAIJWE0PzZknmJGr6Nu+7MDG6sRwBC8R4=;
        b=epsyyxWpxYd+pf8i8+w4cH0N6Kma/d1PJ2WVLDRIedX8TYhSdOz4NrhugWDDKuVrFP
         PfOnrxfPPquXd+VPi6LktGYXsoCDjgqGvgUSWiJAYggH1Ix636PAArSKZCw4En2Ul69m
         gPC1pHWSaJyMroWdh/cdzI5/k9/dUQ9mLdyVXYPL8S1xsT7U3Wl+JmgrXkQXVH6/c2v0
         RNXsfEoDFbw29CQSLf+fqGLR8QZkmYg5dm+gbp8ezYQJITBHbhLfQmQvOLsKDa68nsgC
         7l+8dXZn64/pggf+yvqf4URkkAynYGkwA18lX9a0Y4YwjI+A4L5EiETABHAQ2Vv8a2OW
         4Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4eX3bcVXRctAIJWE0PzZknmJGr6Nu+7MDG6sRwBC8R4=;
        b=KP+fYWrBY0zWRgaohAGo22H5A4Eduiwr7RwKV/FarCNUfC+aLlTXwoQ8H7t3yqrX+Z
         mvCokYrvOX+UYf03OhqkYIbkT/Zzcr+MIqozmdbYLK09L/bxVs9iXFYMG13ucfMtqE7W
         tCe5HmJQqKIrITzMZ4Vu8n9f7S5r8dVyzA8hDBDDkynRTv8Ie+D29dAw4bSqOY74RYPY
         FnFrZIVYQTCVphe9+CW4G4bp/EhCWBojbx4t9keJ41SP/X9ylaxqbw9w8JWbpN29NHGz
         v4qVHQQioEQBBbOIZm66BthOVz3/Mv6voE0BeiWrF9lgpNhQR/EsM6cxdEmEuDZlUtGf
         MXZQ==
X-Gm-Message-State: AOAM530jxHd80MQwJWZ63HIb/minvsNCqHsD5rnJpxdBMtX78iG5FIup
        QNr5tfiW1bhgOcNO7SHlaGc=
X-Google-Smtp-Source: ABdhPJyC75SVETDy5ohVbpOLgMyEY4yCaWXXexkaReT/gQ0Hu9tqBVZJT4YDpdmpMjr39j7mhJeZrQ==
X-Received: by 2002:a17:907:dab:b0:6df:e51a:b990 with SMTP id go43-20020a1709070dab00b006dfe51ab990mr7370885ejc.573.1649004784173;
        Sun, 03 Apr 2022 09:53:04 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: use support_ant_div()
Date:   Sun,  3 Apr 2022 18:52:52 +0200
Message-Id: <20220403165255.6900-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403165255.6900-1-straube.linux@gmail.com>
References: <20220403165255.6900-1-straube.linux@gmail.com>
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

Use support_ant_div() instead of checking haldata->AntDivCfg directly.
This improves readability and makes future cleanups, e.g. removing the
hal_data_8188e structure, easier.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 8 +++-----
 drivers/staging/r8188eu/hal/usb_halinit.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 6d28e3dc0d26..d69327f361aa 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -33,7 +33,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	int i;
 
 	pdmpriv->InitODMFlag = ODM_BB_RSSI_MONITOR;
-	if (hal_data->AntDivCfg)
+	if (support_ant_div(Adapter))
 		pdmpriv->InitODMFlag |= ODM_BB_ANT_DIV;
 
 	dm_odm->SupportAbility = pdmpriv->InitODMFlag;
@@ -102,9 +102,7 @@ void rtl8188e_init_dm_priv(struct adapter *Adapter)
 /*  Compare RSSI for deciding antenna */
 void AntDivCompare8188E(struct adapter *Adapter, struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src)
 {
-	struct hal_data_8188e *hal_data = &Adapter->haldata;
-
-	if (0 != hal_data->AntDivCfg) {
+	if (support_ant_div(Adapter)) {
 		/* select optimum_antenna for before linked =>For antenna diversity */
 		if (dst->Rssi >=  src->Rssi) {/* keep org parameter */
 			src->Rssi = dst->Rssi;
@@ -122,7 +120,7 @@ u8 AntDivBeforeLink8188E(struct adapter *Adapter)
 	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
 
 	/*  Condition that does not need to use antenna diversity. */
-	if (hal_data->AntDivCfg == 0)
+	if (!support_ant_div(Adapter))
 		return false;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 31ec88b7a400..e5b352671ea4 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -492,7 +492,7 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 
-	if (haldata->AntDivCfg == 0)
+	if (!support_ant_div(Adapter))
 		return;
 
 	rtw_write32(Adapter, REG_LEDCFG0, rtw_read32(Adapter, REG_LEDCFG0) | BIT(23));
-- 
2.35.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2273E4F4A51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1455115AbiDEWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358881AbiDELRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DEB8A32D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 03:49:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a6so14915022ejk.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 03:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Adg3pN2RW58wCT9rm+ufFClNqKORGkE/N3E2nxNd7RY=;
        b=UNwkZnqk7dS8LG08uS2paqAo7c3EjqpY8dO4XyoghVpgARkcT6BjhzsEHkCyaVGpuU
         VZ6s3URU004FZ/EoRCCHRR/W8F5zWAOv/G7xiHymasP8sycr/kBLCTG0grOPxO/SmNzV
         UNxkr13NClG5ZDi4Nw5F4ofob7HKxUqPMAGb2b4EYS3xbxKGanh8Z444D6FmFFCj5Fhy
         ewg3m03VFw9oGe8R2qzecy6YNvD/4gK9TnGx8uN2/HwEVTXXxx/ZLLQWGsrB7fJdJhCc
         IBEwwcYUVQd+HfJbyfvfFpXVsJhgvtR9mudbizOoFuqeO45C3zBccb4ilmoblr8/ySFK
         WQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Adg3pN2RW58wCT9rm+ufFClNqKORGkE/N3E2nxNd7RY=;
        b=8NIRqzSCkGZkxBmzriTJ7XLeb0dlXhOxJF6sG9MphkKYzpCOnyy/J7QeoTXIQV2089
         2BckPFByKb4jfMawVSk+170roJok+a50pu29qREEGtEyrVAyTvNgE3KigCebaBDVtwAp
         7jS/Tl9ZsXZY25UwFewLFnWdTv5xYtvkKxsgwrV2yM1DhD9pfrfd/LUZTpHZ45s456eP
         QIiuCv8IL6gNsOdi7HtnZPTbfOrEfN6ec954bjbGB1xlGVLsq2JPGUZ6LvZ0TkpwPkAy
         5MMiE4YPNrcjyGIcJKEApEqKRHQrWueXIciy3lTldUvBGFn8Kl2Q/t9v8qCxqI1zMhIy
         S1lg==
X-Gm-Message-State: AOAM5337WWSLfC4jMlJosfdiHczpxvWCzlrxvmNbfcKVG9Tfisjnv3Lc
        YXkpgmgvMZfSRoK3kP2Zge4=
X-Google-Smtp-Source: ABdhPJxtwBNi5M3av58Natvm7wrBfwyDLFGOKk8pLWKQyqncAUaQNgIcZ12kpqxDNSOBKvaW+hZhxw==
X-Received: by 2002:a17:907:c16:b0:6db:682:c8c9 with SMTP id ga22-20020a1709070c1600b006db0682c8c9mr2987787ejc.153.1649155769444;
        Tue, 05 Apr 2022 03:49:29 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm2436702edl.28.2022.04.05.03.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:49:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/4] staging: r8188eu: remove GetHalDefVar8188EUsb()
Date:   Tue,  5 Apr 2022 12:49:10 +0200
Message-Id: <20220405104910.9769-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405104910.9769-1-straube.linux@gmail.com>
References: <20220405104910.9769-1-straube.linux@gmail.com>
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

The local variable odm_flag in rtw_dbg_port() is set but never used.
This are the last two remaining calls to GetHalDefVar8188EUsb(). Both
calls can be removed and we finally can remove GetHalDefVar8188EUsb()
itself. This is part of the ongoing effort to get rid of the unwanted
hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/hal/usb_halinit.c    | 14 --------------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  8 +-------
 3 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 9d39c5ca56a7..c983e42bf523 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1198,20 +1198,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 
 }
 
-/* Query setting of specified variable. */
-void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
-{
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
-	switch (eVariable) {
-	case HAL_DEF_DBG_DM_FUNC:
-		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
-		break;
-	default:
-		break;
-	}
-}
-
 /* Change default setting of specified variable. */
 void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue)
 {
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 0bc274a695d9..ab6cab1281ab 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -52,7 +52,6 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
 				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
 
 void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
-void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariable, void *pValue);
 
 unsigned int rtl8188eu_inirp_init(struct adapter *Adapter);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index d127cebb6eae..b6851628e4d2 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3675,22 +3675,16 @@ static int rtw_dbg_port(struct net_device *dev,
 			break;
 		case 0xee:/* turn on/off dynamic funcs */
 			{
-				u32 odm_flag;
-
-				if (0xf == extra_arg) {
-					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
-				} else {
+				if (extra_arg != 0xf) {
 					/*	extra_arg = 0  - disable all dynamic func
 						extra_arg = 1  - disable DIG
 						extra_arg = 2  - disable tx power tracking
 						extra_arg = 3  - turn on all dynamic func
 					*/
 					SetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &extra_arg);
-					GetHalDefVar8188EUsb(padapter, HAL_DEF_DBG_DM_FUNC, &odm_flag);
 				}
 			}
 			break;
-
 		case 0xfd:
 			rtw_write8(padapter, 0xc50, arg);
 			rtw_write8(padapter, 0xc58, arg);
-- 
2.35.1


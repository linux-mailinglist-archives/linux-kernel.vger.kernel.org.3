Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004CC4F0015
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354118AbiDBJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239698AbiDBJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:25:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CB4090A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:23:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z92so5503674ede.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgjJrokkXW7Ziu+fxR7JRBXcinNIm/xAaNlTUHhZFuU=;
        b=Z2Un54v4t6eamg3GVvDZNvNGPyBCOn2DYh9tZbI07SlbWX8HpWAGtsjMgEFO9b3APT
         hCp8EcJyTni8mLwNKwYg8sGkodA6XDIJ/qy11swr1JiwkcHMaBXMQzGWfYs0CZTgu+yK
         zKJlulq72LFuurHa6xJf0zfVvUMTDUu3jvpkDPxQIm2koNZL3GkvbnHKU3E2BrPIcOQK
         ANzmKU02RVZR3YoH3CwvGKGu8t+1kPDRIqVfPPq8TiomytzCY3kd75LI8dSVsTfeMFDX
         DoOMO3CQGYHHh9WZ94wVbCwtLODDMFacJKM54JxTgv9aXZF/zqaRmGnm4c2lj5xKv0lF
         mEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgjJrokkXW7Ziu+fxR7JRBXcinNIm/xAaNlTUHhZFuU=;
        b=Ic4sbajmFsUjeVvLX6/BKEO22XVXihgoBL2naYsmIIiAIojpks4upO5hOslIkdMorN
         9hkFkVg49cV+tgdcoQCaXw06R2m7XVx4Bzeh1cAesSwH/rpw6aRJ6hkTKB1gnc2bR8YV
         oJfbzqvdLm2olKkjN5OvKQCm9ozK+ozRbgd1LrMASlh4Y+TALu/axIw3NO0E1mLtPz0R
         i2XXxVPCRKjOAoUpzr04SuKduTfJHPWNTwPETKOWnMBkNey8PPAWRhFHcdtktNJH7NkG
         WU/8QAvBYnAfMPupmii0yqonAgPrzONqd0zIC0H9YVXj+CM6w8ilTHzXUikuXeQ9DIKi
         9r4A==
X-Gm-Message-State: AOAM532IMJRSYq6VQaLcrdEeQK+9VXGsKhVxYECJ168NKvhCg2y+U3zL
        r5/oDCYfiVdvqyP7RvKk7rg=
X-Google-Smtp-Source: ABdhPJx4/vvkLW28QmKU8BZiJ65P4P8VuYoazr+kH+MkJ69+NCRK6N6hIwkrGojB5JuIyYFYDu1s3g==
X-Received: by 2002:aa7:c157:0:b0:418:f8e3:4c87 with SMTP id r23-20020aa7c157000000b00418f8e34c87mr24371555edp.271.1648891418569;
        Sat, 02 Apr 2022 02:23:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id jv19-20020a170907769300b006e095c047d6sm1897679ejc.109.2022.04.02.02.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 02:23:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/7] staging: r8188eu: remove HW_VAR_BSSID from SetHwReg8188EU()
Date:   Sat,  2 Apr 2022 11:23:26 +0200
Message-Id: <20220402092332.6627-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220402092332.6627-1-straube.linux@gmail.com>
References: <20220402092332.6627-1-straube.linux@gmail.com>
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

Remove the HW_VAR_BSSID case from SetHwReg8188EU() and move its
functionality to rtw_mlme_ext.c where it is actually used. This is
part of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 18 +++++++++++++-----
 drivers/staging/r8188eu/hal/usb_halinit.c   | 14 --------------
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 6166baa64091..d409e98f8795 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6096,6 +6096,14 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 	return _SUCCESS;
 }
 
+static void rtw_set_bssid(struct adapter *adapter, u8 *bssid)
+{
+	int i;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		rtw_write8(adapter, REG_BSSID + i, bssid[i]);
+}
+
 void start_create_ibss(struct adapter *padapter)
 {
 	unsigned short	caps;
@@ -6130,7 +6138,7 @@ void start_create_ibss(struct adapter *padapter)
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
-			SetHwReg8188EU(padapter, HW_VAR_BSSID, padapter->registrypriv.dev_network.MacAddress);
+			rtw_set_bssid(padapter, padapter->registrypriv.dev_network.MacAddress);
 			join_type = 0;
 			SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
@@ -6711,7 +6719,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	if (join_res < 0) {
 		join_type = 1;
 		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
-		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
+		rtw_set_bssid(padapter, null_addr);
 
 		/* restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
@@ -6830,7 +6838,7 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
 		mlme_disconnect(padapter);
-		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
+		rtw_set_bssid(padapter, null_addr);
 
 		/* restore to initial setting. */
 		update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
@@ -7266,7 +7274,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 	/* config the initial gain under linking, need to write the BB registers */
 
-	SetHwReg8188EU(padapter, HW_VAR_BSSID, pmlmeinfo->network.MacAddress);
+	rtw_set_bssid(padapter, pmlmeinfo->network.MacAddress);
 	join_type = 0;
 	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
 
@@ -7290,7 +7298,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
 
 	mlme_disconnect(padapter);
-	SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
+	rtw_set_bssid(padapter, null_addr);
 
 	/* restore to initial setting. */
 	update_tx_basic_rate(padapter, padapter->registrypriv.wireless_mode);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 6b4b0b0c4f53..cf34645b3de5 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -942,17 +942,6 @@ static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
 	}
 }
 
-static void hw_var_set_bssid(struct adapter *Adapter, u8 *val)
-{
-	u8 idx = 0;
-	u32 reg_bssid;
-
-	reg_bssid = REG_BSSID;
-
-	for (idx = 0; idx < 6; idx++)
-		rtw_write8(Adapter, (reg_bssid + idx), val[idx]);
-}
-
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -963,9 +952,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 	case HW_VAR_SET_OPMODE:
 		hw_var_set_opmode(Adapter, val);
 		break;
-	case HW_VAR_BSSID:
-		hw_var_set_bssid(Adapter, val);
-		break;
 	case HW_VAR_BASIC_RATE:
 		{
 			u16 BrateCfg = 0;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 9b465001975c..591322c20f7d 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -10,7 +10,6 @@
 
 enum hw_variables {
 	HW_VAR_SET_OPMODE,
-	HW_VAR_BSSID,
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
-- 
2.35.1


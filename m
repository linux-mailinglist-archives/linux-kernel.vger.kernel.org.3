Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDF14EB4A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiC2UXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiC2UXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:35 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1300023B3DC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:51 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a8so37281915ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwoHH2DorQoLHJxUTXcAs6n0sWifllvRMo0K56xrEzw=;
        b=mQ3AbiTBM6wCrigpmTiVd/Ll38qQH+4MXqq5afjCa0AcRph490/4HL4l5dH1Okt71G
         sElXl2tczJw/DGceqv/ckeN8TgyJO/uEvK6CqqnptIbjq8RedVVwga8UOl9nF7bvi8ZZ
         wcitcXQmn/SUHqyKN0yAJ8nM4D+59JSn9YHVYnSrDQIpvALUAQsj6KVr/i+W93gkEH3J
         oM5ttIUgNbhMQB14TTV9qjyCYxJMEqUeVOK4XJ5KEsBDOSUbpJaX+9TNH7VqhU/Wh+Ov
         gCkNfrgRRyvAgQmwXr7HVGNqi2K622a7T6EZnOJ3gWh671JUX70ZK0tUvuXNkrSf/jCn
         5MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwoHH2DorQoLHJxUTXcAs6n0sWifllvRMo0K56xrEzw=;
        b=ZMiNKNMquFAMkPtUQjheLiskjK5Saq0rryAOOPPmJKs/N3cFTagpYsiX4ABizGa25e
         9erdFqmS7Yu3swWovcdedPFBtZ4vQwuweLAGxcNEVSsf7NYG7mLAeU1BX/L79kHonWIo
         uzVnimS5B7wM7UyZ0PNixcQsgvCMw889h3t/JoRWJ3CVy76LprXLkxvMT2vMkGxjFpBO
         or/w19wJDrSVRMKXuTacULxBK8+b8oGjKLkuERFA2SfGjpCJ+KDJNvyjUP3d3fuUyv+z
         5JDZd0r5m9UiFtl8PAh6DmXkvBOq2LoJo4WUFIh9gNk/hf9i0bV+kwnj8gWJOu+nZyMA
         ZquA==
X-Gm-Message-State: AOAM530JmVV1f3kmH5EokZ232zZKhJymT/jNXBlXT3WmNm4byyLxVZbf
        oIyT+uAlSSmEwJFYc+Gy9fo=
X-Google-Smtp-Source: ABdhPJw4oLdWWjJKgol/2/7lcJdEbAX5CWE5R7NVZULtHjCju1DvV5+XbQ2GXKKxTYyK+y8GhNAe4w==
X-Received: by 2002:a17:907:b590:b0:6cf:48a4:9a4c with SMTP id qx16-20020a170907b59000b006cf48a49a4cmr35635934ejc.6.1648585309697;
        Tue, 29 Mar 2022 13:21:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/8] staging: r8188eu: remove HW_VAR_RESP_SIFS from SetHwReg8188EU()
Date:   Tue, 29 Mar 2022 22:21:34 +0200
Message-Id: <20220329202141.7028-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329202141.7028-1-straube.linux@gmail.com>
References: <20220329202141.7028-1-straube.linux@gmail.com>
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

SetHwReg8188EU() is called with HW_VAR_RESP_SIFS only in one place.
Remove the HW_VAR_RESP_SIFS case from SetHwReg8188EU() and call
rtw_write8() directly instead. This is part of the ongoing effort to
get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/core/rtw_wlan_util.c | 11 ++++++-----
 drivers/staging/r8188eu/hal/usb_halinit.c    |  8 --------
 drivers/staging/r8188eu/include/hal_intf.h   |  1 -
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 5a1eede57458..e44f4752f222 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1326,7 +1326,6 @@ void update_capinfo(struct adapter *Adapter, u16 updateCap)
 void update_wireless_mode(struct adapter *padapter)
 {
 	int ratelen, network_type = 0;
-	u32 SIFS_Timer;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex	*cur_network = &pmlmeinfo->network;
@@ -1353,10 +1352,12 @@ void update_wireless_mode(struct adapter *padapter)
 
 	pmlmeext->cur_wireless_mode = network_type & padapter->registrypriv.wireless_mode;
 
-	SIFS_Timer = 0x0a0a0808;/* 0x0808 -> for CCK, 0x0a0a -> for OFDM */
-				/* change this value if having IOT issues. */
-
-	SetHwReg8188EU(padapter, HW_VAR_RESP_SIFS, (u8 *)&SIFS_Timer);
+	/* RESP_SIFS for CCK */
+	rtw_write8(padapter, REG_R2T_SIFS, 0x08);
+	rtw_write8(padapter, REG_R2T_SIFS + 1, 0x08);
+	/* RESP_SIFS for OFDM */
+	rtw_write8(padapter, REG_T2T_SIFS, 0x0a);
+	rtw_write8(padapter, REG_T2T_SIFS + 1, 0x0a);
 
 	if (pmlmeext->cur_wireless_mode & WIRELESS_11B)
 		update_mgnt_tx_rate(padapter, IEEE80211_CCK_RATE_1MB);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 789ad11170b2..0186f8bf73c7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1119,14 +1119,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			}
 		}
 		break;
-	case HW_VAR_RESP_SIFS:
-		/* RESP_SIFS for CCK */
-		rtw_write8(Adapter, REG_R2T_SIFS, val[0]); /*  SIFS_T2T_CCK (0x08) */
-		rtw_write8(Adapter, REG_R2T_SIFS + 1, val[1]); /* SIFS_R2T_CCK(0x08) */
-		/* RESP_SIFS for OFDM */
-		rtw_write8(Adapter, REG_T2T_SIFS, val[2]); /* SIFS_T2T_OFDM (0x0a) */
-		rtw_write8(Adapter, REG_T2T_SIFS + 1, val[3]); /* SIFS_R2T_OFDM(0x0a) */
-		break;
 	case HW_VAR_ACK_PREAMBLE:
 		{
 			u8 regTmp;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 6f661c4af358..77069cbc1e07 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -17,7 +17,6 @@ enum hw_variables {
 	HW_VAR_MLME_SITESURVEY,
 	HW_VAR_MLME_JOIN,
 	HW_VAR_SLOT_TIME,
-	HW_VAR_RESP_SIFS,
 	HW_VAR_ACK_PREAMBLE,
 	HW_VAR_BCN_VALID,
 	HW_VAR_DM_FLAG,
-- 
2.35.1


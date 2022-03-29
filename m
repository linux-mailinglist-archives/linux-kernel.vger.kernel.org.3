Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671734EB4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiC2UXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiC2UXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81023B3DF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id pv16so37466649ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IFwCjklhdRZF/g42Am6ngyzxVzMgTYWvicG6NBlRjM=;
        b=G1iMqA5VrU8bfNiRqfkjPG99D1FghY/aI+iNYv291Gxlg440Cq8gTnfKzjelxam0wL
         tGDRpmqIKmY7K26DQiGGl8m9Yu1RA8uXgLLBBGbwZssgCXtRlavVLAwIhsevmQZlU2A4
         QAbZWLsxkAvNXPOJHp75CKhv/nJZ85mDxxbDxfqPqqP+owbqfrlU8EB1ZLkOXG45jJ/5
         lvnCR7E3S1ngFJP1rRfIMP9ARiXcA/CsSQZ+XsJIuLkBzxhlGbwgrkhDWPoNZbxFOZ1p
         uVrCaZiVhXaiZ+1vGPfowv0crlrwdSHzmdtSGpO6fwxJzXVeF/HI1kzYOucGaEhbaoNx
         JHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IFwCjklhdRZF/g42Am6ngyzxVzMgTYWvicG6NBlRjM=;
        b=bRfuiO7Q8TautE68NJ44Bpri6Uv25aBSLx6J0w1aPCzkNkPgkvARo+VDvk57RP2iLS
         I6T8FOD/KaldPgKCT9uEDtmTWNGqhUFUAc+ou9hmpvAYe8IP3Ml6me+LwMZ60yTP1Z3+
         Vkr5BxMyvv6EyetutgGpmxChEo2O6NBWUNvJvP6Wt8Anf7zdbxT754s7CAeKtwpYTVQy
         RKZRYHTUuXDq5hRNjTeD3XuNJVbRvs2VKXkGlYaUw9/sBveG+6WGLyZwZxEtCc+Sx2BD
         kPZKnBPFURvoaV2OIVoRQFTmamzbeJoEw3ar6p7ctd5e3ElWuot2JXrXZseqHlqHn4Gi
         wwlw==
X-Gm-Message-State: AOAM533a5zV4a3U4DHBlCPsAegJjh+37Jiq30N10LJnzN8tQ/YjRYBQ8
        5jweJnolB7ks3g641ygM2Lw=
X-Google-Smtp-Source: ABdhPJwrIj+5MAnCgW7GIyGwt8R/AGvQIxzLAUowU6Dz+8h8/P33LuxJRRVek/UUeeFM5V+OKNM61Q==
X-Received: by 2002:a17:906:3283:b0:6ce:78f9:fafd with SMTP id 3-20020a170906328300b006ce78f9fafdmr37454449ejw.534.1648585310502;
        Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/8] staging: r8188eu: remove HW_VAR_MLME_DISCONNECT from SetHwReg8188EU()
Date:   Tue, 29 Mar 2022 22:21:35 +0200
Message-Id: <20220329202141.7028-3-straube.linux@gmail.com>
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

SetHwReg8188EU() is called with HW_VAR_MLME_DISCONNECT only from
functions in rtw_mlme_ext.c. Move the functionality into a static
function in rtw_mlme_ext.c and remove the HW_VAR_MLME_DISCONNECT case
from SetHwReg8188EU(). This is part of the ongoing effort to get rid
of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 19 ++++++++++++++++---
 drivers/staging/r8188eu/hal/usb_halinit.c   | 11 -----------
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index c0a1efcd8b28..4a9321e6e327 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6799,13 +6799,26 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 	update_sta_info(padapter, psta);
 }
 
+static void mlme_disconnect(struct adapter *adapter)
+{
+	/* Set RCR to not to receive data frame when NO LINK state */
+	/* reject all data frames */
+	rtw_write16(adapter, REG_RXFLTMAP2, 0x00);
+
+	/* reset TSF */
+	rtw_write8(adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
+
+	/* disable update TSF */
+	rtw_write8(adapter, REG_BCN_CTRL, rtw_read8(adapter, REG_BCN_CTRL) | BIT(4));
+}
+
 void mlmeext_sta_del_event_callback(struct adapter *padapter)
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 
 	if (is_client_associated_to_ap(padapter) || is_IBSS_empty(padapter)) {
-		SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+		mlme_disconnect(padapter);
 		SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
 
 		/* restore to initial setting. */
@@ -7169,7 +7182,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		/* set MSR to nolink -> infra. mode */
 		Set_MSR(padapter, _HW_STATE_STATION_);
 
-		SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+		mlme_disconnect(padapter);
 	}
 
 	rtw_antenna_select_cmd(padapter, pparm->network.PhyInfo.Optimum_antenna, false);
@@ -7265,7 +7278,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if (is_client_associated_to_ap(padapter))
 		issue_deauth_ex(padapter, pnetwork->MacAddress, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms / 100, 100);
 
-	SetHwReg8188EU(padapter, HW_VAR_MLME_DISCONNECT, NULL);
+	mlme_disconnect(padapter);
 	SetHwReg8188EU(padapter, HW_VAR_BSSID, null_addr);
 
 	/* restore to initial setting. */
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 0186f8bf73c7..8e4b84f51a3c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1024,17 +1024,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				ResumeTxBeacon(Adapter);
 		}
 		break;
-	case HW_VAR_MLME_DISCONNECT:
-		/* Set RCR to not to receive data frame when NO LINK state */
-		/* reject all data frames */
-		rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
-
-		/* reset TSF */
-		rtw_write8(Adapter, REG_DUAL_TSF_RST, (BIT(0) | BIT(1)));
-
-		/* disable update TSF */
-		rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) | BIT(4));
-		break;
 	case HW_VAR_MLME_SITESURVEY:
 		if (*((u8 *)val)) { /* under sitesurvey */
 			/* config RCR to receive different BSSID & not to receive data frame */
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 77069cbc1e07..d481cc759e27 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -13,7 +13,6 @@ enum hw_variables {
 	HW_VAR_BSSID,
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
-	HW_VAR_MLME_DISCONNECT,
 	HW_VAR_MLME_SITESURVEY,
 	HW_VAR_MLME_JOIN,
 	HW_VAR_SLOT_TIME,
-- 
2.35.1


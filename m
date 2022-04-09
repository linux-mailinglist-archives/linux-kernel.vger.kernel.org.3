Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30F44FA770
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiDIMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbiDIMIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:08:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817221CFF3
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:06:43 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r13so22078809ejd.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7utODHfqNjFzBMcklrG5MwYZkbXf2tzkjHzM6VBpQUQ=;
        b=IIuqOEvRFRNQehMFjmPbMSnr0s65rsfp8K7MYmppfqDi0djoDchuJ6q1SI3rUOO1HS
         wgLBWTxXmf+K0r0fxjk2S/9WP2T/+fmBAXpCnhycCcbSAe1sZzChJnQmBJpI1Sk1/eGm
         ETFMHFamvZsXsSqEnNwshjIHSHgiviRZiYFT4VrYFj/deQTi2ZEikM471wX88zShCybq
         z8XSSx98DieUUUyAeEMj3n5keFoUA6Ulye6+ideEop4fkVBMyYoSgFV2ey5EZ4xtEjAF
         RLIYXqKGJyf3JX2sN+PfvuDbcuSFftw/3nFzISpw0rn39UwisnlCkMxFyXHbU6FNdNK8
         Mt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7utODHfqNjFzBMcklrG5MwYZkbXf2tzkjHzM6VBpQUQ=;
        b=EPmWRypl7idnSaFedrbnhqajGFWXGuxI0/sncEVtsUndsv2YDsh/I+S4ZbV/I/Zev6
         RRPBiYceJ5G+Rhcv85m7SR2biIwTyDnvVvGDA4sU1IHp2Mj0YuljracJmDBbH88AY3kS
         XP+sGO3VRZyZ+9nc39tqZ5AGu+ubxwagfhqbE71rVD51+cj5+eONOtgO69Es0XK36z8Y
         ajy6XCj4LRj2cO9+Ab16JHf8rAcZOakUu1gWLvX0TBe3LZDSRQz3xN50E1NRXWTAaKJl
         o1u1nfG4svBgOGLTMv5NtbkLwsiBIp8rrr48XpGB0hMZOHBF6I2yqJHeVGrihbQQ+5UW
         vAhA==
X-Gm-Message-State: AOAM530GM7TzUjjVBgJq6y+/f69IXyvIyxNgFFDobqqYPt2DoGl6V5/j
        iRTtI9kmWb7ujspXF+8Xkn8=
X-Google-Smtp-Source: ABdhPJx2ic4EoFvHCuGvDgmzF4mgZW3Os4tY9v1BQi+salNZIEAZqK+wCKlCkQPN3hKtQ/egVkIf+Q==
X-Received: by 2002:a17:906:7316:b0:6d7:16be:b584 with SMTP id di22-20020a170906731600b006d716beb584mr22088865ejc.759.1649506002071;
        Sat, 09 Apr 2022 05:06:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm1102947ejm.189.2022.04.09.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:06:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: r8188eu: remove HW_VAR_MLME_JOIN
Date:   Sat,  9 Apr 2022 14:06:25 +0200
Message-Id: <20220409120627.10633-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409120627.10633-1-straube.linux@gmail.com>
References: <20220409120627.10633-1-straube.linux@gmail.com>
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

Remove the HW_VAR_MLME_JOIN case from SetHwReg8188EU() and move its
functionality to a new static function in rtw_mlme_ext.c. This is part
of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 61 ++++++++++++++++-----
 drivers/staging/r8188eu/hal/usb_halinit.c   | 30 ----------
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index e7fffd56196c..31192b287698 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6110,10 +6110,50 @@ static void rtw_set_bssid(struct adapter *adapter, u8 *bssid)
 		rtw_write8(adapter, REG_BSSID + i, bssid[i]);
 }
 
+static void mlme_join(struct adapter *adapter, int type)
+{
+	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
+	u8 retry_limit = 0x30;
+
+	switch (type) {
+	case 0:
+		/* prepare to join */
+		/* enable to rx data frame, accept all data frame */
+		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
+
+		rtw_write32(adapter, REG_RCR,
+			    rtw_read32(adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
+
+		if (check_fwstate(mlmepriv, WIFI_STATION_STATE)) {
+			retry_limit = 48;
+		} else {
+			/* ad-hoc mode */
+			retry_limit = 0x7;
+		}
+		break;
+	case 1:
+		/* joinbss_event call back when join res < 0 */
+		rtw_write16(adapter, REG_RXFLTMAP2, 0x00);
+		break;
+	case 2:
+		/* sta add event call back */
+		/* enable update TSF */
+		rtw_write8(adapter, REG_BCN_CTRL, rtw_read8(adapter, REG_BCN_CTRL) & (~BIT(4)));
+
+		if (check_fwstate(mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
+			retry_limit = 0x7;
+		break;
+	default:
+		break;
+	}
+
+	rtw_write16(adapter, REG_RL,
+		    retry_limit << RETRY_LIMIT_SHORT_SHIFT | retry_limit << RETRY_LIMIT_LONG_SHIFT);
+}
+
 void start_create_ibss(struct adapter *padapter)
 {
 	unsigned short	caps;
-	u8 join_type;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *pnetwork = (struct wlan_bssid_ex *)(&pmlmeinfo->network);
@@ -6145,8 +6185,7 @@ void start_create_ibss(struct adapter *padapter)
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
 			rtw_set_bssid(padapter, padapter->registrypriv.dev_network.MacAddress);
-			join_type = 0;
-			SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+			mlme_join(padapter, 0);
 
 			report_join_res(padapter, 1);
 			pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
@@ -6719,12 +6758,10 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct wlan_bssid_ex *cur_network = &pmlmeinfo->network;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
-	u8 join_type;
 	u16 media_status;
 
 	if (join_res < 0) {
-		join_type = 1;
-		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+		mlme_join(padapter, 1);
 		rtw_set_bssid(padapter, null_addr);
 
 		/* restore to initial setting. */
@@ -6779,8 +6816,7 @@ void mlmeext_joinbss_event_callback(struct adapter *padapter, int join_res)
 		SetHwReg8188EU(padapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
 
-	join_type = 2;
-	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+	mlme_join(padapter, 2);
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE) {
 		/*  correcting TSF */
@@ -6793,7 +6829,6 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 {
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 join_type;
 
 	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		if (pmlmeinfo->state & WIFI_FW_ASSOC_SUCCESS) {/* adhoc master or sta_count>1 */
@@ -6810,9 +6845,7 @@ void mlmeext_sta_add_event_callback(struct adapter *padapter, struct sta_info *p
 			}
 			pmlmeinfo->state |= WIFI_FW_ASSOC_SUCCESS;
 		}
-
-		join_type = 2;
-		SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+		mlme_join(padapter, 2);
 	}
 
 	pmlmeinfo->FW_sta_info[psta->mac_id].psta = psta;
@@ -7183,7 +7216,6 @@ u8 createbss_hdl(struct adapter *padapter, u8 *pbuf)
 
 u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 {
-	u8 join_type;
 	struct ndis_802_11_var_ie *pIE;
 	struct registry_priv	*pregpriv = &padapter->registrypriv;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
@@ -7281,8 +7313,7 @@ u8 join_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	/* config the initial gain under linking, need to write the BB registers */
 
 	rtw_set_bssid(padapter, pmlmeinfo->network.MacAddress);
-	join_type = 0;
-	SetHwReg8188EU(padapter, HW_VAR_MLME_JOIN, (u8 *)(&join_type));
+	mlme_join(padapter, 0);
 
 	/* cancel link timer */
 	_cancel_timer_ex(&pmlmeext->link_timer);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index d8aea49afe8b..e50d47bf1f0f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1036,36 +1036,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_BCN);
 		}
 		break;
-	case HW_VAR_MLME_JOIN:
-		{
-			u8 RetryLimit = 0x30;
-			u8 type = *((u8 *)val);
-			struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
-
-			if (type == 0) { /*  prepare to join */
-				/* enable to rx data frame.Accept all data frame */
-				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
-
-				rtw_write32(Adapter, REG_RCR, rtw_read32(Adapter, REG_RCR) | RCR_CBSSID_DATA | RCR_CBSSID_BCN);
-
-				if (check_fwstate(pmlmepriv, WIFI_STATION_STATE))
-					RetryLimit = 48;
-				else /*  Ad-hoc Mode */
-					RetryLimit = 0x7;
-			} else if (type == 1) {
-				/* joinbss_event call back when join res < 0 */
-				rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
-			} else if (type == 2) {
-				/* sta add event call back */
-				/* enable update TSF */
-				rtw_write8(Adapter, REG_BCN_CTRL, rtw_read8(Adapter, REG_BCN_CTRL) & (~BIT(4)));
-
-				if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE))
-					RetryLimit = 0x7;
-			}
-			rtw_write16(Adapter, REG_RL, RetryLimit << RETRY_LIMIT_SHORT_SHIFT | RetryLimit << RETRY_LIMIT_LONG_SHIFT);
-		}
-		break;
 	case HW_VAR_SLOT_TIME:
 		{
 			u8 u1bAIFS, aSifsTime;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 342587e05468..42d5aafbb32a 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -13,7 +13,6 @@ enum hw_variables {
 	HW_VAR_BASIC_RATE,
 	HW_VAR_CORRECT_TSF,
 	HW_VAR_MLME_SITESURVEY,
-	HW_VAR_MLME_JOIN,
 	HW_VAR_SLOT_TIME,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
-- 
2.35.1


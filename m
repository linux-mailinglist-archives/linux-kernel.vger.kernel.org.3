Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82094570959
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiGKRof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKRoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:44:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55592A721
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:44:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t3so6936243edd.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9Gy6dRddJ8pXVDfsH+rnsSHJwIA7a3KAfHfb6MUnYE=;
        b=BUyl3DbV4BjVWRhOtqddgbOttXeNyLELiOrB9/4XHyg1zXDbLvpEBll/lRgNzj7aYX
         t9K6hC5g65h0b8FhCKWYCm1eeHIUpuOmIOZOo0gUG+youy6sRAnaS4aq3iSqe4QrA+DN
         i+3YI8S9qvYHYUtsJV24Pt12O4htCIwhMIZeOAiPBeabfwf/GeNtn7tazEb8dU5KPnRO
         Daee9fZDBjx09rOIkrEmakb6j1PyRHw8SCWDXLZDM/6WyLg/dPfzKdrwIzQ7epuqnVz5
         ckzoWKSL8Y/JZ4bu0sagIdRYIoj8ayRXufs4dF7I1dbu2/i/uOojxQeHbRo9lXCwOBa/
         1M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9Gy6dRddJ8pXVDfsH+rnsSHJwIA7a3KAfHfb6MUnYE=;
        b=uKPxWIjSp9zCA1OVfhoD4JoWdOJAwscx6WU6fNd1ttToPcwK5kSkLHBODOwTnr8SlE
         jffuViv6TcUkLaWa01fHBP8B/jpX1TQbKa7iCarAyycOh7wfWXF3yCsKvCeOW+IDB6sV
         qtd6HRs2K/LIpeqzAKH0zwlcgFyRcpLmrSOMJMhWt8o0cgjoJ/WlABQtwhCk0GRMI6t4
         RP51Z76EO3JDz37OHdAPjtQhBMIMLqmVBimBgkWhwl37qqNsgAxuCLCB2TPgNVM8RprT
         0ca2UYf1kDSu2pmfiDLFNUl7DyB15bksQbcRVDCTI5Hy12SNjZ1ePIWk9RtkftYwhJ5p
         gB7Q==
X-Gm-Message-State: AJIora8f6IBD0mAW9Cl2P5cZ2BATYKVWr4pKhUxP5JtAWLHiqNxOEgEH
        g89ueoU7ihN3+pONYmbp4to=
X-Google-Smtp-Source: AGRyM1tKwJrReXkTTLZZGtt/qIhZn9mR6Nt8Mv8utXBoJZXmE0lO1C30xXH8nU54ys7g1wy2hNtTiQ==
X-Received: by 2002:aa7:c784:0:b0:43a:caa8:75b9 with SMTP id n4-20020aa7c784000000b0043acaa875b9mr12493833eds.311.1657561467443;
        Mon, 11 Jul 2022 10:44:27 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb5e.dynamic.kabel-deutschland.de. [95.90.187.94])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906329a00b0072b4da1ed9asm1715675ejw.225.2022.07.11.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:44:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove HW_VAR_MLME_SITESURVEY from SetHwReg8188EU()
Date:   Mon, 11 Jul 2022 19:44:17 +0200
Message-Id: <20220711174417.10721-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Remove the HW_VAR_MLME_SITESURVEY case from SetHwReg8188EU() and move
the functionality to two new functions in rtw_mlme_ext.c. This is part
of the ongoing effort to get rid of SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 70 +++++++++++++++++--
 drivers/staging/r8188eu/core/rtw_p2p.c        |  9 +--
 drivers/staging/r8188eu/hal/usb_halinit.c     | 53 --------------
 drivers/staging/r8188eu/include/hal_intf.h    |  1 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +
 5 files changed, 70 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index eecb00e41d6a..771910763fec 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5695,9 +5695,70 @@ static void rtw_set_initial_gain(struct adapter *adapter, u8 gain)
 	}
 }
 
+void rtw_mlme_under_site_survey(struct adapter *adapter)
+{
+	/* config RCR to receive different BSSID & not to receive data frame */
+
+	int res;
+	u8 reg;
+	u32 v;
+
+	res = rtw_read32(adapter, REG_RCR, &v);
+	if (res)
+		return;
+
+	v &= ~(RCR_CBSSID_BCN);
+	rtw_write32(adapter, REG_RCR, v);
+	/* reject all data frame */
+	rtw_write16(adapter, REG_RXFLTMAP2, 0x00);
+
+	/* disable update TSF */
+	res = rtw_read8(adapter, REG_BCN_CTRL, &reg);
+	if (res)
+		return;
+
+	rtw_write8(adapter, REG_BCN_CTRL, reg | BIT(4));
+}
+
+void rtw_mlme_site_survey_done(struct adapter *adapter)
+{
+	struct mlme_ext_priv *pmlmeext = &adapter->mlmeextpriv;
+	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
+	u32 reg32;
+	int res;
+	u8 reg;
+
+	if ((is_client_associated_to_ap(adapter)) ||
+	    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
+		/* enable to rx data frame */
+		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
+
+		/* enable update TSF */
+		res = rtw_read8(adapter, REG_BCN_CTRL, &reg);
+		if (res)
+			return;
+
+		rtw_write8(adapter, REG_BCN_CTRL, reg & (~BIT(4)));
+	} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
+		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
+		/* enable update TSF */
+		res = rtw_read8(adapter, REG_BCN_CTRL, &reg);
+		if (res)
+			return;
+
+		rtw_write8(adapter, REG_BCN_CTRL, reg & (~BIT(4)));
+	}
+
+	res = rtw_read32(adapter, REG_RCR, &reg32);
+	if (res)
+		return;
+
+	rtw_write32(adapter, REG_RCR, reg32 | RCR_CBSSID_BCN);
+}
+
 void site_survey(struct adapter *padapter)
 {
-	unsigned char		survey_channel = 0, val8;
+	unsigned char survey_channel = 0;
 	enum rt_scan_type ScanType = SCAN_PASSIVE;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -5821,8 +5882,7 @@ void site_survey(struct adapter *padapter)
 			if (is_client_associated_to_ap(padapter))
 				issue_nulldata(padapter, NULL, 0, 3, 500);
 
-			val8 = 0; /* survey done */
-			SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+			rtw_mlme_site_survey_done(padapter);
 
 			report_surveydone_event(padapter);
 
@@ -7343,7 +7403,6 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct sitesurvey_parm	*pparm = (struct sitesurvey_parm *)pbuf;
 	u8 bdelayscan = false;
-	u8 val8;
 	u32	i;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -7400,8 +7459,7 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 		/* set MSR to no link state */
 		Set_MSR(padapter, _HW_STATE_NOLINK_);
 
-		val8 = 1; /* under site survey */
-		SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+		rtw_mlme_under_site_survey(padapter);
 
 		pmlmeext->sitesurvey_res.state = SCAN_PROCESS;
 	}
diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index beffe5b16f1e..c306aafa183b 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -1450,10 +1450,9 @@ static void restore_p2p_state_handler(struct adapter *padapter)
 static void pre_tx_invitereq_handler(struct adapter *padapter)
 {
 	struct wifidirect_info  *pwdinfo = &padapter->wdinfo;
-	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->invitereq_info.peer_ch, HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	rtw_mlme_under_site_survey(padapter);
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -1462,10 +1461,9 @@ static void pre_tx_invitereq_handler(struct adapter *padapter)
 static void pre_tx_provdisc_handler(struct adapter *padapter)
 {
 	struct wifidirect_info  *pwdinfo = &padapter->wdinfo;
-	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->tx_prov_disc_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	rtw_mlme_under_site_survey(padapter);
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
@@ -1474,10 +1472,9 @@ static void pre_tx_provdisc_handler(struct adapter *padapter)
 static void pre_tx_negoreq_handler(struct adapter *padapter)
 {
 	struct wifidirect_info  *pwdinfo = &padapter->wdinfo;
-	u8	val8 = 1;
 
 	set_channel_bwmode(padapter, pwdinfo->nego_req_info.peer_channel_num[0], HAL_PRIME_CHNL_OFFSET_DONT_CARE, HT_CHANNEL_WIDTH_20);
-	SetHwReg8188EU(padapter, HW_VAR_MLME_SITESURVEY, (u8 *)(&val8));
+	rtw_mlme_under_site_survey(padapter);
 	issue_probereq_p2p(padapter, NULL);
 	_set_timer(&pwdinfo->pre_tx_scan_timer, P2P_TX_PRESCAN_TIMEOUT);
 
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 6b0337c09915..68d012a442a8 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1104,59 +1104,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 				ResumeTxBeacon(Adapter);
 		}
 		break;
-	case HW_VAR_MLME_SITESURVEY:
-		if (*((u8 *)val)) { /* under sitesurvey */
-			/* config RCR to receive different BSSID & not to receive data frame */
-			u32 v;
-
-			res = rtw_read32(Adapter, REG_RCR, &v);
-			if (res)
-				return;
-
-			v &= ~(RCR_CBSSID_BCN);
-			rtw_write32(Adapter, REG_RCR, v);
-			/* reject all data frame */
-			rtw_write16(Adapter, REG_RXFLTMAP2, 0x00);
-
-			/* disable update TSF */
-			res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
-			if (res)
-				return;
-
-			rtw_write8(Adapter, REG_BCN_CTRL, reg | BIT(4));
-		} else { /* sitesurvey done */
-			struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-			struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-			u32 reg32;
-
-			if ((is_client_associated_to_ap(Adapter)) ||
-			    ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE)) {
-				/* enable to rx data frame */
-				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
-
-				/* enable update TSF */
-				res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
-				if (res)
-					return;
-
-				rtw_write8(Adapter, REG_BCN_CTRL, reg & (~BIT(4)));
-			} else if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-				rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
-				/* enable update TSF */
-				res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
-				if (res)
-					return;
-
-				rtw_write8(Adapter, REG_BCN_CTRL, reg & (~BIT(4)));
-			}
-
-			res = rtw_read32(Adapter, REG_RCR, &reg32);
-			if (res)
-				return;
-
-			rtw_write32(Adapter, REG_RCR, reg32 | RCR_CBSSID_BCN);
-		}
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 24bbba2cb7cf..819d0dc6e6dc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -11,7 +11,6 @@
 enum hw_variables {
 	HW_VAR_SET_OPMODE,
 	HW_VAR_CORRECT_TSF,
-	HW_VAR_MLME_SITESURVEY,
 };
 
 typedef s32 (*c2h_id_filter)(u8 id);
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 3cc475aa912a..c630700ea657 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -424,6 +424,9 @@ void invalidate_cam_all(struct adapter *padapter);
 int allocate_fw_sta_entry(struct adapter *padapter);
 void flush_all_cam_entry(struct adapter *padapter);
 
+void rtw_mlme_under_site_survey(struct adapter *adapter);
+void rtw_mlme_site_survey_done(struct adapter *adapter);
+
 void site_survey(struct adapter *padapter);
 u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame,
 		    struct wlan_bssid_ex *bssid);
-- 
2.36.1


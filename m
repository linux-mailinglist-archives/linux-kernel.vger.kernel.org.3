Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F673575B90
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiGOG3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGOG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:29:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1F51400C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l23so7275266ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpAPTfgn7x2hsoU7pkb7QkeWbRt4wtXC22iLXqSjDL4=;
        b=c5NkWkSZZOQBe02NEl3AvDe0K9J9M82NsylzabjkTi+Ew2NM+LqWLPYuOcto24LOB5
         wqOz2ZMolxu+Z3Rz/e6l/RjEoihpnHaKF+5gLK7qevxNMqujaJdEphbLx83tkxF70JdN
         6C0lHSJthiiMhswWTYMeKlKrRIQ83NpWgxS0yqDPIG+tusggGpm7zdcmdefVj0j+Kgq4
         kzjvb2yXVi02bgVzoyxTDTGMWhcqHHiFaWmdsj56359P+lKj4tBXA3utliCSoh4M+6SN
         c23AUEYlHGiPTZHFwwYWNU5oT7Rv0/KHjaGemUGLqZIJ4vXYc4Y9JG+LwJzgAFa3Pk50
         Xcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZpAPTfgn7x2hsoU7pkb7QkeWbRt4wtXC22iLXqSjDL4=;
        b=xoMNfCRV3ZS+L9oBLJ+++h0UAYT2j1NkCcD0SLvdWYDAgRlObzqDL39oByQT+RNYeq
         53dJ27SHPyYA3j1Wkip+zX9Bbown4dUrNxh9S05jjukH2xu5Xj3UACN0npq80GNvJVZS
         RqUoelrLqgqo6UOXqWtv0+OknpYoM2G3tpmtHXUBRvKlEMAQqmxLKKiMwTdDdJ/Pybx8
         o8YQkESNXEGKVGy92cJcMA8FKWBAEMhew69j6fMCb/QSMjKTE3ZuubSDKO+rVbhtWYG2
         JCyi2XAcdirCC5KNZdeAp082KakS3yP9bksCDXAKUeai0an1lz42DJr/7MvobBrydNpb
         ooTQ==
X-Gm-Message-State: AJIora/pjzf7vdVfhvZmceFRWR+ZNevmKoG6aMQuT1vofgq1lLB9zaKn
        L6AzaTeWYcsvGIqNLzHNVUs=
X-Google-Smtp-Source: AGRyM1swEBzt38NEiNNoen9segqLBmiaLfupfNuGywhrotsTDuoBbyCZBzpnkWSi4tUodEBJ74dnew==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr3119563ejc.296.1657866556076;
        Thu, 14 Jul 2022 23:29:16 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007262a5e2204sm1614515ejc.153.2022.07.14.23.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 23:29:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove HW_VAR_SET_OPMODE from SetHwReg8188EU()
Date:   Fri, 15 Jul 2022 08:29:04 +0200
Message-Id: <20220715062908.8547-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715062908.8547-1-straube.linux@gmail.com>
References: <20220715062908.8547-1-straube.linux@gmail.com>
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

Remove the HW_VAR_SET_OPMODE case from SetHwReg8188EU() and move the
functions that are called by that case to rtw_mlme_ext.c. This is part
of the ongoing effort to get rid of SetHwReg8188EU().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 103 +++++++++++++++-
 drivers/staging/r8188eu/hal/usb_halinit.c     | 111 +-----------------
 drivers/staging/r8188eu/include/hal_intf.h    |   1 -
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   2 +
 4 files changed, 107 insertions(+), 110 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 771910763fec..0edcf84db16d 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5674,6 +5674,107 @@ void clear_beacon_valid_bit(struct adapter *adapter)
 	rtw_write8(adapter, REG_TDECTRL + 2, reg | BIT(0));
 }
 
+void rtw_resume_tx_beacon(struct adapter *adapt)
+{
+	struct hal_data_8188e *haldata = &adapt->haldata;
+
+	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  which should be read from register to a global variable. */
+
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) | BIT(6));
+	haldata->RegFwHwTxQCtrl |= BIT(6);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0xff);
+	haldata->RegReg542 |= BIT(0);
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
+}
+
+void rtw_stop_tx_beacon(struct adapter *adapt)
+{
+	struct hal_data_8188e *haldata = &adapt->haldata;
+
+	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
+	/*  which should be read from register to a global variable. */
+
+	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
+	haldata->RegFwHwTxQCtrl &= (~BIT(6));
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0x64);
+	haldata->RegReg542 &= ~(BIT(0));
+	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
+
+	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
+}
+
+static void rtw_set_opmode(struct adapter *adapter, u8 mode)
+{
+	u8 val8;
+	int res;
+
+	/*  disable Port0 TSF update */
+	res = rtw_read8(adapter, REG_BCN_CTRL, &val8);
+	if (res)
+		return;
+
+	rtw_write8(adapter, REG_BCN_CTRL, val8 | BIT(4));
+
+	/*  set net_type */
+	res = rtw_read8(adapter, MSR, &val8);
+	if (res)
+		return;
+
+	val8 &= 0x0c;
+	val8 |= mode;
+	rtw_write8(adapter, MSR, val8);
+
+	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
+		rtw_stop_tx_beacon(adapter);
+
+		rtw_write8(adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
+	} else if (mode == _HW_STATE_ADHOC_) {
+		rtw_resume_tx_beacon(adapter);
+		rtw_write8(adapter, REG_BCN_CTRL, 0x1a);
+	} else if (mode == _HW_STATE_AP_) {
+		rtw_resume_tx_beacon(adapter);
+
+		rtw_write8(adapter, REG_BCN_CTRL, 0x12);
+
+		/* Set RCR */
+		rtw_write32(adapter, REG_RCR, 0x7000208e);/* CBSSID_DATA must set to 0,reject ICV_ERR packet */
+		/* enable to rx data frame */
+		rtw_write16(adapter, REG_RXFLTMAP2, 0xFFFF);
+		/* enable to rx ps-poll */
+		rtw_write16(adapter, REG_RXFLTMAP1, 0x0400);
+
+		/* Beacon Control related register for first time */
+		rtw_write8(adapter, REG_BCNDMATIM, 0x02); /*  2ms */
+
+		rtw_write8(adapter, REG_ATIMWND, 0x0a); /*  10ms */
+		rtw_write16(adapter, REG_BCNTCFG, 0x00);
+		rtw_write16(adapter, REG_TBTT_PROHIBIT, 0xff04);
+		rtw_write16(adapter, REG_TSFTR_SYN_OFFSET, 0x7fff);/*  +32767 (~32ms) */
+
+		/* reset TSF */
+		rtw_write8(adapter, REG_DUAL_TSF_RST, BIT(0));
+
+		/* BIT(3) - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
+		res = rtw_read8(adapter, REG_MBID_NUM, &val8);
+		if (res)
+			return;
+
+		rtw_write8(adapter, REG_MBID_NUM, val8 | BIT(3) | BIT(4));
+
+		/* enable BCN0 Function for if1 */
+		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
+		rtw_write8(adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
+
+		/* dis BCN1 ATIM  WND if if2 is station */
+		res = rtw_read8(adapter, REG_BCN_CTRL_1, &val8);
+		if (res)
+			return;
+
+		rtw_write8(adapter, REG_BCN_CTRL_1, val8 | BIT(0));
+	}
+}
+
 /****************************************************************************
 
 Following are some utitity fuctions for WiFi MLME
@@ -7142,7 +7243,7 @@ u8 setopmode_hdl(struct adapter *padapter, u8 *pbuf)
 		type = _HW_STATE_NOLINK_;
 	}
 
-	SetHwReg8188EU(padapter, HW_VAR_SET_OPMODE, (u8 *)(&type));
+	rtw_set_opmode(padapter, type);
 
 	return H2C_SUCCESS;
 }
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 421fe7c40390..b8fd73ac8f7c 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -963,117 +963,12 @@ void ReadAdapterInfo8188EU(struct adapter *Adapter)
 	kfree(efuse_buf);
 }
 
-static void ResumeTxBeacon(struct adapter *adapt)
-{
-	struct hal_data_8188e *haldata = &adapt->haldata;
-
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
-	/*  which should be read from register to a global variable. */
-
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) | BIT(6));
-	haldata->RegFwHwTxQCtrl |= BIT(6);
-	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0xff);
-	haldata->RegReg542 |= BIT(0);
-	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
-}
-
-static void StopTxBeacon(struct adapter *adapt)
-{
-	struct hal_data_8188e *haldata = &adapt->haldata;
-
-	/*  2010.03.01. Marked by tynli. No need to call workitem beacause we record the value */
-	/*  which should be read from register to a global variable. */
-
-	rtw_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl) & (~BIT(6)));
-	haldata->RegFwHwTxQCtrl &= (~BIT(6));
-	rtw_write8(adapt, REG_TBTT_PROHIBIT + 1, 0x64);
-	haldata->RegReg542 &= ~(BIT(0));
-	rtw_write8(adapt, REG_TBTT_PROHIBIT + 2, haldata->RegReg542);
-
-	 /* todo: CheckFwRsvdPageContent(Adapter);  2010.06.23. Added by tynli. */
-}
-
-static void hw_var_set_opmode(struct adapter *Adapter, u8 *val)
-{
-	u8 val8;
-	u8 mode = *((u8 *)val);
-	int res;
-
-	/*  disable Port0 TSF update */
-	res = rtw_read8(Adapter, REG_BCN_CTRL, &val8);
-	if (res)
-		return;
-
-	rtw_write8(Adapter, REG_BCN_CTRL, val8 | BIT(4));
-
-	/*  set net_type */
-	res = rtw_read8(Adapter, MSR, &val8);
-	if (res)
-		return;
-
-	val8 &= 0x0c;
-	val8 |= mode;
-	rtw_write8(Adapter, MSR, val8);
-
-	if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
-		StopTxBeacon(Adapter);
-
-		rtw_write8(Adapter, REG_BCN_CTRL, 0x19);/* disable atim wnd */
-	} else if (mode == _HW_STATE_ADHOC_) {
-		ResumeTxBeacon(Adapter);
-		rtw_write8(Adapter, REG_BCN_CTRL, 0x1a);
-	} else if (mode == _HW_STATE_AP_) {
-		ResumeTxBeacon(Adapter);
-
-		rtw_write8(Adapter, REG_BCN_CTRL, 0x12);
-
-		/* Set RCR */
-		rtw_write32(Adapter, REG_RCR, 0x7000208e);/* CBSSID_DATA must set to 0,reject ICV_ERR packet */
-		/* enable to rx data frame */
-		rtw_write16(Adapter, REG_RXFLTMAP2, 0xFFFF);
-		/* enable to rx ps-poll */
-		rtw_write16(Adapter, REG_RXFLTMAP1, 0x0400);
-
-		/* Beacon Control related register for first time */
-		rtw_write8(Adapter, REG_BCNDMATIM, 0x02); /*  2ms */
-
-		rtw_write8(Adapter, REG_ATIMWND, 0x0a); /*  10ms */
-		rtw_write16(Adapter, REG_BCNTCFG, 0x00);
-		rtw_write16(Adapter, REG_TBTT_PROHIBIT, 0xff04);
-		rtw_write16(Adapter, REG_TSFTR_SYN_OFFSET, 0x7fff);/*  +32767 (~32ms) */
-
-		/* reset TSF */
-		rtw_write8(Adapter, REG_DUAL_TSF_RST, BIT(0));
-
-		/* BIT(3) - If set 0, hw will clr bcnq when tx becon ok/fail or port 0 */
-		res = rtw_read8(Adapter, REG_MBID_NUM, &val8);
-		if (res)
-			return;
-
-		rtw_write8(Adapter, REG_MBID_NUM, val8 | BIT(3) | BIT(4));
-
-		/* enable BCN0 Function for if1 */
-		/* don't enable update TSF0 for if1 (due to TSF update when beacon/probe rsp are received) */
-		rtw_write8(Adapter, REG_BCN_CTRL, (DIS_TSF_UDT0_NORMAL_CHIP | EN_BCN_FUNCTION | BIT(1)));
-
-		/* dis BCN1 ATIM  WND if if2 is station */
-		res = rtw_read8(Adapter, REG_BCN_CTRL_1, &val8);
-		if (res)
-			return;
-
-		rtw_write8(Adapter, REG_BCN_CTRL_1, val8 | BIT(0));
-	}
-}
-
 void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 {
 	u8 reg;
 	int res;
 
 	switch (variable) {
-	case HW_VAR_SET_OPMODE:
-		hw_var_set_opmode(Adapter, val);
-		break;
 	case HW_VAR_CORRECT_TSF:
 		{
 			u64	tsf;
@@ -1084,7 +979,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 							  pmlmeinfo->bcn_interval * 1024) - 1024; /* us */
 
 			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
-				StopTxBeacon(Adapter);
+				rtw_stop_tx_beacon(Adapter);
 
 			/* disable related TSF function */
 			res = rtw_read8(Adapter, REG_BCN_CTRL, &reg);
@@ -1104,7 +999,7 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, REG_BCN_CTRL, reg | BIT(3));
 
 			if (((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE))
-				ResumeTxBeacon(Adapter);
+				rtw_resume_tx_beacon(Adapter);
 		}
 		break;
 	default:
@@ -1221,7 +1116,7 @@ void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt)
 
 	_BeaconFunctionEnable(adapt, true, true);
 
-	ResumeTxBeacon(adapt);
+	rtw_resume_tx_beacon(adapt);
 
 	res = rtw_read8(adapt, bcn_ctrl_reg, &reg);
 	if (res)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 819d0dc6e6dc..e1dfd621a5cb 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -9,7 +9,6 @@
 #include "Hal8188EPhyCfg.h"
 
 enum hw_variables {
-	HW_VAR_SET_OPMODE,
 	HW_VAR_CORRECT_TSF,
 };
 
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index c630700ea657..28416d1bd15c 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -532,6 +532,8 @@ unsigned int send_delba(struct adapter *padapter, u8 initiator, u8 *addr);
 unsigned int send_beacon(struct adapter *padapter);
 bool get_beacon_valid_bit(struct adapter *adapter);
 void clear_beacon_valid_bit(struct adapter *adapter);
+void rtw_resume_tx_beacon(struct adapter *adapt);
+void rtw_stop_tx_beacon(struct adapter *adapt);
 
 void start_clnt_assoc(struct adapter *padapter);
 void start_clnt_auth(struct adapter *padapter);
-- 
2.37.0


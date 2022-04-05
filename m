Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00C4F22E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 08:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDEGKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiDEGKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 02:10:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96C13FB0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 23:08:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p23so6082535edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fu7aqeJdvRBKy6QUBPM9ZuIG13sfzEk0Yx9f/9oe+ik=;
        b=PNr98mEAV+ZJz2/y6HuykyZiTsQITMPhjSEYPEzPAAKqBPxyD+4UJbZ3iskl5B7eTo
         jEZKTd+lPt1q8jruNDR0atk1Nu9BGQEIdUB/fMRFLRM6bHNjhK9RnQhLdKHlGYYXyPPc
         rrDMD2OJ0Y5MdOePeCdwKRsasYHA6nRBc0HbcRJDfCDnRGnORUxtJ1BEqsk9e/pd6jjy
         nrcWvcVml6QOu2dFngziQr+teOyjSkJOD4UvhIszEkMQsQVO+4qgaIS+EE0LVsat/l+e
         GFIz9yoqQd7NfVM1068hhzA43PHPyM6Ix8BHp/LSOfTG4BlIDQS9iG5sO2qWeH5TO32K
         eyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fu7aqeJdvRBKy6QUBPM9ZuIG13sfzEk0Yx9f/9oe+ik=;
        b=1yL7Ml/asa7hylH9N7/GqyOSzjvA+df8UI6ugjvkpQaWiyU0GPAGew/2sf8ogHXPvP
         RSXqLF07NR+DYDbl0+DRCs/a8vSMcaZ7Gto0yZg5HB7Ut/RFB3aRtqUkcAxu7GPw5zIb
         nhKpEZS18t/dd/hwwhu3Zr5ZDZ2/sI32+w6HNBsWmEg1LrDHq+CpuYjHzC8Y+gEvizG8
         7WpTuWKkOpA8P/tbAv9q90bVUxxoC1PQbdogwxLDbqk2PUzlpkuO4qytlBDsakv1jL8Z
         aCO/EGCce04oKx7bNh7DU+24L33AmRxaZ0Ry9UtpYf/GcC7N/CrdYf8NitrMUtrEs2H8
         QPoQ==
X-Gm-Message-State: AOAM5336WxUKfzNGQV+A6FbUPu2y5cK2OFAjU4eDJyYPWPpRdNnyWUEV
        GK8vpWBD5QHTwEjTt8IlP+g=
X-Google-Smtp-Source: ABdhPJyBAD2xvlb10t5lZcC/yT22TrwyDfWlctDkP4Z4vzZDaorZdOp8sBKVZ8NsTld2MziWLMrXvA==
X-Received: by 2002:a05:6402:d0e:b0:418:f011:275e with SMTP id eb14-20020a0564020d0e00b00418f011275emr1813470edb.323.1649138900727;
        Mon, 04 Apr 2022 23:08:20 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id h5-20020a170906718500b006e7edcda732sm2484538ejk.125.2022.04.04.23.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:08:20 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: remove unncessary ternary operator
Date:   Tue,  5 Apr 2022 08:08:12 +0200
Message-Id: <20220405060813.8448-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405060813.8448-1-straube.linux@gmail.com>
References: <20220405060813.8448-1-straube.linux@gmail.com>
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

There are some uses of ternary operator where it explicitly sets
true or false but the condition already evaluates to true or false.
In this cases the ternary operator is redundant and can be removed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c         | 2 +-
 drivers/staging/r8188eu/core/rtw_pwrctrl.c     | 4 ++--
 drivers/staging/r8188eu/core/rtw_sta_mgt.c     | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/r8188eu/hal/hal_com.c          | 2 +-
 drivers/staging/r8188eu/hal/odm_HWConfig.c     | 4 ++--
 drivers/staging/r8188eu/include/HalVerDef.h    | 4 ++--
 drivers/staging/r8188eu/os_dep/osdep_service.c | 2 +-
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 1e728a03e0ac..80305d128ccd 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -951,7 +951,7 @@ u32 process_p2p_devdisc_req(struct wifidirect_info *pwdinfo, u8 *pframe, uint le
 	/* issue Device Discoverability Response */
 	issue_p2p_devdisc_resp(pwdinfo, GetAddr2Ptr(pframe), status, dialogToken);
 
-	return (status == P2P_STATUS_SUCCESS) ? true : false;
+	return status == P2P_STATUS_SUCCESS;
 }
 
 u32 process_p2p_devdisc_resp(struct wifidirect_info *pwdinfo, u8 *pframe, uint len)
diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 5d468e8b4920..4537b51ff8bc 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -348,7 +348,7 @@ void rtw_init_pwrctrl_priv(struct adapter *padapter)
 
 	pwrctrlpriv->LpsIdleCount = 0;
 	pwrctrlpriv->power_mgnt = padapter->registrypriv.power_mgnt;/*  PS_MODE_MIN; */
-	pwrctrlpriv->bLeisurePs = (PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt) ? true : false;
+	pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
 
 	pwrctrlpriv->bFwCurrentInPSMode = false;
 
@@ -424,7 +424,7 @@ int rtw_pm_set_lps(struct adapter *padapter, u8 mode)
 			else
 				pwrctrlpriv->LpsIdleCount = 2;
 			pwrctrlpriv->power_mgnt = mode;
-			pwrctrlpriv->bLeisurePs = (PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt) ? true : false;
+			pwrctrlpriv->bLeisurePs = PS_MODE_ACTIVE != pwrctrlpriv->power_mgnt;
 		}
 	} else {
 		ret = -EINVAL;
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 91ff82f24f1f..357f98e22d8a 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -470,9 +470,9 @@ u8 rtw_access_ctrl(struct adapter *padapter, u8 *mac_addr)
 	spin_unlock_bh(&pacl_node_q->lock);
 
 	if (pacl_list->mode == 1)/* accept unless in deny list */
-		res = (match) ? false : true;
+		res = !match;
 	else if (pacl_list->mode == 2)/* deny unless in accept list */
-		res = (match) ? true : false;
+		res = match;
 	else
 		res = true;
 
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index b526715a70bc..84ced6a86df9 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1482,7 +1482,7 @@ void process_addba_req(struct adapter *padapter, u8 *paddba_req, u8 *addr)
 		tid = (param >> 2) & 0x0f;
 		preorder_ctrl = &psta->recvreorder_ctrl[tid];
 		preorder_ctrl->indicate_seq = 0xffff;
-		preorder_ctrl->enable = (pmlmeinfo->bAcceptAddbaReq) ? true : false;
+		preorder_ctrl->enable = pmlmeinfo->bAcceptAddbaReq;
 	}
 }
 
diff --git a/drivers/staging/r8188eu/hal/hal_com.c b/drivers/staging/r8188eu/hal/hal_com.c
index 06f2a9083056..7649f9919f67 100644
--- a/drivers/staging/r8188eu/hal/hal_com.c
+++ b/drivers/staging/r8188eu/hal/hal_com.c
@@ -267,7 +267,7 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 bool Hal_MappingOutPipe(struct adapter *adapter, u8 numoutpipe)
 {
 	struct registry_priv *pregistrypriv = &adapter->registrypriv;
-	bool  wifi_cfg = (pregistrypriv->wifi_spec) ? true : false;
+	bool wifi_cfg = pregistrypriv->wifi_spec;
 	bool result = true;
 
 	switch (numoutpipe) {
diff --git a/drivers/staging/r8188eu/hal/odm_HWConfig.c b/drivers/staging/r8188eu/hal/odm_HWConfig.c
index 1183e4a522c0..54cc3d7789cd 100644
--- a/drivers/staging/r8188eu/hal/odm_HWConfig.c
+++ b/drivers/staging/r8188eu/hal/odm_HWConfig.c
@@ -65,7 +65,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 
 	struct phy_status_rpt *pPhyStaRpt = (struct phy_status_rpt *)pPhyStatus;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	isCCKrate = pPktinfo->Rate >= DESC92C_RATE1M && pPktinfo->Rate <= DESC92C_RATE11M;
 
 	if (isCCKrate) {
 		u8 cck_agc_rpt;
@@ -234,7 +234,7 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	if ((!pPktinfo->bPacketMatchBSSID))
 		return;
 
-	isCCKrate = ((pPktinfo->Rate >= DESC92C_RATE1M) && (pPktinfo->Rate <= DESC92C_RATE11M)) ? true : false;
+	isCCKrate = pPktinfo->Rate >= DESC92C_RATE1M && pPktinfo->Rate <= DESC92C_RATE11M;
 
 	/* Smart Antenna Debug Message------------------  */
 	if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 2bc18eabb55d..56dadadb1a0f 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -34,10 +34,10 @@ struct HAL_VERSION {
 
 /* HAL_CHIP_TYPE_E */
 #define IS_NORMAL_CHIP(version)				\
-	((GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP) ? true : false)
+	(GET_CVID_CHIP_TYPE(version) == NORMAL_CHIP)
 
 /* HAL_VENDOR_E */
 #define IS_CHIP_VENDOR_TSMC(version)			\
-	((GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC) ? true : false)
+	(GET_CVID_MANUFACTUER(version) == CHIP_VENDOR_TSMC)
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index fc10eefe04a9..6824a6ab2e36 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -211,7 +211,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_empty(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read) ? true : false;
+	return cbuf->write == cbuf->read;
 }
 
 /**
-- 
2.35.1


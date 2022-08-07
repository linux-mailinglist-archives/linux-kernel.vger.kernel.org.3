Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9758BC4E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiHGSQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiHGSPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7285C6545
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m4so12905612ejr.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4cI0C+edHqjQmmO/rArIoU+PLyf7AYRNI0KFouoRxco=;
        b=IlfguZNw5DsBKd9GOuXRcdMC7d9SV4iqU8oonFayH7IONPciQZHwTvQ6U20Srh6qrJ
         CBUVrWEI7CKWO2bUYVI9BFWA3sNVHNPuFXUOJf3NHFTIr9V14yO431vmfzpXb9rPYBiz
         Gue4DSMa+YgGZCdFHPy7TJscjag8Kzx0F4F+L0SIIjSTb2vRkqR6IJCPy9e4xeTNYpwA
         cAWXEZolY09u+DzHn9/xcki2HXsZ1zV8tZPLMrL3WjehP+RIxiFo5kigyLGxzqrXihVT
         z3WzUg1j4fe7ZPh9Vx2XZZE1pwjoUiAWh6qBI6x9j/v3W/K9oX7yf6eeasnkojvxgl/5
         KAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4cI0C+edHqjQmmO/rArIoU+PLyf7AYRNI0KFouoRxco=;
        b=HB0ap3y7xB415/gVJqJJSQz5BtVElzmnQGGlnGaLObe99u07+BZtRkzipoBtY6Xd+6
         XJoXM5p2EHZCBzfrOo19Nm/DTNEqvk5v1Wtqz5Pdl5XgZU0J6QvnatUGQNIioSbkxK/E
         y8yGVenRMX8AcsrT9iCJU8CBNY5lRcqrcmUyNwHpyF027CSdcMo9Ytqa1y6ea7YB41nV
         ZmUZ0ULLF9jd+OwKUjz4MgorS/e5gfa41Krkmyz+ntqU47PXHI4OTBLMKJyjOWF3wtqG
         i3CCeRICR+cg4bkSRdmg/4a7vyocjW4ZwEPYT8amC1Wv9FkHApRLsTLu51i1scgXdviO
         wY1A==
X-Gm-Message-State: ACgBeo2XHtWiAUULl/7+nSMTZ4DCLLq9KoY6I9Bp0T3+Esuzvcv/Zss+
        9YmpmRD5zx2eHXMaQsvsHDE=
X-Google-Smtp-Source: AA6agR5fa5mdkH83cIh2tWtL6RDyjFhuXdTLQnxKV+zSOJHJFHFkOKTz9VflpshhYcnDb6xlUPX82A==
X-Received: by 2002:a17:907:7388:b0:731:e57:dea3 with SMTP id er8-20020a170907738800b007310e57dea3mr7244985ejc.640.1659896151018;
        Sun, 07 Aug 2022 11:15:51 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: make rtw_handle_tkip_mic_err() static
Date:   Sun,  7 Aug 2022 20:15:36 +0200
Message-Id: <20220807181538.8499-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807181538.8499-1-straube.linux@gmail.com>
References: <20220807181538.8499-1-straube.linux@gmail.com>
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

The function rtw_handle_tkip_mic_err() is only used in rtw_recv.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      | 36 ++++++++++++++++++++
 drivers/staging/r8188eu/include/recv_osdep.h |  2 --
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 36 --------------------
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 5de4e13b4b17..8f2b131eb767 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -327,6 +327,42 @@ u32 rtw_free_uc_swdec_pending_queue(struct adapter *adapter)
 	return cnt;
 }
 
+static void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
+{
+	union iwreq_data wrqu;
+	struct iw_michaelmicfailure ev;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	u32 cur_time = 0;
+
+	if (psecuritypriv->last_mic_err_time == 0) {
+		psecuritypriv->last_mic_err_time = jiffies;
+	} else {
+		cur_time = jiffies;
+
+		if (cur_time - psecuritypriv->last_mic_err_time < 60 * HZ) {
+			psecuritypriv->btkip_countermeasure = true;
+			psecuritypriv->last_mic_err_time = 0;
+			psecuritypriv->btkip_countermeasure_time = cur_time;
+		} else {
+			psecuritypriv->last_mic_err_time = jiffies;
+		}
+	}
+
+	memset(&ev, 0x00, sizeof(ev));
+	if (bgroup)
+		ev.flags |= IW_MICFAILURE_GROUP;
+	else
+		ev.flags |= IW_MICFAILURE_PAIRWISE;
+
+	ev.src_addr.sa_family = ARPHRD_ETHER;
+	memcpy(ev.src_addr.sa_data, &pmlmepriv->assoc_bssid[0], ETH_ALEN);
+	memset(&wrqu, 0x00, sizeof(wrqu));
+	wrqu.data.length = sizeof(ev);
+	wireless_send_event(padapter->pnetdev, IWEVMICHAELMICFAILURE,
+			    &wrqu, (char *)&ev);
+}
+
 static int recvframe_chkmic(struct adapter *adapter,  struct recv_frame *precvframe)
 {
 	int	i, res = _SUCCESS;
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index 51dc287f263c..135fbb24fcbb 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -14,8 +14,6 @@ s32  rtw_recv_entry(struct recv_frame *precv_frame);
 int rtw_recv_indicatepkt(struct adapter *adapter, struct recv_frame *recv_frame);
 void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
 
-void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
-
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index c180f0e4dd3c..08dfe4482b8e 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -12,42 +12,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 
-void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
-{
-	union iwreq_data wrqu;
-	struct iw_michaelmicfailure    ev;
-	struct mlme_priv *pmlmepriv  = &padapter->mlmepriv;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
-	u32 cur_time = 0;
-
-	if (psecuritypriv->last_mic_err_time == 0) {
-		psecuritypriv->last_mic_err_time = jiffies;
-	} else {
-		cur_time = jiffies;
-
-		if (cur_time - psecuritypriv->last_mic_err_time < 60 * HZ) {
-			psecuritypriv->btkip_countermeasure = true;
-			psecuritypriv->last_mic_err_time = 0;
-			psecuritypriv->btkip_countermeasure_time = cur_time;
-		} else {
-			psecuritypriv->last_mic_err_time = jiffies;
-		}
-	}
-
-	memset(&ev, 0x00, sizeof(ev));
-	if (bgroup)
-		ev.flags |= IW_MICFAILURE_GROUP;
-	else
-		ev.flags |= IW_MICFAILURE_PAIRWISE;
-
-	ev.src_addr.sa_family = ARPHRD_ETHER;
-	memcpy(ev.src_addr.sa_data, &pmlmepriv->assoc_bssid[0], ETH_ALEN);
-	memset(&wrqu, 0x00, sizeof(wrqu));
-	wrqu.data.length = sizeof(ev);
-	wireless_send_event(padapter->pnetdev, IWEVMICHAELMICFAILURE,
-			    &wrqu, (char *)&ev);
-}
-
 int rtw_recv_indicatepkt(struct adapter *padapter,
 			 struct recv_frame *precv_frame)
 {
-- 
2.37.1


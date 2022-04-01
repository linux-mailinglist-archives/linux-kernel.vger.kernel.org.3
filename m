Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2404EFA64
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351640AbiDATaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351604AbiDATan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:30:43 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9FB36B5F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:28:53 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t7so2997239qta.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=OCd3gsRyzYDvDg9YDJvm6gTOtL0bDx/HUB4aqjhCnua1UdduM1FJa09W17iXTQufZ+
         qhW/keWErJpwKgsd+dcRGjKQpGKUH0cFEx4yxd1YhhZKOjAsdw2W9j0OrHxfERT9LkW+
         yScp27OffdfjqiyTuE3rNkff7aMBuVpbUh+zU4zyRw70xOeXU3IsK5eA2+LBg5Mn3mgv
         HN3GgX6rIQdMWbYOb5mbphx4kZGbTuWdm+PbFpomJ3F0IEFQMU0dur+lUsGl/FgAyEuS
         T21r7a+0IfnpmZ3/KArTz0nNNaMIBinIwHdaGW/WU6O4dJF8syG0SS2bKUMHbGgKHemS
         25CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=2+Aj679mTxUdO2bejlQQvTRuL35QcAGWkow8wGWcnEoNUmNxkKECU5frZF7W1dZGoP
         aKSyzKIKMPlv5zRWF3bu8IOQBx2sSjEztlAHwkJed2+VcpNRMeG4LCNVV7/GcgaTh5ls
         2qupjYTuM8jY+Ii6Uz1yeEHF/l67noN3S9UkQOuw+SEjrr0HSoRyGHeQJlePYD37x97z
         BFSTtg4S4CPo9n1NPEDDYSQdxzWFP1AVaHYwpg3jHa2W22318mAJwuk5wPXMIcbuatSM
         gBKYSIPOf/Vv9kBPHxwwgHC3wjAobVrqRVPRZoEajP9mJ/96jpDbfSbdlZyZ1kOiXK9B
         h3zA==
X-Gm-Message-State: AOAM532A9FPrYND9if7fUWv/3Y7D/e5o9zqxsupDKHREBBQVxr8DJTwv
        ELaywuqItpRrFXZciZq2O40=
X-Google-Smtp-Source: ABdhPJxXC0lHmceb2Y8k4OsE50EED8DUfZseas9xERkD5RyGCqRGAtTNynL89XVJY6mzl7JYj85oBw==
X-Received: by 2002:a05:622a:164e:b0:2e1:e204:44c6 with SMTP id y14-20020a05622a164e00b002e1e20444c6mr9708398qtj.193.1648841332284;
        Fri, 01 Apr 2022 12:28:52 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b0067b520a01afsm1646527qkm.108.2022.04.01.12.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:28:51 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH v3 3/3] staging: rtl8723bs: remove redundant else branches
Date:   Fri,  1 Apr 2022 15:28:38 -0400
Message-Id: <eb57817c25a90a98d5f1602f6595cae13b2ae7ef.1648840991.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648840991.git.sevinj.aghayeva@gmail.com>
References: <cover.1648840991.git.sevinj.aghayeva@gmail.com>
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

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 81e4b1bf68f6..7a941832ee34 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -907,10 +907,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			set_link_timer(pmlmeext, REAUTH_TO);
 
 			return _SUCCESS;
-		} else {
-			/*  open system */
-			go2asoc = 1;
 		}
+		/*  open system */
+		go2asoc = 1;
 	} else if (seq == 4) {
 		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 			go2asoc = 1;
@@ -1467,6 +1466,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
+	int ignore_received_deauth = 0;
 
 	/* check A3 */
 	if (memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
@@ -1502,32 +1502,31 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 		return _SUCCESS;
-	} else {
-		int	ignore_received_deauth = 0;
-
-		/* 	Commented by Albert 20130604 */
-		/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
-		/* 	we will send the deauth first. */
-		/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
-		/* 	Added the following code to avoid this case. */
-		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
-			(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
-			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
-				ignore_received_deauth = 1;
-			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
-				/*  TODO: 802.11r */
-				ignore_received_deauth = 1;
-			}
+	}
+
+	/* 	Commented by Albert 20130604 */
+	/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
+	/* 	we will send the deauth first. */
+	/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
+	/* 	Added the following code to avoid this case. */
+	if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
+		(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
+		if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
+			ignore_received_deauth = 1;
+		} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
+			/*  TODO: 802.11r */
+			ignore_received_deauth = 1;
 		}
+	}
 
-		netdev_dbg(padapter->pnetdev,
-			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-			   reason, GetAddr3Ptr(pframe),
-			   ignore_received_deauth);
+	netdev_dbg(padapter->pnetdev,
+		"sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
+		reason, GetAddr3Ptr(pframe),
+		ignore_received_deauth);
+
+	if (ignore_received_deauth == 0)
+		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 
-		if (ignore_received_deauth == 0)
-			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
-	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
 
@@ -1574,16 +1573,14 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 		}
 
 		return _SUCCESS;
-	} else {
-		netdev_dbg(padapter->pnetdev,
-			   "sta recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr3Ptr(pframe));
-
-		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
+	netdev_dbg(padapter->pnetdev,
+		"sta recv disassoc reason code(%d) sta:%pM\n",
+		reason, GetAddr3Ptr(pframe));
+
+	receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
-
 }
 
 unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
-- 
2.25.1


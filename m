Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0064F218B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiDEDS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiDEDSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16C2127E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id d65so9355747qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BJ7cxaRbKAyhta/oCZgwB/x5LwxJCNvCW+2zU0E+Y5k=;
        b=dLrvpeKHnrI4N6WvNfn5wDAyi72w2XOW2Mz/qI5cv1XUUQWXGaO9inRaDEi7Oqd/KS
         vGTTjjbhJY7145KVMP8yvYLXqhM5YnUE4iMR1Dh6c9sh/UgBSpCj8E518TPycQjAoWhW
         VZp07I0ymE9fe/Digyt/eaGQeF37a/2bcTkw5wV/wD63V/036+iRBbGTXmTwwToCtLIq
         ZO9+1izSrSKthLDV0JYulJaKHchtlkvFUNptFmBtZtc1xhuxoRrBKVrTX3UQ4bJ4re3T
         F4EPI6SX1UYKDf9htTVtbDlMyo5R0KYBEEsN08Jur/QDF7lubt93Bf5TiA6TR7Z+5GLa
         kz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BJ7cxaRbKAyhta/oCZgwB/x5LwxJCNvCW+2zU0E+Y5k=;
        b=WtV41IrNnHm39BtMFujbhDfW5DfKWB8D+1b4ZK23fEZOGZ8ZgwNmMSzgkQuThqabf7
         YKNjtWwDYNYl50mt7tJJgf+z7CFUJ+ZgopgJlv6f+8HhOPe+i7cPFVdfJKGYRN3QgXXV
         Jl/nZQYPChzrq8A82WgBwUvsIh8ogVIpdUMgocJJ5YdmXxfP3vqpx01exwdPvIgvoUUX
         pfiXxfIp18ns512br4XD+ew9h6EyjCuFmStgKVntjF1HLWp+/jxuUCCEQbp23WD7qC+1
         v+sMRMotM8BF70gxayJ3yo5gOr2sPYHqWM9WQ8lpt0Poq870wjgzqEdMozuqruE7Lqg9
         Cr+w==
X-Gm-Message-State: AOAM530Am1465ldDKgiQ3axcKF5aPHeLrSLrPsiZbQ7cop1jLdkWJRpZ
        2uKELeX+7DBtpRsMfIQP5ws=
X-Google-Smtp-Source: ABdhPJwR2t57Egy+nHAQe7HDj3yiX5NJ6BgHpPqLMjHfQcQpIHqHqOzhK9Q9nz97ns4MNx8gquaOAA==
X-Received: by 2002:a05:620a:4706:b0:67d:c81b:b625 with SMTP id bs6-20020a05620a470600b0067dc81bb625mr907357qkb.775.1649128586529;
        Mon, 04 Apr 2022 20:16:26 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id v7-20020ac85787000000b002e1c8376517sm9534540qta.22.2022.04.04.20.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:26 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 2/5] staging: rtl8723bs: remove redundant else branches
Date:   Mon,  4 Apr 2022 23:16:09 -0400
Message-Id: <fcb50e467d5ac81becf222379bcc21136966b86b.1649128267.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
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
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 64 +++++++++----------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 73891222f0d0..8c3b1448270a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -908,10 +908,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			set_link_timer(pmlmeext, REAUTH_TO);
 
 			return _SUCCESS;
-		} else {
-			/*  open system */
-			go2asoc = 1;
 		}
+		/* open system */
+		go2asoc = 1;
 	} else if (seq == 4) {
 		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 			go2asoc = 1;
@@ -1468,6 +1467,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
+	int ignore_received_deauth = 0;
 
 	/* check A3 */
 	if (memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
@@ -1503,35 +1503,33 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 
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
+	    (pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
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
+		   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
+		   reason, GetAddr3Ptr(pframe),
+		   ignore_received_deauth);
+
+	if (ignore_received_deauth == 0)
+		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 
-		if (ignore_received_deauth == 0)
-			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
-	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
-
 }
 
 unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
@@ -1575,13 +1573,13 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
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
+		   "sta recv disassoc reason code(%d) sta:%pM\n",
+		   reason, GetAddr3Ptr(pframe));
+
+	receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
+
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
 
-- 
2.25.1


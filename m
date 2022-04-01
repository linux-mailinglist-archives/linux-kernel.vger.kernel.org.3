Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBCA4EFA46
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351499AbiDATJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351505AbiDATJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:09:07 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D72128A035
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:07:16 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id d65so2885367qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=APcJEDArJqsnOZqX52DlQofSk6M2o5kXbtnZRnmR4+bMQwuqhC9GbyCQkPWUCDWHpT
         OjTa9QKc4uR6yJXko6K6zn1nL7B5iFutXY/Lts6BsgNBVevLricqdXdR1FeVpJ9Q+qGa
         odNRS+gj1i6IZ1qn+MXW19FZEeqj98bhygB6n2ihmYQohknqiaPh8Bkepeyv+WbPLXtF
         iSAxNrsv/HP1kpjqCgPgcknB4rc5goyMxLLdJrYq1KZkaYBrUFqj3B1X4gsnttBPrvfr
         cSFfyN+EVJIPVBaqTlld9w5Xp/T5WOY9eMoYwrUgStxAljX6sxKK25KfVGJWuud9iqlW
         N3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=UfOlpVkpelw+N8VpSdYBxfLrRrcMbhJX5xCecIHjqAUhuBejTuQlemK3FMlhznAxy/
         PpaF7Qr1c4ploSay5pHFo+PIoUARLxKjqOxb80BJxH19oyC2G+T6ADYuLzvOLzcgjIRv
         zlQYkb7eH9JrgLvk7yFtxzuvZBwLxelj5OQOVpv9TGbB+LflpTgOaEO7WapAF6M8zFhy
         oVhezZXeaMAZfz1IAcUzaLTG9tGNNEm2bVkj5HYRYWwAbCUrrVTF8L1QkszSqbRE4cIe
         /Ra+U9gVgVVKTk4pIV0IqjPEgkt9eoFs+hHi264WkwFG6ULKYs8iWL7njGgo3CgUZ177
         Y0PQ==
X-Gm-Message-State: AOAM531bbD2MJEoo711jafmKVt29Ki7Vbwr2QoATL6HIPhZmVxndQDZ+
        1RdWX2smP8WXWGpIeZiJlXs=
X-Google-Smtp-Source: ABdhPJzgZVBoX9n8hle80mGH6mQBR9zbxOU1a7ngT2sbYX7Q1YBV857k348RMha0AjcM8eAflQSSxw==
X-Received: by 2002:a05:620a:410b:b0:67d:d23f:13d5 with SMTP id j11-20020a05620a410b00b0067dd23f13d5mr7670928qko.705.1648840035103;
        Fri, 01 Apr 2022 12:07:15 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm2341549qtx.11.2022.04.01.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:07:14 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove redundant else branches
Date:   Fri,  1 Apr 2022 15:07:00 -0400
Message-Id: <eb57817c25a90a98d5f1602f6595cae13b2ae7ef.1648839305.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648839305.git.sevinj.aghayeva@gmail.com>
References: <cover.1648839305.git.sevinj.aghayeva@gmail.com>
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


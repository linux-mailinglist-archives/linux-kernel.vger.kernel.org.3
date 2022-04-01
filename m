Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC34EEDBE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiDANFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346129AbiDANFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:05:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3352E220
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 06:03:20 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id gi14so1984430qvb.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oI4MeZFmluScztYaA4VGctO3l6sUlCTurVeMLoxfQBg=;
        b=YvI0VDDH3q5+7ckyi7kCQTBjoOqgTj+ac4c9wT8B8eJ1PbPaRwwK0+7mto6l5e0DcS
         0TjrdiBikRqVaBrF2BT/jPxFFgcOKyYAUklYMsq20KQHj/Ey25bvWuyjbDUFwQqNI0ya
         Xooja1fJ+rAk314BrC4GIWJIGBZX0k+aaD26e0ZoGoz06GxE6IfjNE0Cn87VEEJJZqbK
         yruEBFnbu652T3+OqKOOV9GqXGraxiVaQfpgk/aeYWt/47VwZ6cwAKYLkVHIbi6kZBVS
         nKBNv+PhAmZbut7ss3SkJWReTmK5GvW3UC53Cz5gRm2XE5r9Qid0BXEKGzSqIRcM68kD
         loyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oI4MeZFmluScztYaA4VGctO3l6sUlCTurVeMLoxfQBg=;
        b=yIk/p7SShenqKenAWcoeIZoTwjTFOIoNfvxnUUu+bJxVJPkkyYDjPr1s0q9W5vWdag
         McxH7c4cVTwvkRP9+lecaN+4kYYLl+nOURRFrGgDJHXYtoGmUucaAEwBQsYUH9B2yKe2
         sZm0NPBDx2xS3cgxxi21R+n38zccO3qudmnP4G7xMCq96lTtm4XzDn6ZKyKi0utRYvYP
         Q6YCfUdjY68jAjFV0Vu50n4MzdfHkHBrN/5Ppv5yUF5LzXoytqP8kZCmbFPYKi7cbyKv
         4C8A5VfIun5jF6JJ5So0tX4e79z/g6JkrY+mXIdgOA2pk4RA/RCi/qgsMYZMNlm+idM3
         epDw==
X-Gm-Message-State: AOAM532Tn1wY2QdO2yUbGXzXRFTR6XgS3AnDJBllkDVgK3NNPOWEVjEl
        IGQP6SdsawGvO671mZRxXeg=
X-Google-Smtp-Source: ABdhPJyvsCwzPlmuiLN3jWABn2eF7L/jerRPovbVt3dzsb3tiE8WZzgpYikzbcbDORXhvkobAMQWUw==
X-Received: by 2002:a05:6214:5017:b0:441:1ced:36e4 with SMTP id jo23-20020a056214501700b004411ced36e4mr7926306qvb.80.1648818199108;
        Fri, 01 Apr 2022 06:03:19 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id l13-20020a37a20d000000b0067d17b656acsm1220235qke.78.2022.04.01.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 06:03:18 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 3/3] staging: rtl8723bs: remove redundant else branches
Date:   Fri,  1 Apr 2022 09:02:47 -0400
Message-Id: <8d745122cd10f5db59393b1bff09e6a73e88640b.1648817213.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648817213.git.sevinj.aghayeva@gmail.com>
References: <cover.1648817213.git.sevinj.aghayeva@gmail.com>
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
index 81e4b1bf68f6..b80d9061f5a5 100644
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
@@ -1502,32 +1501,32 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 
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
+	int	ignore_received_deauth = 0;
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


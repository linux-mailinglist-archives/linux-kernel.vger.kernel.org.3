Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57474FB979
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345338AbiDKK0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345445AbiDKKZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3806C45055
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t13so13782511pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yl+s+hfKCeq5/g5ZuXagReICrGy9w2ZYqBzEvur9CXQ=;
        b=Pd5QdnSlOTFKqeIQk/tHI6gVXTXj37xy0Apv8pOeoLHcdd6gsN7A5o88Vtcev4CBVu
         TYxsrwuOZzC1RZ7j+MgFAJaZ5/lhS9ADQGR6+LKcDJWS7EvA9wi/HM2cj9LiulCS5N22
         gRDNA3uWnhpRwrb7OGGmrgaEKwFAlfw3IO6nNgxTKTOOGbjXzEBKAO31Kx5iOqCtOkGv
         SlcgCIJ361ycbQ9/yAxzpWB0dwrrmOmnvgwiY5044oOIpmLfM88NXH7NdqQ5ZDSOYAED
         m4RB0qL3w2gSUOaVpMP5ifPYpKm/l7XASbzaXFvM54X6tgAsk1xLoW+p/iyAFp59te+D
         3nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yl+s+hfKCeq5/g5ZuXagReICrGy9w2ZYqBzEvur9CXQ=;
        b=IBgvUzlJvFH8vEujpJMnsoPT+/rWJSWitMKHekR/MEA0tuqp3MdY2zOmKV71jfrWkF
         /X926BxXFbCdfuK82QOM+EuWsKhmKEls9oyq4xEw6pE/N8tJB17u7+IB0UtWq2CnX1Wx
         cYMVGcWmupMfxivDIPb9i3915/hRWyxzoV4EOJl2lZUNOqmiZC5X41TJjAKADj+szQ9z
         EROMKq6Xfbp81Vr6u6mCHSUT34PkztxpvnyiP0IjDqn9/eWsjPsVueOCr4TcSH+LDa3q
         VOPuQLH3NQT15Alhur/jFwnGHNR0p+EOuCOPY7FgcXP39lGbbKqiVY8onu2ZOlvGg5PL
         aohA==
X-Gm-Message-State: AOAM533Jd4XVhS5isUCXIC4StAT6YdeJIHwTIL/+6GJKBDLndTxzlmWg
        yjd570puMf732g1Pkvk32Iw=
X-Google-Smtp-Source: ABdhPJwEjcYvNIrxOhNhNP8a/KJ22xsCXtH+eu4FqsmRTEV4fiFQrge6nR1WP7fU6xiiTJDStESYvg==
X-Received: by 2002:aa7:88d4:0:b0:4fd:ad26:c52f with SMTP id k20-20020aa788d4000000b004fdad26c52fmr31668472pff.25.1649672536593;
        Mon, 11 Apr 2022 03:22:16 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:16 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 6/7] staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
Date:   Mon, 11 Apr 2022 15:51:35 +0530
Message-Id: <20220411102136.14937-7-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411102136.14937-1-makvihas@gmail.com>
References: <20220411102136.14937-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary wrapper _rtw_alloc_network and move its logic to
rtw_alloc_network.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c    | 59 +++++++++-------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 +-
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 3781706f7..959b69be5 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1457,7 +1457,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 		rtw_indicate_connect(padapter);
 	} else {
 
-		pwlan = _rtw_alloc_network(pmlmepriv);
+		pwlan = rtw_alloc_network(pmlmepriv);
 		spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 		if (!pwlan) {
 			pwlan = rtw_get_oldest_wlan_network(&pmlmepriv->scanned_queue);
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 5584e1b84..31a5f252c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -53,38 +53,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_assoc_req_ie, &pmlmepriv->p2p_assoc_req_ie_len);
 }
 
-struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
-{
-	struct	wlan_network	*pnetwork;
-	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
-	struct list_head *plist = NULL;
-
-	spin_lock_bh(&free_queue->lock);
-
-	if (list_empty(&free_queue->queue)) {
-		pnetwork = NULL;
-		goto exit;
-	}
-	plist = (&free_queue->queue)->next;
-
-	pnetwork = container_of(plist, struct wlan_network, list);
-
-	list_del_init(&pnetwork->list);
-
-	pnetwork->network_type = 0;
-	pnetwork->fixed = false;
-	pnetwork->last_scanned = jiffies;
-	pnetwork->aid = 0;
-	pnetwork->join_res = 0;
-
-	pmlmepriv->num_of_scanned++;
-
-exit:
-	spin_unlock_bh(&free_queue->lock);
-
-	return pnetwork;
-}
-
 void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *pnetwork, u8 isfreeall)
 {
 	u32 curr_time, delta_time;
@@ -286,11 +254,34 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	}
 }
 
-static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
+struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 {
 	struct	wlan_network	*pnetwork;
+	struct __queue *free_queue = &pmlmepriv->free_bss_pool;
+	struct list_head *plist = NULL;
+
+	spin_lock_bh(&free_queue->lock);
 
-	pnetwork = _rtw_alloc_network(pmlmepriv);
+	if (list_empty(&free_queue->queue)) {
+		pnetwork = NULL;
+		goto exit;
+	}
+	plist = (&free_queue->queue)->next;
+
+	pnetwork = container_of(plist, struct wlan_network, list);
+
+	list_del_init(&pnetwork->list);
+
+	pnetwork->network_type = 0;
+	pnetwork->fixed = false;
+	pnetwork->last_scanned = jiffies;
+	pnetwork->aid = 0;
+	pnetwork->join_res = 0;
+
+	pmlmepriv->num_of_scanned++;
+
+exit:
+	spin_unlock_bh(&free_queue->lock);
 
 	return pnetwork;
 }
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index fc30793f4..95c23bf11 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -560,7 +560,7 @@ void rtw_scan_timeout_handler(struct adapter *adapter);
 
 void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
- struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
+struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_network(struct mlme_priv *pmlmepriv,
 		       struct wlan_network *pnetwork, u8 isfreeall);
-- 
2.30.2


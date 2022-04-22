Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0844650C137
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiDVVjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiDVVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28042D358B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r11so5789216ila.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZMlpwmjON05raKFGDQgTKXed4pbMzjEU/f7GpRcKxk=;
        b=mMjUvoeU7khCqxILg6UhdkcGTrULEYt3h6NEoR3C9tZq15DQ+u2wQJbEae0E2/OnSq
         nXZ4Y9Sh1wtbGvU4BOWFS/FHjZiyDMDcZWFHB72m+HQPTSBmxB+kWeYyx+DQ8EvP6Udq
         REbku2UZ9VRL294uVCkmhHlD9BNzPE3x7rTRuyx78NBtj3RWIqrvyH5S+3LHhz64Iam0
         iqk1M9yqg+cYzFsZIOQ6o3AWIwXJPXxRulGmYgzWR+EHW4C1MYPF3x1JAWjDrZx7sbKm
         R5UhQc6J6Xf0It0KsW3U7vwGl5KHmRUUSmGR6Pb29Vu5j54tgLX4MTvVvWtTxAOr4ztk
         a7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZMlpwmjON05raKFGDQgTKXed4pbMzjEU/f7GpRcKxk=;
        b=TIUpWKwsRWgD3PpOrkeITc6gCw+HYc6YTiL58mVUZ5CFnHDUYx9Wv5NcWScQWW7EYU
         mx0ajHcpx7CAF6n4IrYUbpUmMGkgiBgbMIDd53TOLprLIJ73upB4BNv5oO17NMuGOpSR
         MJ5gaWeGUc+wN3K97U77t4z1Fo9+RYe9MA1pYTQPmi42jx/xkJHoQVuUChPI3HPTwTLK
         0FREGwytMqtuCZMl2mj+Hv+OBwX5eSvKsS6s6shmxyD8GZi7gofS18Zu+o6dEdEkYCIr
         ZCTxDUBdheWerSJMZn5mj7CkvuMJ/jKDfPXt9Q0yGIwdY0YUNOywd/O7t4fSPG4Z4wcc
         TSug==
X-Gm-Message-State: AOAM5330uJ/DFyA5mNeUISQ9SASRItRJyXVwkR7pVpFMj7WpXLG6eEa2
        VpnjdSEZLDDrUGt9+RNrAtAO9HwmE5dpow==
X-Google-Smtp-Source: ABdhPJwf1R9PUV4mgIvU1nqQLy0/9uBmokjqz+5KcU+gSfYHapHv5UiGBPk1nizg2H8mRtBEfoDOlA==
X-Received: by 2002:a63:591c:0:b0:3aa:506c:b50b with SMTP id n28-20020a63591c000000b003aa506cb50bmr5219423pgb.77.1650655967838;
        Fri, 22 Apr 2022 12:32:47 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:47 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 4/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
Date:   Sat, 23 Apr 2022 01:02:20 +0530
Message-Id: <20220422193223.11948-5-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220422193223.11948-1-makvihas@gmail.com>
References: <20220422193223.11948-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unnecessary wrapper _rtw_init_mlme_priv and move its logic to
rtw_init_mlme_priv.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 103 +++++++++++-------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 081c02417..50a65a4e2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -30,60 +30,6 @@ u8 rtw_to_roaming(struct adapter *adapter)
 	return adapter->mlmepriv.to_roaming;
 }
 
-static int _rtw_init_mlme_priv(struct adapter *padapter)
-{
-	int	i;
-	u8	*pbuf;
-	struct wlan_network	*pnetwork;
-	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
-	int	res = _SUCCESS;
-
-	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
-
-	pmlmepriv->nic_hdl = (u8 *)padapter;
-
-	pmlmepriv->pscanned = NULL;
-	pmlmepriv->fw_state = 0;
-	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
-	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
-
-	spin_lock_init(&pmlmepriv->lock);
-	rtw_init_queue(&pmlmepriv->free_bss_pool);
-	rtw_init_queue(&pmlmepriv->scanned_queue);
-
-	set_scanned_network_val(pmlmepriv, 0);
-
-	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
-
-	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
-
-	if (!pbuf) {
-		res = _FAIL;
-		goto exit;
-	}
-	pmlmepriv->free_bss_buf = pbuf;
-
-	pnetwork = (struct wlan_network *)pbuf;
-
-	for (i = 0; i < MAX_BSS_CNT; i++) {
-		INIT_LIST_HEAD(&pnetwork->list);
-
-		list_add_tail(&pnetwork->list, &pmlmepriv->free_bss_pool.queue);
-
-		pnetwork++;
-	}
-
-	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
-
-	rtw_clear_scan_deny(padapter);
-
-	rtw_init_mlme_timer(padapter);
-
-exit:
-
-	return res;
-}
-
 static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 {
 	kfree(*ppie);
@@ -289,9 +235,54 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 
 int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv) */
 {
-	int	res;
+	int	i;
+	u8	*pbuf;
+	struct wlan_network	*pnetwork;
+	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
+	int	res = _SUCCESS;
+
+	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
+
+	pmlmepriv->nic_hdl = (u8 *)padapter;
+
+	pmlmepriv->pscanned = NULL;
+	pmlmepriv->fw_state = 0;
+	pmlmepriv->cur_network.network.InfrastructureMode = Ndis802_11AutoUnknown;
+	pmlmepriv->scan_mode = SCAN_ACTIVE;/*  1: active, 0: pasive. Maybe someday we should rename this varable to "active_mode" (Jeff) */
+
+	spin_lock_init(&pmlmepriv->lock);
+	rtw_init_queue(&pmlmepriv->free_bss_pool);
+	rtw_init_queue(&pmlmepriv->scanned_queue);
+
+	set_scanned_network_val(pmlmepriv, 0);
+
+	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 
-	res = _rtw_init_mlme_priv(padapter);/*  (pmlmepriv); */
+	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
+
+	if (!pbuf) {
+		res = _FAIL;
+		goto exit;
+	}
+	pmlmepriv->free_bss_buf = pbuf;
+
+	pnetwork = (struct wlan_network *)pbuf;
+
+	for (i = 0; i < MAX_BSS_CNT; i++) {
+		INIT_LIST_HEAD(&pnetwork->list);
+
+		list_add_tail(&pnetwork->list, &pmlmepriv->free_bss_pool.queue);
+
+		pnetwork++;
+	}
+
+	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
+
+	rtw_clear_scan_deny(padapter);
+
+	rtw_init_mlme_timer(padapter);
+
+exit:
 
 	return res;
 }
-- 
2.30.2


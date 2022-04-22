Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329F550C08D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiDVUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 16:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiDVUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 16:01:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A655730FDC3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:47:10 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c1so2367378pfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y+doHSiz3zcutbur9voJocSmaAz48vDvOlIUUyf7FWM=;
        b=a89x4nKawOtJHTWqZbbFoLA02HiA2GzJbSC41mQ0wwzZCECYB6TfQJyr2/Df//ex6j
         XmT7P5B7iv2ke14uKxII/CpVdU/jGI3+z1MIfk01HgLY9e7jNF9Ef2GADrch0NvHa2Y3
         e0KdE6OauULyRg0pbergxbJPNWhKph4DwTXjsVF841dpy6vNTRdBbFB4kG6CDGiBe/En
         Qb0hJIxgcUjt+X3s6hrUD5N9ZqrYgaixHHLzZl+0DDb3SAg7tffEOtAZ3BhMwk+Jk8Q8
         uA7WNM97/AFXWvlT4MeMpnEo8UMFQt1R3aNEVDwn5c6WaCgsPEVAFR101CSOBwwYA7K6
         c4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+doHSiz3zcutbur9voJocSmaAz48vDvOlIUUyf7FWM=;
        b=xKGR+wbhJcystiwDLF8Rk3/XSDsdr8jiu1tXel9+Re4YpVmnMaYHN/qLPao4VQf4nh
         ZugRyFVGQxwJIvjrkg2Mf+joD3iWAzJvMJBovF9LC2l6aADO97uE7fDYP69VxdpxiRx2
         8SOFflEbLFK/YQ9A0H3jRymQr2ajaN/3lLClFxHhhqEmt2UI2649i987AFx6d7KZ4rDK
         Y3i+3cBFdcnZTmNdBSB20/gWt6CCijNIwIy4bahfr5fle5i6BhUDROeRGswlbkD8BrXf
         ohS/sgB1POa5TuUbJ6Yow9kkMktsRJ9zKbWGFluZcd5FenF/U+a3aI62yLlJPuabiasx
         wDXw==
X-Gm-Message-State: AOAM531GYmqRkKsOKWQIW70ZwTPfJTdLnKfF3qKT8UBc8Gpr733VdFhK
        3LTE5COrNtD6n7B9I9a7PIQr+QFy1FBU4A==
X-Google-Smtp-Source: ABdhPJxEUUev7ihPovjIZboLjGNyvTtHcPOY4eAutzFYv8bD3wyzHsFImEWTBe+Xfe0zGML0moa32Q==
X-Received: by 2002:a62:a504:0:b0:50a:ceee:5f4 with SMTP id v4-20020a62a504000000b0050aceee05f4mr6608640pfm.13.1650655974887;
        Fri, 22 Apr 2022 12:32:54 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:54 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 6/7] staging: r8188eu: drop unnecessary wrapper _rtw_alloc_network
Date:   Sat, 23 Apr 2022 01:02:22 +0530
Message-Id: <20220422193223.11948-7-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_alloc_network and move its logic to
rtw_alloc_network.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     |  2 +-
 drivers/staging/r8188eu/core/rtw_mlme.c    | 59 +++++++++-------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 +-
 3 files changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 512896b86..ab462eb40 100644
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
index fb64954a0..080e07385 100644
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
@@ -285,11 +253,34 @@ void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 		vfree(pmlmepriv->free_bss_buf);
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
index fc30793f4..e982f0615 100644
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


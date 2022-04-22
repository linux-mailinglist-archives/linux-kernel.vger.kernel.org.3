Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3B350C13B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiDVVjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiDVVjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:39:32 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D054169E6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id k14so8279970pga.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IQD1XVsVgNtpnSIJlyB1Igy1Zt/tIoNBydvA5N9QY8=;
        b=lMzILyzVY4s6HqsqcMbieRZUuzRhTfhOR3I/bs3u5XTfI/8c0Q8csI4tw+7aSR7FzJ
         lZhHjenfud/GLz8MrvPhRok6un812iDrEpnDXIce7PSTQcfKM42NahuNIBku3irxgGlg
         Hg/x7ZvBxQ51J9+vnDV5d3QrkFrWDo0liJh1zQU3Vr39aVF6R2+KylmIF46tvPc20lEP
         aLnEykbAWUoE4X1f15OOk4c6l67AOSi3PXp0Z+4g6QXXEeSCFhZh4mTcTDUzB8X4hgWr
         BbqhFW3WwnAPLzKmTZHmDPu3QQvaHfYT3z+DxUBp4jT8SabsJ0r9b2pID7g+W5c4yY1Q
         Q2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IQD1XVsVgNtpnSIJlyB1Igy1Zt/tIoNBydvA5N9QY8=;
        b=NWmTJtECvZUAfY5gaJLJ8QXBdpi1QbF+pWPiskBTKNABc/wOQh6X6YvmB2adyoKPSi
         3Ge+rWjes7/uiUASsra+5L7BnKMxM1JW/IvIufG72LYjTt7+Eay0z55MDl5/W2Ebgsx4
         WJB4IlDPwwjnRdvEB9zD9K6fS/vG/5/O3Pw1/jkhOqKPsbltVqNsgLmetWfnih0HFuEt
         vYdTpwSKQM0UcJbeKowiNqnwPjTEW1No5b29ZpEghHaXmuEjppC6INSAriUTlvpEv8t0
         Ze3sqP2YoRMk1jtoyuOoTqaa86eVlL+IO/29JiXQDHNRHTfbsI3VhVANwFv/ekJ6GmKH
         hYxQ==
X-Gm-Message-State: AOAM531MeDt4G0XSdsPjAn+/egjb5OA6XVBXkxV0GbCmKDvovo3k4lnD
        B3baRK7jdHrbXKd+JCdl3aoj9I+ft1Kt4A==
X-Google-Smtp-Source: ABdhPJwck26beUm/r/6Y9AyQaLFefvEwf0yPOn/B0kTV9OwEcXXwd2UxbZV63DbOsNL6PH9M1hnwbw==
X-Received: by 2002:a17:902:b106:b0:159:5c6:cb53 with SMTP id q6-20020a170902b10600b0015905c6cb53mr6148972plr.99.1650655971280;
        Fri, 22 Apr 2022 12:32:51 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:bfe0:e8c0:bea6:ee63])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm3518932pfh.83.2022.04.22.12.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 12:32:50 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v3 5/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
Date:   Sat, 23 Apr 2022 01:02:21 +0530
Message-Id: <20220422193223.11948-6-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_free_mlme_priv and move its logic to
rtw_free_mlme_priv.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 15 ++++-----------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 --
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 50a65a4e2..fb64954a0 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -53,16 +53,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_assoc_req_ie, &pmlmepriv->p2p_assoc_req_ie_len);
 }
 
-void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
-{
-
-	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv)
-		vfree(pmlmepriv->free_bss_buf);
-
-}
-
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
 {
 	struct	wlan_network	*pnetwork;
@@ -289,7 +279,10 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	_rtw_free_mlme_priv(pmlmepriv);
+	rtw_free_mlme_priv_ie_data(pmlmepriv);
+
+	if (pmlmepriv)
+		vfree(pmlmepriv->free_bss_buf);
 }
 
 static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1dc1fbf04..fc30793f4 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -560,8 +560,6 @@ void rtw_scan_timeout_handler(struct adapter *adapter);
 
 void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv);
 
-void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv);
-
  struct wlan_network *_rtw_alloc_network(struct mlme_priv *pmlmepriv);
 
 void _rtw_free_network(struct mlme_priv *pmlmepriv,
-- 
2.30.2


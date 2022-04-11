Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3354FB973
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345472AbiDKK0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345373AbiDKKZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9664E45040
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so5687626pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0Zrucn+WwL2muTuZbK71MP5TYNDykrOeiAojxdU0WI=;
        b=Ch7QdJknQqzcOMoV8qxSf6WOdf7BNtp+gc2rzVO0jw+mSNFxtNzmw/zu72/nAI7tbw
         u84t7t6no98vZm/up1Z8bUEbzFlFfeRkYmRPlwKjT+cscsV9eEHUZKNnBiuXUf3WhiT4
         yPeU1K1tv8EeDkfGOupRpLBLT5r3GAPx9tkcLat/RfuI+z1KHRLY5mP3sBnpPbY5vGzV
         ChatEL3m4Iv7smjU4LZfDieL8WwozJFtKPBJ53+kk4lVstpqd9bhbnUlPZBXGGVoKRHA
         vS8onxkLGq1yq67MU22cpGaXBel69FYTvpn+BrITDN2uXhqbUtpOR2xOYOoCVC7saFlA
         Xgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0Zrucn+WwL2muTuZbK71MP5TYNDykrOeiAojxdU0WI=;
        b=yTGuILQsFKwJGFTbRyMuDyk8fHSsrq96KrQLx2tXjV8IQFfSlnC6sechTrZwlRoENa
         9nOyixrdaCKlu+83G4Yt7j2aR/Gf93OPynFWO5158WEqjDYbozS5DEC2obg4D19b5Jr6
         p6hGcChBxQ1wz7QL5CGanqOZ0t1v3P1o+ZOIOneuOmhchSWRorPW5yZK+RQJIrzcAMn0
         DJaFOZ0HI8CipCNwfgS51A6WlkR7P+WtKh+0yaXyyaPeMNMom0gO/wmX1ns1w+VLNB8T
         UGxu8IwX5w9VOXVrAEPnCknYUT7PuScbHMpcxeXjQMaNRk8p9OUDYe9xR6KiGjokYkcI
         zO5g==
X-Gm-Message-State: AOAM531oYjsvskGKL3F7qDz0m4oD3ML+uRneZKOnS5eBDDBJogTdB5u2
        6+DEPWoF6FlfQVc1W11nHoo=
X-Google-Smtp-Source: ABdhPJxYWMg1MZfRhJeYN5uUBu1QegtEZehtCCABl6fPidSMXprTMg1jnpqCwnjSCiprkDJGzgMJQA==
X-Received: by 2002:a17:90b:4c92:b0:1c7:a9a3:6274 with SMTP id my18-20020a17090b4c9200b001c7a9a36274mr35551149pjb.148.1649672532937;
        Mon, 11 Apr 2022 03:22:12 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:12 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 5/7] staging: r8188eu: drop unnecessary wrapper _rtw_free_mlme_priv
Date:   Mon, 11 Apr 2022 15:51:34 +0530
Message-Id: <20220411102136.14937-6-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_free_mlme_priv and move its logic to
rtw_free_mlme_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 17 +++++------------
 drivers/staging/r8188eu/include/rtw_mlme.h |  2 --
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 6b8c80fe9..5584e1b84 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -53,17 +53,6 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_ie_data(&pmlmepriv->p2p_assoc_req_ie, &pmlmepriv->p2p_assoc_req_ie_len);
 }
 
-void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
-{
-
-	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv) {
-		vfree(pmlmepriv->free_bss_buf);
-	}
-
-}
-
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
 {
 	struct	wlan_network	*pnetwork;
@@ -290,7 +279,11 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	_rtw_free_mlme_priv(pmlmepriv);
+	rtw_free_mlme_priv_ie_data(pmlmepriv);
+
+	if (pmlmepriv) {
+		vfree(pmlmepriv->free_bss_buf);
+	}
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


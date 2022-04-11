Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8501B4FB96C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344159AbiDKK0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345494AbiDKKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:25:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17B344A31
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 32so11663341pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pihteJgws3CPWC4SIMyqFCTdNFf4a7DVbmyRBkvm3cc=;
        b=ozYrBwVoW8GtsA2LMBdHt6bDeJZtkGzYW2+K2uSshw5P4MKZPC6ecevfqXHrxlNoKX
         TempNdL6Nw8L916q5BfA915Cha2mG1sTewnDh/g+NpQTeohWwR3/uvpoJNSDdnRY8ob5
         RC5xWCYcKmls1v5W34MCI1hksCjg9tAKgI8xz6Rcu92eXDERMbIqHbx+p5Vk9K63ZQwu
         5BvNrUsLDsWNg3nTIZpno1vecNM2rFLVclLCnUxPccXBkE7qs/5ta/37e1agqvoZJH4Z
         yj2PL0FZ1RooB4GiTE1scRriMt54bZp1mVbRlFe4aMyhmay5cv1SOxqfmzzm16w68Pfn
         r92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pihteJgws3CPWC4SIMyqFCTdNFf4a7DVbmyRBkvm3cc=;
        b=dY85CtUb/w4mnvNu3MGu2iJS96Zp6N2vP+aRG1Tb8XTvkTVctFPd6QgWtVSA80cVLE
         DqeFZGaV5d6d85cAz3JDakiyAi2KURGcYwA9hrN51GyWQSEJ72LzxvhxacCeBqpV8H4H
         G8ESxUHKeL0N9BNYbg6c8gImHNAM58otrTBYMkOujb86IU2RFc/et4TmXAWIaRIy+eHS
         0B9ASCx5pbHB4BZQaqnOcyyiRQXuwm2lJDwhDdG2q6bGgGQxIvzVIzPBlWcuxf72caQD
         PYtGxyw+BgGF3Gev3UYKyK+EzPg7l0K7n7FX7EQg7bVPWRAhhCCKhQ+sEWQ239Nsj4WU
         v0uA==
X-Gm-Message-State: AOAM531qTrbF6cSAS3M6kzRBOcumRZ8EezMC3exObgFjmJ2ClX01Zz0l
        u9Y+CGn9th174MZMPnLkMo1A5oHl3LRCZBT3
X-Google-Smtp-Source: ABdhPJzlj6WhlOOW9qmB8onlQwlWiD/Ejx99i9RM2YVhF+dpyaVYOxXQA8UWKS+YVr80s/c5q77fVg==
X-Received: by 2002:a63:35c1:0:b0:386:3620:3c80 with SMTP id c184-20020a6335c1000000b0038636203c80mr25577283pga.327.1649672529329;
        Mon, 11 Apr 2022 03:22:09 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:4376:c658:ae1e:1781])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a170e00b001cb7e69ee5csm4886318pjd.54.2022.04.11.03.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:22:09 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 4/7] staging: r8188eu: drop unnecessary wrapper _rtw_init_mlme_priv
Date:   Mon, 11 Apr 2022 15:51:33 +0530
Message-Id: <20220411102136.14937-5-makvihas@gmail.com>
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

Drop unnecessary wrapper _rtw_init_mlme_priv and move its logic to
_rtw_init_mlme_priv.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 103 +++++++++++-------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c90f36dee..6b8c80fe9 100644
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
@@ -290,9 +236,54 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 
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


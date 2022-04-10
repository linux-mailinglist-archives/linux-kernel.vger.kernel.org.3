Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8264FAEED
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 18:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbiDJQeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243625AbiDJQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:34:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7370165B1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:09 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s8so12536623pfk.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 09:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1U7ig0yIYDqqdZdu4wVkYgw4NSUR1m80doAifHbSXg=;
        b=gVpK4lNxM7SmpfWWIq6ooT0wacd8j3RXrqoxFe8fhV0ureF9rZCnTWPLKZSKvZpiPO
         rlg+OUiCIEDO/lJRs95bKzafvIH6lTy+S8WB9dZcykiZ0jrUCBDEitQ5AXEvXpPtZbWR
         rZ7s3VH3O239WHcSmi5TOqN4U2J3ppVHi9LjYWkHPKBDCh4hJpQk8+/bOBP9lAPCwnK9
         oh4lhM1wdxpryANakPH3swYUH6fI1n52GsXI6EEdHZ8Rcwn+wDgh1OzG72bkc5pYh336
         a67AgupEomzdrRyBLksE6+DcyrssQQ8D6HqiJP4Vd3GfxEL4pe90Z3cbFJ+AEVcf4e5H
         TMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1U7ig0yIYDqqdZdu4wVkYgw4NSUR1m80doAifHbSXg=;
        b=efUVN8xJK6GCLR8EC1cKivhuxj4VLm51ePqj3kgv6fQLdtSAjA9Oryo79WMn5bafyo
         5R1Jb5PsGerWodz/aaJmFr8qB/FEIxBDE3qISFpOWh8WjLx+cvoInIyizOkqeObdTX+z
         L52JiasqQUZOi6hWpckNpfOErl1/Z5NfWfh1c8kNW1k1ahelPFMpmho9CipQO+J8Bzk2
         S3ShlxWVegh+vmPdmSgohZhN8dJ077f53NsXhqmvk6bmUPJZFFSX+QhcGRSHohK4ATWl
         cZVrNsqpdcLGY1PzCGBGfDrcVAIAuUK3+HQ3Qv3bF1SH+nb5GOkN3BBoteK7VNXKxRlD
         P5Qw==
X-Gm-Message-State: AOAM530WG12gGiqsl6Ck5K7DhQlqi/s3CDY+/7t4oaAKNz5OGnE0Qnmv
        knPErHFuxFSBAk8I488gUcw=
X-Google-Smtp-Source: ABdhPJz4eUGNhq0nhWYowhDapkqRvXBafHMP7p7w4C4Eq0u7PXK4HDz8GAdi1GmOQe5VQmH2f69Sow==
X-Received: by 2002:a05:6a00:238f:b0:4f6:b09a:4c63 with SMTP id f15-20020a056a00238f00b004f6b09a4c63mr29014047pfc.35.1649608329324;
        Sun, 10 Apr 2022 09:32:09 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:606b:10e4:2085:6825])
        by smtp.gmail.com with ESMTPSA id f12-20020a056a001acc00b004fb37ecc6b2sm31940021pfv.29.2022.04.10.09.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 09:32:09 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 6/6] staging: r8188eu: drop unnecessary wrapper rtw_free_mlme_priv
Date:   Sun, 10 Apr 2022 22:01:17 +0530
Message-Id: <20220410163117.3964-7-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410163117.3964-1-makvihas@gmail.com>
References: <20220410163117.3964-1-makvihas@gmail.com>
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

Remove the unnecessary wrapper. Drop rtw_free_mlme_priv and use 
_rtw_free_mlme_priv instead.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c    | 5 -----
 drivers/staging/r8188eu/include/rtw_mlme.h | 1 -
 drivers/staging/r8188eu/os_dep/os_intfs.c  | 4 ++--
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f2a61c162..c09a565b4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -288,11 +288,6 @@ u8 *rtw_get_beacon_interval_from_ie(u8 *ie)
 	return ie + 8;
 }
 
-void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
-{
-	_rtw_free_mlme_priv(pmlmepriv);
-}
-
 static struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
 {
 	struct	wlan_network	*pnetwork;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index b5b1a0e10..4055a15e2 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -439,7 +439,6 @@ void rtw_join_timeout_handler (struct timer_list *t);
 void _rtw_scan_timeout_handler (struct timer_list *t);
 void rtw_free_network_queue(struct adapter *adapter, u8 isfreeall);
 int _rtw_init_mlme_priv(struct adapter *adapter);
-void rtw_free_mlme_priv (struct mlme_priv *pmlmepriv);
 int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv);
 int rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv,
 		int keyid, u8 set_tx);
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 448ea9533..adfc1e763 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -528,7 +528,7 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 free_mlme_ext:
 	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
-	rtw_free_mlme_priv(&padapter->mlmepriv);
+	_rtw_free_mlme_priv(&padapter->mlmepriv);
 
 free_evt_priv:
 	rtw_free_evt_priv(&padapter->evtpriv);
@@ -576,7 +576,7 @@ u8 rtw_free_drv_sw(struct adapter *padapter)
 
 	rtw_free_evt_priv(&padapter->evtpriv);
 
-	rtw_free_mlme_priv(&padapter->mlmepriv);
+	_rtw_free_mlme_priv(&padapter->mlmepriv);
 	_rtw_free_xmit_priv(&padapter->xmitpriv);
 
 	_rtw_free_sta_priv(&padapter->stapriv); /* will free bcmc_stainfo here */
-- 
2.30.2


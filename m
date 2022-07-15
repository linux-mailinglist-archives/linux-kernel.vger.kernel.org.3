Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FB0575B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiGOG3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbiGOG3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:29:19 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B694513F86
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r18so5034835edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2O/uYRshHQMHbYI/vornb8qnNhKEQ6GUPb1j3U9RmRc=;
        b=JqtQ96+vZsYrvnsILvvlOXUm1ha7+djdjKnUrDYm5ik2k+DyTbB4ZF1DSeeiaMx92f
         Ly9KrVsxE/ZRY8D17j3CRUmS5Hk0XpgqkHTVi1OyNh/yrhotEq88m1YKNyoApbFgbHMQ
         a7q/VUgrn3tUxVAhnlJ+Pk5ECgf6WrM8APoJHAHMVFgqQVRWDBn0y6QspKTKEd6UFldm
         oQ8drVOD2YmDfA56YwdOtMtue2DrkHC/uQpWNJ3qS5GwV8ynBxmQo6+jXn5SxYSe/EH9
         aBn+eXcmaIOwNngZxBtatrD+ch3WNKi4sSsNmRULM/EbeYBTox5rV9TNjGr1ESAOmLxU
         Ee1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2O/uYRshHQMHbYI/vornb8qnNhKEQ6GUPb1j3U9RmRc=;
        b=o0yB2/bSivd0oS2sYEKvIyzWkcDWqKAufcP004uGfSEvEO6mMf7vsJkvaEmvQp5V+9
         315KNtSkDltXtHsGRLZgFTnIWM0bk242C91HRPFRub2OQBHDy6Letk7ArEze9rCbDpyl
         m7bPvxihZn+PjUjVpgtrqNzMbayK81QMY5x3YBLvdPGjYY9C7tJrmTfiyuR9Ux3m99jn
         yTPbdW+P33PusjleivT+fCyKootpYezcvpxARza0vVlOVOItbIXA/p+T/bAkdUNtWwON
         X8jMRsh7SlsS4vnqe0JNPN9VKh6dbj9uPqdVg1O+9LpMqTJAQjc6ll0ECUcjE2evxwY9
         GsuQ==
X-Gm-Message-State: AJIora/5TrHXA4gN2/bVg+SXG3HfP8VW9fLjwR7V81jxiOmW/iku0XBj
        Z8Eya/4+h2BSGPPJ8f2kkmc=
X-Google-Smtp-Source: AGRyM1vL189/RM+6v4C21HG4ijWVy7NJ/WsAgm4+y1rD46JsLNH2Iqax5L0J8Q0UXPXR9bIYg4J50g==
X-Received: by 2002:aa7:c650:0:b0:43a:2c9a:fd1f with SMTP id z16-20020aa7c650000000b0043a2c9afd1fmr16814000edr.318.1657866557369;
        Thu, 14 Jul 2022 23:29:17 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb91.dynamic.kabel-deutschland.de. [95.90.187.145])
        by smtp.gmail.com with ESMTPSA id ku5-20020a170907788500b007262a5e2204sm1614515ejc.153.2022.07.14.23.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 23:29:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove unused parameter from update_TSF()
Date:   Fri, 15 Jul 2022 08:29:06 +0200
Message-Id: <20220715062908.8547-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715062908.8547-1-straube.linux@gmail.com>
References: <20220715062908.8547-1-straube.linux@gmail.com>
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

The parameter 'len' of update_TSF() is unused. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c    | 4 ++--
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 985cb3b4ba30..c23be5d9eaaf 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -582,7 +582,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 			pmlmeinfo->assoc_AP_vendor = check_assoc_AP(pframe + sizeof(struct ieee80211_hdr_3addr), len - sizeof(struct ieee80211_hdr_3addr));
 
 			/* update TSF Value */
-			update_TSF(pmlmeext, pframe, len);
+			update_TSF(pmlmeext, pframe);
 
 			/* start auth */
 			start_clnt_auth(padapter);
@@ -625,7 +625,7 @@ unsigned int OnBeacon(struct adapter *padapter, struct recv_frame *precv_frame)
 				}
 
 				/* update TSF Value */
-				update_TSF(pmlmeext, pframe, len);
+				update_TSF(pmlmeext, pframe);
 
 				/* report sta add event */
 				report_add_sta_event(padapter, GetAddr2Ptr(pframe), cam_idx);
diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 7b705e2ea04a..9e920a320d71 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1571,7 +1571,7 @@ int update_sta_support_rate(struct adapter *padapter, u8 *pvar_ie, uint var_ie_l
 	return _SUCCESS;
 }
 
-void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len)
+void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe)
 {
 	u8 *pIE;
 	__le32 *pbuf;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 2110affc180f..54384b4c6b1a 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -596,7 +596,7 @@ void addba_timer_hdl(struct sta_info *psta);
 bool cckrates_included(unsigned char *rate, int ratelen);
 bool cckratesonly_included(unsigned char *rate, int ratelen);
 
-void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe, uint len);
+void update_TSF(struct mlme_ext_priv *pmlmeext, u8 *pframe);
 void correct_TSF(struct adapter *padapter);
 
 struct cmd_hdl {
-- 
2.37.0


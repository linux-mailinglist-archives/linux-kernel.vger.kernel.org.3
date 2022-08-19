Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39A4599C58
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbiHSMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349248AbiHSMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:54 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1E1D0EC
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id a22so5545947edj.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yyOz/wz9iFnuktDnmIg37pL//Hn26j/SMMCZDt4cX44=;
        b=mUD5vF9s6EowiuWQlcNrvyob52ML+8/CwuHe2GyqVRaVy978B3Prgv9D7XLQajVdoj
         bh1lC+5Cq+EPB1hBGxDOCnJTN4bGQLgNXGiP/7gDyMgdCWBmeTY7XA+RtohpGSMuP2iL
         5EK8ACZ9taMNpLeqD2BkqkeTLBtkJzpWg/t10gAUiFEnZleEf0ZLtcwVkQl9i/reFPOL
         PstlgsrCPYs389Az03Tn5/HRmprMxk4Huo01BgqTtu+orWIH7kMTzNfABFHjZtuJN2p1
         btlg22zfGsdvnAlNFLe3DVDBXBbFyLkJ83OgIoZCELAAP7Ikr+pMsnc9NODTgXTA9xzD
         SmJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yyOz/wz9iFnuktDnmIg37pL//Hn26j/SMMCZDt4cX44=;
        b=TpE4zyv0qUueEXErBCqwZfFUntWp4/Le3h5DIhuPZhxgds1swSdllKQf/Xh9lil4qj
         e4kxK+IQyeD8CvfE3iE2gt272wt4/EOzM3GpDiAtbicVTaMUngzXqFoNABrjUZHJ7wJa
         NCXNBfszkz4mvDZkqWa32R9vVSUFgPcjzddpB1eQxLfBLDxbgps7ZEoagn+Pl3TjuNXz
         jXPurO1qq+3GBzYItp0OqUCZESqv+JhYT4fy2YZVU8YzBpd1msbf1ofMOW0W4kPYrbDB
         JMOZbcqSFzGhWurw8B2b9+i6AgcPgXNOcEOIkzyIDThCGxUHFqWq0UdHLmG/K9+IMXHn
         EseA==
X-Gm-Message-State: ACgBeo3+DGsdexgG3hr2JycpqEBf7TfGKvH74C60EA04KNjByAo4luja
        I5D6gzEVSfX+wV4TSsq2FU1bEfsdaRA=
X-Google-Smtp-Source: AA6agR5mLeaXTWb3gHpI5s3OBuGr2Z+OBYDfL89LkUYEZEoyg8fxykAnWDpyOUmmhYtK5Lsb5YsUuA==
X-Received: by 2002:a05:6402:43c8:b0:445:d773:c1ac with SMTP id p8-20020a05640243c800b00445d773c1acmr6191269edc.309.1660913680312;
        Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/11] staging: r8188eu: make init_addba_retry_timer() static
Date:   Fri, 19 Aug 2022 14:54:19 +0200
Message-Id: <20220819125428.8412-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

The function init_addba_retry_timer() is only used in rtw_sta_mgt.c.
Make it static to get one step closer to removing os_dep/mlme_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_sta_mgt.c     | 12 ++++++++++++
 drivers/staging/r8188eu/include/rtw_mlme_ext.h |  1 -
 drivers/staging/r8188eu/os_dep/mlme_linux.c    | 11 -----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index bbc1ef146826..2b58e11896b4 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -154,6 +154,18 @@ static void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
 	timer_setup(&preorder_ctrl->reordering_ctrl_timer, _rtw_reordering_ctrl_timeout_handler, 0);
 }
 
+static void _addba_timer_hdl(struct timer_list *t)
+{
+	struct sta_info *psta = from_timer(psta, t, addba_retry_timer);
+
+	addba_timer_hdl(psta);
+}
+
+static void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
+{
+	timer_setup(&psta->addba_retry_timer, _addba_timer_hdl, 0);
+}
+
 struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
 	s32	index;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index a6b1b1b7da74..e092e646c0d2 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -388,7 +388,6 @@ struct mlme_ext_priv {
 void init_mlme_ext_priv(struct adapter *adapter);
 int init_hw_mlme_ext(struct adapter *padapter);
 void free_mlme_ext_priv (struct mlme_ext_priv *pmlmeext);
-extern void init_addba_retry_timer(struct adapter *adapt, struct sta_info *sta);
 extern struct xmit_frame *alloc_mgtxmitframe(struct xmit_priv *pxmitpriv);
 
 unsigned char networktype_to_raid(unsigned char network_type);
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index bc4f979280b6..b8d328d74443 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -130,17 +130,6 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	}
 }
 
-static void _addba_timer_hdl(struct timer_list *t)
-{
-	struct sta_info *psta = from_timer(psta, t, addba_retry_timer);
-	addba_timer_hdl(psta);
-}
-
-void init_addba_retry_timer(struct adapter *padapter, struct sta_info *psta)
-{
-	timer_setup(&psta->addba_retry_timer, _addba_timer_hdl, 0);
-}
-
 void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *psta)
 {
 	union iwreq_data wrqu;
-- 
2.37.1


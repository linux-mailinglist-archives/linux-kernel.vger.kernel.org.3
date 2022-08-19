Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8AE599C55
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349281AbiHSMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349249AbiHSMyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3025479EFF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so5523960edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j4QGnRyzHDovtaBxZPEWBkKgdde1TdzHuU7Yr5hTj8c=;
        b=Xdj5glg+xd7AN0WjRq9Trdclbq8A70/xKUMpZi9cgzem0ODywscgUdn0Va2uAMWyd1
         Jyzcl7YD3IDc+UddBCmxxiRIy2AGJteG6DHVGDdxLwfvVRvKYH/ekTOJ3mGBVZqJsyoF
         HhCwJ0U3UkrRi+CAZL01lA5mThkxp8y676qjWilwwJvTerL2IqTVyzvjfHRxSKxup1hf
         dv9CYSgdP3DrBNCmkaqVLyUyZR1OwHznIoAi7b9Gn22k+D6qnQiKA8GFrRoaln9bBSMx
         s+ldhTY9S7GZUt58sxMCtuUTs5o/IVom+nKjzh4nANORCEeBHeZpWLMyEwfjjsLuHKWZ
         gPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j4QGnRyzHDovtaBxZPEWBkKgdde1TdzHuU7Yr5hTj8c=;
        b=Nu4LkfEUGrCZ406XIOx/z7ZBiXjQbqL/3p3faG1gadbD1dF4ql1N+PBmWRTIKW3LkD
         C8Z+Vn8KLuigfrAqRxrbUJxhLLrj3kp/RZ/t8SAYk0MsCE16S/b8c1NMmSsX4Puxt/eG
         dCXV2P25T4TQ/x8TIcf/S4Pp1jRO399bph6Jpz5K5Zd67QhL55ZhPmuWzhkWZ2nxls3+
         39YR3JBQ1h2ZBKgoBkGZ3ZBwbFtAdlQ286eVSalmKhvM6+1tFgHLN5tHWW7Dcg1EL/Vf
         nM4LBMZwXzH681W4mEFeQcLLsK5B/d79PjTu/42sSJbBmn2FXtRhATLf6Rw+Dw7Q39rZ
         r+Qg==
X-Gm-Message-State: ACgBeo3HXkFtEsU3xa6LIrfWT2n2RrdGVqnIoJJYv1mBBQ6nKE4pbzZP
        +VosMdaV9/RhgRhVI1RxHyw=
X-Google-Smtp-Source: AA6agR7oe3y8ZlmtQk2OJYZcO2nX7HU/tAAuNgGvI9ayZMexHbkgYfjTtyOCIkCaFhbOfbQb83WgUQ==
X-Received: by 2002:a05:6402:3881:b0:445:f8bf:5a1c with SMTP id fd1-20020a056402388100b00445f8bf5a1cmr6086214edb.13.1660913680883;
        Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/11] staging: r8188eu: make rtw_indicate_sta_disassoc_event() static
Date:   Fri, 19 Aug 2022 14:54:20 +0200
Message-Id: <20220819125428.8412-4-straube.linux@gmail.com>
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

The function rtw_indicate_sta_disassoc_event() is only used in
rtw_ap.c. Make it static to get one step closer to removing
os_dep/mlme_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c       | 21 +++++++++++++++++++++
 drivers/staging/r8188eu/include/rtw_ap.h    |  2 --
 drivers/staging/r8188eu/os_dep/mlme_linux.c | 21 ---------------------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 5bd9dfa57cc5..a567683c21fd 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -935,6 +935,27 @@ u8 bss_cap_update_on_sta_leave(struct adapter *padapter, struct sta_info *psta)
 	return beacon_updated;
 }
 
+static void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *psta)
+{
+	union iwreq_data wrqu;
+	struct sta_priv *pstapriv = &padapter->stapriv;
+
+	if (!psta)
+		return;
+
+	if (psta->aid > NUM_STA)
+		return;
+
+	if (pstapriv->sta_aid[psta->aid - 1] != psta)
+		return;
+
+	wrqu.addr.sa_family = ARPHRD_ETHER;
+
+	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
+
+	wireless_send_event(padapter->pnetdev, IWEVEXPIRED, &wrqu, NULL);
+}
+
 u8 ap_free_sta(struct adapter *padapter, struct sta_info *psta,
 	       bool active, u16 reason)
 {
diff --git a/drivers/staging/r8188eu/include/rtw_ap.h b/drivers/staging/r8188eu/include/rtw_ap.h
index 724229fe84aa..8b4134eb3095 100644
--- a/drivers/staging/r8188eu/include/rtw_ap.h
+++ b/drivers/staging/r8188eu/include/rtw_ap.h
@@ -10,8 +10,6 @@
 /* external function */
 void rtw_indicate_sta_assoc_event(struct adapter *padapter,
 				  struct sta_info *psta);
-void rtw_indicate_sta_disassoc_event(struct adapter *padapter,
-				     struct sta_info *psta);
 void init_mlme_ap_info(struct adapter *padapter);
 void free_mlme_ap_info(struct adapter *padapter);
 void update_beacon(struct adapter *padapter, u8 ie_id,
diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index b8d328d74443..ad5f795f6857 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -150,24 +150,3 @@ void rtw_indicate_sta_assoc_event(struct adapter *padapter, struct sta_info *pst
 
 	wireless_send_event(padapter->pnetdev, IWEVREGISTERED, &wrqu, NULL);
 }
-
-void rtw_indicate_sta_disassoc_event(struct adapter *padapter, struct sta_info *psta)
-{
-	union iwreq_data wrqu;
-	struct sta_priv *pstapriv = &padapter->stapriv;
-
-	if (!psta)
-		return;
-
-	if (psta->aid > NUM_STA)
-		return;
-
-	if (pstapriv->sta_aid[psta->aid - 1] != psta)
-		return;
-
-	wrqu.addr.sa_family = ARPHRD_ETHER;
-
-	memcpy(wrqu.addr.sa_data, psta->hwaddr, ETH_ALEN);
-
-	wireless_send_event(padapter->pnetdev, IWEVEXPIRED, &wrqu, NULL);
-}
-- 
2.37.1


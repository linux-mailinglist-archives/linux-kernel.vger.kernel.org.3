Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC959AF7C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiHTSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiHTSQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACDD17071
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c39so9160846edf.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h/sCmXVMZBCUJ8u5FcgfwSBgIpf0Du8Mi+DP75rSeIc=;
        b=HdabqiFeZaWjRT/jZcFmoOTy7I598cwDfZNRc7VXO4LptdQ9upQfJLqtNFIHo3kOGC
         BSkQGBmyvX8AjDm0oPwJIw+/Zfv/VJ77vopF2gzy8ZIBk4XMZqlv/m0pcl6lml+XilUf
         lToouyDvDS6vYvAwf4YllZS5mE0uhGxPngcHvgJ8UEAoa/gBngwzESq9+YHu2jrnXYJS
         h95eQXncEA6RZXB6rGpzopL8bo6TrDQe60okp4rhUcXIQgNkgvcq823m0YkywnFnRE+6
         UdWg45kmSRmX5BqvXHR6xZZ7Zwlm8l3wjxMRYx0lCffkBKb1jra3+fDhEvDKagRNB4lF
         1Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h/sCmXVMZBCUJ8u5FcgfwSBgIpf0Du8Mi+DP75rSeIc=;
        b=Hw0S0LQv0iscvS1QbjS0I6mI2soE5XpVpmviHItSvEjI7u9izRVkoi3BuWCOlccUzx
         isEZtsv47DCPq1e/SIeByZ7wFmeQwOI65uXMQHH+avtajltiKADIHHY1X0FbVqOktFtS
         lpvYfCkrPfI1qeldF1eRUMl1LGvPNoKFdkSa9HfJ96xdTlK6N1IbnuI8L9mIG4CAIkvW
         ue4nj4CcbYbfYTKQ9sayZiP0VT71kXqTX4GIE1ORh1nj0ynEMmh83suU0JdvUXBEGNab
         6XLu13lwjW4WiYveR+z351f3IYt699Ya7MTd9Wdb0W/cMWsu1uMZNMFA2TQi6Y/5lGC0
         0DLg==
X-Gm-Message-State: ACgBeo39hDom4MxMfm2MeCzugGv4PnjyNyu1WEETN6i2rGGZdyLNYxiH
        EdxwK1cws4N/VACdHb609ag=
X-Google-Smtp-Source: AA6agR7iObdlp02vy9+GZYF1PD3OTrPVPO56UxS0IZdwOtJL3qK2LFnX1OOWBTE8Lz0k+OOMQwZcJA==
X-Received: by 2002:a05:6402:440f:b0:435:2e63:aca9 with SMTP id y15-20020a056402440f00b004352e63aca9mr10005474eda.162.1661019397578;
        Sat, 20 Aug 2022 11:16:37 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:37 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/19] staging: r8188eu: make rtw_os_xmit_schedule() static
Date:   Sat, 20 Aug 2022 20:16:06 +0200
Message-Id: <20220820181623.12497-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
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

The function rtw_os_xmit_schedule() is only used in rtw_mlme.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 17 +++++++++++++++++
 drivers/staging/r8188eu/include/xmit_osdep.h |  2 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 17 -----------------
 3 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index e3cf3e8962fb..c7f69f7918b8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -641,6 +641,23 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 	spin_unlock_bh(&pmlmepriv->lock);
 }
 
+static void rtw_os_xmit_schedule(struct adapter *padapter)
+{
+	struct xmit_priv *pxmitpriv;
+
+	if (!padapter)
+		return;
+
+	pxmitpriv = &padapter->xmitpriv;
+
+	spin_lock_bh(&pxmitpriv->lock);
+
+	if (rtw_txframes_pending(padapter))
+		tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
+
+	spin_unlock_bh(&pxmitpriv->lock);
+}
+
 void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 {
 	struct	mlme_priv *pmlmepriv = &adapter->mlmepriv;
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 55347de455c8..5a09355a142a 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -30,8 +30,6 @@ struct xmit_buf;
 
 int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
-void rtw_os_xmit_schedule(struct adapter *padapter);
-
 int rtw_os_xmit_resource_alloc(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 alloc_sz);
 void rtw_os_xmit_resource_free(struct adapter *padapter,
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 33400a9b08e1..9759ff5ea76d 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -105,23 +105,6 @@ void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
 	pxframe->pkt = NULL;
 }
 
-void rtw_os_xmit_schedule(struct adapter *padapter)
-{
-	struct xmit_priv *pxmitpriv;
-
-	if (!padapter)
-		return;
-
-	pxmitpriv = &padapter->xmitpriv;
-
-	spin_lock_bh(&pxmitpriv->lock);
-
-	if (rtw_txframes_pending(padapter))
-		tasklet_hi_schedule(&pxmitpriv->xmit_tasklet);
-
-	spin_unlock_bh(&pxmitpriv->lock);
-}
-
 static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pkt)
 {
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-- 
2.37.2


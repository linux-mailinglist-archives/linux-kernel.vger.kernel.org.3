Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A8259AF8A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbiHTSQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiHTSQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A12C3122E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:40 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z20so9104205edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PDPIVySPMRGRZRtU+MncznrTlB37IpX4cguK3flnXUA=;
        b=W6DOBFk9VRRaDkpOdo1jv6Hln3uFH5V6mWgZ2gRGnIL3XyaS+XbCDih+xoOeIcVBuF
         zXUuymTgdqlQgfUIHsEbKsdks5120TOf3FFwrAMS5Y8uzZYMootTTKnlamQMQDnq1iux
         YgDuMvwbebdCZjDGtWyqlvEgZtAkWwmeNu0H4x1qc/z7o9E27oQ7NNtopGCeWSdSFypi
         OcWTztYmz/W3dF9LL3U40ZJVDlo24viwujT/jOgiivm5qn4AfJPPyTL82QrCjqyZJPi4
         NtCXr4ug9d1qHfa8Tsdv9JAIPbePoqWT8JvxTlgvYK6hbIZCZM2Uu7Egoz2AnyKwUZMc
         Xagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PDPIVySPMRGRZRtU+MncznrTlB37IpX4cguK3flnXUA=;
        b=U/1m5CFDGhccTcuzRtNSpDfQsiw9P0erHautmosxPEnjiiLZKYKj7q1At6hh8fq5zQ
         D7HUUohHfLEWxovcSdS7KcqImYLyQLZcpBbJwTygaZhNtE5mewdPOhqUkTJXcu2enCMj
         q8qLugHOZdPsNYFW2M+jrsDvxu+ZhF3CJiw8L1nHMu/WZmpUptAixP+80bYk0CJ49mLU
         NQ7bZMasbQOuPGlKO1ybS+Zste7314o4lejrg6Pw1UHd53gKO+OhHjtYCcvGrZzDeMJs
         BMG3oVjwFVtTbESTbIziUC8RcUPadJgUjfZLLf7ry6FbmBzXKJFrixgMOnKvkLa1N1HJ
         UGIw==
X-Gm-Message-State: ACgBeo1ZKb4/cdrXQkGSeD1MsgtuWqpInW6GGtYy+Oo4nAwqLlnr3LGF
        +8G0+OtdTemf+bm11AxwzYw=
X-Google-Smtp-Source: AA6agR51CtFX/BfnsCvvr23jdZ8g508/rK5R9ppuxFwdC6mgQpmJtKQDHeakSfVfJhoNw1s2fv1meg==
X-Received: by 2002:a05:6402:424f:b0:43e:6d89:4316 with SMTP id g15-20020a056402424f00b0043e6d894316mr10190158edb.408.1661019398953;
        Sat, 20 Aug 2022 11:16:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/19] staging: r8188eu: make rtw_os_xmit_resource_alloc() static
Date:   Sat, 20 Aug 2022 20:16:08 +0200
Message-Id: <20220820181623.12497-5-straube.linux@gmail.com>
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

The function rtw_os_xmit_resource_alloc() is only used in rtw_xmit.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 17 +++++++++++++++++
 drivers/staging/r8188eu/include/xmit_osdep.h |  2 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 16 ----------------
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 48631ef56114..6f3a70a1ab3c 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -33,6 +33,23 @@ void	_rtw_init_sta_xmit_priv(struct sta_xmit_priv *psta_xmitpriv)
 	INIT_LIST_HEAD(&psta_xmitpriv->apsd);
 }
 
+static int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf,
+				      u32 alloc_sz)
+{
+	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
+	if (!pxmitbuf->pallocated_buf)
+		return _FAIL;
+
+	pxmitbuf->pbuf = (u8 *)ALIGN((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
+	pxmitbuf->dma_transfer_addr = 0;
+
+	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!pxmitbuf->pxmit_urb)
+		return _FAIL;
+
+	return _SUCCESS;
+}
+
 s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 {
 	int i;
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 5a09355a142a..82b47b38bafd 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -30,8 +30,6 @@ struct xmit_buf;
 
 int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
-int rtw_os_xmit_resource_alloc(struct adapter *padapter,
-			       struct xmit_buf *pxmitbuf, u32 alloc_sz);
 void rtw_os_xmit_resource_free(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 free_sz);
 
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 9759ff5ea76d..fdecb5e1a784 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -54,22 +54,6 @@ uint _rtw_pktfile_read(struct pkt_file *pfile, u8 *rmem, uint rlen)
 	return len;
 }
 
-int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
-{
-	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
-	if (!pxmitbuf->pallocated_buf)
-		return _FAIL;
-
-	pxmitbuf->pbuf = (u8 *)ALIGN((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
-	pxmitbuf->dma_transfer_addr = 0;
-
-	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxmitbuf->pxmit_urb)
-		return _FAIL;
-
-	return _SUCCESS;
-}
-
 void rtw_os_xmit_resource_free(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 free_sz)
 {
-- 
2.37.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7C504859
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbiDQQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiDQQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 12:39:51 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2D3668A
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:37:15 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p10so21067212lfa.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlNjJfVDWOsy0TP9UEQoWOwdHbve0Jr5Wwvo5wkDRX8=;
        b=mbQt9dPkb+Euu4Tz7uUwlrdfIIjkZ0X1pTYkSuWlyDAbIwoj3iBfUAK6pfGUpf/ny6
         X2c8UHHE+G4dwVOR6FFj1z1qndOER22p1QAbVwjJJ9Z9/CkffyOnMahH0K1SIyjfmsnV
         LLkyFFwAO/Hl2mR9IdIlwEBFXWc+GZe+uMXGdjjotjJUTKYehcSJdAYElUXK395sQhXO
         +LfdVLfk30NNLLULlYUcdug3VRwwAvMhD4bREHL+p0uN1OOurSNja19GA3gQQATevema
         59XU5v3zdP12DPUQgCWmnZ/aV76m7ldfJSanY+RdSKcwGJD7wbcmQtlAvXgeSBQ0+KXI
         Dizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nlNjJfVDWOsy0TP9UEQoWOwdHbve0Jr5Wwvo5wkDRX8=;
        b=6eCqROsOGiuA8Uwb6wO2CyQv+RYpajL9OrLtmtiHiPfupBxzw3p9tmXTuoGEVdnAFf
         WCbSKvaXl8mYVcHk8SiJEbPXPXrMTBRWFYGOWtT3/SQXExQMKMvjFdmLxBU/nSKwzyTO
         crmtFh3lcovn4qNvyKAvXAExQ3L0ufyzIv2wAy93EPm0mtg8WApzs46GrAIDWMNre61a
         FKmFRlV50yz/icKgLy2QTR4wjiHT2thNxBFS6x7gQxrD6PZ4bKFK4sGife6UWA8VjZDL
         eiiHdXlVMs+dl6UNghcla5qPgnKeJSdxfuLikPcdZlD30iQkrhAOMJjIcAzdBvEMxiYJ
         Kazw==
X-Gm-Message-State: AOAM533w/HcJ1NK2MW0UOSiUdbC54EkuLC+fUJd3lx3RqA33VtgBumIR
        +E8ETyBa/WXXKD/3EcoHmtQ=
X-Google-Smtp-Source: ABdhPJwsJSpHa4WQtA8BOw9LsclrZXACQKL0w+C5347rniHR98jWepUqrp3Bw6RLFZLHjkd0t7M8Hw==
X-Received: by 2002:a05:6512:3995:b0:44a:e5c8:e696 with SMTP id j21-20020a056512399500b0044ae5c8e696mr5344661lfu.539.1650213433512;
        Sun, 17 Apr 2022 09:37:13 -0700 (PDT)
Received: from alpha ([31.134.188.37])
        by smtp.gmail.com with ESMTPSA id n10-20020a196f4a000000b0046c24985b33sm976997lfk.208.2022.04.17.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 09:37:12 -0700 (PDT)
Received: (nullmailer pid 42936 invoked by uid 1000);
        Sun, 17 Apr 2022 16:37:12 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] r8188eu: remove unused urbs from struct xmit_buf
Date:   Sun, 17 Apr 2022 19:36:08 +0300
Message-Id: <20220417163608.42917-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Driver allocates eighth urbs per xmit_buf, but uses only first urb.
Allocation of seven remaining urbs wastes memory for nothing.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_xmit.h     |  2 +-
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 16 ++++++----------
 drivers/staging/r8188eu/os_dep/xmit_linux.c    | 16 +++++-----------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b2df1480d66b..54c2bdf68acc 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -198,7 +198,7 @@ struct xmit_buf {
 	u32  len;
 	struct submit_ctx *sctx;
 	u32	ff_hwaddr;
-	struct urb *pxmit_urb[8];
+	struct urb *pxmit_urb;
 	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
 	u8 bpending[8];
 	int last[8];
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 8ca16861bfcc..0269e602b217 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -140,7 +140,7 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 
 	spin_unlock_irqrestore(&pxmitpriv->lock, irqL);
 
-	purb	= pxmitbuf->pxmit_urb[0];
+	purb	= pxmitbuf->pxmit_urb;
 
 	/* translate DMA FIFO addr to pipehandle */
 	pipe = ffaddr2pipehdl(pdvobj, addr);
@@ -178,25 +178,21 @@ u32 rtw_write_port(struct adapter *padapter, u32 addr, u32 cnt, u8 *wmem)
 
 void rtw_write_port_cancel(struct adapter *padapter)
 {
-	int i, j;
+	int i;
 	struct xmit_buf *pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmitbuf;
 
 	padapter->bWritePortCancel = true;
 
 	for (i = 0; i < NR_XMITBUFF; i++) {
-		for (j = 0; j < 8; j++) {
-			if (pxmitbuf->pxmit_urb[j])
-				usb_kill_urb(pxmitbuf->pxmit_urb[j]);
-		}
+		if (pxmitbuf->pxmit_urb)
+			usb_kill_urb(pxmitbuf->pxmit_urb);
 		pxmitbuf++;
 	}
 
 	pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmit_extbuf;
 	for (i = 0; i < NR_XMIT_EXTBUFF; i++) {
-		for (j = 0; j < 8; j++) {
-			if (pxmitbuf->pxmit_urb[j])
-				usb_kill_urb(pxmitbuf->pxmit_urb[j]);
-		}
+		if (pxmitbuf->pxmit_urb)
+			usb_kill_urb(pxmitbuf->pxmit_urb);
 		pxmitbuf++;
 	}
 }
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index a6012cffd37e..e430c64e9068 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -67,8 +67,6 @@ bool rtw_endofpktfile(struct pkt_file *pfile)
 
 int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitbuf, u32 alloc_sz)
 {
-	int i;
-
 	pxmitbuf->pallocated_buf = kzalloc(alloc_sz, GFP_KERNEL);
 	if (!pxmitbuf->pallocated_buf)
 		return _FAIL;
@@ -76,21 +74,17 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 	pxmitbuf->pbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitbuf->pallocated_buf), XMITBUF_ALIGN_SZ);
 	pxmitbuf->dma_transfer_addr = 0;
 
-	for (i = 0; i < 8; i++) {
-		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i])
-			return _FAIL;
-	}
+	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!pxmitbuf->pxmit_urb)
+		return _FAIL;
+
 	return _SUCCESS;
 }
 
 void rtw_os_xmit_resource_free(struct adapter *padapter,
 			       struct xmit_buf *pxmitbuf, u32 free_sz)
 {
-	int i;
-
-	for (i = 0; i < 8; i++)
-		usb_free_urb(pxmitbuf->pxmit_urb[i]);
+	usb_free_urb(pxmitbuf->pxmit_urb);
 
 	kfree(pxmitbuf->pallocated_buf);
 }
-- 
2.35.1


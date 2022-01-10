Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE78E4894A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 10:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbiAJJCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 04:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242571AbiAJJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 04:00:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE7C0611FD
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r10so17678785wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 01:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AlKhIkC0Td2+80z6FQm+ECWH1t7QHBdMgOZBS6zGzEk=;
        b=2qnP41fGb+WzSRmkF6OwH+MhjDnRgf6fEWlID5vJDEJDG/hj3ETbkGEx2pLc/eTOOL
         6/nWbbcroXLXcBPjBNv+5BWZzyB7yo4GNwk+UXVzzBoSfWq2DFCTZqWFCO692zFuPOxQ
         i4JLJmFwiM2pKSc3ZyHFb5xqzClTXVrNXblWEibyJkD+ZKxxjn2V5RDWrjEJZSFwSjyp
         zvQaclnU6k30ZHc/Z7L5Qc/QKafnGtb6TuN4xDPEe5D7zTo26dZ6waqV93Ryn9/owKbW
         ALdaj0Bt17ZCmS5bvx0YK3kt1UjZ3hYIXYWlOsBwyloc2mgbXthsesNr+5cv6IYTiQ4W
         j+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AlKhIkC0Td2+80z6FQm+ECWH1t7QHBdMgOZBS6zGzEk=;
        b=1Fyc8jeazKQIiEidlMb+2qZrwXFix+bJyzosmAAiUU9c7tRzvQH/EFYDgNp//dEjqX
         OQX/rvXgaj8Pmb9TJfbcb9AuHKTm9cgCz2PJjTcrnoVWa99vKju0TRvMGrg7XT9iD4JB
         Zgy+g6bFf9XeVAZP/QSqjxY4ty7LNG7+MKf4YWYpqJz29Bjzk1aVgbB2CscizC02kIIT
         HNYr/exkFk4XneEY5R6B7pBAthyvFAsmI7guoriJxX/CD4qcF9JPw/aGAlKgZ7tsr6Y6
         NFzh0W/X6E6e+q0fOEfelvoe0x8uXrvzenyfln5xjo6/3wPnjBSXN9rV/W65AAXU8tP3
         hd7w==
X-Gm-Message-State: AOAM533aNPU/1GBkIqTxeECLtPYvEnB3tgCNcmqw7Furw/WyvfMiobj5
        Yd7gepL84RM+JjPhMIIzK8tWhg==
X-Google-Smtp-Source: ABdhPJyHXz3AbSq7Qav0CDPSTqC5kLLV09vkPamjvzc1SoSDctM0t8qaAwfcmALkYLEeUHSX1A8BLA==
X-Received: by 2002:adf:c74e:: with SMTP id b14mr30561540wrh.97.1641805223482;
        Mon, 10 Jan 2022 01:00:23 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m15sm6263287wmq.6.2022.01.10.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 01:00:23 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] staging: r8188eu: convert DBG_88E calls in core/rtw_xmit.c
Date:   Mon, 10 Jan 2022 09:00:15 +0000
Message-Id: <20220110090020.6800-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220110090020.6800-1-phil@philpotter.co.uk>
References: <20220110090020.6800-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DBG_88E macro calls in core/rtw_xmit.c to use pr_debug
or netdev_dbg appropriately, as their information may be useful to
observers, and this gets the driver closer to the point of being
able to remove DBG_88E itself. Also remove some commented out
DBG_88E calls altogether.

Some calls are at points in the call chain where use of dev_dbg or
netdev_dbg isn't possible due to lack of device pointer, so plain
pr_debug is appropriate here.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 30 ++++++++++++-------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 8503059edc46..334644e46000 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -372,7 +372,7 @@ u8	qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		DBG_88E("qos_acm(): invalid pattrib->priority: %d!!!\n", priority);
+		pr_debug("invalid pattrib->priority: %d!!!\n", priority);
 		break;
 	}
 
@@ -489,7 +489,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (psta) {
 		pattrib->mac_id = psta->mac_id;
-		/* DBG_88E("%s ==> mac_id(%d)\n", __func__, pattrib->mac_id); */
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
@@ -895,7 +894,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 		return _FAIL;
 
 	if (!pxmitframe->buf_addr) {
-		DBG_88E("==> %s buf_addr == NULL\n", __func__);
+		netdev_dbg(padapter->pnetdev, "buf_addr == NULL\n");
 		return _FAIL;
 	}
 
@@ -906,7 +905,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	mem_start = pbuf_start +	hw_hdr_offset;
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
-		DBG_88E("rtw_xmitframe_coalesce: rtw_make_wlanhdr fail; drop pkt\n");
+		netdev_dbg(padapter->pnetdev,
+			   "rtw_make_wlanhdr fail; drop pkt\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1003,7 +1003,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	}
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
-		DBG_88E("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
+		netdev_dbg(padapter->pnetdev,
+			   "xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1134,7 +1135,7 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		/* pxmitbuf->ext_tag = true; */
 
 		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+			pr_debug("pxmitbuf->sctx is not NULL\n");
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1171,8 +1172,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 	struct __queue *pfree_xmitbuf_queue = &pxmitpriv->free_xmitbuf_queue;
 	unsigned long flags;
 
-	/* DBG_88E("+rtw_alloc_xmitbuf\n"); */
-
 	spin_lock_irqsave(&pfree_xmitbuf_queue->lock, flags);
 
 	if (list_empty(&pfree_xmitbuf_queue->queue)) {
@@ -1191,7 +1190,7 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+			pr_debug("pxmitbuf->sctx is not NULL\n");
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1209,7 +1208,7 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 		return _FAIL;
 
 	if (pxmitbuf->sctx) {
-		DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+		pr_debug("pxmitbuf->sctx is not NULL\n");
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
 	}
 
@@ -1479,7 +1478,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		DBG_88E("rtw_xmit_classifier: psta == NULL\n");
+		netdev_dbg(padapter->pnetdev, "psta == NULL\n");
 		goto exit;
 	}
 
@@ -1725,7 +1724,8 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pxmitframe) {
-		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
+		netdev_dbg(padapter->pnetdev,
+			   "DBG_TX_DROP_FRAME no more pxmitframe\n");
 		return -1;
 	}
 
@@ -2150,7 +2150,7 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	if (!wait_for_completion_timeout(&sctx->done, expire)) {
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		DBG_88E("%s timeout\n", __func__);
+		pr_debug("timeout\n");
 	} else {
 		status = sctx->status;
 	}
@@ -2180,7 +2180,7 @@ void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
 		if (rtw_sctx_chk_waring_status(status))
-			DBG_88E("%s status:%d\n", __func__, status);
+			pr_debug("status:%d\n", status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2205,5 +2205,5 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
 	else
-		DBG_88E("%s ack_tx not set\n", __func__);
+		pr_debug("ack_tx not set\n");
 }
-- 
2.33.1


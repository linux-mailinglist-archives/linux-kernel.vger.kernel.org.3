Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E5D517DFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiECHE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiECHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:04:24 -0400
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E5186F8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561250;
        bh=5TH0OmWyiVh30wRzON7x4iOUaaFh2vLJws9w3+NmQ3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=N0Enpz2iWLPM6HK4bAEJDxN3pxNuTR+zOhAKkgJOiGWUel8eJO6WK/a5EmSxel+GJ
         lhHJsVv3BOA/zMnH9qa8U23kEz99am6QK1aCjq3xGixAJWFvS16Wb6boHJ44d+vrKx
         QZB4CzFPu2wa8s/M4xFf+Bxzry2K5qmhVOl1KeH4=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrszc11.qq.com (NewEsmtp) with SMTP
        id 3004083; Tue, 03 May 2022 15:00:48 +0800
X-QQ-mid: xmsmtpt1651561248tjo3g17xa
Message-ID: <tencent_7D7D384C285AC39D9414FF9D400E98C57209@qq.com>
X-QQ-XMAILINFO: NPwOoMPVnumVWBscUI2QQFEF9reB4ByidI4O5z0ljio542FmHd3oiSQ9vBrFvl
         fTOqDDuZjpHJkcdOWzRQXqmF6/vJm+ut5kUGf/GrS0oIk7gsV4Q1A1WoEN0VjX1ZTv6OhciAjBD2
         y5YtVmL54i/5YwChZuIGLbdaIAQ9Qmix0vLfP+9yoqiW9pSGmutu7uXtTuz/vQfDFB5JcmZEPkWE
         KOEjMZ8JvDYqKshFe9ceG9bmtR7fXNnHo4KSpFosAi5Ik8MCPAv2Kuj7dJW+amaiOEch5lna3RDC
         h0jdUl7+5K+g4hoBuKOYH3WzBD+SFP98oL5uF090bFjSVnBo94T7lARRsOyOcThCZvIrSFMj9VmV
         Y/gFsrDKEsmaHAisr+kxCmAhYBOmwuhl5ULhngQzNsRTvgPKphnzZN9zgQiHEdbQQSLd3wKHFXN9
         objFoVwzTyEiRuLZcRyh/DoqVZC8kVtmpMS2FykWcIFjUpmDV4BxSperNTI61v1CYPYB4tTzC6nY
         xrk1ArZiiwRaea+vRqbL+62naF2gTbwK8o16xWI6BdPqBGOjpQCsv5yBhXMM+ucIyrBgXZFXVd2J
         S8tzlJrRzUeQ+m+s1Lmn0y53hwRqo9Px6DZPMe3mJ/y79zadH6dxuwXLyj8tTKvmhZAsYQcYqw6t
         xvUkJFzaymhdkefgoJSG/smAj1Q7xPoBpsE8Wv3EUw12PbucUFZ4f0vKIq1mnI76vIziWOMxrtM7
         2cgVsqSf1+JCJC7etheS0FkyiovMB4/tbfYUvT/CSY56xMtqps/wmCcNShDek0PeIITCve2rmYgY
         GR5RcSYa1QbQK3I4uYW1yDSYy7UaE+k1V2knQndblVH3GRz4qZWraExyiKY+FMSuIgCq4tyB4ojb
         /lYG33KRgUWtMs8vtKgoxEy5NqdEFI6F761W5dSOvDuuAK/GBNCzSL1+EfNlatDeHl8KItrfAolx
         TcMIa+KePbxLcB9x2qe9VoY3gSSCMrIX2/ExS9yJrJbd8lM7tmpfdhzt3Bjb3h
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 07/12] staging: rtl8723bs: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Tue,  3 May 2022 15:00:38 +0800
X-OQ-MSGID: <20220503070038.3304-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In _rtw_init_xmit_priv(), there are seven error paths for allocation
failures without releasing the resources but directly goto `exit`, while
the exit section only executes `return res;`, which leads to various
memory leaks.

To properly release them, this patch unifies the error handlers of
_rtw_init_xmit_priv() and several error handling paths are added.
According to the allocation sequence, each error will jump to its
corresponding error handling tag.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 50 +++++++++++++++++------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index a225126..2d10fa9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_xmit.c
+++ b/drivers/staging/rtl8723bs/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -132,7 +132,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ), true);
 			if (res == _FAIL)
-				goto exit;
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->phead = pxmitbuf->pbuf;
@@ -162,7 +162,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	if (!pxmitpriv->xframe_ext_alloc_addr) {
 		pxmitpriv->xframe_ext = NULL;
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 	pxmitpriv->xframe_ext = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->xframe_ext_alloc_addr), 4);
 	pxframe = (struct xmit_frame *)pxmitpriv->xframe_ext;
@@ -195,7 +195,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xframe_ext;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((SIZE_PTR)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -210,10 +210,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->buf_tag = XMITBUF_MGNT;
 
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, MAX_XMIT_EXTBUF_SZ + XMITBUF_ALIGN_SZ, true);
-		if (res == _FAIL) {
-			res = _FAIL;
-			goto exit;
-		}
+		if (res == _FAIL)
+			goto free_xmit_extbuf;
 
 		pxmitbuf->phead = pxmitbuf->pbuf;
 		pxmitbuf->pend = pxmitbuf->pbuf + MAX_XMIT_EXTBUF_SZ;
@@ -240,10 +238,8 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			pxmitbuf->buf_tag = XMITBUF_CMD;
 
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, MAX_CMDBUF_SZ+XMITBUF_ALIGN_SZ, true);
-			if (res == _FAIL) {
-				res = _FAIL;
-				goto exit;
-			}
+			if (res == _FAIL)
+				goto free_cmd_xmitbuf;
 
 			pxmitbuf->phead = pxmitbuf->pbuf;
 			pxmitbuf->pend = pxmitbuf->pbuf + MAX_CMDBUF_SZ;
@@ -255,7 +251,7 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	res = rtw_alloc_hwxmits(padapter);
 	if (res == _FAIL)
-		goto exit;
+		goto free_cmd_xmitbuf;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -267,6 +263,34 @@ s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtw_hal_init_xmit_priv(padapter);
 
+	return res;
+
+free_cmd_xmitbuf:
+	while (i-- > 0) {
+		pxmitbuf = &pxmitpriv->pcmd_xmitbuf[i];
+		if (pxmitbuf)
+			rtw_os_xmit_resource_free(padapter, pxmitbuf, MAX_CMDBUF_SZ + XMITBUF_ALIGN_SZ, true);
+	}
+	i = NR_XMIT_EXTBUFF;
+free_xmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMIT_EXTBUF_SZ + XMITBUF_ALIGN_SZ), true);
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+free_xframe_ext:
+	vfree(pxmitpriv->xframe_ext_alloc_addr);
+	i = NR_XMITBUFF;
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ), true);
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
 exit:
 	return res;
 }
-- 

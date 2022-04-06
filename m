Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBB24F655D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiDFQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiDFQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:16:21 -0400
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3343E165AB3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217014;
        bh=zJFkZzqZthfWKrX/zbSrPfFnqxzqHvVv4Csfy9NuN4g=;
        h=From:To:Cc:Subject:Date;
        b=yJ+LF8vfyaqqCWNCZAQD/bwYpIR7a3dOh8yorG9RK/8Uk9Zd8OSQSirxQEul03TEj
         y/kI7GG8INx4q6eVh5p4FQawCvypNO6jLuUpr4jCKqtNBs0ZV86kZ542TNwtqIM0Lf
         ebtJPmw3RqZBS4YHQ08PJVfAaKTNl2AtIIxkqoT0=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id C8B2E245; Wed, 06 Apr 2022 11:50:11 +0800
X-QQ-mid: xmsmtpt1649217011tba63epip
Message-ID: <tencent_0D2E31C704054CF88F12F6FF114803B34106@qq.com>
X-QQ-XMAILINFO: OJV4F5WcWfWafbtek9ZeR1+BxzU4H4LqqfBQzbRUrASnC0l5H8Io4igjpzafji
         84wV1JwjWN33McDWy4ILmtIDT7dxOaLGjPvX+RoCby4d8cn2z/pYiNqI7DjmGymK1jcYWaAZboQ5
         /dyK+9lPw4jCzShkVve2Vsod9vZix5+6Bnlh92E3RjvbxY8Khk5E4TXGi4vJZFmvHSidkd/ILWsx
         wNVS6aUeAhOIemejsFmfXhNyZvlp6RuOBUQ1Rj6zKFPhyK3cbkAD9lmUDktVNEZzTF+N7FgG8l56
         t+9zCgtX2/suAxCnUeOCOI7UcdT12xOh+yxC4r2oITifegyQtsAt/lTrNxmhgyXksMEgrm1agzh+
         DT5gZ/16jHv3pcqoGj6+L/40TnhcnwPBnimrkS4VNTWeAZ0e33gqhnh/WMlKazLjOtkssErNX07j
         gDJBXb1YGJes9QoJO+rg26kxVQ0gZKF7379kwCz69kyoTKSWTSUL/Lg6XizVbJkcgR4h7EfgoTEc
         cZgNTeoQBNNdWZHBEu28luuG1hHNR+JgQOcqXqsEbjhPnOFebspihnx4tOiTFLPzs6PbDoakzP+a
         Fk8EQApApQGdChzDUm5TJeOxda7t6GJld4tKBfc2ypVKrdbVM4q2/OujrpEOuiMnSHoZumi6DswX
         vTgig5tcSWGt7ivxGPUP2fq2JJAZL+4Cb1QPb9FZFghiZqgU3ERI623fiVoVRJ95pVi6KxQVXuuO
         AxXUSCnmz8cNXuLMNkSSQPpt8Vu6sd8sOVmwNrL8Z654ABwDKYibmaFOlke4FykjntZRbMVcy0l0
         P180k+m3bDhrb3TghdZNsesvMCnOdSL7Z9iL+c17vP49oNZFvkhD1WBAS9IdsUMYGfjuvUZVNcDV
         G2DYJD3hoKyEMVHO3BhHBIWrzAJj4z/l9CzMr3vpF58WSUEFs15CBiOY8Vh6DEIWkktlU+PEGEXm
         lBK45r5jujTh9KqkhUNlif8nUFLQ/j
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Wed,  6 Apr 2022 11:50:01 +0800
X-OQ-MSGID: <20220406035001.12744-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
ChangeLog:
v1->v2 update the description.
 drivers/staging/rtl8723bs/core/rtw_xmit.c | 50 +++++++++++++++++------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_xmit.c b/drivers/staging/rtl8723bs/core/rtw_xmit.c
index 528f920..b288b04 100644
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

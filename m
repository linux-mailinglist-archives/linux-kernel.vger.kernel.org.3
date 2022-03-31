Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887BB4EDCC3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 17:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiCaP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbiCaP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 11:28:08 -0400
Received: from out203-205-251-27.mail.qq.com (out203-205-251-27.mail.qq.com [203.205.251.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D6214065
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648740376;
        bh=6eNe0sCBAfB/Hcfduogy8j4fDGvYRi7JohyzMwaNYwc=;
        h=From:To:Cc:Subject:Date;
        b=JpISyFgjkY9ekyIBwFZaBXUpOFirDzI4eVKaJCW/DH/WxyAp30n4IO/frFXP1OOEr
         gBB/Fl0sEuO6Q6HMdX8DOqF5rM8l8dqXV1vROqlRmaOBIadzzNwNG7kdTEzJrpYvLW
         WMtGxPoo8KLDB1+H7MPw58hU4oxbZTyj5Uw7K2qE=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 68DB8661; Thu, 31 Mar 2022 23:26:13 +0800
X-QQ-mid: xmsmtpt1648740373thyjaxjd9
Message-ID: <tencent_0AE833E7E70272D4518084C72B05FE17810A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujP6ZwiqCqDasFNtR0GvcsI1nrPkLX6b36tQRgx8JFpF1v/39Xwb
         7ccgrWcehKuTzSdNQS1f+Ep9OA+uXl4mucqtc4KNvoXuDsyWOjOkUtI9kZuItMmnooQxztrX09QR
         hRh5GiNB32NIPIxvrmfNnoniks96XobZvyRQBeusGZotVrmLkPoHmrx24mI9Bmt/ahtdAOtWQcYu
         834w8xHvRJR/cIklTr81l77/iK9HnOw4zm6KCEOlKNzSpy6b65KgPu83v2BRnP/22qC9CJ9+axJP
         BOyxGFtQw6oBPyAwvcytfYB+NEhyELB6hhiuoyn2FV+4y9o0N000/641C+tvBdNvZje7vf3O0EP0
         hR/PwyGIyV6Dl4deklwQfNF4oFvxTN0VPMQlWbMrDfcPAatl5mZwTJguA5QngCHRIE8+V1wHxvCf
         3pAEQYTVX64NGZbP6w5CbGKw/alDJhcwJSBwHeEAro3GWn6l26wEV1H79EI+Bo52lG47huxxyLoN
         jn1T5TnRoG5ubdZ1bSM2qbWXCsVAclYMzP2pr1Us5P8k16DcjIGT+y7QNUpjgMX7I2dG63kpuOmg
         b2gQkQI1f25G2NA8BKnJHj98hxibd9bdrxVY+PdO7El+EX/DUdiRCAQVedP8A+AVa1HuVeP7/Zs+
         hpWLYPQ7Y4eNx240jmfJYvwHw3CUwIbKhQEUWmfB+Tx0JRtTyictzJMDVumTNhOir4MGL3yzW+aQ
         l+t6mDL6nnJbIq8zJr4nZbHHh7zyL75rIkxvJp5eISWaOOj1LhwgFkLqAfrHlWrDnO2qbeKkNMOh
         Av3w9THovGFV3GqcQW98NECy4Co1ylnSs8NQRdJ7lqlhNiDn9aocOzyS6YT0dRXH98Wzrlq0eM2s
         Tz/j/lpgT986M/0D8uiKGO+rFqVws5qZaTu3OHhutgnyYVMAzqpkvYVRdOS4icKjkq6kCyUEk6dt
         jIa749J9twl1+pFoT8Ag==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: rtl8723bs: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Thu, 31 Mar 2022 23:26:04 +0800
X-OQ-MSGID: <20220331152604.8729-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In _rtw_init_xmit_priv(), there are several error paths for allocation
failures without releasing the resources.
To properly release them, several error handling paths are added.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
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

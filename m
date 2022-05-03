Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C1517E08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiECHGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiECHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:06:15 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409932317D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561359;
        bh=XiIvMOgCUkVPzFs1Jv918EjANrq4vNn2+a1QvQJivL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XOzrAutbu47h56lltPaRFAyOPGgu9LSWOObmAZF3cAws1zcUsACOthkkcMGXK6f8Q
         Qn5HzZzSWnvdXffIu7eayPKhxpRTHfHqpJzHoeqieC28lYqOscIXXcCMTVlrMUS4z8
         UZ8vdwwAYZU+WNfFU4rrBHNlNINhCblvUUU1Tpas=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrsza9.qq.com (NewEsmtp) with SMTP
        id A524095; Tue, 03 May 2022 15:02:37 +0800
X-QQ-mid: xmsmtpt1651561357tl0c7siwz
Message-ID: <tencent_DF81E22E7C4C49E5FF15C497B9257785A305@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBbw3fV/L4WSPM2RTpgTPismn0/Spg/HCb+rfIIOtHgstRNOAQo6L
         QY6mcaY8Q+9D3SZbOLbqtFcGM7Yn8998Y7czqeISC+ftVICX8BhnvVv2fh9mquWaOF9fh3SmJbL5
         tqGV8WNoHjt8x6TFZApR2pKw4flV07L1e/brsj+1f1XqmeRCp4VWlOxy9AsyXZc2Q8NbLyuImlbx
         jvrmYxKPiOlnHFitKZVNqbHlPP2VbRs/s17wCCv/hPTRqD6JAgazE0QVG6fHf0HdGcio5zgfHfHs
         UntnRX2HsJWm2aq1wL8qX3mDBpmm5vYCmUWjUiX3XEjPW9e7WxufLhOA/6vtxhqnBZMCHcmQQnOH
         EhYO4J9fWqSMuHPDdXOXP7UdzwRUkPAwxm3b7DB1jsLrJhoin9gRV8VKqiRZjpuRRZqJXClmiiE7
         YmovqB4JxtI/SzWlaT7aIe6t7X9IJPMmdwnvXFQVuPKkIlbnSa19+wp+10NDQUtUpniT88LTXiUQ
         Jlrmp5GC3gdKqPV4BDggRNDS4h8H4ftS9aRc6+3SWD7a8RHh0ZMMNNou60opjhC1NEWq9xmrV0XW
         qyxWO22Wp1Q4mP5xiyq1XjTG+XS92jJLVqWmFwozYDk6WNnieXOjlH+GR4EUR5AMWr2DcH+8rJiU
         sJTMW+lrL6w4/N2/IbZVzE8lk5jOjZPckvAKohqo3N06DwVhZJDjUc1umXS1t4anFAWIjaamV7Vl
         Zfj8bKEG6rX4Kkz/B/vOoT4s2aAWtuMdOJIAxfqExjCsHS+sAC3SPrVQ53y6pi4IlNc+Nd+9+TyC
         27wimbFbOLCpBEG0irJdselsE3ZB4PeAlvQk2aDSmLfjTMr14fQp+MAUdyQHwAYZUtSP8JRFB6Ck
         PvZKEvPNVnK8NFb6ayAighxfanlvbaXyjs6zFjozjVJY7+TA+EYfEpbdpTSX0lxurKOTlvxS6v7y
         xUL0+j7cDnBjIQzeoHPvp7pYduDqENK4LjsNvtIqEkjXQORrRSBREdau5J5p+4
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 11/12] staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Tue,  3 May 2022 15:02:24 +0800
X-OQ-MSGID: <20220503070225.3390-1-xkernel.wang@foxmail.com>
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

In _rtw_init_xmit_priv(), there are several error paths for allocation
failures just jump to the `exit` section. However, there is no action
will be performed, so the allocated resources are not properly released,
which leads to various memory leaks.

To properly release them, this patch unifies the error handling code and
several error handling paths are added.
According to the allocation sequence, if the validation fails, it will
jump to its corresponding error tag to release the resources.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d086812..4c54647 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -134,7 +134,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL)
-				goto exit;
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -152,7 +152,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -167,10 +167,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->ext_tag = true;
 
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
-		if (res == _FAIL) {
-			res = _FAIL;
-			goto exit;
-		}
+		if (res == _FAIL)
+			goto free_xmit_extbuf;
 
 		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
 		pxmitbuf++;
@@ -200,8 +198,26 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtl8188eu_init_xmit_priv(padapter);
 
-exit:
+	return _SUCCESS;
 
+free_xmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+	i = NR_XMITBUFF;
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
+exit:
 	return res;
 }
 
-- 

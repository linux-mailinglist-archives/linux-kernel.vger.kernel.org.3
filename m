Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4478A517DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiECHC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiECHCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:02:24 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C58129CA6
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561126;
        bh=/491qJnYzSclNx1vERDyC1WZC311I5DFUd7ijjksBNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=opJDHinVmKF5hviz1hvvfdCj8WbAvHMREHgVKL4KbGqJL/f2B2TWzJ7Bm3S97Yv5V
         VLfxxNDFfEvHR5XQ24MyTUpfwn+sUFZ8qKRSXryaiwV991A5Iyhi1jMLbiAH0kvKKy
         sxHHTIZ3vjknO2LCayDyF5GIBLy0+qO5+s7m9epY=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id EAB98809; Tue, 03 May 2022 14:58:43 +0800
X-QQ-mid: xmsmtpt1651561123tdijbcf3b
Message-ID: <tencent_6B192577806397022B9C51A9E1DF16849005@qq.com>
X-QQ-XMAILINFO: MfWa+adQHcqucyr49FpslnDIquvVRalojMY8HACh1qeXkkS/ij/iPp1GO3UBPz
         Kpgqjb6Hg6z2Xcd9usN3OqDFLrBzmWtvyrXf4zNbKSWTX/A9Hg8tssY9eJBAyntzf24RyCbFulVB
         bGZxBB26xq/TqbPcADHI7rQLSl+wtIfCZd8XJV+p/g0WlxJdjLb0zjbWJ8C4Djfs8I9o+IUENk1/
         JCKn52bCuvTH3GN4BktJ3/9uOrZ8BfACHPaPUET7wcIxIXn0nt1V4IXjrz+oAjhFrW/8ivAipo77
         pPrVaVdD+ehazJHH8c6yRQnRHiiAdUVhHTEeSFqeu+o7zBOHTBulyUvLtdjAdKYM/5E4jhweuO5e
         yyIzCGs/KbW/rGFm0by5hZme6aLQu1O3KBhJdIavt94FxXdi4wAVE3YHu3L/eoHK0iW1kOjFxlwZ
         wNfpJqBfHmD+eTsknJC4c2mVAki1GyfnBEbNonFv+7QOqTwcTrb5RPTLuX5ZUaegO4yNLcVU7GZy
         RapZuFrmRei4/8pkEc86jULPdd81relznW0mlgvintDFqhE6nir2+UUh1O6Kcbe91tXhdK+3dx2x
         dF4nDhxVllRzc3pjKeWvteCUdkO2E/lffnjFmvpQEJcOmkKEYQVBflHLrJh6izd12ugweITcYe3D
         cqxfovrMntlUUgT6fdGRHtL4KpSlBuYiaSlNOXmilDr4uG9cGtibnU+OYZWFQ0d3vn3gJGIJIVzx
         U+S5PIiscceT/DE68l0S/SBPpVtT6S/u1A5SI0moleJVenJtZoO1B2+CcNoMnc+PNcuhR2w6Vy1V
         eAF0t7/YbVn9V9udAgN1IL/mQChK7jQ1dbSq9OYs4ivcAbvWWd+p/pFavD7RKD1YcdZOxfyo1Pnh
         0l96B+RVj7q1zY2vyrz2vJhJ5n9A4yru0JqsNuzEksr9WsXf+nJhUKmCteAT3A9jilyysvgMr+CV
         I8APbsg2Si+YWAWX1PfhMrHPoyvlg2
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 02/12] staging: rtl8712: fix potential memory leak in _r8712_init_xmit_priv()
Date:   Tue,  3 May 2022 14:58:29 +0800
X-OQ-MSGID: <20220503065829.3197-1-xkernel.wang@foxmail.com>
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

In _r8712_init_xmit_priv(), if `pxmitbuf->pallocated_buf` is allocated in
failure or `r8712_xmit_resource_alloc(padapter, pxmitbuf)` fails, then it
just returns -ENOMEM but not releases the previous allocated resources,
which leads to various memory leaks.

To fix the memory leaks, this patch unifies the error handler in
_r8712_init_xmit_priv().
Note that if `r8712_xmit_resource_alloc(padapter, pxmitbuf)` fails, we
should call `kfree(pxmitbuf->pallocated_buf);` before goto the error
section so that we do not need to concern the failed item.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 27 ++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index 090345b..dcf3f76 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -117,11 +117,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->pending_xmitbuf_queue);
 	pxmitpriv->pallocated_xmitbuf =
 		kmalloc(NR_XMITBUFF * sizeof(struct xmit_buf) + 4, GFP_ATOMIC);
-	if (!pxmitpriv->pallocated_xmitbuf) {
-		kfree(pxmitpriv->pallocated_frame_buf);
-		pxmitpriv->pallocated_frame_buf = NULL;
-		return -ENOMEM;
-	}
+	if (!pxmitpriv->pallocated_xmitbuf)
+		goto free_frame_buf;
 	pxmitpriv->pxmitbuf = pxmitpriv->pallocated_xmitbuf + 4 -
 			      ((addr_t)(pxmitpriv->pallocated_xmitbuf) & 3);
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
@@ -130,12 +127,14 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 		pxmitbuf->pallocated_buf =
 			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 		if (!pxmitbuf->pallocated_buf)
-			return -ENOMEM;
+			goto free_xmitbuf;
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
 				 ((addr_t) (pxmitbuf->pallocated_buf) &
 				 (XMITBUF_ALIGN_SZ - 1));
-		if (r8712_xmit_resource_alloc(padapter, pxmitbuf))
-			return -ENOMEM;
+		if (r8712_xmit_resource_alloc(padapter, pxmitbuf)) {
+			kfree(pxmitbuf->pallocated_buf);
+			goto free_xmitbuf;
+		}
 		list_add_tail(&pxmitbuf->list,
 				 &(pxmitpriv->free_xmitbuf_queue.queue));
 		pxmitbuf++;
@@ -146,6 +145,18 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 	tasklet_setup(&pxmitpriv->xmit_tasklet, r8712_xmit_bh);
 	return 0;
+
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i-- > 0) {
+		r8712_xmit_resource_free(padapter, pxmitbuf);
+		kfree(pxmitbuf->pallocated_buf);
+		pxmitbuf++;
+	}
+	kfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	kfree(pxmitpriv->pallocated_frame_buf);
+	return -ENOMEM;
 }
 
 void _free_xmit_priv(struct xmit_priv *pxmitpriv)
-- 

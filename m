Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C7A4F6539
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiDFQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiDFQQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:16:13 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337494441FD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217156;
        bh=LaXdq3WgBKG8rGR8/GCiN9AvdoFNszqno/MYmmiggNQ=;
        h=From:To:Cc:Subject:Date;
        b=aK3l4J50HfsB2FVuizOuOHHANkcWu8cOaj+vrH/TPJWlNR9WqJPczLv4bowuGdwzE
         S195/Nup+9JGOO8JlRmEf4g/LiScLjQ2AdIK7Bn8GLHbzGAfVehtYl+gXw3miSRy2Q
         scU4MwIThd7lhe7E9YoU1kuwvmVafLqlTcsd0b6E=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id D210A081; Wed, 06 Apr 2022 11:52:33 +0800
X-QQ-mid: xmsmtpt1649217153tufco4j5d
Message-ID: <tencent_7EE382C22FDC47C9F4FF01E490B93C178C05@qq.com>
X-QQ-XMAILINFO: MDPfhejMR4aIvvFh5dFa71usdUHZqOIpEim1jqrfzaFqwvOLB3onQg62GzVShe
         ECfmSMzBcFq6vn/UVkSam+sKtQ6dLIQACXuF8c6Vt4ODbAYxqjo1KBTxD3+ZuNPws2Oyd6cgEcO/
         MYpVaNyztAj1yD7S0LBcNt/zsVvaXhyztmbyOj7/mrC0hfk0v04okGa9mnt0mRyswlxoxb5VpoLI
         Gu0KlTqXB8qxENvHgZGiglaO2np0KjKLncfvW/oUwcI+hXstyGD9lNSKLJOyCEJoEILjwDivnHN4
         Mohfd3i7ZrYazekBSkKE8z3Lxl3kvFvx3Lg96eDHFa5x78wAO2jTOClaE8Kbux3ifxSjc9ctjdIo
         hVkg5q+2EQq42xanOnDuWMon347w7cWAfJfFNFf0Qc/NVbf5991R4Tv3vmOPfQl75jUgSYNI3mbE
         uAF413artIIumLT7BT0or7nbkYuFUCrHzqq2jv0bFWRxN6dx0l6Lkssx8X+jddlETV47mjYmHOR0
         cNYxxsSGt1YAB0UaentKIKvFVJ+AMHnAWZAJRY+t7rR/J6oczsuZweXbop/pw9PN3zpCgqzo3wa6
         o+Z45FZlGYo0ohPQF1Ew+YAvip0dK5gf6LZM3yaRE0hvbwmrxKDEMwB3u0A0yNx0uTfueGNJOeEa
         h3hc2yUMYST9nm/IttbIvNvBs8q0Zh0QPfLhD8pCYjKICc++TotwH0NOTmCl9fTye0XUha7uD8cH
         2nW67cv5eKamhUICvTrBVwNQzwLLLqdtvuN1Z0N/f9n78xrexupgcawXclRpIrUKjRtQ/KgvaJB/
         fMUIf5iDK7hKrqJIP/f8FzQu6FoAVft8imLl/WJG4V9pnr2phUFshxWGArA0DLiqpo8MNVLSySm/
         LcpUDrqE0Q0PCJDf8YkXy1fblENoCmCd66wKLbwSH2yzJ8Lgc+lLxXR8prAS9v+MLwfvzgvNo1tF
         dC+GjhJfQ=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: rtl8712: fix potential memory leak in _r8712_init_xmit_priv()
Date:   Wed,  6 Apr 2022 11:52:21 +0800
X-OQ-MSGID: <20220406035221.12808-1-xkernel.wang@foxmail.com>
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
ChangeLog:
v1->v2 update the description.
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

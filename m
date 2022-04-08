Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7596F4F8C51
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiDHBkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiDHBkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:40:32 -0400
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B551E092
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649381905;
        bh=S/8n9mmxDhnXnbv+jyDGJ4Z8CVZEzYgHvoBZsxCyIas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VEdrsmTcL6DL4NcLomNxrUvnHBqX/fAeJgOaNBuNTIus9v/3qOY1vg0QkQlbodDUi
         V6dEqORLeE6UMaLkhzh7WjMiYIUjR17gZo846t9lhe2Y9r/GTnbOF30LmeUSz0i3eF
         g5Etp4hYSAOO5ewP/blxmdF4j0/tc0ILKWMwzWks=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 9952D8CE; Fri, 08 Apr 2022 09:38:21 +0800
X-QQ-mid: xmsmtpt1649381901ta7z22dgr
Message-ID: <tencent_8F38C8281EC3CB9498FFF340B09989735509@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj7gXE9EPckiz5cMCCuJIMVfBHD5XvwVJrXKj/SUhg4xmMUB80zp
         hd9T08xuuFLdYN1n7PDD8gXvqgIK0IJD4v+0dy0zoFtD1Wt/06MaAIwWg/TJGoLQO/zAQlb1Vk1l
         BbJdKuFEiBOysOG49ON94WHDrzY+8O8jYNW0P5pQfo+WcfHYsDxB0epwy2bnkhssjfiuWhmDYO+9
         eSr8ftqwlHHsMclrCiZlPbtwzqg0DwiLgIX8/sEe2juHLohotcMaTaE9pWZa0nlfdySWpQ+a+e97
         WSDY5Uxvk897imW470xUl70P5Zv/F/O6/kHb7qzhZ9hpy55VjQoYO7m5bh3Q4B+qOUZErAlt8PXe
         4pSKZyFTES3RRfeN3Clwn2N88I4mT2JEL/OvkjP1Fo+T9w/bOgEVUGDyJNbg/QK4wEE/f2kMcdIF
         FvjADNrGZRL4nSi6lbiMaqL5M0DJRav2gKaCFQqhmgIkku9kGgKFxD6ansWBW9s2KDg6TtvXnw1v
         olMq+xsJzKJ35lmq5npXHrZmHzqByzyGFPRIWzOtrBgYAHvvNqWivEqrRahkIoMlZVyOU9KY2C08
         f+bmWcZ7pFDgoCoRsSlXWrEwoo4hiO8qvJpIhip5Sq2iV8lNpsdqC5f455D3nUfMldvXysNg4pPn
         3kliXas2QBci04M+h9FhYbARcRSSeOC7CgOjFy0OQqAGNtTF2vataUhYNrqPTcyvQnWlDwGxjiei
         BSP9nnOYSvQpOPiAJ7KBLnuRpBpu2Da0CVaVVl1/YMqEHUksbJ4CzsquOErxIFeQakR6O4BH5RpZ
         KqhYaulZi2+GM7fKUmn8PSyK7m9hy0I2YbTmJgWEjL37TEn0LnWd+Xm0HcJiDWG+UMxmnOqlC8tY
         m2TfZvwoGkZsVdHhSQvn4u9ScligebV6I/IH8hZZ0+YSfnKpZvbKhSaJ1S4SZUYySbsWngMkDBWR
         bsLlslrmA=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, paskripkin@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3 2/2] staging: r8188eu: check the return of kzalloc()
Date:   Fri,  8 Apr 2022 09:38:07 +0800
X-OQ-MSGID: <20220408013807.15076-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_06FCFF1B2086CCD7B9C51C7C1490E1D64A08@qq.com>
References: <tencent_06FCFF1B2086CCD7B9C51C7C1490E1D64A08@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to handle the return
of it to prevent potential wrong memory access.

Besides, to propagate the error to the caller, the type of
rtw_alloc_hwxmits() is changed to `int` and another check is added to 
its caller.
Then if kzalloc() fails, the caller will properly jump to the
corresponding error hanlding code.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description and adjust the sequence of patches.
v2->v3 change `s32` -> `int`.
 drivers/staging/r8188eu/core/rtw_xmit.c    | 10 ++++++++--
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 865b2fc..92a1ad3 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -176,7 +176,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto free_xmit_extbuf;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1490,7 +1492,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+int rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1498,6 +1500,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1514,6 +1518,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
 	}
+
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b2df148..fa35776 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -341,7 +341,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
-void rtw_alloc_hwxmits(struct adapter *padapter);
+int rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B84517E0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiECHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiECHGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:06:33 -0400
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA722229D
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651561378;
        bh=h/u8mB+P2I1PeYBUyXJQEYLg+PcOwclXueD7WQy5lFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SEh4wPDdeb4Ml5kzQJsPNuoLNzzbnVv0v/JcyYGD72jabxX8KsJdbolHD3+wvFZQz
         +09AaHmn9a6tgt6u/Icac0DgZ24NfL2zbUWsjZK4do9x07P1Y69kattQGlNjaDaFtM
         DWz2Ns6iGiurmM20jFRr5mDVjHPim0iq9pCR32Sc=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id B78109E; Tue, 03 May 2022 15:02:55 +0800
X-QQ-mid: xmsmtpt1651561375tmbgzldl9
Message-ID: <tencent_702C3C4AA9F65F0EE48859211795E3800205@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwc4l6nqpQb1iMLkQctnwhVMfSaVNQH3tIKaOtuOrS2GkY1bdbOA
         d8ivVbHxH890WZrwNDxxhmvYF2wq/kNNfSD1eRsXRQkK3U2DVkdFc0rYxe5ZSpk729KMxyJ8gqsj
         8WjKwFdyXECu7d/tL6jihMwl2dk5PES+ZhCPDbSOORzEk9ntGdM2lXalXaBQQnQTg/S+Ovt8kU68
         Rn58N78PRC0cGH+7Wich1/JDSmwLD/AOOj/PQkHYyfjwxo0wBNaikvUzx6fTW+u9BI/R2Uyp5ySs
         w+iDexUlkz8fQZagX8lMboOBhmtrAdASyu+hgJe1ZwbQw2qKoK9TIpLY38SkPBVK5Y8OBiuigk68
         gHzFhdd7iHTw6m6NTEGDo6S4gp6RVk73/OxJGUInWrnr7oN0s/9Co4CQRUIo0Clx83FIpouCfgM1
         xYd5m2RsuFKQhB0aVJSkLjKDv8XKj47RcKXj6bnYNTUyYI/Rh/qKwhJmF8GFKf05qVqg/OIgYqSX
         HMKWM4Itb9L2msmhWv9HRUOPyLzAJY4UVn769bgw+7RoW6DesaopPp9eYb5gT75B/EHLm+7aNzOs
         x3g87NB2XjGgwZ56zZ8oEXLPoAd7McZJZ3YRN7ncSFvXce5zLBCchSsd4Jn2av/R2V0Owo26E9xs
         3GLCeEprFtDpjJYUI5wrsCaWLDh4c4rhNkn4kcT1dkQBNX3BInSGd3bwWN4mtZDLhRf76eWy9Gzf
         m2C+Uy69N88+tYRDK16L0LvBFuBIyZxZg2jp3/QoMKD6yVASKjiQPRWvWhzEVt8YBzVdS8bvsTYp
         UzDBJQcdtSIgIdCLMctwl/PqmsqV2MylmiN06pPUhlgaEjO2Tonz70UoZ+gAaE9igN6O7dNnLbU5
         Xv5Zz/ZTUhSXjgqI3IEJRy1lqQXtIA9kAhfb0D9XD9add/MIFok7L9MIH1Y8JrXM9KDzeuR/PVvx
         R4VZFV69Tcn9s98Mv+l9EIaCO3OjHRDUvt09JfHeg2CWEJUZaLNKAe4hW8BQ3w
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 12/12] staging: r8188eu: check the return of kzalloc()
Date:   Tue,  3 May 2022 15:02:46 +0800
X-OQ-MSGID: <20220503070246.3411-1-xkernel.wang@foxmail.com>
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
 drivers/staging/r8188eu/core/rtw_xmit.c    | 10 ++++++++--
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 4c54647..7d1fa52 100644
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
@@ -1487,7 +1489,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+int rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1495,6 +1497,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1511,6 +1515,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
 	}
+
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 54c2bdf..034a9f8 100644
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

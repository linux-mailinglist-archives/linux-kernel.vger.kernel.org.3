Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7EB4ED80F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbiCaK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiCaK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:59:06 -0400
Received: from out203-205-251-84.mail.qq.com (unknown [203.205.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA9204CA5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648724234;
        bh=aRr1Wo0noBzjmztVDr9o7+pq2OCjO4BIh16u58etZvc=;
        h=From:To:Cc:Subject:Date;
        b=AfLDKqLiT1HDI3MB/W6SiZ412Pkbchr0l1bL4jfOH2MXRR9ilw9pfeabZaBRyobdP
         Hm9gNvatHXIrlAtDwUoUVkqNQMwlmkInAM3Lo9l6i2QtOTnSyJRZ0b6q8alEC15LeC
         Dm+efWw9CTuSXFH9cp9ry5WjV75+KEBWC9XY4dXM=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id E4927E21; Thu, 31 Mar 2022 18:57:09 +0800
X-QQ-mid: xmsmtpt1648724229t58b97qig
Message-ID: <tencent_254AD0FF06201BCCF5B9911C6E142CE1F208@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCCGP4N5Q8XMBn0Cixmk8hVKlkQwDgT2cAN7KG384+6dqFHqXzEW
         ElbgUXl9mczuK6kltEVanL23xPmULJTX1NsGfReYVRbMjtYHPtQFAZ9k/2TyJwjTmAYBT7o8gTO8
         uExXrZh6yZRkfVHJe6cWNntlKrLtIRhdrTjpDS5vzW6uBs7CxOc1t3jSVjPuN1hXFJ2HJRuj7QDj
         jlhoQ48a3o8lH/DcZgnxf1E/tQIWH8MV/rhnZ2bpAE0Ucd1MJzdJRRkaoBzXWBxz68dPou2qGpCk
         x1wmsU5jDIpMGqpqLs9+gUln30Db+2inOIwelRCaniPye1EQxFvVdzHbN7SdLFmebrOqYZTe2Utp
         EwommJmxlmapRfBfFlVJKk0KB2ANZmy7GRckvbUTqLhBOHFex4R+tflQWR7Dd1Sp/Vf2D4OQa8Ue
         +zsmc8fCjAOOx1zcrJ5Sr770KSmbUJYgqqnhLZmRZqv6KOEo51Y42GHHVCZ+QvAxTi/FtXZJIonF
         4ppN73g7cPkOkqWCUQUuPSr+5topIcjkniZ3IYfj4CtXoRTBzn12A6xuKO8zs5NbR29Zm0gapL0j
         dX9np/tg0jUrAOZRcMSkv4rwUEqpcKhR/4p51fQ/geFQvY4q1dny7CcGxh7aYCkMxDKRucaCXY1k
         bU0GmPvmLPMS8C80sD+aEatwkh05bDgVYBjlYsO0LN0VVvjT6SIZi2CKxHLwNPy/9GZpz6j/fAjY
         F80f/w738DVMxkLzjOAqFPsrBnA2fhHqJWsMxMQQ6U4p9MQNxt3wq0nhfHNcjW+p8iKx7eq26rf6
         NLMmNLTeu9Kg+OaojNbouaU7zphheQ2CvA1Y9+H+3ZgRgEba7zZ8YcyB+ePDuc68Ki3D1NCvLas+
         DsSAwmJLfbog9mzcMMqmodZl4iu0eOkTNeQH1a6lb1CxUMCzL5cTVx2Uy88LBOStJW5LL2enyXN8
         8GVrIMcfI=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: check the return of kzalloc()
Date:   Thu, 31 Mar 2022 18:56:55 +0800
X-OQ-MSGID: <20220331105655.7958-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to handle the return
of it to prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Note: The subsequent patch is specific to properly release the
resources, while this one is just take aware of the validation for the
return of kzalloc().
ChangeLog:
v1->v2: optimize the style and seperate an another patch.
 drivers/staging/r8188eu/core/rtw_xmit.c    | 10 ++++++++--
 drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 46fe62c..299fe26 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -179,7 +179,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
 
-	rtw_alloc_hwxmits(padapter);
+	res = rtw_alloc_hwxmits(padapter);
+	if (res == _FAIL)
+		goto exit;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -1516,7 +1518,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 	return res;
 }
 
-void rtw_alloc_hwxmits(struct adapter *padapter)
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
 {
 	struct hw_xmit *hwxmits;
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
@@ -1524,6 +1526,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
 
 	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
+	if (!pxmitpriv->hwxmits)
+		return _FAIL;
 
 	hwxmits = pxmitpriv->hwxmits;
 
@@ -1540,6 +1544,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
 		hwxmits[3] .sta_queue = &pxmitpriv->bk_pending;
 	} else {
 	}
+
+	return _SUCCESS;
 }
 
 void rtw_free_hwxmits(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 5f6e240..b45cd29 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -345,7 +345,7 @@ s32 rtw_txframes_sta_ac_pending(struct adapter *padapter,
 void rtw_init_hwxmits(struct hw_xmit *phwxmit, int entry);
 s32 _rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter);
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv);
-void rtw_alloc_hwxmits(struct adapter *padapter);
+s32 rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
-- 

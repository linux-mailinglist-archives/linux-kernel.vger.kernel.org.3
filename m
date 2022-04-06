Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5753D4F578D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiDFHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448776AbiDFGjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:39:52 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13205186482
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649219450;
        bh=6rBElJ0qW4HDdHbJHceH6b2ehGQNwWjmaMG9691pNhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZAFWaEMI1RiujXRoNw419i7o1zIlAZkBH/12rYyTAbTO3itjb/Pl9dugzIZiJP9x/
         sZZtxiiXm8j60CU/Np/JSSU007569fVS2PIxxBIY2BBB1sGgVOIZfNfzyUf5XkCcqq
         7okkI/Clkqw4eBzbcw/1HqXU4RbqD8Pchs5QEaL0=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 7AF8D06E; Wed, 06 Apr 2022 12:30:47 +0800
X-QQ-mid: xmsmtpt1649219447tssay7uu7
Message-ID: <tencent_15C23F2EC8197361EE200714C54E78B45206@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTbni/KihziXXGqr+Qs2lNBeV/C6dUBbYXHX3sJ6jYnkKoDKKL98
         cutp4kam/yeBVRMQ2IcecP2o87TyIbfktM469wXQYOr/EXA5xU8FXmZHupXg3fVd6lp4rh9muiGl
         SUkCxDZppdU1WEafV+1ptsUHU3kQb1juAXFnJrtOisw/Gr8ZkTLhaU/yN+LxX91rCoOwg5N6TfMG
         3dV7hBuB0U3cUqohwWc+AyYsMyMp1Q4zogKDFXB001tvQXEn+B99bZkPsfEZb5szUJb+Av6NQR43
         Gj5N1/51vuFN9uLVn09zBTrH5aw1rPxauIpTG1B7Hkg7r/LOMo30NhwZ69BGeIO9bv2PQvbwObNP
         qJbuaigqTyHGH4N7hH7AcY+IrVGBUm7q5qMxx66/DLInfJZy/Dzpkrrqv0VVd8nDXyF1V4vu3Cg3
         rnj7ebkI9FCY9Qz8GHZS1t3BFBpBej8r+c4O49FwkqWrWt8bmnRaMZuefRaLDyBg81ea+N3rxRss
         lbQuJiu8aNlgRb1YwpPIiITTnMySzHB4Au9ZxVM5k65JZnhoWYnHOqu07RRojr6EvQEtNXQRcHSc
         Iw7wn79bOgOLCuTPFF87E9bsUxa9DFmPLV/gdGhodyRnpho6HddUkCBNZ6DoTi+Uj55UHSjb/468
         q8qFFxTGUPkZOuJ+WoYdAud66TWXLhWM+OrP1DGwpZgEioynISQEFwvfXpMFwDEth5mIO4beEy4x
         ab+mCMaG0+zz1pP2u3qj19nftyDufewG0KFd+DBm5uaAsl/Ni18RkBZ0NjblghGN49FuFk7hiKvr
         9pjqMqKlVKWLhDvGxjph6HicmipYEWeg6ubn7zVwH4RIiQFQter+Vyty3CuhQaIZTa6JnJkao20M
         un9NHbjAjreHX4i9F6TGrXLAx1eDeN21WTVf1AHSz6AAr9Wrey55y3zJ/73CmkBFqms7ZjrSLd4M
         locErS4lax8vBfenHbF2ikSiUarEYAWSSs+ofe/sv8kDwoIM05HQ==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: check the return of kzalloc()
Date:   Wed,  6 Apr 2022 12:30:32 +0800
X-OQ-MSGID: <20220406043032.13393-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com>
References: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
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

Besides, to propagate the error to the caller, the type of
rtw_alloc_hwxmits() is changed and another check is added in its caller.
Then if kzalloc() fails, the caller will properly jump to the
corresponding error hanlding code.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description and adjust the sequence of patches.
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
+s32 rtw_alloc_hwxmits(struct adapter *padapter)
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
+s32 rtw_alloc_hwxmits(struct adapter *padapter);
 void rtw_free_hwxmits(struct adapter *padapter);
 s32 rtw_xmit(struct adapter *padapter, struct sk_buff **pkt);
 
-- 

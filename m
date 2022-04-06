Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA774F6523
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiDFQNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiDFQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:11:47 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4757F44B453
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649216899;
        bh=1Z77nqbV2+A1Msr6oVHor24E79pO7sQR7sgV6KHu69k=;
        h=From:To:Cc:Subject:Date;
        b=OKEtZLy45G9u/sY40I+KcsZq34g6zltQvS0hqxIDgWItTzc/GZRKZztA9M0Qrpb/8
         xaRQ2+hxWnA+6css/oVUrPnFDZSyz/HkkQrVaAld/UrqozjtT1GqP/BwdVgmtbqxFN
         o4kKXavPSBb3t/U1JXUmSylLTWv6DHHKd00vgTFY=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id C1000240; Wed, 06 Apr 2022 11:48:16 +0800
X-QQ-mid: xmsmtpt1649216896tdpol2cs8
Message-ID: <tencent_525C5EC9EBBF0CC494993AB78C438E822005@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85No1HPsB7BdfXhvDdXXQaBWHlesPbwLSGyT0YiJdzKzksbzMaL8Hl
         wgRI2QIwKNsyiYTSJjWb6YFwiJJF3Povsd8Ko7gbZBK3F9+vsos17gkMDTkSNeL8R+mGdDwl5i6n
         +1eei3rQLmYH8A7nXtDcxM16VYB1M5TAr62JZEfplPF2kcG+bTpYPhB9/IamYM8uQkjDgsNzEIDW
         hwrBEKdkVDdP9chsnbpTgScJNYIYma63Kvarau3gVTZjXqjHJoiykcHSBDiQz9dtlxFZXrTfhh5w
         UoLrXVoLNdTChInZVBnJUT1s0yv02ig509yCk9vMhJTw1k2T+m5qXZiVzyeugFIk7Oy9mUIhh80d
         eN+nVsbqRHIS2zU76GtOgA++AE6aPMvgFokxretq9+xg/knXPdnfxDv4VOuJ/y6vp5hmK1YIP9WB
         jMaknJUsCI0F+0axFh85EZ5JhUWzIaaBvEYN81WqYyPNfI/uV2B+ADWJiiJoQOJOYUpV2KMYk8Ih
         0g2nGw0ReEElzoGaeZbNFfz0zhSQNq88p3qPrRni5QKlivhYxKf28QWbP6kVOxnB8R6hK53x0Y4E
         0Pxq9RauG70+8v7M3U9vcuUGy+cN7v94I2Xq0eO9GpwzrjbHbMTXVTnEipHZt0nRJBF4hkly6oLc
         ikp5ke1vNaSiB/RsnezSZ5z8l7UtDop6j0om87bLT0EPZcuZP6nLofwC7aU7VbClxRutBDuhFjWX
         VNk0UQeU3qUBBasO40nUU8QJ/33CtNUt4KakASeM6QxaWJmwkobJjzziobvgUWsCIJRKPPVGG7uT
         zQ4sLzd2CvoK2vDRaRZu+2TfeR1b+Dvv5c/Y02t1pf1dtDI72POBNBkIE2XfW1y7K0e4DUCrjsGo
         xwAQXbuXKRAtNt9svQCNN7WhyrmKAnXrzyWT+oEJa9xJKvbf4eCBQn5V/vnIpw82ORSfgke3xc
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: r8188eu: fix potential memory leak in rtw_os_xmit_resource_alloc()
Date:   Wed,  6 Apr 2022 11:48:03 +0800
X-OQ-MSGID: <20220406034803.12660-1-xkernel.wang@foxmail.com>
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

In rtw_os_xmit_resource_alloc(), if `pxmitbuf->pxmit_urb[i]` is  
allocated in failure, the other resources allocated such as 
`pxmitbuf->pallocated_buf` allocated by kzalloc() and the other explored 
items allocated by usb_alloc_urb() will not be properly released.

To release the resources, this patch first re-explores the allocated 
items and uses usb_free_urb() to release them, then uses kree() to 
release `pxmitbuf->pallocated_buf`.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
 drivers/staging/r8188eu/os_dep/xmit_linux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 8c3f8f0..5a59f62 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -78,8 +78,12 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i])
+		if (!pxmitbuf->pxmit_urb[i]) {
+			while (i-- > 0)
+				usb_free_urb(pxmitbuf->pxmit_urb[i]);
+			kfree(pxmitbuf->pallocated_buf);
 			return _FAIL;
+		}
 	}
 	return _SUCCESS;
 }
-- 

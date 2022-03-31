Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C14EE02E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiCaSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiCaSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:13:48 -0400
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2D1DDFC7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648750315;
        bh=wn45RItVLXLWXANc+t8C2ZSMFmtM6wkn0DriGaM+lMs=;
        h=From:To:Cc:Subject:Date;
        b=k2XOKs0YTRcqszYgpsw8ZuYK2ojrPQOaIdNTc+Kr9xkX46eBbb3wXdfuN0bYnA20l
         7oU79P309lZEcmayiTe5HRl5Y6h+hsMDp05S43u4Xh4nT0IbIbTsTZk1dezRMwa9AZ
         WhsYDeO5KOq9FbWbdjJ2CQbMcb4G0bSaBKx9Zelo=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 2F40E022; Fri, 01 Apr 2022 02:11:52 +0800
X-QQ-mid: xmsmtpt1648750312tvpa0vkk8
Message-ID: <tencent_35C87F0B0813734E6E3DC7100565789CD206@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnTrTyLpsSIIqTGYsnfA2L8f8T0diFi2gcGjeMNwM1yWhKu2y/IL
         GUcg2scRgjI2ko6NDLqsRlZar7h4KGvzZKMII7QgAcMqcEVAXdNn768iI6JiYjbtOa6/+UJuBxsA
         p3ALIOq74OKoI81bPAZAIdlc3UKXq3RPOsP/Obbl+YBv4MlBAxRz1Xu5LwR4ADcBu8DEfOhzYQRa
         NyRVy06fFdQJZ6BcJ8y+dWasvxQuTogjNwquOCX1QorMlkeNh8iKGOu7wTHVX7AitwdDDJlpI1TV
         K+Q/WDgKpq8jTKKf+JoSY3oP3qPMJSHvkShYg6NaBIY6ppgR1k6jMVd3W2/Lst2YJK0fVcsd12+1
         9vVCLyIeTNoHWubMp9o/3i5LfkmA0X016bEwZEX01VN7iDUffp26E4mnogLsdNct5Po3ahfICBp3
         eDSBJpj2+2SJjot5708x4WkdEDBD0/nomOEGJYrdu9P94TBcfiRKZ5ac5kCJuT43sCyKzaZ836+S
         U1vEJzAE2smqkEo4K5I/P72dN2wMqcOaiBtH02zqUdfnOs+YD6NdCG2Y69pRoJ0xmJSpm5p3XGQK
         ZNqAUljTr2GzilzW/lm9K+CKft5HDTBcxt6SiL9jCD2/5KkrTocS5EdddK4nrKDOHHZyooMcvXkc
         L1kb/moqhiyrCew8mnaFWZFC94UuUN14HdiS4IAtMwX0IQ9JLQUY+mm50TiBBbgZTHSgTYhKDQ2s
         1vMaa3zHvi35Q67JszxW1eZnN2yYCKpwTgEdjQjG7EG7J1aYopf0Q4wEjJzM3m4k4/89WWacrNEt
         bG9BGm0A/7xKdzzRj1EdoI7ibqaTTv8WCYfUihqkyrCIJnGRXmjOJnvTZGyKjSus2x5hdgMBCNiA
         2623vv2aOk8ZhWVVabaiZt3rBPG7nnBepFuXuT3MZ7pHbcmgcjhaSPKy2Of2oJNehdUK+/AIQmtO
         0KQAt0kzfJBzi+Dr2ujA==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: rtl8712: fix potential memory leak in r8712_xmit_resource_alloc()
Date:   Fri,  1 Apr 2022 02:11:41 +0800
X-OQ-MSGID: <20220331181141.10172-1-xkernel.wang@foxmail.com>
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

In r8712_xmit_resource_alloc(), if usb_alloc_urb() fails, there are some
explored items should be released before this function returns.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/rtl8712/xmit_linux.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
index 06283c4..1bfa204 100644
--- a/drivers/staging/rtl8712/xmit_linux.c
+++ b/drivers/staging/rtl8712/xmit_linux.c
@@ -113,6 +113,8 @@ int r8712_xmit_resource_alloc(struct _adapter *padapter,
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!pxmitbuf->pxmit_urb[i]) {
 			netdev_err(padapter->pnetdev, "pxmitbuf->pxmit_urb[i] == NULL\n");
+			while (i-- > 0)
+				usb_free_urb(pxmitbuf->pxmit_urb[i]);
 			return -ENOMEM;
 		}
 		kmemleak_not_leak(pxmitbuf->pxmit_urb[i]);
-- 

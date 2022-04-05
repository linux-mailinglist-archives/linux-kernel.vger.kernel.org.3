Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9950E4F2148
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiDECss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiDECsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:48:39 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9615239971C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649125766;
        bh=/3yGeZ7g3ndrgq7ezahWJRS7qUXCaNhhVgCTWOxAzag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hiVX729ojZibzmsVbnRRNjdi7b2WXsBa62yHRFBLvIhxBXuPK2HdBXQQgzH0UL8Na
         SyWutGcrOT6sb7xMQf0+eRRZ4m/UvcuK9iJ7iHax3QUhsY5qEUOCinmbkPk+brMfl0
         QdoWEi3pK1qmIlV3So3F+zWUOgFnaw/exPqQmNl4=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id 757B7698; Tue, 05 Apr 2022 10:29:23 +0800
X-QQ-mid: xmsmtpt1649125763tz7r97vbw
Message-ID: <tencent_5ACC8CB9131CFA14F7E1514A54FFF520D308@qq.com>
X-QQ-XMAILINFO: MDPfhejMR4aIUaXnh8SbAwTwpPAr4zJrY0xemmO5ZgY90J4sb4/U2jqT05KAWV
         G6glXny0sgROGUGBbVUdn27Tw38QXvlDOp8Enm68/axsxQZr/FME463zEIa5Iwg9G5suiHWWQMcP
         xmmfOhvTfIsgQEMcvk9sQiHAXFTJUroanhaEvI952KT/88nwrNRlqA00pLLpDm1KNQcI6nCk9RF5
         Yxq94CJ+ei5ptPAGV+7IbZupHsmzu3NB8o9w0tGfP8wxTeBs/zXpcanGCxnlXbc1BVvSqvuVFPJY
         a0ytrkhcyijw/c6X5KlKpEpmsTemHPWDTqrjGsdYSHk2ZGX6F4JXGkmVKUDoKXKQadVLb4KuuxzB
         N6ZlGjYX21OwOEGVyyz2DmHlqbSXfRnDYJVVWSe7lkWDYINxh6+OgnYsmZlx3XiLrYgyEkmk1yc2
         pJzmQ8YhY9lUu6W036SNV6xzQC8mdCdKyi+CRNMTMZSGjqjWphewxu/vIHGuV4WmgLAf60Nye3tI
         1jhbV87Lk1WNRcbnnuI1wE2X1DbDHeY5ZjnkOOw96/LvosN2nwzsnxfQrvQRtxxunvJGZG4hBrob
         FZLpnvdgMlBAf0HiFNTj9Ub8EEW+66W233i5kncz5Hkth0MtYlW/hGAo9tvg9rDhfWrFMlBfxMGE
         fTsIStPUYSARxoRWWjvIz8UrdaEG2J7SA61uuGNPkqzIwm6Oo1ZU5gjqrudsQ54MKKYXboaE76+g
         Tv7ozgj6ytxDEH8XrpFD9ThvjXmL8lnzy/pGIlpc+zy+y47svDM3WACdZ9k/2f+FOsdqUFeR85rm
         IJa3f6+mp8RdmS0mHa0RdrxrxJq+QsfRjHFLFanFjjwKx30S+f3Rd1PVPs5WcG6vwK+ksxCMm8rQ
         VBJsFo23ODnJeVgV5n3OQsQEKZKitEilprmeR500tASyf/eYzxVjHpSAkLuUySBjVbIpzCzg9lBE
         NvwiYLy2tCGddBTFHygO08AyqRfxUYU+1jXRY4BbnBbiWg8J3ERw==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 3/3] staging: rtl8712: add two validation check in r8712_init_drv_sw()
Date:   Tue,  5 Apr 2022 10:28:54 +0800
X-OQ-MSGID: <20220405022854.10991-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_FCEE3D8703C56F78B552FEFF070817736606@qq.com>
References: <tencent_FCEE3D8703C56F78B552FEFF070817736606@qq.com>
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

_r8712_init_xmit_priv() or _r8712_init_recv_priv() returns -ENOMEM
when some allocations inside it failed.
So it is better to check the return status of them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 adjust the sequence of patches in this series and add error
handlers in the first patch.
 drivers/staging/rtl8712/os_intfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 1f7ccec..0dbf8c2 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -308,8 +308,12 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
 		goto free_evt_priv;
-	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
-	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	ret = _r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
+	if (ret)
+		goto free_mlme_priv;
+	ret = _r8712_init_recv_priv(&padapter->recvpriv, padapter);
+	if (ret)
+		goto free_xmit_priv;
 	memset((unsigned char *)&padapter->securitypriv, 0,
 	       sizeof(struct security_priv));
 	timer_setup(&padapter->securitypriv.tkip_timer,
-- 

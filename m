Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9B5B15B1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiIHHby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIHHbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:31:50 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870AEA8CD2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662622300;
        bh=bwQ65S53ALWy6bGST1Fb3/GMX9ST8lXV82dLJKNIlOQ=;
        h=From:To:Cc:Subject:Date;
        b=LcItgrUnRrkrHP8DL9CTZCo9wZORyw7h9qslPybwReFwfTJyB//6Y8nYxp1qY0roT
         N68xMHoDqy26uZbul/D/yAhEB2x969rWYdiDewtTApU0Yz1Tm320CZj6rKvIZFkptP
         /QyDMNSYK1zPKOPuWRAVPJ8obRoUZ2ZRGFm2+9GU=
Received: from localhost.localdomain ([59.172.176.188])
        by newxmesmtplogicsvrsza30.qq.com (NewEsmtp) with SMTP
        id 7E618A06; Thu, 08 Sep 2022 15:31:38 +0800
X-QQ-mid: xmsmtpt1662622298tyuvudud9
Message-ID: <tencent_61623C1C5469E9DF0E448B5936B78E239C05@qq.com>
X-QQ-XMAILINFO: Mrv6PNPZjcp6xxCecALPcHbA4h6sD5OnU4pfgtJ5GcpkdxPxE/zW1HbCXHGX+0
         LN9b6UbRqOgu7PtrFF2HtcnWoy8lHG/KsZOHCeenkYPO0jLpMr5yU1kkT+ChUpPvuzWwfuFCp0nc
         ISzHFvRq8t3lP75VuYTtMjqiOrjwxczIUUFiTqCh00tCM5UA3Wp0Exc2KaN1h1ybZQl6AR19k0fX
         FPPmIm+fwVb1VZ8pL3MrQ6lqP+dOre0gxoJRKFeHpnLeXJrRG3WOtxnKtYNRt9OGMMPZ7UDQ2xbK
         /vqX/H9S0cdXd32wsgFjnBwp3Basc+QrjerAyuSrohJTYXGrx8pVw0/roB2MNzp2NXqAnfpuwufg
         RAqKeajRSTQPHRQzNtCWXoaF7mn4N9WZrqYCMHW44wwPWw9PkGnsPHr3btIlw0HModR5ORXzisCK
         5vYT+Kagndgdqq6QGuBlkwJJsvDm0aZNo0wwXhp5nvydcWl6cd8MgJb1YpXcEmzVSpNfnBpKkTsQ
         EXfGIJf6IvpMi2cMvpYRTuwm7CxHDoPhR7Ws0t2hJjcK4eOR668ChbX0jxd6btbksL+X+QTG6csd
         cL74h7oQ6YF1RIsunDQzBhMLYly+qfNsfi5rZRl7con9X7LgMopys/GL8jSfjhHVFwFKzYMV9n0S
         AO6mBi1BMGZWSbFKyoGOUfqRGidSq31PGN8gyELZiZInGI1FXWzo6SmKTwULKATCyLDqyQItxtXs
         dC4FVciebeZBMYOSAroaP9/ojspOX4jVBZmP3WGV6mQPVuZ/KtXkHuLWLO9TWND70y4p2di7M1tg
         zdc+RpZgQei/OwslZNkUhX7SWLYos1U2ssTwlUX3nRWPZzlfksUNpQSfiEF60id0H6LADQYHwbaz
         qOQxAo9zuZp/P11lLpGe0ypu3yjSmQAPT0zyEAE6ViR9yreIhD5wT6SIek//pszXQ9aTu7PGXCWe
         PGHFMaVJyMOouxbceyICiX8+KQ4QwrWo76CNdbHEThqzwwUtyg3IDqGeubBaFFEKCQeQL92Wc=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v3] staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
Date:   Thu,  8 Sep 2022 15:31:25 +0800
X-OQ-MSGID: <20220908073125.2232-1-xkernel.wang@foxmail.com>
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

In rtw_init_drv_sw(), there are various init functions are called to 
populate the padapter structure and some checks for their return value.
However, except for the first one error path, the other five error paths 
do not properly release the previous allocated resources, which leads to 
various memory leaks.

This patch fixes them and keeps the success and error separate. As there
is no FooBar device to test with, no runtime testing was performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
v2->v3 update the description.
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 60 +++++++++++----------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 0a8c24e..1bf6fc0 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -664,51 +664,36 @@ void rtw_reset_drv_sw(struct adapter *padapter)
 
 u8 rtw_init_drv_sw(struct adapter *padapter)
 {
-	u8 ret8 = _SUCCESS;
-
 	rtw_init_default_value(padapter);
 
 	rtw_init_hal_com_default_value(padapter);
 
-	if (rtw_init_cmd_priv(&padapter->cmdpriv)) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_cmd_priv(&padapter->cmdpriv))
+		return _FAIL;
 
 	padapter->cmdpriv.padapter = padapter;
 
-	if (rtw_init_evt_priv(&padapter->evtpriv)) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_evt_priv(&padapter->evtpriv))
+		goto free_cmd_priv;
 
-
-	if (rtw_init_mlme_priv(padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (rtw_init_mlme_priv(padapter) == _FAIL)
+		goto free_evt_priv;
 
 	init_mlme_ext_priv(padapter);
 
-	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_xmit_priv(&padapter->xmitpriv, padapter) == _FAIL)
+		goto free_mlme_ext;
 
-	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_recv_priv(&padapter->recvpriv, padapter) == _FAIL)
+		goto free_xmit_priv;
 	/*  add for CONFIG_IEEE80211W, none 11w also can use */
 	spin_lock_init(&padapter->security_key_mutex);
 
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 	/* memset((unsigned char *)&padapter->securitypriv, 0, sizeof (struct security_priv)); */
 
-	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL) {
-		ret8 = _FAIL;
-		goto exit;
-	}
+	if (_rtw_init_sta_priv(&padapter->stapriv) == _FAIL)
+		goto free_recv_priv;
 
 	padapter->stapriv.padapter = padapter;
 	padapter->setband = GHZ24_50;
@@ -719,9 +704,26 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
 
 	rtw_hal_dm_init(padapter);
 
-exit:
+	return _SUCCESS;
+
+free_recv_priv:
+	_rtw_free_recv_priv(&padapter->recvpriv);
+
+free_xmit_priv:
+	_rtw_free_xmit_priv(&padapter->xmitpriv);
+
+free_mlme_ext:
+	free_mlme_ext_priv(&padapter->mlmeextpriv);
 
-	return ret8;
+	rtw_free_mlme_priv(&padapter->mlmepriv);
+
+free_evt_priv:
+	rtw_free_evt_priv(&padapter->evtpriv);
+
+free_cmd_priv:
+	rtw_free_cmd_priv(&padapter->cmdpriv);
+
+	return _FAIL;
 }
 
 void rtw_cancel_all_timer(struct adapter *padapter)
-- 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4124EDFF9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbiCaR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiCaR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:59:25 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186B223217
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648749455;
        bh=XhKQWR3BGW0/rNU3IYozp58rwLwhq1yx0fsceKajOxg=;
        h=From:To:Cc:Subject:Date;
        b=AueJLs0kcWagvSouu0KB0puO5V5UOazzR859YGB+6QyGYcVUTwRabWryBPqXYZFv4
         MfQfn7m7hX3N3MVWSudPKiKv1aAUq1zAFe3B/dMtkty5cWULgM/jKjfNBFEOnSfk66
         0FA9IpqPoU0PpX8YRaOGwssprOJhT1Sd2wk7LXVU=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id E6094825; Fri, 01 Apr 2022 01:57:32 +0800
X-QQ-mid: xmsmtpt1648749452tklbwi7jk
Message-ID: <tencent_DA99AB72BB38FA297CC29394C8FEB5407C09@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQtNO8Egt+c+zUxwIuRKyP1i3lU8ZDsKr96KrLc7Aog2wORKPrIt
         WVbikKfBTnDzPbr/WUIwkDOwAq1zxekQZ6w9bBcBY+wVLl5kwlOl/WgiAckXr97GnJt5EcqOf6ZE
         RwDGWPiAyEScEo4A8ySZy1Gz78ooKP3lKDVgARbu6OlAXWsRyLTKdlTMTmZgP1P/JONVzV9WYNaS
         /1Yg9bEX6zjRHMjOnLt5G/PnU/JaOsRdoLhPzKXsku938vRUmLbckBlpusstT5ZlgnnMylVVAT8c
         NW9xlMQAOS7mz9j3Y3H55+pvfPvr673rpvfmlMfBLXAmnNybARoyf/hwRmOg8yd03As5xYxkuDJA
         pK08wnEt/xqYvl2o6063XxDDhjy9N2vA1tq5s9exSCgfvsi/9aJaUKXgx7fN4B1Ivm8+Mh4cF2hm
         WNKUynfDZZ+TQqdfN6Gzcwv32yukkI1EWKQm3QM/mgGSTImbkC8KYyjAqMNgxv5IEc70k6AQWhrp
         u41SB4zwttZQPwCIEhP/subs31/eYWxjlBWSwYwGI8pXGE680/BVWpVkXU47QEkZZLnVY/Qzgopi
         aEHYz7QTmwpIhvfLo7wWkV/evDl0CwK2Oy6hDb9C3XZ90UR+KZ79ad4gS8KRArcJ82srekWuHeLm
         /Q1nlvj8F6oV3Zgw25oS2q+0Y9ktGSJF+5TXjNLTHXpIPfdfNWwU6ZdvQddCyZY+dbqSab+jYjB1
         6tyIgEsEOkuBfharigC/o0GsHNQJWWYQfcOteW8OzFwxwqZykjN90IE9eXq1y0lklfqitt0F5TtL
         q7MRsoE3XVbJKxvYoEaVecyskV/Vt8VM+im9dKUPOvTj5YtA7Ox04Cl8E6P3/bGoCBNHBH+YLZcT
         TiQmzg6get2pnv5NOwCSMXdrZQCg/nDpxc8Y+6DECFrS34LTPC6hs7KbFAH6fvOIeROnBegrPQn7
         NZyyW1ZNg=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
Date:   Fri,  1 Apr 2022 01:57:20 +0800
X-OQ-MSGID: <20220331175720.10009-1-xkernel.wang@foxmail.com>
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

In rtw_init_drv_sw(), except for the first one, the other error paths
do not properly release the resources allocated by its callees.
This patch is to free them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
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

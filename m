Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B734F5AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357792AbiDFJcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1582058AbiDFJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:21:43 -0400
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EFE1717B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 20:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649217050;
        bh=NKBQjU5IhN7Smi6bhWovIayNOgoinAmwlLxAmwsJtL4=;
        h=From:To:Cc:Subject:Date;
        b=JwWrKzjxxAel84uiu5CHpI6cfZzbwbhhRZ7gMaEbdCw34yOr3W9hKL2gTeYfrEX0U
         k+BJBGPaauwcoBxJktYekWXQPlD6+X3fms+1Hfz+/N2OWoc75LC3t7DpbrIV8sqVyi
         yENDm9LbfsdYvjnrLfNJRpiHoUga52EaMXbqTS80=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id CAF15C39; Wed, 06 Apr 2022 11:50:47 +0800
X-QQ-mid: xmsmtpt1649217047t2ia44wgy
Message-ID: <tencent_4387F32851FE6B81C0329BE44E719450440A@qq.com>
X-QQ-XMAILINFO: OaoBA5NOFC/jwAQ1vk4YzPONfF7qyLOhF15ze7ebY/CHnYf3KXrIF+PJDkOgyw
         6fJ63tPd8vv8i0i7IvA+m380u3vlfSQQcBzpLNlmY+RWbpb6+nlEATw5DsgD39jpg2mUJfe6SNnA
         pCsYkBCvN7qmUfHpirVNMYEBYr8tl8U7W+XTtJIFr9ebcZh6RmU4bPBxYJ7KXfna7wVpcjeN4gX8
         IXMD7BEbYOjVsIZUMae9x7REpvDi8wEQis/bsCu54gbx3XOYQQ/cFr08Y4iQ21k+HhmEqvtkiomH
         7U0VhYSj9Cho6a+MwpQaMoRPp/PmgdD/Ren77He3JhIpaEpfl4g/NsJXuNjEJ3rW0COgakzdzhe7
         DRqodi31nv6PtxOk8aPwv1ge68JaG8EO4UoP6Bv2PGpZ+ubJlOfwN4GW+MI60168vEXF5lr6FRfm
         8z6bRC9lyit+6ellocGyO1naSMGfaLv4Wi1iI0PMr4zbw6q3aIXPPd9oKXA2V/CVf2fa4apfd8gd
         G15NkK6ELJJ6/qK2rsMq81ktprl3A/eNrm7QkbDb2bbaNPR6YoA52F4EtYl99gYoF5aUrVhprnKs
         GUN2ELB5KjL65hFAJ6BOBut4uFGWCibQYcK9BOEhlBCXFGEzmFk5nzuC/7LIqEEY9pEDL0sCcuj1
         s4GRV6v4EpazL+yCN3jjDXL1H5HnWAJ8apA82mbfjh6U+iGBkOiWlQhV3iV6DWamUfmgYAepM2Eo
         TVREaOc4JpPPPqs8FAtkmgZV0xsap0ITiucDWss+lP/87HYQPVtiWl+xUJSLjdp6SkXP6BaMW7K+
         AoLswbAT3JGqLSilD3nONWv2TCiXjG+OBtMjcFyVxDLWh4PC7/BmS4eWRlahay9uVLvj48DHhs41
         EAFB1ykwEFmBaKLxQx/SqogyZ72MUWwKhva2Tuk1BPHR70H4f93q1EcCJLJ20/qdqvsEdV6qGeWd
         S6Q//0g0NDBUpFscBADXDzrRIJW3Nv
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: rtl8723bs: fix potential memory leak in rtw_init_drv_sw()
Date:   Wed,  6 Apr 2022 11:50:33 +0800
X-OQ-MSGID: <20220406035033.12771-1-xkernel.wang@foxmail.com>
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

This patch fixes this and keeps the success and error separate.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description.
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E164F2168
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiDECuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbiDECuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:50:11 -0400
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849F1BB19E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649125663;
        bh=Ms67zyBdNV6hrxEaPT360CJpu7jbKuKGKMPZ/d3UlO4=;
        h=From:To:Cc:Subject:Date;
        b=jI8TLh0MCXxFl+aH5xm+9Npb/oEWTH5wwfnHGaJSCLKPKngwXg2JWgjUT6HRi7R4T
         JlGmxzZ5QQGL3Rgy++coO5DMZTvgNfIE5tX7n6P+Hk0vOpwVmQ/sdUFk11FnEwjxak
         PN94yqlKtXCb56xNUv9QHTMxDV6WheYgDOCkUIuQ=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 6E804CEE; Tue, 05 Apr 2022 10:27:40 +0800
X-QQ-mid: xmsmtpt1649125660t9z6hhdk4
Message-ID: <tencent_FCEE3D8703C56F78B552FEFF070817736606@qq.com>
X-QQ-XMAILINFO: Mv3le6n+CjtdFPofKatnGY7vR5sSKoj1wt14/b6/rM15br6fjRBKA66dToNbUg
         te6DlAnhPi7E2r3czmflgm8TK9fEe9cBdHknXytTp5C8ZNKDWL1jWBZBw8PByB9gVnI2fxyRJW4g
         BqGX86UnpqC8sTGz1LOOFcKZmXUVgx4hyg49mrJor142N5Xiepky2cmwrKKMO4PlBOkFMQFbkgVL
         XTS6FhhuiPXV0GF6799VuDeyxn4TaS4j4yEkpQOc9axe/rzjwNkb7edpCmUL7QMfAcbFClQgRsOt
         5W6T7MTE9UMch6GX2l+ksJ1VsevmrT8l70vtrwCsY7EyvvE5bUQR8lZzu6vTfBHebWRUkwxXXhub
         OM7PJdy42pK5ph1ZeCx/pBvbNGPdrZ+9nEnfEANenQODmS7/V43hO4Cz1pJDd/l5QuuVIqgZBNlo
         YfAUmghyrfDEMjZldsrERhjmW9mpheFmz9dA7xETg6QbuIxasIlNFHsQbNzlzR6fkKLSiqNpvsVZ
         lScdH0Y+tmlk37NM8O5a56vjAq5h5SLKU0iIhiwidaM2/9miJFHiJYQTAcFIif1UxQlmaFxfMKPF
         tZbqgrwKf9/PyFEeFGgKIKlYIDLccxpaMxHyOZxtjedVIaohoDOO+dJav8bM0bp1l3KfKseC07Jn
         gK4w4qm0xHRLX4nV1ZuB7SSXV737L3YfiQUgwCo1JG3K5gGc72FjrZ2B7QUWuITCeCLmrOvyU0ho
         yxIHUbrfSygnLF3wnPbAJ7Eke19HU2CVooNC6PnabzLGgCCj4jLt2InvpqI5P+Io/Dn1JHtIhWaP
         1bnJoqkeMvJMpa+pKQwQcL5K5T4TvnaEKVeCvxF1jYA76jtwx0Ir+uuXyWM7BHqaDuXg8g3talPV
         ZKec/De+HdwFWF9jIZVFvh94p4GWoD6uRxh13zEd0zGWPtnQ68UcNFNyHXURQYF1aAxBR9P+Stgs
         5s+sy/WP4=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 1/3] staging: rtl8712: fix potential memory leak in r8712_init_drv_sw()
Date:   Tue,  5 Apr 2022 10:27:14 +0800
X-OQ-MSGID: <20220405022714.10949-1-xkernel.wang@foxmail.com>
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

In r8712_init_drv_sw(), some error paths do not properly release the
resources allocated by its callees.
This patch is to free them and provide proper error handlers for other
error validations.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 adjust the sequence of the patches in this series. This patch is
for providing proper error handlers.
 drivers/staging/rtl8712/os_intfs.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 9502f6a..1f7ccec 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -304,10 +304,10 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 	padapter->cmdpriv.padapter = padapter;
 	ret = r8712_init_evt_priv(&padapter->evtpriv);
 	if (ret)
-		return ret;
+		goto free_cmd_priv;
 	ret = r8712_init_mlme_priv(padapter);
 	if (ret)
-		return ret;
+		goto free_evt_priv;
 	_r8712_init_xmit_priv(&padapter->xmitpriv, padapter);
 	_r8712_init_recv_priv(&padapter->recvpriv, padapter);
 	memset((unsigned char *)&padapter->securitypriv, 0,
@@ -316,13 +316,25 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 		    r8712_use_tkipkey_handler, 0);
 	ret = _r8712_init_sta_priv(&padapter->stapriv);
 	if (ret)
-		return ret;
+		goto free_recv_priv;
 	padapter->stapriv.padapter = padapter;
 	r8712_init_bcmc_stainfo(padapter);
 	r8712_init_pwrctrl_priv(padapter);
 	mp871xinit(padapter);
 	init_default_value(padapter);
 	r8712_InitSwLeds(padapter);
+	return 0;
+
+free_recv_priv:
+	_r8712_free_recv_priv(&padapter->recvpriv);
+free_xmit_priv:
+	_free_xmit_priv(&padapter->xmitpriv);
+free_mlme_priv:
+	r8712_free_mlme_priv(&padapter->mlmepriv);
+free_evt_priv:
+	r8712_free_evt_priv(&padapter->evtpriv);
+free_cmd_priv:
+	r8712_free_cmd_priv(&padapter->cmdpriv);
 	return ret;
 }
 
-- 

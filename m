Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9333B4BA467
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242531AbiBQPbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:31:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242528AbiBQPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:31:54 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E83DEF7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1645111891;
        bh=FihfJldaJ6r2xVuFS8/jwCVqViJT/Juw+yF0fIUwbtQ=;
        h=From:To:Cc:Subject:Date;
        b=EEMDUMO6rPmbsPDc77JEeADLmFBW80Cke9UFh0rjyBm+jucSVBvpOSoD3lSsCbvk9
         OyOgXfqHy5jDiXfnd2e12B+mp9IOcxxb5YcLlc+O31wafa4UCdhmRXoaMIpzRzXgzj
         M2z5QPTYtNX91rEk9NiG+xVM5XpjBgxrrGP1D4gk=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id 78DB94C8; Thu, 17 Feb 2022 23:30:13 +0800
X-QQ-mid: xmsmtpt1645111813t42y1perq
Message-ID: <tencent_A552D77F0E081BB36EAE11C720455D78BD06@qq.com>
X-QQ-XMAILINFO: NOIkHYnr7VzdBovMCoZOh3CgEwz50dkDvRc6BZyxzTCU3rAJPriHHKsqJamEwf
         VdPGYFBsRcZoPeYLk8uLvbaJZ0wFt5irk6lV4nYWFpFSbHk9wK8V6LkC5Ml65QlyybE6k8KEwBXD
         XJBsdH/FZglrztGCURRy6n8/R+JiaI0SpO2SZPLkyrB+AnwMfAcA1F7avwZnbosFvCgv6b7jMFN/
         nLyQW600y5Aukd1l1k9+c4NGfCIJGIj9/tM/Ytt7z0YFl8QEVzXs5gj/TI7uF3s211UQfKtAUVPu
         0cxVc4D9L8gUKC7Fnvcg7L0JUyDiPpRWb2Hzq2NHB3Yn8t2GKGx+/qLSzmNKtPqES4FJoto9RtPu
         SRsCJ+JVczQ/b3dXnGyGPNPXCrCsn42KmdpnB8A3cHQVE+in/vTePGMtK3LDTXJmfkkk4/vGdSQD
         jcOrmhI6vB8w8peswhimI4T2lhmthG6NbgtT0pxoS6uVSyCRjMSaG6+eyIS75lBn/ogdEAAYn7g+
         Fe3AgeKI6RJ8SHlbcVaVDPng2/Z5UH6MlRbPyhMprsWA3CxqNbDNY8AxlxxrRaWfciwIB0PBlsnW
         rqFP4mJ9/0oWy3NWYJupuLRy9GaUTT3lnmQ2pBobQmJDBW0zA2ttD3Vs56KCLfjEBa5ZgiafoJz/
         sp9XjjgmPXmMHAYEyigWV/aEn2Rpn+gdINQgQ4klxaInAqMAdU5fhcr7cAKaIS704DNhlNR3Zlmu
         WSdEAjnuDt2XPtN6qs4vO+ruimDrYga49LD9oldbxJqML0IF0QbMr+GvJJLfoY/lujK/wmZMLebz
         0yT0XxAbJ0Bqgi5R6RdD21BjDBMLCMZRTzmiUg3YdmM8Gy3dxHgLkbRu1pcrJR+O3w3EK0EIOPjh
         T4hMlluvs13xUgt6UJczUpukrEUJnogqGmIAbd478pzui1o7Xg+sEiFTPcRJM0cz75Ev2sFj6W
From:   xkernel.wang@foxmail.com
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: wfx: fix the error handling in wfx_init_common()
Date:   Thu, 17 Feb 2022 23:29:06 +0800
X-OQ-MSGID: <20220217152906.1029-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

All the error handlers of wfx_init_common() return without calling
ieee80211_free_hw(hw), which may result in memory leak. So I add
one err label to unify the error handlers.

Suggested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/wfx/main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 4b9fdf9..f83df9f 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -309,7 +309,8 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->pdata.gpio_wakeup = devm_gpiod_get_optional(dev, "wakeup",
 							  GPIOD_OUT_LOW);
 	if (IS_ERR(wdev->pdata.gpio_wakeup))
-		return NULL;
+		goto err;
+
 	if (wdev->pdata.gpio_wakeup)
 		gpiod_set_consumer_name(wdev->pdata.gpio_wakeup, "wfx wakeup");
 
@@ -325,9 +326,13 @@ struct wfx_dev *wfx_init_common(struct device *dev,
 	wdev->force_ps_timeout = -1;
 
 	if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
-		return NULL;
+		goto err;
 
 	return wdev;
+
+err:
+	ieee80211_free_hw(hw);
+	return NULL;
 }
 
 int wfx_probe(struct wfx_dev *wdev)
-- 

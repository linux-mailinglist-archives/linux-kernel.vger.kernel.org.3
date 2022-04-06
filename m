Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25E4F57AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiDFHF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447544AbiDFGj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 02:39:26 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB40424879C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1649219405;
        bh=SW7cCxbNw7fP/uh78qTenXR+2MZct6mcKLxV49Y5gMI=;
        h=From:To:Cc:Subject:Date;
        b=EkvD29I7n+opEYEqlP+ejzhcOEPhO55hc8BAO/7zF66LKjJMUSJ+TKUEQ9DChRO2l
         n7zMWcAjPQbVYMML8HMBbG9i3ynYN9ju2rNv96j1kBjkiOWCyN75oNb6xYiJeaJ7lt
         Tn4XCtdXE52Zt3cQ2Bo+LPJkqthCZCBLyLrXmA6E=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 7829ECDF; Wed, 06 Apr 2022 12:30:02 +0800
X-QQ-mid: xmsmtpt1649219402tp1cwvijp
Message-ID: <tencent_5AB92A7786438342357C5669E7BF0C249505@qq.com>
X-QQ-XMAILINFO: NddGNcM70cPAn0dAvnaiD1hQr6vG/nJbcNjebT2nXn1KoP7NzirpfE3fK94qMT
         d5Ed6KskMHmRJkapWFhToWwPu4kf/PvEq/13GpvYuH+KyfHors5kI1GzZPwSEO80Y/KfXXF0wE5J
         1LntFpaybi8aKw+UwxIf0hcnjxsZyDVJeyaKXYPfRnE2qAm/vaUP7m6fQ9+hDotNTXGTzfCnRwKf
         6GgkEOQK/G45kgFaPhlMn6jjLuMteIYTsm/GjUmiHC0CoHPBSkrsx7dTNqlmD16qNAc5lr1rTdTC
         deApv7V5lwdbZXtNsAmxsXp7eb17+8Aro7cXZg8U2nZyGuuQpglS38Cz7D9VSbZ6w+LCWhciYpm/
         Wj8nNgbiABpuFfHEHvCovHLCGh4ewCmwKYAheVAXKBn0TSwAvwIS2tLY6WMHLmpUyQITR7gPV3TT
         VLIaLdXRZz7Cq+JJ30EKz4bKo39XqlUmeLA8GHenL7wVnSFfXv7j+y8eMwOBV9fQ/iqV5z6lXkxp
         7KpDWEZKOfA6B20qhMLw4h4WmSRIl0RwIn7SuiOj6A0B6W3TAeRH7V3XjfF7rBDFis0VzX1yyT9b
         5cqOdpYnh18ZcrKKE9GpL2mtnrmTvea0B4CqX4yNE+ujzMPV/U4sjQPQepSohNAihGcxtCgksATg
         x5eUDaKfR0T3UntpnVk4rwXwCPs717mecH5V1xQfqJ+a1Z7P8vBEVVkSXLWpvyanEE8w6vyxc1Q5
         b1dwdllZM/zxQw9k9MVbIk8+MxA6rRjjNixoTXLdU7ruucAWwcnnLn+eHF+dkfin4xKZ4BfST9Qj
         DbiAXSMEqLJYTlyR5HYdbZnANTgnO6LMsZtiIV5gqQTfhWD4JaJflgdSn5LV2mY0vKwPfl4NAhs5
         HeiNJMKkrieZAAD9LUJHbc2kJMpFXAT5gMMSt6GwBDDFyXfrIGEOMq577e625gxLTbmUI0pFpTOC
         GOaxY4KfKMVU6GNAIpoCqE+CP5l4N02dGdhrBImTY=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 1/2] staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Wed,  6 Apr 2022 12:29:52 +0800
X-OQ-MSGID: <20220406042952.13372-1-xkernel.wang@foxmail.com>
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

In _rtw_init_xmit_priv(), there are several error paths for allocation
failures just jump to the `exit` section. However, there is no action
will be performed, so the allocated resources are not properly released,
which leads to various memory leaks.

To properly release them, this patch unifies the error handling code and
several error handling paths are added.
According to the allocation sequence, if the validation fails, it will
jump to its corresponding error tag to release the resources.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 update the description and adjust the sequence of patches.
 drivers/staging/r8188eu/core/rtw_xmit.c | 32 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index aede8ef..865b2fc 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -134,7 +134,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL)
-				goto exit;
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -152,7 +152,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -167,10 +167,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		pxmitbuf->ext_tag = true;
 
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
-		if (res == _FAIL) {
-			res = _FAIL;
-			goto exit;
-		}
+		if (res == _FAIL)
+			goto free_xmit_extbuf;
 
 		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
 		pxmitbuf++;
@@ -200,8 +198,26 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtl8188eu_init_xmit_priv(padapter);
 
-exit:
+	return _SUCCESS;
 
+free_xmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+	i = NR_XMITBUFF;
+free_xmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	while (i-- > 0) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
+exit:
 	return res;
 }
 
-- 

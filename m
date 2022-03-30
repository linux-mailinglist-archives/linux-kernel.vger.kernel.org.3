Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CDA4EC847
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348224AbiC3Pbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiC3Pbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:31:31 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F9027B63B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648654183;
        bh=2kFT5J58imCM6cAJvQUpFPPND4IVxoCOLpVYRs3gNjE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nizqGVUuStshOyYKkpQihx5WJtV5CQ0+giMiwp/6XUDzGeVjwnak8fbmzAkh8iwx5
         dgJGaFMIEmPQRA8VghwDQ5Ohd5n4RfSIJijRRpysX5MliHY0u6fXRzcfC2PQvjW5H9
         Xh/+TN35p/sbBnpoHDXavZAGH1jQkm7WGIv1QqVI=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc6.qq.com (NewEsmtp) with SMTP
        id 76822865; Wed, 30 Mar 2022 23:29:40 +0800
X-QQ-mid: xmsmtpt1648654180t9zu1x60r
Message-ID: <tencent_2F72CC5068850B2BEDFC2B8058303FE6520A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjlcvuejhie0UE6esMkUAvaRuIy3cmUuk1VM9xSt4JsRol8HlQCy
         cwtNMvUbxCi8bqItKuivmtouPFEjzK2rjgo+g2LsB1A/muZWwhIIAqMmy6GQLqYoERexMbt6tw3h
         kGzIFR2VruIhdhZk/qs1eSLihvPfdBtRTDovIMhbF9dR4cvMUaYJ2zD5LHbgi6waazCgNcmkhpY0
         NBvVMFLZV63ZK11wi89l2OeqxSvdaR9sQ8pTL70tPgBdhOP3ZfPAv2P5O/kNxM4wnTdT+OTaqBAR
         Sre2KNdewRI//H/cBF7jXgyNEc3NsJxzFeoua7A0/9ccLqR89K8iq8l95LfYdrshy/mWZ9EteHO5
         BmtLSqICSr+qU3VaGo1wQWAO5CFXZSB2ddoxtkH5dBqIgouWcgsl5AB1SE699vlh4p7yj/80vWQm
         Oki1jJ6ucGu/jJRYyAz4Q0ywRFLOOXnLVuTvAJocgcdpi2cfm9VD3ia5aYyQBS8OX1tAIHp0ggJK
         EwmcV8JkvOsMcYHQf9nQCdalLEj4Vz+Jtvqn8Z/1kAJh8RnHDglo5m36FAdXTDUlM12el/nMxBub
         6xGKcxmRN7cPVQbR43/8CIdkgzUCG2cWoXcYeVagoDKpaTLtskqSeLerJF9MJCg+siWAoADTu0Q3
         z6mfaOaj5lSPIaSWRN9kSgOcodnU7zI2wp1obABi3uZSdZGKrRzQK/UJTi+vm0j+Fw/+HNlRc2SH
         IQNqIYVdpSesLKOmOwtUemBgcaUwh+vhCaSktA6cjI8fsNx4LN8+jN1lyMWCGWVAeYmMwk5XVlu9
         dE3TgQ9SwG7gNefl+9Ff0aAY7xptXQGcvxRuzcFATH0vAngdFdWQHR8aJTnReuAaIgTSkv9Jr7T0
         hxFv5Ute5X815k2DnIWieQqZW0zibm/MlAc6WMh2Vpf/q41RoC/K7LBT8RODHZdy9hIzrp4hsk1t
         aFt4Kj6QOsNSs732k0+Bek0MSS85cqsDOx3kR2kXrFkwEFCxV7W8G2FHc44LAF46F4H285qr0=
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH 2/2] staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Wed, 30 Mar 2022 23:29:22 +0800
X-OQ-MSGID: <20220330152922.6662-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
References: <tencent_12789CD2DEBF33C818B3542E170737854506@qq.com>
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
failures without releasing the resources.
To properly release them, there are several error lables and some
modifications for rtw_os_xmit_resource_free().
The `for(; i >= 0; i--)` is to only release the explored items.
While the modifications for rtw_os_xmit_resource_free() is 
corresponding to the logic of rtw_os_xmit_resource_alloc() to break 
unintentional wrong operations. 

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c     | 41 ++++++++++++++++++---
 drivers/staging/r8188eu/os_dep/xmit_linux.c |  8 +++-
 2 files changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 5888979..813bddf 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -134,7 +134,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
 			if (res == _FAIL) {
-				goto exit;
+				pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+				for (; i >= 0; i--) {
+					rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+					pxmitbuf++;
+				}
+				goto free_xmitbuf;
 			}
 		}
 
@@ -153,7 +158,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_pxmitbuf;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -169,8 +174,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 		res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, max_xmit_extbuf_size + XMITBUF_ALIGN_SZ);
 		if (res == _FAIL) {
-			res = _FAIL;
-			goto exit;
+			pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+			for (; i >= 0; i--) {
+				rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+				pxmitbuf++;
+			}
+			goto free_xmit_extbuf;
 		}
 
 		list_add_tail(&pxmitbuf->list, &pxmitpriv->free_xmit_extbuf_queue.queue);
@@ -181,7 +190,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	res = rtw_alloc_hwxmits(padapter);
 	if (res == _FAIL)
-		goto exit;
+		goto free_pxmit_extbuf;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -203,6 +212,26 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtw_hal_init_xmit_priv(padapter);
 
+	return res;
+
+free_pxmit_extbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmit_extbuf;
+	for (i = 0; i < num_xmit_extbuf; i++) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (max_xmit_extbuf_size + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+free_xmit_extbuf:
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
+free_pxmitbuf:
+	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
+	for (i = 0; i < NR_XMITBUFF; i++) {
+		rtw_os_xmit_resource_free(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
+		pxmitbuf++;
+	}
+free_xmitbuf:
+	vfree(pxmitpriv->pallocated_xmitbuf);
+free_frame_buf:
+	vfree(pxmitpriv->pallocated_frame_buf);
 exit:
 	return res;
 }
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 565ac5b..7aa39b5 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -95,8 +95,14 @@ void rtw_os_xmit_resource_free(struct adapter *padapter,
 {
 	int i;
 
-	for (i = 0; i < 8; i++)
+	if (!pxmitbuf->pallocated_buf)
+		return;
+
+	for (i = 0; i < 8; i++) {
+		if (!pxmitbuf->pxmit_urb[i])
+			break;
 		usb_free_urb(pxmitbuf->pxmit_urb[i]);
+	}
 
 	kfree(pxmitbuf->pallocated_buf);
 }
-- 

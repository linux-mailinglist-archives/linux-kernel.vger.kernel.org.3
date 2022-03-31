Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679E84ED810
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiCaLAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiCaLAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:00:30 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85AA4990F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648724320;
        bh=nC8dQ7uRLas0XLiNq+JhgvbwYYcBQdgbkee7bW4IQwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LWQBuV+djQdnGJEt4o1qWun30vLDmZdfkJE2hkDyLST3lrL6tYj1f9LWucaZbfUXy
         Bpn+Kj+IPoG2eNPPKr3tSokci9sWKj35R4yOLOznUJ7SeO2bREha7ALZd2IyydO91F
         tsYpFMnR+69+lgwVKLCceO7baQTiFImHrlqfIzSk=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id EA302AEC; Thu, 31 Mar 2022 18:58:35 +0800
X-QQ-mid: xmsmtpt1648724315t8977q2fg
Message-ID: <tencent_A5280DFCCB827030EBE73673F0510084970A@qq.com>
X-QQ-XMAILINFO: NK7mH5+t7Gn7WWAdexxdQcWzT7csSrC6zIsF8JUt1dGBUmpt+vVYkKv1Kgz4Mq
         I0Wo/oH+jP5LQI3acuPORnMg9LiyWixMfJtGI9z3Oc0fZm+jkhJthCS6ERZMr13sG9C0Y6TIEApw
         M9xyi6aljTQrGvTJ7ADqA3/I/NzLDHKGFm/76G3G7yNoha/NH8vtbpIdjlni041uWxvzhzjS7/Uz
         pn+qCYY6OItDBfdujpwRdACOPmUqqFMubzGwHNQjHIvkXdVa2K7EQY6G3BIb86xIzPSPtq2I6AF2
         UzZP8qzPEWscGq2FjmE57HDUkIEK28E8A+hK3MHNA6XlSCVwNnHkfwzonCR+3+eW+l16D0IhaVfa
         DjlV2VZHpY0yPx0FxOBI6As8aP5K/9157j2uzMY1wf70cKntlLD5+AbxpJAPcVvDyPWQrY/JbwdX
         ypJZAXPM13TXIQfqSYcJHzSAQIoJlNbd/O7j4weZnssOOvSJdsMH9bLZhaga3rXmqe6tmjm3O3Wl
         gnVVDh+6YeXjw8/+AuHZcgIahh6dbFL2shDVGGdwIKAu8DHDLSGosC2MdNKp3yjvE74VqwD+j5Id
         ifxdaZRyWJqtQmgWiEvH3vflhYIGYsPcS2yCp54r6oF/O5YdeBSulTRSRrzQUiTygBQNhS66/IMo
         YQkLzsbDcavk66d5pT+4SUJpMyufy0qhcFVDb4BDbHhW8xVfsr/TmZw/RLIvu/D9VEO3g8rk69BS
         jPO2dnx6Sk7DK4ch7bkF/SzAfLx505Q1L8cU9VRTHkjApslJSgx5moYw65a6dLSr5Le/zp+Tqzbt
         unJzBRpEFCH5HgWtOrpjlSKzBVGI6QO8IsQHPrk7ScY0UK1UOsG4pI4ZvawL9BuLxdDBSoXItmuh
         X3KkU1+0OJmm5+Vy9lUUQrItjf0FpumT5QFkjhMNuIui9Y86cYn3M+fep/ouRr/W+++uqBk3uQxI
         8mjSWR+cuvT+MR6q+JDuGRWd3s96giFlHWa0ihA0xFh3fZRt6JAg==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2 2/2] staging: r8188eu: fix potential memory leak in _rtw_init_xmit_priv()
Date:   Thu, 31 Mar 2022 18:58:16 +0800
X-OQ-MSGID: <20220331105816.8003-1-xkernel.wang@foxmail.com>
In-Reply-To: <tencent_254AD0FF06201BCCF5B9911C6E142CE1F208@qq.com>
References: <tencent_254AD0FF06201BCCF5B9911C6E142CE1F208@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
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
To properly release them, several error handling paths are added.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 unified all the error handling code in free_* section.
    remove the unnecessary modifications for rtw_os_xmit_resource_free().
 drivers/staging/r8188eu/core/rtw_xmit.c | 37 +++++++++++++++++--------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 299fe26..e6bbbf7 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -112,7 +112,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmitbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_frame_buf;
 	}
 
 	pxmitpriv->pxmitbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmitbuf), 4);
@@ -133,9 +133,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 		if (res == _FAIL) {
 			msleep(10);
 			res = rtw_os_xmit_resource_alloc(padapter, pxmitbuf, (MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ));
-			if (res == _FAIL) {
-				goto exit;
-			}
+			if (res == _FAIL)
+				goto free_xmitbuf;
 		}
 
 		pxmitbuf->flags = XMIT_VO_QUEUE;
@@ -153,7 +152,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	if (!pxmitpriv->pallocated_xmit_extbuf) {
 		res = _FAIL;
-		goto exit;
+		goto free_xmitbuf;
 	}
 
 	pxmitpriv->pxmit_extbuf = (u8 *)N_BYTE_ALIGMENT((size_t)(pxmitpriv->pallocated_xmit_extbuf), 4);
@@ -168,10 +167,8 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
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
@@ -181,7 +178,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	res = rtw_alloc_hwxmits(padapter);
 	if (res == _FAIL)
-		goto exit;
+		goto free_xmit_extbuf;
 	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);
 
 	for (i = 0; i < 4; i++)
@@ -203,8 +200,26 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	rtw_hal_init_xmit_priv(padapter);
 
-exit:
+	return res;
 
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

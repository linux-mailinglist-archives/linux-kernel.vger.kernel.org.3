Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7084ED844
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiCaLNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbiCaLNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:13:39 -0400
Received: from out203-205-251-80.mail.qq.com (out203-205-251-80.mail.qq.com [203.205.251.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C48654BF
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648725108;
        bh=elyHlnyePDXKN3P2xm16PGMA5PP2gZ61mI8T7iBUoRk=;
        h=From:To:Cc:Subject:Date;
        b=N6gOojrtwo8G4mXrmShY9gX2uuZHat9H6NXUBgYl9t3bv6uRufdPXmS/It9FyDXB8
         CQvvdWZfd0YW99w/PEgk+yhYjvWyp3+IKCDOXv16PkAwSbyXlgCJZ6e9kPfbvCPn6P
         9uNB01rpDdjpGJg0+LTcJN2S/PSo0/6WCd3ivCWs=
Received: from localhost.localdomain ([43.227.138.48])
        by newxmesmtplogicsvrszc9.qq.com (NewEsmtp) with SMTP
        id 2ECB38A4; Thu, 31 Mar 2022 19:11:44 +0800
X-QQ-mid: xmsmtpt1648725104tagn79hsi
Message-ID: <tencent_75E5FF1DC8353370AE0F4712454D78BC9206@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjTDt3SiOUav6tw+MCRYiTRtGQVKAlqhrPGowt5/T9fIFV60L30C
         hrQw0RwamAI8GGfFPKVNA+WEw4T8imN7Jc11+Uq1At7F5LzV+7XlbeTULSE8hOzvheFKi89BndAS
         iKDt+d5jeWoC9oU2vjCtKvAeJtNiEDL1GWKYniQF+rYZCy2Szun90dO0NLcC/LSXbOFBTg/DtVeU
         6xDRS05bisNYZbZjO0sJ67UWrWvPsTT/ALRR249kNA1WtmjM21AUjIvjMTP7QKWy0azWF42GIYsW
         YW5kiG4PHxKpsYS+3W6GGpSgClLvrqBF64lCZa+ob+au/KtrdAp70RvjeYTH2WGwmXg/nyWfTBpY
         GIa4R2hSDK2cLQHMesO0SfAnAaV/sXDmZcM6xYC7fCokf/Y+kcov35wa26LU9vyV1I/Fa9HeRUYb
         PlgY9ZP+H68LeJXIPTMw/NPu6e+kbBMhstxxNj1pGBMA+2yYCNLMOQ03vu+k07rZfP/yLcMj2GIA
         MaaURYe2Drcd37di8xiDtyZULqxmZPniD1J9FuZ/VRNVRYZInb1LAp9Oki2pUif1KQdIv19czxxP
         a2J5AwtrH+MbMf6xsD/qGzouFR5fcmzoXd7t5T2hUxo7MyQtk1W9s42Nmukuqu7V5bZqohg0VCEg
         3TCbTeiCj+pAiiuZ5a/SuKrdsH7doK99siknVfCN0Ol9FXLyfpE9NeDL+7JaVtw+THPWE9cNosmZ
         tReJrKtemhr6jyRNMD/7sc/3zpUkAbJTdcroensdBYNxCrKIPD6qeyvmVw3RS/8Os5RYAwCCs7ti
         c8vUdF5SAfceXkhRiay446lDL18nylOBW9Or8uLL+MaZ7B5htQXGEgb5j3YpXLCWs/RGx4ypkvAZ
         7oo2065STSBx5KSvrC826l33GXH+BU/YWCKW+QZsxg4AYRzR6w1fab1S6pZ0uVAdjIgaIwCi77bL
         D9yMeEBgDVA1/rEEQSsw==
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: fix potential memory leak in rtw_os_xmit_resource_alloc()
Date:   Thu, 31 Mar 2022 19:11:23 +0800
X-OQ-MSGID: <20220331111123.8113-1-xkernel.wang@foxmail.com>
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

in rtw_os_xmit_resource_alloc(), if `pxmitbuf->pxmit_urb[i]` is
allocated in failure, the other resources allocated by this function are
not properly released.
This patch is to free them.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/os_dep/xmit_linux.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index 8c3f8f0..5a59f62 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -78,8 +78,12 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *pxmitb
 
 	for (i = 0; i < 8; i++) {
 		pxmitbuf->pxmit_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!pxmitbuf->pxmit_urb[i])
+		if (!pxmitbuf->pxmit_urb[i]) {
+			while (i-- > 0)
+				usb_free_urb(pxmitbuf->pxmit_urb[i]);
+			kfree(pxmitbuf->pallocated_buf);
 			return _FAIL;
+		}
 	}
 	return _SUCCESS;
 }
-- 

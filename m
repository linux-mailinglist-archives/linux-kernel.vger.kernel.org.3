Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FF58CEF0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244046AbiHHUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiHHUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:14:40 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61061903F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:14:38 -0700 (PDT)
Received: from dslb-188-096-136-209.188.096.pools.vodafone-ip.de ([188.96.136.209] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oL98x-0000V9-BU; Mon, 08 Aug 2022 22:14:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: change all num...Q variables to u8
Date:   Mon,  8 Aug 2022 22:14:03 +0200
Message-Id: <20220808201405.68966-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220808201405.68966-1-martin@kaiser.cx>
References: <20220808201405.68966-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of numPubQ, numHQ and numLQ variables store only u8 values. Change
their types to u8. We can then simplify the REG_RQPN expression. The
macros and the temporary variable are not needed any more.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 10 ++++------
 drivers/staging/r8188eu/include/rtl8188e_spec.h |  4 ----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 18465e5ce9cc..25fd6b46e76d 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -154,11 +154,10 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
-	u32 numHQ	= 0;
-	u32 numLQ	= 0;
+	u8 numHQ = 0;
+	u8 numLQ = 0;
 	u8 numNQ = 0;
-	u32 numPubQ;
-	u32 value32;
+	u8 numPubQ;
 
 	if (pregistrypriv->wifi_spec) {
 		if (haldata->OutEpQueueSel & TX_SELE_HQ)
@@ -176,8 +175,7 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 		numPubQ = 0xA8 - numHQ - numLQ - numNQ;
 
 		/*  TX DMA */
-		value32 = _HPQ(numHQ) | _LPQ(numLQ) | _PUBQ(numPubQ) | LD_RQPN;
-		rtw_write32(Adapter, REG_RQPN, value32);
+		rtw_write32(Adapter, REG_RQPN, LD_RQPN | numPubQ << 16 | numLQ << 8 | numHQ);
 	} else {
 		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0000);/* Just follow MP Team,??? Georgia 03/28 */
 		rtw_write16(Adapter, REG_RQPN_NPQ, 0x0d);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index d9a85fd13230..011da538df5f 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -924,10 +924,6 @@ Current IOREG MAP
 #define _LLT_OP_VALUE(x)		(((x) >> 30) & 0x3)
 
 /* 	0x0200h ~ 0x027Fh	TXDMA Configuration */
-/* 2RQPN */
-#define _HPQ(x)				((x) & 0xFF)
-#define _LPQ(x)				(((x) & 0xFF) << 8)
-#define _PUBQ(x)			(((x) & 0xFF) << 16)
 
 #define HPQ_PUBLIC_DIS			BIT(24)
 #define LPQ_PUBLIC_DIS			BIT(25)
-- 
2.30.2


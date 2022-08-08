Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4F558CEF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiHHUO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiHHUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:14:40 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC04A1928C
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:14:38 -0700 (PDT)
Received: from dslb-188-096-136-209.188.096.pools.vodafone-ip.de ([188.96.136.209] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oL98w-0000V9-CX; Mon, 08 Aug 2022 22:14:30 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/5] staging: r8188eu: make numNQ a u8
Date:   Mon,  8 Aug 2022 22:14:02 +0200
Message-Id: <20220808201405.68966-3-martin@kaiser.cx>
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

The numNQ variable in _InitQueueReservedPage is defined as u32. It is
either set to 0 or to 0x1C. Change its type to u8 and remove the code that
casts the u32 value to u8.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c       | 7 +++----
 drivers/staging/r8188eu/include/rtl8188e_spec.h | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index b63f5bb21017..18465e5ce9cc 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -156,10 +156,9 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 	struct registry_priv	*pregistrypriv = &Adapter->registrypriv;
 	u32 numHQ	= 0;
 	u32 numLQ	= 0;
-	u32 numNQ	= 0;
+	u8 numNQ = 0;
 	u32 numPubQ;
 	u32 value32;
-	u8 value8;
 
 	if (pregistrypriv->wifi_spec) {
 		if (haldata->OutEpQueueSel & TX_SELE_HQ)
@@ -171,8 +170,8 @@ static void _InitQueueReservedPage(struct adapter *Adapter)
 		/*  NOTE: This step shall be proceed before writing REG_RQPN. */
 		if (haldata->OutEpQueueSel & TX_SELE_NQ)
 			numNQ = 0x1C;
-		value8 = (u8)_NPQ(numNQ);
-		rtw_write8(Adapter, REG_RQPN_NPQ, value8);
+
+		rtw_write8(Adapter, REG_RQPN_NPQ, numNQ);
 
 		numPubQ = 0xA8 - numHQ - numLQ - numNQ;
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
index 9e7b1f89037c..d9a85fd13230 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
@@ -928,8 +928,6 @@ Current IOREG MAP
 #define _HPQ(x)				((x) & 0xFF)
 #define _LPQ(x)				(((x) & 0xFF) << 8)
 #define _PUBQ(x)			(((x) & 0xFF) << 16)
-/*  NOTE: in RQPN_NPQ register */
-#define _NPQ(x)				((x) & 0xFF)
 
 #define HPQ_PUBLIC_DIS			BIT(24)
 #define LPQ_PUBLIC_DIS			BIT(25)
-- 
2.30.2


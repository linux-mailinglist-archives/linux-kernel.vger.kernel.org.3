Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6C58B813
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiHFT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiHFT4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:18 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658BEE0B0
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:09 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtv-0004Tu-RY; Sat, 06 Aug 2022 21:55:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 12/13] staging: r8188eu: we always use HQ and NQ for two endpoints
Date:   Sat,  6 Aug 2022 21:55:39 +0200
Message-Id: <20220806195540.777390-13-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806195540.777390-1-martin@kaiser.cx>
References: <20220806195540.777390-1-martin@kaiser.cx>
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

When _InitNormalChipTwoOutEpPriority is called, pdvobjpriv->RtNumOutPipes
and haldata->OutEpQueueSel have already been initialized.

_InitNormalChipTwoOutEpPriority is called only if
pdvobjpriv->RtNumOutPipes == 2. In this case, haldata->OutEpQueueSel is
always TX_SELE_HQ | TX_SELE_NQ.

Remove the switch-case statement and set valueHi and valueLow directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index a89db93840f3..fc4d25b835d3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -227,28 +227,10 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 
 static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
 {
-	struct hal_data_8188e *haldata = &Adapter->haldata;
 	struct registry_priv *pregistrypriv = &Adapter->registrypriv;
 	u16 beQ, bkQ, viQ, voQ, mgtQ, hiQ;
-	u16 valueHi = 0;
-	u16 valueLow = 0;
-
-	switch (haldata->OutEpQueueSel) {
-	case (TX_SELE_HQ | TX_SELE_LQ):
-		valueHi = QUEUE_HIGH;
-		valueLow = QUEUE_LOW;
-		break;
-	case (TX_SELE_NQ | TX_SELE_LQ):
-		valueHi = QUEUE_NORMAL;
-		valueLow = QUEUE_LOW;
-		break;
-	case (TX_SELE_HQ | TX_SELE_NQ):
-		valueHi = QUEUE_HIGH;
-		valueLow = QUEUE_NORMAL;
-		break;
-	default:
-		break;
-	}
+	u16 valueHi = QUEUE_HIGH;
+	u16 valueLow = QUEUE_NORMAL;
 
 	if (!pregistrypriv->wifi_spec) {
 		beQ	= valueLow;
-- 
2.30.2


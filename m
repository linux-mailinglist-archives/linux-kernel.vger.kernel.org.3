Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB8858B809
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiHFT4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiHFT4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:13 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3640DBF6A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:06 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtu-0004Tu-Vs; Sat, 06 Aug 2022 21:55:59 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 11/13] staging: r8188eu: remove _InitNormalChipOneOutEpPriority
Date:   Sat,  6 Aug 2022 21:55:38 +0200
Message-Id: <20220806195540.777390-12-martin@kaiser.cx>
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

When _InitNormalChipOneOutEpPriority is called, pdvobjpriv->RtNumOutPipes
and haldata->OutEpQueueSel have already been initialized.

_InitNormalChipOneOutEpPriority is called only if
pdvobjpriv->RtNumOutPipes == 1. In this case, haldata->OutEpQueueSel is
always TX_SELE_HQ.

We can then simplify _InitNormalChipOneOutEpPriority to a single
_InitNormalChipRegPriority call, i.e. we can remove
_InitNormalChipOneOutEpPriority and call _InitNormalChipRegPriority
directly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 25 ++---------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index f3314bed9285..a89db93840f3 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -225,28 +225,6 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 	rtw_write16(Adapter, REG_TRXDMA_CTRL, value16);
 }
 
-static void _InitNormalChipOneOutEpPriority(struct adapter *Adapter)
-{
-	struct hal_data_8188e *haldata = &Adapter->haldata;
-
-	u16 value = 0;
-	switch (haldata->OutEpQueueSel) {
-	case TX_SELE_HQ:
-		value = QUEUE_HIGH;
-		break;
-	case TX_SELE_LQ:
-		value = QUEUE_LOW;
-		break;
-	case TX_SELE_NQ:
-		value = QUEUE_NORMAL;
-		break;
-	default:
-		break;
-	}
-	_InitNormalChipRegPriority(Adapter, value, value, value, value,
-				   value, value);
-}
-
 static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -319,7 +297,8 @@ static void _InitQueuePriority(struct adapter *Adapter)
 
 	switch (pdvobjpriv->RtNumOutPipes) {
 	case 1:
-		_InitNormalChipOneOutEpPriority(Adapter);
+		_InitNormalChipRegPriority(Adapter, QUEUE_HIGH, QUEUE_HIGH, QUEUE_HIGH,
+					   QUEUE_HIGH, QUEUE_HIGH, QUEUE_HIGH);
 		break;
 	case 2:
 		_InitNormalChipTwoOutEpPriority(Adapter);
-- 
2.30.2


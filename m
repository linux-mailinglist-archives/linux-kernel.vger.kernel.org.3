Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084858B80F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbiHFT4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiHFT4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:14 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E97261E
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:07 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtw-0004Tu-NG; Sat, 06 Aug 2022 21:56:00 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 13/13] staging: r8188eu: simplify _InitNormalChipTwoOutEpPriority
Date:   Sat,  6 Aug 2022 21:55:40 +0200
Message-Id: <20220806195540.777390-14-martin@kaiser.cx>
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

Simplify the _InitNormalChipTwoOutEpPriority function, now that we have
only one configuration for the queues.

Remove the variables which are constant. Keep only those settings that
depend on wifi_spec.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index fc4d25b835d3..e1d56370a471 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -228,26 +228,17 @@ static void _InitNormalChipRegPriority(struct adapter *Adapter, u16 beQ,
 static void _InitNormalChipTwoOutEpPriority(struct adapter *Adapter)
 {
 	struct registry_priv *pregistrypriv = &Adapter->registrypriv;
-	u16 beQ, bkQ, viQ, voQ, mgtQ, hiQ;
-	u16 valueHi = QUEUE_HIGH;
-	u16 valueLow = QUEUE_NORMAL;
+	u16 bkQ, voQ;
 
 	if (!pregistrypriv->wifi_spec) {
-		beQ	= valueLow;
-		bkQ	= valueLow;
-		viQ	= valueHi;
-		voQ	= valueHi;
-		mgtQ	= valueHi;
-		hiQ	= valueHi;
+		bkQ	= QUEUE_NORMAL;
+		voQ	= QUEUE_HIGH;
 	} else {/* for WMM ,CONFIG_OUT_EP_WIFI_MODE */
-		beQ	= valueLow;
-		bkQ	= valueHi;
-		viQ	= valueHi;
-		voQ	= valueLow;
-		mgtQ	= valueHi;
-		hiQ	= valueHi;
+		bkQ	= QUEUE_HIGH;
+		voQ	= QUEUE_NORMAL;
 	}
-	_InitNormalChipRegPriority(Adapter, beQ, bkQ, viQ, voQ, mgtQ, hiQ);
+	_InitNormalChipRegPriority(Adapter, QUEUE_NORMAL, bkQ, QUEUE_HIGH,
+				   voQ, QUEUE_HIGH, QUEUE_HIGH);
 }
 
 static void _InitNormalChipThreeOutEpPriority(struct adapter *Adapter)
-- 
2.30.2


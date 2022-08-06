Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEA558B80A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiHFT4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiHFT4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9915965B3
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:01 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtr-0004Tu-KV; Sat, 06 Aug 2022 21:55:55 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 07/13] staging: r8188eu: remove comments about endpoint mapping
Date:   Sat,  6 Aug 2022 21:55:34 +0200
Message-Id: <20220806195540.777390-8-martin@kaiser.cx>
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

Remove the comments in two_out_pipe and three_out_pipe that show the
mappings. They simply repeat the settings in the code and provide no
additional information. Keep the info which RtOutPipe is high, normal
or low.

Without the removed comments, it'll be easier to summarize and reorganize
the code.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 24 ++++++-----------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 664028c14141..e561c92f1dc9 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -32,11 +32,9 @@ static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
 
-	if (wifi_cfg) { /* WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  0,  1,  0,  1,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
+	/* 0:H, 1:L */
 
+	if (wifi_cfg) {
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[1];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
@@ -47,11 +45,7 @@ static void two_out_pipe(struct adapter *adapter, bool wifi_cfg)
 		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
 		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
 
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	1,  0,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:L */
-
+	} else {
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[0];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[1];/* BE */
@@ -68,11 +62,9 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 {
 	struct dvobj_priv *pdvobjpriv = adapter_to_dvobj(adapter);
 
-	if (wifi_cfg) {/* for WMM */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  1,	2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
+	/* 0:H, 1:N, 2:L */
 
+	if (wifi_cfg) {
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
@@ -83,11 +75,7 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 		pdvobjpriv->Queue2Pipe[6] = pdvobjpriv->RtOutPipe[0];/* HIGH */
 		pdvobjpriv->Queue2Pipe[7] = pdvobjpriv->RtOutPipe[0];/* TXCMD */
 
-	} else {/* typical setting */
-		/* BK, BE, VI, VO, BCN,	CMD, MGT, HIGH, HCCA */
-		/*  2,  2,  1,  0,   0,   0,   0,    0,    0}; */
-		/* 0:H, 1:N, 2:L */
-
+	} else {
 		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
 		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
 		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-- 
2.30.2


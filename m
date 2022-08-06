Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48A158B803
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 21:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiHFT4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiHFT4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 15:56:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBFCE39
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 12:56:05 -0700 (PDT)
Received: from dslb-188-097-043-167.188.097.pools.vodafone-ip.de ([188.97.43.167] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oKPtt-0004Tu-Ai; Sat, 06 Aug 2022 21:55:57 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 09/13] staging: r8188eu: simplify three_out_pipe
Date:   Sat,  6 Aug 2022 21:55:36 +0200
Message-Id: <20220806195540.777390-10-martin@kaiser.cx>
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

Only one of the mappings in three_out_pipe depends on the wifi_cfg flag.
Simplify the code accordingly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 431661be95e0..044e608bf6e2 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -48,17 +48,12 @@ static void three_out_pipe(struct adapter *adapter, bool wifi_cfg)
 
 	/* 0:H, 1:N, 2:L */
 
-	if (wifi_cfg) {
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[1];/* BK */
-	} else {
-		pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
-		pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
-		pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
-		pdvobjpriv->Queue2Pipe[3] = pdvobjpriv->RtOutPipe[2];/* BK */
-	}
+	pdvobjpriv->Queue2Pipe[0] = pdvobjpriv->RtOutPipe[0];/* VO */
+	pdvobjpriv->Queue2Pipe[1] = pdvobjpriv->RtOutPipe[1];/* VI */
+	pdvobjpriv->Queue2Pipe[2] = pdvobjpriv->RtOutPipe[2];/* BE */
+
+	pdvobjpriv->Queue2Pipe[3] = wifi_cfg ?
+		pdvobjpriv->RtOutPipe[1] : pdvobjpriv->RtOutPipe[2];/* BK */
 }
 
 int rtl8188eu_interface_configure(struct adapter *adapt)
-- 
2.30.2


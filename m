Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3550A9B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392182AbiDUUIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388154AbiDUUIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:08:00 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B704C430
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:05:09 -0700 (PDT)
Received: from dslb-178-004-168-011.178.004.pools.vodafone-ip.de ([178.4.168.11] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nhd30-0001uQ-5S; Thu, 21 Apr 2022 22:05:02 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove OnAtim
Date:   Thu, 21 Apr 2022 22:04:49 +0200
Message-Id: <20220421200449.191983-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the empty OnAtim function. We can set the function pointer in
mlme_sta_tbl to NULL if no action is required for this management frame
subtype.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index db61acc914d1..190de0b59c42 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -25,7 +25,7 @@ static mlme_handler mlme_sta_tbl[] = {
 	NULL,
 	NULL,
 	OnBeacon,
-	OnAtim,
+	NULL,
 	OnDisassoc,
 	OnAuthClient,
 	OnDeAuth,
@@ -1479,11 +1479,6 @@ unsigned int OnDisassoc(struct adapter *padapter, struct recv_frame *precv_frame
 	return _SUCCESS;
 }
 
-unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
-{
-	return _SUCCESS;
-}
-
 unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
 {
 	unsigned int ret = _FAIL;
-- 
2.30.2


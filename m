Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C64F0B48
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359453AbiDCQkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359447AbiDCQke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:40:34 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E955BCAE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:38:38 -0700 (PDT)
Received: from dslb-094-219-033-178.094.219.pools.vodafone-ip.de ([94.219.33.178] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nb3FB-00080j-4e; Sun, 03 Apr 2022 18:38:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] staging: r8188eu: make validate_recv_mgnt_frame return void
Date:   Sun,  3 Apr 2022 18:38:17 +0200
Message-Id: <20220403163818.357173-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220403163818.357173-1-martin@kaiser.cx>
References: <20220403163818.357173-1-martin@kaiser.cx>
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

Change the validate_recv_mgnt_frame function to not return a status.

It always returns _SUCCESS, its only caller does not check the
return value.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_recv.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 476bd4f22528..8fa07d37d07b 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -911,14 +911,14 @@ static int validate_recv_ctrl_frame(struct adapter *padapter,
 
 struct recv_frame *recvframe_chk_defrag(struct adapter *padapter, struct recv_frame *precv_frame);
 
-static int validate_recv_mgnt_frame(struct adapter *padapter,
-				    struct recv_frame *precv_frame)
+static void validate_recv_mgnt_frame(struct adapter *padapter,
+				     struct recv_frame *precv_frame)
 {
 	struct sta_info *psta;
 
 	precv_frame = recvframe_chk_defrag(padapter, precv_frame);
 	if (!precv_frame)
-		return _SUCCESS;
+		return;
 
 	/* for rx pkt statistics */
 	psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(precv_frame->rx_data));
@@ -940,8 +940,6 @@ static int validate_recv_mgnt_frame(struct adapter *padapter,
 	}
 
 	mgt_dispatcher(padapter, precv_frame);
-
-	return _SUCCESS;
 }
 
 static int validate_recv_data_frame(struct adapter *adapter,
-- 
2.30.2


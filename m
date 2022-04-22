Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1129850B9AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448432AbiDVONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448413AbiDVONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:13:23 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509195A163
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:10:28 -0700 (PDT)
Received: from ipservice-092-217-076-017.092.217.pools.vodafone-ip.de ([92.217.76.17] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nhtzL-0000tV-8B; Fri, 22 Apr 2022 16:10:23 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: r8188eu: fix the index check in mgt_dispatcher
Date:   Fri, 22 Apr 2022 16:09:58 +0200
Message-Id: <20220422140958.239767-1-martin@kaiser.cx>
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

In mgt_dispatcher, we check that index is a valid index for the
mlme_sta_tbl array. The valid indices for this array are from 0 to
ARRAY_SIZE(mlme_sta_tbl) - 1.

An invalid index is >= ARRAY_SIZE(mlme_sta_tbl). Fix the off by one error
in the check.

Fixes: db84803cd8de ("staging: r8188eu: use ARRAY_SIZE for mlme_sta_tbl")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f426e26341ee..839b0b85993e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -398,7 +398,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		return;
 
 	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
-	if (index > ARRAY_SIZE(mlme_sta_tbl))
+	if (index >= ARRAY_SIZE(mlme_sta_tbl))
 		return;
 	fct = mlme_sta_tbl[index];
 
-- 
2.30.2


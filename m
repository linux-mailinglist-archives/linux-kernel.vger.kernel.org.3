Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08657F5D8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbiGXPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiGXPk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:40:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08CC647B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:40:24 -0700 (PDT)
Received: from dslb-178-004-201-227.178.004.pools.vodafone-ip.de ([178.4.201.227] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oFdiN-0004Qh-GQ; Sun, 24 Jul 2022 17:40:19 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: read capability info from struct ieee80211_mgmt
Date:   Sun, 24 Jul 2022 17:39:15 +0200
Message-Id: <20220724153917.138848-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220724153917.138848-1-martin@kaiser.cx>
References: <20220724153917.138848-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the capability info of the association response message from struct
ieee80211_mgmt instead of parsing the message ourselves.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 663048bc8e7d..1a68b131f983 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -1296,8 +1296,7 @@ unsigned int OnAssocRsp(struct adapter *padapter, struct recv_frame *precv_frame
 		goto report_assoc_result;
 	}
 
-	/* get capabilities */
-	pmlmeinfo->capability = le16_to_cpu(*(__le16 *)(pframe + WLAN_HDR_A3_LEN));
+	pmlmeinfo->capability = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
 
 	/* set slot time */
 	pmlmeinfo->slotTime = (pmlmeinfo->capability & BIT(10)) ? 9 : 20;
-- 
2.30.2


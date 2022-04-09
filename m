Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7844FA987
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242648AbiDIQey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 12:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242616AbiDIQed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 12:34:33 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C90C23F386
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 09:32:25 -0700 (PDT)
Received: from ipservice-092-217-091-111.092.217.pools.vodafone-ip.de ([92.217.91.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ndE0b-0006Rg-TY; Sat, 09 Apr 2022 18:32:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/10] staging: r8188eu: improve timeout handling in rtw_check_join_candidate
Date:   Sat,  9 Apr 2022 18:32:07 +0200
Message-Id: <20220409163212.241122-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409163212.241122-1-martin@kaiser.cx>
References: <20220409163212.241122-1-martin@kaiser.cx>
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

Use the standard kernel functions to define and check the timeout in
rtw_check_join_candidate.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index c90f36dee1ea..aa39f07847c2 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1419,6 +1419,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 {
 	int updated = false;
 	struct adapter *adapter = container_of(pmlmepriv, struct adapter, mlmepriv);
+	unsigned long scan_res_expire;
 
 	/* check bssid, if needed */
 	if (pmlmepriv->assoc_by_bssid) {
@@ -1436,8 +1437,9 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	if (!rtw_is_desired_network(adapter, competitor))
 		goto exit;
 
+	scan_res_expire = competitor->last_scanned + msecs_to_jiffies(RTW_SCAN_RESULT_EXPIRE);
 	if (rtw_to_roaming(adapter) > 0) {
-		if (rtw_get_passing_time_ms((u32)competitor->last_scanned) >= RTW_SCAN_RESULT_EXPIRE ||
+		if (time_after(jiffies, scan_res_expire) ||
 		    !is_same_ess(&competitor->network, &pmlmepriv->cur_network.network))
 			goto exit;
 	}
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A234FFF6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiDMTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiDMTkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:40:03 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E6876662
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:37:40 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1neio5-0005fr-01; Wed, 13 Apr 2022 21:37:37 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 1/8] staging: r8188eu: simplify delay conditions in rtw_pwr_wakeup
Date:   Wed, 13 Apr 2022 21:36:47 +0200
Message-Id: <20220413193654.258507-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413193654.258507-1-martin@kaiser.cx>
References: <20220409151557.207980-1-martin@kaiser.cx>
 <20220413193654.258507-1-martin@kaiser.cx>
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

Simplify the conditions for a loop in rtw_pwr_wakeup that waits while
the system is suspended.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 8c2e98361e47..8150894fba82 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -388,12 +388,8 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 	}
 
 	/* System suspend is not allowed to wakeup */
-	if (pwrpriv->bInSuspend) {
-		while (pwrpriv->bInSuspend &&
-		       (rtw_get_passing_time_ms(start) <= 3000 ||
-		       (rtw_get_passing_time_ms(start) <= 500)))
-				msleep(10);
-	}
+	while (pwrpriv->bInSuspend && rtw_get_passing_time_ms(start) <= 3000)
+		msleep(10);
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
-- 
2.30.2


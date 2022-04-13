Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C744FFF6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiDMTkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbiDMTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:40:05 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F217666A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:37:43 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1neio8-0005fr-4F; Wed, 13 Apr 2022 21:37:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 5/8] staging: r8188eu: use kernel functions for timeout handling
Date:   Wed, 13 Apr 2022 21:36:51 +0200
Message-Id: <20220413193654.258507-6-martin@kaiser.cx>
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

Use the kernel functions to set a timeout and to check if it's expired.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index ff96e5229b52..2ad6105e6ec4 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -372,8 +372,8 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 {
 	struct pwrctrl_priv *pwrpriv = &padapter->pwrctrlpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	unsigned long timeout = jiffies + msecs_to_jiffies(3000);
 	int ret = _SUCCESS;
-	u32 start = jiffies;
 	u32 ips_deffer_ms;
 
 	/* the ms will prevent from falling into IPS after wakeup */
@@ -382,11 +382,11 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 	if (pwrpriv->ips_deny_time < jiffies + rtw_ms_to_systime(ips_deffer_ms))
 		pwrpriv->ips_deny_time = jiffies + rtw_ms_to_systime(ips_deffer_ms);
 
-	while (pwrpriv->ps_processing && rtw_get_passing_time_ms(start) <= 3000)
+	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
 		msleep(10);
 
 	/* System suspend is not allowed to wakeup */
-	while (pwrpriv->bInSuspend && rtw_get_passing_time_ms(start) <= 3000)
+	while (pwrpriv->bInSuspend && time_before(jiffies, timeout))
 		msleep(10);
 
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
-- 
2.30.2


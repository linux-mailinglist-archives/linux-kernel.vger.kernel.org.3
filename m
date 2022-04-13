Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E5A4FFF72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiDMTkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbiDMTkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:40:06 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEBA76666
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:37:45 -0700 (PDT)
Received: from dslb-178-004-174-121.178.004.pools.vodafone-ip.de ([178.4.174.121] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1neio9-0005fr-Mt; Wed, 13 Apr 2022 21:37:41 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 7/8] staging: r8188eu: remove the bInSuspend loop
Date:   Wed, 13 Apr 2022 21:36:53 +0200
Message-Id: <20220413193654.258507-8-martin@kaiser.cx>
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

Remove the loop in rtw_pwr_wakeup that waits while the system is
suspended.

pwrpriv->bInSuspend is set in rtw_suspend and cleared in rtw_resume. These
functions are the .suspend and .resume functions of the struct usb_driver
for r8188eu.

A usb_driver's suspend and resume functions are called when the entire
system goes into suspend or runtime suspend.

All of the code paths for rtw_pwr_wakeup start at ioctl handlers.

We can remove the loop that checks bInSuspend. It's not possible to call
an ioctl while the entire system is suspended.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

I tried to track down who calls suspend and resume of an usb_driver. My
understanding is that all of these calls come from the pm layer and that
the suspend and resume affect the whole system, not just the usb device.

 drivers/staging/r8188eu/core/rtw_pwrctrl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 605210d89f32..6990808ef353 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -379,10 +379,6 @@ int rtw_pwr_wakeup(struct adapter *padapter)
 	while (pwrpriv->ps_processing && time_before(jiffies, timeout))
 		msleep(10);
 
-	/* System suspend is not allowed to wakeup */
-	while (pwrpriv->bInSuspend && time_before(jiffies, timeout))
-		msleep(10);
-
 	/* I think this should be check in IPS, LPS, autosuspend functions... */
 	if (check_fwstate(pmlmepriv, _FW_LINKED)) {
 		ret = _SUCCESS;
-- 
2.30.2


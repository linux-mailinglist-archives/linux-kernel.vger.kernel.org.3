Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2854E31E1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353438AbiCUUfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353372AbiCUUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:35:27 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3793EB8B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:34:02 -0700 (PDT)
Received: from dslb-094-219-034-255.094.219.pools.vodafone-ip.de ([94.219.34.255] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWOj0-0003ce-6c; Mon, 21 Mar 2022 21:33:58 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/6] staging: r8188eu: DYNAMIC_RF_CALIBRATION is not used
Date:   Mon, 21 Mar 2022 21:30:30 +0100
Message-Id: <20220321203031.143486-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220321203031.143486-1-martin@kaiser.cx>
References: <20220321203031.143486-1-martin@kaiser.cx>
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

Remove the DYNAMIC_RF_CALIBRATION capability. It's cleared in one place
but never checked.

DYNAMIC_RF_CALIBRATION is part of podmpriv->SupportAbility, there are no
users that check SupportAbility as a whole and use DYNAMIC_RF_CALIBRATION
implicitly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c      | 2 --
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 599d930a5927..11dc8834acac 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1431,8 +1431,6 @@ void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
 			} else if (dm_func == 1) {/* disable DIG */
 				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DIG);
-			} else if (dm_func == 3) {/* disable tx power tracking */
-				podmpriv->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
 			} else if (dm_func == 6) {/* turn on all dynamic func */
 				if (!(podmpriv->SupportAbility  & DYNAMIC_BB_DIG)) {
 					struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 9b9c81fe8543..9092e775fc5d 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -31,8 +31,6 @@
 /*  BB ODM section BIT 0-15 */
 #define	DYNAMIC_BB_DIG				BIT(0)
 
-#define		DYNAMIC_RF_CALIBRATION		BIT(26)
-
 #define		DYNAMIC_ALL_FUNC_ENABLE		0xFFFFFFF
 
 #define _HW_STATE_NOLINK_		0x00
-- 
2.30.2


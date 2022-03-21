Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF84E31E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353417AbiCUUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353378AbiCUUf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:35:27 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BF03EB86
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:34:00 -0700 (PDT)
Received: from dslb-094-219-034-255.094.219.pools.vodafone-ip.de ([94.219.34.255] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nWOiy-0003ce-ID; Mon, 21 Mar 2022 21:33:56 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: r8188eu: DYNAMIC_BB_DYNAMIC_TXPWR is not used
Date:   Mon, 21 Mar 2022 21:30:28 +0100
Message-Id: <20220321203031.143486-4-martin@kaiser.cx>
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

Remove the DYNAMIC_BB_DYNAMIC_TXPWR capability. It is cleared but not used.

DYNAMIC_BB_DYNAMIC_TXPWR defines a bit in podmpriv->SupportAbility that's
set or cleared. There's no code that checks this bit explicitly.

There's also no code that makes a copy of SupportAbility and checks the
DYNAMIC_BB_DYNAMIC_TXPWR in the copy. SupportAbility is copied to
podmpriv->BK_SupportAbility. The only use of BK_SupportAbility is to
restore a previously saved value. The other remaining reader of
SupportAbility is a private debug ioctl.

It's safe to assume that DYNAMIC_BB_DYNAMIC_TXPWR is not used, not even
indirectly.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 4 ----
 drivers/staging/r8188eu/hal/usb_halinit.c      | 2 --
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index f32401deae9a..2d495a756abf 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1275,14 +1275,10 @@ void update_IOT_info(struct adapter *padapter)
 	case HT_IOT_PEER_RALINK:
 		pmlmeinfo->turboMode_cts2self = 0;
 		pmlmeinfo->turboMode_rtsen = 1;
-		/* disable high power */
-		Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR), false);
 		break;
 	case HT_IOT_PEER_REALTEK:
 		/* rtw_write16(padapter, 0x4cc, 0xffff); */
 		/* rtw_write16(padapter, 0x546, 0x01c0); */
-		/* disable high power */
-		Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR), false);
 		break;
 	default:
 		pmlmeinfo->turboMode_cts2self = 0;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index a92774352d2d..dda8715beb07 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1431,8 +1431,6 @@ void SetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 				podmpriv->SupportAbility = DYNAMIC_FUNC_DISABLE;
 			} else if (dm_func == 1) {/* disable DIG */
 				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DIG);
-			} else if (dm_func == 2) {/* disable High power */
-				podmpriv->SupportAbility  &= (~DYNAMIC_BB_DYNAMIC_TXPWR);
 			} else if (dm_func == 3) {/* disable tx power tracking */
 				podmpriv->SupportAbility  &= (~DYNAMIC_RF_CALIBRATION);
 			} else if (dm_func == 5) {/* disable antenna diversity */
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index 532360c84d66..703fb9f2409d 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -30,7 +30,6 @@
 /*  ====== ODM_ABILITY_E ======== */
 /*  BB ODM section BIT 0-15 */
 #define	DYNAMIC_BB_DIG				BIT(0)
-#define	DYNAMIC_BB_DYNAMIC_TXPWR	BIT(2)
 
 #define		DYNAMIC_BB_ANT_DIV			BIT(6)
 
-- 
2.30.2


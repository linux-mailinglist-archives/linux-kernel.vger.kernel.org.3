Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3117D4883A4
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 13:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbiAHMul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 07:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiAHMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 07:50:24 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB06C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:50:24 -0800 (PST)
Received: from dslb-188-097-214-229.188.097.pools.vodafone-ip.de ([188.97.214.229] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n6BAq-0005EJ-7c; Sat, 08 Jan 2022 13:50:20 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 10/12] staging: r8188eu: HW_VAR_MEDIA_STATUS1 is never set
Date:   Sat,  8 Jan 2022 13:49:57 +0100
Message-Id: <20220108124959.313215-11-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108124959.313215-1-martin@kaiser.cx>
References: <20220108124959.313215-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HW_VAR_MEDIA_STATUS1 hal variable is never set. Remove its define
and the code to set it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 9 ---------
 drivers/staging/r8188eu/include/hal_intf.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 38b88e6b7bdb..21cb505036b7 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1087,15 +1087,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, MSR, val8);
 		}
 		break;
-	case HW_VAR_MEDIA_STATUS1:
-		{
-			u8 val8;
-
-			val8 = rtw_read8(Adapter, MSR) & 0x03;
-			val8 |= *((u8 *)val) << 2;
-			rtw_write8(Adapter, MSR, val8);
-		}
-		break;
 	case HW_VAR_SET_OPMODE:
 		hw_var_set_opmode(Adapter, variable, val);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 120b32994e1f..6728cb506303 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -10,7 +10,6 @@
 
 enum hw_variables {
 	HW_VAR_MEDIA_STATUS,
-	HW_VAR_MEDIA_STATUS1,
 	HW_VAR_SET_OPMODE,
 	HW_VAR_MAC_ADDR,
 	HW_VAR_BSSID,
-- 
2.30.2


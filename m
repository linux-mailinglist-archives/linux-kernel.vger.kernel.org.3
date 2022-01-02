Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E50482C7F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiABSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiABSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:00:21 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A187BC061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 10:00:20 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1n459U-0005Ye-FA; Sun, 02 Jan 2022 19:00:16 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/5] staging: r8188eu: fix_rate is set but not used.
Date:   Sun,  2 Jan 2022 18:59:30 +0100
Message-Id: <20220102175932.89127-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220102175932.89127-1-martin@kaiser.cx>
References: <20220102175932.89127-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix_rate in struct adapter is set but not used. Remove the variable and
the private ioctl code to set it.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c    | 1 -
 drivers/staging/r8188eu/include/drv_types.h  | 2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 ------
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 685431034495..bd6eb3878060 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -84,7 +84,6 @@ void rtl8188e_InitHalDm(struct adapter *Adapter)
 	dm_InitGPIOSetting(Adapter);
 	Update_ODM_ComInfo_88E(Adapter);
 	ODM_DMInit(dm_odm);
-	Adapter->fix_rate = 0xFF;
 }
 
 void rtl8188e_HalDmWatchDog(struct adapter *Adapter)
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index c586a35014d8..2dd5ebaaa921 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -264,8 +264,6 @@ struct adapter {
 	unsigned char			br_ip[4];
 	struct br_ext_info		ethBrExtInfo;
 
-	u8	fix_rate;
-
 	unsigned char     in_cta_test;
 };
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 9d277151a5ee..6e9a6d4db089 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -3978,12 +3978,6 @@ static int rtw_dbg_port(struct net_device *dev,
 			DBG_88E("turn %s the bShowGetP2PState Variable\n", (extra_arg == 1) ? "on" : "off");
 			padapter->bShowGetP2PState = extra_arg;
 			break;
-		case 0xaa:
-			if (extra_arg > 0x13)
-				extra_arg = 0xFF;
-			DBG_88E("chang data rate to :0x%02x\n", extra_arg);
-			padapter->fix_rate = extra_arg;
-			break;
 		case 0xdd:/* registers dump, 0 for mac reg, 1 for bb reg, 2 for rf reg */
 			if (extra_arg == 0)
 				mac_reg_dump(padapter);
-- 
2.30.2


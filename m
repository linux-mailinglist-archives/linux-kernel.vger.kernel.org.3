Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3655B35F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiFZSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 14:06:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD746E92
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 11:06:23 -0700 (PDT)
Received: from dslb-188-104-057-109.188.104.pools.vodafone-ip.de ([188.104.57.109] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1o5WeG-00072p-E6; Sun, 26 Jun 2022 20:06:16 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] staging: r8188eu: remove rtw_usleep_os
Date:   Sun, 26 Jun 2022 20:06:03 +0200
Message-Id: <20220626180603.287054-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220602194807.281115-1-martin@kaiser.cx>
References: <20220602194807.281115-1-martin@kaiser.cx>
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

Remove the rtw_usleep_os helper function. There are only two callers, both
of which call rtw_usleep_os(100). This is equivalent to msleep(1).

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
changes in v2:
- use msleep(1) instead of usleep_range

 drivers/staging/r8188eu/core/rtw_pwrctrl.c      | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 2 --
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 8 --------
 4 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_pwrctrl.c b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
index 45e85b593665..cf9020a73933 100644
--- a/drivers/staging/r8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/r8188eu/core/rtw_pwrctrl.c
@@ -273,7 +273,7 @@ static s32 LPS_RF_ON_check(struct adapter *padapter, u32 delay_ms)
 			err = -1;
 			break;
 		}
-		rtw_usleep_os(100);
+		msleep(1);
 	}
 
 	return err;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 5549e7be334a..5b65313e0b9d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -243,7 +243,7 @@ static int efuse_read_phymap_from_txpktbuf(
 			if (reg)
 				break;
 
-			rtw_usleep_os(100);
+			msleep(1);
 		} while (time_before(jiffies, timeout));
 
 		/* data from EEPROM needs to be in LE */
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 1d97d5be46d5..72990a1cdc66 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -76,8 +76,6 @@ void *rtw_malloc2d(int h, int w, int size);
 		spin_lock_init(&((q)->lock));			\
 	} while (0)
 
-void rtw_usleep_os(int us);
-
 static inline unsigned char _cancel_timer_ex(struct timer_list *ptimer)
 {
 	return del_timer_sync(ptimer);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 812acd59be79..3504a0a9ba87 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -42,14 +42,6 @@ Otherwise, there will be racing condition.
 Caller must check if the list is empty before calling rtw_list_delete
 */
 
-void rtw_usleep_os(int us)
-{
-	if (1 < (us / 1000))
-		msleep(1);
-	else
-		msleep((us / 1000) + 1);
-}
-
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
-- 
2.30.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDA94DE9E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 19:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbiCSSFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 14:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiCSSFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 14:05:36 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3528313DCD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 11:04:12 -0700 (PDT)
Received: from dslb-188-096-148-115.188.096.pools.vodafone-ip.de ([188.96.148.115] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nVdQs-0003Vz-8r; Sat, 19 Mar 2022 19:04:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH] staging: r8188eu: remove local BIT macro
Date:   Sat, 19 Mar 2022 19:03:42 +0100
Message-Id: <20220319180342.3143734-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
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

The r8188eu driver defines a local BIT(x) macro. Remove this local macro
and use the one from include/linux/bits.h.

The global BIT macro returns an unsigned long value, the removed local
BIT macro used a signed int.

DYNAMIC_BB_DYNAMIC_TXPWR is defined as BIT(2), ~DYNAMIC_BB_DYNAMIC_TXPWR
is passed to Switch_DM_Func as a u32 parameter. We need a cast in this
case as ~DYNAMIC_BB_DYNAMIC_TXPWR is a 64-bit value on x86_64 systems.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

Dear all,

this is the next attempt to get this right. I'm not sure if it should be
labeled v3. Greg accepted all other patches of the "some rx cleanups"
series, so I'm sending this as a single patch, starting at v1 again.

Thanks to Greg and Dan for the feedback, I see that ((u32)BIT(2)) is not
different from BIT(2) without the cast. Making the cast where
DYNAMIC_BB_DYNAMIC_TXPWR is used is the better option.

It seems that (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR) and
~(u32)DYNAMIC_BB_DYNAMIC_TXPWR do the same thing and it's ok to invert
first and to cast afterwards. According to the C99 standard, a 64-bit
unsigned int is cast to u32 by repeatedly adding U32_MAX + 1 until the
result fits into a u32 - or simply by cutting off the upper 32bit.

BTW the previous rtl8188eu driver used
Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR), false);
as well.

Thanks,
Martin

 drivers/staging/r8188eu/core/rtw_wlan_util.c | 4 ++--
 drivers/staging/r8188eu/include/wifi.h       | 7 +------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 665b077190bc..f32401deae9a 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1276,13 +1276,13 @@ void update_IOT_info(struct adapter *padapter)
 		pmlmeinfo->turboMode_cts2self = 0;
 		pmlmeinfo->turboMode_rtsen = 1;
 		/* disable high power */
-		Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
+		Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR), false);
 		break;
 	case HT_IOT_PEER_REALTEK:
 		/* rtw_write16(padapter, 0x4cc, 0xffff); */
 		/* rtw_write16(padapter, 0x546, 0x01c0); */
 		/* disable high power */
-		Switch_DM_Func(padapter, (~DYNAMIC_BB_DYNAMIC_TXPWR), false);
+		Switch_DM_Func(padapter, (u32)(~DYNAMIC_BB_DYNAMIC_TXPWR), false);
 		break;
 	default:
 		pmlmeinfo->turboMode_cts2self = 0;
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index c331be19ff83..299553351246 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -4,14 +4,9 @@
 #ifndef _WIFI_H_
 #define _WIFI_H_
 
+#include <linux/bits.h>
 #include <linux/ieee80211.h>
 
-#ifdef BIT
-/* error	"BIT define occurred earlier elsewhere!\n" */
-#undef BIT
-#endif
-#define BIT(x)	(1 << (x))
-
 #define WLAN_ETHHDR_LEN		14
 #define WLAN_HDR_A3_LEN		24
 #define WLAN_HDR_A3_QOS_LEN	26
-- 
2.30.2


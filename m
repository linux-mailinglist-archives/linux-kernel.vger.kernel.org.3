Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCCF59AF89
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiHTSSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiHTSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:52 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A243326C9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u6so4068236eda.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yjcPgw0CG7/5/Itv9oWRmuj8uNx0y9j81u7fcqrcyG8=;
        b=fKY56u27nZCdc2CpciMfhjUjjFmX1muPxps4Tl6+riE/nFQcGjUrmjWc+rmd3mRjQJ
         p9pVfNHdz1Oq7qO5gsHMbLFSOmCxrPlwBZEhNwNr+oO+gCya3XFkA0+Nit8KsXLoXa8l
         6PYTBWeBqz9/vLV7E3hBNFx6eD/CWR1vzCg6K+eh8XJn3b1arvdSspqY5rdbsbxJPMr8
         jDY8N41Tti3CXcb4XU6Dt3y+bVC/OtrmRTsVHz9QPHNEt20GTrKF4rDgwcimK4HxogsL
         XIh+xZLC9uP7Wv/Srvb5SCm3Xv0zO9mUya0bLv8Sl9Onhrv7+AHfiKy/RdWPUPXV/aB2
         bgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yjcPgw0CG7/5/Itv9oWRmuj8uNx0y9j81u7fcqrcyG8=;
        b=MgOFt/L9hGIhsvEnPXIvC4LE4rJE2+jZp763PwiaGcXSBFVlSRgaHEUtxhjwVLdzrx
         dAEhIuE1ttfinh7xkCSIU+q+skCQnLifTes8OKNQqTCwwp8g0mgQbL7Kcsnwi78zptsD
         9tmkwfPBD5RKO0V3ygzIAJSpUdb/tD/f75Gs27VIuJiB2ZCKKVJYJDdahzuAUnikqppX
         J9WrKyagrpakGjcnILzTaqOMoM2NGloMpXxb6QeeU0/Cbby/1ECpoYZOn6GJr844R3MG
         GzDV5a4ue+Hka2gpHGisZPg8/jhvdu6Q5dgXPBZUgz4j/sH8GqKu4hLLuU/qVwIdI+GK
         uOQw==
X-Gm-Message-State: ACgBeo2uLAkH8r7XpS1/yvyztqzN61gp1hL1N8QE20Zg2LHmtPFhLn5A
        uM4k7j+88MmcRA1Duzimfs8=
X-Google-Smtp-Source: AA6agR4Ib7WAPazC9WU6QZ/34Vv3a4iM92Pw2z6TiPCIbiX2j8NhLkrvDizzG97CDrxkJXAI6OWfFQ==
X-Received: by 2002:a05:6402:510a:b0:43d:ab25:7d68 with SMTP id m10-20020a056402510a00b0043dab257d68mr10111339edd.102.1661019406769;
        Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 15/19] staging: r8188eu: rename rtw_os_xmit_complete()
Date:   Sat, 20 Aug 2022 20:16:19 +0200
Message-Id: <20220820181623.12497-16-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181623.12497-1-straube.linux@gmail.com>
References: <20220820181623.12497-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_os_xmit_complete() was moved from the os_dep
directory. It looks like the driver was originaly written to support
different operating systems. Obviously we do not need an extra 'os'
in the function name that indicates that the function is operating
system specific. Rename it to rtw_xmit_complete().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c      | 10 +++++-----
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c |  4 ++--
 drivers/staging/r8188eu/include/rtw_xmit.h   |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 3103e8871dfd..893dac30e8e6 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7876,7 +7876,7 @@ u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 				spin_unlock_bh(&psta_bmc->sleep_q.lock);
 				if (rtl8188eu_hal_xmit(padapter, pxmitframe))
-					rtw_os_xmit_complete(padapter, pxmitframe);
+					rtw_xmit_complete(padapter, pxmitframe);
 				spin_lock_bh(&psta_bmc->sleep_q.lock);
 			}
 			spin_unlock_bh(&psta_bmc->sleep_q.lock);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d5878b31bdbb..760b115938f2 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -229,7 +229,7 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
-void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
+void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
 {
 	if (pxframe->pkt)
 		rtw_os_pkt_complete(padapter, pxframe->pkt);
@@ -249,7 +249,7 @@ void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 		return;
 
 	for (i = 0; i < NR_XMITFRAME; i++) {
-		rtw_os_xmit_complete(padapter, pxmitframe);
+		rtw_xmit_complete(padapter, pxmitframe);
 
 		pxmitframe++;
 	}
@@ -2017,7 +2017,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 		spin_unlock_bh(&psta->sleep_q.lock);
 		if (rtl8188eu_hal_xmit(padapter, pxmitframe))
-			rtw_os_xmit_complete(padapter, pxmitframe);
+			rtw_xmit_complete(padapter, pxmitframe);
 		spin_lock_bh(&psta->sleep_q.lock);
 	}
 
@@ -2067,7 +2067,7 @@ void wakeup_sta_to_xmit(struct adapter *padapter, struct sta_info *psta)
 
 			spin_unlock_bh(&psta_bmc->sleep_q.lock);
 			if (rtl8188eu_hal_xmit(padapter, pxmitframe))
-				rtw_os_xmit_complete(padapter, pxmitframe);
+				rtw_xmit_complete(padapter, pxmitframe);
 			spin_lock_bh(&psta_bmc->sleep_q.lock);
 		}
 
@@ -2141,7 +2141,7 @@ void xmit_delivery_enabled_frames(struct adapter *padapter, struct sta_info *pst
 		pxmitframe->attrib.triggered = 1;
 
 		if (rtl8188eu_hal_xmit(padapter, pxmitframe))
-			rtw_os_xmit_complete(padapter, pxmitframe);
+			rtw_xmit_complete(padapter, pxmitframe);
 
 		if ((psta->sleepq_ac_len == 0) && (!psta->has_legacy_ac) && (wmmps_ac)) {
 			pstapriv->tim_bitmap &= ~BIT(psta->aid);
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index bdfa51949289..8e4a5acc0b18 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -431,7 +431,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 	rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
 
 	/*  always return ndis_packet after rtw_xmitframe_coalesce */
-	rtw_os_xmit_complete(adapt, pxmitframe);
+	rtw_xmit_complete(adapt, pxmitframe);
 
 	/* 3 2. aggregate same priority and same DA(AP or STA) frames */
 	pfirstframe = pxmitframe;
@@ -501,7 +501,7 @@ bool rtl8188eu_xmitframe_complete(struct adapter *adapt, struct xmit_priv *pxmit
 
 		rtw_xmitframe_coalesce(adapt, pxmitframe->pkt, pxmitframe);
 		/*  always return ndis_packet after rtw_xmitframe_coalesce */
-		rtw_os_xmit_complete(adapt, pxmitframe);
+		rtw_xmit_complete(adapt, pxmitframe);
 
 		/*  (len - TXDESC_SIZE) == pxmitframe->attrib.last_txcmdsz */
 		update_txdesc(pxmitframe, pxmitframe->buf_addr, pxmitframe->attrib.last_txcmdsz, true);
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 0c46b19d2842..2475ca084265 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -364,7 +364,7 @@ u32	rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe);
 int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
 
-void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
+void rtw_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
 
 /* include after declaring struct xmit_buf, in order to avoid warning */
 #include "xmit_osdep.h"
-- 
2.37.2


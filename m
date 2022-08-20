Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFEB59AF78
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiHTSRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiHTSQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:16:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780C31EEE
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gb36so14214554ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=c5ehAN+V6o0UyrUy4MpXxQSXfN8Q8ckg1hQmpn4R19w=;
        b=KSqi7rl4+1guhMKdYi9+VP4e2YDJqZXP5I7clqBORFVSYNA81f/iK7jIIUlMa2u9Qe
         WprQl1RL/KmOfk+8tRf0dYwIawmTrp2Vvtboie7OUNkzuoyGIcfarw267CgF89C9uwf1
         WsDzBKAv5dcPfFzhO/iRW+MTeWBrP/iG9XvAZ/LeTMxfctB2Vw7vsMYA79WZd2KggGde
         7XjhkapIFHDyIh3dHqVvVZE17TiBUThobPaymVp3KgSK9pYfIyhJZmSX+AkTu00kLk8+
         aLxuT5oM3rWMA8ev9N0LBXHPMoUZQH5+uxuzrme1t2Hxy/NWYOxiX9a6YQdHvT48QRxq
         HhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=c5ehAN+V6o0UyrUy4MpXxQSXfN8Q8ckg1hQmpn4R19w=;
        b=Xdo172CbH+PYUaCZn5b4mDdgjlKxlcwNoeo5oOeXmVaI+7WgiDkPIbd79I5DZoSizj
         wCzyrK3Utd9ScvPTEuYJiEZQ1cI1K8tjSl+JzEZiJR1/zvA2lHdrfalK4b1OcezLJ2x1
         WFVA/XXiPGwnrdaoGtWoKNnLoi+R4E+YhR4aDSNLP8TvJDs5QyYRJyDw9YTf4Vb5Gzhc
         /huHV1QeAGESxZxkMVHA3qFTneocWrG26IL0ZruVRlBPkRsFqcfnilNz5Zc9vfWEO2Q9
         0937rqQfBgHAyCmVyiv15W1EoSuRxJa3yLAvgfLGtnYCqyY1nUEX18Q3xdWOJNeXNzzl
         AD+A==
X-Gm-Message-State: ACgBeo0OkiStr+RkuA+7GxZugYpHjtWatg/+LDg3ItIHdkcQYERAjIt8
        DqPMO2cp2Ud8eB5gQqt7wKo=
X-Google-Smtp-Source: AA6agR7XGHClFKK38cuEgOKG3DAOv6Day3RPsKs1rVd7WUs7R9RGWljq6EMW+cjz/XGY2ozz9nf8Og==
X-Received: by 2002:a17:907:94d0:b0:730:7a68:3093 with SMTP id dn16-20020a17090794d000b007307a683093mr8687137ejc.760.1661019406059;
        Sat, 20 Aug 2022 11:16:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090604c200b0072af890f52dsm3887833eja.88.2022.08.20.11.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 11:16:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/19] staging: r8188eu: move rtw_os_xmit_complete() to rtw_xmit.c
Date:   Sat, 20 Aug 2022 20:16:18 +0200
Message-Id: <20220820181623.12497-15-straube.linux@gmail.com>
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

Move the function rtw_os_xmit_complete() from the os_dep/xmit_linux.c
to core/rtw_xmit.c. The goal is to get rid of os_dep/xmit_linux.c in
follow up patches.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c      | 7 +++++++
 drivers/staging/r8188eu/include/rtw_xmit.h   | 2 ++
 drivers/staging/r8188eu/include/xmit_osdep.h | 2 --
 drivers/staging/r8188eu/os_dep/xmit_linux.c  | 7 -------
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f79889011cd1..d5878b31bdbb 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -229,6 +229,13 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	return res;
 }
 
+void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
+{
+	if (pxframe->pkt)
+		rtw_os_pkt_complete(padapter, pxframe->pkt);
+	pxframe->pkt = NULL;
+}
+
 void _rtw_free_xmit_priv(struct xmit_priv *pxmitpriv)
 {
 	int i;
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index 0e9471fb19e4..0c46b19d2842 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -364,6 +364,8 @@ u32	rtw_get_ff_hwaddr(struct xmit_frame *pxmitframe);
 int rtw_ack_tx_wait(struct xmit_priv *pxmitpriv, u32 timeout_ms);
 void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status);
 
+void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe);
+
 /* include after declaring struct xmit_buf, in order to avoid warning */
 #include "xmit_osdep.h"
 
diff --git a/drivers/staging/r8188eu/include/xmit_osdep.h b/drivers/staging/r8188eu/include/xmit_osdep.h
index 612cdab52a9f..b881399fd989 100644
--- a/drivers/staging/r8188eu/include/xmit_osdep.h
+++ b/drivers/staging/r8188eu/include/xmit_osdep.h
@@ -22,7 +22,5 @@ struct xmit_buf;
 int rtw_xmit_entry(struct sk_buff *pkt, struct  net_device *pnetdev);
 
 void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt);
-void rtw_os_xmit_complete(struct adapter *padapter,
-			  struct xmit_frame *pxframe);
 
 #endif /* __XMIT_OSDEP_H_ */
diff --git a/drivers/staging/r8188eu/os_dep/xmit_linux.c b/drivers/staging/r8188eu/os_dep/xmit_linux.c
index e216ada44055..d67508096209 100644
--- a/drivers/staging/r8188eu/os_dep/xmit_linux.c
+++ b/drivers/staging/r8188eu/os_dep/xmit_linux.c
@@ -31,13 +31,6 @@ void rtw_os_pkt_complete(struct adapter *padapter, struct sk_buff *pkt)
 	dev_kfree_skb_any(pkt);
 }
 
-void rtw_os_xmit_complete(struct adapter *padapter, struct xmit_frame *pxframe)
-{
-	if (pxframe->pkt)
-		rtw_os_pkt_complete(padapter, pxframe->pkt);
-	pxframe->pkt = NULL;
-}
-
 static void rtw_check_xmit_resource(struct adapter *padapter, struct sk_buff *pkt)
 {
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
-- 
2.37.2


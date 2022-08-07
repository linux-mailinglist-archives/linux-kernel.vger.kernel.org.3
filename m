Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2C58BC4F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiHGSQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiHGSPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D3D64D9
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:51 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id tl27so12921465ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLsK8zyKuvk6BZGE5Y5TZ/KuheYdgzde52aWp1HCe2w=;
        b=MpOFy8JsXjXRXS7sUnFo5CZ6bZkjGKKDTIi4APUpbGeKaADxOHoOC3kaMh13qO8QG7
         Fc04oiFT8VcUOVpUSZZm4XEBZOQxiSJ9dhJElra03xtqLCfZj8OURZ+aGlb69XDWqR7T
         bGpKfmZpB5zrHswcxdEZ5Si3eGRsvpoECsLtZLCWAgKuqgIkF2CphDgijfApwdCr65i/
         5RLwNyJJsLEn2gydgKY91VESc7vWBtKgxei1NII27BcXRXry0PAr7iLXEjhoLBc3p6An
         CqnBeicTShzFJ5vVnZPcd6aC6pLwaUj2DwqmmGJLuHtDuuMNsW+AJBOrX+0DO2EEq6iA
         19qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLsK8zyKuvk6BZGE5Y5TZ/KuheYdgzde52aWp1HCe2w=;
        b=yrmsk+/N0Qbfykv0m2jWoxF7EYi8B/aowEekPZNxr2T4QxfA15LI1tWbhv63uXqFmE
         tcychbXYaTo2weamUSi3X6xYgRr9btO8t4AsSjFNbLYveVUnWkekTYkBsgJ9gUBjEvdi
         YKkOZBwqzIpnGDwelZnNlRv0LJsmSpguGEqeMrQADIc2B0Mt7/mwibPVxzCXRhLfPunY
         gaigYiPlNYjmEv5sZ07ZeIObVrm4jHh5oMH35xui41CxoUdnZBSeiBf5+7eQ5sPkhEsv
         1Qwpwr2LWODuLn94hX4ZnBb0m9iR1yh44ooJeCb+ES4773iEOh+BkLTlNg84KaalDuvw
         XAQw==
X-Gm-Message-State: ACgBeo2W4QFLL1ZeMlwSGIEgSBiWgiYXmG1UKoaS1LT7pqDm7QBcmWn4
        R5fiMdiFNjPNo894OsmGddQ=
X-Google-Smtp-Source: AA6agR6/OjEybgEzJ3bZozk1S++gsbuswCKK5JOUkRVcNEwOYtezdZ1ebHHrHAzuDdrYtS9ms0uwYw==
X-Received: by 2002:a17:907:6e88:b0:730:e16e:b760 with SMTP id sh8-20020a1709076e8800b00730e16eb760mr10353049ejc.5.1659896150263;
        Sun, 07 Aug 2022 11:15:50 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:50 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/5] staging: r8188eu: merge rtw_os_recvbuf_resource_alloc() into rtw_recv.c
Date:   Sun,  7 Aug 2022 20:15:35 +0200
Message-Id: <20220807181538.8499-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807181538.8499-1-straube.linux@gmail.com>
References: <20220807181538.8499-1-straube.linux@gmail.com>
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

Merge the functionality of the function rtw_os_recvbuf_resource_alloc()
into rtl8188eu_init_recv_priv(). Merging the functionality instead of
just making the function static improves readability and we have one
function less to care about when converting the uses of _FAIL/_SUCCESS
to normal kernel error code logic.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      |  8 ++++++--
 drivers/staging/r8188eu/include/recv_osdep.h |  2 --
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 14 --------------
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 7a97c090f297..5de4e13b4b17 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -62,9 +62,13 @@ static int rtl8188eu_init_recv_priv(struct adapter *padapter)
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
-		if (res == _FAIL)
+		precvbuf->pskb = NULL;
+		precvbuf->reuse = false;
+		precvbuf->purb = usb_alloc_urb(0, GFP_KERNEL);
+		if (!precvbuf->purb) {
+			res = _FAIL;
 			break;
+		}
 		precvbuf->adapter = padapter;
 		precvbuf++;
 	}
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index b9dc32c20cfd..51dc287f263c 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -19,8 +19,6 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
-
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
 int _netdev_open(struct net_device *pnetdev);
 int netdev_open(struct net_device *pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index abdb42ab649b..c180f0e4dd3c 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -12,20 +12,6 @@
 #include "../include/osdep_intf.h"
 #include "../include/usb_ops.h"
 
-/* alloc os related resource in struct recv_buf */
-int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
-		struct recv_buf *precvbuf)
-{
-	int res = _SUCCESS;
-
-	precvbuf->purb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!precvbuf->purb)
-		res = _FAIL;
-	precvbuf->pskb = NULL;
-	precvbuf->reuse = false;
-	return res;
-}
-
 void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 {
 	union iwreq_data wrqu;
-- 
2.37.1


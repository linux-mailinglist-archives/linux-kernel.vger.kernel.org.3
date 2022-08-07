Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8737958BC51
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 20:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiHGSQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 14:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiHGSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 14:15:55 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFAB655A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 11:15:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb36so12847925ejc.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tpNJKNKlC50xQq5PpFQzujWlvGj3AJ292qB3U9+6dgE=;
        b=M82YULwaRLvi0ifXA4JINTwWxQ0TIE7hk6dNkj0zaHHUH8R+ecr1SPD0HGeKDE/eDN
         WdpZ1CxbA7ggxsX+J9PczksYx4JBghVLRGT4Z1ohl8jG+6IMMURpczj7JDA+0pwNagMy
         si/4ao2yxXV49coa+UaI4fYDxHYmeQNfdNAtVXdyG9Waikk5mj3s4jy2qYRI2ZAe7g8a
         5UQV3VGC8GRXXCI2eSn3OUayWHGcukB9kykNiwPCvtdwCtJo16hmyKZ3P6jXyc0KavhL
         qHHG48p09J2mpPtZULoCPMQyVtrh9PXOmjpL9YnlnQaD1uu0FvRbigcFAChDrKToScxi
         9PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpNJKNKlC50xQq5PpFQzujWlvGj3AJ292qB3U9+6dgE=;
        b=EiYwVOhap5kIG2xTCk54zDDALGLquFaw9m8vpjzvtQSzxHSbUjL1PiibzuR4sCvPp9
         vH3tCk/tYUzsdeL4jJOY1nt1YWug4Z6nQEEIv/9Gar9b5EeTO2xgkTMTldrEIhsKq5C+
         Ii5XIYK8odeR79uvY4S1M0yr0lMiChfMBxev2yvq+/jzwPYjxCAqtevs1xzzdtUAMvBZ
         CxDdfM5FPVwRQjj1qSAe7pCpJGK6mEMFylR1Y1M3WxG26r03G5T9rORL+AhgLMS1p7Su
         dRP3uYKCffMEKXzY7uRr1TxXyoR6Ne8JUlq1iyXdAgg/JfNFNbGIxguHuJhz2tNTAZJs
         VrAQ==
X-Gm-Message-State: ACgBeo0X86n/3SX9Gy9TaViTK58ZxJ72ogIe7eveSwpAYQ4J/4AD2dR6
        XCnDOkVuBLevT9yJv1lSDN0=
X-Google-Smtp-Source: AA6agR5Z8ax36NV9vB60WsazWbZkbH/r9P460yzOSgZNfrZoSrFqYXnzJm6uUKzJHi3W7tqX348V3w==
X-Received: by 2002:a17:907:a055:b0:730:a432:99d3 with SMTP id gz21-20020a170907a05500b00730a43299d3mr10686945ejc.690.1659896152538;
        Sun, 07 Aug 2022 11:15:52 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb84.dynamic.kabel-deutschland.de. [95.90.187.132])
        by smtp.gmail.com with ESMTPSA id b7-20020a17090630c700b0072b92daef1csm4157441ejb.146.2022.08.07.11.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 11:15:52 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: r8188eu: make rtw_init_recv_timer() static
Date:   Sun,  7 Aug 2022 20:15:38 +0200
Message-Id: <20220807181538.8499-6-straube.linux@gmail.com>
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

The function rtw_init_recv_timer() is only used in rtw_sta_mgt.c.
Make it static and remove the now empty file os_dep/recv_linux.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/Makefile             |  1 -
 drivers/staging/r8188eu/core/rtw_sta_mgt.c   | 13 ++++++++++
 drivers/staging/r8188eu/include/recv_osdep.h |  1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 26 --------------------
 4 files changed, 13 insertions(+), 28 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/os_dep/recv_linux.c

diff --git a/drivers/staging/r8188eu/Makefile b/drivers/staging/r8188eu/Makefile
index b118fd9b695c..b38fb8157d79 100644
--- a/drivers/staging/r8188eu/Makefile
+++ b/drivers/staging/r8188eu/Makefile
@@ -25,7 +25,6 @@ r8188eu-y = \
 		os_dep/mlme_linux.o \
 		os_dep/os_intfs.o \
 		os_dep/osdep_service.o \
-		os_dep/recv_linux.o \
 		os_dep/usb_intf.o \
 		os_dep/usb_ops_linux.o \
 		os_dep/xmit_linux.o \
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index 357f98e22d8a..bbc1ef146826 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -141,6 +141,19 @@ void _rtw_free_sta_priv(struct	sta_priv *pstapriv)
 	}
 }
 
+static void _rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
+{
+	struct recv_reorder_ctrl *preorder_ctrl;
+
+	preorder_ctrl = from_timer(preorder_ctrl, t, reordering_ctrl_timer);
+	rtw_reordering_ctrl_timeout_handler(preorder_ctrl);
+}
+
+static void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
+{
+	timer_setup(&preorder_ctrl->reordering_ctrl_timer, _rtw_reordering_ctrl_timeout_handler, 0);
+}
+
 struct	sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
 	s32	index;
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index e824bfac067e..d88fd6058a62 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -16,7 +16,6 @@ void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
-void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
 int _netdev_open(struct net_device *pnetdev);
 int netdev_open(struct net_device *pnetdev);
 int netdev_close(struct net_device *pnetdev);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
deleted file mode 100644
index ccf23e7fc4ab..000000000000
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#define _RECV_OSDEP_C_
-
-#include "../include/osdep_service.h"
-#include "../include/drv_types.h"
-
-#include "../include/wifi.h"
-#include "../include/recv_osdep.h"
-
-#include "../include/osdep_intf.h"
-#include "../include/usb_ops.h"
-
-static void _rtw_reordering_ctrl_timeout_handler(struct timer_list *t)
-{
-	struct recv_reorder_ctrl *preorder_ctrl;
-
-	preorder_ctrl = from_timer(preorder_ctrl, t, reordering_ctrl_timer);
-	rtw_reordering_ctrl_timeout_handler(preorder_ctrl);
-}
-
-void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl)
-{
-	timer_setup(&preorder_ctrl->reordering_ctrl_timer, _rtw_reordering_ctrl_timeout_handler, 0);
-}
-- 
2.37.1


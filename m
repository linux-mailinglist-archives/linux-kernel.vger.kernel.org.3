Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE44BBC31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbiBRP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:29:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiBRP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:29:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA1A2B2C65
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:29:12 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v12so15231316wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=P9lErvfRMqsjzgJyU2joQv+jFfLJva7YZtX9uTuJR7M=;
        b=UkUtl4UV5WrrI2nm5Z2LAL8NairQw6NpqkNwe0VAuBGw5I0EacbdoxqFOI+jBH0Q+P
         t6dn19T7v4umVJHyMAniHCs8ttvxmTR6hxHg9TjuZsHVU0Zha3LJVRjEx3nqhx0rcNgB
         N6t64JjDDg0Q/fjuk9oqekAiZCu3DEQs4eOcr4AnA9arbFD+4Bhhy4cI6j/FA55OklpJ
         AM+OqFm9ikFSWUDLPiXBCPtCQRCusWigNpPYQS0D1uk6ajGeGAnMoYZ+WzHgKRVrRUv2
         Phxhk/qzZTpSUxgSl36mfvwgbd5blTnEz/DwHixhWXX/AyNo8c1AbAkgtYOaNYazLJJ9
         CkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=P9lErvfRMqsjzgJyU2joQv+jFfLJva7YZtX9uTuJR7M=;
        b=sFpwFAdPbxIcgzRwvfs2uvEeTNXmz7DlPn/ckQA8wI9Ugv74dmScfO6o0lVpaUWhAc
         pC3XVj1UBQLXKS4jD/1C++quEunfOnLUBgoOtHfcuuU4lemajAYarTLreOTQZbA5rSyo
         hJ34LUftXdzVwJpLsTmeG2npdql/cx9O1EfpjJcnVAiXLasZktM4x7EzWmjpZ+aQU6nJ
         YmRAOibuGx8R+ZwAVE4+2BHMWMqupJ+p6nuEOWe6cj6TDJw/mmY5OeC9vtJ8hADFkReJ
         LX/T/FsNt0N0eXiwf1RD0iEQPocAp+jyfxPzu5hncP1odlMI01tO072cMt/cHzXe2iOc
         jC7w==
X-Gm-Message-State: AOAM5334GlCc/CNqT1tNErenByxTTYfzySvI1kErfRY4SmHfx6mNVaDk
        7JYAJfLryaR9x00a5snQwjU=
X-Google-Smtp-Source: ABdhPJy+AYDhw+w7/RVR9bei/tvkkk7tAtzsvF+8SKamp/DgBjOzkN0qbogg3ajZNC/E7TFnTaJl/w==
X-Received: by 2002:adf:e70d:0:b0:1e6:7e44:d986 with SMTP id c13-20020adfe70d000000b001e67e44d986mr6526144wrm.418.1645198150953;
        Fri, 18 Feb 2022 07:29:10 -0800 (PST)
Received: from cpi ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id 20sm4469952wmk.26.2022.02.18.07.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:29:10 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:29:08 +0100
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     mosescb.dev@gmail.com
Subject: rtl8192e: use BIT macro instead of left shifting
Message-ID: <20220218162908.48f83564@cpi>
Organization: CarrtotPi
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=46rom eaca0dd8fcbe3ff6daf14ea7a532e53acf840790 Mon Sep 17 00:00:00 2001
From: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Date: Fri, 18 Feb 2022 16:08:16 +0100
Subject: [PATCH] drivers: staging: rtl8192e: use BIT macro instead of left =
shifting

There is a BIT(nr) macro available in vdso/bits.h
which is doing the same left shift operation

Example: (1 << 7) =3D=3D BIT(7)

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_debug.h | 54 +++++++++++++------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8=
192e/rtllib_debug.h
index 9065901636f5..e3e8302945eb 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -7,6 +7,8 @@
 #ifndef _RTL_DEBUG_H
 #define _RTL_DEBUG_H
=20
+#include <linux/bits.h>
+
 /* Allow files to override DRV_NAME */
 #ifndef DRV_NAME
 #define DRV_NAME "rtllib_92e"
@@ -16,32 +18,32 @@ extern u32 rt_global_debug_component;
=20
 /* These are the defines for rt_global_debug_component */
 enum RTL_DEBUG {
-	COMP_TRACE		=3D (1 << 0),
-	COMP_DBG		=3D (1 << 1),
-	COMP_INIT		=3D (1 << 2),
-	COMP_RECV		=3D (1 << 3),
-	COMP_POWER		=3D (1 << 6),
-	COMP_SWBW		=3D (1 << 8),
-	COMP_SEC		=3D (1 << 9),
-	COMP_LPS		=3D (1 << 10),
-	COMP_QOS		=3D (1 << 11),
-	COMP_RATE		=3D (1 << 12),
-	COMP_RXDESC		=3D (1 << 13),
-	COMP_PHY		=3D (1 << 14),
-	COMP_DIG		=3D (1 << 15),
-	COMP_TXAGC		=3D (1 << 16),
-	COMP_HALDM		=3D (1 << 17),
-	COMP_POWER_TRACKING	=3D (1 << 18),
-	COMP_CH			=3D (1 << 19),
-	COMP_RF			=3D (1 << 20),
-	COMP_FIRMWARE		=3D (1 << 21),
-	COMP_RESET		=3D (1 << 23),
-	COMP_CMDPKT		=3D (1 << 24),
-	COMP_SCAN		=3D (1 << 25),
-	COMP_PS			=3D (1 << 26),
-	COMP_DOWN		=3D (1 << 27),
-	COMP_INTR		=3D (1 << 28),
-	COMP_ERR		=3D (1 << 31)
+	COMP_TRACE		=3D BIT(0),
+	COMP_DBG		=3D BIT(1),
+	COMP_INIT		=3D BIT(2),
+	COMP_RECV		=3D BIT(3),
+	COMP_POWER		=3D BIT(6),
+	COMP_SWBW		=3D BIT(8),
+	COMP_SEC		=3D BIT(9),
+	COMP_LPS		=3D BIT(10),
+	COMP_QOS		=3D BIT(11),
+	COMP_RATE		=3D BIT(12),
+	COMP_RXDESC		=3D BIT(13),
+	COMP_PHY		=3D BIT(14),
+	COMP_DIG		=3D BIT(15),
+	COMP_TXAGC		=3D BIT(16),
+	COMP_HALDM		=3D BIT(17),
+	COMP_POWER_TRACKING	=3D BIT(18),
+	COMP_CH			=3D BIT(19),
+	COMP_RF			=3D BIT(20),
+	COMP_FIRMWARE		=3D BIT(21),
+	COMP_RESET		=3D BIT(23),
+	COMP_CMDPKT		=3D BIT(24),
+	COMP_SCAN		=3D BIT(25),
+	COMP_PS			=3D BIT(26),
+	COMP_DOWN		=3D BIT(27),
+	COMP_INTR		=3D BIT(28),
+	COMP_ERR		=3D BIT(31)
 };
=20
 #define RT_TRACE(component, x, args...)		\
--=20
2.30.2


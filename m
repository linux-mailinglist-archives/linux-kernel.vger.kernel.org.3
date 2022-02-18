Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91754BBC3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiBRPcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:32:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbiBRPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:32:33 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC22B2FEE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:32:16 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m27so3414366wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:organization:mime-version
         :content-transfer-encoding;
        bh=P9lErvfRMqsjzgJyU2joQv+jFfLJva7YZtX9uTuJR7M=;
        b=ebZuG8D5P3OEszEFCfbCbZGDW+kppNGFDCBlkBEhZYwPJno/AvmSK7qAk6CM3B8+2C
         /uXN0pvQoJ1W9Uc288SpKpEybfN4CwWliquyLP1FFOB7SgH+710Sk+TmjAooi6F4tlyM
         3dMgqnue9kbn95JdSl0P+9oixbaHIWvJGXr5qsgSEDUhBkanwo6HeXjer66x2oswLQMB
         XJq5o5PvNCeDwCpFr6kB3TkUgSNWlc0YyRUkulOoBAkM2/ulbT5XVcLY+9jfq/mPJa/E
         /IvgP23hyEi22RDQIKR8ebEI6FKlqpAxSVffvNL661wt10frFz7w+HSOjgvpQX/HTtbI
         LS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=P9lErvfRMqsjzgJyU2joQv+jFfLJva7YZtX9uTuJR7M=;
        b=nnDC15m5imskjAQPJF0+iv+XwwXoU1KCqJvC1JkQBOSjUi5ccq+2V1bXSmNirEuk6e
         QlbYZQi1nBixHv5euNt4m19rfnqSkwLgJJA8WWIJF+rDrItfLm9HBAL+batKX7//quBP
         bED1Pzr/0UYmPq1QisQdUiyDvX1kkF5a8pDKchFY5uNHhvdspfkhEOgdGYqg+FtxsMXV
         MGMGTUnEJtAbXWZ+/4UQlX92Wf74yWzdRUQ3YfUr8vcQ93ihfsTPHzlHLn+XyOnc6k6v
         SZrb6k/liV7SaEmT/Jw4iKRhdq6zKhCSWHV+TA/lPr1E57TSZsEwWGnQ410vNV7S53zc
         +TJg==
X-Gm-Message-State: AOAM530DAalanuat3X9LYQiVvuIDo94eLJ3j19u5VKJuL/9c7bLt+tmN
        QmGt/BUOWXxKlJTCIPLdycUhV2MBOH7gsg==
X-Google-Smtp-Source: ABdhPJxm/zhJBHUkbsbn14NAHTYAGdXha+JUaqzF+paU4ihLIPernc78JLScteZRW75/1WuLpm96pQ==
X-Received: by 2002:adf:82cf:0:b0:1d4:2f04:8c23 with SMTP id 73-20020adf82cf000000b001d42f048c23mr6402136wrc.375.1645198335333;
        Fri, 18 Feb 2022 07:32:15 -0800 (PST)
Received: from cpi ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id y10sm4445426wmi.47.2022.02.18.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 07:32:14 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:32:12 +0100
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: rtl8192e: use BIT macro instead of left shifting
Message-ID: <20220218163212.7103e9e6@cpi>
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


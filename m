Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879054BC9D9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242827AbiBSSdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:33:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242395AbiBSSdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:33:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793663FD86
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:32:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h6so19891706wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2Om4HUFwHssKMFJC3KShI30/to87HwYxiHEG6JaehI=;
        b=EoDhkQTMB5IM+DTH8OHKdybl1rk3RzIBZBDiXmz7BkNJRu51aQdK1760aBafU9ANKt
         J4lEvccjIr7mXjEvQkrVGN196GlTH/v6ChA/uk67fBGnNjN5kOUXfqAmZfHYGydATKxk
         U4uAtZ1XXH74E8H9ycNuptFDH6cu+fRveax3MelGi59iGK1EKmV0sWyujMHRNuDOoVdl
         qQSq7WoT5sDMVzFwF9NsL5ztpUu6H10WzKAO5bHUa4n2wFBgk7A4qdc7xkGIqaAMqYhZ
         MaBsxaRU4TTIwH1pDItprmjHPMJjedykjNXF7vNotap/BFBxVPruGPJAg/JVQ3hQUK28
         FL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x2Om4HUFwHssKMFJC3KShI30/to87HwYxiHEG6JaehI=;
        b=eDvqzs9ltiH6eAh1bW1/afqaxmIKXc7vGxH9wIhSdc18mKQs9Z/RVp1GUItietDbnD
         0o2CFZKTk3g0JiiPth3YmwRebfPUYZraqHU7YMe/nv+n23t3s/lQTwXF1L8Pqv7uBHB7
         JB1XTjVZvPqWy4W3bgjh541ITqES8MX1x5VkDqUPC8NNA2vqWLTT/CfTrnqvsn9I1I0c
         kNgxXsWZthp/0Bi5jqjGzVcchinLs1a3O/qaPzRVuG9QNVQ3d7YB3zmO8sYj0h8gabp0
         +/nZqwAdeT0vhz/XGuOA4JMbvONrLqO6VNL3vTBc12gqn7jxpC6A9dwFxlsH1PSMh8Uv
         VHBw==
X-Gm-Message-State: AOAM530wIwu6yfls4VZvyEMzaprtno8UbBXDONIZOuQFt11boes+QPqH
        W0pKtXHJ26FpCIp6Yzuzx2I=
X-Google-Smtp-Source: ABdhPJxW/bkxF1YMHMa3U/USwle3YdSMCmXlMTXKuv5YFiY9MopFNWJ6q6gTKGrzFKhCqzCl64/O0w==
X-Received: by 2002:adf:f851:0:b0:1e5:c793:3e85 with SMTP id d17-20020adff851000000b001e5c7933e85mr10450437wrq.113.1645295557980;
        Sat, 19 Feb 2022 10:32:37 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id ba27sm17611568wrb.61.2022.02.19.10.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:32:37 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
Subject: [PATCH] staging: rtl8192e: use BIT macro instead of left shifting
Date:   Sat, 19 Feb 2022 19:32:34 +0100
Message-Id: <20220219183234.31216-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There is a BIT(nr) macro available in vdso/bits.h
which is doing the same left shift operation

Example: (1 << 7) == BIT(7)

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_debug.h | 54 +++++++++++++------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_debug.h b/drivers/staging/rtl8192e/rtllib_debug.h
index 9065901636f5..e3e8302945eb 100644
--- a/drivers/staging/rtl8192e/rtllib_debug.h
+++ b/drivers/staging/rtl8192e/rtllib_debug.h
@@ -7,6 +7,8 @@
 #ifndef _RTL_DEBUG_H
 #define _RTL_DEBUG_H
 
+#include <linux/bits.h>
+
 /* Allow files to override DRV_NAME */
 #ifndef DRV_NAME
 #define DRV_NAME "rtllib_92e"
@@ -16,32 +18,32 @@ extern u32 rt_global_debug_component;
 
 /* These are the defines for rt_global_debug_component */
 enum RTL_DEBUG {
-	COMP_TRACE		= (1 << 0),
-	COMP_DBG		= (1 << 1),
-	COMP_INIT		= (1 << 2),
-	COMP_RECV		= (1 << 3),
-	COMP_POWER		= (1 << 6),
-	COMP_SWBW		= (1 << 8),
-	COMP_SEC		= (1 << 9),
-	COMP_LPS		= (1 << 10),
-	COMP_QOS		= (1 << 11),
-	COMP_RATE		= (1 << 12),
-	COMP_RXDESC		= (1 << 13),
-	COMP_PHY		= (1 << 14),
-	COMP_DIG		= (1 << 15),
-	COMP_TXAGC		= (1 << 16),
-	COMP_HALDM		= (1 << 17),
-	COMP_POWER_TRACKING	= (1 << 18),
-	COMP_CH			= (1 << 19),
-	COMP_RF			= (1 << 20),
-	COMP_FIRMWARE		= (1 << 21),
-	COMP_RESET		= (1 << 23),
-	COMP_CMDPKT		= (1 << 24),
-	COMP_SCAN		= (1 << 25),
-	COMP_PS			= (1 << 26),
-	COMP_DOWN		= (1 << 27),
-	COMP_INTR		= (1 << 28),
-	COMP_ERR		= (1 << 31)
+	COMP_TRACE		= BIT(0),
+	COMP_DBG		= BIT(1),
+	COMP_INIT		= BIT(2),
+	COMP_RECV		= BIT(3),
+	COMP_POWER		= BIT(6),
+	COMP_SWBW		= BIT(8),
+	COMP_SEC		= BIT(9),
+	COMP_LPS		= BIT(10),
+	COMP_QOS		= BIT(11),
+	COMP_RATE		= BIT(12),
+	COMP_RXDESC		= BIT(13),
+	COMP_PHY		= BIT(14),
+	COMP_DIG		= BIT(15),
+	COMP_TXAGC		= BIT(16),
+	COMP_HALDM		= BIT(17),
+	COMP_POWER_TRACKING	= BIT(18),
+	COMP_CH			= BIT(19),
+	COMP_RF			= BIT(20),
+	COMP_FIRMWARE		= BIT(21),
+	COMP_RESET		= BIT(23),
+	COMP_CMDPKT		= BIT(24),
+	COMP_SCAN		= BIT(25),
+	COMP_PS			= BIT(26),
+	COMP_DOWN		= BIT(27),
+	COMP_INTR		= BIT(28),
+	COMP_ERR		= BIT(31)
 };
 
 #define RT_TRACE(component, x, args...)		\
-- 
2.30.2


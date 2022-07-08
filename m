Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B6456BF06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbiGHQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbiGHQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:57:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C1113
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 09:56:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so1414701wmb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 09:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XChKEQdQBp8Xhc/f+8kVN+QJ7PmKFATNiMiZLMFoUcs=;
        b=ZkzoE2sTA9GdkN8O7o/bdeBZsb79lfSNGIlZFvI0bk0ofJqPtfAbvwrp35uUKir2bF
         wt9sL5TFz2w7v72gxBy/8pzAwMDex61FAYvOiIy3brtG0jYgpwVp4Et7ChLzDCcsw7r+
         9IBI5QPnaRlqtbO3vG/8K2Of98Pch6BqFh5BiFBoCfCbPLbaKU5gXmHi51oH98KjeQkg
         t7cqDm01bKSWChh+IOGyfBT/FtJ96+KSo0VQLmBs3qJMlqEbw8DtJzNbTphaa2dgSzWx
         o0ZnX4J/Pzzhrt3W7bMRkwjPt48qP5hRt26GtwKW2y0VsaLlvqfNUjuCZwgWGLADmbP4
         3+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XChKEQdQBp8Xhc/f+8kVN+QJ7PmKFATNiMiZLMFoUcs=;
        b=ld0GYUaXkGmMOrT0iqGauzHG9d1EnMzkCMW1NlCoOz8jp8lX3uEu0+2w22qYPXMSHg
         a0LJffuI6xIYDqrhQbm9hNLk6jW6fF5FKQp8QM0aTORrli5CH9G/gtjXNBhr5QSOtzJm
         fuWoWHrCSkanDDYOyoZZGwHdg05PN6KOVoQ7eNGbj2bvTBBnrpfdxizKncRTiCMez20X
         ZnQj0nmwA09xPM3AnM5zgnKJH+E0fBnu3tiy9XLRukcV0ezRk5wiK1T/IJzROYG1h+cG
         yoh3ZKeTV7F0Refs2jVuZqT97RMugsHb+xm/QZsTwDo6QdHk9aGuc8unCCMs+iHA6Gss
         13kg==
X-Gm-Message-State: AJIora9teGCGHsMK77L0/ukeV34i2AoX0MWJ80TiHbdf7deROzc9jFfX
        Smd1jCCuPTx9ZXJgEUclWtEJFA==
X-Google-Smtp-Source: AGRyM1slaXQGTOtfuLkcJfFRFrDt3NyT1QIdBcvTX4D1y3C1eLRfV8BfXoa3KyupTGrEf8qaz5NUVA==
X-Received: by 2002:a05:600c:1f19:b0:3a1:8d3b:91ad with SMTP id bd25-20020a05600c1f1900b003a18d3b91admr798880wmb.111.1657299418412;
        Fri, 08 Jul 2022 09:56:58 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c339300b0039c4506bd25sm3039758wmp.14.2022.07.08.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:56:58 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] reset: allow building of reset simple driver if expert config selected
Date:   Fri,  8 Jul 2022 17:56:56 +0100
Message-Id: <20220708165656.269507-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_EXPERT is selected, allow selection of CONFIG_RESET_SIMPLE
if needed by the user.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/reset/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 93c8d07ee328..f40d9bbb686a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -200,7 +200,7 @@ config RESET_SCMI
 	  firmware controlling all the reset signals.
 
 config RESET_SIMPLE
-	bool "Simple Reset Controller Driver" if COMPILE_TEST
+	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
 	default ARCH_ASPEED || ARCH_BCM4908 || ARCH_BITMAIN || ARCH_REALTEK || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
 	help
 	  This enables a simple reset controller driver for reset lines that
-- 
2.35.1


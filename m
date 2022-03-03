Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02C4CC1D3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiCCPoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbiCCPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:44:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A4F156789
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:43:12 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so8435888wrg.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PSCHAaDenzt4edS/TpOqLWi3iR26rz23jJzPsr8loik=;
        b=rG7/7F3dsVpH+KXNJD7VT7jRZyBZTUZSFw/espgf5K7KrE5qU8zc6i4r+oBidw/zA8
         8U2+ORhiGKbYxeHleTcHaGZcGQP16ljYOk2124ryYEGee5qL02dcTwv4PucPIcZogMmH
         K+WCw0TISP2SzioYnXIm1I2y5MGtNGNDnh9reuODWKsVcqCQ7NPGxrVAQ6UdP7um92KE
         AbGwO7vseqUKIdExVAQ1jxsX+8jRQL+dOj/GAxgiL+Zsnr98jNNuQJ5Yleha5KWw3pAz
         MKmxfCgFmhfuHwIOGN9ebBSyCknPeGYz6FCBPrnlX3HhfUYo2u+6YtxXSzbehAKtgd6G
         JfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PSCHAaDenzt4edS/TpOqLWi3iR26rz23jJzPsr8loik=;
        b=ThSGgQSxvwV08+Q9q7+QiLG5X1Zn67q68uZ599Km6r1Ce6JoTavNxF8cJFaVggaPQa
         lYDG1/P5GcBeS4hXt9IUC5n9OL+8l56NtVPC8mQQDvZMmeFQaDB6KS1mvm05VuUC2Lq8
         WE7rn8t3Rvb/XMpj/9MnFC+4hMGyooD+WrK3snqwqd1vG5tGFuwjjqQ5+kkE2lnW3k1C
         2jL1IMEIO3bOK+qtJfhXNm2qo/q3s9wNKzsxHLVegjBc3j2zeglUt52EE6v/K887JWgO
         wZlZxAB1uX6+l9mJGTr8qjBK5YvRon1XMK7ZT1AO0qZy7KVP6dotupvfgqgwcW2CKsUV
         SpQA==
X-Gm-Message-State: AOAM532wLB0QE/thdxmYVRIl/VYlM9A4YQPHpmMPXswDhZnEjZTaw7Xd
        TkuxJ1KtSJbskYb1DyMpijoxyA==
X-Google-Smtp-Source: ABdhPJzpTbgc6mER3JSjzjYsqiHETOOoZa7y+1TxYK/JpmzljTZGmrvxt+exnZrgbxkIdOrUNgOKkg==
X-Received: by 2002:a05:6000:253:b0:1ef:8a2b:8db8 with SMTP id m19-20020a056000025300b001ef8a2b8db8mr19278269wrz.321.1646322191248;
        Thu, 03 Mar 2022 07:43:11 -0800 (PST)
Received: from localhost.localdomain ([2a01:cb19:8b2c:5e00:e059:ffd7:be1c:ef2c])
        by smtp.gmail.com with ESMTPSA id d8-20020a056000114800b001f045f3435asm3272452wrx.108.2022.03.03.07.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:43:10 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v21 3/3] arm64: defconfig: Add CONFIG_KEYBOARD_MT6779=m
Date:   Thu,  3 Mar 2022 16:43:02 +0100
Message-Id: <20220303154302.252041-4-mkorpershoek@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303154302.252041-1-mkorpershoek@baylibre.com>
References: <20220303154302.252041-1-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "fengping.yu" <fengping.yu@mediatek.com>

Add Mediatek matrix keypad support in defconfig.

Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 30516dc0b70e..e8ca75ce52c1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -391,6 +391,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
+CONFIG_KEYBOARD_MT6779=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m
 CONFIG_TOUCHSCREEN_GOODIX=m
-- 
2.32.0


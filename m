Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19FC4E88AD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 18:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiC0QKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 12:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiC0QKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 12:10:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21547140B4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:08:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d7so17035954wrb.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ov+7Ck42RvbgYnt5K8SkrxtXocNZedNN5M9fAzVeOxA=;
        b=MxRx89uyTMlNU5ntlj7aSXIW5vG4yJvQ5UTnsMDhUYL7vtP1EKhgp8u/4WdzLwMuDL
         iWaNb8uSukU1Zsvaf1SxzzqJmBIS3f2nKDvlHdcTyVMbkLOBPmJ/SKgeo6yxQeaIGlRj
         ciofPkh/CyaVHAcwierKv4QWtKbAlVNNo584n5sFIc7b/eshu6V5i2m4JVPwwyVp6ono
         aI7CTuk54iUYPSbNCSf5SckE/aEA8NASGwQmNookRjp0j0B4T9ABXR6lRanYb6dAP5GV
         lgq7/X5JG9HVDl3c/Af9Pw+ZSXqk+cLmKizq/IF6ZFFzd7VmXzhjgWcnBtlGxdkM27Ga
         yFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ov+7Ck42RvbgYnt5K8SkrxtXocNZedNN5M9fAzVeOxA=;
        b=0+oVcVZZxWMOPGT1sq3XO7VFESCQWZ4p3sdlaD0f4i3S6M+S7/EYNrmKDmc/T4uPsc
         45kNpGKJBtH+digW9/kaKGZgTduZ7JSt7ciw3ptqqEUtLRpldIBjwKS/99Bqfuawiat1
         /h/L6m4ufM0mDy2Lhg1u2GX5OP/Up23h7hjxLtZE88Tqqp1oXiLZ8RzRMmMg1zp5h9UY
         +zEXozPk95KQn0D9cxcCxZxq4m42Mg8vhnQtn/IE+lgbMoKuSV1KZhbZ/R5cPSAruNa7
         HQ4T3bqxTIAL2WeJW0+BdKcOkSfq3PFX7PxvWZFFYZOWyYZUmsmZKcqXuGMlE6MBuG6t
         TEZw==
X-Gm-Message-State: AOAM531Ca8nmmqUUlweYievXG9ZP75/S1vL25yOT2v6Yq5/CnAM3kNM8
        DTPJ9RBwuM3QvJ8hzAa52hzW4A==
X-Google-Smtp-Source: ABdhPJwzeaGl81CkXL3nxPc7P7D9Xdw/+Q2JXGwaRyYkFlUNX56vEB3lxgaITvOaWZMekEn/bA0MaQ==
X-Received: by 2002:a5d:5607:0:b0:203:fb6f:3c88 with SMTP id l7-20020a5d5607000000b00203fb6f3c88mr18432363wrv.261.1648397318694;
        Sun, 27 Mar 2022 09:08:38 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm9425883wmi.39.2022.03.27.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:08:37 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pinctrl: mediatek: mt8195: enable driver on mtk platforms
Date:   Sun, 27 Mar 2022 18:08:13 +0200
Message-Id: <20220327160813.2978637-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.1
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

Set the pinctrl driver as built-in by default if
ARM64 and ARCH_MEDIATEK are enabled.

Fixes: 6cf5e9ef362a ("pinctrl: add pinctrl driver on mt8195")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 66db4ac5d169..8b20109559b3 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -158,6 +158,7 @@ config PINCTRL_MT8195
 	bool "Mediatek MT8195 pin control"
 	depends on OF
 	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
 	select PINCTRL_MTK_PARIS
 
 config PINCTRL_MT8365
-- 
2.35.1


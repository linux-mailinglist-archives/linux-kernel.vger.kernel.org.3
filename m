Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91F504AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 03:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235727AbiDRBxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 21:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235719AbiDRBxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 21:53:22 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9A3E0DA;
        Sun, 17 Apr 2022 18:50:44 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id a5so10114948qvx.1;
        Sun, 17 Apr 2022 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0klc3vSW9S8k8P5p+Y99UzFgu/vMr+K9666OjOkemo=;
        b=oFB3YM/cBOiqfYZxvFdFEg5vfZG0buEK/6QghUeBqmcckbwCjUWYxLw9SSetJ3D6xd
         PSGA0HmP6gyvABB6YfZCNrIezmxM+2Ri7KaKRAHlQeOBtP04SkovKdyLM4Qjx9NScEm1
         LYf40LWmhg4wnjLS3HfIOY7oI4nRqK1d6p5GMguGSPe4DmKK/NoUihutB0UGDeZh3twj
         30lvQLbXMTyhc5hpz7M/xq8uEZw29nbh81y0usT7B/OCBFeJ2RnC9vPUywbARpbzY6s6
         E9JxZ2wr1/Owp0pORM0+EYNETeEVSEdpGYnDj8/UaVMsxNI6Df1QZTtbPuLY3gY6z7Ct
         Dr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l0klc3vSW9S8k8P5p+Y99UzFgu/vMr+K9666OjOkemo=;
        b=Vik7JltIMXPllkvu8JVSxLDm5fXBhkyS1hFg2wO4uZIBY791FiZHAuoVsU7z05HUi1
         sWrHkTmDXmCGCVt8fzy8agQuYL4pEkztw0jzj7xi1ud4uEhwFnjPy4/7v40Z6vnSKXhK
         4NjxBhy90RUdWLxNx2JUlFCa+9zkjvXYDk0lfMSHnlbIPgymtTpKZhwCOfrCWQimnJZd
         UQw3ETFlt+DnMZ7WylSZaownqSxSK/j5qlC+fNSCVu+QNi2IaxqutZZNplM7/pNBGnVr
         YaKlFHJccPxI+S4pmnWPkOaqigSCg2Smf9IIiA9kq6ENM/TlyGzhkgL4Z3rU6G/q0NiY
         djfQ==
X-Gm-Message-State: AOAM5304Mi1g4O1D7i4f8JUh66DNQ56EOkH2RIv5tQCXh8xbbLox+E2t
        Zd1cLu4EsIf5wUSA/pHvXkQ=
X-Google-Smtp-Source: ABdhPJxCsioiF8X96/nDwZ2mphbAQTjNUURDHOENi9NQ8gY34Uwf04BnTV7MkACfELksTbMJB+f6SA==
X-Received: by 2002:a0c:fd91:0:b0:444:46e9:9556 with SMTP id p17-20020a0cfd91000000b0044446e99556mr6464611qvr.75.1650246644025;
        Sun, 17 Apr 2022 18:50:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 128-20020a370486000000b0069e9d72b45fsm981714qke.13.2022.04.17.18.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:50:43 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dmitry.torokhov@gmail.com, alexander.sverdlin@gmail.com
Cc:     lv.ruyi@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] input: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 18 Apr 2022 01:50:36 +0000
Message-Id: <20220418015036.2556731-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/input/keyboard/ep93xx_keypad.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 272a4f1c6e81..7a3b0664ab4f 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -231,7 +231,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	struct ep93xx_keypad *keypad;
 	const struct matrix_keymap_data *keymap_data;
 	struct input_dev *input_dev;
-	struct resource *res;
 	int err;
 
 	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
@@ -250,11 +249,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	if (keypad->irq < 0)
 		return keypad->irq;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
-
-	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	keypad->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(keypad->mmio_base))
 		return PTR_ERR(keypad->mmio_base);
 
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF834D0E22
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiCHCwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiCHCv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:51:59 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B31366B3;
        Mon,  7 Mar 2022 18:51:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id q4so13730285qki.11;
        Mon, 07 Mar 2022 18:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHziwswHK6uNSR77kAaO2ffhpQzUQz0uMTDDzxEF4Ok=;
        b=F+Kwc2v0NjeMR4vC8LyG9ZsURiTPhcvH8Epa7frmH6GHTEIUAHL1iAnRFlZR9OhAVy
         HtEXQI7Nph4PySyAjpqSf3vKWyyfwvrZb0PSK950nYBCQk3av2NoEcwrLzewuhSx55Lg
         SBMI5LJJ69CSmcmL303PSjB16okbG3qLF1tllQeG/J6PigTysYUx3hMsIYRu2PjERy4E
         fHKlvBZYTaWFzi5vPKGlm8AWO6WA7wpgx6HFpFfX3HdSy1WV3s3nN0250Xp/Z2E7WGpS
         mzwU5ZzizP/oYsFcdRCIKXEEI62xHUBAA6As0l5UmnMcRDkew4HOW7Wz1lrC3FxphPh0
         OhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dHziwswHK6uNSR77kAaO2ffhpQzUQz0uMTDDzxEF4Ok=;
        b=aCsqLFb85YBlH7g2rlB6YNPUGtQnAgKx7nKJM7mdIbV1OptpG+rX+LKaebpnXhWNqz
         fgY0uNUPURCP8NQImxr+uAq9mwkzeDpUCz8Z5JEuD7rQlRR8FPjJU2jejaNZ1zxob1rJ
         g+w1Rj1f3hsHrIDaz1OXkXZpfS07d4KdVPr/W9G9e6QbeZlnq/IMArYz1hAmHRIbgyV4
         A7J9XJbfb8FeqRFq5frgThdT6ONLmXKj/JLUx5QP9T3cm2yF2OHYKd4NBDhmjmm9amLS
         0DYO0VbQJER8hakbN7IKxTPp2y2E9DHCrGK+T8cQm/tkHyndZOCRnZudtOnF2b1sgBzI
         vYNw==
X-Gm-Message-State: AOAM533iEHq3BqoJ/aZbIqofv7q9Yq3n13NUwHagOiUL+h3nLzDW8soY
        49jOe8yCIhgc7GNDJmHNS1U=
X-Google-Smtp-Source: ABdhPJzRTUy5nLA4k0FOzG3DQXk/0Q2mTdSiWzr1tJiLmP001iyJl/Q2/IX8p96NjKA2WEMjYSob6Q==
X-Received: by 2002:a05:620a:40d1:b0:67b:ce7:702 with SMTP id g17-20020a05620a40d100b0067b0ce70702mr7712663qko.183.1646707862525;
        Mon, 07 Mar 2022 18:51:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d21-20020a05622a101500b002e07151139fsm244291qte.17.2022.03.07.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:51:01 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        lv.ruyi@zte.com.cn, fengping.yu@mediatek.com,
        m.felsch@pengutronix.de, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] input: fix variable type
Date:   Tue,  8 Mar 2022 02:50:54 +0000
Message-Id: <20220308025054.2077162-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>

The irq is defined unsigned int. If the platform_get_irq return a negative
value, data type cast may result in error.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi (CGEL ZTE) <lv.ruyi@zte.com.cn>
---
 drivers/input/keyboard/mt6779-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/mt6779-keypad.c b/drivers/input/keyboard/mt6779-keypad.c
index 5ff23250ed37..0dbbddc7f298 100644
--- a/drivers/input/keyboard/mt6779-keypad.c
+++ b/drivers/input/keyboard/mt6779-keypad.c
@@ -91,7 +91,7 @@ static void mt6779_keypad_clk_disable(void *data)
 static int mt6779_keypad_pdrv_probe(struct platform_device *pdev)
 {
 	struct mt6779_keypad *keypad;
-	unsigned int irq;
+	int irq;
 	u32 debounce;
 	bool wakeup;
 	int error;
-- 
2.25.1


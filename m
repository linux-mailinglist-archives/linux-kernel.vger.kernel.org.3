Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E613250C8B4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 11:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiDWJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiDWJpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 05:45:30 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7F2C1D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:42:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z99so13109683ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 02:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u792v8dWSrl2ZKGoVimsoHmq0ePG9eKFTfKDgwzNgLI=;
        b=tLzEnTlRJkNulWYGLlGFKEq9rQVE/xl45c4QwO1bEH2T8ymzoHyxbBq5m8vjsguIbF
         JKuoB2NdjGJEqtHZi36LJ8IfeeMQRW86pAUqO3IZR+MXzsXwiocaSY6XrEuoKOPms1/Y
         9zalCOkRBlbLygpsMcBB5nU0JM6EbgVqdmNKPS3ASAlr9LXKWq7Nouwn/gwrPleF2XGd
         hLxfpICzbnHPYudDkyP3gc6W08cEeYa+pFoJafVIq0qaDrZLLkEZ/FQ4HKq90n08cMC9
         WAw7S1LeVUgdHZIGkzfi8c5NJnzkZFvpbqJDxIg2w+OXDS5hwhDgjPe4KBHLWh0rv5gH
         QJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u792v8dWSrl2ZKGoVimsoHmq0ePG9eKFTfKDgwzNgLI=;
        b=QJSh5ADQzRvORHRPF+WbTmCsqvPr2GrPDiLb1M0vvRav2Di1SbfhoLWVEX4a1/HdtS
         +hpEntLs5zFnHrYTUa1m31YG87ZJQH2ZsBtmo/869OtX5T1Uive07tQYVR6gjC/H+WIH
         dXFsYjwKeuUOwEZeOUEZ/ou7DQbfMJjGgxjnbGAlZGC7xiQK/yjrXijoFHjTMXlBwwHS
         B4d2VtxXWYYumexIiuvu+K/MBeujG23IBsOIqOxIVMQVL0w9AJlR78lt8PcXWSkn1cuH
         Jxg4F6iZYbr4oB/UYFMCcZ9gFMdwxhBZbosWx0GqN/jy1Rb3CISjxb4lZ7UkfmkvTo9D
         ChgA==
X-Gm-Message-State: AOAM531xjt309F4r9mLPFZw/bMFrl8u8D292C/1WRlrSWVDWOaozQnA1
        LMFMfOnG8Mv5/OsbmJ4YewmEng==
X-Google-Smtp-Source: ABdhPJwvkG22uMan8o05CdMC4hjydmtl4dSRgwNbR/T9fkB9oinekkKjiP8fjsgtBL8oL2FOJtfwLw==
X-Received: by 2002:a05:6402:42cb:b0:425:d34f:e8ca with SMTP id i11-20020a05640242cb00b00425d34fe8camr2337767edc.126.1650706951641;
        Sat, 23 Apr 2022 02:42:31 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h22-20020a056402281600b004206bd9d0c6sm2069067ede.8.2022.04.23.02.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 02:42:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value
Date:   Sat, 23 Apr 2022 11:42:27 +0200
Message-Id: <20220423094227.33148-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220423094227.33148-1-krzysztof.kozlowski@linaro.org>
References: <20220423094227.33148-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Correct the return value passed further.
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 18b77c3e6db4..279e92cf0b16 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -157,8 +157,8 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq < 0) {
-		rc = irq;
+	if (!irq) {
+		rc = -EINVAL;
 		goto err;
 	}
 
-- 
2.32.0


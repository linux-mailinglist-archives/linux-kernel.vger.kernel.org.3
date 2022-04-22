Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF250B565
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446791AbiDVKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446792AbiDVKoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:44:03 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6759A1FB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:41:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ks6so15611583ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkdTds2gqnd8Xl8DjK8EF0/jpc2ZR5Q5WZgVXWZ5jSc=;
        b=z2km03Qw8xmX4MpL5+XyOmUK8TWb03ryVWsqBYYCd8WqKF9Rr5lgwVyGwB28/plE2S
         6Xqgqz9FHT9wek7ZK8NtmK1ls18ds8QXKwaHpR3G5W4KlV9lEAaZ1JBmaFB4u3QQPRWz
         aiFZmp9aN8f5rm2H7qmglKvrjTiYwlH8GfBj096y4T523ohUTna+9ERXWCqmsY+new06
         zY4rB3aDj0DnP0QDFF6z6KOAACqNWiqvuEEUuqPpRmoh1R7gitcnjKyjCzpmkfujUvqP
         Xj9eAxxikEw8EMjzJj3hEnMNSxb+cXuPzCKk/1/r9YoSt7pw/nAH4PblfXaXzKiy4FGX
         GJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkdTds2gqnd8Xl8DjK8EF0/jpc2ZR5Q5WZgVXWZ5jSc=;
        b=cw8vio2kHmvB2vFStDIj92tyuoprsN1RbDj1JWdlj3GOC/7useOiCI7JLB8P4RI93m
         RA4QJ1p6lBHqaSRx+OSPfp+4ilDNaaitkfPWWtHkQ6SPBwTqeu5CFbedlOW+LcMq6PO4
         HIPSx7W6BoPgqA/am+IBgFAyxq53vJsSgjD2dDsIYeteaf9PuYfIIyD0cd84iVZZWBJe
         SWSC5aalVktKsfWdPShlIFkc3sZsrL/Cy0LuobBm0B5obKRV6E2jh/GO4vB7ztvDs3Oz
         bDYC9+mxicDhDGoRr3/mV6a3GTAh8N+KSEJgExH6y7oHHk+iSs16zsaQIZMg6bXlqwnM
         E3Vg==
X-Gm-Message-State: AOAM531DQaoHpfDGwnjRhegkTXJZe9B0pEHFP0RPyGp8+lxPYQdoErs+
        rfY/VuXDoUjKh7Q8TElE8pLN5g==
X-Google-Smtp-Source: ABdhPJwn3gxzgcRJY+u63RKV+6qqGy9XgIfyv4Z3nxAi8YZqa3+l86k/3nOaO8RSz4OFM7SWzp7qgQ==
X-Received: by 2002:a17:907:6e25:b0:6f0:99d4:9711 with SMTP id sd37-20020a1709076e2500b006f099d49711mr3019301ejc.511.1650624065001;
        Fri, 22 Apr 2022 03:41:05 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709063b1800b006e8cf786ee8sm619736ejf.21.2022.04.22.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:41:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clocksource/drivers/oxnas-rps: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 12:41:01 +0200
Message-Id: <20220422104101.55754-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: 89355274e1f7 ("clocksource/drivers/oxnas-rps: Add Oxford Semiconductor RPS Dual Timer")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clocksource/timer-oxnas-rps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index 56c0cc32d0ac..d514b44e67dd 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -236,7 +236,7 @@ static int __init oxnas_rps_timer_init(struct device_node *np)
 	}
 
 	rps->irq = irq_of_parse_and_map(np, 0);
-	if (rps->irq < 0) {
+	if (!rps->irq) {
 		ret = -EINVAL;
 		goto err_iomap;
 	}
-- 
2.32.0


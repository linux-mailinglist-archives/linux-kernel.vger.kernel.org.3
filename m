Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4DE50B59E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446910AbiDVK4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446889AbiDVK4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:56:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9E5523D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:53:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id el3so5141393edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zq2QegKAeDDJ8HC63i9v8FlnMMpvnBX4PceaklnpLi0=;
        b=p7a5U9mA6hUJIARdw+pDmiP5X7px4N+O1+v+u4U7Fpu7gU/C31ewbkjv9SSulCmwmE
         8YG0CKCT8VeEMxBONxpTIHxCmglJFWBC+didzO2L9vSS4YorWI0XT3HJadQoyOq5e9hq
         /yXLvzxGAcDS5E8HQP7Fls2DTEL4AvTa/xejw3zJptVPcl1NxPosOSHmfPc/MWyZCKr0
         ExCtkae9nlnjcdUsSWvyGdk2KFqbIB1U3uXTqkUjl8rqOfLnE2H2nRXj15zWG3sotO6D
         0bbTptC3EF3n30tKbcqP5bygtU8pyeTyNvvxltjC4ompnVOmCXnm+a5t/tLrs2WBeJ5q
         Rj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zq2QegKAeDDJ8HC63i9v8FlnMMpvnBX4PceaklnpLi0=;
        b=IbzIxg45+7V2m8uc/YWTcSQXjXPmna2vDU3KPkki5W+dYWfxlyUlUJpm0jGV2901Xs
         SWLJ/YS3WT0xtjlp3EiNLU8PC3xidrtCE1w6qM8g/bS0WTMBac2IxX/nL1P2mlnFGPxh
         mIu+sMDX42uzjrpzgzlZfY91R6jPn0OL5GO+flljYctLnxe1R7rVW1uRan0H71o2UMWX
         Gzk6IZmiAhNYdekER6AtKLPbEdnbcwrv7DL3nD3grsPDL7YRQoiuMXM/TZfAU9DbeFtP
         hmHiQBMg6X4EBgE7KQdnzyZYPgkD7gzVV28Qu8XUt+J62dDO/kvSM0Him7z90hDakj3z
         lvBw==
X-Gm-Message-State: AOAM530grRbFyMREgkUaWqwOMdDK/uFnT0V7ZXbgOeQoZRFgmTUIeixu
        95bICu+kRY4Di5u0PkjoLHJCyQ==
X-Google-Smtp-Source: ABdhPJzj9BN6ioAKa02gIEyTGqZeJuFyC2f0bqw21VTYYMJwvK90peDZ7wdXamHTOLcL3qgK9YaXaQ==
X-Received: by 2002:a05:6402:1d4e:b0:423:fd93:6466 with SMTP id dz14-20020a0564021d4e00b00423fd936466mr4154696edb.304.1650624825696;
        Fri, 22 Apr 2022 03:53:45 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gr21-20020a170906e2d500b006f27265cf75sm492934ejb.78.2022.04.22.03.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:53:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] pinctrl: mvebu: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 12:53:38 +0200
Message-Id: <20220422105339.78810-1-krzysztof.kozlowski@linaro.org>
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

Fixes: 2f227605394b ("pinctrl: armada-37xx: Add irqchip support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index ef4118e49f16..a140b6bfbfaa 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -764,7 +764,7 @@ static int armada_37xx_irqchip_register(struct platform_device *pdev,
 	for (i = 0; i < nr_irq_parent; i++) {
 		int irq = irq_of_parse_and_map(np, i);
 
-		if (irq < 0)
+		if (!irq)
 			continue;
 		girq->parents[i] = irq;
 	}
-- 
2.32.0


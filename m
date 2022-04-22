Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8254650B583
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbiDVKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382456AbiDVKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:48:34 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9270D2899F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:45:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g13so15618717ejb.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HE//HcQTXFALh6mE2wSN/v3f/KXxXJCpEOZ5pIZr4hY=;
        b=e5/VJ4uwjeEhiUDjL6Ro+kDSkXiKb18cIXdxJsgc9MfJ3kSMHDqpOjVws7MfyYMItP
         l7dfyU48/9yznSA611fHOqCN5jmwFasrttXsMVnHGH3Go2SPSw/NDk38rF6BJJE3PA98
         Q9aXDR+2Dy0BKEwHsrvGGCCXzDYQutoeQj13k43CJwL4OUox7D+BpQpErL2bzO4Y3RFa
         VbZlXOY0AGWAMIjskiP3aUih8nWm8F7mJu1CsC7IHTDBAn4O0X+jyEd2jPugwxq0LhSv
         5XKQp9Ra8YQYIYnfrM5xSjVJ1p60b8uZvw/Lr8Ix0MjhKdOudMEt9tVV1c/zgzLaPBSv
         5Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HE//HcQTXFALh6mE2wSN/v3f/KXxXJCpEOZ5pIZr4hY=;
        b=5rGYAQ7+uE7pL6JQGEU4WvKZpd6KoKv21oUJJYiNcdLlb/K2JerFxOecB4fDCBgSVZ
         GMd7ofKGMvONeSacVj0oEP+tcm5snzEIv7Gq6+j7I3e9r1/eXpJW8QnUtNDcOMW7sUUb
         m5izkVdAJ0QHkBGGmG+LK0riKAY80IkdJH5rEFel1rvHwfdeyh5mhUOiJRsLBkYF5Sim
         IZ4O5XCWYGvIQfKJeT6ScNquIqbuCVYEi6kf39TtAB6dzcaUjhICaNg87NkE9ky984YX
         wImZblP0cpbdFqHlSjHJoahc7RavVeT5m/I3pUVYTPB95gZbHd30cHsW15mClwJZmeqr
         jSIg==
X-Gm-Message-State: AOAM533MFNf02M7XAbXwIdA5NM86PyfM3kZ70xC5Bx+FDwdKyvYcAgHj
        T8icdePPIxK3PlfvTim63uF3Gg==
X-Google-Smtp-Source: ABdhPJx39u9MWyPfP66DFZ7RmPDZDn+dQyvSAT/UY9njPtByzeZizvvoyz2vh1Iv+uTdK1xL8PcpXA==
X-Received: by 2002:a17:906:2bd4:b0:6e8:7e5:39b6 with SMTP id n20-20020a1709062bd400b006e807e539b6mr3516862ejg.25.1650624340194;
        Fri, 22 Apr 2022 03:45:40 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cn27-20020a0564020cbb00b00418b0c7fbbfsm744502edb.32.2022.04.22.03.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:45:39 -0700 (PDT)
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
Subject: [PATCH 1/2] irqchip/aspeed-i2c-ic: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 12:45:35 +0200
Message-Id: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq_of_parse_and_map() returns 0 on failure, not a negative ERRNO.

Fixes: f48e699ddf70 ("irqchip/aspeed-i2c-ic: Add I2C IRQ controller for Aspeed")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/irqchip/irq-aspeed-i2c-ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aspeed-i2c-ic.c b/drivers/irqchip/irq-aspeed-i2c-ic.c
index a47db16ff960..cef1291ae783 100644
--- a/drivers/irqchip/irq-aspeed-i2c-ic.c
+++ b/drivers/irqchip/irq-aspeed-i2c-ic.c
@@ -77,7 +77,7 @@ static int __init aspeed_i2c_ic_of_init(struct device_node *node,
 	}
 
 	i2c_ic->parent_irq = irq_of_parse_and_map(node, 0);
-	if (i2c_ic->parent_irq < 0) {
+	if (!i2c_ic->parent_irq) {
 		ret = i2c_ic->parent_irq;
 		goto err_iounmap;
 	}
-- 
2.32.0


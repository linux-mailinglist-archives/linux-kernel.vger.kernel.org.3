Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1393750B581
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446848AbiDVKsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446602AbiDVKsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:48:35 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD05E3FBFA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:45:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y21so3037070edo.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0mPDFRf2yGCYjXvBv/hrY8X7EKal2dOh8Gqauv0y1o=;
        b=hMffFfUZGHLuMf4xjuCqC0todGSD5kRTFeTjJ/Kiq1GvDKE7GYPQ3BHfEWcc0+BLRo
         zfNfU1rBTvTUXATzcYtX/G3CPWoziz3HoJYMc7cipZ/SWumhn3QqeoYtqqyMZlGr3WbV
         56kHys/Ez8+9AqYfP78EOQGF8z5jZuNnJCl9IOPLFu2v/38oq2PZOFA9hlupunvO1zDY
         lTAjSXpPU5bqtAkqFbdpdHl3OJngGxgPeFSWr/RBrI33GnVBszAQEjEXLmiT8G1azlst
         xEuBRQlqa0Npblv/r4aiHrALyWxVk9RR5TE/8Addh8txKNshI89Vnr+oT6BqIuKRi4lA
         Kxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0mPDFRf2yGCYjXvBv/hrY8X7EKal2dOh8Gqauv0y1o=;
        b=TXDID6iD5msdJ6ZN7A3TP0BRoKpzYrhKnYhV92dNcanaiaM7p2jL1BDI83H42AjQmr
         v4+lcp5l4azGY1Cg9W9fchWowyml/PDvVMlfmfwb/NDhq9zjKor7HMANhDcAL9lZGiMo
         nMuWgx2Zdhy0Bim6IyK2wSrE9luu4m9EUllT0jev5B3jLvgdMthrjzakPu234o30r8Tv
         FXsQhZkjGQSS7QFLqLZ1Z3DnHYi3QsF8Cd4v/fljf+3+scqF5j+MvCLdJgCK5rYlkuUi
         eKxdGQC9Nva7HlJz9KOLW26gJBKK7r/xK6jy165zTSQGP3ULBEQWsO0/KNKKizwUIolY
         4HRw==
X-Gm-Message-State: AOAM533UmAb20eNN9KRCtykarASv+4VJiVFrS/Oq3GMwH2Uba9sZ3VIq
        tuHEVy5CCX52mxRkdZL9usQC/Q==
X-Google-Smtp-Source: ABdhPJzJD/7be1sR2YX5lXMsY8HObXb/T1c5dQYSajPOBst6CqwP9QEnjh5GfF1c3sLUGXKVJ3qfyw==
X-Received: by 2002:a05:6402:1107:b0:416:439a:6a9e with SMTP id u7-20020a056402110700b00416439a6a9emr4059032edv.382.1650624341298;
        Fri, 22 Apr 2022 03:45:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cn27-20020a0564020cbb00b00418b0c7fbbfsm744502edb.32.2022.04.22.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:45:40 -0700 (PDT)
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
Subject: [PATCH 2/2] irqchip/aspeed-scu-ic: Fix irq_of_parse_and_map() return value
Date:   Fri, 22 Apr 2022 12:45:36 +0200
Message-Id: <20220422104536.61451-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
References: <20220422104536.61451-1-krzysztof.kozlowski@linaro.org>
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

Fixes: 04f605906ff0 ("irqchip: Add Aspeed SCU interrupt controller")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/irqchip/irq-aspeed-scu-ic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c b/drivers/irqchip/irq-aspeed-scu-ic.c
index 18b77c3e6db4..9cf67541828f 100644
--- a/drivers/irqchip/irq-aspeed-scu-ic.c
+++ b/drivers/irqchip/irq-aspeed-scu-ic.c
@@ -157,7 +157,7 @@ static int aspeed_scu_ic_of_init_common(struct aspeed_scu_ic *scu_ic,
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
-	if (irq < 0) {
+	if (!irq) {
 		rc = irq;
 		goto err;
 	}
-- 
2.32.0


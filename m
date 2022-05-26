Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25FE534AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 09:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346478AbiEZHoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiEZHn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 03:43:57 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA9AA30A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:43:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h186so712649pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Px54YeB8y4JCFlFNgwFGWbi1FoMMkCqF3KundDZ3EiM=;
        b=RKAcJBZfcCsaxohCKWP/epF2GjaTRuqPwkXMhBS04emoALQjq+f+0LqvStAqcuFL26
         tC/r1F8A41UCHXN5vk6qvfALEcmEf18gPfvXVQ9VIygMe9/xHxbHOBUJEQ8z0DTqexS7
         9QSCPpk8uNZQ+aQgOlZ3yIdrpMpcsT1osL4jxTChrcImYDsAh7oZQ8slgyDDB9A0HAYG
         Tpl15amFM0/M95YmaSjWr7YTFTSCuuzGgPa+0N36ZKlSnN79zI8NF/xEiTKs7VPoia4S
         i+iLIBZOom58gtGv29qfDnPy+bHITAfz0RMwWaIZe5ox1JUJw1RWylS9jCJoc2RTTXXu
         Xi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Px54YeB8y4JCFlFNgwFGWbi1FoMMkCqF3KundDZ3EiM=;
        b=iS7gzOrNpzyjzxiwVo50qgrAdJjZojkFExaQQ2Uyff61SdGKK5IAhdIXc5DPeWbLP0
         LvwkxxGTmnyQBQzFnI1jTdu87Hg6nKctlQ4suqUnYrKZ4p0+C7t8yfeQiSS4XRti6sfx
         PzgwN5XaDzWjymBEqGKudDZFvz8HoiiCyMJsBQSV9EqSmONeCzVgGtjAe531pdpAbMSF
         l2nbgCX3LLYkgiX76lIjTk4jVf6PyI3iEp3mXnpUr7FUzA/v98AWu1zNrkkIkCQ1xASE
         jgWiJwh2TvTGxGvAoT+Jhy0A0J7GyiBJKRRlILl/MTjV47iONjC2oH3eUwfP6PHxqoWU
         Fs4g==
X-Gm-Message-State: AOAM530NkOToRXqOmmOMKfiPPW2VTrqWXoDUumJ7VBqS4RT9dI2mzqKd
        brhXcEOXBlfjVOYRYfydqTY=
X-Google-Smtp-Source: ABdhPJxHpYjo4AkSPPpqYEZho6uUGWUPUo6tXftM5V/7RkrdTncSttz6Hdun+1CP8TcGheN0L6Q1mw==
X-Received: by 2002:a65:6852:0:b0:3fa:9371:9de with SMTP id q18-20020a656852000000b003fa937109demr12699985pgt.413.1653551036057;
        Thu, 26 May 2022 00:43:56 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm765340plf.56.2022.05.26.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 00:43:55 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] irqchip/gic/realview: Fix refcount leak in realview_gic_of_init
Date:   Thu, 26 May 2022 11:43:48 +0400
Message-Id: <20220526074348.23972-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_matching_node_and_match() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: 82b0a434b436 ("irqchip/gic/realview: Support more RealView DCC variants")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/irqchip/irq-gic-realview.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-gic-realview.c b/drivers/irqchip/irq-gic-realview.c
index b4c1924f0255..38fab02ffe9d 100644
--- a/drivers/irqchip/irq-gic-realview.c
+++ b/drivers/irqchip/irq-gic-realview.c
@@ -57,6 +57,7 @@ realview_gic_of_init(struct device_node *node, struct device_node *parent)
 
 	/* The PB11MPCore GIC needs to be configured in the syscon */
 	map = syscon_node_to_regmap(np);
+	of_node_put(np);
 	if (!IS_ERR(map)) {
 		/* new irq mode with no DCC */
 		regmap_write(map, REALVIEW_SYS_LOCK_OFFSET,
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E9553DD3C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 18:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351338AbiFEQ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351325AbiFEQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 12:57:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C788225FC
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 09:57:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id me5so24329726ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uqI55ErVc07HSIivOX7AXS9kfYIm1rBhZwSqgaXUh40=;
        b=VIbhzFl/bTjxpaT0eAACnezKnRbICldZ9hYrKiZSu8aZCsyIkvl+8ItvppwWMaM4cy
         vX2bu2dfheiQ1Y7jfYkNbnp08WFWGXzWDrijCAU8ZK2neE8ilIIQ7fFDBcpcoTFpfTzg
         so8qbCau2wxK0Lg3SPKxyi/ywoSq5tOmi5U2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uqI55ErVc07HSIivOX7AXS9kfYIm1rBhZwSqgaXUh40=;
        b=JbG3nKRxyjgOooTaUDydvtDPH+zbZ0QG1VZHG6CJaXk9R9523HdzY463PWMBmHo+3D
         ps4U54Ji9wVWVTy5EwK7GWbJDcZq2de9RfiUizjBDudhEY4v3qPRSMSpli9Ju1sbV54d
         FCZECNvhZbFHsZ72MZXwLQsyMFZbZ5iIvP31IrGnFt2ZH9YNh/YlVl4oO/qiVB/U2maY
         e4EWtrJtWMXakbYRNTHl1C57vxlJe/9gKHtkx0rXQZdOz/rBaapSmrGmlZZ3YtsNuFfy
         BUrDpTSI7yXuGjGYR9ou7h34ue1X65m+W37tbL3i6Ot0WjgpI2kz491nHraElA/zFUfk
         Ddlg==
X-Gm-Message-State: AOAM531enHGrPQu3v3ccMtlYXtzcrIINhsKqSc3MM2BHTqGA8BGXB9GP
        Q3wadsYjcM7iJDPAZgF8xXxWIw==
X-Google-Smtp-Source: ABdhPJxGFBkk0/mTq0YRR9HHsIxQAOOFxD2SkOe81uKOGO5XMMxqU0A+LvckNQefcbuJLeKgkpBRYg==
X-Received: by 2002:a17:906:1492:b0:70e:294c:c37e with SMTP id x18-20020a170906149200b0070e294cc37emr12007185ejc.574.1654448231288;
        Sun, 05 Jun 2022 09:57:11 -0700 (PDT)
Received: from localhost.localdomain (mob-83-225-9-201.net.vodafone.it. [83.225.9.201])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b0070e3f58ed5csm3260761ejp.48.2022.06.05.09.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 09:57:10 -0700 (PDT)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 2/3] clk: bd718x7: Enable the possibility to mark the clock as critical
Date:   Sun,  5 Jun 2022 18:57:02 +0200
Message-Id: <20220605165703.1565234-3-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220605165703.1565234-1-michael@amarulasolutions.com>
References: <20220605165703.1565234-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the clock is used to generate the osc_32k, we need to mark
as critical. clock-critical has no binding description at the moment
but it's defined in linux kernel

bd71847: pmic@4b {
...
	rohm,reset-snvs-powered;

	#clock-cells = <0>;
	clock-critical = <1>;
	clocks = <&osc_32k 0>;
	clock-output-names = "clk-32k-out";
...
}

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
 drivers/clk/clk-bd718x7.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
index 04cc0beb67df..5088379ec2b7 100644
--- a/drivers/clk/clk-bd718x7.c
+++ b/drivers/clk/clk-bd718x7.c
@@ -83,6 +83,7 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 	const char *parent_clk;
 	struct device *dev = &pdev->dev;
 	struct device *parent = pdev->dev.parent;
+	unsigned long flags;
 	struct clk_init_data init = {
 		.name = "bd718xx-32k-out",
 		.ops = &bd71837_clk_ops,
@@ -100,6 +101,9 @@ static int bd71837_clk_probe(struct platform_device *pdev)
 
 	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
 
+	of_clk_detect_critical(dev->of_node, 0, &flags);
+	init.flags = flags;
+
 	init.parent_names = &parent_clk;
 	if (!parent_clk) {
 		dev_err(dev, "No parent clk found\n");
-- 
2.25.1


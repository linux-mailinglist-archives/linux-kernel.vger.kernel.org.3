Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558BB4FB939
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiDKKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345192AbiDKKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:16:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B13D15A3E;
        Mon, 11 Apr 2022 03:14:23 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i20so9135244wrb.13;
        Mon, 11 Apr 2022 03:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyBB/Xj3enrJji4q8ldrhQ7YvWPei4kEZRP/O9pYwzk=;
        b=mbr9aqRZ5bzJ9j2PgE8Xj+D9T/7K4bQ/jR9gAnh6Xs6AuyThMdOGBZHFf4sFV87qX8
         g7GXlztvfjO+OQeBoTJ424CgutocIFWHX/HPq67JS3mQ0f4PORvJ7ILT4z9zuzVPzVkh
         2y8Unupg0jnRWB6jPnTZZ//bT7hVElz/FPjB3ziwJhadRO328FLZ3wVvQhFsYPHyOvaT
         bp3drfquwnBgLhIk14soPzWaKxpTwWI5DsinRqeuJLVrNHN7cRoYuFJcN5t6sMg1/Mmb
         FQ7GU5NSI5rMHx4A3HVKE21bJwHqqDZ+FdwzEdtEVBzKTMbiCnQmV4i2722H3qjPqC1K
         fk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyBB/Xj3enrJji4q8ldrhQ7YvWPei4kEZRP/O9pYwzk=;
        b=mq7XsVIkIzWR4eBwCOFPWb6yJMPcHZKVkhCcINNdKJ2PuaWr/7mGrJJD0+WuEDXdd7
         +dK9ICsJMpyO6XoH9TqaO1vUitUHMfjV2us7E8UYAF1/d44p59RShvxiV1E6+n1V8m5L
         YvZY0ELy7eUdrQ2Rb69voG+Z+JWfDdAU2bJmrahIhVzgwiLHGyQjntj0wyPvFhaAVfVK
         2Ae+SKyQpdL+9noPwIC7/Er3UoyYV2nML8MQJoQpyHXDSlALCnLU2RGY52YLR73mSmZJ
         7L8Z76DqXs0jvR4/4lH2/uPct/bT2ePo+ULAILEJhCTIAhZptqOg/o/9tsifLJZ/fN1Z
         OEuw==
X-Gm-Message-State: AOAM533hPl4cRKbuxP9K7LHMClTWE97N2ah2Igoy15yd0YlCbPtb/Zpo
        g+xlvbFmMyO6rXDJct/s17U=
X-Google-Smtp-Source: ABdhPJx+Ei6S/56jT1hFmrSWUx9/eUny5uuJpcLdHYWtZI1+mBb25ide2DZRM67n7urcJAHmZLUgXA==
X-Received: by 2002:adf:d1c6:0:b0:205:dbfb:7892 with SMTP id b6-20020adfd1c6000000b00205dbfb7892mr24423661wrd.193.1649672061630;
        Mon, 11 Apr 2022 03:14:21 -0700 (PDT)
Received: from localhost (92.40.202.18.threembb.co.uk. [92.40.202.18])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0038ceb0b21b4sm20526369wmq.24.2022.04.11.03.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:14:21 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, paulburton@kernel.org,
        tsbogend@alpha.franken.de, mturquette@baylibre.com,
        sboyd@kernel.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [RESEND PATCH 2/3] clk: ingenic: Mark critical clocks in Ingenic SoCs
Date:   Mon, 11 Apr 2022 11:14:40 +0100
Message-Id: <20220411101441.17020-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
References: <20220411101441.17020-1-aidanmacdonald.0x0@gmail.com>
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

Consider the CPU, L2 cache, and memory as critical to ensure they
are not disabled.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/jz4725b-cgu.c | 2 ++
 drivers/clk/ingenic/jz4740-cgu.c  | 2 ++
 drivers/clk/ingenic/jz4760-cgu.c  | 2 ++
 drivers/clk/ingenic/jz4770-cgu.c  | 1 +
 drivers/clk/ingenic/jz4780-cgu.c  | 3 +++
 drivers/clk/ingenic/x1000-cgu.c   | 3 +++
 drivers/clk/ingenic/x1830-cgu.c   | 3 +++
 7 files changed, 16 insertions(+)

diff --git a/drivers/clk/ingenic/jz4725b-cgu.c b/drivers/clk/ingenic/jz4725b-cgu.c
index 15d61793f53b..c209a170be5d 100644
--- a/drivers/clk/ingenic/jz4725b-cgu.c
+++ b/drivers/clk/ingenic/jz4725b-cgu.c
@@ -87,6 +87,7 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -114,6 +115,7 @@ static const struct ingenic_cgu_clk_info jz4725b_cgu_clocks[] = {
 
 	[JZ4725B_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index 43ffb62c42bb..2b6f7a9fcea8 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -102,6 +102,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -129,6 +130,7 @@ static const struct ingenic_cgu_clk_info jz4740_cgu_clocks[] = {
 
 	[JZ4740_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4760-cgu.c b/drivers/clk/ingenic/jz4760-cgu.c
index 8fdd383560fb..7920df2cee1a 100644
--- a/drivers/clk/ingenic/jz4760-cgu.c
+++ b/drivers/clk/ingenic/jz4760-cgu.c
@@ -143,6 +143,7 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 
 	[JZ4760_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
@@ -175,6 +176,7 @@ static const struct ingenic_cgu_clk_info jz4760_cgu_clocks[] = {
 	},
 	[JZ4760_CLK_MCLK] = {
 		"mclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4760_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index 7ef91257630e..02b266c2a537 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -149,6 +149,7 @@ static const struct ingenic_cgu_clk_info jz4770_cgu_clocks[] = {
 
 	[JZ4770_CLK_CCLK] = {
 		"cclk", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = {
 			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1, 0,
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index e357c228e0f1..014674486038 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -341,12 +341,14 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 0, 1, 4, 22, -1, -1 },
 	},
 
 	[JZ4780_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CLOCKCONTROL, 4, 1, 4, -1, -1, -1 },
 	},
@@ -380,6 +382,7 @@ static const struct ingenic_cgu_clk_info jz4780_cgu_clocks[] = {
 
 	[JZ4780_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 3c4d5a77ccbd..1bd421cc2ab3 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -251,6 +251,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR, 30 },
@@ -258,6 +259,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -290,6 +292,7 @@ static const struct ingenic_cgu_clk_info x1000_cgu_clocks[] = {
 
 	[X1000_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1000_CLK_SCLKA, X1000_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
index e01ec2dc7a1a..b08e318aa095 100644
--- a/drivers/clk/ingenic/x1830-cgu.c
+++ b/drivers/clk/ingenic/x1830-cgu.c
@@ -225,6 +225,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_CPU] = {
 		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
 		.gate = { CGU_REG_CLKGR1, 15 },
@@ -232,6 +233,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_L2CACHE] = {
 		"l2cache", CGU_CLK_DIV,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
 		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
 	},
@@ -264,6 +266,7 @@ static const struct ingenic_cgu_clk_info x1830_cgu_clocks[] = {
 
 	[X1830_CLK_DDR] = {
 		"ddr", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
+		.flags = CLK_IS_CRITICAL,
 		.parents = { -1, X1830_CLK_SCLKA, X1830_CLK_MPLL, -1 },
 		.mux = { CGU_REG_DDRCDR, 30, 2 },
 		.div = { CGU_REG_DDRCDR, 0, 1, 4, 29, 28, 27 },
-- 
2.35.1


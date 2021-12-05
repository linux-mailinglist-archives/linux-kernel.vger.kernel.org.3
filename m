Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99C468DA7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbhLEWQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbhLEWQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:16:07 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93BC061A83;
        Sun,  5 Dec 2021 14:12:40 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so35125252eda.11;
        Sun, 05 Dec 2021 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+r7EpSf0pNjaFfwn/B6Z6VZcY67N7qFWlJqGB4TVQpg=;
        b=ndEE0t9j/X4123F1nKdySvSAZxLMbfvnWTYbmXSLqDqDEy6iN7uBpWLWoA9UrL/ERe
         i0HbpmT7x0zkN48w5tUSxfRjGlRq4V0B9U5AnWXgnfdSdYKgShFk/Ber8zBP7OwhwSlA
         lgZ2EiQLG+lusgvsqkczttlE9qol5NIl17vU9D5KheRHDpeMl4oLQv57OQvaVFi+9xTs
         qnbTyEZbPEmB9FEpeAus1HGhtqtpXk27ZsDtzVm+z34eJc6U4QGUaEzb8BArEml75miq
         q8vqCxOkAYAZZDLTzLWgkPu2ZPvEPrKvSNZNXZgY9JDwXmTZj8S4PLF0vydLCfduMhEe
         TjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+r7EpSf0pNjaFfwn/B6Z6VZcY67N7qFWlJqGB4TVQpg=;
        b=ijBTsJGQJeS2m1n6H3oYsp76V7pMWyRaIOZrGkBa2oPiQYSPmkeMg8pvaZRz76qocB
         UFvZv0/f463AJP7LNqwC9mPLN7sOWj/HDTFElgrfn+3XYPG69gd2civB/PrsD61J5TY5
         xtD7w23Z6tn6s46TBjU6hKop7aC4tuo0NX8K/nKZOJRepPzK0M/ZZYzS5KwcgD5/gA95
         BQQj35b+Eafd0jtgkDsoN96tCvMQ9KJkzZXfYw+Pjb5379bi9LwToTWJzXESDO3z6aN+
         2OcZScRP2fH4KceraXY3idzvQjwh85ptyogk8P8KOR6o5w9B6yJpdDQY2y1hmstuMZGf
         Ao9g==
X-Gm-Message-State: AOAM5334+6iHKhfx4rmQwzeC2YnmUiepJsSQ6BXw18jZbRAVtzoN0sIN
        i4c6P78X+a3xLgnn/675sPU=
X-Google-Smtp-Source: ABdhPJx1nlJbnIlldzFEKek+YQhxuDleKpJS6ar/peC++lafWljc8gyJBmhqwmIp890DsKDhqor9mQ==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr50436037edd.198.1638742358652;
        Sun, 05 Dec 2021 14:12:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id gb18sm5608079ejc.95.2021.12.05.14.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:12:38 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 5/7] clk: samsung: clk-pll: Add support for pll1417x
Date:   Sun,  5 Dec 2021 23:11:04 +0100
Message-Id: <20211205221108.193400-6-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205221108.193400-1-virag.david003@gmail.com>
References: <20211205221108.193400-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pll1417x is used in Exynos7885 SoC for top-level integer PLLs.
It is similar enough to pll0822x that practically the same code can
handle both. The difference that's to be noted is that when defining a
pl1417x PLL, the "con" parameter of the PLL macro should be set to the
CON1 register instead of CON3, like this:

    PLL(pll_1417x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
        PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
        NULL),

Signed-off-by: David Virag <virag.david003@gmail.com>
---
Changes in v2:
  - Nothing

 drivers/clk/samsung/clk-pll.c | 1 +
 drivers/clk/samsung/clk-pll.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 83d1b03647db..70cdc87f714e 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1476,6 +1476,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 		else
 			init.ops = &samsung_pll35xx_clk_ops;
 		break;
+	case pll_1417x:
 	case pll_0822x:
 		pll->enable_offs = PLL0822X_ENABLE_SHIFT;
 		pll->lock_offs = PLL0822X_LOCK_STAT_SHIFT;
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index a739f2b7ae80..c83a20195f6d 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -32,6 +32,7 @@ enum samsung_pll_type {
 	pll_2550xx,
 	pll_2650x,
 	pll_2650xx,
+	pll_1417x,
 	pll_1450x,
 	pll_1451x,
 	pll_1452x,
-- 
2.34.1


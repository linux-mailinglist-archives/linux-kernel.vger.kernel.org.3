Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DD5468BCE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbhLEPiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhLEPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:38:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962EC061714;
        Sun,  5 Dec 2021 07:34:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so32446258eda.12;
        Sun, 05 Dec 2021 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s227VvqQvuXMNpaXSWhEVtyVrvC2WZcc4qC7RY9r+kQ=;
        b=e3SxhDXcdh0WMsWuz3x6ra7OWxy4fIeiM8EXCIJzNdqQQqNCQmsiBzIZiuLepWhhRx
         /qWbiw8iEgWrR4secUUMOmwSKVpQfYLaY7RvVKGBApNAqGkYcntr81IgwQym4lFVwjdS
         5ZilAPm0w8eUgO7j5DopLtycKEocpU6zR1rpwAqVmRCSJQXN81OkxGq/BqIfLc9qRZAy
         olM6Izcvbd0O5Ft3YcCOCkW2qWQ3AUH9TbR6tC2WNhiaV0iTRTRvoPJVcPvuxcz/CMSQ
         p8cvbtQb1mcRN98Qu6CQPRvr1sNMtkVkes1H87S0GIfw1wQjMO11w+argJqrSLFb2p3G
         1ioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s227VvqQvuXMNpaXSWhEVtyVrvC2WZcc4qC7RY9r+kQ=;
        b=Gu4gzRfZTKDhOUlHuJ8YdON7wAUVFs9AEDGQg+depfl71GY/X78cV1vD6SQH+6r5Vo
         SsEtYRo9zrvxnNVpDGzqpncK/2HL5dQoWEUxdgX6MeRrj/QKnOecCJ+vr3gIGuP0sxSd
         jrXfLq5e+tz4eAQOewonky2MfYtTWsXcVj3ES2ptGATa9FzyXajFu4lRk8llE+N+6N6P
         MvJ9YGdSEGaofyCeI9PeQV+hdAGuNnBfdpala7O5nTrPk4kuRhqNzbCXpTzIU56N9v7t
         E185rsgNlGaPJCpVcf3rp4syxQzzAcmrZOdo/31m6u4Nzl44qXj47aXbp8RdbFYIkUwE
         ZAVQ==
X-Gm-Message-State: AOAM5317GXC+tLnss6gzd1XpmUUd2P393xdCa/74QDEPXqHy0LpPZOjP
        hW558rwhhJWE6PG2zmiFhWU=
X-Google-Smtp-Source: ABdhPJxmFfQTAJiwLFNDFIvkr5vW1vmAu3zIgay1PRlcAhxfwWSYDEis9twNlltlpKht5mW2gV8tAQ==
X-Received: by 2002:a05:6402:4382:: with SMTP id o2mr44801294edc.143.1638718482028;
        Sun, 05 Dec 2021 07:34:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id sa17sm5529941ejc.123.2021.12.05.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:34:41 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
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
Subject: [PATCH 1/6] clk: samsung: clk-pll: Add support for pll1417x
Date:   Sun,  5 Dec 2021 16:32:55 +0100
Message-Id: <20211205153302.76418-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205153302.76418-1-virag.david003@gmail.com>
References: <20211205153302.76418-1-virag.david003@gmail.com>
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B4468DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241012AbhLEXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbhLEXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:12:49 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572C9C061354;
        Sun,  5 Dec 2021 15:09:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so35755626edv.1;
        Sun, 05 Dec 2021 15:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NdLcz1sAGqK2YXbDQMZKZG5FkxVRmQplbp1+qsq1n6M=;
        b=INbjuhk1vT6qzOViEKd++AfLBJJJiRX8ioBWqgIDfB7/i2cN9wMqTc5H5YC0wpXdjJ
         Il12EoYRctnd+JG9h+C713WZufZsWGfwRB6SGUKf2gnDYBqlsb2sxhcxYJxQTjpvxGtm
         ZVdYgtrGIois+WJRDUTVI7O+7/WT0ZQrHFN/SyrB/ukccb+LQrv5olPLm/eFvgGB2xN0
         3uRyLZSq7+X/k3OgueU91rQsTzF88ePkYX7MxJtSBMBlYNdj84q3JrWCvh8SqmQmj+4g
         ewIEKV+rfY9W+IBMTkw2NV9i+Le6ldMLiwe/GGgKTvp96fzpWiLu4T3sOAzL8vawFHqD
         8OLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NdLcz1sAGqK2YXbDQMZKZG5FkxVRmQplbp1+qsq1n6M=;
        b=DfFdZUsVJBSuTcXpE1byqyNFMvEXxD/lORtcz7UPG2G3HqF85GM8pVxLyA1IZpRjpU
         OzddqF43u8tLTOy6PUhm3XcAWio0qU5wbn8zmXWvvaNW3jK+ZN90vJoLe+9ISzAOqgRZ
         YeBAFOyBLs2hp8C0Wx1/y2tB7N9NZ/3CEPxLAKW6C9n7z8GAc6f9Z68wE8oCO2onI2OL
         qb+T3njxy7O6ZYv2OS+NmV9YhQE5CAYVfrgKDwB6SO/A9AsFGd6W13LgGIehQrR3D76H
         N0RlP9gK49TTSlZNjM1NXC1C68uXLrRkIUMzAbEOU3neaUeHA2/xr59PuxY6fGOehTr6
         gbAg==
X-Gm-Message-State: AOAM5311niEPDmPrD+9n+wwvT/W81vIdFrB0vTJJf9n4xPK0gEx+CMI5
        6Q+flKHRA5nUkmnwz3MzUpM=
X-Google-Smtp-Source: ABdhPJwtzRQS5NVo8sQ3cJ9Z6wUWXF+k/spuS1f3sR/py28D07+kEoYZ1EM+0dRDg34VyXF/kBsY4g==
X-Received: by 2002:a17:906:fcc8:: with SMTP id qx8mr40616285ejb.370.1638745760005;
        Sun, 05 Dec 2021 15:09:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id co10sm6686569edb.83.2021.12.05.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:09:19 -0800 (PST)
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
Subject: [PATCH v3 5/7] clk: samsung: clk-pll: Add support for pll1417x
Date:   Mon,  6 Dec 2021 00:07:59 +0100
Message-Id: <20211205230804.202292-6-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205230804.202292-1-virag.david003@gmail.com>
References: <20211205230804.202292-1-virag.david003@gmail.com>
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

Changes in v3:
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


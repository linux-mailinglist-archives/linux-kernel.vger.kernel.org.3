Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393946A060
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443842AbhLFQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390806AbhLFPmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:51 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BD5C08ED35;
        Mon,  6 Dec 2021 07:32:41 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l25so44391381eda.11;
        Mon, 06 Dec 2021 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgC4TMcfmLrJP/yb6/KvI+5qK1sc/7oD0RhyaOBjmB0=;
        b=cYh/7CPda6Mkod1VoX6HF0g3CQQR6DODP7ou+ibBOd0FcD/9g7MPhRT4+k888QWuwp
         y+t4CMXHxIOiQlhl+pRrJ8uy8zqXofvHUrenxdRV+8LNQvue/qOugyc9CLng5GbPQVcx
         n+6aiC0sMr27RjwArSDV7MYH7tLsL66d+do+jZEfpRBeGci2v8uX/w37zQxiaEm+Vleb
         fDY9i+/UqpbMlmPScG6nUK0XKrrhKZQp7O0fVvLzXTuqIKqaZOaD9soFiCBac80MMdrr
         MW7/AHmseZAgRZDFnoITD/fBj0G96I+tr+VcoSQLFtJ/Zbb7PT67m3Y3yTLc1iMFrHba
         1Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgC4TMcfmLrJP/yb6/KvI+5qK1sc/7oD0RhyaOBjmB0=;
        b=7twXJoAJhNkiBf0Udg1bQWcuNRowArzx5O7KeHp/vm93/C+a8kJCD/w7RH227le+QK
         Gq2F7B3/BEyfd9iiuWXlZ/Iwpa32B/A3alStKVz/YDHDffaI4NmvuYsWWJl/nbp8gG4t
         +FWcE8WKZlvfUeh6OM6w5K7xL7KpZa+U8mJMeArnMDC8DjX3sg/fpvehu4mnfCHo9+nn
         Hpl/4sYXkJkURV90EAFdFZVGqFmjSYQj6qu+vePoEj99CHFV3QrDcsb6v5h8KX9Lr91d
         rgZLBtCZrSSmaoikjXT7DrbyHXZY+cNX6Uwf4q07G2Pi+wkqx1VBtgU36h16l++/xUTx
         icOw==
X-Gm-Message-State: AOAM5321ZSsGI+bJDz0T6ysoxxarAamPQ2y9qluqgNGMxd1N/DzmQKkT
        8AxFst6trpYIPCG1uRgbL1g=
X-Google-Smtp-Source: ABdhPJw6LCeQjYIhwJ5ApOgw0Lrb9jfgl0R6gWBzhG7gNC3cfdjFD8/g0jkKoYmBGdBL4R6S8gIjhw==
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr57708325edw.318.1638804759696;
        Mon, 06 Dec 2021 07:32:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id d19sm7364688edt.34.2021.12.06.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:32:39 -0800 (PST)
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
Subject: [PATCH v4 5/7] clk: samsung: clk-pll: Add support for pll1417x
Date:   Mon,  6 Dec 2021 16:31:19 +0100
Message-Id: <20211206153124.427102-6-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206153124.427102-1-virag.david003@gmail.com>
References: <20211206153124.427102-1-virag.david003@gmail.com>
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: David Virag <virag.david003@gmail.com>
---
Changes in v2:
  - Nothing

Changes in v3:
  - Nothing

Changes in v4:
  - Added R-b tag by Krzysztof Kozlowski

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


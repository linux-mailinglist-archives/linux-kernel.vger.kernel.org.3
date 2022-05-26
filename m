Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB99534997
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbiEZD7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345052AbiEZD6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:58:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29456C0383;
        Wed, 25 May 2022 20:58:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id j28so326155eda.13;
        Wed, 25 May 2022 20:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sGUo79V8IknEK9RaV+1rr5dfMkYi9KkvLOC/DC9705Q=;
        b=frTBXxzAzNw1OrGvbM+DJnEXiDhK6abfNuqcoFf6RXZBuVulVhnBMrxirE8v1dy1HN
         BT54dySSl0TSLpwqmsYoREhIDyA1y4nCE9JaGmr+hlPTZ/sjObzSkuqb6T0aQpZJ8ZQF
         r32y6L3rwSG09BLDG1lBr7eGDcS6HfNnvw8tB6Gd/G79mNU2qS3gg79xdNc+hNoHL1MD
         vG1s4xJjiZ9uiTkIZ96BtkUglGcW+lIb5zAAbqo7F3L+P8srUY6aZ6Vmk3HE7jlv/h2U
         hp6EuGYhY3nsR+gaAO30kja7je4iKTtwRHJ8q/fDTzASaiz4ZZVE1g9WQb0EWIyjYr5d
         Jp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGUo79V8IknEK9RaV+1rr5dfMkYi9KkvLOC/DC9705Q=;
        b=uqwQM297z6LhN8HS8bPI4gCSx1Tsq1tUfSzMMk2NPTIBeZD+PZEYoxuamZyHfVRpoV
         U0/IMtOrM8ZjWJBOXWvJlR47YrzemTorWflTvEFGQ3qeN+LB3dHg/tv5ZEUvbSQ7cl2X
         uDO+9lfMwmJLSZ+Kl6WjoOy32GHpGxP8cLEIFghMre4ZabBD07MD8DoP5PunD5Y5748Y
         w615a5mChkTZPc6Pwtti6SZy7nvEln6Bhs8phuTgPt7Oxzrr3HcPg4oU54RcsEFFy1F5
         ocfvkOBLXV1zcVsr0MqmLoKXXqkXp+8SUucl+uNUWGM0TUdS+K0Vd1irtXpJl3BVn0V+
         yZwg==
X-Gm-Message-State: AOAM533+PEZHZonT5bODulHBN9inATzr0/ORTFJyzdYFvNEL5V+JBJ5+
        YJlsTaNFXK2ZAEBZcytik94=
X-Google-Smtp-Source: ABdhPJxUZkM4WISJm+sH+Os5S6DUAvBQ42HeFS0U92PtCs501xBQl3VhzcIgSaVFAEXnXvQHCp99HQ==
X-Received: by 2002:a50:d7d7:0:b0:42b:d06c:33a with SMTP id m23-20020a50d7d7000000b0042bd06c033amr4235315edj.363.1653537528675;
        Wed, 25 May 2022 20:58:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id c13-20020a50d64d000000b0042617ba63cfsm206621edj.89.2022.05.25.20.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 20:58:48 -0700 (PDT)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: samsung: exynos7885: Correct "div4" clock parents
Date:   Thu, 26 May 2022 07:58:39 +0200
Message-Id: <20220526055840.45209-2-virag.david003@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526055840.45209-1-virag.david003@gmail.com>
References: <20220526055840.45209-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"div4" DIVs which divide PLLs by 4 are actually dividing "div2" DIVs by
2 to achieve a by 4 division, thus their parents are the respective
"div2" DIVs. These DIVs were mistakenly set to have the PLLs as parents.
This leads to the kernel thinking "div4"s and everything under them run
at 2x the clock speed. Fix this.

Fixes: 45bd8166a1d8 ("clk: samsung: Add initial Exynos7885 clock driver")
Signed-off-by: David Virag <virag.david003@gmail.com>
---
 drivers/clk/samsung/clk-exynos7885.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos7885.c b/drivers/clk/samsung/clk-exynos7885.c
index a7b106302706..368c50badd15 100644
--- a/drivers/clk/samsung/clk-exynos7885.c
+++ b/drivers/clk/samsung/clk-exynos7885.c
@@ -182,7 +182,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	    CLK_CON_DIV_PLL_SHARED0_DIV2, 0, 1),
 	DIV(CLK_DOUT_SHARED0_DIV3, "dout_shared0_div3", "fout_shared0_pll",
 	    CLK_CON_DIV_PLL_SHARED0_DIV3, 0, 2),
-	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "fout_shared0_pll",
+	DIV(CLK_DOUT_SHARED0_DIV4, "dout_shared0_div4", "dout_shared0_div2",
 	    CLK_CON_DIV_PLL_SHARED0_DIV4, 0, 1),
 	DIV(CLK_DOUT_SHARED0_DIV5, "dout_shared0_div5", "fout_shared0_pll",
 	    CLK_CON_DIV_PLL_SHARED0_DIV5, 0, 3),
@@ -190,7 +190,7 @@ static const struct samsung_div_clock top_div_clks[] __initconst = {
 	    CLK_CON_DIV_PLL_SHARED1_DIV2, 0, 1),
 	DIV(CLK_DOUT_SHARED1_DIV3, "dout_shared1_div3", "fout_shared1_pll",
 	    CLK_CON_DIV_PLL_SHARED1_DIV3, 0, 2),
-	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "fout_shared1_pll",
+	DIV(CLK_DOUT_SHARED1_DIV4, "dout_shared1_div4", "dout_shared1_div2",
 	    CLK_CON_DIV_PLL_SHARED1_DIV4, 0, 1),
 
 	/* CORE */
-- 
2.35.1


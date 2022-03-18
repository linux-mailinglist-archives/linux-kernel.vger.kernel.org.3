Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC354DDDED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbiCRQKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiCRQJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E918D4AE34;
        Fri, 18 Mar 2022 09:08:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w4so10797525edc.7;
        Fri, 18 Mar 2022 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=Wen3GLrBPeCotIbEPWJodN1XTTyhTbJEexnWKAy7jaeGjMMJOZd6AlFY9j8UraoAHr
         ASkXZotE44o0Cr9yPNsXYUQOGCtw42G0GUgdDgqxL6GYQTGngDOK2e3tBYdU1ZnJSlqm
         DuLRdGiZVFWY8SQdlEJ/Fb8FvFukes6RpcqQ1BlLaH/oGQEgrl9bSWa5G2JrA7VfgXKE
         rslHwvz9+kM2IfxqnfjOA5QlUViwb7MV2KqpNDG/epAZEu9/LGh8nza3donxeurTffrp
         p+gYmaiYgB0CmJqRxglI6qnwQ32I1Q19U9/taI+FrzlPjm4jcwbTrFRLVaKnekLM2aQI
         Cavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h0dp/sRCWnE/SzxqBhwWtp3OCJwunZ7486W2HMfBko=;
        b=3qP6h4hnqgSLArD/8LZsV3gLy8sKq6MVxE4vWmyxKNX0xZelsHHzfhyesTw5LxL+Yz
         qMX6SrWCjWY6UlV924TxjTuqRS1UlY9T3oY5pf4VglZTUCh299GfHzMgc9zf6rRzGrO7
         8ZzfHsUEltsPjxTxwQUv6/uGR8V7NxwpPx2AtJ2CC1nI7Cf1Eqe9akWiJciAwdtws4cT
         RvrHJv1zL6GhNY/6LJ2NBUkDyKd00WvCr0o2u0HChgFsGKaBFK2D1osFCIMH0bBHbbCM
         /uo/NVPvJAKhGUYjlfS/pqXdVzLZkwW60m2LOs9J8GXKGAnbUt63vff0S5oCI/uYycu+
         YDkg==
X-Gm-Message-State: AOAM532KIDINqKa1J2Diyx7vtRq/0MtNhJaNJzSbpjj0QBjC9hCnd3Eu
        v2CuC8DrYaic7s6LOp04je+9yo4YKrE=
X-Google-Smtp-Source: ABdhPJx7trjKAv2zwSvRNB00Gs8Z5nESlKG2+jmEeDulGrr6zLYqKg+gaNtuw/+6TNxoPV6XWYoqPQ==
X-Received: by 2002:a05:6402:27ce:b0:416:aff4:86c1 with SMTP id c14-20020a05640227ce00b00416aff486c1mr10000463ede.339.1647619713359;
        Fri, 18 Mar 2022 09:08:33 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:33 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 04/16] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Fri, 18 Mar 2022 17:08:15 +0100
Message-Id: <20220318160827.8860-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_read_poll_timeout macro instead of do-while structure.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..a4e347eb4d4d 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -12,6 +12,8 @@
 #include "clk-regmap.h"
 #include "clk-hfpll.h"
 
+#define HFPLL_BUSY_WAIT_TIMEOUT	100
+
 #define PLL_OUTCTRL	BIT(0)
 #define PLL_BYPASSNL	BIT(1)
 #define PLL_RESET_N	BIT(2)
@@ -72,13 +74,12 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), USEC_PER_MSEC * 2,
+					 HFPLL_BUSY_WAIT_TIMEOUT * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755C581512
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239321AbiGZOYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239256AbiGZOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:23:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8A528E2E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so11463725wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fHR/l5JjlFTe5U+9TeLfCPWi7acg+LGM6AX/fISUQlA=;
        b=JxggSDwyUfxpBz8xwSy/CRdus25ymovTe92jJ8H+Ic+mUr7eTFMfPc6FyrFDW+0leg
         d/ZLVB75hhUK15+1ejVt/xbaixbVE6QdwYGe5SqoZ/2OLdONBot+jcXGwd08fS7jEHCV
         ro8JiUDcW9URuOEzOigDVFvaNs18GhapOxkx5rWjQQ4CHqGsZxLRw12FGfCl+Lsb8ynZ
         2fX9j8eeJmwJIBU9SlqsmMSWRTv7+VyeCxjhdMu4B/N+lvEWrIg1YDR9v92Nzar1PtCC
         BPteo6eCco5lwHmaqGrMzT1I9dQ9VV6YkuOnUoVvxgSes8kgaZTPw7UkTA/LcLTUQi+J
         M6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fHR/l5JjlFTe5U+9TeLfCPWi7acg+LGM6AX/fISUQlA=;
        b=SQ6FS93O0CfNsDiqRYMLn/rjP8CiZh2utQjVYuVrHI2GQ0rqvWASgw9M+0AS3OElTl
         gXpj9sPLfs+r3lOIVAtTpQsc/yMpOoUJjAjNsnRF4HkVuCNF94rvsRER8eY+NHEsG+qI
         GEiKT5hLINcxSkQW7d1vfNvXEnvkFKuz/bYfWQXjUDwu4S3F8oqvwztdlyR8sp4iIrHN
         qFAEepouka2vd0Kd6eoXKtWG+P01hVrIICYXqTLgaKntyXoU13dnkDGfRwzWmtWuj24N
         YnGQAUHsUigLwqEAnLE/Gf9smWLZVYN6cJmjcNc5jGH7VeY0GBilWpN6JAG1o5mpk68i
         qipw==
X-Gm-Message-State: AJIora/Gx7m21T8it1dnNhRev/VIMOmKilqmfrwHAfQ4xtgWlLhxKatm
        5XL5mYbkyZdjbqkbpJkCtMwveg==
X-Google-Smtp-Source: AGRyM1vM5xsph9+g+W1imOstU4XWX/lRpFrpsheUulR6X4yJLXPfUS/p9F4UwOUrJED37w/8hstyeQ==
X-Received: by 2002:a05:600c:1911:b0:3a3:2933:a1cf with SMTP id j17-20020a05600c191100b003a32933a1cfmr12693921wmq.118.1658845430513;
        Tue, 26 Jul 2022 07:23:50 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id t21-20020a1c7715000000b003a331c6bffdsm17017119wmi.47.2022.07.26.07.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 07:23:49 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC 6/9] clk: qcom: common: Add macro wrapper for all clock types
Date:   Tue, 26 Jul 2022 17:23:00 +0300
Message-Id: <20220726142303.4126434-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726142303.4126434-1-abel.vesa@linaro.org>
References: <20220726142303.4126434-1-abel.vesa@linaro.org>
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

Add a generic macro that uses the clk_type to figure out which
clock type specific macro to call.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/qcom/common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
index 9c8f7b798d9f..475febd19dba 100644
--- a/drivers/clk/qcom/common.h
+++ b/drivers/clk/qcom/common.h
@@ -19,6 +19,9 @@ struct clk_hw;
 #define PLL_VOTE_FSM_ENA	BIT(20)
 #define PLL_VOTE_FSM_RESET	BIT(21)
 
+#define DEFINE_QCOM_CC_CLK(clk_type, ...)	\
+	DEFINE_QCOM_CC_CLK_##clk_type(__VA_ARGS__)
+
 struct qcom_cc_desc {
 	const struct regmap_config *config;
 	struct clk_regmap **clks;
-- 
2.34.3


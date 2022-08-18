Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896D8599020
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344072AbiHRWG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbiHRWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB956D25E6;
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so3526107edc.11;
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ua4G1zirXRRHrwuTv4PR9g1sFu4rKsD/OWAdeD6VB6g=;
        b=Fqt73Un6KjBRBR0cDWIAe3ejsKnL1rkkc4IrO96YkhqG/YOHJFGCT5fvac2tmo7lTb
         wriZglilbZit3jkY+aRzvDXEWYieFkAPhCk11znRBTY0bSpb9JZhlWMAvqwr5ddnPIey
         zDD6BZ1QGA4fYEaji/2NLtHXXLd8l10eRhYgiyWNe13vdAbEA4d4qqR4MGda/2BhzE0s
         fsEpMKZJ1S9qpCK+hRWHEJMZ+sQqUhak6SkFfiFRwgfYjaCefz3PfnU7WwBhxcdCq/P5
         s3Zj9FhUdgINYRPI3xtEKLqvmM65KeGgXQNn4AaciK+5Eeo/ADhkwYPKRtBoYF1zn6T0
         HCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ua4G1zirXRRHrwuTv4PR9g1sFu4rKsD/OWAdeD6VB6g=;
        b=kuYMOPB9KgAjAqxtdlGKhPK71gvecPdox6nbvmo12Cj+sIX9rASdqsv1HpHd+PGYxN
         8knMpzhKcp5Y6qcENPjfy8nqAd6f3LyQ6TE3hK+HfK0ezi2nnYQ1soXyJDpESmN34sR3
         qJl/K624VvboVOUulXWEQEnB46ENLA/OpQeaOCCNUOisPe1ANkAV4KaYGerK4BPY83D8
         +TFRo/yp2db+jRXJnK8k8UfoQFoqv+C5z+TVQNIyCty0d5iAF3Eq/B4ko1pziFp3tcRX
         ljW6c9LjG07NX3B6BQX3R0yW6sFf4cZOMQmpEMhJqzGB73lihvQ2tuy53RuC0NDLi3Uf
         v8YQ==
X-Gm-Message-State: ACgBeo0Iac7M+gN8FNULC57Hasq3KWXGEUQlBvTZmqv5tkFgw9REL/mV
        5Ldx659RfRJeMm9qZ+bcexZmAyCdKzc=
X-Google-Smtp-Source: AA6agR7Hr+vVEbXDrPSFnxZqQ6THbPtlgX8i61gGGGM+UE+6B7913v6bPdGrPW6Ezcu6Y2jFiP5AxA==
X-Received: by 2002:a05:6402:3492:b0:43e:9666:ece2 with SMTP id v18-20020a056402349200b0043e9666ece2mr3805305edc.65.1660860396342;
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:36 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 6/9] clk: qcom: apss-ipq-pll: update IPQ6018 Alpha PLL config
Date:   Fri, 19 Aug 2022 00:06:25 +0200
Message-Id: <20220818220628.339366-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the IPQ6018 Alpha PLL config to the latest one from the downstream
5.4 kernel[1].

This one should match the production SoC-s.

Tested on IPQ6018 CP01-C1 reference board.

[1] https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.1.r4/drivers/clk/qcom/apss-ipq-pll.c#L41
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq-pll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index ba77749b16c4..a4016f3854c2 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -39,10 +39,14 @@ static struct clk_alpha_pll ipq_pll = {
 
 static const struct alpha_pll_config ipq6018_pll_config = {
 	.l = 0x37,
-	.config_ctl_val = 0x04141200,
-	.config_ctl_hi_val = 0x0,
+	.config_ctl_val = 0x240d4828,
+	.config_ctl_hi_val = 0x6,
 	.early_output_mask = BIT(3),
+	.aux2_output_mask = BIT(2),
+	.aux_output_mask = BIT(1),
 	.main_output_mask = BIT(0),
+	.test_ctl_val = 0x1c0000C0,
+	.test_ctl_hi_val = 0x4000,
 };
 
 static const struct regmap_config ipq_pll_regmap_config = {
-- 
2.37.2


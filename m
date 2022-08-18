Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB44599024
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241627AbiHRWHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbiHRWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0151D25FF;
        Thu, 18 Aug 2022 15:06:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e13so3506669edj.12;
        Thu, 18 Aug 2022 15:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=cOo4Et7NAlia+d7YoxikfbUbzkauXGD559ac+lhPQD0=;
        b=YnGZV402MKh2rXUJ1vPNqPLdRdGhEraZk61ps8qnwJrWzGIQxo0l41McW7fkfSy9uB
         SO6R1ncNIRUob7FWdOvI3Lqyz7YJd2T9XC2hJ5tf7oTQZHfofxi1QPyd+RYWqRfAyY7T
         5YMIAl05rKbYoM6fs0Xu7FC7b8dB6UO3kbJ6JaMAIpgamkZahbo0O9eegZWfzFXaung2
         MuggSRTdHPtIk9kbTl+A2fEKvzaMjkhHGOKIX+s9l1rXkjb1O0hFOWpgrPyEzvb/NWtN
         VViBlFNTuupdWyCHAodmFKnC2WVcvDXq46jovMnX9S3V5CGBw4osFsHhz7EDW7wkzEOB
         xkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=cOo4Et7NAlia+d7YoxikfbUbzkauXGD559ac+lhPQD0=;
        b=sNbKHk9uCVTmjPbxZksSL3L2CDeAWsWmEzrcjIfEYS+vMlLZ8I4lEMJTCsN+UiphQj
         iw75hfgc7Rdf/lkhS/CeXffo/x0XMLqB3+5CpoWFVHnT3xf0Xx69OFxMpoMb8HjWHLJU
         FqF5cMX9ECPmQqajfLTvd9Rah87TuUwE6eiC6KmRwdpyHLZ1RX86WsuKI6cSKcPIm1MP
         Dfi26RCNtlA+/u9exvrEJsiUxoHiZA6A8kNuJwXW8fyz8Ve9Jvx2/9WyQfEZomuNiSYP
         LH8HiKKQI6MFqyFbvDBDIKaVj7TNiAMrw6dUC0ePhZ3xbRmi/ZLEy8vOF6QPFax8qGQ3
         viBg==
X-Gm-Message-State: ACgBeo1atzrTjOHPyQLu3l2VuawCXpTCFmOut/VnIY0jG3q1i+qT2QZr
        FWF4BluGhP99ldwOxVxEYMo=
X-Google-Smtp-Source: AA6agR6dxYVG3NB2Aw34X8VZnW0zb7a13V4hg4xpPOmkL4eiN4iuZyftHEw75Zon3exGYDKH0FQPuw==
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr3778405edc.228.1660860397482;
        Thu, 18 Aug 2022 15:06:37 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 7/9] clk: qcom: apss-ipq-pll: add support for IPQ8074
Date:   Fri, 19 Aug 2022 00:06:26 +0200
Message-Id: <20220818220628.339366-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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

Add support for IPQ8074 since it uses the same PLL setup, however it uses
slightly different Alpha PLL config.

Alpha PLL config was obtained by dumping PLL registers from a running
device.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Drop hardcoded compatible check for IPQ6018 to do the PLL config and
utilize match data provided by previous commit
* Add IPQ8074 Alpha PLL config using match data
* Update commit description to reflect changes
---
 drivers/clk/qcom/apss-ipq-pll.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index a4016f3854c2..a5aea27eb867 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -49,6 +49,18 @@ static const struct alpha_pll_config ipq6018_pll_config = {
 	.test_ctl_hi_val = 0x4000,
 };
 
+static const struct alpha_pll_config ipq8074_pll_config = {
+	.l = 0x48,
+	.config_ctl_val = 0x200d4828,
+	.config_ctl_hi_val = 0x6,
+	.early_output_mask = BIT(3),
+	.aux2_output_mask = BIT(2),
+	.aux_output_mask = BIT(1),
+	.main_output_mask = BIT(0),
+	.test_ctl_val = 0x1c000000,
+	.test_ctl_hi_val = 0x4000,
+};
+
 static const struct regmap_config ipq_pll_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -89,6 +101,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
+	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
-- 
2.37.2


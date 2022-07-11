Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99979570C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiGKVHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiGKVGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322DD76EAB;
        Mon, 11 Jul 2022 14:06:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eq6so7776191edb.6;
        Mon, 11 Jul 2022 14:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLBfjcLmD6YsbkjIodLWwt28j3M7ElYSLrVTRWGG6T4=;
        b=P4O30aAsE0qULmewnkHhs/ve4U4Oc/1NiXNPJ0EdoJdniA+vFSnPsUXf5BQWw11bEf
         nizX+v3wwbbMNW5qf3v3ADmPyci2GrTEajFpqfhqIslLDRRYZwmcK0e5nRcgrn34fUrZ
         7z0xQzbDWMJ9erpFluUQ72tbvzQHWNW9YAckuBQ0pjBI6Y5QC/IrRY8MJyM3/lvObtyr
         6A3ioa77Urqr5qmEXdqs/TZOZLJTYjE1Sl6N4ZXpTcl4dZgcgGUBSR17tjgJdQdGROXF
         mwXslj+On9YSnMKSFoJatEwpLkccra1SZwzXoNC9zVy6NSdgIF2uZgdWgOsvt2JChYtl
         a3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLBfjcLmD6YsbkjIodLWwt28j3M7ElYSLrVTRWGG6T4=;
        b=QHv9fVJz8IQ6R0UjW622ibeQCan+rXu322kYEc9yodS3gJJoZ9u5NDXi6r1jGQy12O
         8Z+DWIYxlC+m5TIzRFk4Fsoy6KVaIPzvWWxZIXpq8frH7jYzRrffEDJqPWchRlRrUsHM
         o/zGV7trXGGG4L52Hhh7iBBZs5lb2ygDKONCJnn5zkkM6BT2JGKPe/EShie+/Kd4CkYX
         PntM1kdWRxVUqDLeFk9LOODoN63P3BYqnf9tdA8nOC8E+fAi+GIa8amCvh7/PB5Bb4mX
         zYfpjt65bERwK9AU37QVL+6oi1sCWqMUibnaOMrvn9cS3LlWwVE7qxmz6aSJLrMzdN+t
         ynEg==
X-Gm-Message-State: AJIora8eLKYDLb9zseCnF/ArL7deVd1qAEkke+hxzFt+vjthuYqWQDQ1
        4Ayh8EShyME0xTvfuRf+sWE=
X-Google-Smtp-Source: AGRyM1u2WyDYgjKJPz3dB8Wpohf70WV87DHt2v9c88x/RFHihxzbbyPFGOGbBSezs1UcDFmpRAxsqA==
X-Received: by 2002:a05:6402:5cb:b0:434:eb48:754f with SMTP id n11-20020a05640205cb00b00434eb48754fmr27774202edx.421.1657573602805;
        Mon, 11 Jul 2022 14:06:42 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:42 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 6/7] clk: qcom: apss-ipq-pll: update IPQ6018 Alpha PLL config
Date:   Mon, 11 Jul 2022 23:06:33 +0200
Message-Id: <20220711210634.3042092-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711210634.3042092-1-robimarko@gmail.com>
References: <20220711210634.3042092-1-robimarko@gmail.com>
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
2.36.1


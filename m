Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413415B0FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbiIGWkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiIGWj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:39:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED32F66F;
        Wed,  7 Sep 2022 15:39:49 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id i77so12682024ioa.7;
        Wed, 07 Sep 2022 15:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=SmSdW9i3EThjbK8u7yyNrPgrBdo5J6YHi3eeJSF4bF4=;
        b=Sb0f4bCMcavuFPKoOoOGixCqy09dqQveDbEdf1Qj1BdihVTccFVaiz503W+rxCfGMM
         ZYyvUzKLUIWv9lQxtNxAxvBbPelcLl39Za9uql+DDuzjN/HkGVlLizoaI3PT4xq2eQf6
         2EzG1TVLwHlzG82QAzKaDzsVMT3/wH6r0z8WoAaBnQXxTRe1VDnCVDpu7zfTsb0uzlvP
         ilj+WANWrPUpNj9g7Tyj9O2J9E4I1ga66NN8AwwE3EWrmk3PZss//BLsgjwbHr9UQA34
         9XmxRgPGKxH+oLFOantR462wYlO/rYT2EDjaAhqgNHxQwt5+X2teqZ9QJtAQs82qmVdF
         qgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SmSdW9i3EThjbK8u7yyNrPgrBdo5J6YHi3eeJSF4bF4=;
        b=TeDARCFtCljeXPTfSZeQjR3HNMKo31WoeO8jabGWkF0tIbMjQsufDLZYz7HXBvzohP
         DhyCtBqllrvzvW+YyTNfBhL78eWRGQUHFs5v0g0jfVYVCRXsk7F1vO+gVVSg+FuFky4U
         +DUwhXoycCKiIV11osOT9YIbN1lHd+GpNq1v0acLr5606liYUgGoIC30fnquzb4Ldiu/
         5xjWtHlxBYNgE/e31MJICXShY++YzgffPvIeKwJmlZEfpN3o7Ts/qGx5lebqpsli+PKb
         iYBPiUmv55RE1/0aFZVDJfGSLexfmUuFmw3OYWpdukB3n7O0pbmF+nQY1Xgpf57zlUmg
         O1cQ==
X-Gm-Message-State: ACgBeo1dgbtu5de9M6yMpPDiPo1QnPSoJ18P2hpH+aLmiJOBP9yoJk7e
        I8wCCUoJ/g478l7iMsFGb/TOnGU7UXY=
X-Google-Smtp-Source: AA6agR6AqXuRnAGk/wAhgOcJlVM1a3tktmOIxrGrti2wzCIQC6+WlJzhvI22k69z1FWxOrHxzUKAkQ==
X-Received: by 2002:a05:6638:3385:b0:339:ea59:a31f with SMTP id h5-20020a056638338500b00339ea59a31fmr3008099jav.55.1662590388444;
        Wed, 07 Sep 2022 15:39:48 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id q3-20020a02a983000000b0034c3e98f444sm7637867jam.1.2022.09.07.15.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 15:39:48 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/3] clk: qcom: gcc-sdm845: use device tree match data
Date:   Wed,  7 Sep 2022 18:39:26 -0400
Message-Id: <20220907223927.139858-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907223927.139858-1-mailingradian@gmail.com>
References: <20220907223927.139858-1-mailingradian@gmail.com>
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

This driver will support more than one SoC's set of clocks, and set of
GDSCs. This behavior would be unclean with hard-coded static variables.
Support it by grabbing clocks, GDSCs, and BCRs in the match data.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/clk/qcom/gcc-sdm845.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index 58aa3ec9a7fc..cd6e4e41dc9b 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -3574,7 +3574,7 @@ static const struct qcom_cc_desc gcc_sdm845_desc = {
 };
 
 static const struct of_device_id gcc_sdm845_match_table[] = {
-	{ .compatible = "qcom,gcc-sdm845" },
+	{ .compatible = "qcom,gcc-sdm845", .data = &gcc_sdm845_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gcc_sdm845_match_table);
@@ -3600,6 +3600,7 @@ static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
 
 static int gcc_sdm845_probe(struct platform_device *pdev)
 {
+	const struct qcom_cc_desc *gcc_desc;
 	struct regmap *regmap;
 	int ret;
 
@@ -3616,7 +3617,8 @@ static int gcc_sdm845_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sdm845_desc, regmap);
+	gcc_desc = of_device_get_match_data(&pdev->dev);
+	return qcom_cc_really_probe(pdev, gcc_desc, regmap);
 }
 
 static struct platform_driver gcc_sdm845_driver = {
-- 
2.37.3


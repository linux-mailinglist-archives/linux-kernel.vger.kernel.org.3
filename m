Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD9573EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbiGMVZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiGMVZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:25:54 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2401F63E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:25:53 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p132so136210oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahCcsqdWm37TmcPFIUtqpK14hIGNNZH3jmW8LtZtMN8=;
        b=NESHtn59Pikhwx2KrwGd+gSFuwVBsotcrOTVxXYCbQMMmCPtTqw2BsQiJUHHwhM+Ft
         7wApkkxKaRrTgAe/JMjQyHxtdcGnIj/gVUZn9R0mqMuNyOeHYar/zMnfBFQmQlzXo+wL
         rYinUkRdSeMp5P4q59cHeOkpWzvpCPxTy2XvizKZq3jtoRfWqOvSs1bjXyRG8DTI4X8O
         JPZ1IF2SH8AnZJuj6tghmPHFNT0irgIKR7HagvV9gvVDbkMYVFXl3Ehl9BVA9yWPzNuq
         wGGl63VseOdTBAc3MmFGkioly/NLNjsLIvi5IxhdTauvnsZP/nYyRTvpe2K/3uQW14nl
         iJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ahCcsqdWm37TmcPFIUtqpK14hIGNNZH3jmW8LtZtMN8=;
        b=Cx++Gj+NF2dMSL7BkWzaorUbWB+rU12+ifpj5AgSXsFm7vYfShjAFmJ8fe2Sxa8EMc
         ADxDBz5CdgH3Lj+ONkszfaLW6sDQ7kHNK1OjAwR6hzCjuI/g26gdMPdSHZ98kfupiCII
         qaiUMi5qgytHstPFtSYsvjZp7/xRhUBH735Kx1d09PThbVwDgvrr6pW1iOxYArunn1sb
         K/I91+JVYNd6fD+EEnQwnFZMx8cXSAc7r3aBx+w3NUdiJAxF+Ba7sOyjHEh7xt6zOz9r
         +jntMTi5yzqSBhiooBgtXOK/XEYBGAqbBX3zUr3AOaFO+qMHeXHzH1m6eqnOp60k/NYm
         1q9g==
X-Gm-Message-State: AJIora9Uz900jpUeLEQe7uhmB0PM0eSezhyEvi61X8y/7LKz9rQxfIoE
        uUUC1IVf4MJKAy7bWx7VFKvqcg==
X-Google-Smtp-Source: AGRyM1t2yHge3yTrtqRyoN4FGuWqSLwDfqF+kw0lyP4FH/bXEbtKTyOGVcHH5ftV7kPTKr0+RWJ9qw==
X-Received: by 2002:a05:6808:1a19:b0:33a:1514:507b with SMTP id bk25-20020a0568081a1900b0033a1514507bmr3036628oib.58.1657747552837;
        Wed, 13 Jul 2022 14:25:52 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b000f33b23a030sm6719965oad.57.2022.07.13.14.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:25:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] clk: qcom: gdsc: Bump parent usage count when GDSC is found enabled
Date:   Wed, 13 Jul 2022 14:28:18 -0700
Message-Id: <20220713212818.130277-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a GDSC is found to be enabled at boot the pm_runtime state will
be unbalanced as the GDSC is later turned off. Fix this by increasing
the usage counter on the power-domain, in line with how we handled the
regulator state.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added error handling

 drivers/clk/qcom/gdsc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index 6f746158d28f..d3244006c661 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -437,6 +437,14 @@ static int gdsc_init(struct gdsc *sc)
 				return ret;
 		}
 
+		/* ...and the power-domain */
+		ret = gdsc_pm_runtime_get(sc);
+		if (ret) {
+			if (sc->rsupply)
+				regulator_disable(sc->rsupply);
+			return ret;
+		}
+
 		/*
 		 * Votable GDSCs can be ON due to Vote from other masters.
 		 * If a Votable GDSC is ON, make sure we have a Vote.
-- 
2.35.1


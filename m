Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7199E55374E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353564AbiFUQHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353533AbiFUQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:02 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CA3F1E;
        Tue, 21 Jun 2022 09:07:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z11so13869811edp.9;
        Tue, 21 Jun 2022 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKqPjvnqn/BfVGE7rmt0Y6NyBVZf/KJRsjpNtw4RE3c=;
        b=dz7WmkSt2aBv/t4ECJFou+3jvdVpb7oFa9WWzezlhyydmuPbHkDsJbQ2sRLJMpDdJv
         yxpwRK1TU1fkoMjMYYyCUS/MRx4Cb4KbpW2/zpeW7Igk0lVT9ZdKJnF9uoLF1wRvyF/2
         4ECWBA4Y/ZlyDICPsbVVzl5EybvL0QVZ0WGUeCTGjCq7G11OSnHVPKBH/cbJpdxFnsSM
         tPyntE+WbWm6rh+hfvaFkgx0O/5TDOykL4LgPhXvqTKjCavmU4ycTUiypQc5CVHc9xlI
         YqNbZVWddayGAfD2IzxhxkjimFG3FOIbUv1T2gKV23Pes8l0x26vXtfPpUhc/2kaVUH7
         K1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKqPjvnqn/BfVGE7rmt0Y6NyBVZf/KJRsjpNtw4RE3c=;
        b=HSJAa0/TThZnYMRiTJ++fukDGoNVfydJumeM3dSei0cuzFhRNMwFZBucUryRrr87FO
         +b9GBH2DOk3VnGzfQN02j4xcXqPjIkHgOWkyz9hbTpyfbI22NBMbXGKiMqcsfxlByW+q
         XGxQaX5UtlKZ3VVIOamr985RlLIGvrlgFtV5IoajYQrGRjUeBtUJs9Rhvrgas5CrPuO2
         eR3094jNFHO/ZmdtIwSQP9nS3Py4CvHaIe4VbsEj4fQsgItxoAA08M6A321xyyvRWN+j
         0A5zPI+PffVzqZ2/TnpvEOfqFkk2U0vgh5S0MJrVz18OoNRg+xqDRuMM8TQz3kXENMbi
         MoyQ==
X-Gm-Message-State: AJIora/nixjr6q4oI37nHbOKyoPz088WwPzUPj84fTaqLY2ltia341pi
        5VHGTu0vLTC57W3ISoX50x0=
X-Google-Smtp-Source: AGRyM1tIFkBte3j/c01tIp3DP84GCU+PwJuyxQ0Kq3nlMMo7/s307lU+hI56/3rvRFbM0GnuYukUHQ==
X-Received: by 2002:a05:6402:320f:b0:435:7236:e312 with SMTP id g15-20020a056402320f00b004357236e312mr20386929eda.115.1655827620203;
        Tue, 21 Jun 2022 09:07:00 -0700 (PDT)
Received: from localhost.localdomain ([185.107.57.61])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b00722e0b1fa8esm1772943ejo.164.2022.06.21.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:06:59 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] clk: qcom: msm8996-cpu: Rename DIV_2_INDEX to SMUX_INDEX
Date:   Tue, 21 Jun 2022 20:06:16 +0400
Message-Id: <20220621160621.24415-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621160621.24415-1-y.oudjana@protonmail.com>
References: <20220621160621.24415-1-y.oudjana@protonmail.com>
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

The parent at this index is the secondary mux, which can connect
not only to primary PLL/2 but also to XO. Rename the index to SMUX_INDEX
to better reflect the parent.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 drivers/clk/qcom/clk-cpu-8996.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
index 4a4fde8dd12d..5dc68dc3621f 100644
--- a/drivers/clk/qcom/clk-cpu-8996.c
+++ b/drivers/clk/qcom/clk-cpu-8996.c
@@ -61,7 +61,7 @@
 #include "clk-regmap.h"
 
 enum _pmux_input {
-	DIV_2_INDEX = 0,
+	SMUX_INDEX = 0,
 	PLL_INDEX,
 	ACD_INDEX,
 	ALT_INDEX,
@@ -468,7 +468,7 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
 	case POST_RATE_CHANGE:
 		if (cnd->new_rate < DIV_2_THRESHOLD)
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
-							  DIV_2_INDEX);
+							  SMUX_INDEX);
 		else
 			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
 							  ACD_INDEX);
-- 
2.36.1


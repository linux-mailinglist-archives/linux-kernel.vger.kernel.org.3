Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A4570C60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbiGKVGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C861136;
        Mon, 11 Jul 2022 14:06:39 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so7777278eda.3;
        Mon, 11 Jul 2022 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uazmij0Esvr2NeRa8qq3R8EEDOgLATsuriz7SNqzQq4=;
        b=KNpmjORjN9Cnuurg42Z9ZqXLSIUAEkJg6aGJbC/9NZgi+A1YF6BMgWBuuNptWA8bWR
         UYpjcsoHZwbMZoGRC0y/m6FsYkkrmppYAF1FrrfZ0NyKQkxAnu/rKJ2qmLuKGevblnPC
         X8aYi4fkjvX7v0RIxtFI0YcPr2U5gQcctWLaLhHNDfp5MdjZnPZB80FLR3cYfEUiQgmD
         abjwMP0Xf8vBXfay6xxY3xoCw3DyQ1PiW9gBtCxVkAs1sj48UJeSdFgeI+a2boSC27Fx
         DDDevk6tkN9YQ3T32Io8uDdDbRGGeZxZRxze8auZ7i8lXhDjiSmTBL1bEGsm16iQWuJS
         tqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uazmij0Esvr2NeRa8qq3R8EEDOgLATsuriz7SNqzQq4=;
        b=pnTdDABJCMt6TAa38d0YY275zCbP/8PkdRR+fPomseIGrobgs3U8MkNcEji9YJARqn
         UpkMXSvFr6wq5Bfu0WwYyJYzVjSQSstHjZ5HOiJP30YzQ8nd+gipqkcUhSUEKDtAsLrh
         LXxcjcVv/amjX4AUcijBgaVvxtrVkAOOrMjKS8BNMj/5IjYUJ9W6NlYLZxszukYU9U/l
         dN3VykN0Qf+uzLKjOGhEJgRrkzGRe34YRLDfgQkclEDHDXC8/F6ebGOYYKIZkWXzIYxu
         eg7yz+jUy6tArXg1CPDmLkVQrxiuo5Klw2GDUDK0kcV7NMEAC+xdEsnk7Nw9JStSYlCv
         pQzg==
X-Gm-Message-State: AJIora/31WTnewRx4VoKAmeDXDSbq7UJ+wRtI1wD1hLNlGrNBeGj8EEa
        /u+Q/40xBrbomL6arcvQEHU=
X-Google-Smtp-Source: AGRyM1szg7J3Am+CedvikNzTE+AzcoNI3BTG1zSobgSxdI2pvbuLF/Q8MLQ+euSX7ezHJ9Q7PZ1rBQ==
X-Received: by 2002:a05:6402:913:b0:43a:b594:93a8 with SMTP id g19-20020a056402091300b0043ab59493a8mr23154274edz.346.1657573598153;
        Mon, 11 Jul 2022 14:06:38 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:37 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/7] clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
Date:   Mon, 11 Jul 2022 23:06:29 +0200
Message-Id: <20220711210634.3042092-2-robimarko@gmail.com>
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

While working on IPQ8074 APSS driver it was discovered that IPQ6018 and
IPQ8074 use almost the same PLL and APSS clocks, however APSS driver is
currently broken.

More precisely apcs_alias0_clk_src is broken, it was added as regmap_mux
clock.
However after debugging why it was always stuck at 800Mhz, it was figured
out that its not regmap_mux compatible at all.
It is a simple mux but it uses RCG2 register layout and control bits, so
utilize the new clk_rcg2_mux_closest_ops to correctly drive it while not
having to provide a dummy frequency table.

While we are here, use ARRAY_SIZE for number of parents.

Tested on IPQ6018-CP01-C1 reference board and multiple IPQ8074 boards.

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/apss-ipq6018.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index d78ff2f310bf..be952d417ded 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -16,7 +16,7 @@
 #include "clk-regmap.h"
 #include "clk-branch.h"
 #include "clk-alpha-pll.h"
-#include "clk-regmap-mux.h"
+#include "clk-rcg.h"
 
 enum {
 	P_XO,
@@ -33,16 +33,15 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
 	{ P_APSS_PLL_EARLY, 5 },
 };
 
-static struct clk_regmap_mux apcs_alias0_clk_src = {
-	.reg = 0x0050,
-	.width = 3,
-	.shift = 7,
+static struct clk_rcg2 apcs_alias0_clk_src = {
+	.cmd_rcgr = 0x0050,
+	.hid_width = 5,
 	.parent_map = parents_apcs_alias0_clk_src_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "apcs_alias0_clk_src",
 		.parent_data = parents_apcs_alias0_clk_src,
-		.num_parents = 2,
-		.ops = &clk_regmap_mux_closest_ops,
+		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
+		.ops = &clk_rcg2_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.36.1


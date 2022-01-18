Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5249133D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbiARBCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbiARBCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:02:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADBC061401;
        Mon, 17 Jan 2022 17:02:01 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m4so72501351edb.10;
        Mon, 17 Jan 2022 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rCx/NWCn5wFgUlCns4gxP47CTM6P+IWicMwkRv5E1+s=;
        b=W00CEX5U3ssKB+oc/8MFhXvIomGoLhGg7yCosvBcOD6Wuyo4FD2JPS2OPMhwVBPqRO
         gePd2zjbvbNwkfgLtBLtS429rXGK5LIY5nY0Ax6HuCWC1o3Nf35o+GPm8OwNuxLXNq32
         MgbR2hd5EPAtykP3e+plOIXTy/o3AGhMEVMqDm5H08jht+FGdfrrpdvXl/lHiZKoE4kw
         HhudslCY/IFNB6hsXLj5X1OiHXBmrXYNxobEcxmLzBD6q19j364ZNODKpcXscSa2JPZQ
         bWknZLbHEzu4g12kIog01MKBgVa8gUcc2TRiMkiGLwMrpUUH9LwaFPs7Jj7yFs7/KtjU
         FZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rCx/NWCn5wFgUlCns4gxP47CTM6P+IWicMwkRv5E1+s=;
        b=qqequIVvWRn0QXoXNhTMdIOV31zGzOS8XD8M8NhCvk1SEVXlOyG1Z4RRt/Dziktxm8
         vXz6JM+OmwMVllq4roCwuinNCwFD8bqRFEquQE1bWG2m26yI0MGT97tOsg0IOKS1xjMM
         GpD9FnL+WrLmwsiGinE3tA2aJ8sdS4d/imYLqBcLSXITs4ZDZ8fh7FALmLJCNp6i+lzj
         zuZK2bz4EW1ByKnyLWInjbdQZifm2/SEw6QupJG9Gy27th7FVzqZVqDghwyTfFzVxwOE
         rPXzGQKnw4jkp5o2tQUn/s79aBhCRlqhZl4OOY14q+04u9cSNmUCL94FeK9nIaspFC3O
         YTHw==
X-Gm-Message-State: AOAM532ICZk+gWzHNccYbCcoI55ZfB7BJwBPPxV/cAiBvkiMkY6HyKId
        zWEerB0yKYOZ9XYQf8rAXUU=
X-Google-Smtp-Source: ABdhPJwaLjuiJXYwOM+CpUiffY2l13ni9Tf460XnssKQ2McotB+4RV+MocFyft2g6cZHVr6s0BkoPA==
X-Received: by 2002:a17:906:5fc2:: with SMTP id k2mr12334612ejv.472.1642467720128;
        Mon, 17 Jan 2022 17:02:00 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id 24sm4892127ejg.47.2022.01.17.17.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:01:59 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] drivers: clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Tue, 18 Jan 2022 01:44:28 +0100
Message-Id: <20220118004434.17095-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118004434.17095-1-ansuelsmth@gmail.com>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clocks are used by other devices present on the SoC. For example
the gsbi4_h_clk is used by RPM and is if disabled cause the RPM to
reject any regulator change command. These clock should never be
disabled.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index d0c5441eb98e..7d1ddbbbc8ec 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -810,7 +810,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -828,7 +828,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -912,7 +912,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -981,7 +981,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1027,6 +1027,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.33.1


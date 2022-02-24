Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3624C4C31F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiBXQuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiBXQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14871AAA55;
        Thu, 24 Feb 2022 08:48:51 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p4so221961wmg.1;
        Thu, 24 Feb 2022 08:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wR7verCsF4y3vjmAFlqOCCqihDr70DuiuS9gm5q3ByI=;
        b=pNmioxB0vKaOaBGdJx3zi3YLzB9pldhSKQdVe3Ct3/7ahvC7uqusik6mjQXrhunlPn
         ds6bdxKYqhb0p3+Z1vKKikDuAFoqsvbftDnG5s6o26kPPMJI83zCYQ3c5PT7+3hiNViT
         8MXR0lYVQ4EqrLD9Zcods1IniFTLCzhjIlSAFo7enM3GxiiMU2jFUczD6qMOqvBgQmzW
         7kezSTh9mVsjGsq5nQDekwEQrWPygYfd4BFKLJH9mBXVcJwvLDvhAmn4vuOexemSdPHB
         F9/j4fuBLakEtpqy9tC9+/XBUFx2WNbedAgrfagyfNX8WQm5Htri5afKKxTmWBhmfLEb
         VqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wR7verCsF4y3vjmAFlqOCCqihDr70DuiuS9gm5q3ByI=;
        b=nCfq2YoPfhitO8nL6cv0YPxZ/z34yig50iGJdPuWX22orohN2H0uMhf6ondL+xM5Gn
         FvrZnRfWvDgEMXcIkjFpHFYaYo+/nq2hTmskBiOROyMxk6LYmrb+P/0yw6kiWkfAPSYl
         jSXqRR33E+DMqovPM6/RbxiCNNGYYzUFuSwTsKQc+8eeGjsab95Fs0TNMurF1c+AfE72
         RSldnlIL71KoyOnTTfL3nMH2W3yzUskEvi8HvNrGysIByjw6XnHI/N0puwKOdXSGNRua
         Za3WOnDmFsufgBl8XZVRdMWdLPkeAPog/2qBRyE8BkKnvxFULybOWp61WyyITvpB5R7J
         /Fyw==
X-Gm-Message-State: AOAM533NNUoWjr7yIY/Iwq/VCC1C5V4yuZcANvwhGbc0PHXzeGOSfiMe
        92rGp6MaPHIvKXz6mCB9giuZrbqv1i4=
X-Google-Smtp-Source: ABdhPJyTzzj4g5/GQQ81Y04kAJ6K9fnM5w5MsUT+UfAfMgy7wyj4b/9Nvi0cnp/ElDO20HMF9JJ68Q==
X-Received: by 2002:a05:600c:19d3:b0:37d:1718:be8d with SMTP id u19-20020a05600c19d300b0037d1718be8dmr3170372wmq.111.1645721329948;
        Thu, 24 Feb 2022 08:48:49 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:49 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/15] clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Thu, 24 Feb 2022 17:48:24 +0100
Message-Id: <20220224164831.21475-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224164831.21475-1-ansuelsmth@gmail.com>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
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

Some clocks are used by other devices present on the SoC. For example
the gsbi4_h_clk is used by RPM and is if disabled cause the RPM to
reject any regulator change command. These clock should never be
disabled.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 0a3ba3480de8..49a4eae4161f 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -805,7 +805,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -823,7 +823,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -907,7 +907,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -976,7 +976,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1022,6 +1022,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7754C3214
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiBXQtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiBXQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:49:36 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCCB1C60C0;
        Thu, 24 Feb 2022 08:48:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d3so623967wrf.1;
        Thu, 24 Feb 2022 08:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=G2ztJDmnzUJFjzMszXXqncdEv1+kAKg/pMcz0nH32YU=;
        b=egaFw+1A9tM6VbTNViCeKwAiUXIMmNeVrv7Kro25W2UWNDf2Ah1Z15QfhkhnH3Nhw+
         +EPveA1dmejRNXRkNq1CDCD6ZZBaSGxqOaCl6Vw2zQ/O8SsMjMQxNEYbIH3D6hV+7r5Z
         UCt0NgO5sbG09kqNN11Yg3esi+UUQsiwjMq43QZx6Hf9unJLJ6UG6iEXz4hdeuULFxZD
         pag/6GX3OIbU3tSaf97hG4ND+fnmm2VduoiBXDs/iZ+3obEsoiNQuHeN8jLNHzeFa/cX
         RYyEKwkldNDUZeNWI0HWQn5QMx3tHriyXnGslWigLjIexfdyOyjcjO9j4wLNs5fJADK0
         G9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2ztJDmnzUJFjzMszXXqncdEv1+kAKg/pMcz0nH32YU=;
        b=RcLSEFGy8sZiDSDqQGu6tTJED2tHliwclnPgcOM3lnxnW5kvfgT4YGA/+seE58BuZL
         wuyXN3GDvpG4E6llXN+0OLUszI9iVDBrodt+swbq0WPtLUT3V5SxE6Wg5fomQEHVrUlY
         D2il+u7UMSRm4uzUVKWq7Yev0uTkLW4N85eCr1MLhyQS2+8XSJa9CVXZjvXJp0H9gw3P
         U5kSXu2Kbr6QxoUbjt/bE/ecYstUSiaMS8kkLxxsO+hvVP2lu1+1i4UrDRWbvmS0KgtM
         0jFCByDppSXpq5U+te+BNjkN1m67eJiGsvMzNcFl84145+PoIg/6AJIW9vRU39YM95bL
         jsdQ==
X-Gm-Message-State: AOAM5315Vqc1qA7V4llrjhnWz5W2UekhiaXgcv8F5DA6hIGTl1hWNlaA
        Yg3n9EZZruJWbaihzvaoEDA=
X-Google-Smtp-Source: ABdhPJxOJXEiEb1YkF+BXrupRnLVvYFf1g0UWb5cdmqaBQgzSHNs0kdqD8TlqKTwvwdkoa5Sf8PJ9w==
X-Received: by 2002:a5d:4acc:0:b0:1ed:b776:a501 with SMTP id y12-20020a5d4acc000000b001edb776a501mr2938856wrs.76.1645721334064;
        Thu, 24 Feb 2022 08:48:54 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.googlemail.com with ESMTPSA id k18sm2694095wrp.104.2022.02.24.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:48:53 -0800 (PST)
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
Subject: [PATCH v5 10/15] clk: qcom: gcc-ipq806x: add additional freq for sdc table
Date:   Thu, 24 Feb 2022 17:48:26 +0100
Message-Id: <20220224164831.21475-11-ansuelsmth@gmail.com>
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

Add additional freq supported for the sdc table. The ops are changed to
the floor_ops to handle a freq request of 52kHz where we need to provide
a freq of 51.2kHz instead for stability reason.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 49a4eae4161f..6eb03b72eed4 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1299,6 +1299,7 @@ static const struct freq_tbl clk_tbl_sdc[] = {
 	{  20210000, P_PLL8,  1, 1,  19 },
 	{  24000000, P_PLL8,  4, 1,   4 },
 	{  48000000, P_PLL8,  4, 1,   2 },
+	{  51200000, P_PLL8,  1, 2,  15 },
 	{  64000000, P_PLL8,  3, 1,   2 },
 	{  96000000, P_PLL8,  4, 0,   0 },
 	{ 192000000, P_PLL8,  2, 0,   0 },
@@ -1332,7 +1333,7 @@ static struct clk_rcg sdc1_src = {
 			.name = "sdc1_src",
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
-			.ops = &clk_rcg_ops,
+			.ops = &clk_rcg_floor_ops,
 		},
 	}
 };
-- 
2.34.1


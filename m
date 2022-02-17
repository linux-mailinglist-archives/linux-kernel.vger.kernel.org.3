Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179BB4BADFB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiBQX6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:58:18 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiBQX6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:58:04 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D8A42EC8;
        Thu, 17 Feb 2022 15:57:26 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id x5so6814292wrg.13;
        Thu, 17 Feb 2022 15:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FZYn4dDcPjXeJZV6gh5sYOUK3nuBBshuULLNYbagtWM=;
        b=p2fZr2bEOFZ/lxAQQKPqKjiMYkPzb1hgQZy8IGivHanoZ5/5wENheWCpskLXpFxdUi
         VuWY8j4FWnmGmKq96o25bC0M7Q69mFKLt4JXZnjd3uY16nvwHwloYSkc1oNqL3Fr10UX
         iqrO8oSL3IjkuIm/AfjVV6D69HWhjsPJiLI6WVeBlqVgQ3IAo9SzG+F7KP+Ynpg17PaH
         +N1Ledd3PARh4ehvXt4bb2glRfcYI1ibXDFObYLbZpJVn9/Ty8p3T+kBsaUWLkiY7xZb
         3Cqkvh90ZjfMHtSjTnD3jVKYGmdPt3N3j+PtRmS/oJvpGO5NP1CXA5WNyYOTJ3vsc/dP
         TFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FZYn4dDcPjXeJZV6gh5sYOUK3nuBBshuULLNYbagtWM=;
        b=rUcvCp33AAMxv3tHPypXvB8hHNEX3EV8pKyT+8L0V+NJ2A2BEAu5FWoZU6y3NPm+DW
         UhNYUeiEptlZ5QsJAJIEomZ6BrBlByFnXlNKinpd7oi9pp9UL+KJPWljaeu/88JMtmLt
         w+hkxQ5L2gLIVXu5QpCiy3snMGJTh53OA6D1eg73PaZ8wDYUTqmtn9VxeBw0H4nDG3Dx
         j2GOGk+vsuZjnyLPnt8GJKb3bPuSI2+YnLBz8IfSSit9fDMgHBB5FCaF9N9R0Fhp1P9/
         T7lBd44A1Nbkj0CY1lUzTFBPPz+P/WDR/HUkhpg3r7OHdzTzUnXA3ScmuB2paOsZAXds
         D7jQ==
X-Gm-Message-State: AOAM532Rc61eVGciK95nFkDmhrqgyRniXyg0vB1Rhs83Ra2+GuBLvMLd
        fLz3pIlcJtNCc/zuUH5FW0o=
X-Google-Smtp-Source: ABdhPJwU5YMC2StsQVw15/v4ARdP1QkUCzJvBv66hk2TXNWNy+VkJG+FacLTb2zLCMC/I6/YzEJaEA==
X-Received: by 2002:a5d:4e03:0:b0:1e3:3a59:48ae with SMTP id p3-20020a5d4e03000000b001e33a5948aemr3981917wrt.634.1645142232538;
        Thu, 17 Feb 2022 15:57:12 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:12 -0800 (PST)
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
Subject: [PATCH v4 09/16] clk: qcom: gcc-ipq806x: add unusued flag for critical clock
Date:   Fri, 18 Feb 2022 00:56:56 +0100
Message-Id: <20220217235703.26641-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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
index 53a61860063d..77bc3d94f580 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -798,7 +798,7 @@ static struct clk_rcg gsbi4_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -816,7 +816,7 @@ static struct clk_branch gsbi4_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -900,7 +900,7 @@ static struct clk_rcg gsbi6_qup_src = {
 			.parent_data = gcc_pxo_pll8,
 			.num_parents = ARRAY_SIZE(gcc_pxo_pll8),
 			.ops = &clk_rcg_ops,
-			.flags = CLK_SET_PARENT_GATE,
+			.flags = CLK_SET_PARENT_GATE | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -969,7 +969,7 @@ static struct clk_branch gsbi7_qup_clk = {
 			},
 			.num_parents = 1,
 			.ops = &clk_branch_ops,
-			.flags = CLK_SET_RATE_PARENT,
+			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
 		},
 	},
 };
@@ -1015,6 +1015,7 @@ static struct clk_branch gsbi4_h_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "gsbi4_h_clk",
 			.ops = &clk_branch_ops,
+			.flags = CLK_IGNORE_UNUSED,
 		},
 	},
 };
-- 
2.34.1


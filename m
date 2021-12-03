Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75F94670EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbhLCD4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354586AbhLCD43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:56:29 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB77C061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 19:53:06 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q25so3465108oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 19:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dpqixTWiVGWiYabOu0I3C2VDh8fb1TU9B4bmnLjn4lA=;
        b=o+BhrVJxDAkpC90IBFmsSrYrMll1yp0WFYoS+zHO4hhkitrPYWteyZabjTlib+Xtw8
         MjsiSOBbOGYsEKyUJmbn31CUXjTSq+LkvH7r7dDsg/gr2VAf47lRM6lgWXS4SXWbv0D8
         dLtLQnwrIBANVRZ8AkNGgb0V0utqz+EwdS4BXxkTxGVqfth7ZWJMgQxNQfgED7o9zXIM
         2RwS3Nt6HhbTNxWygP9aHgR9HhHOfznsmAlssKGYdob2KFZ7bZ/M4th//sLKiloMZGk2
         5Vdg6OTF47JDVruu8y0r0prDmH5Mkl7q9PCd1a72aXEZQixVCz1o4U6QP1DpCeYOspaw
         4/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dpqixTWiVGWiYabOu0I3C2VDh8fb1TU9B4bmnLjn4lA=;
        b=gP5Yrl7xxI1kmpsEEbCKSG01oScluDS3ljsGuOXFlN1sq6ByonnCAL066AIlVRx8u1
         9gVCt8SWbRZ0BtdJ43lLfk8Pwpt5VvgPIoCoCZ7Z7Oxon9XTffvqHNlDA7az6CNyO9VQ
         Ou7lzVH9ZulU4aYEepRS/iN9rENGfM+gVvcyKZapNkIIFc2+LBvH6H5EaYwM1Kq65F57
         ZogX2JfSjuquAXQlIytmA8pvBWwpK5NCEgOc9tx0imSCPJyG2klwezXDb0LVEWvrDa4x
         uPsHUZy9aKIHsWyUaNs8fCA/YJH58OuvJRmq7eUXoLNwuCxzJLHWwOUCPgNXifzU1ASZ
         qJeg==
X-Gm-Message-State: AOAM533+XrFRzkVLlpnoc8NxzXIZDjPDOVPahV9trLhEA8Qe2OJLcBFX
        ROwBUT6U5KZp3jox9u8vXG4DbsSJmoOlyQ==
X-Google-Smtp-Source: ABdhPJxkCYrayZNm047DAM5zj3R3twVzowyhkuuyL1K2DLsOqgr76f47R/XUYjnLdY6TAJxn+sZgEQ==
X-Received: by 2002:a05:6808:238e:: with SMTP id bp14mr7832547oib.130.1638503586042;
        Thu, 02 Dec 2021 19:53:06 -0800 (PST)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t14sm418006otr.23.2021.12.02.19.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 19:53:05 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        dmitry.baryshkov@linaro.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: sm8250-dispcc: Flag shared RCGs as assumed enable
Date:   Thu,  2 Dec 2021 19:54:36 -0800
Message-Id: <20211203035436.3505743-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
References: <20211203035436.3505743-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state of the shared RCGs found in the SM8250 dispcc can't reliably
be queried and hence doesn't implement the is_enabled() callback.

Mark the shared RCGs as CLK_ASSUME_ENABLED_WHEN_UNUSED, to ensure that
clk_disable_unused() will issue a disable and park the RCGs before it
turns off the parent PLLs - which will lock up these RCGs in any system
with continuous splash enabled.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/dispcc-sm8250.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 2842e2b6f4a4..f7c7c829553e 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -218,7 +218,7 @@ static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
 		.name = "disp_cc_mdss_ahb_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_ASSUME_ENABLED_WHEN_UNUSED,
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
@@ -550,7 +550,7 @@ static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
 		.name = "disp_cc_mdss_mdp_clk_src",
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_ASSUME_ENABLED_WHEN_UNUSED,
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
@@ -602,7 +602,7 @@ static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
 		.name = "disp_cc_mdss_rot_clk_src",
 		.parent_data = disp_cc_parent_data_5,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_ASSUME_ENABLED_WHEN_UNUSED,
 		.ops = &clk_rcg2_shared_ops,
 	},
 };
-- 
2.33.1


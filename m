Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DE4D77BD
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiCMTGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbiCMTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:23 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0D4D62F;
        Sun, 13 Mar 2022 12:05:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y22so17068149eds.2;
        Sun, 13 Mar 2022 12:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=XskXl0dWUiZDjMV75GJUYOdUWBNXrTgYu3bGRKZZHL/+ZwJh7A/WyRWEvg+41zTqsV
         qxLLxzmxJi+YTjhjtYk487wsoQxY5JPW1XSV5ediPlSVPsDFDaPtFSu6ee9IUFFRmwTj
         B0uQ6b0pQS+32RbOmmq4z1lAuC3iFQQzQCjvKAA+GAT5Q6nl/FfMFMgqsyV9HncLZnHl
         XpbYDf/SpNJu6F36zqsjILb/Fm0SW3Ku3psCk6OBAXgrGGP8HQR3jFImQkBMQumpwWkY
         fWpw9bSnZfT1Q3AZlRmNj2/59fufsDT9tRiG4vwUMq6D4C3BlWvfE8p83mIJYbSpzrFw
         pqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDLuIDyRCuRCH3Dc/gWWNAl91bj4g20Fwm4jwXMbE5A=;
        b=f3KnQj09xxe25KBVYCrysu1NX+l20TAYaTvrFvbHIkqwJU7yBa8o3Lk1sObqmJGY5+
         hfAivoA88309Evw8U8LBCBUV8/431KFELdom/s9CefprwzD7rSz/mr8vW7hJSChvE1YN
         Va6s2F4s08O/dmeGa0TjmXpnl7hhe126kONWQWluPxPVhE4CGfrC1AR0zK3sTPON1aX3
         L/5EgYgpDv6iXvEMTcYcSyHfamBfj6vO37F3zmx0Vtk5ICKKMjTHmlS8ZPUGfPVHW4pc
         w6DGRq62cS3mHQ+6I8vUoISUOr7msntx2gfF5ga0zkFPUxwHyFjUUjfCkf0rFNaimlZY
         cVBQ==
X-Gm-Message-State: AOAM530npi/3xMc6LI2a0Ouqe1fymzgbzsXwQJi9sXkMpYWgapB6cvpD
        su6rjC+uVRN44mxIF51w9j4=
X-Google-Smtp-Source: ABdhPJxEd19rUdqjOvPTG3FNBKH26QTry81M7HjqFvgqGaJxNmoVRMrAdqyNY1orYsRzigbHw4UWDQ==
X-Received: by 2002:aa7:ce1a:0:b0:416:460:9df5 with SMTP id d26-20020aa7ce1a000000b0041604609df5mr17215194edv.277.1647198308027;
        Sun, 13 Mar 2022 12:05:08 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:07 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 06/16] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Sun, 13 Mar 2022 20:04:09 +0100
Message-Id: <20220313190419.2207-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Unlock spinlock after the mux switch is completed to prevent any corner
case of mux request while the switch still needs to be done.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 59f1af415b58..e447fcc3806d 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -32,11 +32,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
 	}
 	krait_set_l2_indirect_reg(mux->offset, regval);
-	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 
 	/* Wait for switch to complete. */
 	mb();
 	udelay(1);
+
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 }
 
 static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
-- 
2.34.1


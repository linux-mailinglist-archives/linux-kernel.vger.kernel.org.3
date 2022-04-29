Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67255148CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358895AbiD2MIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358842AbiD2MHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:07:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2618C6EFF;
        Fri, 29 Apr 2022 05:04:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i27so15011254ejd.9;
        Fri, 29 Apr 2022 05:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTN4YPB3ReVlC0xdlo/o2kEZ6pNHWHpS60qNSXbPOCg=;
        b=PohNDIo+Eo0LZnDzbZrJiK9XGhhrFEicR8oWQHwLl8Y1a8Sr5Bu/ge1oiQqdduVBNN
         NOkmVUHpXRR+2jDUlU/FRsbsQjCN+WWz4OujIMTu0Ao6eX18LeK6JHHvHqssXmhLJCI7
         ywTNp9+Qno+exjne71N7srBOzz/thnQwfGFVGIs49OQlwKTAHmHe8hsqlzKU/bHTrira
         hZUReCoW4x4YLiISOlFiWQTOf2WspqAqhCHLRfUReCLKgI/SvsLX0hRJrP80JTZQDIR9
         uOa4ra4LOEWYe7sTsVZqDSshbfdxUHlZuZjpM62cmvvx5n5RaI9wRcFRZ1ub6kGZbqPq
         RQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTN4YPB3ReVlC0xdlo/o2kEZ6pNHWHpS60qNSXbPOCg=;
        b=1mRhXYJ3a8Fl35y9sQB+znhTPz0jWo8mKt4PQ2yFlnq2PPZinI7oPD/+VVhrQNCyDy
         OZUaHZi9V2rWDGaiDNPJezLeuwBEuymOT/yYLJj0Wkfco/hzwNd/q2WcylBR8r+4djs1
         JMSkqOCxjCN27ZZyDjU3aV0tpfYR7k//I6hPbX/hbkAov0D9MVx+zx2HCSZ9kYbIyhGt
         iynLp9MoCU4e7DR8XIANtn5+0mTJtQAWfykQKks02rTdGOF22BU/lyDRQJLcYOlH/kNW
         gw+k5e3prDJqZ88A+fLe4WOcQlT6+65b8YV4XWnNsG9LFmx3muz5oOCeD/DZaDdwfoWH
         +5eQ==
X-Gm-Message-State: AOAM530NDTffSVVmkn/V0J9Cs+y0/sPD/RFjPiT3ph+WFRulWYM3wfTG
        /nXE2Q6VxaGE7vAvi6mzvx0=
X-Google-Smtp-Source: ABdhPJyXOodPPAA+FfJITY6pN4kVrunB2JpbhBMBMTT7QLBbEVaC1lUl4mfZyzDq6xLnqNZLMhQhvA==
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id gg2-20020a170906898200b006f395f44adfmr23837541ejc.524.1651233870256;
        Fri, 29 Apr 2022 05:04:30 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id eo9-20020a1709069b0900b006f3ef214e02sm581338ejc.104.2022.04.29.05.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:04:29 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 3/4] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Fri, 29 Apr 2022 14:01:07 +0200
Message-Id: <20220429120108.9396-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220429120108.9396-1-ansuelsmth@gmail.com>
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if hw_parent is present before calculating the round_rate to
prevent kernel panic. On error -EINVAL is reported.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 90046428693c..6c367ad6506a 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -84,7 +84,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
+
+	if (!hw_parent)
+		return -EINVAL;
+
+	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
 	return DIV_ROUND_UP(*parent_rate, 2);
 }
 
-- 
2.34.1


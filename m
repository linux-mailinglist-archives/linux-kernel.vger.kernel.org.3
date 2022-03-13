Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B074D77B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiCMTGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbiCMTGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5604DF60;
        Sun, 13 Mar 2022 12:05:10 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dr20so29343598ejc.6;
        Sun, 13 Mar 2022 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sGj8B8j9Pw2IR/o72q6EjCl5T3t+1bmUyf2kYodPsRM=;
        b=atWc/wRl6k9wbdttykqBYuayRGkmafCvguTkpFh/NTsuYcyCynxRq2J5/yiB0HoesP
         RiBSVNUJUFLNVMoppLV57K+5OuY0dlBVIbF1dx33ya95GNhsAkCCU9DJ34IcVzxZ3KQk
         PvjlaMQ0785VqScIP10aR8OPk/fgnVDVvA3+6Z8951/6Nw50KP4C5skLDjE9vHDj3a9O
         faMf5NhhBmsDWxqlW4mSRDZQueLBGhla1/TSBVQ1CD018KV4UrxV7ioW4Naue4rm67i6
         D5aqlVCnXrnFFbdx16zxlqXYaDp3GWKUGXXfgeQMeP/nohBD+Q0jfKg0T8f0w8WwY3g+
         2Q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sGj8B8j9Pw2IR/o72q6EjCl5T3t+1bmUyf2kYodPsRM=;
        b=AdJo1zqHAS/nOGg55v0KOyEwvPpRN/kB+DJ435LYRzrSsEmysa4mIBdO0NXqk+Jbb2
         B9nC57nc89v7sX/VTtwqne/h9SfJ/5L9jmJ5MHsgGLrvvN963LiHv0/d9QORHShmw3FW
         H+eRG4ZBMvskuYBh6hp2IVTBYEk/5tRMJKuWDDgHH2kEx0Ek679vBd7i1fT0tH9Jr9Uf
         n81wWZvvY4q7IyGIaK1JgCxTSpxn57Ox9i0LpA/MgO7iwLLk5SBz02d+sBrY9T7CpWi6
         a0krnSVcnpf2Y8wbvY/rK9K1bclSf7NqfcqukFHcjuTGRJRYMJjd7dFewXhg6ApaBHgY
         dXyw==
X-Gm-Message-State: AOAM533pjdgsWOdDSFyk1inlBsIzZ9leLoqcRIs/G5mbClRl44QlD7FC
        VmIb6xY+3qb9ZNPHJzGT5iA=
X-Google-Smtp-Source: ABdhPJwpivhqHoJiBwRPTccXKrxYpEY1DhxDRe7t541Uwi34g8eEKRcRYpX2e15BDHR/DumidDT6mA==
X-Received: by 2002:a17:907:9483:b0:6da:a26b:2d44 with SMTP id dm3-20020a170907948300b006daa26b2d44mr16756955ejc.337.1647198309215;
        Sun, 13 Mar 2022 12:05:09 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:08 -0700 (PDT)
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
Subject: [PATCH 07/16] clk: qcom: clk-krait: add hw_parent check for div2_round_rate
Date:   Sun, 13 Mar 2022 20:04:10 +0100
Message-Id: <20220313190419.2207-8-ansuelsmth@gmail.com>
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

Check if hw_parent is present before calculating the round_rate to
prevent kernel panic.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index e447fcc3806d..d8af281eba0e 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -80,7 +80,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
 static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate)
 {
-	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
+	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
+
+	if (!hw_parent)
+		return -1;
+
+	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
 	return DIV_ROUND_UP(*parent_rate, 2);
 }
 
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76952569F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiGGKDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiGGKDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:03:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280FB2FFC8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:03:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l68so10309474wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lyjBxTca7YaObwbb4+mBlqGjkBNtiN/iQI75P0dOoGs=;
        b=ApylUshkdPMBxowBWdA11FXwyilkLHFoxw2TpZNdWVe7J5wK5WsuGuLdOmNX9zTzk2
         B3wObarbyP8uqKLaucFKPH78aop8aE2blu7qAJxjpQV5nQzDxGkC1l+zG1hr57kOGvSH
         KgIss4NahKugLPEinebU9ajU/LHaVcvDyCz6Z39lpqL29COOaADmWKuLQbdTKSJqi6kP
         xAXlqSE1KkqV65uWgS3vpW/BlnJWVs4SEftY6DMHJooeFm6vanfThWukfrTHd/9tAGJ8
         ZyrjZZbQK11/AxnT17r7KeJLminrUJ2pwTXpmV+7H0bqbmeBHrfZWOcF3ulMGARIhSvh
         EO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lyjBxTca7YaObwbb4+mBlqGjkBNtiN/iQI75P0dOoGs=;
        b=tWDv71oPwO1lpKBrQQw+LoF7EsQ57KWcUHEZaRPgtgN7FXodasdmlthyDx19IsDMWG
         fpK0mBCmuTDmLe96TYPt6MUuBmwRFcOvJ1jRDr7S7qCzDiplfh0ICD8C2R6Skw9IQlC+
         k4+2UDmRJF1VHRiOXKLwRQaDHLiETnt4Phwx0QdwFmuDt8OLF/YCBk4EqZP0ydx3jaU+
         859528QXBzBBpwYLsX6awgPnUY7KDJSM6Az9xYykc/Zk65KJlQSs3f8OyCM3UsOBDHrs
         JU8+tQuSuPo0qsE1Qmw9P3RWU7A/EVZLokP9s1FSuajcVZUCFvOEmtmQED/QlVim6TyV
         8vMg==
X-Gm-Message-State: AJIora8ZH4iXifFmfVEsEplKT97llRhYB4aexr75SCefSV2R0tkwcr8Y
        qh76PGruTu2B7h+r3fweL2mYuEzl1lpNrA==
X-Google-Smtp-Source: AGRyM1u9J+vSFg1DqYI+JSf7PHyh8N0GS+NGvJr8GthhXh2mHVh2UqUCCYZ4YWoXz6FbhRB0mk59Xg==
X-Received: by 2002:a1c:e902:0:b0:3a0:2d95:49d4 with SMTP id q2-20020a1ce902000000b003a02d9549d4mr3555661wmc.189.1657188221377;
        Thu, 07 Jul 2022 03:03:41 -0700 (PDT)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d548e000000b0021d7ad6b9fdsm4612034wrv.57.2022.07.07.03.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:03:40 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
Subject: [RFC PATCH 2/4] clk: Add consumers count to core
Date:   Thu,  7 Jul 2022 13:03:07 +0300
Message-Id: <20220707100309.1357663-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220707100309.1357663-1-abel.vesa@linaro.org>
References: <20220707100309.1357663-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keep a count of all consumers per clock. One usage of could be to make
core decisions (like disabling unused clocks) based on the number of
consumers a clock has.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e1d8245866b1..9b54afd2fee8 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -72,6 +72,7 @@ struct clk_core {
 	unsigned long		flags;
 	bool			orphan;
 	bool			rpm_enabled;
+	unsigned int		consumers_count;
 	unsigned int		enable_count;
 	unsigned int		prepare_count;
 	unsigned int		protect_count;
@@ -3682,6 +3683,9 @@ static int __clk_core_init(struct clk_core *core)
 		core->hw->core = NULL;
 	}
 
+	if (!ret)
+		core->consumers_count = 0;
+
 	clk_prepare_unlock();
 
 	if (!ret)
@@ -3699,6 +3703,7 @@ static void clk_core_link_consumer(struct clk_core *core, struct clk *clk)
 {
 	clk_prepare_lock();
 	hlist_add_head(&clk->clks_node, &core->clks);
+	clk->core->consumers_count++;
 	clk_prepare_unlock();
 }
 
@@ -3710,6 +3715,7 @@ static void clk_core_unlink_consumer(struct clk *clk)
 {
 	lockdep_assert_held(&prepare_lock);
 	hlist_del(&clk->clks_node);
+	clk->core->consumers_count--;
 }
 
 /**
-- 
2.34.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10354D7793
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbiCMTGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiCMTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16D04B40B;
        Sun, 13 Mar 2022 12:05:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id m12so17003316edc.12;
        Sun, 13 Mar 2022 12:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FipcY+lkDnxvWbnpTUMABHmi8LHo7/IC+P6HwGjY488=;
        b=U2tU+HYy5lbcm/0aqa4m9mdzYpiIHgL7Pe3kFb2jPZobjl6e9Mx/+N2rJYnJFvo18k
         Z96PQcY0rfyd8qk4ng6xDwH0vPsaQBDUpigqBXkaUEeCCXth4mDG5z1lsVAIRyRSlSKq
         +OLGn5FH3JkfWk1mcbhv0FeVf8YUKkWLAi9ZqBDm5uxY0Gadr02jaaVO7xxN8JM5/ltC
         BzIwY+q7UWisCaRcyBr4yR8zNHw6PU5hG7uH2tpFEsaiyCPcXO3TWAEQKxjHYG/kehA3
         zIcvZFTpkqMv2NNkvqpz25bSptgv5GhxOMaU7bUd6NIwst1W+SgmaS1XuyurtySOxgIe
         UfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FipcY+lkDnxvWbnpTUMABHmi8LHo7/IC+P6HwGjY488=;
        b=iPrtCP9AMw5Zh/GtcyZJZM2JlguvOTXnLjTKrQAQQv0aPC+IysoimMHG5d8/0d1fUy
         +3ChqQAsM7lFgR0ApuLcHEida8pQMhAM5z49XFe1orRi9kudsnjCNFHHqaUjczPkE6gU
         vffGTqwrs9XWV8ohvDaWkUFIaFmwH3YjDLA8IpN6DszMlc4aomCdueWWWUAnQA6Df6Ap
         zAvq+DfKAFuyk3eBwQT104aRW40dBfT2GdiTG6PhB5fnJEGIzWGT7OMdqwi1942o6kT1
         K0L0sjC7T9/JUYhHXBKUkiUlrjgEx6bO1xjQ41ErajNAOEEn+6asXrMEuz0T8wf2yJT1
         IuCQ==
X-Gm-Message-State: AOAM532YyglyxXXgPlZ32/y7cMM1CM5gKPxFppCDYMbBb7/GnWLuwIRh
        RSjmJhokktf7Ope1t84i4sI=
X-Google-Smtp-Source: ABdhPJxYD9W6GHhYeKFQdJKjnbUP6tqfeGRYBy5Kuw4m0kblar/Mdnlkft6bgMegPd67bTBBYxowcQ==
X-Received: by 2002:aa7:d313:0:b0:416:8fba:835f with SMTP id p19-20020aa7d313000000b004168fba835fmr17204808edq.354.1647198302090;
        Sun, 13 Mar 2022 12:05:02 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:01 -0700 (PDT)
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
Subject: [PATCH 01/16] clk: permit to define a custom parent for clk_hw_get_parent_index
Date:   Sun, 13 Mar 2022 20:04:04 +0100
Message-Id: <20220313190419.2207-2-ansuelsmth@gmail.com>
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

Clk can have multiple parents. Some clk may require to get the cached
index of other parent that are not current associated with the clk.
Extend clk_hw_get_parent_index() with an optional parent to permit a
driver to get the cached index. If parent is NULL, the parent associated
with the provided hw clk is used.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/clk.c                 | 14 +++++++++-----
 drivers/clk/tegra/clk-periph.c    |  2 +-
 drivers/clk/tegra/clk-sdmmc-mux.c |  2 +-
 drivers/clk/tegra/clk-super.c     |  4 ++--
 include/linux/clk-provider.h      |  2 +-
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8de6a22498e7..fe42f56bfbdf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1711,15 +1711,19 @@ static int clk_fetch_parent_index(struct clk_core *core,
 /**
  * clk_hw_get_parent_index - return the index of the parent clock
  * @hw: clk_hw associated with the clk being consumed
+ * @parent: optional clk_hw of the parent to be fetched
  *
- * Fetches and returns the index of parent clock. Returns -EINVAL if the given
- * clock does not have a current parent.
+ * Fetches and returns the index of parent clock. If parent is not
+ * provided the parent of hw is used.
+ * Returns -EINVAL if the given clock does not have a current parent.
  */
-int clk_hw_get_parent_index(struct clk_hw *hw)
+int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent)
 {
-	struct clk_hw *parent = clk_hw_get_parent(hw);
+	/* With parent NULL get the current parent of hw */
+	if (!parent)
+		parent = clk_hw_get_parent(hw);
 
-	if (WARN_ON(parent == NULL))
+	if (WARN_ON(!parent))
 		return -EINVAL;
 
 	return clk_fetch_parent_index(hw->core, parent->core);
diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
index 79ca3aa072b7..0fecdbbaca8f 100644
--- a/drivers/clk/tegra/clk-periph.c
+++ b/drivers/clk/tegra/clk-periph.c
@@ -116,7 +116,7 @@ static void clk_periph_restore_context(struct clk_hw *hw)
 	struct clk_hw *div_hw = &periph->divider.hw;
 	int parent_id;
 
-	parent_id = clk_hw_get_parent_index(hw);
+	parent_id = clk_hw_get_parent_index(hw, NULL);
 	if (WARN_ON(parent_id < 0))
 		return;
 
diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
index 4f2c3309eea4..6013ca8444f4 100644
--- a/drivers/clk/tegra/clk-sdmmc-mux.c
+++ b/drivers/clk/tegra/clk-sdmmc-mux.c
@@ -210,7 +210,7 @@ static void clk_sdmmc_mux_restore_context(struct clk_hw *hw)
 	unsigned long rate = clk_hw_get_rate(hw);
 	int parent_id;
 
-	parent_id = clk_hw_get_parent_index(hw);
+	parent_id = clk_hw_get_parent_index(hw, NULL);
 	if (WARN_ON(parent_id < 0))
 		return;
 
diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
index a98a420398fa..27cbbc09ef68 100644
--- a/drivers/clk/tegra/clk-super.c
+++ b/drivers/clk/tegra/clk-super.c
@@ -128,7 +128,7 @@ static void clk_super_mux_restore_context(struct clk_hw *hw)
 {
 	int parent_id;
 
-	parent_id = clk_hw_get_parent_index(hw);
+	parent_id = clk_hw_get_parent_index(hw, NULL);
 	if (WARN_ON(parent_id < 0))
 		return;
 
@@ -180,7 +180,7 @@ static void clk_super_restore_context(struct clk_hw *hw)
 	struct clk_hw *div_hw = &super->frac_div.hw;
 	int parent_id;
 
-	parent_id = clk_hw_get_parent_index(hw);
+	parent_id = clk_hw_get_parent_index(hw, NULL);
 	if (WARN_ON(parent_id < 0))
 		return;
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 2faa6f7aa8a8..65b2850c09be 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1198,7 +1198,7 @@ unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
 					  unsigned int index);
-int clk_hw_get_parent_index(struct clk_hw *hw);
+int clk_hw_get_parent_index(struct clk_hw *hw, struct clk_hw *parent);
 int clk_hw_set_parent(struct clk_hw *hw, struct clk_hw *new_parent);
 unsigned int __clk_get_enable_count(struct clk *clk);
 unsigned long clk_hw_get_rate(const struct clk_hw *hw);
-- 
2.34.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3948F5E3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 09:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiAOIHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 03:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiAOIHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 03:07:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642BFC061574;
        Sat, 15 Jan 2022 00:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF10360B60;
        Sat, 15 Jan 2022 08:06:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03151C36AE5;
        Sat, 15 Jan 2022 08:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642234018;
        bh=MokbMad2MJK+phFQjho2Ga7EWL4pFI+qfkXz14J9DPQ=;
        h=From:To:Cc:Subject:Date:From;
        b=T1FEvPeThPOP7Y48nrGSuXcFwrTUt9vmirucTSkadq4gUMyoumhvrI2TrtzsXPOXi
         huBCy7oLwWPtVxQe0f7vs19J95+uyzU7z3jQMOG+/Kqb7Pus0jkMHCvIzeZKFienPv
         RRWMX67w7SlTBZffhKMcsLbq7dZmRI6cUNDSJWXsioxOn8ARN9NXhmVi0rhpaEZdgy
         FZr+lszbz2cVRsuVN/l43/pX2HdsclY57VBsVxT5+n0hcudk1y+F4budUeVGx6KDVJ
         pcTrAUeOEnDoPKzcAua0BWuhvVrtQeqNdLPjsKb0bUISHqQIzwaAEpHl9F6hC1in5I
         YBJb4j5bxyK5w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        kunit-dev@googlegroups.com
Subject: [PATCH] clk: gate: Add some kunit test suites
Date:   Sat, 15 Jan 2022 00:06:57 -0800
Message-Id: <20220115080657.2780989-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test various parts of the clk gate implementation with the kunit testing
framework.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Cc: <kunit-dev@googlegroups.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

This is a resend of the RFC[1] from almost two years ago! It will be
merged after the merge window closes.

[1] https://lore.kernel.org/r/20200408035637.110858-1-sboyd@kernel.org

 drivers/clk/Kconfig         |   8 +
 drivers/clk/Makefile        |   1 +
 drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
 3 files changed, 490 insertions(+)
 create mode 100644 drivers/clk/clk-gate-test.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c5b3dc97396a..41e560249370 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -421,4 +421,12 @@ source "drivers/clk/x86/Kconfig"
 source "drivers/clk/xilinx/Kconfig"
 source "drivers/clk/zynqmp/Kconfig"
 
+# Kunit test cases
+config CLK_GATE_TEST
+	tristate "Basic gate type Kunit test"
+	depends on KUNIT
+	default KUNIT
+	help
+	  Kunit test for the basic clk gate type.
+
 endif
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e42312121e51..dcdb75712940 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-divider.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-factor.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-fixed-rate.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-gate.o
+obj-$(CONFIG_CLK_GATE_TEST)	+= clk-gate-test.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-multiplier.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-mux.o
 obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
diff --git a/drivers/clk/clk-gate-test.c b/drivers/clk/clk-gate-test.c
new file mode 100644
index 000000000000..b499c2ffa815
--- /dev/null
+++ b/drivers/clk/clk-gate-test.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kunit test for clk gate basic type
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include <kunit/test.h>
+
+static void clk_gate_register_test_dev(struct kunit *test)
+{
+	struct clk_hw *ret;
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_simple("test_gate_device", -1, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
+
+	ret = clk_hw_register_gate(&pdev->dev, "test_gate", NULL, 0, NULL,
+				   0, 0, NULL);
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_STREQ(test, "test_gate", clk_hw_get_name(ret));
+	KUNIT_EXPECT_EQ(test, 0UL, clk_hw_get_flags(ret));
+
+	clk_hw_unregister_gate(ret);
+	platform_device_put(pdev);
+}
+
+static void clk_gate_register_test_parent_names(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ret = clk_hw_register_gate(NULL, "test_gate", "test_parent", 0, NULL,
+				   0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_data(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+	struct clk_parent_data pdata = { };
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	pdata.hw = parent;
+
+	ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
+					       NULL, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_data_legacy(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+	struct clk_parent_data pdata = { };
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+	pdata.name = "test_parent";
+
+	ret = clk_hw_register_gate_parent_data(NULL, "test_gate", &pdata, 0,
+					       NULL, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_parent_hw(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *ret;
+
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    1000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ret = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0, NULL,
+					     0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ret);
+	KUNIT_EXPECT_PTR_EQ(test, parent, clk_hw_get_parent(ret));
+
+	clk_hw_unregister_gate(ret);
+	clk_hw_unregister_fixed_rate(parent);
+}
+
+static void clk_gate_register_test_hiword_invalid(struct kunit *test)
+{
+	struct clk_hw *ret;
+
+	ret = clk_hw_register_gate(NULL, "test_gate", NULL, 0, NULL,
+				   20, CLK_GATE_HIWORD_MASK, NULL);
+
+	KUNIT_EXPECT_TRUE(test, IS_ERR(ret));
+}
+
+static struct kunit_case clk_gate_register_test_cases[] = {
+	KUNIT_CASE(clk_gate_register_test_dev),
+	KUNIT_CASE(clk_gate_register_test_parent_names),
+	KUNIT_CASE(clk_gate_register_test_parent_data),
+	KUNIT_CASE(clk_gate_register_test_parent_data_legacy),
+	KUNIT_CASE(clk_gate_register_test_parent_hw),
+	KUNIT_CASE(clk_gate_register_test_hiword_invalid),
+	{}
+};
+
+static struct kunit_suite clk_gate_register_test_suite = {
+	.name = "clk-gate-register-test",
+	.test_cases = clk_gate_register_test_cases,
+};
+
+struct clk_gate_test_context {
+	void __iomem *fake_mem;
+	struct clk_hw *hw;
+	struct clk_hw *parent;
+	u32 fake_reg; /* Keep at end, KASAN can detect out of bounds */
+};
+
+static struct clk_gate_test_context *clk_gate_test_alloc_ctx(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx;
+
+	test->priv = ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	ctx->fake_mem = (void __force __iomem *)&ctx->fake_reg;
+
+	return ctx;
+}
+
+static void clk_gate_test_parent_rate(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	unsigned long prate = clk_hw_get_rate(parent);
+	unsigned long rate = clk_hw_get_rate(hw);
+
+	KUNIT_EXPECT_EQ(test, prate, rate);
+}
+
+static void clk_gate_test_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(5);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(5);
+	u32 disable_val = 0;
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_cases[] = {
+	KUNIT_CASE(clk_gate_test_parent_rate),
+	KUNIT_CASE(clk_gate_test_enable),
+	KUNIT_CASE(clk_gate_test_disable),
+	{}
+};
+
+static int clk_gate_test_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 5, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static void clk_gate_test_exit(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+
+	clk_hw_unregister_gate(ctx->hw);
+	clk_hw_unregister_fixed_rate(ctx->parent);
+	kfree(ctx);
+}
+
+static struct kunit_suite clk_gate_test_suite = {
+	.name = "clk-gate-test",
+	.init = clk_gate_test_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_cases,
+};
+
+static void clk_gate_test_invert_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = 0;
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_invert_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = 0;
+	u32 disable_val = BIT(15);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_invert_cases[] = {
+	KUNIT_CASE(clk_gate_test_invert_enable),
+	KUNIT_CASE(clk_gate_test_invert_disable),
+	{}
+};
+
+static int clk_gate_test_invert_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	ctx->fake_reg = BIT(15); /* Default to off */
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 15,
+					    CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static struct kunit_suite clk_gate_test_invert_suite = {
+	.name = "clk-gate-invert-test",
+	.init = clk_gate_test_invert_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_invert_cases,
+};
+
+static void clk_gate_test_hiword_enable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(9) | BIT(9 + 16);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, enable_val, ctx->fake_reg);
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_TRUE(test, clk_hw_is_prepared(parent));
+}
+
+static void clk_gate_test_hiword_disable(struct kunit *test)
+{
+	struct clk_gate_test_context *ctx = test->priv;
+	struct clk_hw *parent = ctx->parent;
+	struct clk_hw *hw = ctx->hw;
+	struct clk *clk = hw->clk;
+	int ret;
+	u32 enable_val = BIT(9) | BIT(9 + 16);
+	u32 disable_val = BIT(9 + 16);
+
+	ret = clk_prepare_enable(clk);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	KUNIT_ASSERT_EQ(test, enable_val, ctx->fake_reg);
+
+	clk_disable_unprepare(clk);
+	KUNIT_EXPECT_EQ(test, disable_val, ctx->fake_reg);
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(hw));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_enabled(parent));
+	KUNIT_EXPECT_FALSE(test, clk_hw_is_prepared(parent));
+}
+
+static struct kunit_case clk_gate_test_hiword_cases[] = {
+	KUNIT_CASE(clk_gate_test_hiword_enable),
+	KUNIT_CASE(clk_gate_test_hiword_disable),
+	{}
+};
+
+static int clk_gate_test_hiword_init(struct kunit *test)
+{
+	struct clk_hw *parent;
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	parent = clk_hw_register_fixed_rate(NULL, "test_parent", NULL, 0,
+					    2000000);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	hw = clk_hw_register_gate_parent_hw(NULL, "test_gate", parent, 0,
+					    ctx->fake_mem, 9,
+					    CLK_GATE_HIWORD_MASK, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+
+	ctx->hw = hw;
+	ctx->parent = parent;
+
+	return 0;
+}
+
+static struct kunit_suite clk_gate_test_hiword_suite = {
+	.name = "clk-gate-hiword-test",
+	.init = clk_gate_test_hiword_init,
+	.exit = clk_gate_test_exit,
+	.test_cases = clk_gate_test_hiword_cases,
+};
+
+static void clk_gate_test_is_enabled(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(7);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
+				  0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_disabled(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(4);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 7,
+				  0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_enabled_inverted(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(31);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 2,
+				  CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_TRUE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static void clk_gate_test_is_disabled_inverted(struct kunit *test)
+{
+	struct clk_hw *hw;
+	struct clk_gate_test_context *ctx;
+
+	ctx = clk_gate_test_alloc_ctx(test);
+	ctx->fake_reg = BIT(29);
+	hw = clk_hw_register_gate(NULL, "test_gate", NULL, 0, ctx->fake_mem, 29,
+				  CLK_GATE_SET_TO_DISABLE, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hw);
+	KUNIT_ASSERT_FALSE(test, clk_hw_is_enabled(hw));
+
+	clk_hw_unregister_gate(hw);
+	kfree(ctx);
+}
+
+static struct kunit_case clk_gate_test_enabled_cases[] = {
+	KUNIT_CASE(clk_gate_test_is_enabled),
+	KUNIT_CASE(clk_gate_test_is_disabled),
+	KUNIT_CASE(clk_gate_test_is_enabled_inverted),
+	KUNIT_CASE(clk_gate_test_is_disabled_inverted),
+	{}
+};
+
+static struct kunit_suite clk_gate_test_enabled_suite = {
+	.name = "clk-gate-is_enabled-test",
+	.test_cases = clk_gate_test_enabled_cases,
+};
+
+kunit_test_suites(
+	&clk_gate_register_test_suite,
+	&clk_gate_test_suite,
+	&clk_gate_test_invert_suite,
+	&clk_gate_test_hiword_suite,
+	&clk_gate_test_enabled_suite
+);
+MODULE_LICENSE("GPL v2");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


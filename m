Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BE570864
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiGKQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiGKQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:30:51 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768C4198C;
        Mon, 11 Jul 2022 09:30:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B4D1CE157F;
        Mon, 11 Jul 2022 16:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE84C34115;
        Mon, 11 Jul 2022 16:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657557046;
        bh=7ys5DT5LCo4Aok86zE8TUi4FZO1ZJabIQ/9L+8kOfnA=;
        h=From:To:Cc:Subject:Date:From;
        b=B5nvxvLkr5analne4pcAsLvy47vA10xyIdIuXIaeYQ8DMr63M8PTcGl+P31+cl0JF
         ZGH0J6ZJUpsk+Jh3kf8Pvg2X/wuMWFt4ypm5s/+U4UAVOU1sEtlRcZAhy2zLRMmFqy
         J/M4aNdWOw7GmhlS6WrTzXbIoJr5P5xxgy1pFd+k3aO+ondwbDghSI0TQL8vzJAKpb
         o1gSEVGOZevToclf+pvCJMc/Yk9vhO6vjcrMe8S4ldfcHkjOYblbUAr3TprIem5T4J
         mT4ukJq3M1aDDK6xQ7corz6dbtaFM2MUi23GWH3AC5q5z6otAFX+LW2A1zsacgVBn2
         Fa6lso6NwmHCA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: qcom: gpucc-sm8350: Fix "initializer element is not constant" error
Date:   Mon, 11 Jul 2022 09:30:21 -0700
Message-Id: <20220711163021.152578-1-nathan@kernel.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with clang or GCC older than 8, errors along the following
lines occur:

  drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
          gpu_cc_parent,
          ^~~~~~~~~~~~~
  drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
          gpu_cc_parent,
          ^~~~~~~~~~~~~
  2 errors generated.

The C standard allows an implementation to accept other forms of
constant expressions, which GCC 8+ has chosen to do, but it is not
required. To fix this error with clang and older supported versions of
GCC, use a macro so that the expression can be used in a designated
initializer.

Fixes: 160758b05ab1 ("clk: qcom: add support for SM8350 GPUCC")
Link: https://github.com/ClangBuiltLinux/linux/issues/1660
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/clk/qcom/gpucc-sm8350.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
index d13fa813d190..9390723f6e40 100644
--- a/drivers/clk/qcom/gpucc-sm8350.c
+++ b/drivers/clk/qcom/gpucc-sm8350.c
@@ -51,9 +51,9 @@ static const struct alpha_pll_config gpu_cc_pll0_config = {
 	.user_ctl_hi1_val = 0x00000000,
 };
 
-static const struct clk_parent_data gpu_cc_parent = {
-	.fw_name = "bi_tcxo",
-};
+#define GPU_CC_PARENT_INIT { .fw_name = "bi_txco", }
+
+static const struct clk_parent_data gpu_cc_parent = GPU_CC_PARENT_INIT;
 
 static struct clk_alpha_pll gpu_cc_pll0 = {
 	.offset = 0x0,
@@ -108,7 +108,7 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_0[] = {
-	gpu_cc_parent,
+	GPU_CC_PARENT_INIT,
 	{ .hw = &gpu_cc_pll0.clkr.hw },
 	{ .hw = &gpu_cc_pll1.clkr.hw },
 	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
@@ -123,7 +123,7 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
 };
 
 static const struct clk_parent_data gpu_cc_parent_data_1[] = {
-	gpu_cc_parent,
+	GPU_CC_PARENT_INIT,
 	{ .hw = &gpu_cc_pll1.clkr.hw },
 	{ .fw_name = "gcc_gpu_gpll0_clk_src" },
 	{ .fw_name = "gcc_gpu_gpll0_div_clk_src" },

base-commit: 0dd8e16bfbc003b009f843e75fae4046daa08fe9
-- 
2.37.0


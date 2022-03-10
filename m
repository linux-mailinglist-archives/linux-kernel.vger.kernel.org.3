Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B294D4054
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 05:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbiCJEcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 23:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiCJEcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:32:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BBB12D09F;
        Wed,  9 Mar 2022 20:31:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D65C1B81E9E;
        Thu, 10 Mar 2022 04:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D606C340E8;
        Thu, 10 Mar 2022 04:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646886673;
        bh=QvaTFHdvRQC6vhnCGhCNGbUG5lOmJT7AvT1dhysnGyQ=;
        h=From:To:Cc:Subject:Date:From;
        b=jA10JuuNv8bWswK/CZ3q+5fWdDgVi1Ul0vQNeqgOK/frmB7PXAMhyY5ZCf8AFGW2P
         4IjJ4iXdMHYhkj4iCHuYm9VtlOCufSU2d1ufwQzP1F3pgR7Qo/zQIa1yJAN2eHlGX7
         Vvs1oOo4f1Ktnvxs7R5DLgcCCLDRfRir/lPV3I6lylBB9ChpnCFHe7kDM+GhRHpyoL
         j95Hd2FkDN+2HJJc73P84sCq8CUAIHGclUBPH54uSAzzUCs/34ZE2ndxsp+atJAa0Y
         3L1bskVocMyPP6fHrReMHc0wQvToGvj6s/cYVHkTL/IrHhb6JQyhKvJxVBWCgkrun2
         Pz+IgucgKZAJw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.17-rc7
Date:   Wed,  9 Mar 2022 20:31:12 -0800
Message-Id: <20220310043112.3908132-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2f0754f27a230fee6e6d753f07585cee03bedfe3:

  clk: jz4725b: fix mmc0 clock gating (2022-02-17 17:05:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to aa091a6a91df395a0fa00a808a543301ec99e734:

  clk: lan966x: Fix linking error (2022-02-24 16:53:24 -0800)

----------------------------------------------------------------
One more small batch of clk driver fixes

 - A fix for the Qualcomm GDSC power domain delays that
   avoids black screens at boot on some more recent SoCs
   that use a different delay than the hard-coded delays
   in the driver.

 - A build fix LAN966X clk driver that let it be built
   on architectures that didn't have IOMEM.

----------------------------------------------------------------
Horatiu Vultur (1):
      clk: lan966x: Fix linking error

Taniya Das (2):
      clk: qcom: gdsc: Add support to update GDSC transition delay
      clk: qcom: dispcc: Update the transition delay for MDSS GDSC

 drivers/clk/Kconfig              |  2 ++
 drivers/clk/qcom/dispcc-sc7180.c |  5 ++++-
 drivers/clk/qcom/dispcc-sc7280.c |  5 ++++-
 drivers/clk/qcom/dispcc-sm8250.c |  5 ++++-
 drivers/clk/qcom/gdsc.c          | 26 +++++++++++++++++++++-----
 drivers/clk/qcom/gdsc.h          |  8 +++++++-
 6 files changed, 42 insertions(+), 9 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

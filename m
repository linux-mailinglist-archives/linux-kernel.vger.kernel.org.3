Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE314710F8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 03:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhLKCcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 21:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbhLKCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 21:32:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD73C061714;
        Fri, 10 Dec 2021 18:29:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6F94CE2DDA;
        Sat, 11 Dec 2021 02:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1BFC341C8;
        Sat, 11 Dec 2021 02:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639189752;
        bh=rwVs29kzBD5mlMpJeBeHYII9ZNlchTWq4SlsojX3yEA=;
        h=From:To:Cc:Subject:Date:From;
        b=elFzdEzl+SoORCOC/hsOBkjC/Mu9rE6aV4Tybloo1ST+7RclpUAemqvuf8KBv1gnC
         oQllg8pPdE8Wdg5GCSY8pTPLfvh/jCMR7GQnhAeRY/ZGV05Lk6fICEr25Z7FbmTdvi
         cAEikPWfIrplwuwepAewMjwoaux2lwmrKTc6usv2FzbANvV41Ra0RIFDfSKJcxCB1p
         LZO0LBfR+6FhBDx4HbHSCSIhijauRR+Qt15/xc0hv+VHLwZBjdk1kjpH3PnCnEssJm
         rKDwoDzP11Mp0zlhDZBKCY0EuPOBDOCfIjn5EYccWnsy6v+Mer8vIJzMryMiziQrAj
         Qq1tghzCqesBA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.16-rc4
Date:   Fri, 10 Dec 2021 18:29:11 -0800
Message-Id: <20211211022912.3311440-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 2d4fcc5ab35fac2e995f497d62439dcbb416babc:

  clk: versatile: clk-icst: use after free on error path (2021-12-07 12:25:29 -0800)

----------------------------------------------------------------
Here's a collection of clk driver fixes.

 - Fix qcom mux logic to look at the proper parent table member.
   Luckily this clk type isn't very common.

 - Don't kill clks on qcom systems that use Trion PLLs that are
   enabled out of the bootloader. We will simply skip programming
   the PLL rate if it's already done.

 - Use the proper clk_ops for the qcom sm6125 ICE clks.

 - Use module_platform_driver() in i.MX as it can be a module.

 - Fix a UAF in the versatile clk driver on an error path.

----------------------------------------------------------------
Bjorn Andersson (1):
      clk: qcom: clk-alpha-pll: Don't reconfigure running Trion

Dan Carpenter (1):
      clk: versatile: clk-icst: use after free on error path

Dmitry Baryshkov (1):
      clk: qcom: regmap-mux: fix parent clock lookup

Martin Botka (1):
      clk: qcom: sm6125-gcc: Swap ops of ice and apps on sdcc1

Miles Chen (1):
      clk: imx: use module_platform_driver

 drivers/clk/imx/clk-imx8qxp-lpcg.c |  2 +-
 drivers/clk/imx/clk-imx8qxp.c      |  2 +-
 drivers/clk/qcom/clk-alpha-pll.c   |  9 +++++++++
 drivers/clk/qcom/clk-regmap-mux.c  |  2 +-
 drivers/clk/qcom/common.c          | 12 ++++++++++++
 drivers/clk/qcom/common.h          |  2 ++
 drivers/clk/qcom/gcc-sm6125.c      |  4 ++--
 drivers/clk/versatile/clk-icst.c   |  2 +-
 8 files changed, 29 insertions(+), 6 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7830D5ABD1B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 07:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiICFBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 01:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiICFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 01:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92136E833A;
        Fri,  2 Sep 2022 22:01:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D02F61158;
        Sat,  3 Sep 2022 05:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE12AC433D6;
        Sat,  3 Sep 2022 05:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662181287;
        bh=fFBOexKUsV4kkTj1uk/BuRIUwzySFWNuOf+j1u9TAYs=;
        h=From:To:Cc:Subject:Date:From;
        b=khTk5VVC7WiAFACQMh7oBmy2raAnkrQdncQ+Yg+Jl72CXENWDO+OVrHXCCI8w7kYe
         zR5nTt8w57O6iddAZg/OVj3EW/aa9JmWuAVJ33YojCuDAHKz/fayu2jqbeF0uMtuG2
         lDOIl4OLn0ttSEtH84s0TWBu66g5ohMK9LD1vJl+jk9CeopOvXyOM/uIux+R8Z2Ix2
         sFS7OYJK+BFpCraj03/L+ltSF4pb/vLBflqajeeAwQ1YRpOnf9w/MSnsbp760o5WB7
         YgD7VJG5I5pyEysiv7mzkrSQ6QLUg+O+ClufJN4vYKbNGkrXrA9gW55oVzdKw5RI2Z
         jFywqePkQwKDA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.0-rc3
Date:   Fri,  2 Sep 2022 22:01:25 -0700
Message-Id: <20220903050126.2767493-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to abb5f3f4b1f5f0ad50eb067a00051d3587dec9fb:

  Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops" (2022-08-31 12:06:46 -0700)

----------------------------------------------------------------
Here's a collection of primarily clk driver fixes, with a couple fixes
to the core framework. We had to revert out a commit that affected boot
on some devices that have the CLK_OPS_PARENT_ENABLE flag set. It isn't
critical to have that fix so we'll try again next time.

Driver side fixes include:

 - Plug an of node refcount bug in the TI clk driver

 - Fix the error handling in the raspberry pi firmware get_rate
   so that errors don't look like valid frequencies

 - Avoid going out of bounds in the raspberry pi driver too if the
   video firmware returns something we're not expecting

----------------------------------------------------------------
Chen-Yu Tsai (2):
      clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
      clk: core: Fix runtime PM sequence in clk_core_unprepare()

Stefan Wahren (4):
      clk: bcm: rpi: Fix error handling of raspberrypi_fw_get_rate
      clk: bcm: rpi: Prevent out-of-bounds access
      clk: bcm: rpi: Add missing newline
      clk: bcm: rpi: Show clock id limit in error case

Stephen Boyd (1):
      Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops"

Tony Lindgren (1):
      clk: ti: Fix missing of_node_get() ti_find_clock_provider()

 drivers/clk/bcm/clk-raspberrypi.c | 16 +++++++++++-----
 drivers/clk/clk.c                 |  3 +--
 drivers/clk/ti/clk.c              |  1 +
 3 files changed, 13 insertions(+), 7 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

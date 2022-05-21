Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7152F8CD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 07:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354534AbiEUFAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 01:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354515AbiEUFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 01:00:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1D5179C1A;
        Fri, 20 May 2022 22:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D8E9B82DC1;
        Sat, 21 May 2022 05:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C8C385A5;
        Sat, 21 May 2022 05:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653109227;
        bh=mA2P05gweCVfV9yQkQJHdjy+EqVdPxdGnSgo+YnUgbs=;
        h=From:To:Cc:Subject:Date:From;
        b=lar6/CFS4ONBR2UAiSi54gj+kCL4bMS7q9YigvrBY2vHyDMcUp39e9eQa66iq/7Jh
         V9ZYLn/QvMRdULklySh5Sz81nf+W6ekOpF6q2KoKAeN9Z5z9zmMrCyg6G+DvCwPKUV
         T4v3B2j0YFXynuBmv/gAAgYBSI7uFMn4ufmKQD0HGMcFw4Hfe6JhKUPqgQf+8pPhzR
         +t7OfwYcT7OKTlkFDC4qDeWM4fZuR8XyNX33LmEeASFskJ5yB9iqveOGMysqX8taVm
         Tf51VeJVVDz/avAKSxaqZP2c4l7vt055qem3/HHR2zBbosIyFN17k27jZlQ9tbSP5M
         C6Fa4xXjPUmeA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.18-rc7
Date:   Fri, 20 May 2022 22:00:26 -0700
Message-Id: <20220521050026.2534728-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
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

The following changes since commit a91b05f6b928e8fab750fc953d7df0aa6dc43547:

  Merge tag 'sunxi-clk-fixes-for-5.18-2' of https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into clk-fixes (2022-04-25 16:47:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to d0031e6fbed955ff8d5f5bbc8fe7382482559cec:

  clk: at91: generated: consider range when calculating best rate (2022-05-17 12:41:07 -0700)

----------------------------------------------------------------
Three clk driver fixes to close out the release

 - Fix a divider calculation brekaing boot on Broadcom bcm2835

 - Fix HDMI output on Tanix TX6 mini board by reverting a patch

 - Fix clk_set_rate_range() calls on at91 by considering the range
   while calculating the divisor

----------------------------------------------------------------
Codrin Ciubotariu (1):
      clk: at91: generated: consider range when calculating best rate

Jernej Skrabec (1):
      Revert "clk: sunxi-ng: sun6i-rtc: Add support for H6"

Stefan Wahren (1):
      clk: bcm2835: fix bcm2835_clock_choose_div

 drivers/clk/at91/clk-generated.c     |  4 ++++
 drivers/clk/bcm/clk-bcm2835.c        |  1 +
 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c | 15 ---------------
 drivers/rtc/rtc-sun6i.c              | 17 +++++++++++++++++
 4 files changed, 22 insertions(+), 15 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

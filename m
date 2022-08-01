Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1368B586B35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiHAMrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiHAMq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBB8BCA2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D27661176
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82E9C433D6;
        Mon,  1 Aug 2022 12:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357478;
        bh=B0zmon3+6pgQcGh5p86krRiiw/IqUKvcIuyfjb97Lns=;
        h=From:To:Cc:Subject:Date:From;
        b=fEWhn+yGMGXoRmfqL/5MAbfLpqxtS4GW4VKn6acZmNMnXKfeI2llSLVvRVmZEoW1g
         o2m2O9HiI0p/SDz4bdqDW8cqG08FLTtyZfpuxfFcvufEjXGE1fwzOTbS42ZrliDCOz
         MIQ3jX6bB3VEK+pivOIn/UUnpgK7bEDEZCHFe6GFEmWGad1diL1YS6PACJ62BBhnLM
         YTbDAkq7cKvQlRA8o+6OfkY6XaE3IrtsbQ2BMRKHqamrv32GJAcU8IaerohuTrM8xF
         s7vMus7dditpW9VDP4mGXtJJiiRZ5l6sUSDExBnkGySFmVswRUqKUErIsqhWiPjExr
         m9v3hGyaLzjOA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.20
Date:   Mon, 01 Aug 2022 13:37:40 +0100
Message-Id: <20220801123757.A82E9C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3f05010f243be06478a9b11cfce0ce994f5a0890:

  regmap-irq: Fix offset/index mismatch in read_sub_irq_data() (2022-06-22 11:59:52 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.20

for you to fetch changes up to 739f872e48d47c97fa17a86a7b3356771b75240c:

  regmap: permit to set reg_update_bits with bulk implementation (2022-07-18 13:45:28 +0100)

----------------------------------------------------------------
regmap: Updates for v5.20

The big thing this release is a big cleanup of the interrupt code from
Aidan MacDonald, plus a few new API updates:

 - Rework of the interrupt code, making it much simpler and easier to
   extend.
 - Support for device specific update bits operations with devices that
   otherwise use bitstream interfaces.
 - Support for bit operations on fields as well as whole registers.

----------------------------------------------------------------
Aidan MacDonald (13):
      regmap-irq: Convert bool bitfields to unsigned int
      regmap-irq: Remove unused type_reg_stride field
      regmap-irq: Cleanup sizeof(...) use in memory allocation
      regmap-irq: Remove an unnecessary restriction on type_in_mask
      regmap-irq: Remove inappropriate uses of regmap_irq_update_bits()
      regmap-irq: Remove mask_writeonly and regmap_irq_update_bits()
      regmap-irq: Refactor checks for status bulk read support
      regmap-irq: Introduce config registers for irq types
      regmap-irq: Deprecate type registers and virtual registers
      regmap-irq: Fix inverted handling of unmask registers
      regmap-irq: Add get_irq_reg() callback
      regmap-irq: Deprecate the not_fixed_stride flag
      regmap-irq: Fix bug in regmap_irq_get_irq_reg_linear()

Christian Marangi (1):
      regmap: permit to set reg_update_bits with bulk implementation

Li Chen (1):
      regmap: provide regmap_field helpers for simple bit operations

Mark Brown (4):
      Merge tag 'regmap-field-bit-helpers' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap into regmap-5.20
      regmap: Don't warn about cache only mode for devices with no cache
      regmap: Merge up fixes
      regmap-irq cleanups and refactoring

Matt Ranostay (1):
      regmap: add WARN_ONCE when invalid mask is provided to regmap_field_init()

Schspa Shi (1):
      regmap: cache: Add extra parameter check in regcache_init

Xiang wangx (1):
      regmap: cache: Fix syntax errors in comments

 drivers/base/regmap/regcache.c   |  11 +-
 drivers/base/regmap/regmap-irq.c | 432 ++++++++++++++++++++++++++-------------
 drivers/base/regmap/regmap.c     |  27 +++
 include/linux/regmap.h           | 141 ++++++++++---
 4 files changed, 440 insertions(+), 171 deletions(-)

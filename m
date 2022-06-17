Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC89E54FCF1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiFQSfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 14:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiFQSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 14:35:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14CD33A1D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 11:35:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E60A61F77
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 18:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0A3C3411B;
        Fri, 17 Jun 2022 18:35:26 +0000 (UTC)
Date:   Fri, 17 Jun 2022 19:35:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 5.19-rc3/rc4
Message-ID: <YqzJa4UPCNQg2pAR@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below (they can wait until -rc4 if
travelling). Thanks.

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to c50f11c6196f45c92ca48b16a5071615d4ae0572:

  arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer (2022-06-17 19:06:06 +0100)

----------------------------------------------------------------
arm64 fixes for 5.19-rc3:

- Revert the moving of the jump labels initialisation before
  setup_machine_fdt(). The bug was fixed in drivers/char/random.c.

- Ftrace fixes: branch range check and consistent handling of PLTs.

- Clean rather than invalidate FROM_DEVICE buffers at start of DMA
  transfer (safer if such buffer is mapped in user space). A cache
  invalidation is done already at the end of the transfer.

- A couple of clean-ups (unexport symbol, remove unused label).

----------------------------------------------------------------
Catalin Marinas (1):
      Revert "arm64: Initialize jump labels before setup_machine_fdt()"

Mark Brown (1):
      arm64/cpufeature: Unexport set_cpu_feature()

Mark Rutland (3):
      arm64: ftrace: fix branch range checks
      arm64: ftrace: consistently handle PLTs.
      arm64: ftrace: remove redundant label

Will Deacon (1):
      arm64: mm: Don't invalidate FROM_DEVICE buffers at start of DMA transfer

 arch/arm64/kernel/cpufeature.c   |   1 -
 arch/arm64/kernel/entry-ftrace.S |   1 -
 arch/arm64/kernel/ftrace.c       | 137 +++++++++++++++++++--------------------
 arch/arm64/kernel/setup.c        |   7 +-
 arch/arm64/mm/cache.S            |   2 -
 5 files changed, 69 insertions(+), 79 deletions(-)

-- 
Catalin

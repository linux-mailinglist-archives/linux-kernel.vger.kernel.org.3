Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AD74F9A98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 18:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiDHQbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiDHQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 12:31:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E881A3A105A
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 09:29:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76B71B82C01
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04095C385A3;
        Fri,  8 Apr 2022 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649435346;
        bh=x4dhjkETefwHzF0BSywC1YGUzOvL3hMJFwITeWy3G/I=;
        h=Date:From:To:Cc:Subject:From;
        b=fMawvy6u03JUiIIegIcQuh61EsdNHKerclvCiSe4VNxU7Z8tU4NKLVCTGes24sPJu
         tvh6bPCkeykF0E5GmzsGuWWLLi6R1Ue5Olu70wQ63ptqh4td7LHJgV1M2uS7op66Xw
         7WUApIV1uYAJRBJ9QZ7hNdo5dO22jY3f3nkQCzk2MqBl5XeVi1tY+CSVrkA5Fiyj47
         ZEHizvy5/FxX9Df4lmhFhBKuQpXORmX0ODJpDyrqJP5no21ceBnE2DRh31Sm+g7jCx
         qoIqXg5fmkhL4SlK/xG5O5gfPPxcpt2cGSObToVDVC/h0S7cdt+iw6NrO0q4If6wLh
         NSvmxliWVXadw==
Date:   Fri, 8 Apr 2022 17:29:00 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc2
Message-ID: <20220408162900.GC28108@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc2. The usual summary is in the tag,
but the two main things to note are:

  (1) The bulk of the diffstat is us reverting a horrible bodge we had
      in place to ease the merging of maple tree during the merge window
      (which turned out not to be needed, but anyway)

  (2) The TLB invalidation fix is done in core code, as suggested by
      (and Acked-by) Peter.

Cheers,

Will

--->8

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to d02b4dd84e1a90f7f1444d027c0289bf355b0d5a:

  perf/imx_ddr: Fix undefined behavior due to shift overflowing the constant (2022-04-08 14:17:57 +0100)

----------------------------------------------------------------
arm64 fixes for -rc2

- Revert temporary bodge in MTE coredumping to ease maple tree integration

- Fix stack frame size warning reported with 64k pages

- Fix stop_machine() race with instruction text patching

- Ensure alternatives patching routines are not instrumented

- Enable Spectre-BHB mitigation for Cortex-A78AE

- Fix hugetlb TLB invalidation when contiguous hint is used

- Minor perf driver fixes

- Fix some typos

----------------------------------------------------------------
Borislav Petkov (1):
      perf/imx_ddr: Fix undefined behavior due to shift overflowing the constant

Catalin Marinas (1):
      arm64: mte: Fix the stack frame size warning in mte_dump_tag_range()

Chanho Park (1):
      arm64: Add part number for Arm Cortex-A78AE

Geert Uytterhoeven (1):
      perf: MARVELL_CN10K_DDR_PMU should depend on ARCH_THUNDER

Guo Ren (1):
      arm64: patch_text: Fixup last cpu should be master

Joey Gouly (1):
      arm64: alternatives: mark patch_alternative() as `noinstr`

Julia Lawall (1):
      arm64: fix typos in comments

Phil Auld (1):
      arch/arm64: Fix topology initialization for core scheduling

Steve Capper (1):
      tlb: hugetlb: Add more sizes to tlb_remove_huge_tlb_entry

Will Deacon (1):
      Revert "arm64: Change elfcore for_each_mte_vma() to use VMA iterator"

Xiaomeng Tong (1):
      perf: qcom_l2_pmu: fix an incorrect NULL check on list iterator

Zhiyuan Dai (1):
      arm64: Fix comments in macro __init_el2_gicv3

 arch/arm64/include/asm/cputype.h   |  2 ++
 arch/arm64/include/asm/el2_setup.h |  2 +-
 arch/arm64/kernel/alternative.c    |  6 ++---
 arch/arm64/kernel/elfcore.c        | 47 +++++++++++++++++++++-----------------
 arch/arm64/kernel/hw_breakpoint.c  |  2 +-
 arch/arm64/kernel/module-plts.c    |  2 +-
 arch/arm64/kernel/patching.c       |  4 ++--
 arch/arm64/kernel/proton-pack.c    |  1 +
 arch/arm64/kernel/smp.c            |  2 +-
 arch/arm64/kernel/suspend.c        |  2 +-
 arch/arm64/mm/init.c               |  4 ++--
 drivers/perf/Kconfig               |  2 +-
 drivers/perf/fsl_imx8_ddr_perf.c   |  2 +-
 drivers/perf/qcom_l2_pmu.c         |  6 ++---
 include/asm-generic/tlb.h          | 10 +++++---
 15 files changed, 53 insertions(+), 41 deletions(-)

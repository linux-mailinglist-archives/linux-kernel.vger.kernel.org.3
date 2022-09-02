Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2DC5AAD40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiIBLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235915AbiIBLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:12:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06CBCEB0B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:12:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59604B82A53
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 11:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1E9C433C1;
        Fri,  2 Sep 2022 11:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662117130;
        bh=/QVsmuyia5+3J+DfDubjMTWJVlKxzCNx6ax9d23OoFg=;
        h=Date:From:To:Cc:Subject:From;
        b=ZYfpC2CGyWQI6Ze09dVx2SYgZAcRtIIT4T3T4nTLST09EWuFf4GtZCRhIDSABoK/I
         5bIus93l7FMrjC/9zYtm+LnelsY/8FaNty080+hwkEv1Gh3jUy04tN5RHbDhqNZWrY
         HZUeYC60tX2rvfCdALS+RF6HyIDcNaagRgOllGGL8tPaigxY5+pADghf1GJPZ32q6c
         Df96EeysqHPf7f+JzonQB+tv8R81RZsSM5jLuRD2uc2MZk+Oqx0zY3aJ6rbQ/e1DzG
         Xijd4C/AvE0f5WvIkPNtrF5fmKMTInbrHoxsStiClXiBXR1Bcrln6Hk9nksqqEETMh
         iBOlttVzNuGog==
Date:   Fri, 2 Sep 2022 12:12:05 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc4
Message-ID: <20220902111204.GA25902@willie-the-truck>
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

Please pull these arm64 fixes for -rc4.

It's a lot smaller than last week, with the star of the show being a
couple of fixes to head.S addressing a boot regression introduced by the
recent overhaul of that code in non-default configurations (i.e. KASLR
disabled). The first of those two resolves the issue reported (and
bisected) by Mikulus in the wait_on_bit() thread.

Cheers,

Will

--->8

The following changes since commit 714f3cbd70a4db9f9b7fe5b8a032896ed33fb824:

  arm64/sme: Don't flush SVE register state when handling SME traps (2022-08-23 11:29:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 5fbc49cef91916140a305f22f7430e9a7ea0c6b4:

  arm64: mm: Reserve enough pages for the initial ID map (2022-09-01 12:02:39 +0100)

----------------------------------------------------------------
arm64 fixes for -rc4

- Fix two boot issues caused by the recent head.S rework when !KASLR

- Fix calculation of crashkernel memory reservation

- Fix bogus error check in PMU IRQ probing code

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: head: Ignore bogus KASLR displacement on non-relocatable kernels
      arm64: mm: Reserve enough pages for the initial ID map

Levi Yun (1):
      arm64/kexec: Fix missing extra range for crashkres_low.

Yu Zhe (1):
      perf/arm_pmu_platform: fix tests for platform_get_irq() failure

 arch/arm64/include/asm/kernel-pgtable.h | 26 +++++++++++++-------------
 arch/arm64/kernel/head.S                |  2 ++
 arch/arm64/kernel/machine_kexec_file.c  |  2 +-
 drivers/perf/arm_pmu_platform.c         |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

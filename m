Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B626F5A2DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbiHZR7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiHZR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:59:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D0E1ABC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCD2AB83210
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A8DC433D6;
        Fri, 26 Aug 2022 17:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661536743;
        bh=ML00VXZq74rLsWSCPX4qAUs7nJr27zkTJK9wwnNrUbE=;
        h=Date:From:To:Cc:Subject:From;
        b=n0YHMPnLk7UG56gX/qdLwzPEa70Y4IgWbTREGMm3zHRclNTr3of4ek0ZL0n1ICowK
         WPjwvomEi6DTN7QDnQS6QkVfl/mdkjzcavgBaJO24j1kW8u4F7n/geHGy15PvgkcNX
         L4w4ijS2dDOhlmSLgY50uY7cMdWrvgjWHLxXwESyTU8BCJQAOxTWZMduT31BC+GyoV
         OFtEIGLdCe7iQSRitdJwANCwsDLKKbve/DimVPx4P0PJYnV9Mpq9OQn60Z869iDcfo
         LsBh6UlOUPwPqP7knO7vCNkh9fnJwHqkjQ7iQvTsEdJWaauPNYhIXTAZ1at4TFdabU
         9Sip9ejz4KodQ==
Date:   Fri, 26 Aug 2022 18:58:58 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: [GIT PULL] arm64 fixes for -rc3
Message-ID: <20220826175857.GA20431@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Please pull this bumper crop of arm64 fixes for -rc3. The usual summary
is in the tag, but the largest change is fixing our parsing of the
'rodata=full' command line option, which kstrtobool() started treating
as 'rodata=false'. The fix actually makes the parsing of that option much
less fragile and updates the documentation at the same time.

We still have a boot issue pending when KASLR is disabled at compile time,
but there's a fresh fix on the list which I'll send next week if it holds
up to testing.

Cheers,

Will

--->8

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 714f3cbd70a4db9f9b7fe5b8a032896ed33fb824:

  arm64/sme: Don't flush SVE register state when handling SME traps (2022-08-23 11:29:12 +0100)

----------------------------------------------------------------
arm64 fixes for -rc3

- Fix workaround for Cortex-A76 erratum #1286807

- Add workaround for AMU erratum #2457168 on Cortex-A510

- Drop reference to removed CONFIG_ARCH_RANDOM #define

- Fix parsing of the "rodata=full" cmdline option

- Fix a bunch of issues in the SME register state switching and sigframe code

- Fix incorrect extraction of the CTR_EL0.CWG register field

- Fix ACPI cache topology probing when the PPTT is not present

- Trivial comment and whitespace fixes

----------------------------------------------------------------
Ionela Voinescu (1):
      arm64: errata: add detection for AMEVCNTR01 incrementing incorrectly

Kuan-Ying Lee (1):
      arm64: Fix comment typo

Lukas Bulwahn (1):
      arm64: adjust KASLR relocation after ARCH_RANDOM removal

Mark Brown (7):
      arm64/sysreg: Directly include bitfield.h
      arm64/sysreg: Guard SYS_FIELD_ macros for asm
      arm64/cache: Fix cache_type_cwg() for register generation
      arm64/signal: Raise limit on stack frames
      arm64/signal: Flush FPSIMD register state when disabling streaming mode
      arm64/sme: Don't flush SVE register state when allocating SME storage
      arm64/sme: Don't flush SVE register state when handling SME traps

Mark Rutland (1):
      arm64: fix rodata=full

Martin Liška (1):
      docs/arm64: elf_hwcaps: unify newlines in HWCAP lists

Sudeep Holla (1):
      arm64: cacheinfo: Fix incorrect assignment of signed error value to unsigned fw_level

Zenghui Yu (1):
      arm64: Fix match_list for erratum 1286807 on Arm Cortex-A76

 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 Documentation/arm64/elf_hwcaps.rst              | 10 --------
 Documentation/arm64/silicon-errata.rst          |  2 ++
 arch/arm64/Kconfig                              | 17 +++++++++++++
 arch/arm64/include/asm/cache.h                  |  2 +-
 arch/arm64/include/asm/fpsimd.h                 |  4 ++--
 arch/arm64/include/asm/setup.h                  | 17 +++++++++++++
 arch/arm64/include/asm/sysreg.h                 |  5 ++--
 arch/arm64/kernel/cacheinfo.c                   |  6 ++++-
 arch/arm64/kernel/cpu_errata.c                  | 12 ++++++++++
 arch/arm64/kernel/cpufeature.c                  |  5 +++-
 arch/arm64/kernel/entry.S                       |  2 +-
 arch/arm64/kernel/fpsimd.c                      | 21 +++++-----------
 arch/arm64/kernel/pi/kaslr_early.c              |  8 +++----
 arch/arm64/kernel/ptrace.c                      |  6 ++---
 arch/arm64/kernel/signal.c                      | 14 +++++++++--
 arch/arm64/kernel/topology.c                    | 32 +++++++++++++++++++++++--
 arch/arm64/mm/mmu.c                             | 18 --------------
 arch/arm64/tools/cpucaps                        |  1 +
 init/main.c                                     | 18 +++++++++++---
 20 files changed, 136 insertions(+), 66 deletions(-)

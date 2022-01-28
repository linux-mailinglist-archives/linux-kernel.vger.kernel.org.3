Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA254A00B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350801AbiA1TOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:14:35 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiA1TOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:14:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F38C61D33
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 19:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EDDC340E7;
        Fri, 28 Jan 2022 19:14:32 +0000 (UTC)
Date:   Fri, 28 Jan 2022 19:14:29 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org
Subject: [GIT PULL] arm64 fixes for 5.17-rc2
Message-ID: <YfRAlb4M0Su+iyow@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 297ae1eb23b04c5a46111ab53c8d0f69af43f402:

  arm64: cpufeature: List early Cortex-A510 parts as having broken dbm (2022-01-28 16:15:46 +0000)

----------------------------------------------------------------
arm64 fixes:

- Errata workarounds for Cortex-A510: broken hardware dirty bit
  management, detection code for the TRBE (tracing) bugs with the actual
  fixes going in via the CoreSight tree.

- Cortex-X2 errata handling for TRBE (inheriting the workarounds from
  Cortex-A710).

- Fix ex_handler_load_unaligned_zeropad() to use the correct struct
  members.

- A couple of kselftest fixes for FPSIMD.

- Silence the vdso "no previous prototype" warning.

- Mark start_backtrace() notrace and NOKPROBE_SYMBOL.

----------------------------------------------------------------
Anshuman Khandual (6):
      arm64: Add Cortex-X2 CPU part definition
      arm64: errata: Update ARM64_ERRATUM_[2119858|2224489] with Cortex-X2 ranges
      arm64: Add Cortex-A510 CPU part definition
      arm64: errata: Add detection for TRBE ignored system register writes
      arm64: errata: Add detection for TRBE invalid prohibited states
      arm64: errata: Add detection for TRBE trace data corruption

Catalin Marinas (1):
      Merge tag 'trbe-cortex-a510-errata' of gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux into for-next/fixes

Evgenii Stepanov (1):
      arm64: extable: fix load_unaligned_zeropad() reg indices

James Morse (1):
      arm64: cpufeature: List early Cortex-A510 parts as having broken dbm

Mark Brown (2):
      kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
      kselftest/arm64: Correct logging of FPSIMD register read via ptrace

Masami Hiramatsu (1):
      arm64: Mark start_backtrace() notrace and NOKPROBE_SYMBOL

Vincenzo Frascino (1):
      arm64: vdso: Fix "no previous prototype" warning

 Documentation/arm64/silicon-errata.rst        | 12 ++++
 arch/arm64/Kconfig                            | 81 +++++++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h              |  4 ++
 arch/arm64/kernel/cpu_errata.c                | 29 ++++++++++
 arch/arm64/kernel/cpufeature.c                |  3 +
 arch/arm64/kernel/stacktrace.c                |  5 +-
 arch/arm64/kernel/vdso/Makefile               |  5 +-
 arch/arm64/mm/extable.c                       |  4 +-
 arch/arm64/tools/cpucaps                      |  3 +
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 11 +++-
 10 files changed, 144 insertions(+), 13 deletions(-)

-- 
Catalin

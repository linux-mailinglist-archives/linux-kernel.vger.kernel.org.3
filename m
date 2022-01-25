Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0198049B648
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiAYO1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:27:39 -0500
Received: from foss.arm.com ([217.140.110.172]:46434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578691AbiAYOVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:21:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B8B1D6E;
        Tue, 25 Jan 2022 06:20:55 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.42.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA5313F793;
        Tue, 25 Jan 2022 06:20:50 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 RESEND 0/7] coresight: trbe: Workaround Cortex-A510 erratas
Date:   Tue, 25 Jan 2022 19:50:30 +0530
Message-Id: <1643120437-14352-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This series adds three different workarounds in the TRBE driver for
Cortex-A510 specific erratas. But first, this adds Cortex-A510 specific cpu
part number definition in the platform. This series applies on 5.17-rc1.

Relevant errata documents can be found here.

https://developer.arm.com/documentation/SDEN2397239/900
https://developer.arm.com/documentation/SDEN2397589/900

Changes in V3:

https://lore.kernel.org/all/1641872346-3270-1-git-send-email-anshuman.khandual@arm.com/

- Moved the comment inside trbe_needs_drain_after_disable()
- Moved the comment inside trbe_needs_ctxt_sync_after_enable()

Changes in V2:

https://lore.kernel.org/all/1641517808-5735-1-git-send-email-anshuman.khandual@arm.com/

Accommodated most review comments from the previous version.

- Split all patches into CPU errata definition, detection and TRBE workarounds
- s/TRBE_WORKAROUND_SYSREG_WRITE_FAILURE/TRBE_NEEDS_DRAIN_AFTER_DISABLE
- s/TRBE_WORKAROUND_CORRUPTION_WITH_ENABLE/TRBE_NEEDS_CTXT_SYNC_AFTER_ENABLE
- s/trbe_may_fail_sysreg_write()/trbe_needs_drain_after_disable()
- s/trbe_may_corrupt_with_enable()/trbe_needs_ctxt_sync_after_enable()
- Updated Kconfig help message for config ARM64_ERRATUM_1902691
- Updated error message for trbe_is_broken() detection
- Added new trblimitr parameter to set_trbe_enabled(), improving performance
- Added COMPILE_TEST dependency in the errata, until TRBE part is available

Changes in V1:

https://lore.kernel.org/lkml/1641359159-22726-1-git-send-email-anshuman.khandual@arm.com/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (7):
  arm64: Add Cortex-A510 CPU part definition
  arm64: errata: Add detection for TRBE ignored system register writes
  arm64: errata: Add detection for TRBE invalid prohibited states
  arm64: errata: Add detection for TRBE trace data corruption
  coresight: trbe: Work around the ignored system register writes
  coresight: trbe: Work around the invalid prohibited states
  coresight: trbe: Work around the trace data corruption

 Documentation/arm64/silicon-errata.rst       |   6 +
 arch/arm64/Kconfig                           |  59 ++++++++++
 arch/arm64/include/asm/cputype.h             |   2 +
 arch/arm64/kernel/cpu_errata.c               |  27 +++++
 arch/arm64/tools/cpucaps                     |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c | 114 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-trbe.h |   8 --
 7 files changed, 183 insertions(+), 36 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA8F484D38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiAEFGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:06:15 -0500
Received: from foss.arm.com ([217.140.110.172]:39148 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbiAEFGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:06:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D753C1042;
        Tue,  4 Jan 2022 21:06:13 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.72.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 369D03F66F;
        Tue,  4 Jan 2022 21:06:10 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] coresight: trbe: Workaround Cortex-A510 erratas
Date:   Wed,  5 Jan 2022 10:35:55 +0530
Message-Id: <1641359159-22726-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This series adds three different workarounds in the TRBE driver for
Cortex-A510 specific erratas. But first, this adds Cortex-A510 specific cpu
part number definition in the platform. This series applies on 5.16-rc8.

Relevant errata documents can be found here.

https://developer.arm.com/documentation/SDEN2397239/900
https://developer.arm.com/documentation/SDEN2397589/900

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-doc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (4):
  arm64: Add Cortex-A510 CPU part definition
  coresight: trbe: Work around the ignored system register writes
  coresight: trbe: Work around the invalid prohibited states
  coresight: trbe: Workaround TRBE trace data corruption

 Documentation/arm64/silicon-errata.rst       |   6 +
 arch/arm64/Kconfig                           |  57 ++++++++++
 arch/arm64/include/asm/cputype.h             |   2 +
 arch/arm64/kernel/cpu_errata.c               |  27 +++++
 arch/arm64/tools/cpucaps                     |   3 +
 drivers/hwtracing/coresight/coresight-trbe.c | 111 ++++++++++++++-----
 drivers/hwtracing/coresight/coresight-trbe.h |   8 --
 7 files changed, 181 insertions(+), 33 deletions(-)

-- 
2.25.1


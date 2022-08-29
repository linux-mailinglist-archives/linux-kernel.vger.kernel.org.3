Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F7E5A436D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiH2GzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiH2GzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:55:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 184C31EEDD;
        Sun, 28 Aug 2022 23:55:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0DD23A;
        Sun, 28 Aug 2022 23:55:26 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 313C43F766;
        Sun, 28 Aug 2022 23:55:46 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 0/3] perf/core: Assert PERF_EVENT_FLAG_ARCH is followed
Date:   Mon, 29 Aug 2022 12:25:04 +0530
Message-Id: <20220829065507.177781-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series ensures that PERF_EVENT_FLAG_ARCH mask is followed correctly,
while defining all the platform specific hardware event flags. But after
adding these checks, there are couple of build failures on x86 platform
like the following.

BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_AMD_BRS)
BUILD_BUG_ON(~PERF_EVENT_FLAG_ARCH & PERF_X86_EVENT_PEBS_LAT_HYBRID)

This happens because both these flags PERF_X86_EVENT_AMD_BRS (0x10000) and
PERF_X86_EVENT_PEBS_LAT_HYBRID (0x20000) falls outside PERF_EVENT_FLAG_ARCH
(0x0000ffff). Given that x86 platform is already using up all available bit
positions, should this platform flags mask be extended to (0x000fffff) ?

This seires applies on v6.0-rc3.

Anshuman Khandual (3):
  perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags
  arm64/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
  x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH

 arch/arm64/kernel/perf_event.c  |  1 +
 arch/x86/events/amd/core.c      |  2 ++
 arch/x86/events/core.c          | 16 ++++++++++++++++
 drivers/perf/apple_m1_cpu_pmu.c |  1 +
 drivers/perf/arm_spe_pmu.c      |  1 +
 kernel/events/core.c            |  1 +
 6 files changed, 22 insertions(+)

-- 
2.25.1


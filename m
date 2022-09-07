Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FC05B0033
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbiIGJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIGJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:19:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A725DEA1;
        Wed,  7 Sep 2022 02:19:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9EAD6E;
        Wed,  7 Sep 2022 02:19:40 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBCD33F73D;
        Wed,  7 Sep 2022 02:19:58 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, x86@kernel.org
Subject: [PATCH V3 0/4] perf/core: Assert PERF_EVENT_FLAG_ARCH is followed
Date:   Wed,  7 Sep 2022 14:49:20 +0530
Message-Id: <20220907091924.439193-1-anshuman.khandual@arm.com>
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

This series ensures that PERF_EVENT_FLAG_ARCH mask is followed correctly
while defining all the platform specific hardware event flags. But first
this expands PERF_EVENT_FLAG_ARCH with another four bits, to accommodate
some x86 platform event flags which were going beyond the existing mask.

This series applies on v6.0-rc4.

Changes in V3:

- Reworked event flags check on x86 platform as per Peter

Changes in V2:

https://lore.kernel.org/all/20220905054239.324029-1-anshuman.khandual@arm.com/

- Added first patch to expand PERF_EVENT_FLAG_ARCH
- Converted all BUILD_BUG_ON() into static_assert() 

Changes in V1:

https://lore.kernel.org/all/20220829065507.177781-1-anshuman.khandual@arm.com/

Cc: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org

Anshuman Khandual (4):
  perf/core: Expand PERF_EVENT_FLAG_ARCH
  perf/core: Assert PERF_EVENT_FLAG_ARCH does not overlap with generic flags
  arm64/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH
  x86/perf: Assert all platform event flags are within PERF_EVENT_FLAG_ARCH

 arch/x86/events/perf_event.h       | 34 ++++++++++++++----------------
 arch/x86/events/perf_event_flags.h | 22 +++++++++++++++++++
 drivers/perf/arm_spe_pmu.c         |  4 +++-
 include/linux/perf/arm_pmu.h       |  9 ++++----
 include/linux/perf_event.h         |  4 +++-
 5 files changed, 49 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/events/perf_event_flags.h

-- 
2.25.1


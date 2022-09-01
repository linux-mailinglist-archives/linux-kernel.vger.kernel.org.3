Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDAC5A9835
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiIANMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiIANMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:12:10 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F403015FD6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662037802; x=1693573802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Xs6dTSIQEv6dKZ9VRRzlKgUVAPM8qcTfEP3P5hkYfc=;
  b=j+ioJlG2P3LFG3GbymleRrYdINfNX7AZ43vEYLuDVY1EoywsTZTRK4T0
   jBJpNC6HYWLv91dp8nXSIVCTiGJ2kR16vKxDN4qcO54y3MMZfNwQuDkID
   xrMLbIYcNC51/4u189PbyYXz2HCVyw0Sh+BDino1wDAuqhb1Q731TDqYs
   WR5PyhA0fsE5pImSpHoOT0A8TfAkFoQ3XAoTOEmtcaDZT5WT8DQvZmWPo
   R6oLgnefVPlIsm4LA92BaLfK2LIccP4OSL9TtfiuiZ4v8bKEPbL/asy16
   LCZWKL+LWeBCV9Ok5EvnKg7Kuk0jtnnadFAWQiaZ+xaVl9eKH8PnGqwe2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321858084"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="321858084"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:10:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="612485297"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 01 Sep 2022 06:10:00 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org,
        ravi.bangoria@amd.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/6] Add sample_flags to improve the perf_sample_data struct
Date:   Thu,  1 Sep 2022 06:09:53 -0700
Message-Id: <20220901130959.1285717-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V1:
- Update the AMD LBR code in patch 3

The patch series is to fix PEBS timestamps overwritten and improve the
perf_sample_data struct. The detailed discussion can be found at
https://lore.kernel.org/lkml/YwXvGe4%2FQdgGYOKJ@worktop.programming.kicks-ass.net/

The patch series has two changes compared with the suggestions in the
above discussion.
- Only clear the sample flags for the perf_prepare_sample().
  The __perf_event_header__init_id is shared between perf_prepare_sample()
  (used by PERF_RECORD_SAMPLE) and perf_event_header__init_id() (used by
  other PERF_RECORD_* event type). The sample data is only available
  for the PERF_RECORD_SAMPLE.
- The CALLCHAIN_EARLY hack is still required for the BPF, especially
  perf_event_set_bpf_handler(). The sample data is not available when
  the function is invoked.

Kan Liang (6):
  perf: Add sample_flags to indicate the PMU-filled sample data
  perf/x86/intel/pebs: Fix PEBS timestamps overwritten
  perf: Use sample_flags for branch stack
  perf: Use sample_flags for weight
  perf: Use sample_flags for data_src
  perf: Use sample_flags for txn

 arch/powerpc/perf/core-book3s.c | 10 ++++++---
 arch/x86/events/amd/core.c      |  4 +++-
 arch/x86/events/core.c          |  4 +++-
 arch/x86/events/intel/core.c    |  4 +++-
 arch/x86/events/intel/ds.c      | 39 ++++++++++++++++++++++++---------
 include/linux/perf_event.h      | 15 ++++++-------
 kernel/events/core.c            | 30 ++++++++++++++++++-------
 7 files changed, 74 insertions(+), 32 deletions(-)

-- 
2.35.1


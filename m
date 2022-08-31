Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A87B5A80B3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiHaO4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiHaO4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:56:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587FB249A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661957745; x=1693493745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s5rv6//zF2ymuLakepAQbf0e6VQ9kcA5MOCntS5H4as=;
  b=lN4k/jTET3cdCZ6JQlDJmCxZGDhcuUQcuFqvi/uYBmvFhTAah0T905ie
   QA7IpIxqGa3G35iR4tRiiuWsB3vtdR8d8GnfszIshdZJ+vFG0lVRhUVmC
   6JZx8gVpbV+E5lx8JvHXh/TMqMZP/zJlXPimsc8F9RA6vyLa0QVdgXjEc
   QYxXwYIB3wAAlK+GXSAtMsEjZDWGHqojMNTKm0l02rVwo7qLOaoWaF/7i
   BNBQBFPnJaqAe1yfFsPEWJegvPFkbnXmrIUtbDsWZriPiR0vJZEj6Cmz+
   ZhhWKebTnIAAnGcmjneQ6dtR04BxWUBj5P9dC0u10K7oMXWt/Kj7hOrKG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296248191"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="296248191"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 07:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="614991677"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga007.fm.intel.com with ESMTP; 31 Aug 2022 07:55:44 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        eranian@google.com, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, andreas.kogler.0x@gmail.com,
        atrajeev@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/6] Add sample_flags to improve the perf_sample_data struct 
Date:   Wed, 31 Aug 2022 07:55:08 -0700
Message-Id: <20220831145514.190514-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
 arch/x86/events/core.c          |  4 +++-
 arch/x86/events/intel/core.c    |  4 +++-
 arch/x86/events/intel/ds.c      | 39 ++++++++++++++++++++++++---------
 include/linux/perf_event.h      | 15 ++++++-------
 kernel/events/core.c            | 33 +++++++++++++++++++---------
 6 files changed, 72 insertions(+), 33 deletions(-)

-- 
2.35.1


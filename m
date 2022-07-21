Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E214557C4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbiGUG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGUG4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:56:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4795252A6;
        Wed, 20 Jul 2022 23:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658386584; x=1689922584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzQeFX68gnIklr+bbjNE8aiCC5EqbVdttq1LHlkCJME=;
  b=Jhx7l1hsxjqmxsDo66TE3SU0P+oAb6LK9K/VAOYsSbEqX/SZaWEP0mnF
   K6ocGm3KXY5UENnIlFW7mZ/L4utgm6A9qGnw6QvMtBozzrhxLfgjKQSPA
   pddGHLZAAJcYxTtwYyfw9SsW9E7okiOXCJDZTnWKK4teVGTB1I28HDPzO
   GaMtj1JE0yGwDvFHuG7u7WgMGyvYrZ7MdSelCzWBNnMwbNDV4k6rUCX6D
   xRFJeOKaqR+tcXgUWFdSTcBAv+raAf8Z+3eRMJFDMwvJHkbTYxBm4i0SB
   XrwtBZ712AbpGsNgIlGxQsesdvcECl1cqpIfEhYlKJCbwx74kxVbQ7LSf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="285732468"
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="285732468"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:56:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,288,1650956400"; 
   d="scan'208";a="602217285"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2022 23:56:21 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH v4 0/5] Add perf stat default events for hybrid machines
Date:   Thu, 21 Jul 2022 14:57:01 +0800
Message-Id: <20220721065706.2886112-1-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The patch series is to clean up the existing perf stat default and support
the perf metrics Topdown for the p-core PMU in the perf stat default. The
first 4 patches are the clean-up patch and fixing the "--detailed" issue.
The last patch adds support for the perf metrics Topdown, the perf metrics
Topdown support for e-core PMU will be implemented later separately.

Kan Liang (4):
  perf stat: Revert "perf stat: Add default hybrid events"
  perf evsel: Add arch_evsel__hw_name()
  perf evlist: Always use arch_evlist__add_default_attrs()
  perf x86 evlist: Add default hybrid events for perf stat

Zhengjun Xing (1):
  perf stat: Add topdown metrics in the default perf stat on the hybrid
    machine

 tools/perf/arch/x86/util/evlist.c  | 64 +++++++++++++++++++++++++-----
 tools/perf/arch/x86/util/evsel.c   | 20 ++++++++++
 tools/perf/arch/x86/util/topdown.c | 51 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  1 +
 tools/perf/builtin-stat.c          | 50 ++++-------------------
 tools/perf/util/evlist.c           | 11 +++--
 tools/perf/util/evlist.h           |  9 ++++-
 tools/perf/util/evsel.c            |  7 +++-
 tools/perf/util/evsel.h            |  1 +
 tools/perf/util/stat-display.c     |  2 +-
 tools/perf/util/topdown.c          |  7 ++++
 tools/perf/util/topdown.h          |  3 +-
 12 files changed, 166 insertions(+), 60 deletions(-)

-- 
2.25.1


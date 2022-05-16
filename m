Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACDB5288B8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbiEPPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiEPPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:24:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129113BF93;
        Mon, 16 May 2022 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652714684; x=1684250684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8TW1dSBc1us8UEZ0Z0BBN3pyPo1SKgfKleeQ4vjaGhI=;
  b=lKMCLiWsu/qgYiVGGTreZJ3RTp8NULZotM8qY3wR3eW9Ut2qTV+g5vX+
   fo6UwXKVITE2haD2gqLw44z55sg9h4zY2iJkoY2LPvMi+YzgiawIJPEB2
   gaWJGtH/d1UtJm13owaURGpFo9+7ZZoBms0UWtTluwQNWU7F6FKqSA7zb
   qriHN3tX7UZkhYu/DypgP8lqorQ8lX8XcLOgVjwJihQlwOMgaBg+rZDJz
   /8jgmQBEj8rEuHX4pNwoEHt9p5WmD4xp60cMd9/XgtpkDiVmjFGysJpZo
   sJme7cssLaEGvaXSrk4RTiO+1uC+pIAN9sWQpZ+YC7lEDgHT703eaSXEu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270561296"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270561296"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:24:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="741290194"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 08:24:43 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 0/4] Several perf metrics topdown related fixes
Date:   Mon, 16 May 2022 08:24:32 -0700
Message-Id: <20220516152436.1104757-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Patch 1 is a follow-up patch for Ian's ("Fix topdown event weak
grouping")[1].

The patch 2 is to fix the perf metrics topdown events in a mixed group.
It reuses the function introduced in [1].
Patch 1 & 2 should be on top of [1].

The patch 3 & 4 are to fix other perf metrics topdown related issues.
They can be merged separately.

[1]: https://lore.kernel.org/all/20220512061308.1152233-1-irogers@google.com/

Changes since V1:
- Add comments for the evsel__sys_has_perf_metrics() and
  topdown_sys_has_perf_metrics()
- Factor out evsel__remove_from_group()

Kan Liang (4):
  perf evsel: Fixes topdown events in a weak group for the hybrid
    platform
  perf stat: Always keep perf metrics topdown events in a group
  perf parse-events: Support different format of the topdown event name
  perf parse-events: Move slots event for the hybrid platform too

 tools/perf/arch/x86/util/evlist.c  |  7 ++++---
 tools/perf/arch/x86/util/evsel.c   | 21 +++++++++++++++++++--
 tools/perf/arch/x86/util/topdown.c | 24 ++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  7 +++++++
 tools/perf/builtin-stat.c          |  7 +++----
 tools/perf/util/evlist.c           |  6 +-----
 tools/perf/util/evsel.c            | 13 +++++++++++--
 tools/perf/util/evsel.h            |  2 +-
 8 files changed, 70 insertions(+), 17 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/topdown.h

-- 
2.35.1


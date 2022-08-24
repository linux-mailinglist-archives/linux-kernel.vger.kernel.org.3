Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BC359F43C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiHXH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHXH2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:28:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E61696DC
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661326118; x=1692862118;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OGi5JWvzYcs82fmCKOdgk6Fa2nawMjW0N8IfD+y6akE=;
  b=V/Et44QGUwSaHJpScVvaJLQrtch3oyywuhtmznp/Zr5fv7dtro8k0W44
   LDcJP8UVNjDRxwdgwgEY0GjokdMbXAM9dNSbHJ11Ud3j0Jb+QmJqPDIPc
   TgPFEXfb6QxX2v2d2ijCLWUwLcUftG8chDkx/BtHLTVZ8M6rfnyA2mzFJ
   p0IvVGdxSMEXs9YdfjahsGH20mR9466/bqF+opWo1QmFJ+7mUjIiFOCl0
   X2c0DyGTNCqwKDD+ce+WftU48UxuQWu1BpuNK7RmzhnXJE6+hsVJLv73y
   DqTteDK0GW8G2nPStH2XVZhQnWEmnp5hOw/ZSC6v/M4xuj/8/C0uQMzEY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="295173936"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="295173936"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="605939127"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.51.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 00:28:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] perf record: Allow multiple recording time ranges
Date:   Wed, 24 Aug 2022 10:28:09 +0300
Message-Id: <20220824072814.16422-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch set extends perf record -D/--delay option to accept time ranges
for when events are enabled, for instance:

    perf record -e intel_pt// -D 10-20,30-40

to record 10ms to 20ms into the trace and 30ms to 40ms.  Refer patch 5 for
more details.

This ran into an issue with the handling of polling file descriptors.
Essentially, calling perf_evlist__add_pollfd() would not actually result
in the file descriptor being polled.  Patches 1, 2 and 3 deal with that.

Patch 4 deals with the issue that when disabling events, we actually do not
want to disable events collecting sideband information.

Patch 5, the last patch, actually makes the desired enhancement to
perf record.


Adrian Hunter (5):
      perf record: Fix way of handling non-perf-event pollfds
      perf record: Fix done_fd wakeup event
      perf record: Change evlist->ctl_fd to use fdarray_flag__non_perf_event
      perf evlist: Add evlist__{en/dis}able_non_dummy()
      perf record: Allow multiple recording time ranges

 tools/lib/api/fd/array.h                 |   5 +-
 tools/perf/Documentation/perf-record.txt |   6 +-
 tools/perf/builtin-record.c              | 117 ++++++++++++--
 tools/perf/util/evlist.c                 | 270 +++++++++++++++++++++++++++++--
 tools/perf/util/evlist.h                 |  12 +-
 5 files changed, 374 insertions(+), 36 deletions(-)


Regards
Adrian

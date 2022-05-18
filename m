Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B70C52BE07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiEROjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiEROjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:39:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C58F1C0F19;
        Wed, 18 May 2022 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652884745; x=1684420745;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UUIPLdOolmuMVgiLBbElltq3r2rvu+uGXiWi7YQ1CF4=;
  b=cJHc8zsCWxn4wDUMq71MLG/cS6iZe9bAv6kavX3kmM/tfJD6F28XtC5R
   DnNKIk161U2SlFD1xnzFRr7mWwhGzAnoepYHe2w0e+v8Dkd7AbJz9dA+t
   VKPaFKl3uJy9awiGpm/STvrF0GaqBDYYTxyIqqiKMeZjZsiB3ejit1ZtD
   JjkXab/ZbBGKk+aT2ycKLaHAiv/ByaAEszwakn5HkY4vFifPqa7Cggn6T
   tKEIpwCerr4y4S9V7lbMG6pdR1T1VlBG8ms8grRVdgg/27qv8ZH91yDQV
   EJV2cc4o3ed2/9sYGRGGVW7XmVf+D795U0n41ip7L/y/8tis4zE+NDV4H
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332321833"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332321833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="714455498"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2022 07:39:04 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/4] Several perf metrics topdown related fixes
Date:   Wed, 18 May 2022 07:38:56 -0700
Message-Id: <20220518143900.1493980-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

[1]: https://lore.kernel.org/all/20220517052724.283874-2-irogers@google.com/

Changes since V2:
- Add more comments for the evsel__sys_has_perf_metrics() and
  topdown_sys_has_perf_metrics()
- Remove the uncessary evsel->core.leader->nr_members = 0; in patch 2.
  The value has been updated in the new evsel__remove_from_group().
- Add Reviewed-by from Ian for patch 4

Changes since V1:
- Add comments for the evsel__sys_has_perf_metrics() and
  topdown_sys_has_perf_metrics()
- Factor out evsel__remove_from_group()
- Add Reviewed-by from Ian for patch 3

Kan Liang (4):
  perf evsel: Fixes topdown events in a weak group for the hybrid
    platform
  perf stat: Always keep perf metrics topdown events in a group
  perf parse-events: Support different format of the topdown event name
  perf parse-events: Move slots event for the hybrid platform too

 tools/perf/arch/x86/util/evlist.c  |  7 ++++---
 tools/perf/arch/x86/util/evsel.c   | 23 +++++++++++++++++++++--
 tools/perf/arch/x86/util/topdown.c | 25 +++++++++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  7 +++++++
 tools/perf/builtin-stat.c          |  7 ++-----
 tools/perf/util/evlist.c           |  6 +-----
 tools/perf/util/evsel.c            | 13 +++++++++++--
 tools/perf/util/evsel.h            |  2 +-
 8 files changed, 72 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/topdown.h

-- 
2.35.1


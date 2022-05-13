Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068585265D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381855AbiEMPQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377250AbiEMPQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:16:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02405A0AC;
        Fri, 13 May 2022 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652454963; x=1683990963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZlUCGx+rhIlmPnOqTb6cLmIeqJ2B+x6g12kXA7/q2hk=;
  b=MxBx9uwR7MtfdnFjOdp5EuIp2NuxfuIrZJ6eSQHMt9u3B+vtyo++C8Um
   Oo83M48AvWwTAKq19SN+th0z/PtZ/fQukn4AZ2RkVpvTPDvT1IYobCKUn
   YQJyiPuz4uQbontcBjp0C2i9Rk8AFK6l4wI6j4BadkNQC+bo7YEttquB2
   WUlZmFwe2bgZWuFPT10xlgFb2WDGMnvZRQD5XMjanSWjN1z9w8hGWyHd4
   FcSbyKgiLI9XW2LcWMEBXFA5TS0miFEtGV5yd4fqPmcD76im4ILMB4o00
   RZ2U/aviIyWPcXET9bXDUHEI8qY1MfChjBC4ZQtjcJ/8y5buEPjoXSkRk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269160142"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269160142"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:16:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698518045"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 08:16:01 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/4] Several perf metrics topdown related fixes
Date:   Fri, 13 May 2022 08:15:50 -0700
Message-Id: <20220513151554.1054452-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[1]: https://lore.kernel.org/all/20220512061308.1152233-1-irogers@google.com/

Kan Liang (4):
  perf evsel: Fixes topdown events in a weak group for the hybrid
    platform
  perf stat: Always keep perf metrics topdown events in a group
  perf parse-events: Support different format of the topdown event name
  perf parse-events: Move slots event for hybrid platforms too

 tools/perf/arch/x86/util/evlist.c  |  7 ++++---
 tools/perf/arch/x86/util/evsel.c   |  5 +++--
 tools/perf/arch/x86/util/topdown.c | 18 ++++++++++++++++++
 tools/perf/arch/x86/util/topdown.h |  7 +++++++
 tools/perf/builtin-stat.c          |  7 +++++--
 5 files changed, 37 insertions(+), 7 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/topdown.h

-- 
2.35.1


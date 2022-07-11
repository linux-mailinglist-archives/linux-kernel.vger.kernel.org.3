Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C1A5709B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 20:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbiGKSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiGKSHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 14:07:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E120728E2F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 11:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657562832; x=1689098832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Bd+9H2ydeTu2KP/lzJtZiS804+lAQT/B8kuP4qJ9yv4=;
  b=jvbI9UAnsKKX1uZ8lODhHc4TyLabX6lpPMf36/tWKtW93g5nko/UWFU1
   GTYK78GJ+2D7Mlt45LpQiuTvGqhULdC76dwLABo4Xfm/imxn7kwhO2/m2
   +W4qm3IYB+Hd2P0icfqhRoHdy0rXKaBl1jrT0kmO2BhmN6CKz6qRZzyt1
   SkVtDx/qreilFyZGU3oUNVk0cOc6KLmaDo/KelBQwMHI++p01+X/g6Fi6
   Dl2cjkcTcRSRt0nePKcY+lEERz2pKhl7r8TCtdB6+GizW5o3dZhVr4Mc6
   VVTol/OtqDyBQNUIbQ5H08vNAVk2Wx0Wfag9SlozxVay8fACxE6IRNCuP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283487053"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="283487053"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 11:07:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="697720729"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2022 11:07:11 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        adrian.hunter@intel.com, nadav.amit@gmail.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: [PATCH] perf/core: Fix the same task check in perf_event_set_output
Date:   Mon, 11 Jul 2022 11:07:06 -0700
Message-Id: <20220711180706.3418612-1-kan.liang@linux.intel.com>
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

With the --per-thread option, perf record errors out when sampling with
a hardware event and a software event as below.

 $ perf record -e cycles,dummy --per-thread ls
 failed to mmap with 22 (Invalid argument)

The same task is sampled with the two events. The IOC_OUTPUT is invoked
to share the mmap memory of the task between the events. In the
perf_event_set_output(), the event->ctx is used to check whether the
two events are attached to the same task. However, a hardware event and
a software event are from different task context. The check always
fails.

The task struct is stored in the event->hw.target for each per-thread
event. It can be used to determine whether two events are attached to
the same task.

The patch can also fix another issue reported months ago.
https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
The event->ctx is not ready when the perf_event_set_output() is invoked
in the perf_event_open(), while the event->hw.target has been assigned
at the moment.

The problem should be a long time issue since commit c3f00c70276d
("perf: Separate find_get_context() from event initialization"). The
event->hw.target doesn't exist at that time. Here, the patch which
introduces the event->hw.target is used by the Fixes tag.

The problem should still exists between the broken patch and the
event->hw.target patch. This patch does not intend to fix that case.

Fixes: 50f16a8bf9d7 ("perf: Remove type specific target pointers")
Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b4d62210c3e5..22df79d3f19d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12080,7 +12080,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	/*
 	 * If its not a per-cpu rb, it must be the same task.
 	 */
-	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
+	if (output_event->cpu == -1 && output_event->hw.target != event->hw.target)
 		goto out;
 
 	/*
-- 
2.35.1


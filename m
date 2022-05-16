Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D135288B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiEPPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiEPPYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:24:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CC3BF93;
        Mon, 16 May 2022 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652714686; x=1684250686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XFEeuqGOKYZbTkzW8wUdOuH8GKHFxQqzXqZIW5aoD3Q=;
  b=LunLe1htK/GM+8/yrWVrBsxvYEi2Hk57/jcjeCXE3kzi8Qf4TA78sD0S
   tTZZw3UiiGoqIxBf2nuCkZ2xFsFp9W0k8ip03tk6yx1D6XN8b8wt5XlJS
   7ZARuOUERkwH3du4Nkj9JrnbDQUsfsgNCakzqkLP/9sc5T2LWDDLIFcCw
   O5tJhDCvtfQFWhowMUbQqh9IikGvVeDdGJ3ZKL+hw4zGkOyEQd7HVN7ig
   I0igvzPVeu4DngNcSG8bH+IOTVsm0zTiIsQk/GdPkqxJ8FgMsR82GFLJE
   zEeKcaswxMvu1x7maS51QvfLN6bqbbspoP7vb1tqsUcbRgnc0XRF0TlOx
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="270561300"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="270561300"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 08:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="741290213"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2022 08:24:43 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/4] perf parse-events: Support different format of the topdown event name
Date:   Mon, 16 May 2022 08:24:35 -0700
Message-Id: <20220516152436.1104757-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516152436.1104757-1-kan.liang@linux.intel.com>
References: <20220516152436.1104757-1-kan.liang@linux.intel.com>
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

The evsel->name may have a different format for a topdown event, a pure
topdown name (e.g., topdown-fe-bound), or a PMU name + a topdown name
(e.g., cpu/topdown-fe-bound/). The cpu/topdown-fe-bound/ kind format
isn't supported by the arch_evlist__leader(). This format is a very
common format for a hybrid platform, which requires specifying the PMU
name for each event.

Without the patch,

$perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1

 Performance counter stats for 'system wide':

     <not counted>      instructions
     <not counted>      slots
   <not supported>      cpu/topdown-fe-bound/

       1.003482041 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
The events in group usually have to be from the same PMU. Try reorganizing the group.

With the patch,

perf stat -e '{instructions,slots,cpu/topdown-fe-bound/}' -a sleep 1

 Performance counter stats for 'system wide':

       157,383,996      slots
        25,011,711      instructions
        27,441,686      cpu/topdown-fe-bound/

       1.003530890 seconds time elapsed

Fixes: bc355822f0d9 ("perf parse-events: Move slots only with topdown")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index cfc208d71f00..75564a7df15b 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -36,7 +36,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
 				if (slots == first)
 					return first;
 			}
-			if (!strncasecmp(evsel->name, "topdown", 7))
+			if (strcasestr(evsel->name, "topdown"))
 				has_topdown = true;
 			if (slots && has_topdown)
 				return slots;
-- 
2.35.1


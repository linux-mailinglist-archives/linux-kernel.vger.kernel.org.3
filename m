Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D477D52BDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiEROjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiEROjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:39:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB37C33378;
        Wed, 18 May 2022 07:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652884747; x=1684420747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XFEeuqGOKYZbTkzW8wUdOuH8GKHFxQqzXqZIW5aoD3Q=;
  b=nYrAulNVveaRc8sdaoPcIcGcj/0Ane+YqASGu1vOjju/ejMPlfMhY0cM
   Iqf9G31e6225q6901G1UBjktLde5ztuAeB5I8I4rq7Wlwb6eWzUnKJTx9
   YT22/GNeoAXQUUK1plTTZsJIy3xHoDuEb3rL6LQu0fXd2eW4NC01hXv00
   lkLmcUmAdhavCN75wDlnZKvvciFjlO/ITW40STe+f5KXNvcw+HPazcMKw
   yKWenp0BANe8f/OiHVlbD2LchVyoAMD5i96xMFxr1XSji9UH3ASa/01aa
   FrDeXShKXOKBu1oquRGcatjgUOi0qmkYrN7aWgYJtnFVLsNMbLMWKu7+n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="332321842"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="332321842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 07:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="714455507"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga001.fm.intel.com with ESMTP; 18 May 2022 07:39:05 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 3/4] perf parse-events: Support different format of the topdown event name
Date:   Wed, 18 May 2022 07:38:59 -0700
Message-Id: <20220518143900.1493980-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518143900.1493980-1-kan.liang@linux.intel.com>
References: <20220518143900.1493980-1-kan.liang@linux.intel.com>
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


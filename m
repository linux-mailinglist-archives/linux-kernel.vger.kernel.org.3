Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD85265D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381832AbiEMPQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381173AbiEMPQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:16:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC2C5A141;
        Fri, 13 May 2022 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652454966; x=1683990966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WaaPZTGXGvvrIUYYvLuGheNzDThV1e0SRqk9uhMThso=;
  b=XHLubT2k7LVqpMqjG5th6UYYjvI7PXog8AEIZp3dqYCTJ4qugsFLh2BG
   EcQzBqPnPV41rmFK2TgRv9Mr9a0yYAWg6aOVWxi2lF6A38cpWIP3PfauP
   NJclxEdsgo0FALOFRSbmqFWVAZiTjoKU6liYjdxBSqiXN80fo3UykobBK
   x9z/QnnTUb+YT4vnClpxsrYCeaEK7VMONMwhSPRqLwBbpgaL8dhgV7YaY
   pWgD7g0s8VsRFKYBiE2vvvNOy1+piFNAmgFpAEf9Mr/Q53iUEnU754Cvy
   fBZV9Bip2RiF5naH8t1ui2WWZCFG7ztdOyROmPcEos9+Gog0TfUTvt/I3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="269160154"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="269160154"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 08:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698518059"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 08:16:02 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@redhat.com, irogers@google.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf parse-events: Support different format of the topdown event name
Date:   Fri, 13 May 2022 08:15:53 -0700
Message-Id: <20220513151554.1054452-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513151554.1054452-1-kan.liang@linux.intel.com>
References: <20220513151554.1054452-1-kan.liang@linux.intel.com>
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


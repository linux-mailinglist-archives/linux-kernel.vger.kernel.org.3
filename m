Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB6590DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiHLIwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237874AbiHLIwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:52:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52558A98E6;
        Fri, 12 Aug 2022 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294327; x=1691830327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hb7RxByBEL6uL748ejvAvrFFyckPabdvIkUDHPGiz/Q=;
  b=DtLu8xrrdYoeTw5KRXOehHu40MRKWAgPjcfsq0nhEM8DKnETn9WkI/wB
   EImJNoy9+WQmrnMOmHB550wGtiVGsX/jhtQN9/x90VB90TnJYvWdr+pwW
   9qjqN0vqZiTNtDGAJcKko3Jj2pNv9xYs1rUGyFXda8YD/SQDFSMe5zfFR
   t8OfB95DhjjbtcK/SUHjk4kOt5h/JICpI/Ue9/Apz1eiU+IuxUCw2HBkU
   HJQ20Vg4MI0/A7wCLxIbbd3nWJFOfl/WQjy5rN5tFeModT1UF1KVEDRvL
   DH+gQw5V3Gc8he3H1PFVTiFzXjz6qK5hqzMcdiKkN/hAk5KVbIqs/Jp6t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="271939163"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="271939163"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:52:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451476"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:52:04 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 07/11] perf vendor events: Update metrics for jaketown
Date:   Fri, 12 Aug 2022 16:52:35 +0800
Message-Id: <20220812085239.3089231-8-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

The metrics are based on TMA 4.4 full, add new metrics “UNCORE_FREQ” for
jaketown.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the jaketown files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
index 2711cbe536b8..c0fbb4f31241 100644
--- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
@@ -208,6 +208,12 @@
         "MetricGroup": "SoC",
         "MetricName": "Socket_CLKS"
     },
+    {
+        "BriefDescription": "Uncore frequency per die [GHZ]",
+        "MetricExpr": "cbox_0@event\\=0x0@ / #num_dies / duration_time / 1000000000",
+        "MetricGroup": "SoC",
+        "MetricName": "UNCORE_FREQ"
+    },
     {
         "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
         "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
-- 
2.25.1


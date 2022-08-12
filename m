Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2037C590DC3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbiHLIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237723AbiHLIvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:51:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0347EA9257;
        Fri, 12 Aug 2022 01:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294297; x=1691830297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0hYsjf9lb5aUXxCyQMN5Po0mqNtfWcfZlLYgfTNcHE=;
  b=WewMFgMi/whYMIH8O5FLBuscKGGwVeDfkCI16+tVwKAZah56pIt4pN5w
   Twff3wwXCocvrLiC+eusgES1Lrcej5gBOdvFbfJaiUGu2WYAoHU8fTHI0
   iHT3L4DIaQLOW4J3Y47GDF2DnQNRnKzaZiBo5yN7a4C8ClOIo8Q6VtOdz
   AALAg4LxEeEaaX0mvC9Rh22uwS9uQ5+uVLP3MsdIqunJNwt/Iam67+uxy
   p+rdg4IsxqDeLaSnMSNUmaeLug8+sMar7tGP57cQXe5esgPyZ5zQh36s7
   hyQDBzKKckGitgOlqSYKWoMQXus3HF2celasRANILV7pDz6LNZ6G/fo1V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="353297756"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="353297756"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451382"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:51:32 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 01/11] perf vendor events: Update metrics for broadwellde
Date:   Fri, 12 Aug 2022 16:52:29 +0800
Message-Id: <20220812085239.3089231-2-zhengjun.xing@linux.intel.com>
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
broadwellde.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the broadwellde files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
index 6789285555f0..b6fdf5ba2c9a 100644
--- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
@@ -450,6 +450,12 @@
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


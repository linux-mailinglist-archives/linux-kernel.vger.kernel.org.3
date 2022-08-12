Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45F590DCD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbiHLIwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiHLIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:52:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A99AA98F1;
        Fri, 12 Aug 2022 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660294335; x=1691830335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ACshjCPLnW+F8ev2LdADkoEpe3HIPro9YFT0yv04RCo=;
  b=DcxqkpNckJH/KM/LroGBec3ySp/e0ZuWgo+sD3GAQkKY/YVWZLTjWPWl
   ft8+BNnbBBlOX2G3/UULSqDynCqhrIAL3PUksm+Q2beoeBHfzYGgzso3W
   B1p+X+pnixk6+VkujlrZ0eeUt7r3UGEJm6ScJVq9xXL7EbxQxXRk111qN
   N3p5TcRO2U0eJo62bBQT+WGV5JA/1m8WOKZXFE0eNPHeuDKnJZQjNt1Uj
   bQ2Z276oc7/fNLIRm3YJmpChPzvpxnEQ4lRJvAZxpXYgK0swODTz9Ut9m
   B7n2QNw8PoK6RnkaMZJdW6hXsoPT89J6R1zqySkgsi3q+7mjIEGDgSGbb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292819536"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292819536"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 01:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="602451491"
Received: from zxingrtx.sh.intel.com ([10.239.159.110])
  by orsmga007.jf.intel.com with ESMTP; 12 Aug 2022 01:52:09 -0700
From:   zhengjun.xing@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        zhengjun.xing@linux.intel.com
Subject: [PATCH 08/11] perf vendor events: Update events for knightslanding
Date:   Fri, 12 Aug 2022 16:52:36 +0800
Message-Id: <20220812085239.3089231-9-zhengjun.xing@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
References: <20220812085239.3089231-1-zhengjun.xing@linux.intel.com>
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

From: Zhengjun Xing <zhengjun.xing@linux.intel.com>

Update the events to v9, update events for knightslanding by the latest
event converter tools.

Use script at:
https://github.com/intel/event-converter-for-linux-perf/blob/master/download_and_gen.py

to download and generate the latest events and metrics. Manually copy
the knightslanding files into perf.

Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
---
 .../arch/x86/knightslanding/uncore-other.json | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
index a87d7431ef45..a5e1a9a47e73 100644
--- a/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
+++ b/tools/perf/pmu-events/arch/x86/knightslanding/uncore-other.json
@@ -1,4 +1,67 @@
 [
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IRQ ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.IRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IRQ or PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.LOC_ALL",
+        "PerPkg": "1",
+        "UMask": "0x37",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.PRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_C_TOR_INSERTS.PRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Counts the number of read requests and streaming stores that hit in MCDRAM cache and the data in MCDRAM is clean with respect to DDR. This event is only valid in cache and hybrid memory mode.",
         "Counter": "0,1,2,3",
@@ -3497,6 +3560,156 @@
         "UMask": "0x08",
         "Unit": "CHA"
     },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -SF/LLC Evictions",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x32",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -Hit (Not a Miss)",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.HIT",
+        "PerPkg": "1",
+        "UMask": "0x1F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IPQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -IRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -Miss",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.MISS",
+        "PerPkg": "1",
+        "UMask": "0x2F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "Counts the number of entries successfully inserted into the TOR that match  qualifications specified by the subevent -PRQ",
+        "Counter": "0,1,2,3",
+        "EventCode": "0x35",
+        "EventName": "UNC_H_TOR_INSERTS.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -SF/LLC Evictions",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.EVICT",
+        "PerPkg": "1",
+        "UMask": "0x32",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -Hit (Not a Miss)",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.HIT",
+        "PerPkg": "1",
+        "UMask": "0x1F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IPQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IPQ",
+        "PerPkg": "1",
+        "UMask": "0x38",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IPQ hit",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IPQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x18",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IPQ miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IPQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x28",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IRQ or PRQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IRQ",
+        "PerPkg": "1",
+        "UMask": "0x31",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IRQ or PRQ hit",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x11",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -IRQ or PRQ miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.IRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x21",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -Miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.MISS",
+        "PerPkg": "1",
+        "UMask": "0x2F",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -PRQ",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.PRQ",
+        "PerPkg": "1",
+        "UMask": "0x34",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -PRQ hit",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.PRQ_HIT",
+        "PerPkg": "1",
+        "UMask": "0x14",
+        "Unit": "CHA"
+    },
+    {
+        "BriefDescription": "For each cycle, this event accumulates the number of valid entries in the TOR that match qualifications specified by the subevent -PRQ miss",
+        "EventCode": "0x36",
+        "EventName": "UNC_H_TOR_OCCUPANCY.PRQ_MISS",
+        "PerPkg": "1",
+        "UMask": "0x24",
+        "Unit": "CHA"
+    },
     {
         "BriefDescription": "Uncore Clocks",
         "Counter": "0,1,2,3",
-- 
2.25.1


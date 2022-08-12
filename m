Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29475912CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbiHLPO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiHLPOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:14:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE0FA599C;
        Fri, 12 Aug 2022 08:14:23 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M46Zp58GHz688mK;
        Fri, 12 Aug 2022 23:11:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 17:14:17 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 16:14:17 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <john.garry@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 4/4] docs: perf: Minimal introduction the the CXL PMU device and driver.
Date:   Fri, 12 Aug 2022 16:12:14 +0100
Message-ID: <20220812151214.2025-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
References: <20220812151214.2025-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very basic introduction to the device and the current driver support
provided. I expect to expand on this in future versions of this patch
set.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

--
RFC:
- I'll post separately about this shortly, but it seems very odd
  to me that there is no way to assign a parent to an event_sources
  device.  As a result we get the messy approach of playing match
  the name to figure out what the CPMU instance is connected to.
---
 Documentation/admin-guide/perf/cxl.rst   | 60 ++++++++++++++++++++++++
 Documentation/admin-guide/perf/index.rst |  1 +
 2 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
new file mode 100644
index 000000000000..6ffc057591fb
--- /dev/null
+++ b/Documentation/admin-guide/perf/cxl.rst
@@ -0,0 +1,60 @@
+======================================
+CXL Performance Monitoring Unit (CPMU)
+======================================
+
+The CXL rev 3.0 specification provides a definition of CXL Performance
+Monitoring Unit in section 13.2: Performance Monitoring.
+
+CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
+any number of CPMU instances. CPMU capabilities are fully discoverable from
+the devices. The specification provides event definitions for all CXL protocol
+message types and a set of additional events for things commonly counted on
+CXL devices (e.g. DRAM events).
+
+CPMU driver
+===========
+
+The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
+
+    /sys/bus/cxl/device/cpmu<id>
+
+The associated PMU is registered as
+
+   /sys/bus/event_sources/devices/cpmu<id>
+
+In common with other CXL bus devices, the id has no specific meaning and the
+relationship to specific CXL device should be established via the device parent
+of the device on the CXL bus.
+
+PMU driver provides description of available events and filter options in sysfs.
+
+The "format" directory describes all formats of the config (event vendor id,
+group id and mask) config1 (threshold, filter enables) and config2 (filter
+parameters) fields of the perf_event_attr structure.  The "events" directory
+describes all documented events show in perf list.
+
+The events shown in perf list are the most fine grained events with a single
+bit of the event mask set. More general events may be enable by setting
+multiple mask bits in config. For example, all Device to Host Read Requests
+may be captured on a single counter by setting the bits for all of
+
+* d2h_req_rdcurr
+* d2h_req_rdown
+* d2h_req_rdshared
+* d2h_req_rdany
+* d2h_req_rdownnodata
+
+Example of usage::
+
+  $#perf list
+  cpmu0/clock_ticks/                                 [Kernel PMU event]
+  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
+  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
+  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
+  -----------------------------------------------------------
+
+  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
+
+The driver does not support sampling. So "perf record" and attaching to
+a task are unsupported.
+
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 69b23f087c05..ff1ac52c37fb 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -17,3 +17,4 @@ Performance monitor support
    xgene-pmu
    arm_dsu_pmu
    thunderx2-pmu
+   cxl
-- 
2.32.0


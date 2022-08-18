Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57140597C30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243067AbiHRDSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbiHRDSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:18:38 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC925FC4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:18:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VMZAdEL_1660792709;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VMZAdEL_1660792709)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 11:18:30 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [PATCH v4 1/3] docs: perf: Add description for Alibaba's T-Head PMU driver
Date:   Thu, 18 Aug 2022 11:18:20 +0800
Message-Id: <20220818031822.38415-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alibaba's T-Head SoC implements uncore PMU for performance and functional
debugging to facilitate system maintenance. Document it to provide guidance
on how to use it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../admin-guide/perf/alibaba_pmu.rst          | 100 ++++++++++++++++++
 Documentation/admin-guide/perf/index.rst      |   1 +
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst

diff --git a/Documentation/admin-guide/perf/alibaba_pmu.rst b/Documentation/admin-guide/perf/alibaba_pmu.rst
new file mode 100644
index 000000000000..11de998bb480
--- /dev/null
+++ b/Documentation/admin-guide/perf/alibaba_pmu.rst
@@ -0,0 +1,100 @@
+=============================================================
+Alibaba's T-Head SoC Uncore Performance Monitoring Unit (PMU)
+=============================================================
+
+The Yitian 710, custom-built by Alibaba Group's chip development business,
+T-Head, implements uncore PMU for performance and functional debugging to
+facilitate system maintenance.
+
+DDR Sub-System Driveway (DRW) PMU Driver
+=========================================
+
+Yitian 710 employs eight DDR5/4 channels, four on each die. Each DDR5 channel
+is independent of others to service system memory requests. And one DDR5
+channel is split into two independent sub-channels. The DDR Sub-System Driveway
+implements separate PMUs for each sub-channel to monitor various performance
+metrics.
+
+The Driveway PMU devices are named as ali_drw_<sys_base_addr> with perf.
+For example, ali_drw_21000 and ali_drw_21080 are two PMU devices for two
+sub-channels of the same channel in die 0. And the PMU device of die 1 is
+prefixed with ali_drw_400XXXXX, e.g. ali_drw_40021000.
+
+Each sub-channel has 36 PMU counters in total, which is classified into
+four groups:
+
+- Group 0: PMU Cycle Counter. This group has one pair of counters
+  pmu_cycle_cnt_low and pmu_cycle_cnt_high, that is used as the cycle count
+  based on DDRC core clock.
+
+- Group 1: PMU Bandwidth Counters. This group has 8 counters that are used
+  to count the total access number of either the eight bank groups in a
+  selected rank, or four ranks separately in the first 4 counters. The base
+  transfer unit is 64B.
+
+- Group 2: PMU Retry Counters. This group has 10 counters, that intend to
+  count the total retry number of each type of uncorrectable error.
+
+- Group 3: PMU Common Counters. This group has 16 counters, that are used
+  to count the common events.
+
+For now, the Driveway PMU driver only uses counters in group 0 and group 3.
+
+The DDR Controller (DDRCTL) and DDR PHY combine to create a complete solution
+for connecting an SoC application bus to DDR memory devices. The DDRCTL
+receives transactions Host Interface (HIF) which is custom-defined by Synopsys.
+These transactions are queued internally and scheduled for access while
+satisfying the SDRAM protocol timing requirements, transaction priorities, and
+dependencies between the transactions. The DDRCTL in turn issues commands on
+the DDR PHY Interface (DFI) to the PHY module, which launches and captures data
+to and from the SDRAM. The driveway PMUs have hardware logic to gather
+statistics and performance logging signals on HIF, DFI, etc.
+
+By counting the READ, WRITE and RMW commands sent to the DDRC through the HIF
+interface, we could calculate the bandwidth. Example usage of counting memory
+data bandwidth::
+
+  perf stat \
+    -e ali_drw_21000/hif_wr/ \
+    -e ali_drw_21000/hif_rd/ \
+    -e ali_drw_21000/hif_rmw/ \
+    -e ali_drw_21000/cycle/ \
+    -e ali_drw_21080/hif_wr/ \
+    -e ali_drw_21080/hif_rd/ \
+    -e ali_drw_21080/hif_rmw/ \
+    -e ali_drw_21080/cycle/ \
+    -e ali_drw_23000/hif_wr/ \
+    -e ali_drw_23000/hif_rd/ \
+    -e ali_drw_23000/hif_rmw/ \
+    -e ali_drw_23000/cycle/ \
+    -e ali_drw_23080/hif_wr/ \
+    -e ali_drw_23080/hif_rd/ \
+    -e ali_drw_23080/hif_rmw/ \
+    -e ali_drw_23080/cycle/ \
+    -e ali_drw_25000/hif_wr/ \
+    -e ali_drw_25000/hif_rd/ \
+    -e ali_drw_25000/hif_rmw/ \
+    -e ali_drw_25000/cycle/ \
+    -e ali_drw_25080/hif_wr/ \
+    -e ali_drw_25080/hif_rd/ \
+    -e ali_drw_25080/hif_rmw/ \
+    -e ali_drw_25080/cycle/ \
+    -e ali_drw_27000/hif_wr/ \
+    -e ali_drw_27000/hif_rd/ \
+    -e ali_drw_27000/hif_rmw/ \
+    -e ali_drw_27000/cycle/ \
+    -e ali_drw_27080/hif_wr/ \
+    -e ali_drw_27080/hif_rd/ \
+    -e ali_drw_27080/hif_rmw/ \
+    -e ali_drw_27080/cycle/ -- sleep 10
+
+The average DRAM bandwidth can be calculated as follows:
+
+- Read Bandwidth =  perf_hif_rd * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
+- Write Bandwidth = (perf_hif_wr + perf_hif_rmw) * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
+
+Here, DDRC_WIDTH = 64 bytes.
+
+The current driver does not support sampling. So "perf record" is
+unsupported.  Also attach to a task is unsupported as the events are all
+uncore.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 9c9ece88ce53..793e1970bc05 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -18,3 +18,4 @@ Performance monitor support
    xgene-pmu
    arm_dsu_pmu
    thunderx2-pmu
+   alibaba_pmu
-- 
2.20.1.12.g72788fdb


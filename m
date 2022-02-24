Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AE94C2A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiBXLNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiBXLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:13:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D85E293A0C;
        Thu, 24 Feb 2022 03:12:43 -0800 (PST)
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K49B12BFZzbbkh;
        Thu, 24 Feb 2022 19:08:09 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 24 Feb 2022 19:12:41 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 19:12:41 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>,
        <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 2/2] perf jevents: Add support for HiSilicon CPA PMU aliasing
Date:   Thu, 24 Feb 2022 19:11:29 +0800
Message-ID: <20220224111129.41416-3-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20220224111129.41416-1-liuqi115@huawei.com>
References: <20220224111129.41416-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for HiSilicon CPA PMU aliasing.

The kernel driver is in drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 .../arm64/hisilicon/hip09/sys/uncore-cpa.json | 81 +++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
new file mode 100644
index 000000000000..7bcddec8a84f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json
@@ -0,0 +1,81 @@
+[
+	{
+		"ConfigCode": "0x00",
+		"EventName": "cpa_cycles",
+		"BriefDescription": "count of CPA cycles",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x61",
+		"EventName": "cpa_p1_wr_dat",
+		"BriefDescription": "Number of write ops transmitted by the P1 port",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x62",
+		"EventName": "cpa_p1_rd_dat",
+		"BriefDescription": "Number of read ops transmitted by the P1 port",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x3",
+		"EventName": "cpa_p1_rd_dat_64b",
+		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 64 bytes",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x4",
+		"EventName": "cpa_p1_rd_dat_32b",
+		"BriefDescription": "Number of read ops transmitted by the P1 port which size is 32 bytes",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0xE1",
+		"EventName": "cpa_p0_wr_dat",
+		"BriefDescription": "Number of write ops transmitted by the P0 port",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0xE2",
+		"EventName": "cpa_p0_rd_dat",
+		"BriefDescription": "Number of read ops transmitted by the P0 port",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x83",
+		"EventName": "cpa_p0_rd_dat_64b",
+		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 64 bytes",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"ConfigCode": "0x84",
+		"EventName": "cpa_p0_rd_dat_32b",
+		"BriefDescription": "Number of read ops transmitted by the P0 port which size is 32 bytes",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"MetricExpr": "(cpa_p1_wr_dat * 64 + cpa_p1_rd_dat_64b * 64 + cpa_p1_rd_dat_32b * 32) / cpa_cycles",
+		"BriefDescription": "Average bandwidth of CPA Port 1",
+		"MetricGroup": "CPA",
+		"MetricName": "cpa_p1_avg_bw",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	},
+	{
+		"MetricExpr": "(cpa_p0_wr_dat * 64 + cpa_p0_rd_dat_64b * 64 + cpa_p0_rd_dat_32b * 32) / cpa_cycles",
+		"BriefDescription": "Average bandwidth of CPA Port 0",
+		"MetricGroup": "CPA",
+		"MetricName": "cpa_p0_avg_bw",
+		"Compat": "0x00000030",
+		"Unit": "hisi_sicl,cpa"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 1a57c3f81dd4..159d9eab6e79 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -277,6 +277,7 @@ static struct map {
 	{ "CPU-M-CF", "cpum_cf" },
 	{ "CPU-M-SF", "cpum_sf" },
 	{ "UPI LL", "uncore_upi" },
+	{ "hisi_sicl,cpa", "hisi_sicl,cpa"},
 	{ "hisi_sccl,ddrc", "hisi_sccl,ddrc" },
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
-- 
2.24.0


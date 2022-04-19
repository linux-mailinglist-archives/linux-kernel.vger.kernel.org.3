Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156BC506D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351201AbiDSNGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351169AbiDSNGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:06:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C23702F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:03:36 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjP5B0Xp6zCr6T;
        Tue, 19 Apr 2022 20:59:10 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 21:03:34 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Apr 2022 21:03:33 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <huangguangbin2@huawei.com>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>,
        <moyufeng@huawei.com>
Subject: [PATCH V4 1/2] drivers/perf: hisi: Add description for HNS3 PMU driver
Date:   Tue, 19 Apr 2022 20:57:49 +0800
Message-ID: <20220419125750.5924-2-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220419125750.5924-1-huangguangbin2@huawei.com>
References: <20220419125750.5924-1-huangguangbin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HNS3 PMU End Point device is supported on HiSilicon HIP09 platform, so
add document hns3-pmu.rst to provide guidance on how to use it.

Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
---
 Documentation/admin-guide/perf/hns3-pmu.rst | 136 ++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst

diff --git a/Documentation/admin-guide/perf/hns3-pmu.rst b/Documentation/admin-guide/perf/hns3-pmu.rst
new file mode 100644
index 000000000000..578407e487d6
--- /dev/null
+++ b/Documentation/admin-guide/perf/hns3-pmu.rst
@@ -0,0 +1,136 @@
+======================================
+HNS3 Performance Monitoring Unit (PMU)
+======================================
+
+HNS3(HiSilicon network system 3) Performance Monitoring Unit (PMU) is an
+End Point device to collect performance statistics of HiSilicon SoC NIC.
+On Hip09, each SICL(Super I/O cluster) has one PMU device.
+
+HNS3 PMU supports collection of performance statistics such as bandwidth,
+latency, packet rate and interrupt rate.
+
+Each HNS3 PMU supports 8 hardware events.
+
+HNS3 PMU driver
+===============
+
+The HNS3 PMU driver registers a perf PMU with the name of its sicl id.::
+
+  /sys/devices/hns3_pmu_sicl_<sicl_id>
+
+PMU driver provides description of available events, filter modes, format,
+identifier and cpumask in sysfs.
+
+The "events" directory describes the event code of all supported events
+shown in perf list.
+
+The "filtermode" directory describes the supported filter modes of each
+event.
+
+The "format" directory describes all formats of the config (events) and
+config1 (filter options) fields of the perf_event_attr structure.
+
+The "identifier" file shows version of PMU hardware device.
+
+The "bdf_min" and "bdf_max" files show the supported bdf range of each
+pmu device.
+
+The "hw_clk_freq" file shows the hardware clock frequency of each pmu
+device.
+
+Example usage of checking event code and subevent code::
+
+  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_time
+  config=0x00204
+  $# cat /sys/devices/hns3_pmu_sicl_0/events/dly_tx_normal_to_mac_packet_num
+  config=0x10204
+
+Each performance statistic has a pair of events to get two values to
+calculate real performance data in userspace.
+
+The bits 0~15 of config (here 0x0204) are the true hardware event code. If
+two events have same value of bits 0~15 of config, that means they are
+event pair. And the bit 16 of config indicates getting counter 0 or
+counter 1 of hardware event.
+
+After getting two values of event pair in usersapce, the formula of
+computation to calculate real performance data is:::
+
+  counter 0 / counter 1
+
+Example usage of checking supported filter mode::
+
+  $# cat /sys/devices/hns3_pmu_sicl_0/filtermode/bw_ssu_rpu_byte_num
+  filter mode supported: global/port/port-tc/func/func-queue/
+
+Example usage of perf::
+
+  $# perf list
+  hns3_pmu_sicl_0/bw_ssu_rpu_byte_num/ [kernel PMU event]
+  hns3_pmu_sicl_0/bw_ssu_rpu_time/     [kernel PMU event]
+  ------------------------------------------
+
+  $# perf stat -g -e hns3_pmu_sicl_0/bw_ssu_rpu_byte_num,global=1/ -e hns3_pmu_sicl_0/bw_ssu_rpu_time,global=1/ -I 1000
+  or
+  $# perf stat -g -e hns3_pmu_sicl_0/config=0x00002,global=1/ -e hns3_pmu_sicl_0/config=0x10002,global=1/ -I 1000
+
+
+Filter modes
+--------------
+
+1. global mode
+PMU collect performance statistics for all HNS3 PCIe functions of IO DIE.
+Set the "global" filter option to 1 will enable this mode.
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x1020F,global=1/ -I 1000
+
+2. port mode
+PMU collect performance statistic of one whole physical port. The port id
+is same as mac id. The "tc" filter option must be set to 0xF in this mode,
+here tc stands for traffic class.
+
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x1020F,port=0,tc=0xF/ -I 1000
+
+3. port-tc mode
+PMU collect performance statistic of one tc of physical port. The port id
+is same as mac id. The "tc" filter option must be set to 0 ~ 7 in this
+mode.
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x1020F,port=0,tc=0/ -I 1000
+
+4. func mode
+PMU collect performance statistic of one PF/VF. The function id is BDF of
+PF/VF, its conversion formula::
+
+  func = (bus << 8) + (device << 3) + (function)
+
+for example:
+  BDF         func
+  35:00.0    0x3500
+  35:00.1    0x3501
+  35:01.0    0x3508
+
+In this mode, the "queue" filter option must be set to 0xFFFF.
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x1020F,bdf=0x3500,queue=0xFFFF/ -I 1000
+
+5. func-queue mode
+PMU collect performance statistic of one queue of PF/VF. The function id
+is BDF of PF/VF, the "queue" filter option must be set to the exact queue
+id of function.
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x1020F,bdf=0x3500,queue=0/ -I 1000
+
+6. func-intr mode
+PMU collect performance statistic of one interrupt of PF/VF. The function
+id is BDF of PF/VF, the "intr" filter option must be set to the exact
+interrupt id of function.
+Example usage of perf::
+
+  $# perf stat -a -e hns3_pmu_sicl_0/config=0x00301,bdf=0x3500,intr=0/ -I 1000
-- 
2.33.0


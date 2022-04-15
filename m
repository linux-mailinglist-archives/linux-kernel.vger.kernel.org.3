Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF453502843
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352295AbiDOK2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDOK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:28:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE109284D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:25:31 -0700 (PDT)
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KfsqZ66jGzgYpc;
        Fri, 15 Apr 2022 18:23:38 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 18:25:29 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 15 Apr 2022 18:25:29 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v5 0/2] Add Support for HiSilicon CPA PMU
Date:   Fri, 15 Apr 2022 18:23:50 +0800
Message-ID: <20220415102352.6665-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Add Support for HiSilicon CPA PMU driver. Json file in perf tool
is applied in 
https://lore.kernel.org/linux-arm-kernel/YhkhSZp+a715Ldzr@kernel.org/.

Change since v4:
- Add hisi_cpa_pmu_enable_pm() for a failed probe.
- Link: https://lore.kernel.org/linux-arm-kernel/20220407124617.54521-1-liuqi115@huawei.com/

Change since v3:
- Add more explanation for changing CPA PMUs CPU affinity.
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220321070124.41338-1-liuqi115@huawei.com/

Change since v2:
- Associate CPA PMUs with CPUs online, rather than CPUs in the nearest SCCL.
- Move CPA power management to probe and remove function.
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220224111129.41416-1-liuqi115@huawei.com/

Change since v1:
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220214114228.40859-1-liuqi115@huawei.com/

Qi Liu (2):
  drivers/perf: hisi: Associate PMUs in SICL with CPUs online
  drivers/perf: hisi: Add Support for CPA PMU

 drivers/perf/hisilicon/Makefile              |   2 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 409 +++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c  |  18 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c     |   4 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h     |   1 +
 include/linux/cpuhotplug.h                   |   1 +
 6 files changed, 423 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c

-- 
2.24.0


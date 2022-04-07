Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01894F7F70
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiDGMt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245412AbiDGMtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:49:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3BD1104
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:47:51 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KZ1Jn69t5zBs6p;
        Thu,  7 Apr 2022 20:43:37 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 20:47:49 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 7 Apr 2022 20:47:49 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v4 0/2] Add Support for HiSilicon CPA PMU
Date:   Thu, 7 Apr 2022 20:46:15 +0800
Message-ID: <20220407124617.54521-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
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

Add Support for HiSilicon CPA PMU driver. Json file in perf tool
is applied in 
https://lore.kernel.org/linux-arm-kernel/YhkhSZp+a715Ldzr@kernel.org/.

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
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 401 +++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c  |  18 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c     |   4 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h     |   1 +
 include/linux/cpuhotplug.h                   |   1 +
 6 files changed, 415 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c

-- 
2.24.0


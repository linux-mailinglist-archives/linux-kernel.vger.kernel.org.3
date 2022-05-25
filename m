Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52F8533481
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 02:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242509AbiEYA6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 20:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242288AbiEYA6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 20:58:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7CD60AA5
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 17:58:13 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L7CLx4ldvz1JBsv;
        Wed, 25 May 2022 08:56:41 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 08:58:11 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 08:58:10 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <huangguangbin2@huawei.com>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>
Subject: [RESEND PATCH V7 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
Date:   Wed, 25 May 2022 08:52:09 +0800
Message-ID: <20220525005211.57059-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend this patch-set for adding reviewed-by of John Garry and
Shaokun Zhang.

This patch-set adds driver for HNS3(HiSilicon network system version 3)
PMU and doc to descript it.

Change logs:
V6 -> V7:
modify the comments of Will Deacon:
 - Modify format of event number shown for user.
 - Add a trailing space for func-intr when show filter mode.
 - Format the bdf number as the way "b:d.f" when show bdf_min and bdf_max.
 - Add subevent, event_type, ext_counter_used and real_event for
   hns3_pmu_format_attr[].
 - Link: https://lore.kernel.org/linux-arm-kernel/20220427121000.56026-1-huangguangbin2@huawei.com/
V5 -> V6:
 - Modify prefix hns3_get into hns3_pmu_get.
 - Some switch cases return directly.
 - Modify failed log when io remap failed.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220426132822.51735-1-huangguangbin2@huawei.com/
V4 -> V5:
 - Add COMPILE_TEST and include io-64-nonatomic-hi-lo.h as suggestion of
   John Garry.
V3 -> V4:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220329113930.37631-1-huangguangbin2@huawei.com/
V2 -> V3:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220228123955.30284-1-huangguangbin2@huawei.com/
V1 -> V2:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/ 

Guangbin Huang (2):
  drivers/perf: hisi: Add description for HNS3 PMU driver
  drivers/perf: hisi: add driver for HNS3 PMU

 Documentation/admin-guide/perf/hns3-pmu.rst |  136 ++
 MAINTAINERS                                 |    6 +
 drivers/perf/hisilicon/Kconfig              |   10 +
 drivers/perf/hisilicon/Makefile             |    1 +
 drivers/perf/hisilicon/hns3_pmu.c           | 1662 +++++++++++++++++++
 include/linux/cpuhotplug.h                  |    1 +
 6 files changed, 1816 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
 create mode 100644 drivers/perf/hisilicon/hns3_pmu.c

-- 
2.33.0


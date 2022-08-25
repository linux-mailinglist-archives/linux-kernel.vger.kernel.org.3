Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA325A0C75
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiHYJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239029AbiHYJWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:22:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC01140CB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:22:19 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MCy991tT3znTVX;
        Thu, 25 Aug 2022 17:19:57 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 17:22:17 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <sudeep.holla@arm.com>, <vincent.guittot@linaro.org>,
        <ionela.voinescu@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>
Subject: [PATCH v2] arch_topology: Make cluster topology span at least SMT CPUs
Date:   Thu, 25 Aug 2022 17:20:07 +0800
Message-ID: <20220825092007.8129-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Currently cpu_clustergroup_mask() will return CPU mask if cluster span more
or the same CPUs as cpu_coregroup_mask(). This will result topology borken
on non-Cluster SMT machines when building with CONFIG_SCHED_CLUSTER=y.

Test with:
qemu-system-aarch64 -enable-kvm -machine virt \
 -net none \
 -cpu host \
 -bios ./QEMU_EFI.fd \
 -m 2G \
 -smp 48,sockets=2,cores=12,threads=2 \
 -kernel $Image \
 -initrd $Rootfs \
 -nographic \
 -append "rdinit=init console=ttyAMA0 sched_verbose loglevel=8"

We'll get below error:
[    3.084568] BUG: arch topology borken
[    3.084570]      the SMT domain not a subset of the CLS domain

Since cluster is a level higher than SMT, fix this by making cluster
spans at least SMT CPUs.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Fixes: bfcc4397435d ("arch_topology: Limit span of cpu_clustergroup_mask()")
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
---
Change since v1:
- mention the kernel config CONFIG_SCHED_CLUSTER=y, per Ionela
Link:https://lore.kernel.org/lkml/20220823073044.58697-1-yangyicong@huawei.com/

 drivers/base/arch_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0424b59b695e..0056a1273275 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -724,7 +724,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
 	 */
 	if (cpumask_subset(cpu_coregroup_mask(cpu),
 			   &cpu_topology[cpu].cluster_sibling))
-		return get_cpu_mask(cpu);
+		return cpu_smt_mask(cpu);
 
 	return &cpu_topology[cpu].cluster_sibling;
 }
-- 
2.24.0


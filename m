Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4E542CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236386AbiFHKPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbiFHKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:13:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358920ED7E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:59:06 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJ2jC0TJMzjXrZ;
        Wed,  8 Jun 2022 17:58:07 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 17:59:04 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH v3 0/2] sched/fair: Wake task within the cluster when possible
Date:   Wed, 8 Jun 2022 17:57:56 +0800
Message-ID: <20220608095758.60504-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up work to support cluster scheduler. Previously
we have added cluster level in the scheduler for both ARM64[1] and
X86[2] to support load balance between clusters to bring more memory
bandwidth and decrease cache contention. This patchset, on the other
hand, takes care of wake-up path by giving CPUs within the same cluster
a try before scanning the whole LLC to benefit those tasks communicating
with each other.

[1] 778c558f49a2 ("sched: Add cluster scheduler level in core and related Kconfig for ARM64")
[2] 66558b730f25 ("sched: Add cluster scheduler level for x86")

Change since v2:
- leverage SIS_PROP to suspend redundant scanning when LLC is overloaded
- remove the ping-pong suppression
- address the comment from Tim, thanks.
Link: https://lore.kernel.org/lkml/20220126080947.4529-1-yangyicong@hisilicon.com/

Change since v1:
- regain the performance data based on v5.17-rc1
- rename cpus_share_cluster to cpus_share_resources per Vincent and Gautham, thanks!
Link: https://lore.kernel.org/lkml/20211215041149.73171-1-yangyicong@hisilicon.com/

Barry Song (2):
  sched: Add per_cpu cluster domain info and cpus_share_resources API
  sched/fair: Scan cluster before scanning LLC in wake-up path

 include/linux/sched/sd_flags.h |  7 ++++++
 include/linux/sched/topology.h |  8 ++++++-
 kernel/sched/core.c            | 12 ++++++++++
 kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 15 ++++++++++++
 6 files changed, 83 insertions(+), 4 deletions(-)

-- 
2.24.0


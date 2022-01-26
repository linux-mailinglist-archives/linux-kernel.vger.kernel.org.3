Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9449C4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiAZILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:11:10 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:32059 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiAZILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:11:07 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JkGXb2x9hz1FD6R;
        Wed, 26 Jan 2022 16:07:11 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 16:11:05 +0800
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
        <21cnbao@gmail.com>, <song.bao.hua@hisilicon.com>,
        <guodong.xu@linaro.org>
Subject: [PATCH v2 0/2] sched/fair: Wake task within the cluster when possible
Date:   Wed, 26 Jan 2022 16:09:45 +0800
Message-ID: <20220126080947.4529-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
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

Change since v1:
- regain the performance data based on v5.17-rc1
- rename cpus_share_cluster to cpus_share_resources per Vincent and Gautham, thanks!

Barry Song (2):
  sched: Add per_cpu cluster domain info and cpus_share_resources API
  sched/fair: Scan cluster before scanning LLC in wake-up path

 include/linux/sched/sd_flags.h |  7 ++++++
 include/linux/sched/topology.h |  8 +++++-
 kernel/sched/core.c            | 12 +++++++++
 kernel/sched/fair.c            | 46 +++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 15 +++++++++++
 6 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.24.0


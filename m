Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B123D5966EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiHQBng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237611AbiHQBnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:43:33 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B6440E00;
        Tue, 16 Aug 2022 18:43:31 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M6rLK1pfDz1M8s7;
        Wed, 17 Aug 2022 09:40:09 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:43:29 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 09:43:28 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "Josh Triplett" <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, <rcu@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 0/2] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in rcu_init_nohz()
Date:   Wed, 17 Aug 2022 09:42:51 +0800
Message-ID: <20220817014253.1982-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 --> v4:
Fix a build warning.
-       struct cpumask *cpumask = NULL;
+       const struct cpumask *cpumask = NULL;

v2 --> v3:
1. Eliminate rcu_state.nocb_is_setup
2. Update the code based on the above patch and commit b37a667c6242
   ("rcu/nocb: Add an option to offload all CPUs on boot").

Test cases and test results as below:

 ----------------------------------------------------------------------
| CONFIG_NO_HZ_FULL  | CONFIG_RCU_NOCB_CPU_DEFAULT_ALL |    cmdline    |
 ----------------------------------------------------------------------
1)         N         |                 N               |     none      |
2)         N         |                 N               | rcu_nocbs=1-2 |
3)         Y         |                 N               | nohz_full=1-2 |
4)         Y         |                 Y               |     none      |
 ----------------------------------------------------------------------

1)
[ 1085.691770] rcu-torture:--- End of test: SUCCESS: (default)
root@genericarmv8:~# dmesg | grep "Offload RCU callbacks"
[    0.000000] rcu:     Offload RCU callbacks from CPUs: (none).
root@genericarmv8:~# zcat /proc/config.gz | grep NOCB
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
root@genericarmv8:~# zcat /proc/config.gz | grep NO_HZ_FULL
# CONFIG_NO_HZ_FULL is not set
root@genericarmv8:~# cat /proc/cmdline
console=ttyAMA0 root=/dev/vda2 crashkernel=256M@ee000000

2)
[ 1022.532198] rcu-torture:--- End of test: SUCCESS: (default)
root@genericarmv8:~# dmesg | grep "Offload RCU callbacks"
[    0.000000] rcu:     Offload RCU callbacks from CPUs: 1-2.
root@genericarmv8:~# zcat /proc/config.gz | grep NOCB
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
root@genericarmv8:~# zcat /proc/config.gz | grep NO_HZ_FULL
# CONFIG_NO_HZ_FULL is not set
root@genericarmv8:~# cat /proc/cmdline
console=ttyAMA0 root=/dev/vda2 crashkernel=256M@ee000000 rcu_nocbs=1-2

3)
[ 1011.714712] rcu-torture:--- End of test: SUCCESS: (default)
root@genericarmv8:~# dmesg | grep "Offload RCU callbacks"
[    0.000000] rcu:     Offload RCU callbacks from CPUs: 1-2.
root@genericarmv8:~# zcat /proc/config.gz | grep NOCB
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
root@genericarmv8:~# zcat /proc/config.gz | grep NO_HZ_FULL
CONFIG_NO_HZ_FULL=y
root@genericarmv8:~# cat /proc/cmdline
console=ttyAMA0 root=/dev/vda2 crashkernel=256M@ee000000 nohz_full=1-2

4)
[ 1031.047094] rcu-torture:--- End of test: SUCCESS: (default)
root@genericarmv8:~# dmesg | grep "Offload RCU callbacks"
[    0.000000] rcu:     Offload RCU callbacks from CPUs: 0-3.
root@genericarmv8:~# zcat /proc/config.gz | grep NOCB
CONFIG_RCU_NOCB_CPU=y
CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
root@genericarmv8:~# zcat /proc/config.gz | grep NO_HZ_FULL
CONFIG_NO_HZ_FULL=y
root@genericarmv8:~# cat /proc/cmdline
console=ttyAMA0 root=/dev/vda2 crashkernel=256M@ee000000


v1 --> v2:
Update commit message.

Zhen Lei (2):
  rcu: Eliminate rcu_state.nocb_is_setup
  rcu: Simplify the code logic of rcu_init_nohz()

 kernel/rcu/tree.h      |  1 -
 kernel/rcu/tree_nocb.h | 38 +++++++++++---------------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.25.1


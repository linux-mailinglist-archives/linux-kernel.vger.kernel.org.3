Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D645A9852
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiIANTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234341AbiIANSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:18:49 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AE7C30A;
        Thu,  1 Sep 2022 06:16:03 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MJM2D32LbzHnYY;
        Thu,  1 Sep 2022 21:14:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:00 +0800
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 21:16:00 +0800
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
Subject: [PATCH v6 0/2] rcu/nocb: Delete local variable 'need_rcu_nocb_mask' in rcu_init_nohz()
Date:   Thu, 1 Sep 2022 21:14:34 +0800
Message-ID: <20220901131436.986-1-thunder.leizhen@huawei.com>
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

v5 --> v6:
1. Frist, update patch 1/2, so that, CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y takes
   effect only when there are no 'rcu_nocbs=' and 'nohz_full='. Retain the same
   semantics as the original.
2. Then, add patch 2/2, so that, CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y takes effect
   as long as there is no "rcu_nocbs=" boot parameter. This is suggested by
   Frederic Weisbecker.

Test cases and test results as below:
 ----------------------------------------------------------------------
| CONFIG_NO_HZ_FULL  | CONFIG_RCU_NOCB_CPU_DEFAULT_ALL |    cmdline    |
 ----------------------------------------------------------------------
1)         N         |                 N               |     none      |
2)         N         |                 N               | rcu_nocbs=1-2 |
3)         Y         |                 N               | nohz_full=2-3 |
4)         Y         |                 N               | rcu_nocbs=1 nohz_full=3 |
5)         Y         |                 Y               |      none     |
6)         Y         |                 Y               | rcu_nocbs=1-2 |
7)         Y         |                 Y               | nohz_full=2-3 |
8)         Y         |                 Y               | rcu_nocbs=1 nohz_full=3 |
 ----------------------------------------------------------------------

dmesg | grep "Offload RCU callbacks"
1) none
2) Offload RCU callbacks from CPUs: 1-2.
3) Offload RCU callbacks from CPUs: 2-3.
4) Offload RCU callbacks from CPUs: 1,3.
5) Offload RCU callbacks from CPUs: 0-3.
6) Offload RCU callbacks from CPUs: 1-2.
7) Offload RCU callbacks from CPUs: 0-3.
8) Offload RCU callbacks from CPUs: 1,3.


v4 --> v5:
1. Cancel eliminate rcu_state.nocb_is_setup. It is useful for case 1) below.

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
[ 1018.082417] rcu-torture:--- End of test: SUCCESS (default)
root@genericarmv8:~# dmesg | grep "Offload RCU callbacks"

root@genericarmv8:~# zcat /proc/config.gz | grep NOCB
CONFIG_RCU_NOCB_CPU=y
# CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
root@genericarmv8:~# zcat /proc/config.gz | grep NO_HZ_FULL
# CONFIG_NO_HZ_FULL is not set
root@genericarmv8:~# cat /proc/cmdline
console=ttyS0 earlyprintk=serial root=/dev/sda rw

2) 3) 4)
The same to v4.


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
  rcu: Simplify rcu_init_nohz() cpumask handling
  rcu: Offload callback processing from all CPUs in the absence of
    rcu_nocbs=

 kernel/rcu/Kconfig     |  4 ++--
 kernel/rcu/tree_nocb.h | 35 ++++++++++++-----------------------
 2 files changed, 14 insertions(+), 25 deletions(-)

-- 
2.25.1


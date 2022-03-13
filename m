Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46C4D7558
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiCMMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiCMMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:52:26 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7959AE49
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647175869; x=1678711869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HBXI7r7X3nnhgdcLq1B3/NblrZvIK2bp8FFIvQ0O2xQ=;
  b=j/4HXnGrg08mRgRH/CwVGJkEJopGY8L2ZqWJr5nxC9EajXIpx28cYr56
   yY7YnOj2TihLMg+gg/ESOXlblMd0fNyyi8Gkh76vCrMsaFsWcq9qkktn1
   2PWamPksbnvi3x578mWEgDKsi+6Fhy8m9PLTQx6Th91UYzx9KFtiqWvZq
   reW8NFF1rcX2mO74gJkSTN6QaFsJXaDjfqj+yelj0lBNdJD9yjuE6d84X
   HcUgQpa8BDC6Me2JEGHFmrULCN//YyiVLO86IsaqObsNq3K9/1NDiQ5AO
   /pZgmLQyWG9MBoWYnEQGhk1BgVbHtWZ41JRuovqVL4ATZeLR7caN7c1YI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="254696190"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="xz'?scan'208";a="254696190"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:51:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="xz'?scan'208";a="556020001"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:51:05 -0700
Date:   Sun, 13 Mar 2022 20:49:50 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     lkp@lists.01.org, lkp@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Subject: [EXP rcutorture]  556d8afe4a: BUG:workqueue_lockup-pool
Message-ID: <20220313124950.GA14898@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Paul,

we reported this commit as "[EXP rcutorture]  cd7bd64af5: BUG:workqueue_lockup-pool"
last month.

at that time, you requested us to test
25c0b105b7ba ("EXP rcu: Add polled expedited grace-period primitives")
and we confirmed the issue gone on this commit.

however, now we found this commit is already in linux-next/master,
but the issue seems still exists.

and we found the "EXP rcu: Add polled expedited grace-period primitives" is
actually the parent of this commit.

* 556d8afe4a779 EXP rcutorture: Test polled expedited grace-period primitives
* 6227afdc95e49 EXP rcu: Add polled expedited grace-period primitives

and since the issue still exists in lastest linux-next/master, so we report
this again for your information.


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 556d8afe4a779f41dfc8fa373993a88e43f1c5dc ("EXP rcutorture: Test polled expedited grace-period primitives")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: rcu

test-description: rcutorture is rcutorture kernel module load/unload test.
test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt


on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+--------------------------------------------------+------------+------------+
|                                                  | 6227afdc95 | 556d8afe4a |
+--------------------------------------------------+------------+------------+
| boot_successes                                   | 10         | 4          |
| boot_failures                                    | 0          | 6          |
| BUG:workqueue_lockup-pool                        | 0          | 6          |
| INFO:task_blocked_for_more_than#seconds          | 0          | 6          |
| Kernel_panic-not_syncing:hung_task:blocked_tasks | 0          | 6          |
+--------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[  408.705502][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 338s!
[  408.706448][    C1] Showing busy workqueues and worker pools:
[  408.707057][    C1] workqueue events: flags=0x0
[  408.707553][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  408.707613][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  408.707984][    C1] workqueue events_unbound: flags=0x2
[  408.711681][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  408.711733][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  408.711871][    C1] workqueue events_power_efficient: flags=0x80
[  408.714333][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  408.714384][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  408.716530][    C1] workqueue rcu_gp: flags=0x8
[  408.716915][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  408.716964][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  408.717002][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  408.717069][    C1] workqueue mm_percpu_wq: flags=0x8
[  408.719169][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  408.719220][    C1]     pending: vmstat_update
[  408.719267][    C1] workqueue cgroup_destroy: flags=0x0
[  408.720719][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  408.720775][    C1]     pending: css_killed_work_fn
[  408.720808][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  408.720969][    C1] workqueue ipv6_addrconf: flags=0x40008
[  408.723813][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  408.723858][    C1]     pending: addrconf_verify_work
[  408.723897][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=338s workers=3 idle: 23 36
[  408.723947][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  438.914180][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 368s!
[  438.915000][    C1] Showing busy workqueues and worker pools:
[  438.915495][    C1] workqueue events: flags=0x0
[  438.915869][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  438.915918][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  438.916204][    C1] workqueue events_unbound: flags=0x2
[  438.919292][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  438.919334][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  438.919451][    C1] workqueue events_power_efficient: flags=0x80
[  438.921618][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  438.921676][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  438.921825][    C1] workqueue rcu_gp: flags=0x8
[  438.923936][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  438.923981][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  438.924018][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  438.924077][    C1] workqueue mm_percpu_wq: flags=0x8
[  438.925910][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  438.925947][    C1]     pending: vmstat_update
[  438.925979][    C1] workqueue cgroup_destroy: flags=0x0
[  438.926981][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  438.927014][    C1]     pending: css_killed_work_fn
[  438.927034][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  438.927140][    C1] workqueue ipv6_addrconf: flags=0x40008
[  438.929584][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  438.929631][    C1]     pending: addrconf_verify_work
[  438.929677][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=368s workers=3 idle: 23 36
[  438.929734][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  469.121528][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 399s!
[  469.122375][    C1] Showing busy workqueues and worker pools:
[  469.122940][    C1] workqueue events: flags=0x0
[  469.123375][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  469.123443][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  469.126663][    C1] workqueue events_unbound: flags=0x2
[  469.127113][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  469.127162][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  469.127286][    C1] workqueue events_power_efficient: flags=0x80
[  469.129649][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  469.129693][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  469.129817][    C1] workqueue rcu_gp: flags=0x8
[  469.131968][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  469.132021][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  469.132064][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  469.132132][    C1] workqueue mm_percpu_wq: flags=0x8
[  469.134219][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  469.134275][    C1]     pending: vmstat_update
[  469.134323][    C1] workqueue cgroup_destroy: flags=0x0
[  469.135788][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  469.135843][    C1]     pending: css_killed_work_fn
[  469.135877][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  469.136035][    C1] workqueue ipv6_addrconf: flags=0x40008
[  469.138818][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  469.138876][    C1]     pending: addrconf_verify_work
[  469.138928][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=399s workers=3 idle: 23 36
[  469.138999][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  499.329506][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 429s!
[  499.330360][    C1] Showing busy workqueues and worker pools:
[  499.330933][    C1] workqueue events: flags=0x0
[  499.331287][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  499.331332][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  499.334522][    C1] workqueue events_unbound: flags=0x2
[  499.334966][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  499.334999][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  499.335119][    C1] workqueue events_power_efficient: flags=0x80
[  499.337451][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  499.337512][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  499.339525][    C1] workqueue rcu_gp: flags=0x8
[  499.339915][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  499.339967][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  499.340008][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  499.340073][    C1] workqueue mm_percpu_wq: flags=0x8
[  499.342140][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  499.342197][    C1]     pending: vmstat_update
[  499.342244][    C1] workqueue cgroup_destroy: flags=0x0
[  499.343789][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  499.343843][    C1]     pending: css_killed_work_fn
[  499.343877][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  499.344041][    C1] workqueue ipv6_addrconf: flags=0x40008
[  499.346756][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  499.346813][    C1]     pending: addrconf_verify_work
[  499.346866][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=429s workers=3 idle: 23 36
[  499.346933][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  529.537551][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 459s!
[  529.538415][    C1] Showing busy workqueues and worker pools:
[  529.538982][    C1] workqueue events: flags=0x0
[  529.539387][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  529.539447][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  529.542641][    C1] workqueue events_unbound: flags=0x2
[  529.543117][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
[  529.543154][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  529.543254][    C1]     pending: toggle_allocation_gate
[  529.543280][    C1] workqueue events_power_efficient: flags=0x80
[  529.546120][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  529.546177][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  529.546344][    C1] workqueue rcu_gp: flags=0x8
[  529.548606][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  529.548662][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  529.548704][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  529.548767][    C1] workqueue mm_percpu_wq: flags=0x8
[  529.550856][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  529.550912][    C1]     pending: vmstat_update
[  529.550969][    C1] workqueue cgroup_destroy: flags=0x0
[  529.552552][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  529.552608][    C1]     pending: css_killed_work_fn
[  529.552641][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  529.552804][    C1] workqueue ipv6_addrconf: flags=0x40008
[  529.555564][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  529.555620][    C1]     pending: addrconf_verify_work
[  529.555671][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=459s workers=3 idle: 23 36
[  529.555739][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  559.746304][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 489s!
[  559.747235][    C1] Showing busy workqueues and worker pools:
[  559.747797][    C1] workqueue events: flags=0x0
[  559.748212][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  559.748262][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  559.751350][    C1] workqueue events_unbound: flags=0x2
[  559.751813][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  559.751860][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  559.751984][    C1] workqueue events_power_efficient: flags=0x80
[  559.754423][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  559.754481][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  559.756567][    C1] workqueue rcu_gp: flags=0x8
[  559.756967][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  559.757012][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  559.757049][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  559.757108][    C1] workqueue mm_percpu_wq: flags=0x8
[  559.759130][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  559.759182][    C1]     pending: vmstat_update
[  559.759228][    C1] workqueue cgroup_destroy: flags=0x0
[  559.760711][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  559.760768][    C1]     pending: css_killed_work_fn
[  559.760802][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  559.760967][    C1] workqueue ipv6_addrconf: flags=0x40008
[  559.763732][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  559.763789][    C1]     pending: addrconf_verify_work
[  559.763837][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=489s workers=3 idle: 23 36
[  559.763906][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  589.953507][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 519s!
[  589.954311][    C1] Showing busy workqueues and worker pools:
[  589.954843][    C1] workqueue events: flags=0x0
[  589.955222][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  589.955276][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  589.958545][    C1] workqueue events_unbound: flags=0x2
[  589.959008][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  589.959055][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  589.959183][    C1] workqueue events_power_efficient: flags=0x80
[  589.961591][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  589.961640][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  589.961788][    C1] workqueue rcu_gp: flags=0x8
[  589.963963][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  589.964015][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  589.964056][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  589.964123][    C1] workqueue mm_percpu_wq: flags=0x8
[  589.966276][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  589.966332][    C1]     pending: vmstat_update
[  589.966379][    C1] workqueue cgroup_destroy: flags=0x0
[  589.967806][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  589.967856][    C1]     pending: css_killed_work_fn
[  589.967888][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  589.968037][    C1] workqueue ipv6_addrconf: flags=0x40008
[  589.970821][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  589.970879][    C1]     pending: addrconf_verify_work
[  589.970930][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=519s workers=3 idle: 23 36
[  589.970998][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  620.161550][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 550s!
[  620.162374][    C1] Showing busy workqueues and worker pools:
[  620.162952][    C1] workqueue events: flags=0x0
[  620.163356][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  620.163429][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  620.166742][    C1] workqueue events_unbound: flags=0x2
[  620.167203][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  620.167247][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  620.167384][    C1] workqueue events_power_efficient: flags=0x80
[  620.169800][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  620.169855][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  620.170007][    C1] workqueue rcu_gp: flags=0x8
[  620.172416][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  620.172466][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  620.172506][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  620.174272][    C1] workqueue mm_percpu_wq: flags=0x8
[  620.174791][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  620.174850][    C1]     pending: vmstat_update
[  620.174900][    C1] workqueue cgroup_destroy: flags=0x0
[  620.176449][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  620.176511][    C1]     pending: css_killed_work_fn
[  620.176545][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  620.178995][    C1] workqueue ipv6_addrconf: flags=0x40008
[  620.179458][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  620.179508][    C1]     pending: addrconf_verify_work
[  620.180619][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=550s workers=3 idle: 23 36
[  620.180678][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  650.369599][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 580s!
[  650.370205][    C1] Showing busy workqueues and worker pools:
[  650.370772][    C1] workqueue events: flags=0x0
[  650.371192][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  650.371248][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  650.374574][    C1] workqueue events_unbound: flags=0x2
[  650.375046][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  650.375094][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  650.375217][    C1] workqueue events_power_efficient: flags=0x80
[  650.377523][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  650.377581][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  650.377756][    C1] workqueue rcu_gp: flags=0x8
[  650.379967][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  650.380011][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  650.380044][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  650.380097][    C1] workqueue mm_percpu_wq: flags=0x8
[  650.382130][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  650.382185][    C1]     pending: vmstat_update
[  650.382231][    C1] workqueue cgroup_destroy: flags=0x0
[  650.383783][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  650.383834][    C1]     pending: css_killed_work_fn
[  650.383864][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  650.384013][    C1] workqueue ipv6_addrconf: flags=0x40008
[  650.386562][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  650.386618][    C1]     pending: addrconf_verify_work
[  650.386671][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=580s workers=3 idle: 23 36
[  650.386739][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  680.578270][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 610s!
[  680.579223][    C1] Showing busy workqueues and worker pools:
[  680.579757][    C1] workqueue events: flags=0x0
[  680.580171][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  680.580229][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  680.583530][    C1] workqueue events_unbound: flags=0x2
[  680.583987][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
[  680.584033][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  680.584152][    C1]     pending: toggle_allocation_gate
[  680.584184][    C1] workqueue events_power_efficient: flags=0x80
[  680.587166][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  680.587219][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  680.587389][    C1] workqueue rcu_gp: flags=0x8
[  680.589740][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  680.589793][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  680.589834][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  680.589900][    C1] workqueue mm_percpu_wq: flags=0x8
[  680.592043][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  680.592096][    C1]     pending: vmstat_update
[  680.592143][    C1] workqueue cgroup_destroy: flags=0x0
[  680.593720][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  680.593780][    C1]     pending: css_killed_work_fn
[  680.593816][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  680.593991][    C1] workqueue ipv6_addrconf: flags=0x40008
[  680.596853][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  680.596933][    C1]     pending: addrconf_verify_work
[  680.596981][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=610s workers=3 idle: 23 36
[  680.597046][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  710.785506][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 640s!
[  710.786354][    C1] Showing busy workqueues and worker pools:
[  710.786896][    C1] workqueue events: flags=0x0
[  710.787277][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  710.787331][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  710.790604][    C1] workqueue events_unbound: flags=0x2
[  710.791083][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  710.791133][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  710.791267][    C1] workqueue events_power_efficient: flags=0x80
[  710.793708][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  710.793765][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  710.793934][    C1] workqueue rcu_gp: flags=0x8
[  710.796240][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  710.796294][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  710.796335][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  710.796403][    C1] workqueue mm_percpu_wq: flags=0x8
[  710.798676][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  710.798728][    C1]     pending: vmstat_update
[  710.798775][    C1] workqueue cgroup_destroy: flags=0x0
[  710.800268][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  710.800324][    C1]     pending: css_killed_work_fn
[  710.800357][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  710.802827][    C1] workqueue ipv6_addrconf: flags=0x40008
[  710.803289][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  710.803345][    C1]     pending: addrconf_verify_work
[  710.803396][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=640s workers=3 idle: 23 36
[  710.803461][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  740.993516][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 670s!
[  740.994427][    C1] Showing busy workqueues and worker pools:
[  740.994975][    C1] workqueue events: flags=0x0
[  740.995387][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  740.995432][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  740.998508][    C1] workqueue events_unbound: flags=0x2
[  740.998989][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  740.999055][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  740.999175][    C1] workqueue events_power_efficient: flags=0x80
[  741.001710][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  741.001765][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  741.001922][    C1] workqueue rcu_gp: flags=0x8
[  741.004173][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  741.004223][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  741.004262][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  741.004326][    C1] workqueue mm_percpu_wq: flags=0x8
[  741.006403][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  741.006456][    C1]     pending: vmstat_update
[  741.007516][    C1] workqueue cgroup_destroy: flags=0x0
[  741.007988][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  741.008042][    C1]     pending: css_killed_work_fn
[  741.008072][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  741.008235][    C1] workqueue ipv6_addrconf: flags=0x40008
[  741.011076][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  741.011131][    C1]     pending: addrconf_verify_work
[  741.011181][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=671s workers=3 idle: 23 36
[  741.011244][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  771.201509][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 701s!
[  771.202368][    C1] Showing busy workqueues and worker pools:
[  771.202945][    C1] workqueue events: flags=0x0
[  771.203355][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  771.203416][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  771.206775][    C1] workqueue events_unbound: flags=0x2
[  771.207260][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  771.207307][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  771.207427][    C1] workqueue events_power_efficient: flags=0x80
[  771.209848][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  771.209909][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  771.210088][    C1] workqueue rcu_gp: flags=0x8
[  771.212125][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  771.212181][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  771.212224][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  771.212292][    C1] workqueue mm_percpu_wq: flags=0x8
[  771.214339][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  771.214392][    C1]     pending: vmstat_update
[  771.214437][    C1] workqueue cgroup_destroy: flags=0x0
[  771.215926][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  771.215987][    C1]     pending: css_killed_work_fn
[  771.216019][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  771.216189][    C1] workqueue ipv6_addrconf: flags=0x40008
[  771.219053][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  771.219323][    C1]     pending: addrconf_verify_work
[  771.219374][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=701s workers=3 idle: 23 36
[  771.219439][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  801.410329][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 731s!
[  801.411198][    C1] Showing busy workqueues and worker pools:
[  801.411729][    C1] workqueue events: flags=0x0
[  801.412126][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  801.412180][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  801.415504][    C1] workqueue events_unbound: flags=0x2
[  801.415971][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  801.416019][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  801.416144][    C1] workqueue events_power_efficient: flags=0x80
[  801.418610][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  801.418667][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  801.418822][    C1] workqueue rcu_gp: flags=0x8
[  801.421028][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  801.421073][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  801.421109][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  801.421163][    C1] workqueue mm_percpu_wq: flags=0x8
[  801.423291][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  801.423347][    C1]     pending: vmstat_update
[  801.423394][    C1] workqueue cgroup_destroy: flags=0x0
[  801.424904][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  801.424956][    C1]     pending: css_killed_work_fn
[  801.424988][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  801.425154][    C1] workqueue ipv6_addrconf: flags=0x40008
[  801.427954][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  801.428011][    C1]     pending: addrconf_verify_work
[  801.428064][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=731s workers=3 idle: 23 36
[  801.428134][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  831.617538][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 761s!
[  831.618345][    C1] Showing busy workqueues and worker pools:
[  831.618921][    C1] workqueue events: flags=0x0
[  831.619320][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  831.619380][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  831.622661][    C1] workqueue events_unbound: flags=0x2
[  831.623135][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  831.623191][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  831.623337][    C1] workqueue events_power_efficient: flags=0x80
[  831.626041][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  831.626122][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  831.626316][    C1] workqueue rcu_gp: flags=0x8
[  831.628626][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  831.628682][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  831.628728][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  831.628798][    C1] workqueue mm_percpu_wq: flags=0x8
[  831.631035][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  831.631098][    C1]     pending: vmstat_update
[  831.631150][    C1] workqueue cgroup_destroy: flags=0x0
[  831.632675][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  831.632731][    C1]     pending: css_killed_work_fn
[  831.632765][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  831.632955][    C1] workqueue ipv6_addrconf: flags=0x40008
[  831.635610][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  831.635653][    C1]     pending: addrconf_verify_work
[  831.635692][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=761s workers=3 idle: 23 36
[  831.635744][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  861.825544][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 791s!
[  861.826418][    C1] Showing busy workqueues and worker pools:
[  861.826963][    C1] workqueue events: flags=0x0
[  861.827374][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  861.827418][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  861.830571][    C1] workqueue events_unbound: flags=0x2
[  861.831021][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  861.831067][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  861.831190][    C1] workqueue events_power_efficient: flags=0x80
[  861.833611][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  861.833668][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  861.833838][    C1] workqueue rcu_gp: flags=0x8
[  861.836085][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  861.836128][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  861.836165][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  861.836223][    C1] workqueue mm_percpu_wq: flags=0x8
[  861.838322][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  861.838376][    C1]     pending: vmstat_update
[  861.838423][    C1] workqueue cgroup_destroy: flags=0x0
[  861.840003][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  861.840062][    C1]     pending: css_killed_work_fn
[  861.840120][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  861.840255][    C1] workqueue ipv6_addrconf: flags=0x40008
[  861.842948][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  861.842999][    C1]     pending: addrconf_verify_work
[  861.843048][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=791s workers=3 idle: 23 36
[  861.843118][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  892.033547][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 822s!
[  892.034444][    C1] Showing busy workqueues and worker pools:
[  892.035014][    C1] workqueue events: flags=0x0
[  892.035425][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  892.035485][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  892.038781][    C1] workqueue events_unbound: flags=0x2
[  892.039243][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
[  892.039288][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  892.039406][    C1]     pending: toggle_allocation_gate
[  892.039437][    C1] workqueue events_power_efficient: flags=0x80
[  892.042420][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  892.042482][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  892.044566][    C1] workqueue rcu_gp: flags=0x8
[  892.044969][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  892.045018][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  892.045057][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  892.045123][    C1] workqueue mm_percpu_wq: flags=0x8
[  892.047297][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  892.047355][    C1]     pending: vmstat_update
[  892.047402][    C1] workqueue cgroup_destroy: flags=0x0
[  892.048963][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  892.049035][    C1]     pending: css_killed_work_fn
[  892.049067][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  892.049230][    C1] workqueue ipv6_addrconf: flags=0x40008
[  892.052055][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  892.052118][    C1]     pending: addrconf_verify_work
[  892.052176][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=822s workers=3 idle: 23 36
[  892.052252][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  922.242347][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 852s!
[  922.243300][    C1] Showing busy workqueues and worker pools:
[  922.243812][    C1] workqueue events: flags=0x0
[  922.244216][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  922.244262][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  922.247381][    C1] workqueue events_unbound: flags=0x2
[  922.247877][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  922.247927][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  922.248053][    C1] workqueue events_power_efficient: flags=0x80
[  922.250508][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  922.250553][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  922.250689][    C1] workqueue rcu_gp: flags=0x8
[  922.252888][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  922.252939][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  922.252979][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  922.253044][    C1] workqueue mm_percpu_wq: flags=0x8
[  922.255182][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  922.255232][    C1]     pending: vmstat_update
[  922.255277][    C1] workqueue cgroup_destroy: flags=0x0
[  922.256691][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  922.256749][    C1]     pending: css_killed_work_fn
[  922.256784][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  922.256969][    C1] workqueue ipv6_addrconf: flags=0x40008
[  922.259659][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  922.259713][    C1]     pending: addrconf_verify_work
[  922.259760][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=852s workers=3 idle: 23 36
[  922.259823][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[  952.449517][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 882s!
[  952.450408][    C1] Showing busy workqueues and worker pools:
[  952.450995][    C1] workqueue events: flags=0x0
[  952.451428][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  952.451489][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  952.454524][    C1] workqueue events_unbound: flags=0x2
[  952.455011][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  952.455061][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  952.455195][    C1] workqueue events_power_efficient: flags=0x80
[  952.457674][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  952.457730][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  952.457880][    C1] workqueue rcu_gp: flags=0x8
[  952.460158][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  952.460205][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  952.460240][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  952.460303][    C1] workqueue mm_percpu_wq: flags=0x8
[  952.462396][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  952.462444][    C1]     pending: vmstat_update
[  952.463534][    C1] workqueue cgroup_destroy: flags=0x0
[  952.464021][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  952.464080][    C1]     pending: css_killed_work_fn
[  952.464113][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  952.464280][    C1] workqueue ipv6_addrconf: flags=0x40008
[  952.467161][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  952.467222][    C1]     pending: addrconf_verify_work
[  952.467275][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=882s workers=3 idle: 23 36
[  952.467347][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
[  982.657536][    C1] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 912s!
[  982.658425][    C1] Showing busy workqueues and worker pools:
[  982.659004][    C1] workqueue events: flags=0x0
[  982.659421][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
[  982.659480][    C1]     pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
[  982.662894][    C1] workqueue events_unbound: flags=0x2
[  982.663394][    C1]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
[  982.663445][    C1]     in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
[  982.665500][    C1] workqueue events_power_efficient: flags=0x80
[  982.665994][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
[  982.666044][    C1]     pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
[  982.666181][    C1] workqueue rcu_gp: flags=0x8
[  982.668550][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
[  982.668597][    C1]     in-flight: 179:sync_rcu_do_polled_gp
[  982.668634][    C1]     pending: sync_rcu_do_polled_gp, process_srcu
[  982.668695][    C1] workqueue mm_percpu_wq: flags=0x8
[  982.670910][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  982.670971][    C1]     pending: vmstat_update
[  982.671020][    C1] workqueue cgroup_destroy: flags=0x0
[  982.672512][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
[  982.672559][    C1]     pending: css_killed_work_fn
[  982.672587][    C1]     inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
[  982.672740][    C1] workqueue ipv6_addrconf: flags=0x40008
[  982.675414][    C1]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
[  982.675466][    C1]     pending: addrconf_verify_work
[  982.676570][    C1] pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=912s workers=3 idle: 23 36
[  982.676637][    C1] pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
[ 1004.162318][   T29] INFO: task systemd:1 blocked for more than 491 seconds.
[ 1004.163047][   T29]       Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
[ 1004.163690][   T29] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1004.164413][   T29] task:systemd         state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
[ 1004.165227][   T29] Call Trace:
[ 1004.165552][   T29]  <TASK>
[ 1004.165808][ T29] __schedule (kernel/sched/core.c:4986 kernel/sched/core.c:6296) 
[ 1004.166207][ T29] ? usleep_range_state (kernel/time/timer.c:1843) 
[ 1004.166670][ T29] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1)) 
[ 1004.167044][ T29] schedule_timeout (kernel/time/timer.c:1858) 
[ 1004.167498][ T29] ? hlock_class (kernel/locking/lockdep.c:199) 
[ 1004.167918][ T29] ? write_comp_data (kernel/kcov.c:221) 
[ 1004.168370][ T29] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:4293 kernel/locking/lockdep.c:4244) 
[ 1004.168962][ T29] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 1004.169435][ T29] __wait_for_common (kernel/sched/completion.c:86 kernel/sched/completion.c:106) 
[ 1004.169915][ T29] __flush_work (kernel/workqueue.c:3095) 
[ 1004.170331][ T29] ? flush_workqueue_prep_pwqs (kernel/workqueue.c:2660) 
[ 1004.170926][ T29] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 1004.171397][ T29] ? inotify_poll (fs/notify/inotify/inotify_user.c:288) 
[ 1004.171855][ T29] fsnotify_destroy_group (fs/notify/group.c:84 (discriminator 1)) 
[ 1004.172348][ T29] ? __sanitizer_cov_trace_pc (kernel/kcov.c:200) 
[ 1004.172852][ T29] ? locks_remove_file (fs/locks.c:2620) 
[ 1004.173300][ T29] ? inotify_poll (fs/notify/inotify/inotify_user.c:288) 
[ 1004.173722][ T29] inotify_release (fs/notify/inotify/inotify_user.c:297) 
[ 1004.174143][ T29] __fput (fs/file_table.c:312) 
[ 1004.174545][ T29] task_work_run (kernel/task_work.c:166 (discriminator 1)) 
[ 1004.175001][ T29] exit_to_user_mode_prepare (include/linux/tracehook.h:197 kernel/entry/common.c:175 kernel/entry/common.c:207) 
[ 1004.175548][ T29] syscall_exit_to_user_mode (kernel/entry/common.c:126 kernel/entry/common.c:302) 
[ 1004.176065][ T29] do_syscall_64 (arch/x86/entry/common.c:87) 
[ 1004.176511][ T29] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
[ 1004.177062][   T29] RIP: 0033:0x7fa39f4f7b54
[ 1004.177438][   T29] RSP: 002b:00007fffb0b4d7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[ 1004.178185][   T29] RAX: 0000000000000000 RBX: 0000000000000017 RCX: 00007fa39f4f7b54
[ 1004.178867][   T29] RDX: 00007fa39f5c8ca0 RSI: 0000000000000000 RDI: 0000000000000017
[ 1004.179606][   T29] RBP: 00007fa39e3468c0 R08: 00000000000000ef R09: 00007fa3a13f2060
[ 1004.180297][   T29] R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
[ 1004.181006][   T29] R13: 00007fffb0b4d890 R14: 0000000000000001 R15: 00007fa39f6e3a8e
[ 1004.181724][   T29]  </TASK>
[ 1004.182001][   T29] INFO: task kworker/u4:1:9 blocked for more than 491 seconds.
[ 1004.182640][   T29]       Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
[ 1004.183221][   T29] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1004.183958][   T29] task:kworker/u4:1    state:D stack:    0 pid:    9 ppid:     2 flags:0x00004000
[ 1004.184769][   T29] Workqueue: events_unbound fsnotify_connector_destroy_workfn
[ 1004.185432][   T29] Call Trace:
[ 1004.185753][   T29]  <TASK>
[ 1004.186042][ T29] __schedule (kernel/sched/core.c:4986 kernel/sched/core.c:6296) 
[ 1004.186441][ T29] ? to_kthread (kernel/kthread.c:77 (discriminator 3)) 
[ 1004.186867][ T29] ? usleep_range_state (kernel/time/timer.c:1843) 
[ 1004.187313][ T29] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1)) 
[ 1004.187713][ T29] schedule_timeout (kernel/time/timer.c:1858) 
[ 1004.188141][ T29] ? mark_held_locks (kernel/locking/lockdep.c:4206) 
[ 1004.188598][ T29] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:4293 kernel/locking/lockdep.c:4244) 
[ 1004.189130][ T29] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 1004.189611][ T29] __wait_for_common (kernel/sched/completion.c:86 kernel/sched/completion.c:106) 
[ 1004.190073][ T29] __synchronize_srcu (kernel/rcu/srcutree.c:1154) 
[ 1004.190574][ T29] ? rcu_tasks_pregp_step (kernel/rcu/update.c:367) 
[ 1004.191049][ T29] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 1004.191549][ T29] fsnotify_connector_destroy_workfn (fs/notify/mark.c:165) 
[ 1004.192112][ T29] process_one_work (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/linux/jump_label.h:266 include/linux/jump_label.h:276 include/trace/events/workqueue.h:108 kernel/workqueue.c:2312) 
[ 1004.192605][ T29] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2455) 
[ 1004.193020][ T29] ? rescuer_thread (kernel/workqueue.c:2397) 
[ 1004.193452][ T29] kthread (kernel/kthread.c:377) 
[ 1004.193834][ T29] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 1004.194326][ T29] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[ 1004.194768][   T29]  </TASK>
[ 1004.195061][   T29] INFO: task kworker/u4:2:40 blocked for more than 491 seconds.
[ 1004.195713][   T29]       Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
[ 1004.196309][   T29] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1004.197064][   T29] task:kworker/u4:2    state:D stack:    0 pid:   40 ppid:     2 flags:0x00004000
[ 1004.197887][   T29] Workqueue: events_unbound fsnotify_mark_destroy_workfn
[ 1004.198529][   T29] Call Trace:
[ 1004.198816][   T29]  <TASK>
[ 1004.199095][ T29] __schedule (kernel/sched/core.c:4986 kernel/sched/core.c:6296) 
[ 1004.199524][ T29] ? to_kthread (kernel/kthread.c:77 (discriminator 3)) 
[ 1004.199911][ T29] ? usleep_range_state (kernel/time/timer.c:1843) 
[ 1004.200369][ T29] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1)) 
[ 1004.200769][ T29] schedule_timeout (kernel/time/timer.c:1858) 
[ 1004.201213][ T29] ? mark_held_locks (kernel/locking/lockdep.c:4206) 
[ 1004.201689][ T29] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:4293 kernel/locking/lockdep.c:4244) 
[ 1004.202245][ T29] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 1004.202716][ T29] __wait_for_common (kernel/sched/completion.c:86 kernel/sched/completion.c:106) 
[ 1004.203170][ T29] __synchronize_srcu (kernel/rcu/srcutree.c:1154) 
[ 1004.203638][ T29] ? rcu_tasks_pregp_step (kernel/rcu/update.c:367) 
[ 1004.204121][ T29] ? __wait_for_common (kernel/sched/completion.c:74 kernel/sched/completion.c:106) 
[ 1004.204625][ T29] fsnotify_mark_destroy_workfn (fs/notify/mark.c:866) 
[ 1004.205153][ T29] process_one_work (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-instrumented.h:28 include/linux/jump_label.h:266 include/linux/jump_label.h:276 include/trace/events/workqueue.h:108 kernel/workqueue.c:2312) 
[ 1004.205643][ T29] worker_thread (include/linux/list.h:292 kernel/workqueue.c:2455) 
[ 1004.206080][ T29] ? rescuer_thread (kernel/workqueue.c:2397) 
[ 1004.206559][ T29] kthread (kernel/kthread.c:377) 
[ 1004.206931][ T29] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 1004.207426][ T29] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[ 1004.207878][   T29]  </TASK>
[ 1004.208180][   T29] INFO: task rmmod:1812 blocked for more than 491 seconds.
[ 1004.208797][   T29]       Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
[ 1004.209395][   T29] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1004.210155][   T29] task:rmmod           state:D stack:    0 pid: 1812 ppid:   508 flags:0x00004000
[ 1004.210953][   T29] Call Trace:
[ 1004.211243][   T29]  <TASK>
[ 1004.211532][ T29] __schedule (kernel/sched/core.c:4986 kernel/sched/core.c:6296) 
[ 1004.211961][ T29] ? usleep_range_state (kernel/time/timer.c:1843) 
[ 1004.212427][ T29] schedule (arch/x86/include/asm/preempt.h:85 (discriminator 1) kernel/sched/core.c:6370 (discriminator 1)) 
[ 1004.212846][ T29] schedule_timeout (kernel/time/timer.c:1858) 
[ 1004.213296][ T29] ? hlock_class (kernel/locking/lockdep.c:199) 
[ 1004.213723][ T29] ? write_comp_data (kernel/kcov.c:221) 
[ 1004.214161][ T29] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:4293 kernel/locking/lockdep.c:4244) 
[ 1004.214723][ T29] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:45 arch/x86/include/asm/irqflags.h:80 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 1004.215223][ T29] __wait_for_common (kernel/sched/completion.c:86 kernel/sched/completion.c:106) 
[ 1004.215702][ T29] kthread_stop (kernel/kthread.c:710) 
[ 1004.216129][ T29] _torture_stop_kthread (kernel/torture.c:956 (discriminator 3)) torture
[ 1004.216618][ T29] rcu_torture_cleanup (kernel/rcu/rcutorture.c:2995) rcutorture
[ 1004.217140][ T29] ? prepare_to_wait_exclusive (kernel/sched/wait.c:415) 
[ 1004.217667][ T29] __x64_sys_delete_module (kernel/module.c:969 kernel/module.c:912 kernel/module.c:912) 
[ 1004.218150][ T29] ? lockdep_hardirqs_on_prepare (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:4293 kernel/locking/lockdep.c:4244) 
[ 1004.218695][ T29] do_syscall_64 (arch/x86/entry/common.c:67 arch/x86/entry/common.c:80) 
[ 1004.219103][ T29] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113) 
[ 1004.219635][   T29] RIP: 0033:0x7f93a158add7
[ 1004.220037][   T29] RSP: 002b:00007ffd6aef9048 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 1004.220804][   T29] RAX: ffffffffffffffda RBX: 00007f93a3179900 RCX: 00007f93a158add7
[ 1004.221533][   T29] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00007f93a3179968
[ 1004.222218][   T29] RBP: 0000000000000000 R08: 00007ffd6aef7fc1 R09: 0000000000000000
[ 1004.222940][   T29] R10: 00007f93a15fcae0 R11: 0000000000000206 R12: 00007ffd6aef9270
[ 1004.223624][   T29] R13: 00007ffd6aefadfc R14: 00007f93a3179260 R15: 00007f93a3179900
[ 1004.224302][   T29]  </TASK>
[ 1004.224593][   T29]
[ 1004.224593][   T29] Showing all locks held in the system:
[ 1004.225166][   T29] 2 locks held by kworker/u4:1/9:
[ 1004.225587][ T29] #0: ffff9b4480051548 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2278) 
[ 1004.226554][ T29] #1: ffff9b448016fe78 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2278) 
[ 1004.227509][   T29] 1 lock held by khungtaskd/29:
[ 1004.227914][ T29] #0: ffffffffbaddd460 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire (include/linux/rcupdate.h:267) 
[ 1004.228845][   T29] 2 locks held by kworker/u4:2/40:
[ 1004.229296][ T29] #0: ffff9b4480051548 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2278) 
[ 1004.230227][ T29] #1: ffff9b4480c93e78 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work (kernel/workqueue.c:2278) 
[ 1004.231129][   T29] 2 locks held by kworker/1:2/179:
[ 1004.231578][   T29] 1 lock held by in:imklog/431:
[ 1004.231981][   T29] 1 lock held by dmesg/440:
[ 1004.232337][   T29]
[ 1004.232570][   T29] =============================================
[ 1004.232570][   T29]
[ 1004.233244][   T29] Kernel panic - not syncing: hung_task: blocked tasks
[ 1004.233796][   T29] CPU: 1 PID: 29 Comm: khungtaskd Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
[ 1004.234584][   T29] Call Trace:
[ 1004.234898][   T29]  <TASK>
[ 1004.235182][ T29] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[ 1004.235600][ T29] panic (kernel/panic.c:251) 
[ 1004.235952][ T29] ? _printk (kernel/printk/printk.c:2270) 
[ 1004.236313][ T29] ? watchdog (kernel/hung_task.c:216 kernel/hung_task.c:369) 
[ 1004.236698][ T29] watchdog (kernel/hung_task.c:370) 
[ 1004.237098][ T29] ? rcu_read_unlock (init/main.c:1291) 
[ 1004.237530][ T29] kthread (kernel/kthread.c:377) 
[ 1004.237898][ T29] ? kthread_complete_and_exit (kernel/kthread.c:332) 
[ 1004.238409][ T29] ret_from_fork (arch/x86/entry/entry_64.S:301) 
[ 1004.238815][   T29]  </TASK>
[ 1004.239265][   T29] Kernel Offset: 0x38200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Kboot worker: lkp-worker57
Elapsed time: 1020

kvm=(
qemu-system-x86_64
-enable-kvm
-cpu SandyBridge
-kernel $kernel
-initrd initrd-vm-snb-67.cgz
-m 16384
-smp 2
-device e1000,netdev=net0
-netdev user,id=net0,hostfwd=tcp::32032-:22
-boot order=nc
-no-reboot
-watchdog i6300esb
-watchdog-action debug
-rtc base=localtime
-serial stdio
-display none
-monitor null
)

append=(
ip=::::vm-snb-67::dhcp
root=/dev/ram0
RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77
branch=linux-devel/devel-hourly-20220304-094445
job=/job-script
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20210928
commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc
vmalloc=128M
initramfs_async=0
page_owner=on
max_uptime=2100


To reproduce:

        # build kernel
	cd linux
	cp config-5.17.0-rc1-00111-g556d8afe4a77 .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/lkp@lists.01.org

Thanks,
Oliver Sang


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.17.0-rc1-00111-g556d8afe4a77"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.17.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
# CONFIG_UAPI_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
CONFIG_KERNEL_BZIP2=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_KMEM=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_MISC=y
CONFIG_CGROUP_DEBUG=y
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

# CONFIG_VM_EVENT_COUNTERS is not set
# CONFIG_SLUB_DEBUG is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_AUDIT_ARCH=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=m
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_PROCESSOR_SELECT=y
CONFIG_CPU_SUP_INTEL=y
# CONFIG_CPU_SUP_AMD is not set
# CONFIG_CPU_SUP_HYGON is not set
# CONFIG_CPU_SUP_CENTAUR is not set
# CONFIG_CPU_SUP_ZHAOXIN is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_DMI is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
# CONFIG_X86_MCE_INTEL is not set
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
# CONFIG_PERF_EVENTS_INTEL_UNCORE is not set
CONFIG_PERF_EVENTS_INTEL_RAPL=m
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
# end of Performance monitoring

CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_NUMA is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
# CONFIG_MTRR is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
CONFIG_X86_INTEL_TSX_MODE_ON=y
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_X86_SGX=y
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
# CONFIG_MODIFY_LDT_SYSCALL is not set
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_TABLE_LIB=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
CONFIG_ACPI_THERMAL=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_DEBUG=y
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=y
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_CONFIGFS=y
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=m
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=m
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_SPEEDSTEP_CENTRINO=m
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
# CONFIG_ISA_DMA_API is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_VMAP_STACK is not set
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y
CONFIG_HAVE_ARCH_NODE_DEV_GROUP=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
CONFIG_MODULE_SIG_SHA384=y
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha384"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
# CONFIG_BLOCK is not set
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
CONFIG_TRANSPARENT_HUGEPAGE=y
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=m
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
# CONFIG_ZONE_DMA is not set
CONFIG_ZONE_DMA32=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
# CONFIG_ATM_CLIP is not set
# CONFIG_ATM_LANE is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_BRIDGE_MRP=y
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
CONFIG_LAPB=m
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
# CONFIG_NET_SCH_TEQL is not set
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_DSMARK is not set
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=y
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=y
CONFIG_NET_CLS_TCINDEX=y
# CONFIG_NET_CLS_ROUTE4 is not set
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
# CONFIG_CLS_U32_PERF is not set
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_CLS_MATCHALL=m
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
CONFIG_BATMAN_ADV_NC=y
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUG=y
# CONFIG_BATMAN_ADV_TRACING is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
# CONFIG_MPLS_ROUTING is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
CONFIG_QRTR_TUN=m
CONFIG_QRTR_MHI=m
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
CONFIG_AX25_DAMA_SLAVE=y
CONFIG_NETROM=y
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
# CONFIG_BPQETHER is not set
# CONFIG_BAYCOM_SER_FDX is not set
# CONFIG_BAYCOM_SER_HDX is not set
CONFIG_BAYCOM_PAR=m
CONFIG_YAM=m
# end of AX.25 network device drivers

CONFIG_CAN=m
# CONFIG_CAN_RAW is not set
CONFIG_CAN_BCM=m
# CONFIG_CAN_GW is not set
# CONFIG_CAN_J1939 is not set
CONFIG_CAN_ISOTP=m

#
# CAN Device Drivers
#
# CONFIG_CAN_VCAN is not set
CONFIG_CAN_VXCAN=m
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
CONFIG_CAN_FLEXCAN=m
CONFIG_CAN_GRCAN=m
CONFIG_CAN_KVASER_PCIEFD=m
# CONFIG_CAN_C_CAN is not set
CONFIG_CAN_CC770=m
CONFIG_CAN_CC770_ISA=m
# CONFIG_CAN_CC770_PLATFORM is not set
# CONFIG_CAN_IFI_CANFD is not set
CONFIG_CAN_M_CAN=m
CONFIG_CAN_M_CAN_PCI=m
CONFIG_CAN_M_CAN_PLATFORM=m
CONFIG_CAN_PEAK_PCIEFD=m
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
CONFIG_CAN_EMS_PCMCIA=m
CONFIG_CAN_F81601=m
CONFIG_CAN_KVASER_PCI=m
# CONFIG_CAN_PEAK_PCI is not set
CONFIG_CAN_PEAK_PCMCIA=m
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
# CONFIG_CAN_SOFTING is not set

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
# CONFIG_CAN_EMS_USB is not set
CONFIG_CAN_ESD_USB2=m
CONFIG_CAN_ETAS_ES58X=m
CONFIG_CAN_GS_USB=m
CONFIG_CAN_KVASER_USB=m
CONFIG_CAN_MCBA_USB=m
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
# CONFIG_BT_RFCOMM is not set
CONFIG_BT_BNEP=y
# CONFIG_BT_BNEP_MC_FILTER is not set
CONFIG_BT_BNEP_PROTO_FILTER=y
# CONFIG_BT_HIDP is not set
CONFIG_BT_HS=y
# CONFIG_BT_LE is not set
CONFIG_BT_LEDS=y
CONFIG_BT_MSFTEXT=y
# CONFIG_BT_AOSPEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set
# CONFIG_BT_FEATURE_DEBUG is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
# CONFIG_BT_HCIBTUSB_RTL is not set
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
# CONFIG_BT_HCIUART_ATH3K is not set
CONFIG_BT_HCIUART_INTEL=y
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIBCM203X is not set
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIDTL1=m
CONFIG_BT_HCIBT3C=m
# CONFIG_BT_HCIBLUECARD is not set
CONFIG_BT_HCIVHCI=m
# CONFIG_BT_MRVL is not set
# CONFIG_BT_ATH3K is not set
CONFIG_BT_VIRTIO=m
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=y
CONFIG_RFKILL_LEDS=y
# CONFIG_RFKILL_INPUT is not set
CONFIG_RFKILL_GPIO=y
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=y
# CONFIG_CAIF_USB is not set
# CONFIG_CEPH_LIB is not set
CONFIG_NFC=m
# CONFIG_NFC_DIGITAL is not set
# CONFIG_NFC_NCI is not set
CONFIG_NFC_HCI=m
# CONFIG_NFC_SHDLC is not set

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_PN533=m
CONFIG_NFC_PN533_USB=m
CONFIG_NFC_PN533_I2C=m
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=y
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
# CONFIG_PCIEASPM is not set
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
# CONFIG_PCIE_BUS_DEFAULT is not set
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
CONFIG_PCIE_BUS_PEER2PEER=y
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=y
# CONFIG_PCI_HOST_GENERIC is not set

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
CONFIG_PCIE_CADENCE_PLAT=y
CONFIG_PCIE_CADENCE_PLAT_HOST=y
# CONFIG_PCI_J721E_HOST is not set
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=m
# end of PCI switch controller drivers

CONFIG_CXL_BUS=m
CONFIG_CXL_MEM=m
CONFIG_CXL_MEM_RAW_COMMANDS=y
CONFIG_CXL_ACPI=m
CONFIG_PCCARD=y
CONFIG_PCMCIA=m
CONFIG_PCMCIA_LOAD_CIS=y
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
CONFIG_PD6729=m
CONFIG_I82092=m
CONFIG_PCCARD_NONSTATIC=y
CONFIG_RAPIDIO=m
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=m
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=m

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_CPS_XX=m
CONFIG_RAPIDIO_CPS_GEN2=m
CONFIG_RAPIDIO_RXS_GEN3=m
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SLIMBUS=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
CONFIG_MHI_BUS_PCI_GENERIC=m
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_GNSS=m
# CONFIG_GNSS_USB is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_RESERVED_MEM=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y

#
# NVME Support
#
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
CONFIG_PHANTOM=m
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=y
CONFIG_HP_ILO=m
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
CONFIG_HMC6352=m
CONFIG_DS1682=m
# CONFIG_VMWARE_BALLOON is not set
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=m
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=y
# CONFIG_HISI_HIKEY_USB is not set
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
CONFIG_EEPROM_IDT_89HPESX=m
CONFIG_EEPROM_EE1004=m
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=m
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
CONFIG_ALTERA_STAPL=m
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
CONFIG_ECHO=m
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=m
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=m
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# end of SCSI device support

# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=m
# CONFIG_FIREWIRE_NET is not set
CONFIG_FIREWIRE_NOSY=m
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
# CONFIG_MAC_EMUMOUSEBTN is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_RIONET is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=y
# CONFIG_ATM_DUMMY is not set
# CONFIG_ATM_TCP is not set
# CONFIG_ATM_LANAI is not set
# CONFIG_ATM_ENI is not set
# CONFIG_ATM_FIRESTREAM is not set
# CONFIG_ATM_ZATM is not set
# CONFIG_ATM_NICSTAR is not set
# CONFIG_ATM_IDT77252 is not set
# CONFIG_ATM_AMBASSADOR is not set
# CONFIG_ATM_HORIZON is not set
# CONFIG_ATM_IA is not set
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
# CONFIG_ATM_SOLOS is not set
# CONFIG_CAIF_DRIVERS is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
# CONFIG_LITEX_LITEETH is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_USB4_NET is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=m

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_IQS62X is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=y
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=y
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=y
CONFIG_JOYSTICK_IFORCE_USB=m
CONFIG_JOYSTICK_IFORCE_232=m
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
# CONFIG_JOYSTICK_STINGER is not set
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=m
# CONFIG_JOYSTICK_DB9 is not set
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=m
CONFIG_JOYSTICK_AS5011=m
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=m
# CONFIG_JOYSTICK_XPAD_FF is not set
CONFIG_JOYSTICK_XPAD_LEDS=y
# CONFIG_JOYSTICK_PXRC is not set
# CONFIG_JOYSTICK_QWIIC is not set
CONFIG_JOYSTICK_FSIA6B=m
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=y
CONFIG_TABLET_USB_PEGASUS=y
# CONFIG_TABLET_SERIAL_WACOM4 is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM80X_ONKEY is not set
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_ATC260X_ONKEY=m
CONFIG_INPUT_ATMEL_CAPTOUCH=m
CONFIG_INPUT_BMA150=m
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_MAX77650_ONKEY=m
CONFIG_INPUT_MC13783_PWRBUTTON=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=y
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
CONFIG_INPUT_CM109=y
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_RETU_PWRBUTTON is not set
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_UINPUT=y
# CONFIG_INPUT_PCF50633_PMU is not set
# CONFIG_INPUT_PCF8574 is not set
CONFIG_INPUT_RK805_PWRKEY=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=m
CONFIG_INPUT_DA9063_ONKEY=m
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_IMS_PCU is not set
CONFIG_INPUT_IQS269A=m
# CONFIG_INPUT_IQS626A is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
CONFIG_SERIO_APBPS2=m
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=m
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_PNP is not set
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=m
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_PERICOM=y
# CONFIG_SERIAL_OF_PLATFORM is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
CONFIG_SERIAL_LANTIQ=m
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=m
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=m
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_MOXA_INTELLIO=m
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK_GT=y
CONFIG_N_HDLC=y
# CONFIG_GOLDFISH_TTY is not set
# CONFIG_N_GSM is not set
CONFIG_NOZOMI=m
CONFIG_NULL_TTY=y
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=y
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=y
# CONFIG_VIRTIO_CONSOLE is not set
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=y
# CONFIG_HW_RANDOM_VIA is not set
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_CCTRNG=m
CONFIG_HW_RANDOM_XIPHERA=m
CONFIG_APPLICOM=y

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
CONFIG_HPET=y
# CONFIG_HPET_MMAP is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
# CONFIG_HW_RANDOM_TPM is not set
CONFIG_TCG_TIS_CORE=m
CONFIG_TCG_TIS=m
CONFIG_TCG_TIS_I2C_CR50=m
CONFIG_TCG_TIS_I2C_ATMEL=m
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=m
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=m
CONFIG_XILLYBUS_OF=m
CONFIG_XILLYUSB=y
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=m
CONFIG_I2C_ALI1563=m
CONFIG_I2C_ALI15X3=m
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=m
# CONFIG_I2C_I801 is not set
CONFIG_I2C_ISCH=m
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
CONFIG_I2C_NFORCE2=m
# CONFIG_I2C_NFORCE2_S4985 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
CONFIG_I2C_SIS5595=m
CONFIG_I2C_SIS630=m
CONFIG_I2C_SIS96X=m
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_SLAVE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_KEMPLD=m
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
# CONFIG_I2C_DLN2 is not set
CONFIG_I2C_CP2615=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_ROBOTFUZZ_OSIF=m
CONFIG_I2C_TAOS_EVM=m
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_FSI=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
CONFIG_I2C_SLAVE_TESTUNIT=m
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=m
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=m
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_GENERIC_PINCTRL_GROUPS=y
CONFIG_PINMUX=y
CONFIG_GENERIC_PINMUX_FUNCTIONS=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_DA9062=m
CONFIG_PINCTRL_EQUILIBRIUM=m
CONFIG_PINCTRL_MCP23S08_I2C=m
CONFIG_PINCTRL_MCP23S08=m
# CONFIG_PINCTRL_MICROCHIP_SGPIO is not set
CONFIG_PINCTRL_OCELOT=y
CONFIG_PINCTRL_RK805=m
# CONFIG_PINCTRL_SINGLE is not set
# CONFIG_PINCTRL_STMFX is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
CONFIG_PINCTRL_CHERRYVIEW=y
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_ALDERLAKE is not set
CONFIG_PINCTRL_BROXTON=m
# CONFIG_PINCTRL_CANNONLAKE is not set
CONFIG_PINCTRL_CEDARFORK=m
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
CONFIG_PINCTRL_EMMITSBURG=y
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=m
CONFIG_PINCTRL_JASPERLAKE=y
CONFIG_PINCTRL_LAKEFIELD=m
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=m
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_CADENCE=m
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_FTGPIO010 is not set
CONFIG_GPIO_GENERIC_PLATFORM=y
CONFIG_GPIO_GRGPIO=y
# CONFIG_GPIO_HLWD is not set
CONFIG_GPIO_ICH=y
CONFIG_GPIO_LOGICVC=m
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_SAMA5D2_PIOBU=y
# CONFIG_GPIO_SIFIVE is not set
CONFIG_GPIO_SYSCON=y
CONFIG_GPIO_VX855=m
CONFIG_GPIO_WCD934X=m
CONFIG_GPIO_XILINX=y
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
CONFIG_GPIO_104_IDIO_16=m
# CONFIG_GPIO_104_IDI_48 is not set
CONFIG_GPIO_F7188X=y
CONFIG_GPIO_GPIO_MM=m
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_GW_PLD=m
# CONFIG_GPIO_MAX7300 is not set
CONFIG_GPIO_MAX732X=m
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ARIZONA=m
CONFIG_GPIO_BD9571MWV=m
CONFIG_GPIO_DLN2=m
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_MAX77650 is not set
# CONFIG_GPIO_TPS65086 is not set
CONFIG_GPIO_TPS65218=m
CONFIG_GPIO_TPS65912=m
# CONFIG_GPIO_TQMX86 is not set
CONFIG_GPIO_WM8994=m
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
CONFIG_GPIO_BT8XX=y
CONFIG_GPIO_ML_IOH=m
CONFIG_GPIO_PCI_IDIO_16=y
CONFIG_GPIO_PCIE_IDIO_24=m
CONFIG_GPIO_RDC321X=y
CONFIG_GPIO_SODAVILLE=y
# end of PCI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=m
CONFIG_GPIO_MOCKUP=y
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2490=y
# CONFIG_W1_MASTER_DS2482 is not set
CONFIG_W1_MASTER_DS1WM=y
CONFIG_W1_MASTER_GPIO=y
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=m
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=y
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
# CONFIG_W1_SLAVE_DS2413 is not set
CONFIG_W1_SLAVE_DS2406=m
CONFIG_W1_SLAVE_DS2423=m
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=m
CONFIG_POWER_RESET_GPIO=y
# CONFIG_POWER_RESET_GPIO_RESTART is not set
# CONFIG_POWER_RESET_LTC2952 is not set
# CONFIG_POWER_RESET_REGULATOR is not set
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_NVMEM_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
# CONFIG_BATTERY_ACT8945A is not set
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=m
CONFIG_BATTERY_DS2780=y
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_MAX17040=m
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_ISP1704=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
CONFIG_CHARGER_MAX14577=m
CONFIG_CHARGER_DETECTOR_MAX14656=m
# CONFIG_CHARGER_MAX77650 is not set
# CONFIG_CHARGER_MAX77693 is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_MT6360 is not set
CONFIG_CHARGER_BQ2415X=m
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
# CONFIG_CHARGER_UCS1002 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
CONFIG_SENSORS_AXI_FAN_CONTROL=y
CONFIG_SENSORS_K8TEMP=m
# CONFIG_SENSORS_APPLESMC is not set
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=y
CONFIG_SENSORS_CORSAIR_PSU=m
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=m
# CONFIG_SENSORS_GSC is not set
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_GL518SM=m
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=m
# CONFIG_SENSORS_GPIO_FAN is not set
CONFIG_SENSORS_HIH6130=m
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=y
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
CONFIG_SENSORS_MAX127=m
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=m
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=m
# CONFIG_SENSORS_LM95245 is not set
CONFIG_SENSORS_PC87360=m
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NPCM7XX=m
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SBTSI=m
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=y
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHT4x=m
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP513=m
CONFIG_SENSORS_VIA_CPUTEMP=y
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=m
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=y
# CONFIG_SENSORS_W83627EHF is not set
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_OF is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_DEVFREQ_THERMAL=y
CONFIG_THERMAL_EMULATION=y
CONFIG_THERMAL_MMIO=m
CONFIG_DA9062_THERMAL=m

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
CONFIG_INT3406_THERMAL=m
CONFIG_PROC_THERMAL_MMIO_RAPL=m
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_PCIHOST_POSSIBLE=y
# CONFIG_SSB_PCIHOST is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=m
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=y
CONFIG_MFD_BCM590XX=m
CONFIG_MFD_BD9571MWV=m
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
CONFIG_MFD_DA9062=m
CONFIG_MFD_DA9063=m
# CONFIG_MFD_DA9150 is not set
CONFIG_MFD_DLN2=m
CONFIG_MFD_GATEWORKS_GSC=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=m
CONFIG_MFD_HI6421_PMIC=y
CONFIG_HTC_PASIC3=m
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
CONFIG_INTEL_SOC_PMIC_MRFLD=y
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_INTEL_PMC_BXT is not set
CONFIG_MFD_IQS62X=m
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=m
CONFIG_MFD_88PM800=m
CONFIG_MFD_88PM805=m
CONFIG_MFD_MAX14577=m
CONFIG_MFD_MAX77650=m
CONFIG_MFD_MAX77686=m
CONFIG_MFD_MAX77693=m
# CONFIG_MFD_MAX8907 is not set
CONFIG_MFD_MT6360=m
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
CONFIG_MFD_VIPERBOARD=m
CONFIG_MFD_NTXEC=m
CONFIG_MFD_RETU=m
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
CONFIG_PCF50633_GPIO=m
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=m
CONFIG_MFD_RT5033=m
CONFIG_MFD_RK808=m
CONFIG_MFD_RN5T618=m
CONFIG_MFD_SI476X_CORE=m
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_TI_LMU=m
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=m
CONFIG_MFD_TPS65086=m
CONFIG_MFD_TPS65217=m
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TI_LP87565 is not set
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TQMX86=m
CONFIG_MFD_VX855=m
CONFIG_MFD_ARIZONA=m
CONFIG_MFD_ARIZONA_I2C=m
# CONFIG_MFD_CS47L24 is not set
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
# CONFIG_MFD_WM8997 is not set
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8994=m
CONFIG_MFD_STMFX=m
CONFIG_MFD_WCD934X=m
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_MFD_QCOM_PM8008=m
CONFIG_MFD_RSMU_I2C=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=m
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
CONFIG_REGULATOR_88PM800=m
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_ACT8945A=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_BCM590XX=m
CONFIG_REGULATOR_BD9571MWV=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9063=m
CONFIG_REGULATOR_DA9121=m
CONFIG_REGULATOR_DA9210=m
CONFIG_REGULATOR_DA9211=m
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_FAN53880=m
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=m
# CONFIG_REGULATOR_ISL9305 is not set
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
CONFIG_REGULATOR_MAX1586=m
CONFIG_REGULATOR_MAX77650=m
CONFIG_REGULATOR_MAX8649=m
CONFIG_REGULATOR_MAX8660=m
CONFIG_REGULATOR_MAX8893=m
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77686=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MAX77802=m
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
# CONFIG_REGULATOR_MC13783 is not set
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MCP16502=m
# CONFIG_REGULATOR_MP5416 is not set
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MP886X=m
# CONFIG_REGULATOR_MPQ7920 is not set
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PF8X00=m
# CONFIG_REGULATOR_PFUZE100 is not set
CONFIG_REGULATOR_PV88060=m
CONFIG_REGULATOR_PV88080=m
# CONFIG_REGULATOR_PV88090 is not set
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=m
# CONFIG_REGULATOR_RK808 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_RT4801=m
CONFIG_REGULATOR_RT4831=m
CONFIG_REGULATOR_RT5033=m
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
# CONFIG_REGULATOR_RTQ6752 is not set
CONFIG_REGULATOR_SLG51000=m
CONFIG_REGULATOR_SY8106A=m
CONFIG_REGULATOR_SY8824X=m
CONFIG_REGULATOR_SY8827N=m
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=m
CONFIG_REGULATOR_TPS65023=m
CONFIG_REGULATOR_TPS6507X=m
CONFIG_REGULATOR_TPS65086=m
CONFIG_REGULATOR_TPS65132=m
CONFIG_REGULATOR_TPS65217=m
CONFIG_REGULATOR_TPS65218=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM8994=m
CONFIG_RC_CORE=m
# CONFIG_RC_MAP is not set
CONFIG_LIRC=y
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=m
# CONFIG_USB_PULSE8_CEC is not set
# CONFIG_USB_RAINSHADOW_CEC is not set
# end of CEC support

# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=m
CONFIG_AGP_VIA=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=m
CONFIG_BACKLIGHT_LM3533=m
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=m
# CONFIG_BACKLIGHT_ADP8870 is not set
CONFIG_BACKLIGHT_PCF50633=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_TPS65217=m
# CONFIG_BACKLIGHT_GPIO is not set
CONFIG_BACKLIGHT_LV5207LP=m
# CONFIG_BACKLIGHT_BD6107 is not set
CONFIG_BACKLIGHT_ARCXCNN=m
CONFIG_BACKLIGHT_LED=y
# end of Backlight & LCD device support
# end of Graphics support

CONFIG_SOUND=m
# CONFIG_SND is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
# CONFIG_HID_GENERIC is not set

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACRUX=y
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_CHERRY is not set
CONFIG_HID_COUGAR=y
CONFIG_HID_MACALLY=y
CONFIG_HID_CMEDIA=y
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
CONFIG_HID_GLORIOUS=m
CONFIG_HID_VIVALDI=y
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=y
# CONFIG_HID_KENSINGTON is not set
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=y
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=y
CONFIG_HID_ORTEK=y
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_SAITEK=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
CONFIG_HID_SUNPLUS=y
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
CONFIG_USB_MOUSE=y
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=m
CONFIG_I2C_HID_OF=m
CONFIG_I2C_HID_OF_GOODIX=m
# end of I2C HID support

CONFIG_I2C_HID_CORE=m

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_FEW_INIT_RETRIES=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_OTG=y
CONFIG_USB_OTG_PRODUCTLIST=y
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_OTG_FSM=m
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=m
CONFIG_USB_XHCI_DBGCAP=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
CONFIG_USB_XHCI_PLATFORM=m
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
# CONFIG_USB_EHCI_FSL is not set
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=m
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_U132_HCD=m
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=m
CONFIG_USB_HCD_SSB=m
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USBIP_CORE=y
# CONFIG_USBIP_VHCI_HCD is not set
CONFIG_USBIP_HOST=y
CONFIG_USBIP_VUDC=m
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS_SUPPORT=m
CONFIG_USB_CDNS_HOST=y
CONFIG_USB_CDNS3=m
# CONFIG_USB_CDNS3_GADGET is not set
CONFIG_USB_CDNS3_HOST=y
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=m
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_PERIPHERAL=y
# CONFIG_USB_DWC2_DUAL_ROLE is not set
CONFIG_USB_DWC2_DEBUG=y
CONFIG_USB_DWC2_VERBOSE=y
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
CONFIG_USB_CHIPIDEA=m
CONFIG_USB_CHIPIDEA_UDC=y
CONFIG_USB_CHIPIDEA_HOST=y
CONFIG_USB_CHIPIDEA_MSM=m
# CONFIG_USB_CHIPIDEA_IMX is not set
CONFIG_USB_CHIPIDEA_GENERIC=m
CONFIG_USB_CHIPIDEA_TEGRA=m
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_SIMPLE=m
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_ARK3116=m
# CONFIG_USB_SERIAL_BELKIN is not set
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
# CONFIG_USB_SERIAL_EMPEG is not set
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=m
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
CONFIG_USB_SERIAL_F8153X=m
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
CONFIG_USB_SERIAL_METRO=m
# CONFIG_USB_SERIAL_MOS7720 is not set
CONFIG_USB_SERIAL_MOS7840=m
CONFIG_USB_SERIAL_MXUPORT=m
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
CONFIG_USB_SERIAL_TI=m
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
CONFIG_USB_SERIAL_WISHBONE=m
# CONFIG_USB_SERIAL_SSU100 is not set
CONFIG_USB_SERIAL_QT2=m
CONFIG_USB_SERIAL_UPD78F0730=m
# CONFIG_USB_SERIAL_XR is not set
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
# CONFIG_USB_EMI26 is not set
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=m
CONFIG_USB_CYPRESS_CY7C63=m
CONFIG_USB_CYTHERM=m
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
CONFIG_USB_CHAOSKEY=m
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=m
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=m
CONFIG_USB_GR_UDC=m
CONFIG_USB_R8A66597=m
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
CONFIG_USB_SNP_CORE=m
CONFIG_USB_SNP_UDC_PLAT=m
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
CONFIG_USB_NET2272=m
CONFIG_USB_NET2272_DMA=y
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_DUMMY_HCD=m
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_ACM=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_U_SERIAL=m
CONFIG_USB_U_ETHER=m
CONFIG_USB_F_SERIAL=m
CONFIG_USB_F_OBEX=m
CONFIG_USB_F_ECM=m
CONFIG_USB_F_SUBSET=m
CONFIG_USB_F_RNDIS=m
CONFIG_USB_F_FS=m
CONFIG_USB_F_HID=m
CONFIG_USB_CONFIGFS=m
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
CONFIG_USB_CONFIGFS_RNDIS=y
# CONFIG_USB_CONFIGFS_EEM is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_PRINTER is not set

#
# USB Gadget precomposed configurations
#
CONFIG_USB_ZERO=m
CONFIG_USB_ZERO_HNPTEST=y
CONFIG_USB_ETH=m
# CONFIG_USB_ETH_RNDIS is not set
# CONFIG_USB_ETH_EEM is not set
# CONFIG_USB_G_NCM is not set
CONFIG_USB_GADGETFS=m
# CONFIG_USB_FUNCTIONFS is not set
CONFIG_USB_G_SERIAL=m
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
CONFIG_USB_G_HID=m
CONFIG_USB_G_DBGP=m
CONFIG_USB_G_DBGP_PRINTK=y
# CONFIG_USB_G_DBGP_SERIAL is not set
CONFIG_USB_RAW_GADGET=m
# end of USB Gadget precomposed configurations

CONFIG_TYPEC=y
CONFIG_TYPEC_TCPM=m
CONFIG_TYPEC_TCPCI=m
CONFIG_TYPEC_RT1711H=m
CONFIG_TYPEC_MT6360=m
# CONFIG_TYPEC_TCPCI_MAXIM is not set
# CONFIG_TYPEC_FUSB302 is not set
# CONFIG_TYPEC_UCSI is not set
CONFIG_TYPEC_TPS6598X=m
CONFIG_TYPEC_HD3SS3220=m
CONFIG_TYPEC_STUSB160X=m

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=m
CONFIG_TYPEC_MUX_INTEL_PMC=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_AN30259A=m
CONFIG_LEDS_AW2013=m
CONFIG_LEDS_BCM6328=m
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3532=m
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_LM3692X=m
# CONFIG_LEDS_PCA9532 is not set
CONFIG_LEDS_GPIO=y
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=m
CONFIG_LEDS_LP50XX=m
CONFIG_LEDS_LP55XX_COMMON=m
# CONFIG_LEDS_LP5521 is not set
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_PCA955X=m
CONFIG_LEDS_PCA955X_GPIO=y
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=m
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_MC13783 is not set
# CONFIG_LEDS_TCA6507 is not set
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_MAX77650=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_IS31FL319X=m
CONFIG_LEDS_IS31FL32XX=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM3697=m
CONFIG_LEDS_LM36274=m
# CONFIG_LEDS_LGM is not set

#
# Flash and Torch LED drivers
#
CONFIG_LEDS_AAT1290=m
CONFIG_LEDS_AS3645A=m
CONFIG_LEDS_KTD2692=y
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_MAX77693=m
# CONFIG_LEDS_MT6360 is not set
CONFIG_LEDS_RT4505=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=y
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
CONFIG_LEDS_TRIGGER_NETDEV=y
CONFIG_LEDS_TRIGGER_PATTERN=m
CONFIG_LEDS_TRIGGER_AUDIO=m
CONFIG_LEDS_TRIGGER_TTY=y

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
# CONFIG_RTC_NVMEM is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=m
# CONFIG_RTC_DRV_ABEOZ9 is not set
CONFIG_RTC_DRV_ABX80X=m
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1672 is not set
CONFIG_RTC_DRV_HYM8563=m
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX77686 is not set
CONFIG_RTC_DRV_RK808=m
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=m
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12026 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
CONFIG_RTC_DRV_PCF85363=m
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
# CONFIG_RTC_DRV_M41T80_WDT is not set
CONFIG_RTC_DRV_BQ32K=m
CONFIG_RTC_DRV_RC5T619=m
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=m

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
# CONFIG_RTC_DRV_DS3232_HWMON is not set
CONFIG_RTC_DRV_PCF2127=m
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=y
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=y
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9063=m
CONFIG_RTC_DRV_STK17TA8=y
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_PCF50633 is not set
CONFIG_RTC_DRV_ZYNQMP=y
CONFIG_RTC_DRV_NTXEC=m

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_R7301 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
CONFIG_DMABUF_SYSFS_STATS=y
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
CONFIG_UIO_MF624=m
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=m
CONFIG_VIRTIO_PCI_LIB_LEGACY=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
CONFIG_VIRTIO_VDPA=m
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VDPA=y
CONFIG_VDPA_SIM=y
# CONFIG_VDPA_SIM_NET is not set
CONFIG_VDPA_SIM_BLOCK=y
CONFIG_VDPA_USER=m
CONFIG_VHOST_IOTLB=y
CONFIG_VHOST_RING=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=y
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=m
# CONFIG_COMEDI_TEST is not set
CONFIG_COMEDI_PARPORT=m
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
CONFIG_COMEDI_NI_LABPC_CS=m
CONFIG_COMEDI_NI_MIO_CS=m
# CONFIG_COMEDI_QUATECH_DAQP_CS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
# CONFIG_COMEDI_NI_USB6501 is not set
CONFIG_COMEDI_USBDUX=y
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
CONFIG_STAGING_MEDIA=y

#
# Android
#
CONFIG_ASHMEM=y
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_LTE_GDM724X=m
# CONFIG_FIREWIRE_SERIAL is not set
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
# CONFIG_UNISYS_VISORNIC is not set
# CONFIG_UNISYS_VISORINPUT is not set
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_MOST_COMPONENTS=y
CONFIG_MOST_NET=y
CONFIG_MOST_DIM2=y
# CONFIG_MOST_I2C is not set
CONFIG_XIL_AXIS_FIFO=m
CONFIG_FIELDBUS_DEV=m
CONFIG_HMS_ANYBUSS_BUS=m
CONFIG_ARCX_ANYBUS_CONTROLLER=m
CONFIG_HMS_PROFINET=m
# CONFIG_QLGE is not set
CONFIG_X86_PLATFORM_DEVICES=y
# CONFIG_ACPI_WMI is not set
CONFIG_ACERHDF=m
CONFIG_ACER_WIRELESS=m
# CONFIG_AMD_PMC is not set
CONFIG_ADV_SWBUTTON=m
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
CONFIG_ASUS_WIRELESS=m
# CONFIG_ASUS_TF103C_DOCK is not set
CONFIG_MERAKI_MX100=y
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_X86_PLATFORM_DRIVERS_DELL=y
CONFIG_DCDBAS=m
# CONFIG_DELL_RBU is not set
CONFIG_DELL_RBTN=y
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_SMO8800=m
# CONFIG_AMILO_RFKILL is not set
# CONFIG_FUJITSU_LAPTOP is not set
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
# CONFIG_HP_ACCEL is not set
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_IBM_RTL=m
# CONFIG_IDEAPAD_LAPTOP is not set
# CONFIG_SENSORS_HDAPS is not set
# CONFIG_INTEL_ATOMISP2_LED is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
# CONFIG_INTEL_SKL_INT3472 is not set
# CONFIG_INTEL_PMC_CORE is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_HID_EVENT is not set
# CONFIG_INTEL_VBTN is not set
# CONFIG_INTEL_OAKTRAIL is not set
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_MRFLD_PWRBTN is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# CONFIG_INTEL_VSEC is not set
# CONFIG_MSI_LAPTOP is not set
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
# CONFIG_SAMSUNG_LAPTOP is not set
CONFIG_SAMSUNG_Q10=m
# CONFIG_TOSHIBA_BT_RFKILL is not set
CONFIG_TOSHIBA_HAPS=m
CONFIG_ACPI_CMPC=y
# CONFIG_COMPAL_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
# CONFIG_SONYPI_COMPAT is not set
# CONFIG_SYSTEM76_ACPI is not set
# CONFIG_TOPSTAR_LAPTOP is not set
CONFIG_I2C_MULTI_INSTANTIATE=m
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
CONFIG_INTEL_SCU_PLATFORM=m
# CONFIG_INTEL_SCU_IPC_UTIL is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=m
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_COMMON_CLK_MAX77686=m
CONFIG_COMMON_CLK_MAX9485=m
CONFIG_COMMON_CLK_RK808=m
# CONFIG_COMMON_CLK_SI5341 is not set
CONFIG_COMMON_CLK_SI5351=m
# CONFIG_COMMON_CLK_SI514 is not set
CONFIG_COMMON_CLK_SI544=m
CONFIG_COMMON_CLK_SI570=m
CONFIG_COMMON_CLK_CDCE706=m
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_CS2000_CP=m
# CONFIG_COMMON_CLK_LAN966X is not set
# CONFIG_COMMON_CLK_AXI_CLKGEN is not set
CONFIG_COMMON_CLK_VC5=m
# CONFIG_COMMON_CLK_FIXED_MMIO is not set
CONFIG_CLK_LGM_CGU=y
CONFIG_XILINX_VCU=m
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_TIMER_OF=y
CONFIG_TIMER_PROBE=y
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
CONFIG_CLKSRC_MMIO=y
CONFIG_MICROCHIP_PIT64B=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=m
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_NS=y
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# CONFIG_LITEX_SOC_CONTROLLER is not set
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=m
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=m
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_INTEL_INT3496=y
CONFIG_EXTCON_INTEL_MRFLD=m
CONFIG_EXTCON_MAX14577=m
# CONFIG_EXTCON_MAX3355 is not set
CONFIG_EXTCON_MAX77693=m
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USB_GPIO=y
CONFIG_EXTCON_USBC_TUSB320=m
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
CONFIG_NTB_INTEL=m
CONFIG_NTB_EPF=m
CONFIG_NTB_SWITCHTEC=m
CONFIG_NTB_PINGPONG=m
CONFIG_NTB_TOOL=m
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_AL_FIC=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_INTEL_GW is not set
CONFIG_RESET_TI_SYSCON=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
CONFIG_USB_LGM_PHY=m
CONFIG_PHY_CAN_TRANSCEIVER=m

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_CADENCE_TORRENT=m
CONFIG_PHY_CADENCE_DPHY=y
CONFIG_PHY_CADENCE_SIERRA=m
CONFIG_PHY_CADENCE_SALVO=y
CONFIG_PHY_FSL_IMX8MQ_USB=y
# CONFIG_PHY_MIXEL_MIPI_DPHY is not set
# CONFIG_PHY_FSL_IMX8M_PCIE is not set
CONFIG_PHY_PXA_28NM_HSIC=y
CONFIG_PHY_PXA_28NM_USB2=y
# CONFIG_PHY_LAN966X_SERDES is not set
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_PHY_OCELOT_SERDES=y
CONFIG_PHY_QCOM_USB_HS=m
# CONFIG_PHY_QCOM_USB_HSIC is not set
CONFIG_PHY_SAMSUNG_USB2=m
# CONFIG_PHY_TUSB1210 is not set
# CONFIG_PHY_INTEL_LGM_COMBO is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
CONFIG_IDLE_INJECT=y
# CONFIG_DTPM is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
CONFIG_USB4=y
CONFIG_USB4_DEBUGFS_WRITE=y
# CONFIG_USB4_DMA_TEST is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=m
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
# CONFIG_STM_SOURCE_FTRACE is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
CONFIG_INTEL_TH_DEBUG=y
# end of HW tracing support

CONFIG_FPGA=m
CONFIG_ALTERA_PR_IP_CORE=m
CONFIG_ALTERA_PR_IP_CORE_PLAT=m
CONFIG_FPGA_MGR_ALTERA_CVP=m
CONFIG_FPGA_BRIDGE=m
CONFIG_ALTERA_FREEZE_BRIDGE=m
CONFIG_XILINX_PR_DECOUPLER=m
CONFIG_FPGA_REGION=m
CONFIG_OF_FPGA_REGION=m
# CONFIG_FPGA_DFL is not set
CONFIG_FSI=y
CONFIG_FSI_NEW_DEV_NODE=y
CONFIG_FSI_MASTER_GPIO=y
# CONFIG_FSI_MASTER_HUB is not set
CONFIG_FSI_MASTER_ASPEED=y
# CONFIG_FSI_SCOM is not set
CONFIG_FSI_SBEFIFO=m
CONFIG_FSI_OCC=m
CONFIG_PM_OPP=y
CONFIG_UNISYS_VISORBUS=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
CONFIG_INTERRUPT_CNT=m
CONFIG_FTM_QUADDEC=m
# CONFIG_MICROCHIP_TCB_CAPTURE is not set
CONFIG_INTEL_QEP=m
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
CONFIG_MOST_CDEV=m
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
# CONFIG_FS_DAX is not set
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_VERITY=y
CONFIG_FS_VERITY_DEBUG=y
# CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
# CONFIG_NLS_CODEPAGE_862 is not set
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
# CONFIG_NLS_ISO8859_1 is not set
CONFIG_NLS_ISO8859_2=m
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=y
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=y
CONFIG_NLS_MAC_CROATIAN=m
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=y
# CONFIG_NLS_MAC_INUIT is not set
CONFIG_NLS_MAC_ROMANIAN=y
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_UTF8_DATA=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
CONFIG_SECURITY_DMESG_RESTRICT=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_PAGE_TABLE_ISOLATION is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_HASH is not set
CONFIG_SECURITY_APPARMOR_DEBUG=y
# CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is not set
# CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
CONFIG_CRYPTO_ECRDSA=y
CONFIG_CRYPTO_SM2=m
# CONFIG_CRYPTO_CURVE25519 is not set
CONFIG_CRYPTO_CURVE25519_X86=m

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=m
CONFIG_CRYPTO_NHPOLY1305_AVX2=y
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
# CONFIG_CRYPTO_CRC32_PCLMUL is not set
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD160 is not set
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=m
CONFIG_CRYPTO_SHA256_SSSE3=y
# CONFIG_CRYPTO_SHA512_SSSE3 is not set
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=m
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
# CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_DES3_EDE_X86_64=y
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SERPENT=m
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
# CONFIG_CRYPTO_TWOFISH is not set
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
# CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=m

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=m
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_CCREE is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=m
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
# CONFIG_MODULE_SIG_KEY_TYPE_RSA is not set
CONFIG_MODULE_SIG_KEY_TYPE_ECDSA=y
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# CONFIG_SYSTEM_REVOCATION_LIST is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_LINEAR_RANGES=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=m
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=m
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=y
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=y
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=m
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
# CONFIG_XZ_DEC_POWERPC is not set
# CONFIG_XZ_DEC_IA64 is not set
# CONFIG_XZ_DEC_ARM is not set
# CONFIG_XZ_DEC_ARMTHUMB is not set
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_DMA_DECLARE_COHERENT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_RESTRICTED_POOL=y
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACK_HASH_ORDER=20
# end of Library routines

CONFIG_ASN1_ENCODER=m

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_HEADERS_INSTALL=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_STACK_VALIDATION=y
CONFIG_VMLINUX_MAP=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
# CONFIG_MAGIC_SYSRQ_SERIAL is not set
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_SLUB_STATS=y
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
# CONFIG_DEBUG_VM_RB is not set
CONFIG_DEBUG_VM_PGFLAGS=y
CONFIG_DEBUG_VM_PGTABLE=y
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
CONFIG_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_DEBUG_PER_CPU_MAPS=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=1
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
CONFIG_CPU_HOTPLUG_STATE_CONTROL=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT is not set
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=m
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_KCOV=y
CONFIG_KCOV_ENABLE_COMPARISONS=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_KCOV_IRQ_AREA_SIZE=0x40000
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_DEBUG_VIRTUAL is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='rcutorture'
	export testcase='rcutorture'
	export category='functional'
	export need_memory='300MB'
	export runtime=300
	export job_origin='rcutorture.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='bisect'
	export testbox='vm-snb-67'
	export tbox_group='vm-snb'
	export branch='linux-devel/devel-hourly-20220304-094445'
	export commit='556d8afe4a779f41dfc8fa373993a88e43f1c5dc'
	export kconfig='x86_64-randconfig-a012-20210928'
	export nr_vm=160
	export submit_id='6227adaafa9a1defaf472e96'
	export job_file='/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml'
	export id='2c60266b60311a02f4e4d7220371cf9e2c7d3b49'
	export queuer_version='/lkp-src'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"RCU_TORTURE_TEST\"\=\>\"m\"\}'
'\{\"SECURITY_LOADPIN_ENABLED\"\=\>\"n,\ \<\=\ v4.19\"\}'
'\{\"SECURITY_LOADPIN_ENFORCE\"\=\>\"n,\ v4.20\"\}'
'\{\"MODULE_UNLOAD\"\=\>\"y\"\}'
'\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export compiler='gcc-9'
	export enqueue_time='2022-03-09 03:25:31 +0800'
	export _id='6227b814fa9a1defaf472e98'
	export _rt='/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3'
	export scheduler_version='/lkp/lkp/.src-20220308-102049'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77
branch=linux-devel/devel-hourly-20220304-094445
job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20210928
commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc
vmalloc=128M initramfs_async=0 page_owner=on
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77'
	export dequeue_time='2022-03-09 04:10:54 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test test='default' torture_type='rcu' $LKP_SRC/tests/wrapper rcutorture
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env test='default' torture_type='rcu' $LKP_SRC/stats/wrapper rcutorture
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time rcutorture.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--uAKRQypu60I7Lcqm
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=rcutorture

early console in setup code
early console in extract_kernel
input_data: 0x00000000030e22e0
input_len: 0x0000000000d1cbf1
output: 0x0000000001000000
output_len: 0x000000000295baa0
kernel_total_size: 0x0000000003220000
needed_size: 0x0000000003400000
trampoline_32bit: 0x000000000009d000
Physical KASLR using RDTSC...
Virtual KASLR using RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
Linux version 5.17.0-rc1-00111-g556d8afe4a77 (kbuild@1871ff489a11) (gcc-9 (Debian 9.3.0-22) 9.3.0, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP Wed Mar 9 03:43:42 CST 2022
Command line: ip=::::vm-snb-67::dhcp root=/dev/ram0 RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77 branch=linux-devel/devel-hourly-20220304-094445 job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20210928 commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc vmalloc=128M initramfs_async=0 page_owner=on max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdi
KERNEL supported cpus:
Intel GenuineIntel
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
signal: max sigframe size: 1360
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x00000000bffdffff] usable
BIOS-e820: [mem 0x00000000bffe0000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
printk: debug: ignoring loglevel setting.
printk: bootconsole [earlyser0] enabled
NX (Execute Disable) protection: active
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: using sched offset of 5557670255 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 2095.078 MHz processor
e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
e820: remove [mem 0x000a0000-0x000fffff] usable
last_pfn = 0x440000 max_arch_pfn = 0x400000000
x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC  
Memory KASLR using RDTSC...
last_pfn = 0xbffe0 max_arch_pfn = 0x400000000
RAMDISK: [mem 0x78a9d000-0x7fffffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
ACPI: DSDT 0x00000000BFFE0040 00145D (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
ACPI: FACS 0x00000000BFFE0000 000040
ACPI: APIC 0x00000000BFFE1511 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
ACPI: HPET 0x00000000BFFE1591 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
ACPI: Reserving FACP table memory at [mem 0xbffe149d-0xbffe1510]
ACPI: Reserving DSDT table memory at [mem 0xbffe0040-0xbffe149c]
ACPI: Reserving FACS table memory at [mem 0xbffe0000-0xbffe003f]
ACPI: Reserving APIC table memory at [mem 0xbffe1511-0xbffe1590]
ACPI: Reserving HPET table memory at [mem 0xbffe1591-0xbffe15c8]
mapped APIC to ffffffffff5fd000 (        fee00000)
Zone ranges:
DMA32    [mem 0x0000000000001000-0x00000000ffffffff]
Normal   [mem 0x0000000100000000-0x000000043fffffff]
Movable zone start for each node
Early memory node ranges
node   0: [mem 0x0000000000001000-0x000000000009efff]
node   0: [mem 0x0000000000100000-0x00000000bffdffff]
node   0: [mem 0x0000000100000000-0x000000043fffffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]
On node 0, zone DMA32: 1 pages in unavailable ranges
On node 0, zone DMA32: 97 pages in unavailable ranges
On node 0, zone Normal: 32 pages in unavailable ranges
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 0, APIC INT 02
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 05, APIC ID 0, APIC INT 05
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 0, APIC INT 09
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0a, APIC ID 0, APIC INT 0a
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
Int: type 0, pol 1, trig 3, bus 00, IRQ 0b, APIC ID 0, APIC INT 0b
Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 0, APIC INT 01
Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 0, APIC INT 03
Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 0, APIC INT 04
Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 0, APIC INT 06
Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 0, APIC INT 07
Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 0, APIC INT 08
Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 0, APIC INT 0c
Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 0, APIC INT 0d
Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 0, APIC INT 0e
Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 0, APIC INT 0f
ACPI: Using ACPI (MADT) for SMP configuration information
ACPI: HPET id: 0x8086a201 base: 0xfed00000
TSC deadline timer available
smpboot: Allowing 2 CPUs, 0 hotplug CPUs
mapped IOAPIC to ffffffffff5fc000 (fec00000)
[mem 0xc0000000-0xfeffbfff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8192 nr_cpumask_bits:2 nr_cpu_ids:2 nr_node_ids:1
percpu: Embedded 502 pages/cpu s2016920 r8192 d31080 u2097152
pcpu-alloc: s2016920 r8192 d31080 u2097152 alloc=1*2097152
pcpu-alloc: [0] 0 [0] 1 
Built 1 zonelists, mobility grouping on.  Total pages: 4128482
Kernel command line: ip=::::vm-snb-67::dhcp root=/dev/ram0 RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77 branch=linux-devel/devel-hourly-20220304-094445 job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20210928 commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc vmalloc=128M initramfs_async=0 page_owner=on max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 promp
sysrq: sysrq always enabled.
ignoring the deprecated load_ramdisk= option
Unknown kernel command line parameters "RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77 branch=linux-devel/devel-hourly-20220304-094445 job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml user=lkp ARCH=x86_64 kconfig=x86_64-randconfig-a012-20210928 commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc vmalloc=128M page_owner=on max_uptime=2100 LKP_SERVER=internal-lkp-server selinux=0 softlockup_panic=1 nmi_watchdog=panic prompt_ramdisk=0 vga=normal", will be passed to user space.
Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
mem auto-init: stack:off, heap alloc:on, heap free:on
mem auto-init: clearing system memory may take some time...
Memory: 16245120K/16776696K available (14341K kernel code, 6125K rwdata, 7964K rodata, 3052K init, 13768K bss, 531316K reserved, 0K cma-reserved)
random: get_random_u64 called from cache_random_seq_create+0x54/0x10f with crng_init=0
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
Running RCU self tests
rcu: Hierarchical RCU implementation.
rcu: 	RCU lockdep checking is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=2.
	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
	Trampoline variant of Tasks RCU enabled.
	Rude variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 4352, nr_irqs: 56, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
printk: console [ttyS0] enabled
printk: bootconsole [earlyser0] disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8192
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     32768
... MAX_LOCKDEP_CHAINS:      65536
... CHAINHASH_SIZE:          32768
memory used by lock dependency info: 6877 kB
memory used for stack traces: 4224 kB
per task-struct memory footprint: 2688 bytes
ACPI: Core revision 20211217
clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
APIC: Switch to symmetric I/O mode setup
masked ExtINT on CPU#0
ENABLING IO-APIC IRQs
init IO_APIC IRQs
apic 0 pin 0 not connected
IOAPIC[0]: Preconfigured routing entry (0-1 -> IRQ 1 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-2 -> IRQ 0 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-3 -> IRQ 3 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-4 -> IRQ 4 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-5 -> IRQ 5 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-6 -> IRQ 6 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-7 -> IRQ 7 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-8 -> IRQ 8 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-9 -> IRQ 9 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-10 -> IRQ 10 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-11 -> IRQ 11 Level:1 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-12 -> IRQ 12 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-13 -> IRQ 13 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-14 -> IRQ 14 Level:0 ActiveLow:0)
IOAPIC[0]: Preconfigured routing entry (0-15 -> IRQ 15 Level:0 ActiveLow:0)
apic 0 pin 16 not connected
apic 0 pin 17 not connected
apic 0 pin 18 not connected
apic 0 pin 19 not connected
apic 0 pin 20 not connected
apic 0 pin 21 not connected
apic 0 pin 22 not connected
apic 0 pin 23 not connected
..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
Calibrating delay loop (skipped) preset value.. 4190.15 BogoMIPS (lpj=2095078)
pid_max: default: 4096 minimum: 301
LSM: Security Framework initializing
landlock: Up and running.
Yama: becoming mindful.
Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
Poking KASLR using RDTSC...
Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
Speculative Store Bypass: Vulnerable
MDS: Vulnerable: Clear CPU buffers attempted, no microcode
Freeing SMP alternatives memory: 16K
smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)
cblist_init_generic: Setting adjustable number of callback queues.
cblist_init_generic: Setting shift to 1 and lim to 1.
cblist_init_generic: Setting shift to 1 and lim to 1.
cblist_init_generic: Setting shift to 1 and lim to 1.
Running RCU-tasks wait API self tests
Performance Events: unsupported p6 CPU model 42 no PMU driver, software events only.
rcu: Hierarchical SRCU implementation.
Callback from call_rcu_tasks_trace() invoked.
smp: Bringing up secondary CPUs ...
x86: Booting SMP configuration:
.... node  #0, CPUs:      #1
masked ExtINT on CPU#1
smpboot: CPU 1 Converting physical 0 to logical die 1
smp: Brought up 1 node, 2 CPUs
smpboot: Max logical packages: 2
smpboot: Total of 2 processors activated (8380.31 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 16 (order: -1, 2048 bytes, linear)
pinctrl core: initialized pinctrl subsystem
pinctrl core: failed to create debugfs directory
regulator-dummy: no parameters, enabled
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
thermal_sys: Registered thermal governor 'bang_bang'
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
cpuidle: using governor menu
audit: type=2000 audit(1646770297.786:1): state=initialized audit_enabled=0 res=1
NET: Registered PF_QIPCRTR protocol family
acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB: can free 6 vmemmap pages for hugepages-2048kB
HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
cryptd: max_cpu_qlen set to 1000
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: Added _OSI(Linux-Dell-Video)
ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
ACPI: 1 ACPI AML tables successfully acquired and loaded
Callback from call_rcu_tasks_rude() invoked.
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
ACPI: Enabled 2 GPEs in block 00 to 0F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A03:00: _OSC: OS supports [Segments HPX-Type3]
acpi PNP0A03:00: PCIe port services disabled; not requesting _OSC control
acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
acpiphp: Slot [3] registered
acpiphp: Slot [4] registered
acpiphp: Slot [5] registered
acpiphp: Slot [6] registered
acpiphp: Slot [7] registered
acpiphp: Slot [8] registered
acpiphp: Slot [9] registered
acpiphp: Slot [10] registered
acpiphp: Slot [11] registered
acpiphp: Slot [12] registered
acpiphp: Slot [13] registered
acpiphp: Slot [14] registered
acpiphp: Slot [15] registered
acpiphp: Slot [16] registered
acpiphp: Slot [17] registered
acpiphp: Slot [18] registered
acpiphp: Slot [19] registered
acpiphp: Slot [20] registered
acpiphp: Slot [21] registered
acpiphp: Slot [22] registered
acpiphp: Slot [23] registered
acpiphp: Slot [24] registered
acpiphp: Slot [25] registered
acpiphp: Slot [26] registered
acpiphp: Slot [27] registered
acpiphp: Slot [28] registered
acpiphp: Slot [29] registered
acpiphp: Slot [30] registered
acpiphp: Slot [31] registered
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [mem 0x440000000-0x4bfffffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
pci 0000:00:01.1: reg 0x20: [io  0xc040-0xc04f]
pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
pci 0000:00:03.0: [8086:100e] type 00 class 0x020000
pci 0000:00:03.0: reg 0x10: [mem 0xfebc0000-0xfebdffff]
pci 0000:00:03.0: reg 0x14: [io  0xc000-0xc03f]
pci 0000:00:03.0: reg 0x30: [mem 0xfeb80000-0xfebbffff pref]
pci 0000:00:04.0: [8086:25ab] type 00 class 0x088000
pci 0000:00:04.0: reg 0x10: [mem 0xfebf1000-0xfebf100f]
pci_bus 0000:00: on NUMA node 0
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKS configured for IRQ 9
iommu: Default domain type: Translated 
iommu: DMA domain TLB invalidation policy: lazy mode 
pci 0000:00:02.0: vgaarb: setting as boot VGA device
pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:02.0: vgaarb: bridge control possible
vgaarb: loaded
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: pci_cache_line_size set to 64 bytes
e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
e820: reserve RAM buffer [mem 0xbffe0000-0xbfffffff]
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 comparators, 64-bit 100.000000 MHz counter
clocksource: Switched to clocksource kvm-clock
Callback from call_rcu_tasks() invoked.
pnp: PnP ACPI init
pnp 00:03: [dma 2]
pnp: PnP ACPI: found 7 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 720896 bytes, linear)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
TCP bind hash table entries: 65536 (order: 10, 5242880 bytes, vmalloc)
TCP: Hash tables configured (established 131072 bind 65536)
UDP hash table entries: 8192 (order: 8, 1572864 bytes, linear)
UDP-Lite hash table entries: 8192 (order: 8, 1572864 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: resource 8 [mem 0x440000000-0x4bfffffff window]
pci 0000:00:01.0: PIIX3: Enabling Passive Release
pci 0000:00:00.0: Limiting direct PCI/PCI transfers
pci 0000:00:01.0: Activating ISA DMA hang workarounds
pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
PCI: CLS 0 bytes, default 64
Unpacking initramfs...
Freeing initrd memory: 120204K
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
software IO TLB: mapped [mem 0x00000000bbfe0000-0x00000000bffe0000] (64MB)
ACPI: bus type thunderbolt registered
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e3306b9ada, max_idle_ns: 440795224413 ns
AVX2 or AES-NI instructions are not detected.
Initialise system trusted keyrings
Key type blacklist registered
workingset: timestamp_bits=46 max_order=22 bucket_order=0
zbud: loaded
zsmalloc: debugfs not available, stat dir not created
NET: Registered PF_ALG protocol family
xor: automatically using best checksumming function   avx       
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
start plist test
end plist test
gpio_winbond: chip ID at 2e is ffff
gpio_winbond: not an our chip
gpio_winbond: chip ID at 4e is ffff
gpio_winbond: not an our chip
acpiphp_ibm: ibm_acpiphp_init: acpi_walk_namespace failed
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
SyncLink GT
SyncLink GT, tty major#245
SyncLink GT no devices found
lp: driver loaded but no devices found
Applicom driver: $Id: ac.c,v 1.30 2000/03/22 16:03:57 dwmw2 Exp $
ac.o: No PCI boards found.
ac.o: For an ISA board you must supply memory and irq parameters.
ppdev: user-space parallel port driver
smapi::smapi_init, ERROR invalid usSmapiID
mwave: tp3780i::tp3780I_InitializeBoardData: Error: SMAPI is not available on this machine
mwave: mwavedd::mwave_init: Error: Failed to initialize board data
mwave: mwavedd::mwave_init: Error: Failed to initialize
Hangcheck: starting hangcheck timer 0.9.1 (tick is 180 seconds, margin is 60 seconds).
usbcore: registered new interface driver xillyusb
usbcore: registered new interface driver rtsx_usb
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
ACPI: \_SB_.LNKC: Enabled at IRQ 11
e1000 0000:00:03.0 eth0: (PCI:33MHz:32-bit) 52:54:00:12:34:56
e1000 0000:00:03.0 eth0: Intel(R) PRO/1000 Network Connection
mkiss: AX.25 Multikiss, Hans Albas PE1AYX
AX.25: 6pack driver, Revision: 0.3.0
VFIO - User Level meta-driver version: 0.3
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
usbcore: registered new interface driver cdc_wdm
usbcore: registered new interface driver usbtmc
usbcore: registered new interface driver mdc800
mdc800: v0.7.5 (30/10/2000):USB Driver for Mustek MDC800 Digital Camera
usbcore: registered new interface driver appledisplay
usbcore: registered new interface driver emi62 - firmware loader
ftdi_elan: driver ftdi-elan
usbcore: registered new interface driver ftdi-elan
usbcore: registered new interface driver idmouse
usbcore: registered new interface driver isight_firmware
usbcore: registered new interface driver uss720
uss720: USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
uss720: NOTE: this is a special purpose driver to allow nonstandard
uss720: protocols (eg. bitbang) over USS720 usb to parallel cables
uss720: If you just want to connect to a printer, use usblp instead
usbcore: registered new interface driver usbsevseg
usbcore: registered new device driver usbip-host
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mousedev: PS/2 mouse device common for all mice
usbcore: registered new interface driver usb_acecad
usbcore: registered new interface driver kbtab
usbcore: registered new interface driver pegasus_notetaker
usbcore: registered new interface driver ati_remote2
cm109: Keymap for Komunikate KIP1000 phone loaded
usbcore: registered new interface driver cm109
cm109: CM109 phone driver: 20080805 (C) Alfred E. Heggestad
usbcore: registered new interface driver keyspan_remote
rtc_cmos 00:00: RTC can wake from S4
rtc_cmos 00:00: registered as rtc0
rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
Driver for 1-wire Dallas network protocol.
usbcore: registered new interface driver DS9490R
DS1WM w1 busmaster driver - (c) 2004 Szabolcs Gyurko
intel_pstate: CPU model not supported
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
evbug: Connected device: input0 (AT Translated Set 2 keyboard at isa0060/serio0/input0)
usbcore: registered new interface driver usbmouse
comedi: version 0.7.76 - http://www.comedi.org
usbcore: registered new interface driver usbdux
usbcore: registered new interface driver usbduxfast
usbcore: registered new interface driver usbduxsigma
usbcore: registered new interface driver vmk80xx
ashmem: initialized
usbcore: registered new interface driver hdm_usb
u32 classifier
input device check on
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
NET: Registered PF_NETROM protocol family
NET: Registered PF_ROSE protocol family
NET: Registered PF_AX25 protocol family
NET4: DECnet for Linux: V.2.5.68s (C) 1995-2003 Linux DECnet Project Team
DECnet: Routing cache hash table of 1024 buckets, 80Kbytes
NET: Registered PF_DECnet protocol family
8021q: 802.1Q VLAN Support v1.8
9pnet: Installing 9P2000 support
NET: Registered PF_CAIF protocol family
Key type dns_resolver registered
batman_adv: B.A.T.M.A.N. advanced 2022.0 (compatibility version 15) loaded
mpls_gso: MPLS GSO support
IPI shorthand broadcast: enabled
... APIC ID:      00000000 (0)
... APIC VERSION: 00050014
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000008000000

number of MP IRQ sources: 15.
number of IO-APIC #0 registers: 24.
testing the IO APIC.......................
IO APIC #0......
.... register #00: 00000000
.......    : physical APIC id: 00
.......    : Delivery Type: 0
.......    : LTS          : 0
.... register #01: 00170011
.......     : max redirection entries: 17
.......     : PRQ implemented: 0
.......     : IO APIC version: 11
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
IOAPIC 0:
pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin01, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0002), M(0)
pin02, enabled , edge , high, V(30), IRR(0), S(0), logical , D(0001), M(0)
pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin08, enabled , edge , high, V(22), IRR(0), S(0), logical , D(0001), M(0)
pin09, enabled , level, high, V(21), IRR(0), S(0), logical , D(0002), M(0)
pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0c, enabled , edge , high, V(21), IRR(0), S(0), logical , D(0001), M(0)
pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin10, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin15, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0)
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
.................................... done.
sched_clock: Marking stable (47726844576, 47642871)->(48086399637, -311912190)
Loading compiled-in X.509 certificates
Loaded X.509 cert 'Build time autogenerated kernel key: 1ce19b688c6758fa98504a06999e9f6554fc9436'
debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
Key type ._fscrypt registered
Key type .fscrypt registered
Key type fscrypt-provisioning registered
fs-verity: Initialized fs-verity
Key type encrypted registered
8021q: adding VLAN 0 to HW filter on device eth0
e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 10.0.2.2, my address is 10.0.2.15
IP-Config: Complete:
device=eth0, hwaddr=52:54:00:12:34:56, ipaddr=10.0.2.15, mask=255.255.255.0, gw=10.0.2.2
host=vm-snb-67, domain=, nis-domain=(none)
bootserver=10.0.2.2, rootserver=10.0.2.2, rootpath=
nameserver0=10.0.2.3
DEBUG_HOTPLUG_CPU0: CPU 0 is now offline
Freeing unused kernel image (initmem) memory: 3052K
Write protecting the kernel read-only data: 24576k
Freeing unused kernel image (text/rodata gap) memory: 2040K
Freeing unused kernel image (rodata/data gap) memory: 228K
Run /init as init process
with arguments:
/init
with environment:
HOME=/
TERM=linux
RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77
branch=linux-devel/devel-hourly-20220304-094445
job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a012-20210928
commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc
vmalloc=128M
page_owner=on
max_uptime=2100
LKP_SERVER=internal-lkp-server
selinux=0
softlockup_panic=1
nmi_watchdog=panic
prompt_ramdisk=0
vga=normal
systemd[1]: RTC configured in localtime, applying delta of 0 minutes to system time.
systemd[1]: Inserted module 'autofs4'

Welcome to Debian GNU/Linux 10 (buster)!

random: systemd: uninitialized urandom read (16 bytes read)
Listening on udev Kernel Socket.
random: systemd: uninitialized urandom read (16 bytes read)
Listening on Syslog Socket.
random: systemd: uninitialized urandom read (16 bytes read)
Listening on Journal Audit Socket.
Listening on udev Control Socket.
Reached target Swap.
Listening on Journal Socket.
Starting Load Kernel Modules...
Starting Remount Root and Kernel File Systems...
Mounting POSIX Message Queue File System...
Mounting RPC Pipe File System...
Listening on initctl Compatibility Named Pipe.
Mounting Huge Pages File System...
Created slice system-getty.slice.
Reached target Paths.
Reached target Local Encrypted Volumes.
Created slice User and Session Slice.
Starting udev Coldplug all Devices...
Listening on Journal Socket (/dev/log).
Starting Journal Service...
Listening on RPCbind Server Activation Socket.
Reached target Slices.
Started Load Kernel Modules.
Started Remount Root and Kernel File Systems.
Mounted POSIX Message Queue File System.
Failed to mount RPC Pipe File System.
See 'systemctl status run-rpc_pipefs.mount' for details.
Mounted Huge Pages File System.
Reached target NFS client services.
Starting Create System Users...
Starting Load/Save Random Seed...
Starting Apply Kernel Variables...
Mounting Kernel Configuration File System...
Started Create System Users.
Started Load/Save Random Seed.
Starting Create Static Device Nodes in /dev...
Started Apply Kernel Variables.
Mounted Kernel Configuration File System.
Started Journal Service.
Starting Flush Journal to Persistent Storage...
random: fast init done
Started Create Static Device Nodes in /dev.
Reached target Local File Systems (Pre).
Reached target Local File Systems.
Starting Preprocess NFS configuration...
Starting udev Kernel Device Manager...
Started Flush Journal to Persistent Storage.
Starting Create Volatile Files and Directories...
Started Preprocess NFS configuration.
Started udev Kernel Device Manager.
Started Create Volatile Files and Directories.
Starting Network Time Synchronization...
Starting Update UTMP about System Boot/Shutdown...
Starting RPC bind portmap service...
Started udev Coldplug all Devices.
Starting Helper to synchronize boot up for ifupdown...
Started RPC bind portmap service.
Reached target RPC Port Mapper.
Reached target Remote File Systems (Pre).
Reached target Remote File Systems.
Started Update UTMP about System Boot/Shutdown.
Started Helper to synchronize boot up for ifupdown.
Starting Raise network interfaces...
Started Network Time Synchronization.
Reached target System Time Synchronized.
Reached target System Initialization.
Started Daily Cleanup of Temporary Directories.
Listening on D-Bus System Message Bus Socket.
Reached target Sockets.
Started Daily rotation of log files.
Started Daily apt download activities.
Started Daily apt upgrade and clean activities.
Reached target Timers.
Reached target Basic System.
Started D-Bus System Message Bus.
Starting System Logging Service...
Starting LSB: OpenIPMI Driver init script...
Starting Login Service...
Started Regular background program processing daemon.
Started Raise network interfaces.
Reached target Network.
Starting LKP bootstrap...
Starting Permit User Sessions...
Starting /etc/rc.local Compatibility...
Starting OpenBSD Secure Shell server...
Started Permit User Sessions.
Starting LSB: Load kernel image with kexec...
Started LKP bootstrap.
Started Login Service.
IPMI message handler: version 39.2
Started LSB: Load kernel image with kexec.
ipmi_si: IPMI System Interface driver
ipmi_si: Unable to find any System Interface(s)
Failed to start LSB: OpenIPMI Driver init script.
See 'systemctl status openipmi.service' for details.
random: crng init done
random: 7 urandom warning(s) missed due to ratelimiting
LKP: ttyS0: 247: Kernel tests: Boot OK!
LKP: ttyS0: 247: HOSTNAME vm-snb-67, MAC 52:54:00:12:34:56, kernel 5.17.0-rc1-00111-g556d8afe4a77 1
Started OpenBSD Secure Shell server.
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
evbug: Connected device: input2 (Power Button at LNXPWRBN/button/input0)
ACPI: button: Power Button [PWRF]
RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl timer
AVX version of gcm_enc/dec engaged.
AES CTR mode by8 optimization enabled
LKP: ttyS0: 247:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml
Started System Logging Service.
rcu-torture:--- Start of test: nreaders=1 nfakewriters=4 stat_interval=60 verbose=1 test_no_idle_hz=1 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0 fqs_holdoff=0 fqs_stutter=3 test_boost=1/0 test_boost_interval=7 test_boost_duration=4 shutdown_secs=0 stall_cpu=0 stall_cpu_holdoff=10 stall_cpu_irqsoff=0 stall_cpu_block=0 n_barrier_cbs=0 onoff_interval=0 onoff_holdoff=0 read_exit_delay=13 read_exit_burst=16 nocbs_nthreads=0 nocbs_toggle=1000
rcu:  Start-test grace-period state: g35208 f0x0
rcu_torture_write_types: Testing conditional GPs.
rcu_torture_write_types: Testing conditional expedited GPs.
rcu_torture_write_types: Testing expedited GPs.
rcu_torture_write_types: Testing asynchronous GPs.
rcu_torture_write_types: Testing polling GPs.
rcu_torture_write_types: Testing polling expedited GPs.
rcu_torture_write_types: Testing normal GPs.
rcu-torture: Creating rcu_torture_writer task
rcu-torture: rcu_torture_writer task started
rcu-torture: Creating rcu_torture_fakewriter task
rcu-torture: Creating rcu_torture_fakewriter task
rcu-torture: rcu_torture_fakewriter task started
rcu-torture: Creating rcu_torture_fakewriter task
rcu-torture: rcu_torture_fakewriter task started
rcu-torture: Creating rcu_torture_fakewriter task
rcu-torture: rcu_torture_fakewriter task started
rcu-torture: Creating rcu_torture_reader task
rcu-torture: rcu_torture_fakewriter task started
rcu-torture: rcu_torture_reader task started
rcu-torture: Creating rcu_torture_stats task
rcu-torture: Creating torture_shuffle task
rcu-torture: rcu_torture_stats task started
rcu-torture: torture_shuffle task started
rcu-torture: Creating torture_stutter task
rcu-torture: torture_stutter task started
rcu-torture: Creating rcu_torture_fwd_prog task
rcu-torture: rcu_torture_fwd_progress task started
rcu-torture: Creating rcu_torture_read_exit task
rcu-torture: rcu_torture_read_exit: Start of test
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
LKP: stdout: 247: Kernel tests: Boot OK!

rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode

mount: /sys/kernel/debug: mount point does not exist.

LKP: stdout: 247: HOSTNAME vm-snb-67, MAC 52:54:00:12:34:56, kernel 5.17.0-rc1-00111-g556d8afe4a77 1

rcu-torture: rcu_torture_read_exit: Start of episode
install debs round one: dpkg -i --force-confdef --force-depends /opt/deb/gawk_1%3a4.2.1+dfsg-1_amd64.deb

Selecting previously unselected package gawk.

(Reading database ... 16553 files and directories currently installed.)

Preparing to unpack .../gawk_1%3a4.2.1+dfsg-1_amd64.deb ...

Unpacking gawk (1:4.2.1+dfsg-1) ...

Setting up gawk (1:4.2.1+dfsg-1) ...

mount debug /sys/kernel/debug -t debugfs

rootfs on / type rootfs (rw)

rcu-torture: rcu_torture_read_exit: End of episode
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)

proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)

devtmpfs on /dev type devtmpfs (rw,nosuid,size=8122696k,nr_inodes=2030674,mode=755)

securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)

tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev)

devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)

tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755)

tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=5120k)

tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755)

cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)

cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)

cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)

cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)

cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)

cgroup on /sys/fs/cgroup/misc type cgroup (rw,nosuid,nodev,noexec,relatime,misc)

cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)

cgroup on /sys/fs/cgroup/debug type cgroup (rw,nosuid,nodev,noexec,relatime,debug)

cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)

cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)

cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)

mqueue on /dev/mqueue type mqueue (rw,relatime)

hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)

configfs on /sys/kernel/config type configfs (rw,relatime)

tmp on /tmp type tmpfs (rw,relatime)

nodev	sysfs

nodev	tmpfs

nodev	proc

nodev	cgroup

nodev	cgroup2

nodev	cpuset

nodev	devtmpfs

nodev	configfs

nodev	tracefs

nodev	securityfs

nodev	sockfs

nodev	pipefs

nodev	ramfs

nodev	hugetlbfs

nodev	devpts

nodev	mqueue

nodev	binder

nodev	autofs

rcu-torture: rtc: 00000000cc758e4b ver: 5 tfle: 0 rta: 6 rtaf: 0 rtf: 2 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 760 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 84 nocb-toggles: 0:0
rcu-torture: Reader Pipe:  49488 0 0 0 0 0 0 0 0 0 0
rcu-torture: Reader Batch:  49488 0 0 0 0 0 0 0 0 0 0
rcu-torture: Free-Block Circulation:  5 4 3 2 2 2 2 2 2 2 0
rcu_torture_fwd_prog: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu_torture_fwd_prog_cr Duration 475 barrier: 251 pending 103 n_launders: 1841 n_launders_sa: 103 n_max_gps: 100 n_max_cbs: 1425 cver 0 gps 14
rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 980 jiffies): 1s/10: 648:3 2s/10: 0:1 3s/10: 1091:11402 4s/10: 1424:3 5s/10: 103:5
rcu_torture_fwd_prog_nr: Starting forward-progress test 0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
LKP: stdout: 247:  /lkp/lkp/src/bin/run-lkp /lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml

RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3

job=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml

result_service: raw_upload, RESULT_MNT: /internal-lkp-server/result, RESULT_ROOT: /internal-lkp-server/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3, TMP_RESULT_ROOT: /tmp/lkp/result

run-job /lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml

rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://internal-lkp-server:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/vm-snb-67/rcutorture-300s-default-rcu-debian-10.4-x86_64-20200603.cgz-556d8afe4a779f41dfc8fa373993a88e43f1c5dc-20220309-61359-zgedsu-2.yaml&job_state=running -O /dev/null

target ucode: 

2022-03-08 20:12:30 modprobe rcutorture torture_type=rcu

2022-03-08 20:12:31 sleep 300

rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu_torture_fwd_prog_nr: 0 Duration 40623 cver 0 gps 14906
rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rtc: 00000000cc758e4b ver: 5 tfle: 0 rta: 6 rtaf: 0 rtf: 2 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 1756 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 152 nocb-toggles: 0:0
rcu-torture: Reader Pipe:  118373 0 0 0 0 0 0 0 0 0 0
rcu-torture: Reader Batch:  118373 0 0 0 0 0 0 0 0 0 0
rcu-torture: Free-Block Circulation:  5 4 3 2 2 2 2 2 2 2 0
??? Writer stall state RTWS_POLL_WAIT_EXP(12) g109004 f0x0 ->state 0x2 cpu 1
task:rcu_torture_wri state:D stack:    0 pid:  515 ppid:     2 flags:0x00004000
Call Trace:
<TASK>
__schedule+0x6dd/0x721
schedule+0x4e/0x83
schedule_hrtimeout_range_clock+0xba/0x10c
? __hrtimer_init+0x135/0x135
torture_hrtimeout_ns+0x65/0x6b [torture]
rcu_torture_writer+0x4f5/0x766 [rcutorture]
? write_comp_data+0x20/0x71
? rcutorture_oom_notify+0x185/0x185 [rcutorture]
kthread+0xf7/0x106
? kthread_complete_and_exit+0x2d/0x2d
ret_from_fork+0x1f/0x30
</TASK>
rcu: rcu_sched: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x402 ->rt_priority 0 delta ->gp_start 46 ->gp_activity 45 ->gp_req_activity 46 ->gp_wake_time 45 ->gp_wake_seq 109001 ->gp_seq 109004 ->gp_seq_needed 109004 ->gp_max 133 ->gp_flags 0x0
rcu: RCU callbacks invoked since boot: 174032
rcu_tasks: RTGS_WAIT_CBS(11) since 176582 g:8 i:0/0 k. 
rcu_tasks_rude: RTGS_WAIT_CBS(11) since 176790 g:8 i:0/3 k. 
rcu_tasks_trace: RTGS_WAIT_CBS(11) since 176988 g:8 i:0/0 k. N0 h:0/0/0
Dumping ftrace buffer:
(ftrace buffer empty)
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu_torture_fwd_prog n_max_cbs: 1425
rcu_torture_fwd_prog: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu_torture_fwd_prog_cr Duration 205 barrier: 129 pending 103 n_launders: 1632 n_launders_sa: 102 n_max_gps: 100 n_max_cbs: 1225 cver 0 gps 11
rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 486 jiffies): 1s/10: 1531:6 2s/10: 1223:4 3s/10: 103:5
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu_torture_fwd_prog_nr: Starting forward-progress test 0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rtc: 00000000cc758e4b ver: 5 tfle: 0 rta: 6 rtaf: 0 rtf: 2 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 3261 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 237 nocb-toggles: 0:0
rcu-torture: Reader Pipe:  221546 0 0 0 0 0 0 0 0 0 0
rcu-torture: Reader Batch:  221546 0 0 0 0 0 0 0 0 0 0
rcu-torture: Free-Block Circulation:  5 4 3 2 2 2 2 2 2 2 0
??? Writer stall state RTWS_POLL_WAIT_EXP(12) g141173 f0x2 ->state 0x0 cpu 1
rcu: rcu_sched: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x0 ->rt_priority 0 delta ->gp_start 9 ->gp_activity 9 ->gp_req_activity 9 ->gp_wake_time 8 ->gp_wake_seq 141173 ->gp_seq 141173 ->gp_seq_needed 141176 ->gp_max 133 ->gp_flags 0x2
rcu: 	rcu_node 0:1 ->gp_seq 141173 ->gp_seq_needed 141176 ->qsmask 0x0 .... ->n_boosts 0
rcu: 	cpu 1 ->gp_seq_needed 141176
rcu: RCU callbacks invoked since boot: 195553
rcu_tasks: RTGS_WAIT_CBS(11) since 238020 g:8 i:0/0 k. 
rcu_tasks_rude: RTGS_WAIT_CBS(11) since 238228 g:8 i:0/3 k. 
rcu_tasks_trace: RTGS_WAIT_CBS(11) since 238425 g:8 i:0/0 k. N0 h:0/0/0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu_torture_fwd_prog_nr: 0 Duration 34398 cver 0 gps 12844
rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rtc: 00000000cc758e4b ver: 5 tfle: 0 rta: 6 rtaf: 0 rtf: 2 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 4606 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 305 nocb-toggles: 0:0
rcu-torture: Reader Pipe:  312724 0 0 0 0 0 0 0 0 0 0
rcu-torture: Reader Batch:  312724 0 0 0 0 0 0 0 0 0 0
rcu-torture: Free-Block Circulation:  5 4 3 2 2 2 2 2 2 2 0
??? Writer stall state RTWS_POLL_WAIT_EXP(12) g178804 f0x0 ->state 0x0 cpu 1
rcu: rcu_sched: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x402 ->rt_priority 0 delta ->gp_start 25 ->gp_activity 24 ->gp_req_activity 25 ->gp_wake_time 24 ->gp_wake_seq 178801 ->gp_seq 178804 ->gp_seq_needed 178804 ->gp_max 133 ->gp_flags 0x0
rcu: RCU callbacks invoked since boot: 215714
rcu_tasks: RTGS_WAIT_CBS(11) since 299456 g:8 i:0/0 k. 
rcu_tasks_rude: RTGS_WAIT_CBS(11) since 299664 g:8 i:0/3 k. 
rcu_tasks_trace: RTGS_WAIT_CBS(11) since 299861 g:8 i:0/0 k. N0 h:0/0/0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu_torture_fwd_prog n_max_cbs: 1225
rcu_torture_fwd_prog: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Starting forward-progress test 0
rcu_torture_fwd_prog_cr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu_torture_fwd_prog_cr Duration 245 barrier: 126 pending 104 n_launders: 1742 n_launders_sa: 103 n_max_gps: 100 n_max_cbs: 1185 cver 0 gps 31
rcu_torture_fwd_cb_hist: Callback-invocation histogram 0 (duration 517 jiffies): 1s/10: 592:2 2s/10: 2231:28 3s/10: 104:5
rcu_torture_fwd_prog_nr: Starting forward-progress test 0
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
rcu-torture: rcu_torture_read_exit: Start of episode
rcu-torture: rcu_torture_read_exit: End of episode
2022-03-08 20:17:31 rmmod rcutorture

rcu-torture: Stopping torture_shuffle task
rcu-torture: torture_shuffle is stopping
rcu-torture: Stopping torture_stutter task
rcu-torture: torture_stutter is stopping
rcu: rcu_sched: wait state: RCU_GP_WAIT_FQS(5) ->state: 0x402 ->rt_priority 0 delta ->gp_start 0 ->gp_activity 0 ->gp_req_activity 0 ->gp_wake_time 0 ->gp_wake_seq 231476 ->gp_seq 231477 ->gp_seq_needed 231480 ->gp_max 133 ->gp_flags 0x0
rcu: 	rcu_node 0:1 ->gp_seq 231477 ->gp_seq_needed 231484 ->qsmask 0x0 .... ->n_boosts 0
rcu: 	cpu 1 ->gp_seq_needed 231480
rcu: RCU callbacks invoked since boot: 241662
rcu_tasks: RTGS_WAIT_CBS(11) since 353737 g:8 i:0/0 k. 
rcu_tasks_rude: RTGS_WAIT_CBS(11) since 353944 g:8 i:0/3 k. 
rcu_tasks_trace: RTGS_WAIT_CBS(11) since 354142 g:8 i:0/0 k. N0 h:0/0/0
rcu-torture: rcu_torture_reader is stopping
rcu_torture_fwd_prog_nr: Waiting for CBs: rcu_barrier+0x0/0x253() 0
rcu_torture_fwd_prog: tested 2 tested_tries 3
rcu-torture: rcu_torture_fwd_prog is stopping
rcu-torture: rcu_torture_read_exit is stopping
rcu-torture: Stopping rcutorture_read_exit task
rcu-torture: Stopping rcu_torture_fwd_prog task
rcu-torture: Stopping rcu_torture_writer task
rcu-torture: rtc: 00000000cc758e4b ver: 5 tfle: 0 rta: 6 rtaf: 0 rtf: 2 rtmbe: 0 rtmbkf: 0/0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 5832 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=1000) barrier: 0/0:0 read-exits: 373 nocb-toggles: 0:0
rcu-torture: Reader Pipe:  402665 0 0 0 0 0 0 0 0 0 0
rcu-torture: Reader Batch:  402665 0 0 0 0 0 0 0 0 0 0
rcu-torture: Free-Block Circulation:  5 4 3 2 2 2 2 2 2 2 0
??? Writer stall state RTWS_POLL_WAIT_EXP(12) g232412 f0x0 ->state 0x2 cpu 1
rcu: rcu_sched: wait state: RCU_GP_WAIT_GPS(1) ->state: 0x402 ->rt_priority 0 delta ->gp_start 130 ->gp_activity 129 ->gp_req_activity 130 ->gp_wake_time 129 ->gp_wake_seq 232409 ->gp_seq 232412 ->gp_seq_needed 232412 ->gp_max 133 ->gp_flags 0x0
rcu: RCU callbacks invoked since boot: 243296
rcu_tasks: RTGS_WAIT_CBS(11) since 360896 g:8 i:0/0 k. 
rcu_tasks_rude: RTGS_WAIT_CBS(11) since 361103 g:8 i:0/3 k. 
rcu_tasks_trace: RTGS_WAIT_CBS(11) since 361301 g:8 i:0/0 k. N0 h:0/0/0
rcu-torture: rcu_torture_stats is stopping
Started /etc/rc.local Compatibility.
Reached target Login Prompts.
Reached target Multi-User System.
Starting watchdog daemon...
Started watchdog daemon.
Reached target Graphical Interface.
Starting Update UTMP about System Runlevel Changes...
Started Update UTMP about System Runlevel Changes.
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 338s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=338s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 368s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=368s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 399s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=399s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 429s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=429s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 459s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
pending: toggle_allocation_gate
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=459s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 489s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=489s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 519s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=519s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 550s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=550s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 580s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=580s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 610s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
pending: toggle_allocation_gate
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=610s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 640s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=640s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 670s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=671s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 701s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=701s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 731s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=731s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 761s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=761s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 791s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=791s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 822s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=5/512 refcnt=8
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
pending: toggle_allocation_gate
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=822s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 852s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=852s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 882s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=882s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1871 1873
BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 912s!
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=15/256 refcnt=16
pending: do_free_init, e1000_watchdog, vmstat_shepherd, kfree_rcu_monitor, regulator_init_complete_work_function, kernfs_notify_workfn, release_one_tty, key_garbage_collector, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty, release_one_tty
workqueue events_unbound: flags=0x2
pwq 4: cpus=0-1 flags=0x4 nice=0 active=4/512 refcnt=7
in-flight: 40:fsnotify_mark_destroy_workfn fsnotify_mark_destroy_workfn BAR(1), 9:fsnotify_connector_destroy_workfn fsnotify_connector_destroy_workfn
workqueue events_power_efficient: flags=0x80
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=7/256 refcnt=8
pending: neigh_managed_work, neigh_managed_work, neigh_managed_work, neigh_periodic_work, neigh_periodic_work, neigh_periodic_work, check_lifetime
workqueue rcu_gp: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=3/256 refcnt=4
in-flight: 179:sync_rcu_do_polled_gp
pending: sync_rcu_do_polled_gp, process_srcu
workqueue mm_percpu_wq: flags=0x8
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
pending: vmstat_update
workqueue cgroup_destroy: flags=0x0
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=9
pending: css_killed_work_fn
inactive: css_killed_work_fn, css_killed_work_fn, css_release_work_fn, css_release_work_fn, css_killed_work_fn, css_killed_work_fn, css_killed_work_fn
workqueue ipv6_addrconf: flags=0x40008
pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/1 refcnt=2
pending: addrconf_verify_work
pool 2: cpus=1 node=0 flags=0x0 nice=0 hung=912s workers=3 idle: 23 36
pool 4: cpus=0-1 flags=0x4 nice=0 hung=0s workers=4 idle: 1873 1871
INFO: task systemd:1 blocked for more than 491 seconds.
Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:systemd         state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
Call Trace:
<TASK>
__schedule+0x6dd/0x721
? usleep_range_state+0x9d/0x9d
schedule+0x4e/0x83
schedule_timeout+0x38/0x106
? hlock_class+0x1a/0x5d
? write_comp_data+0x20/0x71
? lockdep_hardirqs_on_prepare+0x14a/0x169
? _raw_spin_unlock_irq+0x1f/0x29
__wait_for_common+0xbd/0x11b
__flush_work+0x391/0x3bf
? flush_workqueue_prep_pwqs+0x1ca/0x1ca
? __wait_for_common+0x3c/0x11b
? inotify_poll+0xaf/0xaf
fsnotify_destroy_group+0xad/0xe9
? __sanitizer_cov_trace_pc+0x17/0x42
? locks_remove_file+0x131/0x13e
? inotify_poll+0xaf/0xaf
inotify_release+0x15/0x19
__fput+0x212/0x3c0
task_work_run+0x94/0xbf
exit_to_user_mode_prepare+0xb1/0x15c
syscall_exit_to_user_mode+0x18/0x43
do_syscall_64+0xa1/0xa7
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa39f4f7b54
RSP: 002b:00007fffb0b4d7d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000017 RCX: 00007fa39f4f7b54
RDX: 00007fa39f5c8ca0 RSI: 0000000000000000 RDI: 0000000000000017
RBP: 00007fa39e3468c0 R08: 00000000000000ef R09: 00007fa3a13f2060
R10: 0000000000000007 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb0b4d890 R14: 0000000000000001 R15: 00007fa39f6e3a8e
</TASK>
INFO: task kworker/u4:1:9 blocked for more than 491 seconds.
Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:1    state:D stack:    0 pid:    9 ppid:     2 flags:0x00004000
Workqueue: events_unbound fsnotify_connector_destroy_workfn
Call Trace:
<TASK>
__schedule+0x6dd/0x721
? to_kthread+0x2c/0x36
? usleep_range_state+0x9d/0x9d
schedule+0x4e/0x83
schedule_timeout+0x38/0x106
? mark_held_locks+0x4a/0x5c
? lockdep_hardirqs_on_prepare+0x14a/0x169
? _raw_spin_unlock_irq+0x1f/0x29
__wait_for_common+0xbd/0x11b
__synchronize_srcu+0xfd/0x10c
? rcu_tasks_pregp_step+0x5/0x5
? __wait_for_common+0x3c/0x11b
fsnotify_connector_destroy_workfn+0x3d/0x6b
process_one_work+0x3d6/0x66d
worker_thread+0x29f/0x38a
? rescuer_thread+0x382/0x382
kthread+0xf7/0x106
? kthread_complete_and_exit+0x2d/0x2d
ret_from_fork+0x1f/0x30
</TASK>
INFO: task kworker/u4:2:40 blocked for more than 491 seconds.
Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:2    state:D stack:    0 pid:   40 ppid:     2 flags:0x00004000
Workqueue: events_unbound fsnotify_mark_destroy_workfn
Call Trace:
<TASK>
__schedule+0x6dd/0x721
? to_kthread+0x2c/0x36
? usleep_range_state+0x9d/0x9d
schedule+0x4e/0x83
schedule_timeout+0x38/0x106
? mark_held_locks+0x4a/0x5c
? lockdep_hardirqs_on_prepare+0x14a/0x169
? _raw_spin_unlock_irq+0x1f/0x29
__wait_for_common+0xbd/0x11b
__synchronize_srcu+0xfd/0x10c
? rcu_tasks_pregp_step+0x5/0x5
? __wait_for_common+0x3c/0x11b
fsnotify_mark_destroy_workfn+0x6a/0xc8
process_one_work+0x3d6/0x66d
worker_thread+0x29f/0x38a
? rescuer_thread+0x382/0x382
kthread+0xf7/0x106
? kthread_complete_and_exit+0x2d/0x2d
ret_from_fork+0x1f/0x30
</TASK>
INFO: task rmmod:1812 blocked for more than 491 seconds.
Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:rmmod           state:D stack:    0 pid: 1812 ppid:   508 flags:0x00004000
Call Trace:
<TASK>
__schedule+0x6dd/0x721
? usleep_range_state+0x9d/0x9d
schedule+0x4e/0x83
schedule_timeout+0x38/0x106
? hlock_class+0x1a/0x5d
? write_comp_data+0x20/0x71
? lockdep_hardirqs_on_prepare+0x14a/0x169
? _raw_spin_unlock_irq+0x1f/0x29
__wait_for_common+0xbd/0x11b
kthread_stop+0x1bc/0x34c
_torture_stop_kthread+0x5a/0x6a [torture]
rcu_torture_cleanup+0x23b/0x834 [rcutorture]
? prepare_to_wait_exclusive+0x83/0x83
__x64_sys_delete_module+0x109/0x1c3
? lockdep_hardirqs_on_prepare+0x14a/0x169
do_syscall_64+0x85/0xa7
entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f93a158add7
RSP: 002b:00007ffd6aef9048 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 00007f93a3179900 RCX: 00007f93a158add7
RDX: 000000000000000a RSI: 0000000000000800 RDI: 00007f93a3179968
RBP: 0000000000000000 R08: 00007ffd6aef7fc1 R09: 0000000000000000
R10: 00007f93a15fcae0 R11: 0000000000000206 R12: 00007ffd6aef9270
R13: 00007ffd6aefadfc R14: 00007f93a3179260 R15: 00007f93a3179900
</TASK>

Showing all locks held in the system:
2 locks held by kworker/u4:1/9:
#0: ffff9b4480051548 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x233/0x66d
#1: ffff9b448016fe78 (connector_reaper_work){+.+.}-{0:0}, at: process_one_work+0x233/0x66d
1 lock held by khungtaskd/29:
#0: ffffffffbaddd460 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x22
2 locks held by kworker/u4:2/40:
#0: ffff9b4480051548 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x233/0x66d
#1: ffff9b4480c93e78 ((reaper_work).work){+.+.}-{0:0}, at: process_one_work+0x233/0x66d
2 locks held by kworker/1:2/179:
1 lock held by in:imklog/431:
1 lock held by dmesg/440:

=============================================

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 5.17.0-rc1-00111-g556d8afe4a77 #1
Call Trace:
<TASK>
dump_stack_lvl+0xcd/0x134
panic+0x1c2/0x51f
? _printk+0x53/0x55
? watchdog+0x6ec/0x725
watchdog+0x6f8/0x725
? rcu_read_unlock+0x94/0x94
kthread+0xf7/0x106
? kthread_complete_and_exit+0x2d/0x2d
ret_from_fork+0x1f/0x30
</TASK>
Kernel Offset: 0x38200000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)

Kboot worker: lkp-worker57
Elapsed time: 1020

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu SandyBridge
	-kernel $kernel
	-initrd initrd-vm-snb-67.cgz
	-m 16384
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0,hostfwd=tcp::32032-:22
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	ip=::::vm-snb-67::dhcp
	root=/dev/ram0
	RESULT_ROOT=/result/rcutorture/300s-default-rcu/vm-snb/debian-10.4-x86_64-20200603.cgz/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/3
	BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a012-20210928/gcc-9/556d8afe4a779f41dfc8fa373993a88e43f1c5dc/vmlinuz-5.17.0-rc1-00111-g556d8afe4a77
	branch=linux-devel/devel-hourly-20220304-094445
	job=/job-script
	user=lkp
	ARCH=x86_64
	kconfig=x86_64-randconfig-a012-20210928
	commit=556d8afe4a779f41dfc8fa373993a88e43f1c5dc
	vmalloc=128M
	initramfs_async=0
	page_owner=on
	max_uptime=2100
	result_service=tmpfs
	selinux=0
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	rcuperf.shutdown=0
	watchdog_thresh=240
)

"${kvm[@]}" -append "${append[*]}"

--uAKRQypu60I7Lcqm--

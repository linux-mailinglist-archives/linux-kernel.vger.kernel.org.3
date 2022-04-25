Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A87950D9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiDYHFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiDYHFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:05:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3B5193DA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650870150; x=1682406150;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=d2tTQFpHvKrEUWVB8g/4UtOkjCXRK5at7CpNb7E5ViI=;
  b=JKWrg05lNAN6p3DyLHrFSzgG4sb7oyhsJ8OBG3v0Qx0F1AwFnS9iF0lC
   3NDXoQrwJKgBn2w6681yk3WTA1JnXr6WSk7Z5d6ssbT0r1ONhXvgmVOPn
   UckBaqKsa8yaaB9ZTG0USBgbmOcwT5cGE7gIy3Wwycb8z51m+ASTUWOd+
   ELB7kFZZZcR0QChoHeBr5NcDqe/UUXvpv1SrLIHa2J8cbfqkenk+00jeJ
   64rj6NxHKZmZfrQLe4rj1eTBJfmYhmffxajRrwdNtZnd3SoS/pwB9oYem
   EstgT5oylPV0IxIBLGLJGhNrWu3vi4aGjdRUGAjEtNUIHGqgpm9dSGJ5t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="262762130"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="yaml'?scan'208";a="262762130"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:02:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="yaml'?scan'208";a="660020054"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:02:06 -0700
Date:   Mon, 25 Apr 2022 15:02:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, fengwei.yin@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        joshdon@google.com, Abel Wu <wuyun.abel@bytedance.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com
Subject: [sched/fair]  6b433275e3:  stress-ng.sock.ops_per_sec 16.2%
 improvement
Message-ID: <20220425070204.GC21864@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220409135104.3733193-2-wuyun.abel@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit


(please be noted we also observed performance drop on
"netperf: netperf.Throughput_Mbps -44.4% regression",
but the data is not stable, especial the data for 6b433275e3.
details are as below)

Greeting,

FYI, we noticed a 16.2% improvement of stress-ng.sock.ops_per_sec due to commit:


commit: 6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc ("[RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS")
url: https://github.com/intel-lab-lkp/linux/commits/Abel-Wu/introduece-sched-idle-balance/20220409-215303
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 089c02ae2771a14af2928c59c56abfb9b885a8d7
patch link: https://lore.kernel.org/lkml/20220409135104.3733193-2-wuyun.abel@bytedance.com

in testcase: stress-ng
on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
with following parameters:

	nr_threads: 100%
	testtime: 60s
	class: network
	test: sock
	cpufreq_governor: performance
	ucode: 0xd000331


In addition to that, the commit also has significant impact on the following tests:

+------------------+-------------------------------------------------------------------------------------+
| testcase: change | netperf: netperf.Throughput_Mbps -44.4% regression                                  |
| test machine     | 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cluster=cs-localhost                                                                |
|                  | cpufreq_governor=performance                                                        |
|                  | ip=ipv4                                                                             |
|                  | nr_threads=200%                                                                     |
|                  | runtime=900s                                                                        |
|                  | test=TCP_STREAM                                                                     |
|                  | ucode=0x500320a                                                                     |
+------------------+-------------------------------------------------------------------------------------+
| testcase: change | stress-ng: stress-ng.fifo.ops_per_sec 26.8% improvement                             |
| test machine     | 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory |
| test parameters  | class=pipe                                                                          |
|                  | cpufreq_governor=performance                                                        |
|                  | nr_threads=100%                                                                     |
|                  | test=fifo                                                                           |
|                  | testtime=60s                                                                        |
|                  | ucode=0xd000331                                                                     |
+------------------+-------------------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        sudo bin/lkp install job.yaml           # job file is attached in this email
        bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
        sudo bin/lkp run generated-yaml-file

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.

=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  network/gcc-11/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp6/sock/stress-ng/60s/0xd000331

commit: 
  089c02ae27 ("ftrace: Use preemption model accessors for trace header printout")
  6b433275e3 ("sched/fair: filter out overloaded cpus in SIS")

089c02ae2771a14a 6b433275e3a3cf18a16c0d2afb7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   2770364           +16.2%    3218069        stress-ng.sock.ops
     46171           +16.2%      53633        stress-ng.sock.ops_per_sec
 5.952e+08           -30.3%  4.151e+08 ±  2%  stress-ng.time.involuntary_context_switches
      9199            +4.1%       9579        stress-ng.time.percent_of_cpu_this_job_got
      5427            +4.4%       5666        stress-ng.time.system_time
 6.112e+08           -28.0%  4.403e+08        stress-ng.time.voluntary_context_switches
  11029514 ±  2%     +21.5%   13402519 ±  2%  cpuidle..usage
  18689062           -29.1%   13251715        vmstat.system.cs
     60526 ± 23%     -42.3%      34928 ± 23%  numa-meminfo.node1.Active
     60526 ± 23%     -42.3%      34928 ± 23%  numa-meminfo.node1.Active(anon)
  32260894 ± 50%    +135.6%   76016130 ±  6%  numa-numastat.node0.local_node
  32321995 ± 49%    +135.3%   76056280 ±  6%  numa-numastat.node0.numa_hit
     62966 ± 24%     -41.7%      36737 ± 18%  meminfo.Active
     62966 ± 24%     -41.7%      36737 ± 18%  meminfo.Active(anon)
    120624 ± 11%     +20.5%     145331 ±  6%  meminfo.Mapped
      5.48 ±  9%      +0.7        6.21 ± 10%  mpstat.cpu.all.idle%
      1.23            +0.2        1.45 ±  3%  mpstat.cpu.all.irq%
     22.46            -3.4       19.03        mpstat.cpu.all.soft%
  32324845 ± 49%    +135.3%   76071014 ±  6%  numa-vmstat.node0.numa_hit
  32263743 ± 50%    +135.7%   76030863 ±  6%  numa-vmstat.node0.numa_local
     14955 ± 24%     -43.9%       8397 ± 24%  numa-vmstat.node1.nr_active_anon
     14955 ± 24%     -43.9%       8397 ± 24%  numa-vmstat.node1.nr_zone_active_anon
    336.75 ± 14%     +28.8%     433.89 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
   -574367           +51.0%    -867232        sched_debug.cfs_rq:/.spread0.min
   4523462           -28.5%    3234077        sched_debug.cpu.nr_switches.avg
   5422243 ± 10%     -33.1%    3628496 ±  4%  sched_debug.cpu.nr_switches.max
      2895            +3.0%       2982        turbostat.Bzy_MHz
   8257844 ±  3%     +29.9%   10727822 ±  2%  turbostat.C1
   1695590 ± 16%     -39.8%    1020687 ± 14%  turbostat.C1E
    183102 ±105%    +167.3%     489441 ±  6%  turbostat.C6
      1.87 ±109%      +3.3        5.19 ± 13%  turbostat.C6%
      1.64 ±122%    +200.5%       4.94 ± 13%  turbostat.CPU%c6
      0.28 ±  7%     -16.4%       0.24        turbostat.IPC
    874435 ±  2%     +31.4%    1148985 ±  3%  turbostat.POLL
      0.02            +0.0        0.03        turbostat.POLL%
     15257 ± 23%     -41.6%       8903 ± 25%  proc-vmstat.nr_active_anon
     98281 ±  3%      +6.9%     105084 ±  3%  proc-vmstat.nr_inactive_anon
     30793 ± 12%     +19.1%      36686 ±  7%  proc-vmstat.nr_mapped
     87672            +1.4%      88924        proc-vmstat.nr_slab_unreclaimable
     15257 ± 23%     -41.6%       8903 ± 25%  proc-vmstat.nr_zone_active_anon
     98281 ±  3%      +6.9%     105084 ±  3%  proc-vmstat.nr_zone_inactive_anon
 1.005e+08 ±  2%     +56.5%  1.573e+08        proc-vmstat.numa_hit
 1.004e+08 ±  2%     +56.6%  1.572e+08        proc-vmstat.numa_local
      2209 ± 14%     +28.4%       2837 ±  9%  proc-vmstat.numa_pages_migrated
 1.004e+08 ±  2%     +56.5%  1.572e+08        proc-vmstat.pgalloc_normal
    435497            +2.0%     444333        proc-vmstat.pgfault
 1.002e+08 ±  2%     +56.6%   1.57e+08        proc-vmstat.pgfree
      2209 ± 14%     +28.4%       2837 ±  9%  proc-vmstat.pgmigrate_success
      8.30 ±  3%     +65.2%      13.72        perf-stat.i.MPKI
 5.662e+10           -10.7%  5.059e+10        perf-stat.i.branch-instructions
 5.571e+08           -13.4%  4.824e+08        perf-stat.i.branch-misses
     11.62 ±  4%      -2.3        9.29        perf-stat.i.cache-miss-rate%
 2.871e+08 ±  6%     +16.8%  3.354e+08        perf-stat.i.cache-misses
 2.404e+09 ±  2%     +47.0%  3.533e+09        perf-stat.i.cache-references
  19355289           -28.7%   13800045        perf-stat.i.context-switches
      1.20           +15.6%       1.39        perf-stat.i.cpi
 3.491e+11            +3.1%  3.601e+11        perf-stat.i.cpu-cycles
    102803 ±  2%    +154.7%     261853 ±  2%  perf-stat.i.cpu-migrations
      1397 ±  8%     -15.3%       1184        perf-stat.i.cycles-between-cache-misses
      0.01 ± 40%      +0.0        0.01 ±  2%  perf-stat.i.dTLB-load-miss-rate%
   2927467 ±  8%     +98.1%    5798140 ±  4%  perf-stat.i.dTLB-load-misses
 8.529e+10           -11.0%  7.595e+10        perf-stat.i.dTLB-loads
      0.01 ±  9%      +0.0        0.02 ±  4%  perf-stat.i.dTLB-store-miss-rate%
   3922667 ±  4%     +51.1%    5927414 ±  5%  perf-stat.i.dTLB-store-misses
 4.909e+10           -11.3%  4.355e+10        perf-stat.i.dTLB-stores
 2.892e+11           -10.9%  2.578e+11        perf-stat.i.instructions
      0.83           -13.5%       0.72        perf-stat.i.ipc
     12.76            +3.0%      13.14        perf-stat.i.major-faults
      2.73            +3.1%       2.81        perf-stat.i.metric.GHz
      1511           -10.2%       1356        perf-stat.i.metric.M/sec
      6.04 ±  9%      +1.5        7.54 ±  3%  perf-stat.i.node-load-miss-rate%
   3432454 ±  7%     +37.7%    4726278 ±  5%  perf-stat.i.node-load-misses
      4.08 ±  5%      +1.4        5.51 ±  3%  perf-stat.i.node-store-miss-rate%
   2905147 ±  3%    +100.9%    5837508 ±  2%  perf-stat.i.node-store-misses
  94641010 ±  7%     +29.5%  1.226e+08        perf-stat.i.node-stores
      8.31 ±  3%     +64.7%      13.68        perf-stat.overall.MPKI
      0.98            -0.0        0.95        perf-stat.overall.branch-miss-rate%
     11.99 ±  4%      -2.5        9.52        perf-stat.overall.cache-miss-rate%
      1.21           +15.6%       1.40        perf-stat.overall.cpi
      1216 ±  6%     -11.9%       1072        perf-stat.overall.cycles-between-cache-misses
      0.00 ±  8%      +0.0        0.01 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.01 ±  4%      +0.0        0.01 ±  4%  perf-stat.overall.dTLB-store-miss-rate%
      0.83           -13.5%       0.72        perf-stat.overall.ipc
      3.92 ± 11%      +1.9        5.79 ±  5%  perf-stat.overall.node-load-miss-rate%
      2.99 ±  7%      +1.6        4.54 ±  3%  perf-stat.overall.node-store-miss-rate%
  5.58e+10           -10.5%  4.994e+10        perf-stat.ps.branch-instructions
 5.489e+08           -13.3%   4.76e+08        perf-stat.ps.branch-misses
  2.84e+08 ±  6%     +16.6%  3.312e+08        perf-stat.ps.cache-misses
 2.368e+09 ±  2%     +47.0%   3.48e+09        perf-stat.ps.cache-references
  19072464           -28.5%   13641191        perf-stat.ps.context-switches
 3.442e+11            +3.2%   3.55e+11        perf-stat.ps.cpu-cycles
    100880 ±  2%    +155.1%     257340 ±  3%  perf-stat.ps.cpu-migrations
   2896052 ±  8%     +96.9%    5703524 ±  4%  perf-stat.ps.dTLB-load-misses
 8.405e+10           -10.8%  7.497e+10        perf-stat.ps.dTLB-loads
   3866307 ±  4%     +50.8%    5831234 ±  5%  perf-stat.ps.dTLB-store-misses
 4.837e+10           -11.1%    4.3e+10        perf-stat.ps.dTLB-stores
 2.851e+11           -10.7%  2.545e+11        perf-stat.ps.instructions
   3390204 ±  7%     +37.5%    4661478 ±  5%  perf-stat.ps.node-load-misses
   2868113 ±  3%    +100.3%    5743781 ±  2%  perf-stat.ps.node-store-misses
  93732924 ±  8%     +29.0%  1.209e+08        perf-stat.ps.node-stores
 1.806e+13           -11.0%  1.608e+13        perf-stat.total.instructions
     19.88 ±  2%      -5.6       14.29        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     18.37 ±  2%      -5.1       13.29        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
     23.38            -5.1       18.33        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     23.67            -5.1       18.61        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     23.43            -4.5       18.92        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     23.11            -4.4       18.69        perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit
     32.14            -4.3       27.80        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     21.73            -4.0       17.72        perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     18.02 ±  2%      -4.0       14.07        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     21.20 ±  2%      -3.8       17.41        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
     21.09 ±  2%      -3.8       17.33        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
     40.66            -3.7       36.96        perf-profile.calltrace.cycles-pp.recv
     18.40 ±  2%      -3.5       14.87        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     20.08 ±  2%      -3.5       16.58        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
     13.86 ±  2%      -3.4       10.49        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
     17.69 ±  2%      -3.4       14.33        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     38.54            -3.3       35.21        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv
     17.30            -3.3       13.98        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     14.71 ±  2%      -3.3       11.42        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
     38.16            -3.3       34.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     11.91            -3.1        8.80        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
     37.21            -3.1       34.12        perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     37.06            -3.1       34.00        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     35.66            -3.0       32.61        perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     35.39            -3.0       32.39        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     11.15            -2.8        8.32        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      8.63 ±  3%      -2.8        5.84        perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      8.50 ±  3%      -2.8        5.73        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      9.58 ±  3%      -2.7        6.84        perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      8.25 ±  3%      -2.7        5.54        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
     15.50 ±  2%      -2.7       12.83        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      8.02 ±  3%      -2.7        5.37        perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
      8.25 ±  3%      -2.5        5.78        perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      9.96            -2.4        7.52        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
      7.88 ±  3%      -2.4        5.44        perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
      7.70 ±  3%      -2.4        5.32        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      7.48 ±  3%      -2.3        5.16        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
      8.16            -1.9        6.26        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      4.87 ±  2%      -1.8        3.05 ±  2%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
      4.69 ±  2%      -1.8        2.90 ±  2%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
      3.83 ±  2%      -1.6        2.28 ±  2%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      3.66 ±  2%      -1.5        2.19 ±  2%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      2.98 ±  3%      -1.1        1.91 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
      2.88 ±  3%      -1.0        1.84 ±  2%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.__wake_up_common.__wake_up_common_lock
      4.00 ±  2%      -1.0        2.98        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.63 ±  3%      -0.9        1.68 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.__wake_up_common
      2.45 ±  2%      -0.8        1.63 ±  2%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      2.85 ±  3%      -0.8        2.02        perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      2.61 ±  2%      -0.8        1.81        perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable
      2.52 ±  3%      -0.8        1.75        perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common.__wake_up_common_lock
      2.31 ±  2%      -0.6        1.70        perf-profile.calltrace.cycles-pp.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
      2.18            -0.6        1.60 ±  2%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      2.22            -0.6        1.65        perf-profile.calltrace.cycles-pp.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
      1.76 ±  3%      -0.6        1.21 ±  2%  perf-profile.calltrace.cycles-pp.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up
      1.64 ±  2%      -0.5        1.10 ±  3%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      2.02            -0.5        1.52        perf-profile.calltrace.cycles-pp.loopback_xmit.xmit_one.dev_hard_start_xmit.__dev_queue_xmit.ip_finish_output2
      0.98 ±  3%      -0.4        0.59 ±  4%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.02 ±  2%      -0.4        0.65 ±  2%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.53 ±  2%      -0.4        1.18        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      1.15 ±  2%      -0.3        0.84        perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.schedule_timeout.wait_woken
      1.03 ±  3%      -0.3        0.72 ±  2%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.__wake_up_common
      0.94 ±  2%      -0.3        0.64 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_send_ack.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.87 ±  2%      -0.3        0.58 ±  2%  perf-profile.calltrace.cycles-pp.__alloc_skb.__tcp_send_ack.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      1.59            -0.3        1.32        perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.75 ±  2%      -0.2        0.54 ±  2%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      0.98 ±  3%      -0.2        0.80 ±  2%  perf-profile.calltrace.cycles-pp.dequeue_entity.dequeue_task_fair.__schedule.schedule.schedule_timeout
      1.78            -0.1        1.65        perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.71 ±  2%      -0.1        0.59        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      0.74            -0.1        0.67        perf-profile.calltrace.cycles-pp.tcp_rcv_space_adjust.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.70 ±  3%      -0.0        0.65        perf-profile.calltrace.cycles-pp.aa_sk_perm.security_socket_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.64            -0.0        0.60 ±  2%  perf-profile.calltrace.cycles-pp.sockfd_lookup_light.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84            +0.1        0.94        perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.58            +0.1        0.70        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      1.21            +0.1        1.34        perf-profile.calltrace.cycles-pp.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64
      0.98            +0.1        1.12        perf-profile.calltrace.cycles-pp.tcp_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl
      1.34            +0.1        1.48        perf-profile.calltrace.cycles-pp.sock_ioctl.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64            +0.1        0.78        perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      0.80 ±  9%      +0.2        0.96        perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
      1.49            +0.2        1.65        perf-profile.calltrace.cycles-pp.do_vfs_ioctl.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      1.03 ±  9%      +0.2        1.20        perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      1.03 ±  9%      +0.2        1.21        perf-profile.calltrace.cycles-pp.__kfree_skb.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.85 ±  9%      +0.2        1.03        perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
      2.33            +0.3        2.58        perf-profile.calltrace.cycles-pp.__x64_sys_ioctl.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.41 ± 71%      +0.3        0.66        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      2.58            +0.3        2.83        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ioctl
      0.62 ±  2%      +0.3        0.88        perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
      2.70            +0.3        2.96        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ioctl
      0.62 ±  2%      +0.3        0.88        perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.64 ±  2%      +0.3        0.90        perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__connect
      0.64 ±  2%      +0.3        0.91        perf-profile.calltrace.cycles-pp.__connect
      0.64 ±  2%      +0.3        0.90        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__connect
      0.64 ±  2%      +0.3        0.90        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__connect
      0.64 ±  2%      +0.3        0.90        perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.__connect
      0.59 ±  5%      +0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.59 ±  4%      +0.3        0.86 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
      0.60 ±  4%      +0.3        0.87 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      3.48            +0.3        3.76        perf-profile.calltrace.cycles-pp.ioctl
      0.63 ±  2%      +0.3        0.92        perf-profile.calltrace.cycles-pp.tcp_send_mss.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      1.20 ±  8%      +0.3        1.51        perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.22 ±  8%      +0.3        1.54        perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.60            +0.3        0.93        perf-profile.calltrace.cycles-pp.lock_sock_nested.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.43 ± 44%      +0.3        0.77        perf-profile.calltrace.cycles-pp.tcp_current_mss.tcp_send_mss.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.17 ±141%      +0.4        0.58        perf-profile.calltrace.cycles-pp.__check_object_size.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.60 ±  3%      +0.4        1.02        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.__entry_text_start.send
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.__lock_sock_fast.tcp_ioctl.sock_do_ioctl.sock_ioctl.do_vfs_ioctl
      0.00            +0.6        0.55 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.00            +0.6        0.56        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.6        0.60        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.6        0.65        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.7        0.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close
      0.00            +0.7        0.66 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.lock_sock_nested.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.00            +0.7        0.68        perf-profile.calltrace.cycles-pp.__close
      0.55 ±  6%      +0.7        1.26 ±  4%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg
      0.00            +0.7        0.71 ±  6%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      0.00            +0.7        0.73 ±  3%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
      0.00            +0.8        0.75 ±  2%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.00            +0.8        0.78 ±  2%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
      0.72 ±  7%      +0.8        1.52 ±  3%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg
      0.69 ±  5%      +0.8        1.52 ±  2%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      0.00            +0.9        0.89 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.04 ±  8%      +0.9        1.94 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      0.77 ±  5%      +0.9        1.68 ±  3%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      0.09 ±223%      +1.0        1.08 ±  2%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      1.34 ±  6%      +1.0        2.35 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.87 ±  5%      +1.0        1.90 ±  2%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      0.88 ±  5%      +1.0        1.91 ±  2%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.49 ±  3%      +1.3        2.82        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      1.52 ±  4%      +1.3        2.87        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      4.52 ±  6%      +1.4        5.88        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
      4.61 ±  6%      +1.4        5.97        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      3.50 ±  5%      +1.4        4.87        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked
      3.62 ±  5%      +1.4        5.01        perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg
      5.01 ±  6%      +1.4        6.42        perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      4.24 ±  4%      +1.6        5.80        perf-profile.calltrace.cycles-pp._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      6.42 ±  5%      +1.6        8.04        perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
      6.51 ±  4%      +1.6        8.12        perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      4.94 ±  4%      +1.7        6.63        perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      2.35 ±  3%      +1.9        4.21 ±  2%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
     36.64            +2.0       38.63        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     51.16            +2.0       53.20        perf-profile.calltrace.cycles-pp.send
      2.77 ±  3%      +2.0        4.82 ±  2%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     49.13            +2.3       51.47        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.send
     48.76            +2.4       51.13        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
      1.00 ±  9%      +3.4        4.43 ±  8%  perf-profile.calltrace.cycles-pp.__sk_mem_raise_allocated.__sk_mem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      1.02 ±  9%      +3.4        4.46 ±  8%  perf-profile.calltrace.cycles-pp.__sk_mem_schedule.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     43.50            +4.2       47.74        perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
     43.21            +4.3       47.52        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
     41.92            +4.4       46.33        perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     40.49            +4.4       44.93        perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     35.21            -6.5       28.67        perf-profile.children.cycles-pp.__tcp_transmit_skb
     32.41            -6.0       26.44        perf-profile.children.cycles-pp.__ip_queue_xmit
     29.91            -5.4       24.53        perf-profile.children.cycles-pp.ip_finish_output2
     25.44            -4.4       21.05        perf-profile.children.cycles-pp.__local_bh_enable_ip
     32.21            -4.3       27.87        perf-profile.children.cycles-pp.tcp_recvmsg_locked
     24.83            -4.3       20.52        perf-profile.children.cycles-pp.do_softirq
     24.72            -4.1       20.63        perf-profile.children.cycles-pp.__softirqentry_text_start
     11.63 ±  2%      -3.9        7.72        perf-profile.children.cycles-pp.schedule
     23.16            -3.9       19.27        perf-profile.children.cycles-pp.net_rx_action
     25.57            -3.8       21.80        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     22.67            -3.8       18.92        perf-profile.children.cycles-pp.__napi_poll
     22.58            -3.7       18.85        perf-profile.children.cycles-pp.process_backlog
     40.99            -3.7       37.30        perf-profile.children.cycles-pp.recv
     21.77            -3.6       18.15        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     11.89 ±  2%      -3.6        8.28        perf-profile.children.cycles-pp.__schedule
     19.98            -3.3       16.68        perf-profile.children.cycles-pp.ip_local_deliver_finish
     25.81            -3.1       22.66        perf-profile.children.cycles-pp.tcp_write_xmit
     19.32            -3.1       16.18        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     18.99            -3.1       15.86        perf-profile.children.cycles-pp.tcp_v4_rcv
     37.25            -3.1       34.15        perf-profile.children.cycles-pp.__x64_sys_recvfrom
     37.10            -3.1       34.04        perf-profile.children.cycles-pp.__sys_recvfrom
     35.67            -3.0       32.63        perf-profile.children.cycles-pp.inet_recvmsg
     35.48            -3.0       32.47        perf-profile.children.cycles-pp.tcp_recvmsg
      9.62 ±  3%      -2.8        6.87        perf-profile.children.cycles-pp.sk_wait_data
      8.26 ±  3%      -2.5        5.79        perf-profile.children.cycles-pp.wait_woken
      8.95 ±  3%      -2.4        6.50        perf-profile.children.cycles-pp.__wake_up_common_lock
      9.06 ±  3%      -2.4        6.62        perf-profile.children.cycles-pp.sock_def_readable
      7.95 ±  2%      -2.4        5.54        perf-profile.children.cycles-pp.schedule_timeout
      8.67 ±  3%      -2.4        6.27        perf-profile.children.cycles-pp.__wake_up_common
      8.48 ±  3%      -2.4        6.10        perf-profile.children.cycles-pp.try_to_wake_up
      6.19 ±  2%      -1.7        4.45        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      5.82 ±  2%      -1.7        4.09        perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      4.42 ±  2%      -1.4        3.01        perf-profile.children.cycles-pp.exit_to_user_mode_loop
     16.59 ±  2%      -1.4       15.23        perf-profile.children.cycles-pp.tcp_rcv_established
      3.11 ±  3%      -1.0        2.12        perf-profile.children.cycles-pp.select_task_rq
      3.01 ±  3%      -1.0        2.04        perf-profile.children.cycles-pp.select_task_rq_fair
      2.77 ±  3%      -0.9        1.86 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
     18.43            -0.9       17.54        perf-profile.children.cycles-pp.tcp_v4_do_rcv
      2.90 ±  3%      -0.8        2.08        perf-profile.children.cycles-pp.dequeue_task_fair
      1.58 ±  3%      -0.7        0.84 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
      2.75 ±  2%      -0.7        2.04        perf-profile.children.cycles-pp.ttwu_do_activate
      2.67 ±  3%      -0.7        1.98        perf-profile.children.cycles-pp.enqueue_task_fair
      2.32 ±  2%      -0.7        1.67        perf-profile.children.cycles-pp.switch_mm_irqs_off
      4.38            -0.6        3.75        perf-profile.children.cycles-pp.__dev_queue_xmit
      2.00 ±  3%      -0.6        1.42 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.88 ±  3%      -0.5        1.35 ±  2%  perf-profile.children.cycles-pp.select_idle_cpu
      2.73            -0.5        2.21        perf-profile.children.cycles-pp.__alloc_skb
      1.69 ±  3%      -0.5        1.20 ±  2%  perf-profile.children.cycles-pp.update_curr
      2.03 ±  3%      -0.5        1.54        perf-profile.children.cycles-pp.update_load_avg
      1.12 ±  4%      -0.5        0.66        perf-profile.children.cycles-pp.available_idle_cpu
      2.61            -0.4        2.18        perf-profile.children.cycles-pp.dev_hard_start_xmit
      2.51            -0.4        2.11        perf-profile.children.cycles-pp.xmit_one
      0.87 ±  2%      -0.4        0.48 ±  3%  perf-profile.children.cycles-pp.reweight_entity
      2.34            -0.4        1.97        perf-profile.children.cycles-pp.loopback_xmit
      3.40            -0.3        3.08        perf-profile.children.cycles-pp.tcp_ack
      1.13 ±  2%      -0.3        0.84        perf-profile.children.cycles-pp.switch_fpu_return
      1.14 ±  3%      -0.3        0.87        perf-profile.children.cycles-pp.enqueue_entity
      1.13            -0.2        0.88        perf-profile.children.cycles-pp.__tcp_send_ack
      2.40 ±  4%      -0.2        2.16        perf-profile.children.cycles-pp._raw_spin_lock
      0.83 ±  3%      -0.2        0.58 ±  3%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.87 ±  2%      -0.2        0.63 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.76 ±  2%      -0.2        0.52 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.73 ±  4%      -0.2        0.49 ±  2%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.81 ±  2%      -0.2        0.58 ±  2%  perf-profile.children.cycles-pp.__switch_to_asm
      0.71 ±  3%      -0.2        0.48 ±  2%  perf-profile.children.cycles-pp.___perf_sw_event
      0.63 ±  3%      -0.2        0.41 ±  4%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      1.16            -0.2        0.93 ±  2%  perf-profile.children.cycles-pp.__netif_rx
      0.93            -0.2        0.71        perf-profile.children.cycles-pp.kmalloc_reserve
      0.91 ±  2%      -0.2        0.68 ±  3%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.65            -0.2        0.43 ±  2%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.70 ±  3%      -0.2        0.49 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      1.10            -0.2        0.89 ±  2%  perf-profile.children.cycles-pp.netif_rx_internal
      0.78            -0.2        0.57 ±  3%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.75 ±  3%      -0.2        0.54 ±  2%  perf-profile.children.cycles-pp.set_next_entity
      0.66 ±  4%      -0.2        0.46        perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.83            -0.2        0.64        perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      1.02            -0.2        0.83        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.67            -0.2        0.48 ±  2%  perf-profile.children.cycles-pp.validate_xmit_skb
      1.03 ±  3%      -0.2        0.84        perf-profile.children.cycles-pp.dequeue_entity
      0.72 ±  2%      -0.2        0.54 ±  3%  perf-profile.children.cycles-pp.native_sched_clock
      0.63 ±  4%      -0.2        0.44        perf-profile.children.cycles-pp.check_preempt_curr
      0.54 ±  4%      -0.2        0.36        perf-profile.children.cycles-pp.check_preempt_wakeup
      2.31            -0.2        2.15        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      0.45 ±  2%      -0.2        0.29 ±  3%  perf-profile.children.cycles-pp.put_prev_entity
      0.57 ±  2%      -0.2        0.42 ±  2%  perf-profile.children.cycles-pp.ip_output
      0.67            -0.2        0.52 ±  2%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.54            -0.1        0.40 ±  2%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.38 ±  2%      -0.1        0.24 ±  4%  perf-profile.children.cycles-pp.cpumask_next_wrap
      0.36 ±  2%      -0.1        0.23 ±  4%  perf-profile.children.cycles-pp._find_next_bit
      0.77            -0.1        0.64        perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.46 ±  2%      -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.ip_rcv_core
      1.82            -0.1        1.70        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.83            -0.1        0.72        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.49            -0.1        0.38 ±  2%  perf-profile.children.cycles-pp.ip_local_out
      0.32 ±  2%      -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.netif_skb_features
      0.30 ±  2%      -0.1        0.20 ±  3%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.90 ±  2%      -0.1        0.80 ±  2%  perf-profile.children.cycles-pp.ip_rcv
      0.27 ±  2%      -0.1        0.17 ±  4%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      1.10            -0.1        1.00        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.31 ±  3%      -0.1        0.21 ±  2%  perf-profile.children.cycles-pp.nf_hook_slow
      0.42 ±  2%      -0.1        0.33 ±  2%  perf-profile.children.cycles-pp.__ip_local_out
      0.24 ±  6%      -0.1        0.16 ±  4%  perf-profile.children.cycles-pp.update_min_vruntime
      0.21 ±  2%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.__calc_delta
      1.09            -0.1        1.01        perf-profile.children.cycles-pp.read_tsc
      0.20 ±  4%      -0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.28 ±  3%      -0.1        0.21 ±  5%  perf-profile.children.cycles-pp.perf_tp_event
      0.75            -0.1        0.68        perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.21 ±  3%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.pick_next_entity
      0.18 ±  3%      -0.1        0.12 ±  4%  perf-profile.children.cycles-pp.apparmor_ip_postroute
      0.32 ±  2%      -0.1        0.26 ±  2%  perf-profile.children.cycles-pp.remove_wait_queue
      0.30 ±  2%      -0.1        0.24        perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.14 ±  3%      -0.1        0.09 ±  4%  perf-profile.children.cycles-pp.skb_network_protocol
      0.25 ±  3%      -0.1        0.20 ±  4%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.20 ±  4%      -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.cpumask_next
      0.35            -0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__list_add_valid
      0.28            -0.1        0.22 ±  3%  perf-profile.children.cycles-pp.ip_send_check
      0.21 ±  3%      -0.1        0.16 ±  3%  perf-profile.children.cycles-pp.ip_finish_output
      0.20            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__fdget
      0.73            -0.0        0.68        perf-profile.children.cycles-pp.kfree
      0.28 ±  2%      -0.0        0.23 ±  3%  perf-profile.children.cycles-pp.__ip_finish_output
      0.18 ±  2%      -0.0        0.13 ±  5%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.21 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.inet_ehashfn
      0.54            -0.0        0.49        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.28 ±  3%      -0.0        0.23        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.10 ±  8%      -0.0        0.06        perf-profile.children.cycles-pp.switch_ldt
      0.14 ±  2%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.__copy_skb_header
      0.16 ±  6%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.15 ±  5%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.12            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.ip_local_deliver
      0.11 ±  5%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.kmalloc_slab
      0.32            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.import_single_range
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.19 ±  4%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.add_wait_queue
      0.18 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.14 ±  3%      -0.0        0.11 ±  5%  perf-profile.children.cycles-pp.tcp_inbound_md5_hash
      0.06            -0.0        0.02 ± 99%  perf-profile.children.cycles-pp.__raise_softirq_irqoff
      0.14 ±  5%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.set_next_buddy
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.tcp_options_write
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.neigh_hh_output
      0.32 ±  3%      -0.0        0.29 ±  3%  perf-profile.children.cycles-pp.__ksize
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.__tcp_select_window
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.sched_clock
      0.09 ±  5%      -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.clear_buddies
      0.48            -0.0        0.46        perf-profile.children.cycles-pp.__list_del_entry_valid
      0.10 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.children.cycles-pp.perf_swevent_get_recursion_context
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tcp_skb_entail
      0.40            -0.0        0.38 ±  2%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.skb_clone_tx_timestamp
      0.10 ±  4%      -0.0        0.07        perf-profile.children.cycles-pp.qdisc_pkt_len_init
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.12 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rb_erase
      0.13 ±  3%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.15 ±  7%      -0.0        0.13 ±  6%  perf-profile.children.cycles-pp.cpuacct_charge
      0.12 ±  6%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.eth_type_trans
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__build_skb_around
      0.07 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.schedule_debug
      0.10 ±  4%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_rate_skb_sent
      0.09            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.tcp_v4_send_check
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.09 ±  5%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.tracing_gen_ctx_irq_test
      0.13 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.validate_xmit_vlan
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.skb_push
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.tcp_rate_gen
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.tcp_rearm_rto
      0.43 ±  2%      -0.0        0.41        perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.10 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.tcp_rate_skb_delivered
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.11 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.skb_clone
      0.10 ±  4%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.tcp_newly_delivered
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.rb_insert_color
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.rb_next
      0.07 ±  5%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.kthread
      0.10 ±  3%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.inet_sendmsg
      0.12 ±  3%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tcp_update_recv_tstamps
      0.05            +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.do_tcp_getsockopt
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.rb_first
      0.10 ±  3%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.tcp_check_space
      0.05 ±  8%      +0.0        0.07        perf-profile.children.cycles-pp.tcp_downgrade_zcopy_pure
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.security_file_alloc
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.__d_alloc
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.getsockname
      0.04 ± 44%      +0.0        0.06        perf-profile.children.cycles-pp.inode_init_always
      0.06 ±  7%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_rate_check_app_limited
      0.05            +0.0        0.07        perf-profile.children.cycles-pp.__sk_destruct
      0.06            +0.0        0.08        perf-profile.children.cycles-pp.tcp_small_queue_check
      0.06 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.do_dentry_open
      0.08 ±  6%      +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.alloc_file_pseudo
      0.06 ±  6%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.33            +0.0        0.35        perf-profile.children.cycles-pp.__mod_timer
      0.08 ±  5%      +0.0        0.11        perf-profile.children.cycles-pp.sock_alloc
      0.11            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__sock_wfree
      0.08 ±  6%      +0.0        0.10        perf-profile.children.cycles-pp.sock_alloc_file
      0.07 ± 10%      +0.0        0.10        perf-profile.children.cycles-pp.free_unref_page_commit
      0.09 ±  5%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.tcp_conn_request
      0.08 ±  5%      +0.0        0.11 ±  3%  perf-profile.children.cycles-pp.dentry_open
      0.14 ±  2%      +0.0        0.17 ±  2%  perf-profile.children.cycles-pp.__sys_getsockopt
      0.08            +0.0        0.11        perf-profile.children.cycles-pp.seq_read
      0.08            +0.0        0.11        perf-profile.children.cycles-pp.seq_read_iter
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.children.cycles-pp.check_new_pages
      0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.10 ±  5%      +0.0        0.13        perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.07            +0.0        0.10        perf-profile.children.cycles-pp.tcp_v4_syn_recv_sock
      0.07            +0.0        0.10        perf-profile.children.cycles-pp.do_tcp_setsockopt
      0.10 ±  3%      +0.0        0.13        perf-profile.children.cycles-pp.__dentry_kill
      0.09 ±  4%      +0.0        0.12 ±  4%  perf-profile.children.cycles-pp.sk_free
      0.09 ±  4%      +0.0        0.12        perf-profile.children.cycles-pp.tcp_mtu_probe
      0.11 ±  9%      +0.0        0.14 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.12 ±  5%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.alloc_inode
      0.09 ±  5%      +0.0        0.12        perf-profile.children.cycles-pp.tcp_check_req
      0.10 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.dentry_kill
      0.09 ±  5%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.vfs_read
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__x64_sys_getsockopt
      0.12 ±  5%      +0.0        0.16 ±  3%  perf-profile.children.cycles-pp.alloc_empty_file
      0.12 ±  4%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.__alloc_file
      0.09 ±  5%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.ksys_read
      0.02 ± 99%      +0.0        0.06        perf-profile.children.cycles-pp.do_open
      0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
      0.10 ±  4%      +0.0        0.14 ±  2%  perf-profile.children.cycles-pp.read
      0.06 ±  7%      +0.0        0.10        perf-profile.children.cycles-pp.__zone_watermark_ok
      0.20 ±  2%      +0.0        0.23 ±  2%  perf-profile.children.cycles-pp.kfree_skbmem
      0.58            +0.0        0.62        perf-profile.children.cycles-pp.__might_fault
      0.14            +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__x64_sys_setsockopt
      0.21 ±  3%      +0.0        0.25 ±  2%  perf-profile.children.cycles-pp.getsockopt
      0.14 ±  2%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.dput
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.__sys_setsockopt
      0.09 ±  8%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.__x64_sys_accept
      0.02 ± 99%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.link_path_walk
      0.38 ±  2%      +0.0        0.42        perf-profile.children.cycles-pp.__sk_dst_check
      0.09 ±  6%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__x64_sys_accept4
      0.12 ±  4%      +0.0        0.16        perf-profile.children.cycles-pp.__ns_get_path
      0.02 ±141%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_ack_update_window
      0.14 ±  3%      +0.0        0.18 ±  2%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.10 ±  4%      +0.0        0.15        perf-profile.children.cycles-pp.accept
      0.08 ±  8%      +0.0        0.13 ±  2%  perf-profile.children.cycles-pp.inet_csk_accept
      0.10 ±  3%      +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.tcp_fin
      0.01 ±223%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.alloc_file
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sk_clone_lock
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.___slab_alloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sock_alloc_inode
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.sk_alloc
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.seq_show
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__vsnprintf_chk
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.evict
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.walk_component
      0.08 ±  6%      +0.1        0.13 ±  2%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.11 ±  6%      +0.1        0.16 ±  3%  perf-profile.children.cycles-pp.accept4
      0.00            +0.1        0.05 ±  7%  perf-profile.children.cycles-pp.tcp_done
      0.28 ±  6%      +0.1        0.33        perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.20 ±  2%      +0.1        0.25        perf-profile.children.cycles-pp.setsockopt
      0.08 ± 26%      +0.1        0.13 ± 28%  perf-profile.children.cycles-pp.mod_objcg_state
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.dev_ifconf
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.inet_csk_clone_lock
      0.02 ±141%      +0.1        0.07        perf-profile.children.cycles-pp.inet_create
      0.04 ± 71%      +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.12 ±  4%      +0.1        0.18        perf-profile.children.cycles-pp.__sock_create
      0.41 ±  5%      +0.1        0.46        perf-profile.children.cycles-pp.skb_release_head_state
      0.09 ±  6%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.inet_accept
      0.02 ± 99%      +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.page_counter_uncharge
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.set_task_cpu
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.ip_route_output_flow
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.tcp_validate_incoming
      0.15 ±  4%      +0.1        0.21 ±  2%  perf-profile.children.cycles-pp.do_filp_open
      0.15 ±  4%      +0.1        0.21        perf-profile.children.cycles-pp.path_openat
      0.00            +0.1        0.06        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.11 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.tcp_child_process
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.tcp_create_openreq_child
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.inet_csk_destroy_sock
      0.18 ±  5%      +0.1        0.24        perf-profile.children.cycles-pp.do_sys_openat2
      0.18 ±  6%      +0.1        0.24 ±  2%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.20 ±  2%      +0.1        0.27        perf-profile.children.cycles-pp.tcp_tso_segs
      0.17 ±  4%      +0.1        0.24        perf-profile.children.cycles-pp.__sys_socket
      0.02 ±146%      +0.1        0.09 ± 38%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.07        perf-profile.children.cycles-pp.lock_timer_base
      0.17 ±  4%      +0.1        0.24        perf-profile.children.cycles-pp.__x64_sys_socket
      0.20 ±  6%      +0.1        0.27        perf-profile.children.cycles-pp.tcp_tx_timestamp
      0.18 ±  4%      +0.1        0.26        perf-profile.children.cycles-pp.__socket
      0.17 ±  4%      +0.1        0.24        perf-profile.children.cycles-pp.do_accept
      0.11 ±  8%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.skb_try_coalesce
      0.22 ±  4%      +0.1        0.30 ±  3%  perf-profile.children.cycles-pp.sock_put
      0.19 ±  5%      +0.1        0.26        perf-profile.children.cycles-pp.open
      0.18 ±  4%      +0.1        0.26 ±  2%  perf-profile.children.cycles-pp.__sys_accept4
      0.10 ±  4%      +0.1        0.18 ±  4%  perf-profile.children.cycles-pp.__sk_flush_backlog
      1.36            +0.1        1.45        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.23 ±  3%      +0.1        0.31        perf-profile.children.cycles-pp.open_related_ns
      0.13 ±  5%      +0.1        0.21        perf-profile.children.cycles-pp.__free_one_page
      0.17 ±  4%      +0.1        0.25        perf-profile.children.cycles-pp.__sys_accept4_file
      0.29            +0.1        0.37        perf-profile.children.cycles-pp.tcp_queue_rcv
      0.10 ±  8%      +0.1        0.18 ±  3%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.98            +0.1        1.07        perf-profile.children.cycles-pp.__cond_resched
      0.33 ±  4%      +0.1        0.42 ±  5%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      0.13 ±  2%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp.__tcp_close
      1.17            +0.1        1.26        perf-profile.children.cycles-pp.__entry_text_start
      0.22 ±  2%      +0.1        0.31        perf-profile.children.cycles-pp.tcp_connect
      0.33 ±  4%      +0.1        0.42 ±  4%  perf-profile.children.cycles-pp.intel_idle
      0.14 ±  2%      +0.1        0.24 ±  3%  perf-profile.children.cycles-pp.tcp_close
      0.12 ±  7%      +0.1        0.22        perf-profile.children.cycles-pp.tcp_try_coalesce
      0.12 ±  4%      +0.1        0.21        perf-profile.children.cycles-pp.tcp_add_backlog
      0.86            +0.1        0.96        perf-profile.children.cycles-pp.simple_copy_to_iter
      0.32 ±  3%      +0.1        0.43        perf-profile.children.cycles-pp.__sys_shutdown
      0.17 ±  2%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.inet_release
      0.33 ±  2%      +0.1        0.44        perf-profile.children.cycles-pp.shutdown
      0.24 ±  4%      +0.1        0.35        perf-profile.children.cycles-pp.tcp_push
      0.37 ±  5%      +0.1        0.48 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.32 ±  3%      +0.1        0.43        perf-profile.children.cycles-pp.__x64_sys_shutdown
      0.14 ±  3%      +0.1        0.24 ±  4%  perf-profile.children.cycles-pp.schedule_idle
      0.18 ±  2%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.__sock_release
      0.32 ±  2%      +0.1        0.43        perf-profile.children.cycles-pp.inet_shutdown
      0.38 ±  5%      +0.1        0.49 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
      0.00            +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.sk_forced_mem_schedule
      0.18 ±  2%      +0.1        0.29 ±  2%  perf-profile.children.cycles-pp.sock_close
      0.44 ±  4%      +0.1        0.55 ±  2%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.14 ±  6%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.__slab_free
      0.29 ±  3%      +0.1        0.41        perf-profile.children.cycles-pp.tcp_rcv_synsent_state_process
      0.00            +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.17 ±  2%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.31 ±  2%      +0.1        0.44        perf-profile.children.cycles-pp.tcp_v4_connect
      0.19 ±  3%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.rcu_do_batch
      1.02            +0.1        1.16        perf-profile.children.cycles-pp.tcp_ioctl
      1.22            +0.1        1.36        perf-profile.children.cycles-pp.sock_do_ioctl
      0.21 ±  3%      +0.1        0.35 ±  6%  perf-profile.children.cycles-pp.rcu_core
      0.43            +0.1        0.57        perf-profile.children.cycles-pp.__lock_sock_fast
      0.42 ±  5%      +0.1        0.56 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.81 ±  9%      +0.2        0.97        perf-profile.children.cycles-pp.get_page_from_freelist
      0.26 ±  4%      +0.2        0.43 ± 11%  perf-profile.children.cycles-pp.tick_sched_timer
      1.50            +0.2        1.67        perf-profile.children.cycles-pp.do_vfs_ioctl
      0.34 ±  6%      +0.2        0.50        perf-profile.children.cycles-pp.dst_release
      0.16 ±  4%      +0.2        0.32 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      1.14 ±  8%      +0.2        1.31 ±  2%  perf-profile.children.cycles-pp.free_unref_page
      0.45 ±  3%      +0.2        0.62 ±  8%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ±  4%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.update_process_times
      0.11 ±  4%      +0.2        0.28 ± 10%  perf-profile.children.cycles-pp.task_tick_fair
      0.45 ±  2%      +0.2        0.62 ±  8%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.22 ±  3%      +0.2        0.40 ± 10%  perf-profile.children.cycles-pp.tick_sched_handle
      0.39            +0.2        0.57        perf-profile.children.cycles-pp.__fput
      0.31 ±  4%      +0.2        0.49 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.86 ±  9%      +0.2        1.04        perf-profile.children.cycles-pp.__alloc_pages
      0.41            +0.2        0.59        perf-profile.children.cycles-pp.task_work_run
      1.41            +0.2        1.60        perf-profile.children.cycles-pp.__check_object_size
     92.88            +0.2       93.08        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.48            +0.2        0.69        perf-profile.children.cycles-pp.__close
      0.25 ±  6%      +0.2        0.47 ±  2%  perf-profile.children.cycles-pp.ipv4_mtu
      2.36            +0.3        2.62        perf-profile.children.cycles-pp.__x64_sys_ioctl
      0.62 ±  2%      +0.3        0.88        perf-profile.children.cycles-pp.__inet_stream_connect
      2.52 ±  3%      +0.3        2.78        perf-profile.children.cycles-pp.skb_release_data
      0.62 ±  2%      +0.3        0.88        perf-profile.children.cycles-pp.inet_stream_connect
      1.69            +0.3        1.96        perf-profile.children.cycles-pp.sock_ioctl
      0.64 ±  2%      +0.3        0.90        perf-profile.children.cycles-pp.__x64_sys_connect
      0.64 ±  2%      +0.3        0.91        perf-profile.children.cycles-pp.__connect
      0.64 ±  2%      +0.3        0.90        perf-profile.children.cycles-pp.__sys_connect
      0.60 ±  4%      +0.3        0.87 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.60 ±  4%      +0.3        0.87 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.59 ±  4%      +0.3        0.86 ±  4%  perf-profile.children.cycles-pp.do_idle
      0.56 ±  2%      +0.3        0.84        perf-profile.children.cycles-pp.tcp_current_mss
      2.94 ±  2%      +0.3        3.22        perf-profile.children.cycles-pp.__kfree_skb
      1.48 ±  7%      +0.3        1.76 ±  2%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.66 ±  2%      +0.3        0.95        perf-profile.children.cycles-pp.tcp_send_mss
      3.74            +0.3        4.02        perf-profile.children.cycles-pp.ioctl
      0.70 ±  8%      +0.3        0.98 ±  2%  perf-profile.children.cycles-pp.update_cfs_group
      0.69 ±  2%      +0.3        0.99 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.64 ±  2%      +0.3        0.93 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     92.11            +0.3       92.41        perf-profile.children.cycles-pp.do_syscall_64
      1.21 ±  8%      +0.3        1.52        perf-profile.children.cycles-pp.skb_page_frag_refill
      1.25 ±  8%      +0.3        1.58        perf-profile.children.cycles-pp.sk_page_frag_refill
      1.36 ±  9%      +0.3        1.70        perf-profile.children.cycles-pp.tcp_rcv_state_process
      1.06            +0.5        1.56        perf-profile.children.cycles-pp.lock_sock_nested
      0.16 ±  9%      +0.5        0.67 ±  7%  perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.53 ±  5%      +0.7        1.23 ±  5%  perf-profile.children.cycles-pp.tcp_data_queue
      1.46            +0.9        2.41 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      4.63 ±  6%      +1.4        5.99        perf-profile.children.cycles-pp.copyout
      3.64 ±  4%      +1.4        5.04        perf-profile.children.cycles-pp.copyin
      5.04 ±  6%      +1.4        6.45        perf-profile.children.cycles-pp._copy_to_iter
      4.27 ±  4%      +1.6        5.84        perf-profile.children.cycles-pp._copy_from_iter
      6.46 ±  4%      +1.6        8.08        perf-profile.children.cycles-pp.__skb_datagram_iter
      6.52 ±  4%      +1.6        8.14        perf-profile.children.cycles-pp.skb_copy_datagram_iter
      4.99 ±  4%      +1.7        6.68        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
     36.84            +2.0       38.87        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     51.57            +2.1       53.65        perf-profile.children.cycles-pp.send
      8.21 ±  5%      +2.8       10.97        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      3.87 ±  2%      +3.0        6.87 ±  2%  perf-profile.children.cycles-pp.__release_sock
      4.68            +3.2        7.90 ±  2%  perf-profile.children.cycles-pp.release_sock
      1.21 ±  9%      +4.1        5.29 ±  8%  perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      1.24 ±  9%      +4.1        5.33 ±  8%  perf-profile.children.cycles-pp.__sk_mem_schedule
     43.55            +4.2       47.78        perf-profile.children.cycles-pp.__x64_sys_sendto
     43.26            +4.3       47.57        perf-profile.children.cycles-pp.__sys_sendto
     41.95            +4.4       46.37        perf-profile.children.cycles-pp.sock_sendmsg
     40.58            +4.4       45.01        perf-profile.children.cycles-pp.tcp_sendmsg
      2.29 ±  2%      -0.6        1.65        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.87 ±  4%      -0.5        0.38 ±  3%  perf-profile.self.cycles-pp.prepare_task_switch
      1.09 ±  4%      -0.4        0.64 ±  2%  perf-profile.self.cycles-pp.available_idle_cpu
      1.24 ±  3%      -0.4        0.86        perf-profile.self.cycles-pp.__schedule
      0.61 ±  3%      -0.3        0.26        perf-profile.self.cycles-pp.dequeue_task_fair
      1.74            -0.3        1.45        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.49 ±  3%      -0.2        0.24 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      0.82 ±  3%      -0.2        0.57 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.51 ±  3%      -0.2        0.27 ±  3%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.80 ±  2%      -0.2        0.57 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.83 ±  2%      -0.2        0.60 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.82 ±  2%      -0.2        0.60 ±  2%  perf-profile.self.cycles-pp.__ip_queue_xmit
      0.67 ±  4%      -0.2        0.45 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.79 ±  3%      -0.2        0.57 ±  3%  perf-profile.self.cycles-pp.ip_finish_output2
      0.64            -0.2        0.43 ±  2%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.73 ±  3%      -0.2        0.52 ±  2%  perf-profile.self.cycles-pp.update_curr
      0.60 ±  3%      -0.2        0.38 ±  3%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.62 ±  2%      -0.2        0.41 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      1.16 ±  2%      -0.2        0.97        perf-profile.self.cycles-pp._raw_spin_lock
      0.63 ±  4%      -0.2        0.44 ±  2%  perf-profile.self.cycles-pp.select_idle_cpu
      0.70 ±  2%      -0.2        0.52 ±  3%  perf-profile.self.cycles-pp.native_sched_clock
      0.59            -0.2        0.42 ±  2%  perf-profile.self.cycles-pp.loopback_xmit
      0.56 ±  2%      -0.2        0.40 ±  2%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.66            -0.2        0.50 ±  2%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.45 ±  3%      -0.1        0.31 ±  3%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.33 ±  3%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.select_idle_sibling
      0.50 ±  3%      -0.1        0.38        perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.32 ±  3%      -0.1        0.20 ±  5%  perf-profile.self.cycles-pp._find_next_bit
      0.37 ±  3%      -0.1        0.25        perf-profile.self.cycles-pp.update_rq_clock
      0.34 ±  4%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.sk_wait_data
      0.64 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.__alloc_skb
      0.41 ±  2%      -0.1        0.30 ±  2%  perf-profile.self.cycles-pp.net_rx_action
      0.86            -0.1        0.75        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.44            -0.1        0.33 ±  3%  perf-profile.self.cycles-pp.ip_rcv_core
      0.30 ±  3%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.schedule
      0.29 ±  2%      -0.1        0.19 ±  2%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.53            -0.1        0.43        perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.61            -0.1        0.51        perf-profile.self.cycles-pp.tcp_ack
      0.64            -0.1        0.54 ±  2%  perf-profile.self.cycles-pp.do_syscall_64
      1.06            -0.1        0.97        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.32 ±  3%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.enqueue_entity
      0.53 ±  2%      -0.1        0.43        perf-profile.self.cycles-pp.kmem_cache_free
      0.40            -0.1        0.31 ±  2%  perf-profile.self.cycles-pp.process_backlog
      0.80            -0.1        0.70 ±  2%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.46 ±  2%      -0.1        0.37 ±  3%  perf-profile.self.cycles-pp.kfree
      0.32            -0.1        0.24 ±  3%  perf-profile.self.cycles-pp.do_softirq
      0.20 ±  4%      -0.1        0.13 ±  3%  perf-profile.self.cycles-pp.check_preempt_wakeup
      1.04            -0.1        0.96        perf-profile.self.cycles-pp.read_tsc
      0.28 ±  3%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.19 ±  3%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.perf_trace_buf_alloc
      0.19            -0.1        0.12 ±  7%  perf-profile.self.cycles-pp.__calc_delta
      0.56            -0.1        0.48        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.24 ±  2%      -0.1        0.16 ±  2%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.25 ±  2%      -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.30 ±  2%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.20 ±  7%      -0.1        0.14 ±  4%  perf-profile.self.cycles-pp.update_min_vruntime
      0.19 ±  3%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.27 ±  2%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.38            -0.1        0.32        perf-profile.self.cycles-pp.tcp_rcv_space_adjust
      0.80            -0.1        0.74        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.27 ±  2%      -0.1        0.21 ±  3%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.17 ±  4%      -0.1        0.11 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.26 ±  2%      -0.1        0.20 ±  3%  perf-profile.self.cycles-pp.ip_output
      0.62 ±  2%      -0.1        0.56        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.25 ±  3%      -0.1        0.19 ±  3%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.19 ±  2%      -0.1        0.13 ±  2%  perf-profile.self.cycles-pp.netif_skb_features
      0.16 ±  4%      -0.1        0.10        perf-profile.self.cycles-pp.apparmor_ip_postroute
      0.38            -0.1        0.33        perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.20 ±  3%      -0.1        0.14        perf-profile.self.cycles-pp.dequeue_entity
      0.18 ±  4%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.pick_next_entity
      0.17 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.__fdget
      0.26 ±  2%      -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.19 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.finish_task_switch
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.cpumask_next_wrap
      0.71 ±  3%      -0.0        0.66        perf-profile.self.cycles-pp.update_load_avg
      0.19 ±  4%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_finish_output
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.ip_rcv
      0.12 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.skb_network_protocol
      0.14 ±  3%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.put_prev_entity
      0.17 ±  2%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.schedule_timeout
      0.16 ±  4%      -0.0        0.12 ±  5%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.31            -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.__list_add_valid
      0.18 ±  2%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.set_next_entity
      0.16 ±  4%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.37 ±  3%      -0.0        0.33        perf-profile.self.cycles-pp.wait_woken
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.xmit_one
      0.30            -0.0        0.26 ±  3%  perf-profile.self.cycles-pp.import_single_range
      0.15 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.21 ±  3%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.13            -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.14 ±  6%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.19 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.inet_ehashfn
      0.13 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.update_irq_load_avg
      0.14 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.__x64_sys_recvfrom
      0.28 ±  3%      -0.0        0.25        perf-profile.self.cycles-pp.switch_fpu_return
      0.14 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.ip_local_deliver_finish
      0.11 ±  3%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.ip_local_deliver
      0.10 ±  3%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.kmalloc_slab
      0.09 ± 10%      -0.0        0.06        perf-profile.self.cycles-pp.switch_ldt
      0.08 ±  6%      -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.perf_swevent_get_recursion_context
      0.19 ±  3%      -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.inet_recvmsg
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.18 ±  2%      -0.0        0.15 ±  2%  perf-profile.self.cycles-pp.__tcp_select_window
      0.31            -0.0        0.28        perf-profile.self.cycles-pp.tcp_recvmsg
      0.13 ±  2%      -0.0        0.10        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.nf_hook_slow
      0.13 ±  5%      -0.0        0.10 ±  6%  perf-profile.self.cycles-pp.perf_tp_event
      0.13 ±  2%      -0.0        0.10        perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.11 ±  4%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.skb_release_head_state
      0.13 ±  2%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__ip_local_out
      0.12 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__ip_finish_output
      0.32            -0.0        0.29        perf-profile.self.cycles-pp.__sys_recvfrom
      0.31 ±  3%      -0.0        0.28 ±  2%  perf-profile.self.cycles-pp.__ksize
      0.13 ±  5%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.set_next_buddy
      0.13 ±  2%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.neigh_hh_output
      0.27            -0.0        0.24 ±  3%  perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.10 ±  3%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.10 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_options_write
      0.10 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.11            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__sk_dst_check
      0.10 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.kmalloc_reserve
      0.09 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.qdisc_pkt_len_init
      0.08 ±  4%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.__wake_up_common_lock
      0.41            -0.0        0.38 ±  2%  perf-profile.self.cycles-pp.__sys_sendto
      0.22 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.08            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.10 ±  4%      -0.0        0.08        perf-profile.self.cycles-pp.tcp_inbound_md5_hash
      0.13 ±  3%      -0.0        0.11 ±  5%  perf-profile.self.cycles-pp.sched_clock_cpu
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.self.cycles-pp.eth_type_trans
      0.23            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__mod_timer
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.tcp_v4_send_check
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.tcp_rate_gen
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_skb_entail
      0.08 ±  5%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.skb_clone_tx_timestamp
      0.10            -0.0        0.08        perf-profile.self.cycles-pp.tcp_rate_skb_sent
      0.10 ±  3%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.select_task_rq
      0.09 ±  5%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.netif_rx_internal
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.__build_skb_around
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.cpumask_next
      0.12 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_sendmsg
      0.08 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.__kfree_skb
      0.19 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.10 ±  3%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.10 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.tcp_update_skb_after_send
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.ip_local_out
      0.07 ±  5%      -0.0        0.05        perf-profile.self.cycles-pp.clear_buddies
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.__napi_poll
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.tracing_gen_ctx_irq_test
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.10 ±  5%      -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_rearm_rto
      0.15 ±  5%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.resched_curr
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rb_erase
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_rate_skb_delivered
      0.07 ±  6%      -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.check_preempt_curr
      0.10 ±  5%      -0.0        0.08        perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.13 ±  3%      -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_v4_do_rcv
      0.11 ±  3%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.tcp_mstamp_refresh
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__usecs_to_jiffies
      0.14 ±  3%      -0.0        0.13        perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.12 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.19 ±  2%      -0.0        0.18        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.10 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.__wake_up_common
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.ttwu_do_activate
      0.08 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.tcp_stream_alloc_skb
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.skb_push
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.cubictcp_acked
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.copyin
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.inet_sendmsg
      0.10 ±  4%      +0.0        0.11        perf-profile.self.cycles-pp.tcp_check_space
      0.13 ±  3%      +0.0        0.15 ±  2%  perf-profile.self.cycles-pp.sockfd_lookup_light
      0.05 ±  8%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_rate_check_app_limited
      0.13 ±  3%      +0.0        0.15 ±  3%  perf-profile.self.cycles-pp.tcp_send_mss
      0.40            +0.0        0.42 ±  2%  perf-profile.self.cycles-pp.recv
      0.15 ±  2%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.do_vfs_ioctl
      0.05            +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.tcp_small_queue_check
      0.06 ± 11%      +0.0        0.09 ±  4%  perf-profile.self.cycles-pp.free_unref_page_commit
      0.08 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.tcp_mtu_probe
      0.10            +0.0        0.13 ±  2%  perf-profile.self.cycles-pp.__sock_wfree
      0.05            +0.0        0.08        perf-profile.self.cycles-pp.tcp_add_backlog
      0.05 ±  7%      +0.0        0.08 ±  4%  perf-profile.self.cycles-pp.check_new_pages
      0.32            +0.0        0.35        perf-profile.self.cycles-pp.__entry_text_start
      0.27 ±  2%      +0.0        0.31        perf-profile.self.cycles-pp._copy_to_iter
      0.08 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.sk_free
      0.12            +0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_cleanup_rbuf
      0.18 ±  2%      +0.0        0.22 ±  2%  perf-profile.self.cycles-pp.tcp_current_mss
      0.17 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.skb_do_copy_data_nocache
      0.25            +0.0        0.29 ±  2%  perf-profile.self.cycles-pp.__skb_clone
      0.06 ±  6%      +0.0        0.10        perf-profile.self.cycles-pp.__zone_watermark_ok
      0.18 ±  2%      +0.0        0.22        perf-profile.self.cycles-pp.kfree_skbmem
      0.08 ±  9%      +0.0        0.12        perf-profile.self.cycles-pp.rmqueue
      0.07            +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.08 ±  5%      +0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__free_one_page
      0.01 ±223%      +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.__alloc_pages
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tcp_ack_update_window
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.rb_first
      0.26 ±  6%      +0.1        0.32        perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.14 ±  7%      +0.1        0.20        perf-profile.self.cycles-pp.tcp_tx_timestamp
      0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.83            +0.1        0.89        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.19 ±  3%      +0.1        0.25        perf-profile.self.cycles-pp.tcp_tso_segs
      0.08 ±  4%      +0.1        0.15 ±  2%  perf-profile.self.cycles-pp.__release_sock
      0.10 ±  9%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.skb_try_coalesce
      0.00            +0.1        0.07 ± 10%  perf-profile.self.cycles-pp.page_counter_uncharge
      0.21 ±  3%      +0.1        0.29 ±  3%  perf-profile.self.cycles-pp.sock_put
      0.01 ±223%      +0.1        0.09 ± 41%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      1.36            +0.1        1.44        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.40            +0.1        0.48        perf-profile.self.cycles-pp.__skb_datagram_iter
      0.09 ±  5%      +0.1        0.18 ±  2%  perf-profile.self.cycles-pp.free_pcp_prepare
      0.32 ±  5%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      0.00            +0.1        0.10 ±  7%  perf-profile.self.cycles-pp.sk_forced_mem_schedule
      0.22 ±  4%      +0.1        0.32        perf-profile.self.cycles-pp.tcp_push
      0.31 ±  7%      +0.1        0.42 ±  2%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.14 ±  4%      +0.1        0.26 ±  2%  perf-profile.self.cycles-pp.__slab_free
      0.41 ±  4%      +0.1        0.53        perf-profile.self.cycles-pp.ipv4_dst_check
      0.00            +0.1        0.12 ±  9%  perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.41 ±  3%      +0.1        0.54 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      0.59            +0.1        0.72        perf-profile.self.cycles-pp.skb_release_data
      0.33 ±  6%      +0.2        0.49 ±  2%  perf-profile.self.cycles-pp.dst_release
      0.80            +0.2        0.98        perf-profile.self.cycles-pp.__check_object_size
      0.23 ±  5%      +0.2        0.46 ±  2%  perf-profile.self.cycles-pp.ipv4_mtu
      1.48 ±  7%      +0.3        1.76 ±  2%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.67 ±  7%      +0.3        0.97 ±  2%  perf-profile.self.cycles-pp.update_cfs_group
      1.78 ±  5%      +0.5        2.32        perf-profile.self.cycles-pp.tcp_write_xmit
      1.12            +0.6        1.73 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      2.30 ±  4%      +0.7        2.99        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      8.12 ±  5%      +2.7       10.82        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.19 ±  9%      +4.0        5.22 ±  8%  perf-profile.self.cycles-pp.__sk_mem_raise_allocated


***************************************************************************************************
lkp-csl-2ap4: 192 threads 4 sockets Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase/ucode:
  cs-localhost/gcc-11/performance/ipv4/x86_64-rhel-8.3/200%/debian-10.4-x86_64-20200603.cgz/900s/lkp-csl-2ap4/TCP_STREAM/netperf/0x500320a

commit: 
  089c02ae27 ("ftrace: Use preemption model accessors for trace header printout")
  6b433275e3 ("sched/fair: filter out overloaded cpus in SIS")

089c02ae2771a14a 6b433275e3a3cf18a16c0d2afb7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      4701 ± 11%     -44.4%       2612 ± 33%  netperf.Throughput_Mbps
   1805303 ± 11%     -44.4%    1003138 ± 33%  netperf.Throughput_total_Mbps
 7.318e+09 ± 16%     -60.3%  2.904e+09 ± 65%  netperf.time.involuntary_context_switches
      9183 ±  2%      -8.5%       8398 ±  4%  netperf.time.percent_of_cpu_this_job_got
     76163 ±  2%     -10.1%      68461 ±  5%  netperf.time.system_time
      7722 ±  2%      +7.8%       8324 ±  3%  netperf.time.user_time
  1.24e+10 ± 11%     -44.4%  6.888e+09 ± 33%  netperf.workload
      2.03 ±  9%      +0.9        2.97 ± 14%  mpstat.cpu.all.irq%
     16.05 ±  9%      -5.1       10.95 ± 18%  mpstat.cpu.all.soft%
  16081667 ± 16%     -59.9%    6441541 ± 64%  vmstat.system.cs
    412129           -10.6%     368582 ± 14%  vmstat.system.in
      2953            +4.1%       3073        turbostat.Bzy_MHz
      1.08 ± 12%     -24.2%       0.82 ± 17%  turbostat.CPU%c1
      0.10 ± 16%     -57.1%       0.04 ± 50%  turbostat.IPC
    144406 ± 39%     -42.2%      83397 ± 41%  numa-meminfo.node1.AnonPages
    280909 ± 80%     -66.5%      94203 ± 50%  numa-meminfo.node1.Inactive
    280909 ± 80%     -66.5%      94203 ± 50%  numa-meminfo.node1.Inactive(anon)
      7513 ±  5%     +33.8%      10054 ± 28%  numa-meminfo.node2.KernelStack
 1.329e+09 ±  3%     -57.8%  5.603e+08 ±  8%  numa-numastat.node0.local_node
 1.329e+09 ±  3%     -57.8%  5.603e+08 ±  8%  numa-numastat.node0.numa_hit
 1.003e+09 ± 26%     -37.4%  6.283e+08 ± 24%  numa-numastat.node1.local_node
 1.003e+09 ± 26%     -37.3%  6.283e+08 ± 24%  numa-numastat.node1.numa_hit
    105957            +2.7%     108777        proc-vmstat.nr_slab_unreclaimable
 4.376e+09 ±  9%     -37.8%  2.723e+09 ± 25%  proc-vmstat.numa_hit
 4.376e+09 ±  9%     -37.8%  2.722e+09 ± 25%  proc-vmstat.numa_local
 4.374e+09 ±  9%     -37.8%  2.722e+09 ± 25%  proc-vmstat.pgalloc_normal
 4.374e+09 ±  9%     -37.8%  2.721e+09 ± 25%  proc-vmstat.pgfree
    245123            -2.8%     238345 ±  2%  proc-vmstat.pgreuse
 1.329e+09 ±  3%     -57.8%  5.603e+08 ±  8%  numa-vmstat.node0.numa_hit
 1.329e+09 ±  3%     -57.8%  5.603e+08 ±  8%  numa-vmstat.node0.numa_local
     36082 ± 39%     -42.2%      20856 ± 41%  numa-vmstat.node1.nr_anon_pages
     70727 ± 82%     -66.7%      23573 ± 50%  numa-vmstat.node1.nr_inactive_anon
     70727 ± 82%     -66.7%      23573 ± 50%  numa-vmstat.node1.nr_zone_inactive_anon
 1.003e+09 ± 26%     -37.3%  6.283e+08 ± 24%  numa-vmstat.node1.numa_hit
 1.003e+09 ± 26%     -37.4%  6.283e+08 ± 24%  numa-vmstat.node1.numa_local
      7514 ±  5%     +33.7%      10050 ± 28%  numa-vmstat.node2.nr_kernel_stack
   9484366 ± 81%    +111.4%   20049256 ± 27%  sched_debug.cfs_rq:/.MIN_vruntime.max
    102.85 ± 20%     +45.9%     150.08 ± 15%  sched_debug.cfs_rq:/.load_avg.max
   9484366 ± 81%    +111.4%   20049256 ± 27%  sched_debug.cfs_rq:/.max_vruntime.max
 -37498528           +21.4%  -45520159        sched_debug.cfs_rq:/.spread0.avg
    102.01 ±  4%     -12.8%      88.92 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
    190.37 ± 12%     -38.2%     117.62 ± 18%  sched_debug.cfs_rq:/.util_est_enqueued.min
      6324 ± 38%    +156.7%      16237 ± 41%  sched_debug.cpu.avg_idle.min
    286287 ±  7%     -11.3%     253842 ±  6%  sched_debug.cpu.avg_idle.stddev
    204.01 ± 31%    +102.8%     413.65 ± 21%  sched_debug.cpu.clock.stddev
     10208 ± 37%     -41.3%       5989 ± 55%  sched_debug.cpu.clock_task.stddev
      0.00 ± 30%    +101.7%       0.00 ± 21%  sched_debug.cpu.next_balance.stddev
  32000235 ± 18%     -57.5%   13593568 ± 56%  sched_debug.cpu.nr_switches.avg
      0.00 ±135%  +9.5e+05%       0.09 ±105%  sched_debug.rt_rq:/.rt_time.avg
      0.00 ±135%  +9.5e+05%      16.48 ±105%  sched_debug.rt_rq:/.rt_time.max
      0.00 ±135%  +9.5e+05%       1.19 ±105%  sched_debug.rt_rq:/.rt_time.stddev
     13.35 ±  7%    +107.1%      27.65 ± 27%  perf-stat.i.MPKI
 4.085e+10 ± 15%     -55.4%  1.822e+10 ± 50%  perf-stat.i.branch-instructions
 5.149e+08 ± 16%     -55.9%  2.273e+08 ± 53%  perf-stat.i.branch-misses
  16690647 ± 17%     -60.8%    6537000 ± 65%  perf-stat.i.context-switches
      3.08 ± 13%    +146.2%       7.59 ± 32%  perf-stat.i.cpi
 5.517e+11            +3.6%  5.716e+11        perf-stat.i.cpu-cycles
    757.31 ± 12%     -22.9%     583.92 ± 10%  perf-stat.i.cpu-migrations
      1123 ± 44%     -52.8%     530.23 ± 29%  perf-stat.i.cycles-between-cache-misses
  26399845 ± 34%     -59.3%   10744768 ± 54%  perf-stat.i.dTLB-load-misses
 6.126e+10 ± 15%     -55.2%  2.745e+10 ± 50%  perf-stat.i.dTLB-loads
   5174658 ± 66%     -68.0%    1657325 ± 61%  perf-stat.i.dTLB-store-misses
 3.495e+10 ± 15%     -55.5%  1.555e+10 ± 50%  perf-stat.i.dTLB-stores
     61.10            +6.1       67.20 ±  4%  perf-stat.i.iTLB-load-miss-rate%
 2.707e+08 ± 16%     -55.0%  1.219e+08 ± 50%  perf-stat.i.iTLB-load-misses
 1.771e+08 ± 18%     -63.5%   64622781 ± 67%  perf-stat.i.iTLB-loads
 2.069e+11 ± 15%     -55.3%  9.243e+10 ± 50%  perf-stat.i.instructions
      0.38 ± 16%     -56.3%       0.17 ± 50%  perf-stat.i.ipc
      2.87            +3.6%       2.98        perf-stat.i.metric.GHz
    728.27 ± 15%     -54.2%     333.34 ± 48%  perf-stat.i.metric.M/sec
     34.65 ± 69%     -26.6        8.02 ± 79%  perf-stat.i.node-load-miss-rate%
  38032587 ± 23%     -48.0%   19778776 ± 40%  perf-stat.i.node-load-misses
     26.05 ±108%     -23.1        2.97 ± 62%  perf-stat.i.node-store-miss-rate%
  10666695 ± 19%     -48.0%    5547155 ± 32%  perf-stat.i.node-store-misses
     12.37 ±  7%    +119.3%      27.12 ± 28%  perf-stat.overall.MPKI
      2.82 ± 15%    +164.4%       7.46 ± 33%  perf-stat.overall.cpi
    814.23 ± 25%     -40.9%     481.05 ± 24%  perf-stat.overall.cycles-between-cache-misses
     60.62            +6.3       66.95 ±  4%  perf-stat.overall.iTLB-load-miss-rate%
      0.36 ± 15%     -55.8%       0.16 ± 50%  perf-stat.overall.ipc
     20.73 ± 47%     -14.2        6.51 ± 72%  perf-stat.overall.node-load-miss-rate%
      7.26 ± 58%      -5.4        1.83 ± 75%  perf-stat.overall.node-store-miss-rate%
     14719 ±  2%     -20.9%      11643 ± 12%  perf-stat.overall.path-length
 3.953e+10 ± 14%     -54.5%    1.8e+10 ± 49%  perf-stat.ps.branch-instructions
  4.98e+08 ± 15%     -54.9%  2.244e+08 ± 52%  perf-stat.ps.branch-misses
  16095450 ± 16%     -60.0%    6440979 ± 64%  perf-stat.ps.context-switches
 5.527e+11            +3.6%  5.725e+11        perf-stat.ps.cpu-cycles
    770.48 ± 12%     -24.9%     578.71 ± 11%  perf-stat.ps.cpu-migrations
  25360360 ± 32%     -58.0%   10639294 ± 53%  perf-stat.ps.dTLB-load-misses
  5.93e+10 ± 14%     -54.2%  2.713e+10 ± 49%  perf-stat.ps.dTLB-loads
   4898387 ± 64%     -66.5%    1640892 ± 60%  perf-stat.ps.dTLB-store-misses
 3.382e+10 ± 14%     -54.6%  1.537e+10 ± 49%  perf-stat.ps.dTLB-stores
  2.62e+08 ± 15%     -54.1%  1.204e+08 ± 49%  perf-stat.ps.iTLB-load-misses
 1.707e+08 ± 17%     -62.7%   63724182 ± 66%  perf-stat.ps.iTLB-loads
 2.003e+11 ± 14%     -54.4%  9.135e+10 ± 49%  perf-stat.ps.instructions
  36791027 ± 22%     -47.1%   19465718 ± 39%  perf-stat.ps.node-load-misses
  10396698 ± 18%     -47.7%    5442218 ± 33%  perf-stat.ps.node-store-misses
 1.831e+14 ± 14%     -54.3%   8.36e+13 ± 49%  perf-stat.total.instructions
     12.76 ± 18%      -8.3        4.43 ± 53%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
     11.20 ± 18%      -6.9        4.33 ± 46%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
     18.04 ± 11%      -6.7       11.31 ± 16%  perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
     17.79 ± 11%      -6.6       11.20 ± 16%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit
     52.16 ±  3%      -6.5       45.70 ±  4%  perf-profile.calltrace.cycles-pp.send_tcp_stream.main.__libc_start_main
     52.12 ±  3%      -6.4       45.68 ±  4%  perf-profile.calltrace.cycles-pp.send_omni_inner.send_tcp_stream.main.__libc_start_main
     51.94 ±  3%      -6.1       45.85 ±  4%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.send.send_omni_inner.send_tcp_stream
     51.29 ±  3%      -6.1       45.20 ±  4%  perf-profile.calltrace.cycles-pp.send.send_omni_inner.send_tcp_stream.main.__libc_start_main
     50.98 ±  3%      -6.1       44.91 ±  4%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.send.send_omni_inner.send_tcp_stream.main
     16.90 ± 11%      -6.1       10.84 ± 15%  perf-profile.calltrace.cycles-pp.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip.ip_finish_output2
     10.15 ± 17%      -6.0        4.10 ± 46%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     10.26 ± 16%      -6.0        4.24 ± 44%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     46.61 ±  4%      -5.9       40.70 ±  4%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.send.send_omni_inner
      9.62 ± 18%      -5.9        3.73 ± 52%  perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
     46.49 ±  4%      -5.8       40.65 ±  4%  perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
     16.50 ± 11%      -5.8       10.69 ± 15%  perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq.__local_bh_enable_ip
      9.36 ± 18%      -5.8        3.58 ± 53%  perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg.__sys_sendto
     16.42 ± 11%      -5.8       10.66 ± 15%  perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start.do_softirq
      8.82 ± 18%      -5.6        3.18 ± 55%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
     45.72 ±  4%      -5.6       40.10 ±  4%  perf-profile.calltrace.cycles-pp.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     15.93 ± 11%      -5.5       10.44 ± 14%  perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.__softirqentry_text_start
     44.98 ±  4%      -5.3       39.65 ±  4%  perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
      7.28 ± 17%      -5.3        1.97 ± 75%  perf-profile.calltrace.cycles-pp.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      7.14 ± 17%      -5.2        1.92 ± 74%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      6.92 ± 17%      -5.2        1.76 ± 78%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established.tcp_v4_do_rcv
      8.06 ± 18%      -5.1        2.92 ± 55%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      6.67 ± 17%      -5.1        1.60 ± 84%  perf-profile.calltrace.cycles-pp.try_to_wake_up.__wake_up_common.__wake_up_common_lock.sock_def_readable.tcp_rcv_established
      7.40 ± 18%      -5.0        2.35 ± 61%  perf-profile.calltrace.cycles-pp.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      6.42 ± 18%      -4.5        1.96 ± 66%  perf-profile.calltrace.cycles-pp.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     13.96 ±  9%      -4.4        9.56 ± 11%  perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     13.58 ±  9%      -4.3        9.30 ± 11%  perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
      6.13 ± 18%      -4.3        1.86 ± 66%  perf-profile.calltrace.cycles-pp.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked.tcp_recvmsg
     10.48 ± 11%      -4.2        6.24 ± 19%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      6.02 ± 18%      -4.2        1.82 ± 66%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
     13.34 ±  9%      -4.2        9.18 ± 11%  perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
      5.89 ± 18%      -4.1        1.78 ± 66%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.wait_woken.sk_wait_data
     10.14 ± 10%      -4.0        6.13 ± 18%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      6.29 ± 18%      -3.8        2.52 ± 54%  perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.sock_sendmsg
      5.95 ± 18%      -3.6        2.36 ± 53%  perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      5.26 ± 19%      -3.3        1.94 ± 53%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      5.16 ± 18%      -3.2        1.95 ± 52%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      5.13 ± 18%      -3.2        1.94 ± 52%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      4.74 ± 19%      -3.0        1.75 ± 53%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      4.36 ± 19%      -2.8        1.60 ± 53%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg
      3.99 ± 19%      -2.5        1.44 ± 52%  perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.tcp_sendmsg_locked
      4.18 ± 18%      -2.2        2.00 ± 29%  perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established
      2.28 ± 24%      -1.7        0.54 ±116%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.schedule_timeout.wait_woken
      4.84 ± 11%      -1.7        3.18 ± 17%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv
      2.30 ± 16%      -1.4        0.88 ± 53%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
      1.77 ± 16%      -1.3        0.48 ±112%  perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock
      1.86 ± 17%      -1.3        0.58 ± 88%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.send
      1.68 ± 44%      -1.3        0.41 ± 76%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      8.40 ±  9%      -1.2        7.16 ±  8%  perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
      1.58 ± 17%      -1.2        0.42 ±111%  perf-profile.calltrace.cycles-pp.recv
      1.56 ± 17%      -1.1        0.44 ±111%  perf-profile.calltrace.cycles-pp.send
      1.24 ± 21%      -0.7        0.52 ± 83%  perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      2.26 ±  5%      -0.5        1.78 ±  8%  perf-profile.calltrace.cycles-pp.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      2.11 ±  4%      -0.4        1.70 ±  7%  perf-profile.calltrace.cycles-pp.__alloc_skb.tcp_stream_alloc_skb.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      6.95 ±  2%      +0.3        7.27        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked.tcp_recvmsg
      0.55 ± 45%      +0.4        0.92 ± 24%  perf-profile.calltrace.cycles-pp.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
      0.48 ± 46%      +0.4        0.87 ± 26%  perf-profile.calltrace.cycles-pp.__check_object_size.simple_copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
      0.74 ±  9%      +0.5        1.22 ± 13%  perf-profile.calltrace.cycles-pp.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
      0.72 ± 10%      +0.5        1.21 ± 14%  perf-profile.calltrace.cycles-pp.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
      0.09 ±223%      +0.7        0.81 ± 24%  perf-profile.calltrace.cycles-pp.release_sock.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      0.18 ±141%      +0.7        0.92 ± 18%  perf-profile.calltrace.cycles-pp.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +0.8        0.81 ± 21%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_pages.skb_page_frag_refill.sk_page_frag_refill.tcp_sendmsg_locked
     34.53            +1.1       35.64        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto.__x64_sys_sendto
      0.19 ±142%      +1.2        1.41 ± 35%  perf-profile.calltrace.cycles-pp.skb_release_data.__kfree_skb.__sk_defer_free_flush.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.19 ±142%      +1.2        1.41 ± 35%  perf-profile.calltrace.cycles-pp.__kfree_skb.__sk_defer_free_flush.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.20 ±142%      +1.3        1.49 ± 35%  perf-profile.calltrace.cycles-pp.__sk_defer_free_flush.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      5.46 ±  3%      +1.5        6.93 ±  6%  perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_recvmsg_locked
      0.52 ± 81%      +1.5        2.00 ± 25%  perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv
      0.52 ± 81%      +1.5        2.00 ± 25%  perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_rcv_established.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.34 ±152%      +1.8        2.12 ± 27%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter
     41.80 ±  6%      +8.9       50.66 ±  5%  perf-profile.calltrace.cycles-pp.recv.recv_omni.process_requests.spawn_child.accept_connection
     41.35 ±  6%      +9.1       50.45 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests.spawn_child
     37.18 ±  7%      +9.2       46.39 ±  6%  perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
     41.12 ±  7%      +9.2       50.36 ±  6%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.recv_omni.process_requests
     39.12 ±  7%      +9.3       48.38 ±  6%  perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
     38.29 ±  7%      +9.6       47.85 ±  6%  perf-profile.calltrace.cycles-pp.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
     38.13 ±  7%      +9.7       47.78 ±  7%  perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
     38.50 ±  7%      +9.8       48.32 ±  6%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.recv_omni
     10.96 ± 28%     +10.0       21.01 ± 16%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked
     12.20 ± 25%     +10.1       22.33 ± 16%  perf-profile.calltrace.cycles-pp.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.__sys_sendto
     11.21 ± 28%     +10.2       21.40 ± 16%  perf-profile.calltrace.cycles-pp.copyin._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg
     11.68 ± 27%     +10.3       22.02 ± 16%  perf-profile.calltrace.cycles-pp._copy_from_iter.skb_do_copy_data_nocache.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg
     15.86 ± 31%     +14.9       30.77 ± 16%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter
     16.71 ± 30%     +15.3       32.02 ± 16%  perf-profile.calltrace.cycles-pp._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg
     16.30 ± 31%     +15.5       31.79 ± 16%  perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked
     17.87 ± 29%     +15.7       33.59 ± 16%  perf-profile.calltrace.cycles-pp.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.__sys_recvfrom
     17.84 ± 29%     +15.7       33.57 ± 16%  perf-profile.calltrace.cycles-pp.__skb_datagram_iter.skb_copy_datagram_iter.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg
     27.74 ± 14%     -12.2       15.57 ± 25%  perf-profile.children.cycles-pp.__tcp_transmit_skb
     21.97 ± 16%     -11.7       10.31 ± 35%  perf-profile.children.cycles-pp.tcp_write_xmit
     25.43 ± 14%     -10.8       14.64 ± 24%  perf-profile.children.cycles-pp.__ip_queue_xmit
     22.89 ± 13%      -9.5       13.43 ± 21%  perf-profile.children.cycles-pp.ip_finish_output2
     16.64 ± 14%      -8.0        8.60 ± 29%  perf-profile.children.cycles-pp.__tcp_push_pending_frames
     17.72 ± 13%      -7.8        9.91 ± 22%  perf-profile.children.cycles-pp.tcp_v4_do_rcv
     55.10 ±  4%      -7.5       47.59 ±  5%  perf-profile.children.cycles-pp.send
     17.03 ± 12%      -7.4        9.59 ± 21%  perf-profile.children.cycles-pp.tcp_rcv_established
     18.87 ± 12%      -7.3       11.56 ± 17%  perf-profile.children.cycles-pp.__local_bh_enable_ip
     18.56 ± 12%      -7.1       11.44 ± 17%  perf-profile.children.cycles-pp.do_softirq
     54.21 ±  4%      -6.9       47.33 ±  4%  perf-profile.children.cycles-pp.send_omni_inner
     18.36 ± 12%      -6.8       11.53 ± 16%  perf-profile.children.cycles-pp.__softirqentry_text_start
     53.87 ±  3%      -6.8       47.07 ±  4%  perf-profile.children.cycles-pp.send_tcp_stream
     17.39 ± 12%      -6.4       11.00 ± 16%  perf-profile.children.cycles-pp.net_rx_action
     16.98 ± 12%      -6.1       10.84 ± 15%  perf-profile.children.cycles-pp.__napi_poll
     16.89 ± 12%      -6.1       10.80 ± 15%  perf-profile.children.cycles-pp.process_backlog
     47.46 ±  4%      -6.1       41.38 ±  4%  perf-profile.children.cycles-pp.__x64_sys_sendto
     47.34 ±  4%      -6.0       41.33 ±  4%  perf-profile.children.cycles-pp.__sys_sendto
     46.65 ±  4%      -5.9       40.77 ±  4%  perf-profile.children.cycles-pp.sock_sendmsg
      9.54 ± 17%      -5.9        3.68 ± 48%  perf-profile.children.cycles-pp.__schedule
     10.69 ± 17%      -5.8        4.85 ± 39%  perf-profile.children.cycles-pp.release_sock
     16.39 ± 11%      -5.8       10.58 ± 15%  perf-profile.children.cycles-pp.__netif_receive_skb_one_core
     45.99 ±  4%      -5.7       40.31 ±  4%  perf-profile.children.cycles-pp.tcp_sendmsg
     10.14 ± 17%      -5.6        4.59 ± 40%  perf-profile.children.cycles-pp.__release_sock
      7.57 ± 18%      -5.1        2.45 ± 50%  perf-profile.children.cycles-pp.sock_def_readable
      7.90 ± 17%      -4.9        3.02 ± 48%  perf-profile.children.cycles-pp.schedule
      7.47 ± 17%      -4.8        2.62 ± 42%  perf-profile.children.cycles-pp.__wake_up_common_lock
      7.42 ± 18%      -4.8        2.58 ± 55%  perf-profile.children.cycles-pp.sk_wait_data
     14.46 ± 10%      -4.8        9.70 ± 11%  perf-profile.children.cycles-pp.ip_local_deliver_finish
      7.25 ± 17%      -4.7        2.53 ± 42%  perf-profile.children.cycles-pp.__wake_up_common
      7.02 ± 17%      -4.6        2.43 ± 42%  perf-profile.children.cycles-pp.try_to_wake_up
     14.05 ± 10%      -4.5        9.51 ± 11%  perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
     13.84 ± 10%      -4.4        9.39 ± 11%  perf-profile.children.cycles-pp.tcp_v4_rcv
      6.46 ± 17%      -4.0        2.48 ± 46%  perf-profile.children.cycles-pp.wait_woken
      6.18 ± 17%      -3.8        2.37 ± 46%  perf-profile.children.cycles-pp.schedule_timeout
      2.58 ± 16%      -1.7        0.91 ± 50%  perf-profile.children.cycles-pp.ttwu_do_activate
      2.53 ± 17%      -1.7        0.87 ± 52%  perf-profile.children.cycles-pp.enqueue_task_fair
      2.82 ± 17%      -1.7        1.17 ± 45%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      2.43 ± 18%      -1.6        0.85 ± 53%  perf-profile.children.cycles-pp.dequeue_task_fair
      2.34 ± 17%      -1.6        0.78 ± 30%  perf-profile.children.cycles-pp.select_task_rq
      3.63 ± 15%      -1.5        2.10 ± 31%  perf-profile.children.cycles-pp.__dev_queue_xmit
      3.32 ± 13%      -1.5        1.83 ± 25%  perf-profile.children.cycles-pp.tcp_ack
      2.19 ± 18%      -1.5        0.71 ± 30%  perf-profile.children.cycles-pp.select_task_rq_fair
      1.92 ± 18%      -1.3        0.60 ± 27%  perf-profile.children.cycles-pp.select_idle_sibling
      2.10 ± 18%      -1.3        0.80 ± 55%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.10 ± 17%      -1.2        0.86 ± 47%  perf-profile.children.cycles-pp.__cond_resched
      1.93 ± 17%      -1.2        0.75 ± 51%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      1.74 ± 16%      -1.1        0.65 ± 51%  perf-profile.children.cycles-pp.update_load_avg
      2.51 ± 12%      -1.1        1.44 ± 24%  perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      1.70 ± 16%      -1.0        0.67 ± 46%  perf-profile.children.cycles-pp.update_curr
      1.40 ± 19%      -1.0        0.37 ± 21%  perf-profile.children.cycles-pp.select_idle_cpu
      1.74 ± 15%      -1.0        0.76 ± 40%  perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.61 ± 17%      -1.0        0.64 ± 52%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.67 ± 15%      -0.9        0.74 ± 39%  perf-profile.children.cycles-pp.xmit_one
      3.06 ±  8%      -0.9        2.15 ± 13%  perf-profile.children.cycles-pp.__alloc_skb
      1.56 ± 16%      -0.9        0.68 ± 40%  perf-profile.children.cycles-pp.loopback_xmit
      1.52 ± 16%      -0.8        0.67 ± 40%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      1.32 ± 16%      -0.8        0.49 ± 52%  perf-profile.children.cycles-pp.enqueue_entity
      1.20 ± 27%      -0.7        0.49 ± 63%  perf-profile.children.cycles-pp.dst_release
      1.06 ± 26%      -0.6        0.41 ± 64%  perf-profile.children.cycles-pp.skb_release_head_state
      0.90 ± 19%      -0.6        0.26 ± 56%  perf-profile.children.cycles-pp.reweight_entity
      1.04 ± 17%      -0.6        0.40 ± 52%  perf-profile.children.cycles-pp.dequeue_entity
      2.54 ±  7%      -0.6        1.92 ± 10%  perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      0.90 ± 19%      -0.6        0.28 ± 60%  perf-profile.children.cycles-pp.set_next_entity
      1.14 ± 25%      -0.6        0.54 ± 56%  perf-profile.children.cycles-pp.ip_rcv
      0.70 ± 20%      -0.6        0.14 ± 21%  perf-profile.children.cycles-pp.available_idle_cpu
      0.89 ± 18%      -0.5        0.34 ± 39%  perf-profile.children.cycles-pp.prepare_task_switch
      0.96 ± 29%      -0.5        0.48 ± 51%  perf-profile.children.cycles-pp.ipv4_dst_check
      0.87 ± 18%      -0.5        0.42 ± 12%  perf-profile.children.cycles-pp._raw_spin_lock
      0.75 ± 17%      -0.4        0.31 ± 44%  perf-profile.children.cycles-pp.__switch_to_asm
      0.65 ± 17%      -0.4        0.22 ± 60%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      0.64 ± 17%      -0.4        0.22 ± 50%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.75 ± 19%      -0.4        0.33 ± 41%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      0.62 ± 17%      -0.4        0.21 ± 60%  perf-profile.children.cycles-pp.check_preempt_curr
      0.80 ± 16%      -0.4        0.38 ± 36%  perf-profile.children.cycles-pp.switch_fpu_return
      0.77 ± 29%      -0.4        0.36 ± 61%  perf-profile.children.cycles-pp.ip_rcv_finish_core
      0.57 ± 17%      -0.4        0.18 ± 63%  perf-profile.children.cycles-pp.check_preempt_wakeup
      0.68 ± 15%      -0.4        0.30 ± 39%  perf-profile.children.cycles-pp.__netif_rx
      0.78 ± 16%      -0.4        0.40 ± 32%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.66 ± 15%      -0.4        0.29 ± 40%  perf-profile.children.cycles-pp.netif_rx_internal
      0.54 ± 18%      -0.4        0.17 ± 54%  perf-profile.children.cycles-pp.native_sched_clock
      0.70 ± 16%      -0.4        0.33 ± 32%  perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.73 ± 14%      -0.4        0.37 ± 31%  perf-profile.children.cycles-pp.__tcp_send_ack
      0.64 ± 15%      -0.4        0.28 ± 40%  perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.56 ± 17%      -0.4        0.20 ± 41%  perf-profile.children.cycles-pp.update_rq_clock
      0.58 ± 15%      -0.3        0.26 ± 39%  perf-profile.children.cycles-pp.enqueue_to_backlog
      0.52 ± 16%      -0.3        0.21 ± 41%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.59 ± 16%      -0.3        0.28 ± 38%  perf-profile.children.cycles-pp.__switch_to
      0.60 ± 18%      -0.3        0.29 ± 31%  perf-profile.children.cycles-pp.__inet_lookup_established
      0.53 ± 14%      -0.3        0.23 ± 32%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.46 ± 18%      -0.3        0.16 ± 59%  perf-profile.children.cycles-pp.put_prev_entity
      0.63 ± 13%      -0.3        0.34 ± 23%  perf-profile.children.cycles-pp.sk_reset_timer
      0.48 ± 16%      -0.3        0.19 ± 43%  perf-profile.children.cycles-pp.read_tsc
      0.49 ± 17%      -0.3        0.21 ± 37%  perf-profile.children.cycles-pp.lock_sock_nested
      0.49 ± 18%      -0.3        0.22 ± 46%  perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.53 ± 17%      -0.3        0.26 ± 34%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.43 ± 16%      -0.3        0.17 ± 41%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.41 ± 17%      -0.3        0.15 ± 52%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.58 ± 13%      -0.3        0.33 ± 21%  perf-profile.children.cycles-pp.__mod_timer
      0.41 ± 17%      -0.3        0.16 ± 46%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.82 ± 14%      -0.2        0.57 ±  5%  perf-profile.children.cycles-pp.ktime_get
      0.43 ± 16%      -0.2        0.19 ± 41%  perf-profile.children.cycles-pp.___perf_sw_event
      0.47 ± 17%      -0.2        0.24 ± 38%  perf-profile.children.cycles-pp.validate_xmit_skb
      0.70 ±  9%      -0.2        0.48 ± 15%  perf-profile.children.cycles-pp.kmalloc_reserve
      0.42 ± 16%      -0.2        0.20 ± 39%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.41 ± 15%      -0.2        0.19 ± 38%  perf-profile.children.cycles-pp.__entry_text_start
      0.46 ± 14%      -0.2        0.25 ± 25%  perf-profile.children.cycles-pp.__might_resched
      0.41 ± 15%      -0.2        0.20 ± 29%  perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.29 ± 16%      -0.2        0.11 ± 54%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.32 ± 17%      -0.2        0.13 ± 64%  perf-profile.children.cycles-pp.set_next_buddy
      0.32 ± 19%      -0.2        0.14 ± 50%  perf-profile.children.cycles-pp.tcp_ack_update_rtt
      0.48 ±  8%      -0.2        0.31 ± 12%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.36 ± 22%      -0.2        0.19 ± 39%  perf-profile.children.cycles-pp.tcp_add_backlog
      0.63 ±  8%      -0.2        0.46 ± 13%  perf-profile.children.cycles-pp.__kmalloc_node_track_caller
      0.35 ± 17%      -0.2        0.18 ± 28%  perf-profile.children.cycles-pp.update_cfs_group
      0.32 ± 12%      -0.2        0.15 ± 25%  perf-profile.children.cycles-pp.__might_fault
      0.30 ± 15%      -0.2        0.13 ± 40%  perf-profile.children.cycles-pp.__might_sleep
      0.32 ± 14%      -0.2        0.16 ± 27%  perf-profile.children.cycles-pp.ktime_get_with_offset
      0.28 ± 17%      -0.2        0.11 ± 48%  perf-profile.children.cycles-pp.ip_local_out
      0.23 ± 20%      -0.2        0.07 ± 47%  perf-profile.children.cycles-pp.rb_erase
      0.27 ± 18%      -0.2        0.11 ± 52%  perf-profile.children.cycles-pp.__calc_delta
      0.33 ± 18%      -0.2        0.18 ± 41%  perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.32 ± 15%      -0.1        0.17 ± 19%  perf-profile.children.cycles-pp.send_data
      0.24 ± 16%      -0.1        0.09 ± 55%  perf-profile.children.cycles-pp.update_min_vruntime
      0.25 ± 16%      -0.1        0.11 ± 47%  perf-profile.children.cycles-pp.ip_rcv_core
      0.18 ± 18%      -0.1        0.04 ±109%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.24 ± 17%      -0.1        0.10 ± 47%  perf-profile.children.cycles-pp.__ip_local_out
      0.25 ± 17%      -0.1        0.11 ± 59%  perf-profile.children.cycles-pp.pick_next_entity
      0.26 ± 14%      -0.1        0.12 ± 29%  perf-profile.children.cycles-pp.perf_tp_event
      0.24 ± 18%      -0.1        0.10 ± 36%  perf-profile.children.cycles-pp.ip_finish_output
      0.22 ± 18%      -0.1        0.09 ± 41%  perf-profile.children.cycles-pp.cpuacct_charge
      0.32 ± 16%      -0.1        0.18 ± 14%  perf-profile.children.cycles-pp.recv_data
      0.45 ±  9%      -0.1        0.32 ±  9%  perf-profile.children.cycles-pp.kmem_cache_free
      0.26 ± 13%      -0.1        0.14 ± 38%  perf-profile.children.cycles-pp.ip_output
      0.22 ± 18%      -0.1        0.10 ± 43%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.21 ± 16%      -0.1        0.09 ± 36%  perf-profile.children.cycles-pp._find_next_bit
      0.21 ± 20%      -0.1        0.09 ± 56%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.27 ± 12%      -0.1        0.16 ± 27%  perf-profile.children.cycles-pp.tcp_tso_segs
      0.16 ± 18%      -0.1        0.04 ±111%  perf-profile.children.cycles-pp.ip_send_check
      0.21 ± 17%      -0.1        0.10 ± 40%  perf-profile.children.cycles-pp.netif_skb_features
      0.53 ±  7%      -0.1        0.42 ± 10%  perf-profile.children.cycles-pp.aa_sk_perm
      0.46 ±  7%      -0.1        0.35 ±  8%  perf-profile.children.cycles-pp.security_socket_sendmsg
      0.24 ± 18%      -0.1        0.12 ± 45%  perf-profile.children.cycles-pp.finish_task_switch
      0.15 ± 21%      -0.1        0.04 ±115%  perf-profile.children.cycles-pp.sock_put
      0.16 ± 19%      -0.1        0.05 ± 88%  perf-profile.children.cycles-pp.tcp_rearm_rto
      0.14 ± 11%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.__copy_skb_header
      0.15 ± 14%      -0.1        0.05 ± 82%  perf-profile.children.cycles-pp.inet_ehashfn
      0.17 ± 12%      -0.1        0.07 ± 33%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.19 ± 19%      -0.1        0.09 ± 39%  perf-profile.children.cycles-pp.tcp_wfree
      0.17 ± 17%      -0.1        0.07 ± 44%  perf-profile.children.cycles-pp.remove_wait_queue
      0.15 ± 14%      -0.1        0.05 ± 77%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.72 ±  5%      -0.1        0.62 ±  4%  perf-profile.children.cycles-pp.sockfd_lookup_light
      0.18 ± 19%      -0.1        0.08 ± 41%  perf-profile.children.cycles-pp.add_wait_queue
      0.33 ±  6%      -0.1        0.24 ± 14%  perf-profile.children.cycles-pp.__skb_clone
      0.22 ± 13%      -0.1        0.13 ± 18%  perf-profile.children.cycles-pp.tcp_rcv_space_adjust
      0.18 ± 16%      -0.1        0.08 ± 36%  perf-profile.children.cycles-pp.memcg_slab_free_hook
      0.13 ± 16%      -0.1        0.03 ±106%  perf-profile.children.cycles-pp.kmalloc_slab
      0.20 ± 17%      -0.1        0.11 ± 41%  perf-profile.children.cycles-pp.__tcp_ack_snd_check
      0.14 ± 17%      -0.1        0.05 ± 80%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.24 ± 11%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.__ksize
      0.16 ± 16%      -0.1        0.08 ± 44%  perf-profile.children.cycles-pp.cpumask_next
      0.17 ± 13%      -0.1        0.09 ± 29%  perf-profile.children.cycles-pp.tcp_established_options
      0.15 ± 15%      -0.1        0.07 ± 37%  perf-profile.children.cycles-pp.__tcp_select_window
      0.14 ± 14%      -0.1        0.07 ± 29%  perf-profile.children.cycles-pp.tcp_event_data_recv
      0.14 ± 14%      -0.1        0.08 ± 22%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.13 ± 12%      -0.1        0.06 ± 28%  perf-profile.children.cycles-pp.__list_add_valid
      0.13 ± 17%      -0.1        0.07 ± 37%  perf-profile.children.cycles-pp.rb_next
      0.10 ±  7%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.eth_type_trans
      0.11 ± 16%      -0.1        0.06 ± 25%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.13 ±  9%      -0.1        0.08 ± 13%  perf-profile.children.cycles-pp.kfree_skbmem
      0.56 ±  5%      -0.1        0.52 ±  2%  perf-profile.children.cycles-pp.__fget_light
      0.10 ± 16%      -0.0        0.06 ± 25%  perf-profile.children.cycles-pp.tcp_cleanup_rbuf
      0.09 ± 12%      -0.0        0.05 ± 47%  perf-profile.children.cycles-pp.check_stack_object
      0.10 ±  8%      -0.0        0.07 ± 15%  perf-profile.children.cycles-pp.rcu_all_qs
      0.11 ±  6%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.lock_timer_base
      0.07 ± 10%      -0.0        0.05 ±  8%  perf-profile.children.cycles-pp.enqueue_timer
      0.26 ±  3%      +0.1        0.31 ±  4%  perf-profile.children.cycles-pp.tcp_eat_recv_skb
      0.02 ±142%      +0.1        0.08 ± 21%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.write
      0.02 ±141%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.__zone_watermark_ok
      0.35 ±  3%      +0.1        0.42 ± 11%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.18 ±  8%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.sock_rfree
      0.02 ±142%      +0.1        0.11 ± 31%  perf-profile.children.cycles-pp.call_timer_fn
      0.02 ±142%      +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.run_timer_softirq
      0.02 ±141%      +0.1        0.12 ± 27%  perf-profile.children.cycles-pp.__run_timers
      0.02 ±141%      +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.__free_one_page
      0.02 ±141%      +0.1        0.15 ± 25%  perf-profile.children.cycles-pp.check_new_pages
      0.07 ± 76%      +0.1        0.21 ± 24%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.51 ±  7%      +0.1        0.66 ±  9%  perf-profile.children.cycles-pp.kfree
      0.03 ±141%      +0.2        0.19 ± 28%  perf-profile.children.cycles-pp.___slab_alloc
      0.12 ± 27%      +0.2        0.28 ± 27%  perf-profile.children.cycles-pp.__put_page
      0.12 ± 27%      +0.2        0.32 ± 17%  perf-profile.children.cycles-pp.task_tick_fair
      0.06 ± 78%      +0.2        0.26 ± 33%  perf-profile.children.cycles-pp.PageHuge
      0.26 ± 21%      +0.2        0.46 ± 18%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.02 ±142%      +0.2        0.22 ± 39%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.18 ± 37%      +0.2        0.41 ± 18%  perf-profile.children.cycles-pp.skb_clone
      0.04 ±108%      +0.2        0.28 ± 29%  perf-profile.children.cycles-pp.sk_stream_write_space
      0.13 ± 29%      +0.2        0.38 ± 23%  perf-profile.children.cycles-pp.tcp_check_space
      0.04 ±141%      +0.2        0.28 ± 29%  perf-profile.children.cycles-pp.sk_stream_wait_memory
      0.19 ± 23%      +0.2        0.44 ± 16%  perf-profile.children.cycles-pp.scheduler_tick
      0.03 ±141%      +0.3        0.29 ± 33%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.10 ± 82%      +0.3        0.36 ± 23%  perf-profile.children.cycles-pp.__slab_free
      0.09 ± 84%      +0.3        0.36 ± 27%  perf-profile.children.cycles-pp.skb_try_coalesce
      0.04 ±107%      +0.3        0.31 ± 30%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.10 ± 84%      +0.3        0.38 ± 27%  perf-profile.children.cycles-pp.tcp_try_coalesce
      0.32 ± 19%      +0.4        0.68 ± 17%  perf-profile.children.cycles-pp.update_process_times
      0.33 ± 20%      +0.4        0.72 ± 17%  perf-profile.children.cycles-pp.tick_sched_handle
      0.39 ± 13%      +0.4        0.78 ± 17%  perf-profile.children.cycles-pp.tick_sched_timer
      0.24 ± 28%      +0.4        0.67 ± 24%  perf-profile.children.cycles-pp.rmqueue
      0.32 ± 29%      +0.5        0.78 ± 24%  perf-profile.children.cycles-pp.free_pcp_prepare
      0.49 ± 15%      +0.5        0.96 ± 16%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.49 ± 16%      +0.5        0.96 ± 19%  perf-profile.children.cycles-pp.__alloc_pages
      0.37 ± 21%      +0.5        0.85 ± 21%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.80 ±  9%      +0.5        1.30 ± 13%  perf-profile.children.cycles-pp.sk_page_frag_refill
      0.76 ± 10%      +0.5        1.26 ± 14%  perf-profile.children.cycles-pp.skb_page_frag_refill
      0.74 ±  8%      +0.5        1.25 ± 16%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.72 ±  9%      +0.5        1.24 ± 16%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.84 ± 10%      +0.6        1.48 ± 16%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.53 ± 23%      +0.7        1.22 ± 23%  perf-profile.children.cycles-pp.free_unref_page
     35.38            +0.8       36.21        perf-profile.children.cycles-pp.tcp_sendmsg_locked
      1.66 ±  8%      +0.9        2.52 ± 15%  perf-profile.children.cycles-pp.skb_release_data
      0.32 ± 84%      +1.2        1.54 ± 31%  perf-profile.children.cycles-pp.__sk_defer_free_flush
      1.26 ± 27%      +1.4        2.69 ± 20%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     95.58            +2.1       97.64        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     95.15            +2.3       97.46        perf-profile.children.cycles-pp.do_syscall_64
     43.52 ±  5%      +7.9       51.38 ±  5%  perf-profile.children.cycles-pp.recv
     42.50 ±  6%      +8.6       51.08 ±  5%  perf-profile.children.cycles-pp.accept_connection
     42.50 ±  6%      +8.6       51.08 ±  5%  perf-profile.children.cycles-pp.spawn_child
     42.50 ±  6%      +8.6       51.08 ±  5%  perf-profile.children.cycles-pp.process_requests
     42.48 ±  6%      +8.6       51.07 ±  5%  perf-profile.children.cycles-pp.recv_omni
     39.24 ±  7%      +9.4       48.60 ±  6%  perf-profile.children.cycles-pp.__x64_sys_recvfrom
     37.21 ±  7%      +9.4       46.58 ±  6%  perf-profile.children.cycles-pp.tcp_recvmsg_locked
     39.13 ±  7%      +9.4       48.56 ±  6%  perf-profile.children.cycles-pp.__sys_recvfrom
     38.29 ±  7%      +9.7       48.03 ±  7%  perf-profile.children.cycles-pp.inet_recvmsg
     38.16 ±  7%      +9.8       47.97 ±  7%  perf-profile.children.cycles-pp.tcp_recvmsg
     11.67 ± 27%     +10.1       21.79 ± 15%  perf-profile.children.cycles-pp.copyin
     12.75 ± 25%     +10.2       22.91 ± 15%  perf-profile.children.cycles-pp.skb_do_copy_data_nocache
     12.15 ± 26%     +10.2       22.39 ± 15%  perf-profile.children.cycles-pp._copy_from_iter
     16.73 ± 30%     +15.3       32.04 ± 16%  perf-profile.children.cycles-pp._copy_to_iter
     16.31 ± 31%     +15.5       31.79 ± 16%  perf-profile.children.cycles-pp.copyout
     17.87 ± 29%     +15.7       33.60 ± 16%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
     17.84 ± 29%     +15.7       33.57 ± 16%  perf-profile.children.cycles-pp.__skb_datagram_iter
     27.76 ± 30%     +25.7       53.48 ± 16%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      1.58 ± 17%      -0.9        0.64 ± 52%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.17 ± 27%      -0.7        0.49 ± 62%  perf-profile.self.cycles-pp.dst_release
      0.84 ± 20%      -0.6        0.21 ± 34%  perf-profile.self.cycles-pp._raw_spin_lock
      0.90 ± 16%      -0.6        0.33 ± 53%  perf-profile.self.cycles-pp.update_load_avg
      0.69 ± 20%      -0.6        0.13 ± 19%  perf-profile.self.cycles-pp.available_idle_cpu
      0.94 ± 15%      -0.5        0.44 ± 36%  perf-profile.self.cycles-pp.__schedule
      0.96 ± 28%      -0.5        0.47 ± 51%  perf-profile.self.cycles-pp.ipv4_dst_check
      0.77 ± 15%      -0.5        0.30 ± 47%  perf-profile.self.cycles-pp.update_curr
      0.75 ± 17%      -0.4        0.31 ± 44%  perf-profile.self.cycles-pp.__switch_to_asm
      1.24 ±  8%      -0.4        0.83 ± 16%  perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.76 ± 29%      -0.4        0.36 ± 62%  perf-profile.self.cycles-pp.ip_rcv_finish_core
      0.70 ± 19%      -0.4        0.30 ± 44%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      0.77 ± 16%      -0.4        0.40 ± 32%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.53 ± 18%      -0.4        0.16 ± 55%  perf-profile.self.cycles-pp.native_sched_clock
      0.63 ± 15%      -0.4        0.28 ± 39%  perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.44 ± 23%      -0.3        0.10 ± 50%  perf-profile.self.cycles-pp.reweight_entity
      0.66 ± 21%      -0.3        0.32 ± 49%  perf-profile.self.cycles-pp.tcp_v4_rcv
      0.62 ± 18%      -0.3        0.28 ± 46%  perf-profile.self.cycles-pp.ip_finish_output2
      0.46 ± 19%      -0.3        0.16 ± 32%  perf-profile.self.cycles-pp.prepare_task_switch
      0.47 ± 17%      -0.3        0.17 ± 20%  perf-profile.self.cycles-pp.select_idle_cpu
      0.56 ± 16%      -0.3        0.27 ± 37%  perf-profile.self.cycles-pp.__switch_to
      0.46 ± 16%      -0.3        0.19 ± 43%  perf-profile.self.cycles-pp.read_tsc
      0.53 ± 17%      -0.3        0.26 ± 34%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.63 ± 10%      -0.3        0.36 ± 24%  perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.37 ± 15%      -0.3        0.12 ± 46%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.44 ± 17%      -0.3        0.18 ± 47%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.42 ± 15%      -0.3        0.17 ± 41%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.40 ± 17%      -0.3        0.14 ± 58%  perf-profile.self.cycles-pp.enqueue_entity
      0.40 ± 18%      -0.3        0.15 ± 50%  perf-profile.self.cycles-pp.loopback_xmit
      0.40 ± 16%      -0.2        0.14 ± 53%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.40 ± 17%      -0.2        0.16 ± 45%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.43 ± 16%      -0.2        0.19 ± 36%  perf-profile.self.cycles-pp.tcp_ack
      0.47 ± 14%      -0.2        0.23 ± 33%  perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.40 ± 16%      -0.2        0.16 ± 43%  perf-profile.self.cycles-pp.__softirqentry_text_start
      0.36 ± 17%      -0.2        0.13 ± 43%  perf-profile.self.cycles-pp.net_rx_action
      0.32 ± 19%      -0.2        0.10 ± 50%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.38 ± 16%      -0.2        0.16 ± 45%  perf-profile.self.cycles-pp.___perf_sw_event
      0.31 ± 18%      -0.2        0.09 ± 34%  perf-profile.self.cycles-pp.update_rq_clock
      0.41 ± 16%      -0.2        0.20 ± 38%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.44 ± 20%      -0.2        0.23 ± 27%  perf-profile.self.cycles-pp.__inet_lookup_established
      0.45 ± 13%      -0.2        0.24 ± 24%  perf-profile.self.cycles-pp.__might_resched
      0.42 ± 12%      -0.2        0.22 ± 28%  perf-profile.self.cycles-pp.kmem_cache_alloc_node
      0.30 ± 17%      -0.2        0.12 ± 45%  perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.30 ± 18%      -0.2        0.12 ± 65%  perf-profile.self.cycles-pp.set_next_buddy
      0.29 ± 17%      -0.2        0.11 ± 56%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.42 ± 14%      -0.2        0.25 ± 22%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.24 ± 18%      -0.2        0.07 ± 71%  perf-profile.self.cycles-pp.sk_wait_data
      0.30 ± 24%      -0.2        0.13 ± 64%  perf-profile.self.cycles-pp.tcp_v4_do_rcv
      0.34 ± 15%      -0.2        0.18 ± 27%  perf-profile.self.cycles-pp.update_cfs_group
      0.28 ± 17%      -0.2        0.11 ± 47%  perf-profile.self.cycles-pp.wait_woken
      0.20 ± 14%      -0.2        0.04 ±113%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.46 ±  8%      -0.2        0.30 ± 12%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.36 ± 11%      -0.2        0.21 ± 25%  perf-profile.self.cycles-pp.__kmalloc_node_track_caller
      0.26 ± 17%      -0.2        0.11 ± 52%  perf-profile.self.cycles-pp.__calc_delta
      0.29 ± 16%      -0.2        0.14 ± 33%  perf-profile.self.cycles-pp.__mod_timer
      0.26 ± 17%      -0.2        0.11 ± 43%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.30 ± 13%      -0.2        0.15 ± 32%  perf-profile.self.cycles-pp.do_syscall_64
      0.26 ± 15%      -0.2        0.11 ± 44%  perf-profile.self.cycles-pp.do_softirq
      0.34 ± 14%      -0.2        0.19 ± 36%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.39 ± 10%      -0.1        0.24 ± 18%  perf-profile.self.cycles-pp.send_omni_inner
      0.34 ± 16%      -0.1        0.19 ± 22%  perf-profile.self.cycles-pp.send
      0.26 ± 14%      -0.1        0.12 ± 39%  perf-profile.self.cycles-pp.__might_sleep
      0.23 ± 15%      -0.1        0.08 ± 55%  perf-profile.self.cycles-pp.update_min_vruntime
      0.25 ± 16%      -0.1        0.11 ± 38%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.26 ± 15%      -0.1        0.12 ± 39%  perf-profile.self.cycles-pp.select_idle_sibling
      0.24 ± 18%      -0.1        0.10 ± 34%  perf-profile.self.cycles-pp.ip_finish_output
      0.24 ± 17%      -0.1        0.11 ± 47%  perf-profile.self.cycles-pp.ip_rcv_core
      0.23 ± 18%      -0.1        0.10 ± 61%  perf-profile.self.cycles-pp.pick_next_entity
      0.18 ± 17%      -0.1        0.05 ± 87%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.21 ± 18%      -0.1        0.08 ± 38%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.22 ± 18%      -0.1        0.08 ± 38%  perf-profile.self.cycles-pp.cpuacct_charge
      0.25 ± 15%      -0.1        0.12 ± 24%  perf-profile.self.cycles-pp.send_data
      0.24 ± 14%      -0.1        0.11 ± 37%  perf-profile.self.cycles-pp.switch_fpu_return
      0.18 ± 18%      -0.1        0.06 ± 63%  perf-profile.self.cycles-pp.set_next_entity
      0.18 ± 20%      -0.1        0.06 ± 92%  perf-profile.self.cycles-pp.put_prev_entity
      0.17 ± 19%      -0.1        0.06 ± 89%  perf-profile.self.cycles-pp.__cond_resched
      0.24 ± 14%      -0.1        0.13 ± 22%  perf-profile.self.cycles-pp.__sys_sendto
      0.25 ± 15%      -0.1        0.14 ± 21%  perf-profile.self.cycles-pp.recv_data
      0.18 ± 15%      -0.1        0.06 ± 65%  perf-profile.self.cycles-pp.schedule
      0.15 ± 17%      -0.1        0.04 ±111%  perf-profile.self.cycles-pp.ip_send_check
      0.26 ± 11%      -0.1        0.16 ± 26%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.15 ± 14%      -0.1        0.04 ±110%  perf-profile.self.cycles-pp.inet_ehashfn
      0.30 ± 12%      -0.1        0.19 ±  9%  perf-profile.self.cycles-pp.recv_omni
      0.19 ± 22%      -0.1        0.09 ± 53%  perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.19 ± 16%      -0.1        0.09 ± 36%  perf-profile.self.cycles-pp._find_next_bit
      0.14 ± 19%      -0.1        0.04 ±112%  perf-profile.self.cycles-pp.sock_put
      0.23 ± 15%      -0.1        0.13 ± 18%  perf-profile.self.cycles-pp.recv
      0.42 ±  9%      -0.1        0.32 ± 11%  perf-profile.self.cycles-pp.skb_release_data
      0.14 ± 13%      -0.1        0.04 ± 75%  perf-profile.self.cycles-pp.__copy_skb_header
      0.21 ± 10%      -0.1        0.11 ± 32%  perf-profile.self.cycles-pp.process_backlog
      0.19 ± 15%      -0.1        0.09 ± 32%  perf-profile.self.cycles-pp.irqtime_account_irq
      0.15 ± 14%      -0.1        0.05 ± 77%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.33 ±  9%      -0.1        0.23 ±  9%  perf-profile.self.cycles-pp.kmem_cache_free
      0.18 ± 16%      -0.1        0.08 ± 38%  perf-profile.self.cycles-pp.memcg_slab_free_hook
      0.19 ± 17%      -0.1        0.09 ± 39%  perf-profile.self.cycles-pp.tcp_wfree
      0.19 ± 20%      -0.1        0.10 ± 33%  perf-profile.self.cycles-pp.sk_filter_trim_cap
      0.17 ± 17%      -0.1        0.08 ± 30%  perf-profile.self.cycles-pp.tcp_queue_rcv
      0.17 ± 13%      -0.1        0.08 ± 34%  perf-profile.self.cycles-pp.ip_output
      0.14 ± 17%      -0.1        0.05 ± 80%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.18 ± 12%      -0.1        0.10 ± 30%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.42 ±  7%      -0.1        0.33 ± 10%  perf-profile.self.cycles-pp.aa_sk_perm
      0.12 ± 17%      -0.1        0.04 ±105%  perf-profile.self.cycles-pp.__x64_sys_sendto
      0.33 ± 10%      -0.1        0.25 ±  8%  perf-profile.self.cycles-pp.kfree
      0.18 ± 16%      -0.1        0.09 ± 30%  perf-profile.self.cycles-pp.__entry_text_start
      0.15 ± 16%      -0.1        0.07 ± 33%  perf-profile.self.cycles-pp.release_sock
      0.27 ±  9%      -0.1        0.19 ± 11%  perf-profile.self.cycles-pp._copy_to_iter
      0.18 ± 18%      -0.1        0.09 ± 42%  perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.13 ± 16%      -0.1        0.04 ± 79%  perf-profile.self.cycles-pp.inet_recvmsg
      0.16 ± 14%      -0.1        0.08 ± 38%  perf-profile.self.cycles-pp.try_to_wake_up
      0.24 ± 12%      -0.1        0.16 ± 14%  perf-profile.self.cycles-pp.__ksize
      0.18 ± 11%      -0.1        0.10 ± 15%  perf-profile.self.cycles-pp.ktime_get_with_offset
      0.16 ± 14%      -0.1        0.09 ± 36%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.14 ± 13%      -0.1        0.06 ± 29%  perf-profile.self.cycles-pp.perf_tp_event
      0.15 ± 14%      -0.1        0.07 ± 30%  perf-profile.self.cycles-pp.select_task_rq
      0.12 ± 17%      -0.1        0.04 ±110%  perf-profile.self.cycles-pp.schedule_timeout
      0.16 ± 15%      -0.1        0.09 ± 29%  perf-profile.self.cycles-pp.tcp_established_options
      0.11 ± 13%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.tcp_add_backlog
      0.14 ± 16%      -0.1        0.07 ± 33%  perf-profile.self.cycles-pp.__tcp_select_window
      0.14 ± 16%      -0.1        0.07 ± 29%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.17 ± 16%      -0.1        0.10 ± 30%  perf-profile.self.cycles-pp.validate_xmit_skb
      0.10 ±  7%      -0.1        0.03 ±102%  perf-profile.self.cycles-pp.eth_type_trans
      0.14 ± 12%      -0.1        0.07 ± 20%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.12 ± 16%      -0.1        0.06 ± 60%  perf-profile.self.cycles-pp.tcp_skb_entail
      0.12 ± 12%      -0.1        0.06 ± 30%  perf-profile.self.cycles-pp.__list_add_valid
      0.56 ±  5%      -0.1        0.49 ±  3%  perf-profile.self.cycles-pp.__fget_light
      0.13 ± 14%      -0.1        0.07 ± 33%  perf-profile.self.cycles-pp.rb_next
      0.13 ± 10%      -0.1        0.07 ± 24%  perf-profile.self.cycles-pp.__might_fault
      0.14 ± 14%      -0.1        0.09 ± 25%  perf-profile.self.cycles-pp.sock_def_readable
      0.09 ± 14%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.__wake_up_common
      0.11 ± 11%      -0.1        0.05 ± 51%  perf-profile.self.cycles-pp.xmit_one
      0.08 ± 17%      -0.1        0.03 ±103%  perf-profile.self.cycles-pp.tcp_cleanup_rbuf
      0.13 ± 10%      -0.0        0.08 ± 13%  perf-profile.self.cycles-pp.kfree_skbmem
      0.10 ± 12%      -0.0        0.06 ± 19%  perf-profile.self.cycles-pp.security_socket_sendmsg
      0.11 ± 11%      -0.0        0.06 ± 23%  perf-profile.self.cycles-pp.sock_sendmsg
      0.10 ± 16%      -0.0        0.06 ± 21%  perf-profile.self.cycles-pp.__release_sock
      0.13 ± 14%      -0.0        0.09 ± 15%  perf-profile.self.cycles-pp.tcp_stream_alloc_skb
      0.08 ± 10%      -0.0        0.05 ± 47%  perf-profile.self.cycles-pp.tcp_eat_recv_skb
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ±  8%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.free_unref_page
      0.07 ±  6%      +0.0        0.09 ± 11%  perf-profile.self.cycles-pp.tcp_check_space
      0.18 ±  2%      +0.0        0.20 ±  2%  perf-profile.self.cycles-pp.skb_page_frag_refill
      0.10            +0.0        0.12 ±  6%  perf-profile.self.cycles-pp.rmqueue
      0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.self.cycles-pp.alloc_pages
      0.27 ±  3%      +0.0        0.32 ±  6%  perf-profile.self.cycles-pp._copy_from_iter
      0.76            +0.0        0.81        perf-profile.self.cycles-pp.tcp_write_xmit
      0.02 ±142%      +0.1        0.08 ± 20%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.02 ±141%      +0.1        0.10 ± 20%  perf-profile.self.cycles-pp.__zone_watermark_ok
      0.18 ±  9%      +0.1        0.25 ±  7%  perf-profile.self.cycles-pp.sock_rfree
      0.32 ±  4%      +0.1        0.42 ± 12%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.03 ±141%      +0.1        0.14 ± 24%  perf-profile.self.cycles-pp.___slab_alloc
      0.01 ±223%      +0.1        0.13 ± 26%  perf-profile.self.cycles-pp.__free_one_page
      0.02 ±141%      +0.1        0.15 ± 25%  perf-profile.self.cycles-pp.check_new_pages
      0.32 ± 15%      +0.1        0.45 ±  7%  perf-profile.self.cycles-pp.__skb_datagram_iter
      0.06 ± 77%      +0.2        0.25 ± 34%  perf-profile.self.cycles-pp.PageHuge
      0.16 ± 27%      +0.2        0.35 ± 25%  perf-profile.self.cycles-pp.skb_do_copy_data_nocache
      0.02 ±142%      +0.2        0.22 ± 39%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.17 ± 40%      +0.2        0.40 ± 18%  perf-profile.self.cycles-pp.skb_clone
      0.19 ± 43%      +0.2        0.42 ± 17%  perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.52 ± 15%      +0.2        0.76 ± 10%  perf-profile.self.cycles-pp.__alloc_skb
      0.09 ± 84%      +0.3        0.35 ± 28%  perf-profile.self.cycles-pp.skb_try_coalesce
      0.10 ± 82%      +0.3        0.36 ± 23%  perf-profile.self.cycles-pp.__slab_free
      0.61 ± 12%      +0.4        0.98 ± 19%  perf-profile.self.cycles-pp.__check_object_size
      0.32 ± 29%      +0.4        0.76 ± 24%  perf-profile.self.cycles-pp.free_pcp_prepare
      1.50 ± 13%      +0.6        2.10 ±  9%  perf-profile.self.cycles-pp.tcp_sendmsg_locked
      5.06 ±  8%      +0.8        5.89 ±  3%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode
     27.43 ± 30%     +25.1       52.52 ± 16%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string



***************************************************************************************************
lkp-icl-2sp6: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz with 128G memory
=========================================================================================
class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
  pipe/gcc-11/performance/x86_64-rhel-8.3/100%/debian-10.4-x86_64-20200603.cgz/lkp-icl-2sp6/fifo/stress-ng/60s/0xd000331

commit: 
  089c02ae27 ("ftrace: Use preemption model accessors for trace header printout")
  6b433275e3 ("sched/fair: filter out overloaded cpus in SIS")

089c02ae2771a14a 6b433275e3a3cf18a16c0d2afb7 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
 1.736e+09 ±  6%     +26.8%    2.2e+09 ±  6%  stress-ng.fifo.ops
  28931140 ±  6%     +26.8%   36670758 ±  6%  stress-ng.fifo.ops_per_sec
 8.772e+08 ±  3%     -38.2%  5.421e+08        stress-ng.time.involuntary_context_switches
    408.02 ±  3%     +12.8%     460.42        stress-ng.time.user_time
 1.417e+09 ±  3%     -12.6%  1.238e+09 ±  7%  stress-ng.time.voluntary_context_switches
  21260022 ±  3%     -53.5%    9882616 ±  5%  cpuidle..usage
      5.80 ±  9%      -0.8        5.03        mpstat.cpu.all.idle%
      0.02 ±  5%      -0.0        0.02 ±  8%  mpstat.cpu.all.soft%
      5.24 ±  3%      +0.6        5.83        mpstat.cpu.all.usr%
  18344723 ±  3%     -58.5%    7614636 ±  6%  turbostat.C1
      0.77 ±  4%      -0.5        0.30 ±  7%  turbostat.C1%
  46526185 ±  9%     -35.6%   29952171 ±  5%  turbostat.IRQ
    257.33           +16.1%     298.67 ±  2%  vmstat.procs.r
  35575264 ±  3%     -22.5%   27561102 ±  5%  vmstat.system.cs
    714764 ±  9%     -35.4%     461616 ±  5%  vmstat.system.in
   1415904 ± 12%     +88.8%    2673914 ±  6%  proc-vmstat.numa_hit
   1300187 ± 13%     +96.8%    2558221 ±  6%  proc-vmstat.numa_local
   1415865 ± 12%     +88.9%    2673934 ±  6%  proc-vmstat.pgalloc_normal
   1214846 ± 14%    +103.7%    2474149 ±  6%  proc-vmstat.pgfree
     27150 ±  2%      -2.3%      26529        proc-vmstat.pgreuse
      1.09           +18.9%       1.30 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.64 ±  3%     +20.4%       0.77 ±  7%  sched_debug.cfs_rq:/.h_nr_running.stddev
    404114 ± 21%     -42.3%     233298 ± 21%  sched_debug.cfs_rq:/.min_vruntime.stddev
      1225           +16.0%       1422 ±  2%  sched_debug.cfs_rq:/.runnable_avg.avg
      2533 ±  9%     +37.9%       3493 ± 19%  sched_debug.cfs_rq:/.runnable_avg.max
    404214 ± 21%     -42.3%     233408 ± 21%  sched_debug.cfs_rq:/.spread0.stddev
      1.10 ±  3%     +19.3%       1.31 ±  3%  sched_debug.cpu.nr_running.avg
      3.00           +55.6%       4.67 ± 23%  sched_debug.cpu.nr_running.max
      0.65 ±  3%     +19.7%       0.78 ±  7%  sched_debug.cpu.nr_running.stddev
   8624987 ±  2%     -22.6%    6679073 ±  5%  sched_debug.cpu.nr_switches.avg
  12669773 ±  4%     -21.8%    9903407 ± 12%  sched_debug.cpu.nr_switches.max
   2489911 ± 18%     -54.7%    1128032 ± 15%  sched_debug.cpu.nr_switches.stddev
      4.46 ±  5%     -27.0%       3.26 ±  5%  perf-stat.i.MPKI
 5.637e+10 ±  2%      +3.8%  5.853e+10        perf-stat.i.branch-instructions
      0.79 ±  3%      -0.1        0.69 ±  3%  perf-stat.i.branch-miss-rate%
 4.063e+08           -11.7%  3.585e+08 ±  4%  perf-stat.i.branch-misses
      0.80 ± 19%      +0.3        1.08 ± 11%  perf-stat.i.cache-miss-rate%
 1.189e+09 ±  2%     -25.3%  8.875e+08 ±  2%  perf-stat.i.cache-references
  36910521 ±  2%     -22.6%   28555484 ±  5%  perf-stat.i.context-switches
 7.988e+10 ±  2%      +4.5%  8.347e+10        perf-stat.i.dTLB-loads
 4.885e+10 ±  2%      +4.6%  5.112e+10        perf-stat.i.dTLB-stores
 2.795e+11 ±  2%      +4.4%  2.917e+11        perf-stat.i.instructions
    350.05 ±  2%     -18.2%     286.28 ±  6%  perf-stat.i.metric.K/sec
      1455 ±  2%      +4.1%       1515        perf-stat.i.metric.M/sec
      4.25 ±  3%     -28.5%       3.04 ±  2%  perf-stat.overall.MPKI
      0.72 ±  2%      -0.1        0.61 ±  4%  perf-stat.overall.branch-miss-rate%
      0.66 ± 15%      +0.2        0.91 ±  5%  perf-stat.overall.cache-miss-rate%
      0.73 ±  2%      +3.6%       0.75        perf-stat.overall.ipc
 5.551e+10 ±  2%      +3.9%  5.766e+10        perf-stat.ps.branch-instructions
 3.999e+08           -11.8%  3.527e+08 ±  4%  perf-stat.ps.branch-misses
  1.17e+09 ±  2%     -25.4%   8.73e+08 ±  2%  perf-stat.ps.cache-references
  36346244 ±  2%     -22.7%   28101939 ±  5%  perf-stat.ps.context-switches
 7.867e+10 ±  2%      +4.5%  8.223e+10        perf-stat.ps.dTLB-loads
 4.811e+10 ±  2%      +4.7%  5.036e+10        perf-stat.ps.dTLB-stores
 2.753e+11 ±  2%      +4.4%  2.873e+11        perf-stat.ps.instructions
 1.738e+13            +4.6%  1.819e+13        perf-stat.total.instructions
     28.90 ±  4%      -8.5       20.41 ± 13%  perf-profile.calltrace.cycles-pp.read
     26.32 ±  4%      -8.3       18.04 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
     25.93 ±  4%      -8.2       17.71 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     11.73 ±  9%      -7.1        4.66 ± 22%  perf-profile.calltrace.cycles-pp.__wake_up_common_lock.pipe_read.new_sync_read.vfs_read.ksys_read
     11.38 ± 10%      -6.9        4.46 ± 22%  perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.pipe_read.new_sync_read.vfs_read
     11.28 ± 10%      -6.9        4.39 ± 22%  perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read.new_sync_read
     11.17 ± 10%      -6.8        4.34 ± 23%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.pipe_read
     17.47 ±  5%      -5.7       11.78 ± 14%  perf-profile.calltrace.cycles-pp.pipe_read.new_sync_read.vfs_read.ksys_read.do_syscall_64
     17.99 ±  5%      -5.6       12.40 ± 13%  perf-profile.calltrace.cycles-pp.new_sync_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      9.14 ± 11%      -5.4        3.72 ± 22%  perf-profile.calltrace.cycles-pp.schedule.pipe_write.new_sync_write.vfs_write.ksys_write
      8.94 ± 11%      -5.3        3.64 ± 23%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_write.new_sync_write.vfs_write
     19.71 ±  4%      -5.3       14.44 ± 12%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
     20.13 ±  4%      -5.2       14.98 ± 12%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.23 ±  6%      -3.1        2.09 ± 20%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      5.46 ±  6%      -3.1        2.34 ± 19%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      4.98 ± 19%      -2.9        2.06 ± 27%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      4.89 ± 19%      -2.9        2.02 ± 28%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      4.88 ± 20%      -2.9        2.03 ± 27%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.pipe_write.new_sync_write
      5.94 ±  3%      -2.6        3.30 ±  4%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.72 ±  3%      -2.6        3.17 ±  4%  perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      5.51 ±  3%      -2.5        3.03 ±  4%  perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      3.34 ±  5%      -2.1        1.28 ± 19%  perf-profile.calltrace.cycles-pp.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock
      3.24 ±  5%      -2.0        1.24 ± 19%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function.__wake_up_common
      2.99 ±  5%      -1.9        1.13 ± 19%  perf-profile.calltrace.cycles-pp.select_idle_sibling.select_task_rq_fair.select_task_rq.try_to_wake_up.autoremove_wake_function
      1.08 ±  5%      -0.8        0.28 ±100%  perf-profile.calltrace.cycles-pp.switch_mm_irqs_off.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      1.21 ±  5%      -0.6        0.57 ± 11%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.87 ± 19%      -0.6        0.31 ±100%  perf-profile.calltrace.cycles-pp.available_idle_cpu.select_idle_cpu.select_idle_sibling.select_task_rq_fair.select_task_rq
      1.41 ±  3%      -0.4        0.98 ±  7%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.secondary_startup_64_no_verify
      1.43 ±  2%      -0.4        1.00 ±  6%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      1.41 ±  3%      -0.4        0.98 ±  6%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.secondary_startup_64_no_verify
      0.55 ±  7%      +0.2        0.71 ±  5%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.core_sys_select.kern_select.__x64_sys_select.do_syscall_64
      0.99 ±  8%      +0.2        1.16 ±  7%  perf-profile.calltrace.cycles-pp._copy_from_user.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.59 ±  9%      +0.2        0.78 ±  7%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter.pipe_write.new_sync_write.vfs_write
      0.80 ±  9%      +0.2        1.05 ±  7%  perf-profile.calltrace.cycles-pp.select_estimate_accuracy.do_select.core_sys_select.kern_select.__x64_sys_select
      0.76 ±  8%      +0.3        1.02 ±  7%  perf-profile.calltrace.cycles-pp._copy_to_user.poll_select_finish.kern_select.__x64_sys_select.do_syscall_64
      0.82 ± 10%      +0.3        1.08 ±  8%  perf-profile.calltrace.cycles-pp._copy_from_user.core_sys_select.kern_select.__x64_sys_select.do_syscall_64
      1.31 ±  4%      +0.3        1.59 ±  2%  perf-profile.calltrace.cycles-pp.stress_fifo
      0.36 ± 70%      +0.3        0.66 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get_ts64.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.34 ± 70%      +0.3        0.64 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get_ts64.select_estimate_accuracy.do_select.core_sys_select.kern_select
      0.36 ± 71%      +0.3        0.67 ±  7%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copyin.copy_page_from_iter.pipe_write.new_sync_write
      0.35 ± 70%      +0.3        0.67 ±  7%  perf-profile.calltrace.cycles-pp.ktime_get_ts64.poll_select_finish.kern_select.__x64_sys_select.do_syscall_64
      1.49 ± 10%      +0.4        1.87 ±  8%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.pipe_read.new_sync_read.vfs_read.ksys_read
      1.29 ±  9%      +0.4        1.71 ±  7%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.pipe_write.new_sync_write.vfs_write.ksys_write
      0.17 ±141%      +0.5        0.62 ±  7%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_to_user.poll_select_finish.kern_select.__x64_sys_select
      0.86 ± 16%      +0.5        1.32 ± 11%  perf-profile.calltrace.cycles-pp.mutex_lock.pipe_write.new_sync_write.vfs_write.ksys_write
      0.36 ± 70%      +0.5        0.84 ± 35%  perf-profile.calltrace.cycles-pp.__entry_text_start.write
      0.09 ±223%      +0.5        0.58 ±  7%  perf-profile.calltrace.cycles-pp.__fsnotify_parent.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.36 ± 71%      +0.5        0.86 ± 36%  perf-profile.calltrace.cycles-pp.__entry_text_start.read
      0.36 ± 70%      +0.5        0.86 ± 35%  perf-profile.calltrace.cycles-pp.__entry_text_start.select
      0.09 ±223%      +0.5        0.60 ±  6%  perf-profile.calltrace.cycles-pp.touch_atime.pipe_read.new_sync_read.vfs_read.ksys_read
      0.19 ±142%      +0.5        0.72 ±  3%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.try_to_wake_up.pollwake.__wake_up_common.__wake_up_common_lock
      0.09 ±223%      +0.5        0.62 ±  9%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.core_sys_select.kern_select.__x64_sys_select
      1.63 ±  8%      +0.5        2.15 ±  7%  perf-profile.calltrace.cycles-pp.poll_select_finish.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.51 ±  9%      +0.5        2.05 ±  7%  perf-profile.calltrace.cycles-pp.memset_erms.core_sys_select.kern_select.__x64_sys_select.do_syscall_64
      0.09 ±223%      +0.5        0.63 ±  7%  perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string._copy_from_user.kern_select.__x64_sys_select.do_syscall_64
      0.00            +0.5        0.54 ±  4%  perf-profile.calltrace.cycles-pp.security_file_permission.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ±223%      +0.6        0.69 ± 13%  perf-profile.calltrace.cycles-pp.mutex_unlock.pipe_write.new_sync_write.vfs_write.ksys_write
     22.08 ±  5%      +4.8       26.90 ±  6%  perf-profile.calltrace.cycles-pp.do_select.core_sys_select.kern_select.__x64_sys_select.do_syscall_64
     26.20 ±  4%      +6.2       32.36 ±  4%  perf-profile.calltrace.cycles-pp.core_sys_select.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe
     30.07 ±  3%      +7.2       37.31 ±  3%  perf-profile.calltrace.cycles-pp.kern_select.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe.select
     30.28 ±  3%      +7.2       37.52 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_select.do_syscall_64.entry_SYSCALL_64_after_hwframe.select
     30.92 ±  3%      +7.4       38.29 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.select
     31.20 ±  3%      +7.5       38.66 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.select
     33.41 ±  3%      +8.2       41.66 ±  2%  perf-profile.calltrace.cycles-pp.select
     29.32 ±  4%      -8.6       20.76 ± 12%  perf-profile.children.cycles-pp.read
     11.29 ± 10%      -6.9        4.40 ± 22%  perf-profile.children.cycles-pp.autoremove_wake_function
     24.00 ±  8%      -6.3       17.74 ±  9%  perf-profile.children.cycles-pp.schedule
     24.16 ±  8%      -6.2       18.00 ±  9%  perf-profile.children.cycles-pp.__schedule
     17.57 ±  5%      -5.7       11.91 ± 14%  perf-profile.children.cycles-pp.pipe_read
     18.03 ±  5%      -5.6       12.44 ± 13%  perf-profile.children.cycles-pp.new_sync_read
     19.78 ±  4%      -5.3       14.52 ± 12%  perf-profile.children.cycles-pp.vfs_read
     20.17 ±  4%      -5.1       15.03 ± 12%  perf-profile.children.cycles-pp.ksys_read
      7.09 ±  3%      -2.8        4.34 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      6.02 ±  3%      -2.7        3.33 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      7.58 ±  3%      -2.6        5.00 ±  3%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      6.24 ±  8%      -1.5        4.72 ± 13%  perf-profile.children.cycles-pp.select_task_rq
      6.06 ±  8%      -1.5        4.56 ± 14%  perf-profile.children.cycles-pp.select_task_rq_fair
      5.61 ±  9%      -1.4        4.20 ± 14%  perf-profile.children.cycles-pp.select_idle_sibling
      2.31 ±  6%      -1.2        1.07 ±  6%  perf-profile.children.cycles-pp.prepare_task_switch
      3.63 ±  4%      -1.1        2.54 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      4.55 ±  6%      -1.1        3.47 ±  9%  perf-profile.children.cycles-pp.update_load_avg
      1.95 ±  8%      -1.0        0.98 ± 12%  perf-profile.children.cycles-pp.available_idle_cpu
      3.06 ±  5%      -0.9        2.16 ±  8%  perf-profile.children.cycles-pp.update_curr
      3.70 ±  3%      -0.8        2.88 ±  7%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      1.24 ±  5%      -0.7        0.59 ±  4%  perf-profile.children.cycles-pp.ttwu_do_wakeup
      1.18 ±  5%      -0.6        0.53 ±  3%  perf-profile.children.cycles-pp.check_preempt_curr
      1.01 ±  6%      -0.6        0.40 ±  4%  perf-profile.children.cycles-pp.check_preempt_wakeup
      1.59 ±  5%      -0.5        1.08 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_se
      1.38 ±  5%      -0.5        0.87 ±  8%  perf-profile.children.cycles-pp.update_rq_clock
      1.61 ±  7%      -0.5        1.13 ± 10%  perf-profile.children.cycles-pp.reweight_entity
      0.79 ±  2%      -0.4        0.35 ± 17%  perf-profile.children.cycles-pp.cpuidle_idle_call
      1.43 ±  2%      -0.4        1.00 ±  6%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      1.43 ±  2%      -0.4        1.00 ±  6%  perf-profile.children.cycles-pp.cpu_startup_entry
      1.43 ±  2%      -0.4        1.00 ±  6%  perf-profile.children.cycles-pp.do_idle
      1.57 ±  5%      -0.4        1.16 ±  7%  perf-profile.children.cycles-pp.set_next_entity
      1.03 ±  6%      -0.4        0.63 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.70 ±  2%      -0.4        0.30 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter
      0.70 ±  2%      -0.4        0.30 ± 18%  perf-profile.children.cycles-pp.cpuidle_enter_state
      1.27 ±  6%      -0.4        0.89 ±  8%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.62 ±  7%      -0.4        0.26 ± 20%  perf-profile.children.cycles-pp.prepare_to_wait_event
      0.62 ±  2%      -0.4        0.26 ± 17%  perf-profile.children.cycles-pp.intel_idle
      0.62 ±  2%      -0.4        0.26 ± 17%  perf-profile.children.cycles-pp.mwait_idle_with_hints
      1.38 ±  4%      -0.4        1.03 ±  7%  perf-profile.children.cycles-pp.__switch_to_asm
      2.05 ±  5%      -0.3        1.70 ±  9%  perf-profile.children.cycles-pp.dequeue_entity
      1.42 ±  2%      -0.3        1.08 ±  6%  perf-profile.children.cycles-pp.__switch_to
      0.70 ±  3%      -0.2        0.48 ±  3%  perf-profile.children.cycles-pp.finish_task_switch
      0.64 ±  2%      -0.2        0.42 ±  5%  perf-profile.children.cycles-pp.put_prev_entity
      0.31 ±  6%      -0.2        0.14 ±  7%  perf-profile.children.cycles-pp.resched_curr
      0.79 ±  4%      -0.1        0.66 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.50            -0.1        0.37 ±  6%  perf-profile.children.cycles-pp.__wrgsbase_inactive
      0.48 ±  2%      -0.1        0.36 ±  7%  perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.74 ±  3%      -0.1        0.63 ±  9%  perf-profile.children.cycles-pp.switch_fpu_return
      0.24 ± 29%      -0.1        0.14 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.18 ± 20%      -0.1        0.09 ± 16%  perf-profile.children.cycles-pp.get_nohz_timer_target
      0.46 ±  6%      -0.1        0.37 ± 10%  perf-profile.children.cycles-pp.update_min_vruntime
      0.36 ±  3%      -0.1        0.27 ±  6%  perf-profile.children.cycles-pp.pick_next_entity
      0.32 ±  2%      -0.1        0.24 ±  5%  perf-profile.children.cycles-pp.__rdgsbase_inactive
      0.18 ± 10%      -0.1        0.10 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.35 ±  6%      -0.1        0.28 ±  8%  perf-profile.children.cycles-pp.cpumask_next
      0.43 ±  3%      -0.1        0.36 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.41 ±  6%      -0.1        0.34 ± 10%  perf-profile.children.cycles-pp.__calc_delta
      0.29 ±  5%      -0.1        0.23 ±  9%  perf-profile.children.cycles-pp.__cgroup_account_cputime
      0.41 ±  5%      -0.1        0.35 ± 10%  perf-profile.children.cycles-pp.perf_tp_event
      0.17 ±  4%      -0.1        0.11 ±  6%  perf-profile.children.cycles-pp.clear_buddies
      0.13 ± 11%      -0.1        0.08 ± 16%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.29 ±  4%      -0.1        0.24 ± 10%  perf-profile.children.cycles-pp.perf_trace_sched_stat_runtime
      0.11 ± 23%      -0.1        0.06 ±  8%  perf-profile.children.cycles-pp.switch_ldt
      0.20 ±  3%      -0.0        0.16 ±  8%  perf-profile.children.cycles-pp.perf_trace_sched_switch
      0.20 ±  7%      -0.0        0.16 ± 12%  perf-profile.children.cycles-pp.set_next_buddy
      0.12 ±  8%      -0.0        0.08 ± 17%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.11 ±  9%      -0.0        0.07 ± 18%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.22 ±  6%      -0.0        0.19 ± 11%  perf-profile.children.cycles-pp.perf_trace_buf_update
      0.06 ±  6%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.perf_swevent_event
      0.12 ±  4%      -0.0        0.09 ±  7%  perf-profile.children.cycles-pp.schedule_debug
      0.14 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.08 ±  4%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.perf_exclude_event
      0.11 ±  6%      -0.0        0.09 ±  5%  perf-profile.children.cycles-pp.rb_next
      0.08 ±  4%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.rcu_note_context_switch
      0.13 ±  4%      -0.0        0.11 ±  7%  perf-profile.children.cycles-pp.perf_trace_buf_alloc
      0.06 ±  6%      -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.cr4_update_irqsoff
      0.09 ±  4%      -0.0        0.07 ±  9%  perf-profile.children.cycles-pp.perf_trace_run_bpf_submit
      0.08 ± 10%      +0.0        0.10 ±  8%  perf-profile.children.cycles-pp.timespec64_add_safe
      0.10 ±  9%      +0.0        0.12 ±  8%  perf-profile.children.cycles-pp.set_normalized_timespec64
      0.08 ±  4%      +0.0        0.11 ±  5%  perf-profile.children.cycles-pp.__x64_sys_write
      0.15 ±  8%      +0.0        0.19 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_safe_stack
      0.12 ±  9%      +0.0        0.15 ±  8%  perf-profile.children.cycles-pp.rw_verify_area
      0.14 ±  9%      +0.0        0.18 ±  4%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.14 ±  8%      +0.0        0.19 ±  7%  perf-profile.children.cycles-pp.check_stack_object
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__fdget
      0.02 ±142%      +0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__bitmap_andnot
      0.16 ±  9%      +0.1        0.22 ±  6%  perf-profile.children.cycles-pp.memset
      0.11 ± 11%      +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.fsnotify_perm
      0.39 ±  3%      +0.1        0.46 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      0.44 ±  3%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.23 ±  8%      +0.1        0.30 ±  6%  perf-profile.children.cycles-pp.aa_file_perm
      0.36 ±  3%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.36 ±  4%      +0.1        0.43 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.25 ±  7%      +0.1        0.33 ±  6%  perf-profile.children.cycles-pp.rcu_all_qs
      0.23 ±  3%      +0.1        0.32 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.20 ±  3%      +0.1        0.28 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.15 ±  2%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.scheduler_tick
      0.18 ±  2%      +0.1        0.26 ±  8%  perf-profile.children.cycles-pp.update_process_times
      0.18 ±  2%      +0.1        0.27 ±  8%  perf-profile.children.cycles-pp.tick_sched_handle
      0.59 ±  3%      +0.1        0.68 ±  3%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.12 ±  6%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.task_tick_fair
      0.24 ± 15%      +0.1        0.35 ± 12%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.40 ±  8%      +0.1        0.53 ±  5%  perf-profile.children.cycles-pp.atime_needs_update
      0.34 ± 10%      +0.1        0.47 ± 10%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.37 ±  8%      +0.1        0.50 ±  5%  perf-profile.children.cycles-pp.file_update_time
      0.38 ±  9%      +0.1        0.51 ±  6%  perf-profile.children.cycles-pp.__check_object_size
      1.21 ±  5%      +0.1        1.35 ±  4%  perf-profile.children.cycles-pp.security_file_permission
      0.40 ±  8%      +0.1        0.54 ±  5%  perf-profile.children.cycles-pp.current_time
      0.49 ±  8%      +0.2        0.65 ±  6%  perf-profile.children.cycles-pp.touch_atime
      0.51 ±  9%      +0.2        0.66 ±  4%  perf-profile.children.cycles-pp.__fdget_pos
      0.55 ±  8%      +0.2        0.70 ±  6%  perf-profile.children.cycles-pp.__cond_resched
      0.77 ±  7%      +0.2        0.94 ±  5%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.62 ±  8%      +0.2        0.81 ±  7%  perf-profile.children.cycles-pp.copyin
      0.67 ±  9%      +0.2        0.87 ±  7%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.82 ±  5%      +0.2        1.03        perf-profile.children.cycles-pp.__fget_light
      0.84 ±  9%      +0.3        1.10 ±  7%  perf-profile.children.cycles-pp.select_estimate_accuracy
      0.77 ± 10%      +0.3        1.03 ±  8%  perf-profile.children.cycles-pp.__might_sleep
      0.81 ±  8%      +0.3        1.08 ±  6%  perf-profile.children.cycles-pp._copy_to_user
      1.39 ±  4%      +0.3        1.68 ±  2%  perf-profile.children.cycles-pp.stress_fifo
      1.01 ±  9%      +0.3        1.33 ±  7%  perf-profile.children.cycles-pp.read_tsc
      1.57 ± 10%      +0.4        1.97 ±  8%  perf-profile.children.cycles-pp.copy_page_to_iter
      1.37 ±  9%      +0.4        1.79 ±  7%  perf-profile.children.cycles-pp.__might_fault
      1.35 ±  9%      +0.4        1.79 ±  7%  perf-profile.children.cycles-pp.copy_page_from_iter
      1.35 ±  8%      +0.4        1.80 ±  6%  perf-profile.children.cycles-pp.__might_resched
      1.90 ±  9%      +0.5        2.37 ±  7%  perf-profile.children.cycles-pp._copy_from_user
      1.74 ±  8%      +0.5        2.22 ±  7%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      1.56 ±  9%      +0.5        2.05 ±  7%  perf-profile.children.cycles-pp.ktime_get_ts64
      1.54 ±  9%      +0.5        2.04 ±  7%  perf-profile.children.cycles-pp.__entry_text_start
      1.68 ±  8%      +0.5        2.23 ±  7%  perf-profile.children.cycles-pp.poll_select_finish
      1.58 ±  9%      +0.6        2.14 ±  7%  perf-profile.children.cycles-pp.memset_erms
      1.91 ± 16%      +0.9        2.78 ± 11%  perf-profile.children.cycles-pp.mutex_lock
      3.45 ±  9%      +1.0        4.44 ±  7%  perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
     22.20 ±  5%      +4.9       27.06 ±  6%  perf-profile.children.cycles-pp.do_select
     26.42 ±  3%      +6.2       32.66 ±  4%  perf-profile.children.cycles-pp.core_sys_select
     30.31 ±  3%      +7.2       37.56 ±  3%  perf-profile.children.cycles-pp.__x64_sys_select
     30.15 ±  3%      +7.3       37.41 ±  3%  perf-profile.children.cycles-pp.kern_select
     33.84 ±  3%      +8.2       42.03 ±  3%  perf-profile.children.cycles-pp.select
      1.89 ±  8%      -1.0        0.94 ± 12%  perf-profile.self.cycles-pp.available_idle_cpu
      1.30 ±  7%      -0.8        0.46 ±  7%  perf-profile.self.cycles-pp.prepare_task_switch
      3.64 ±  3%      -0.8        2.84 ±  7%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      1.36 ±  7%      -0.7        0.70 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock
      2.06 ±  4%      -0.6        1.48 ±  8%  perf-profile.self.cycles-pp.__schedule
      1.47 ±  5%      -0.5        0.99 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_se
      1.38 ±  5%      -0.5        0.91 ±  8%  perf-profile.self.cycles-pp.update_curr
      0.85 ±  6%      -0.4        0.42 ±  8%  perf-profile.self.cycles-pp.update_rq_clock
      0.80 ±  9%      -0.4        0.43 ± 11%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.90 ±  6%      -0.4        0.53 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
      1.21 ±  6%      -0.4        0.84 ±  8%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.61 ±  2%      -0.4        0.25 ± 18%  perf-profile.self.cycles-pp.mwait_idle_with_hints
      1.36 ±  4%      -0.3        1.01 ±  7%  perf-profile.self.cycles-pp.__switch_to_asm
      1.37 ±  3%      -0.3        1.04 ±  6%  perf-profile.self.cycles-pp.__switch_to
      0.82 ±  5%      -0.3        0.50 ±  6%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.75 ±  7%      -0.3        0.44 ±  9%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.75 ±  7%      -0.3        0.48 ± 10%  perf-profile.self.cycles-pp.reweight_entity
      0.77 ±  9%      -0.2        0.54 ± 12%  perf-profile.self.cycles-pp.select_idle_sibling
      0.38 ±  6%      -0.2        0.17 ±  4%  perf-profile.self.cycles-pp.check_preempt_wakeup
      0.44 ±  4%      -0.2        0.27 ±  5%  perf-profile.self.cycles-pp.finish_task_switch
      0.30 ±  7%      -0.2        0.13 ±  6%  perf-profile.self.cycles-pp.resched_curr
      0.71 ±  5%      -0.2        0.55 ±  9%  perf-profile.self.cycles-pp.enqueue_entity
      0.48 ±  2%      -0.1        0.36 ±  7%  perf-profile.self.cycles-pp.__wrgsbase_inactive
      0.47 ±  2%      -0.1        0.36 ±  6%  perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.20 ±  6%      -0.1        0.09 ± 18%  perf-profile.self.cycles-pp.prepare_to_wait_event
      0.18 ± 19%      -0.1        0.08 ± 17%  perf-profile.self.cycles-pp.get_nohz_timer_target
      0.32 ±  4%      -0.1        0.22 ±  5%  perf-profile.self.cycles-pp.set_next_entity
      0.39 ±  6%      -0.1        0.30 ± 10%  perf-profile.self.cycles-pp.dequeue_entity
      0.38 ±  6%      -0.1        0.29 ±  9%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.31 ±  2%      -0.1        0.22 ±  6%  perf-profile.self.cycles-pp.__rdgsbase_inactive
      0.22 ±  3%      -0.1        0.14 ±  5%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.42 ±  4%      -0.1        0.34 ±  7%  perf-profile.self.cycles-pp.schedule
      0.30 ±  5%      -0.1        0.22 ±  3%  perf-profile.self.cycles-pp.switch_fpu_return
      0.39 ±  7%      -0.1        0.31 ± 10%  perf-profile.self.cycles-pp.update_min_vruntime
      0.31 ±  4%      -0.1        0.23 ±  6%  perf-profile.self.cycles-pp.pick_next_entity
      0.38 ±  2%      -0.1        0.32 ±  6%  perf-profile.self.cycles-pp.__list_add_valid
      0.10 ± 28%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.switch_ldt
      0.38 ±  5%      -0.1        0.32 ± 10%  perf-profile.self.cycles-pp.__calc_delta
      0.13 ±  4%      -0.1        0.08 ±  7%  perf-profile.self.cycles-pp.clear_buddies
      0.19 ±  4%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_switch
      0.20            -0.0        0.15 ±  4%  perf-profile.self.cycles-pp.put_prev_entity
      0.27 ±  4%      -0.0        0.22 ± 11%  perf-profile.self.cycles-pp.perf_trace_sched_stat_runtime
      0.18 ±  3%      -0.0        0.14 ± 11%  perf-profile.self.cycles-pp.__cgroup_account_cputime
      0.20 ±  6%      -0.0        0.17 ±  8%  perf-profile.self.cycles-pp.perf_tp_event
      0.17 ±  5%      -0.0        0.14 ±  7%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.14 ±  5%      -0.0        0.11 ±  9%  perf-profile.self.cycles-pp.check_preempt_curr
      0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.perf_exclude_event
      0.11 ±  6%      -0.0        0.09 ± 10%  perf-profile.self.cycles-pp.cpumask_next
      0.11 ±  4%      -0.0        0.08 ±  8%  perf-profile.self.cycles-pp.schedule_debug
      0.15 ±  3%      -0.0        0.13 ±  8%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.09 ±  5%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.rb_next
      0.08 ±  4%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.perf_trace_run_bpf_submit
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.memset
      0.06 ± 11%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp.timespec64_add_safe
      0.06 ±  9%      +0.0        0.08 ±  7%  perf-profile.self.cycles-pp.__x64_sys_write
      0.04 ± 44%      +0.0        0.06 ±  7%  perf-profile.self.cycles-pp.copyin
      0.07 ±  8%      +0.0        0.10 ±  8%  perf-profile.self.cycles-pp.set_normalized_timespec64
      0.04 ± 45%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.copyout
      0.10 ±  9%      +0.0        0.13 ±  9%  perf-profile.self.cycles-pp.touch_atime
      0.09 ±  9%      +0.0        0.12 ±  8%  perf-profile.self.cycles-pp.remove_wait_queue
      0.09 ±  7%      +0.0        0.12 ±  5%  perf-profile.self.cycles-pp.rw_verify_area
      0.10 ±  6%      +0.0        0.13 ±  8%  perf-profile.self.cycles-pp.__fdget_pos
      0.14 ±  7%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.11 ±  8%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp._copy_to_user
      0.12 ±  9%      +0.0        0.16 ±  4%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.12 ±  8%      +0.0        0.16 ±  7%  perf-profile.self.cycles-pp.check_stack_object
      0.16 ±  9%      +0.0        0.20 ±  7%  perf-profile.self.cycles-pp.ksys_read
      0.14 ± 11%      +0.0        0.18 ±  7%  perf-profile.self.cycles-pp.poll_freewait
      0.14 ±  7%      +0.0        0.18 ±  6%  perf-profile.self.cycles-pp.rcu_all_qs
      0.02 ±142%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__bitmap_andnot
      0.17 ±  8%      +0.1        0.23 ±  6%  perf-profile.self.cycles-pp.file_update_time
      0.10 ± 12%      +0.1        0.16 ±  6%  perf-profile.self.cycles-pp.fsnotify_perm
      0.19 ± 10%      +0.1        0.25 ±  6%  perf-profile.self.cycles-pp.atime_needs_update
      0.28 ±  9%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.__might_fault
      0.20 ± 10%      +0.1        0.27 ±  6%  perf-profile.self.cycles-pp.aa_file_perm
      0.17 ± 12%      +0.1        0.24 ±  9%  perf-profile.self.cycles-pp.ksys_write
      0.36 ±  5%      +0.1        0.43 ±  3%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.20 ±  9%      +0.1        0.27 ±  8%  perf-profile.self.cycles-pp.__check_object_size
      0.29 ±  9%      +0.1        0.38 ±  7%  perf-profile.self.cycles-pp.select_estimate_accuracy
      0.25 ±  8%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.current_time
      0.54 ±  7%      +0.1        0.62 ±  5%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.81 ±  4%      +0.1        0.90 ±  3%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.24 ± 10%      +0.1        0.34 ±  6%  perf-profile.self.cycles-pp.new_sync_write
      0.34 ±  8%      +0.1        0.43 ±  7%  perf-profile.self.cycles-pp.poll_select_finish
      0.30 ±  9%      +0.1        0.40 ±  6%  perf-profile.self.cycles-pp.copy_page_from_iter
      0.31 ±  8%      +0.1        0.41 ±  6%  perf-profile.self.cycles-pp.__cond_resched
      0.20 ± 17%      +0.1        0.31 ± 13%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.30 ±  7%      +0.1        0.40 ±  5%  perf-profile.self.cycles-pp.new_sync_read
      0.42 ±  9%      +0.1        0.54 ±  8%  perf-profile.self.cycles-pp.vfs_read
      0.29 ± 11%      +0.1        0.41 ± 11%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.39 ±  9%      +0.1        0.50 ±  7%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.36 ± 10%      +0.1        0.47 ±  7%  perf-profile.self.cycles-pp.vfs_write
      0.50 ±  8%      +0.1        0.62 ±  6%  perf-profile.self.cycles-pp.read
      0.51 ±  6%      +0.1        0.65 ±  5%  perf-profile.self.cycles-pp.select
      0.46 ±  6%      +0.1        0.59 ±  3%  perf-profile.self.cycles-pp.kern_select
      0.41 ±  9%      +0.1        0.54 ±  6%  perf-profile.self.cycles-pp.__entry_text_start
      0.51 ±  6%      +0.1        0.65 ±  4%  perf-profile.self.cycles-pp.write
      0.25 ± 14%      +0.2        0.41 ±  3%  perf-profile.self.cycles-pp.pollwake
      0.56 ±  8%      +0.2        0.73 ±  8%  perf-profile.self.cycles-pp.ktime_get_ts64
      0.38 ± 11%      +0.2        0.55 ±  7%  perf-profile.self.cycles-pp.pipe_poll
      0.63 ±  7%      +0.2        0.82 ±  6%  perf-profile.self.cycles-pp.core_sys_select
      0.78 ±  5%      +0.2        0.98 ±  2%  perf-profile.self.cycles-pp.__fget_light
      0.61 ±  9%      +0.2        0.81 ±  7%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.64 ± 10%      +0.2        0.85 ±  8%  perf-profile.self.cycles-pp.__might_sleep
      1.22 ±  5%      +0.3        1.51 ±  2%  perf-profile.self.cycles-pp.stress_fifo
      0.97 ±  9%      +0.3        1.28 ±  7%  perf-profile.self.cycles-pp.read_tsc
      1.20 ±  8%      +0.4        1.60 ±  6%  perf-profile.self.cycles-pp.__might_resched
      1.73 ±  8%      +0.5        2.22 ±  7%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      1.52 ±  9%      +0.5        2.06 ±  7%  perf-profile.self.cycles-pp.memset_erms
      1.96 ±  3%      +0.5        2.50 ±  2%  perf-profile.self.cycles-pp.do_select
      1.34 ± 20%      +0.7        2.02 ± 12%  perf-profile.self.cycles-pp.mutex_lock
      3.32 ±  9%      +1.0        4.27 ±  7%  perf-profile.self.cycles-pp.copy_user_enhanced_fast_string





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.18.0-rc1-00004-g6b433275e3a3"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.18.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-11 (Debian 11.2.0-20) 11.2.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=110200
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23800
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23800
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
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
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
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
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
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
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_BPF_UNPRIV_DEFAULT_OFF=y
# CONFIG_BPF_PRELOAD is not set
# CONFIG_BPF_LSM is not set
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
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
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
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
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
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_MISC is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
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
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
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
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_GUEST_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
CONFIG_SHUFFLE_PAGE_ALLOCATOR=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
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
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_HAVE_INTEL_TXT=y
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
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_CC_HAS_SLS=y
# CONFIG_SLS is not set
# CONFIG_X86_CPU_RESCTRL is not set
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
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
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
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
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
# CONFIG_X86_MCE_AMD is not set
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=m
CONFIG_PERF_EVENTS_INTEL_RAPL=m
CONFIG_PERF_EVENTS_INTEL_CSTATE=m
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
# CONFIG_AMD_NUMA is not set
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
# CONFIG_X86_KERNEL_IBT is not set
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
# CONFIG_PM_ADVANCED_DEBUG is not set
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_PM_TRACE_RTC is not set
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
CONFIG_ACPI_TAD=m
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=m
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
# CONFIG_ACPI_CUSTOM_METHOD is not set
CONFIG_ACPI_BGRT=y
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
CONFIG_ACPI_PCC=y
CONFIG_PMIC_OPREGION=y
CONFIG_X86_PM_TIMER=y
CONFIG_ACPI_PRMT=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
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
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32_ABI is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_PFNCACHE=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_DIRTY_RING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_HAVE_KVM_PM_NOTIFIER=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
# CONFIG_KVM_AMD is not set
# CONFIG_KVM_XEN is not set
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
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_USER_RETURN_NOTIFIER=y
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
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
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
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
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
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_FC_APPID is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
# CONFIG_BLK_CGROUP_IOPRIO is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
CONFIG_BFQ_GROUP_IOSCHED=y
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
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
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MHP_MEMMAP_ON_MEMORY=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_DEVICE_MIGRATION=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_FRONTSWAP=y
# CONFIG_CMA is not set
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_SECRETMEM=y
# CONFIG_ANON_VMA_NAME is not set

#
# Data Access Monitoring
#
# CONFIG_DAMON is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
CONFIG_TLS_DEVICE=y
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
CONFIG_INET_ESP_OFFLOAD=m
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
CONFIG_INET_RAW_DIAG=m
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_NV=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
CONFIG_TCP_CONG_BBR=m
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_ESP_OFFLOAD=m
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
CONFIG_NETLABEL=y
# CONFIG_MPTCP is not set
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_EGRESS=y
CONFIG_NETFILTER_SKIP_EGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
# CONFIG_NETFILTER_NETLINK_HOOK is not set
# CONFIG_NETFILTER_NETLINK_ACCT is not set
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_SYSLOG=m
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
CONFIG_NF_CT_NETLINK_HELPER=m
CONFIG_NETFILTER_NETLINK_GLUE_CT=y
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
CONFIG_NFT_NUMGEN=m
CONFIG_NFT_CT=m
CONFIG_NFT_CONNLIMIT=m
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
CONFIG_NFT_QUOTA=m
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
CONFIG_NFT_FIB=m
CONFIG_NFT_FIB_INET=m
# CONFIG_NFT_XFRM is not set
CONFIG_NFT_SOCKET=m
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
CONFIG_NF_DUP_NETDEV=m
CONFIG_NFT_DUP_NETDEV=m
CONFIG_NFT_FWD_NETDEV=m
CONFIG_NFT_FIB_NETDEV=m
# CONFIG_NFT_REJECT_NETDEV is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y
CONFIG_NETFILTER_XTABLES_COMPAT=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
# CONFIG_NETFILTER_XT_TARGET_LED is not set
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
# CONFIG_NETFILTER_XT_MATCH_L2TP is not set
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
# CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
# CONFIG_NETFILTER_XT_MATCH_TIME is not set
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_FO=m
CONFIG_IP_VS_OVF=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m
# CONFIG_IP_VS_TWOS is not set

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
CONFIG_NFT_DUP_IPV4=m
CONFIG_NFT_FIB_IPV4=m
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=m
CONFIG_NF_LOG_ARP=m
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
# CONFIG_IP_NF_TARGET_CLUSTERIP is not set
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
CONFIG_NFT_DUP_IPV6=m
CONFIG_NFT_FIB_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
# CONFIG_IP6_NF_TARGET_HL is not set
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
CONFIG_NF_TABLES_BRIDGE=m
# CONFIG_NFT_BRIDGE_META is not set
CONFIG_NFT_BRIDGE_REJECT=m
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=y
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
CONFIG_TIPC=m
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=m
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
# CONFIG_6LOWPAN_NHC is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=y
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
CONFIG_NET_SCH_HHF=m
CONFIG_NET_SCH_PIE=m
# CONFIG_NET_SCH_FQ_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_ETS is not set
CONFIG_NET_SCH_DEFAULT=y
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="fq_codel"

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
# CONFIG_NET_ACT_CONNMARK is not set
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_GATE is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=y
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
# CONFIG_CAN_8DEV_USB is not set
# CONFIG_CAN_EMS_USB is not set
# CONFIG_CAN_ESD_USB2 is not set
# CONFIG_CAN_ETAS_ES58X is not set
# CONFIG_CAN_GS_USB is not set
# CONFIG_CAN_KVASER_USB is not set
# CONFIG_CAN_MCBA_USB is not set
# CONFIG_CAN_PEAK_USB is not set
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_MCTP is not set
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
# CONFIG_CFG80211_WEXT is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_PAGE_POOL=y
# CONFIG_PAGE_POOL_STATS is not set
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
CONFIG_PCIE_DPC=y
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_EDR is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
CONFIG_PCI_PF_STUB=m
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
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
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
# CONFIG_DEVTMPFS_SAFE is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
# CONFIG_APPLE_PROPERTIES is not set
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
# CONFIG_NVME_VERBOSE_ERRORS is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_MISC_RTSX=m
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
# CONFIG_INTEL_MEI_PXP is not set
CONFIG_VMWARE_VMCI=m
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_BCM_VK is not set
# CONFIG_MISC_ALCOR_PCI is not set
CONFIG_MISC_RTSX_PCI=m
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_MPI3MR is not set
# CONFIG_SCSI_SMARTPQI is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_FC is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_EFCT is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
# CONFIG_PATA_CMD64X is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
CONFIG_MD_CLUSTER=m
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
CONFIG_DM_WRITECACHE=m
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
CONFIG_DM_INTEGRITY=m
CONFIG_DM_AUDIT=y
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_ISCSI_TARGET=m
# CONFIG_SBP_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_IFB is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_AMT is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_NET_VRF is not set
# CONFIG_VSOCKMON is not set
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
CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
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
# CONFIG_ENA_ETHERNET is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
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
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DM9051 is not set
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
CONFIG_NET_VENDOR_FUNGIBLE=y
# CONFIG_FUN_ETH is not set
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_IXGBEVF is not set
CONFIG_I40E=y
# CONFIG_I40E_DCB is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
CONFIG_IGC=y
CONFIG_NET_VENDOR_MICROSOFT=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
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
# CONFIG_NFP is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
# CONFIG_NE2K_PCI is not set
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
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
# CONFIG_ROCKER is not set
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
# CONFIG_MSE102X is not set
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
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MARVELL_88X2222_PHY is not set
# CONFIG_MAXLINEAR_GPHY is not set
# CONFIG_MEDIATEK_GE_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_MOTORCOMM_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_C45_TJA11XX_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
# CONFIG_USB_NET_CDCETHER is not set
# CONFIG_USB_NET_CDC_EEM is not set
# CONFIG_USB_NET_CDC_NCM is not set
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
# CONFIG_USB_NET_SMSC75XX is not set
# CONFIG_USB_NET_SMSC95XX is not set
# CONFIG_USB_NET_GL620A is not set
# CONFIG_USB_NET_NET1080 is not set
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
# CONFIG_USB_NET_CDC_SUBSET is not set
# CONFIG_USB_NET_ZAURUS is not set
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_HSO is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
# CONFIG_ATH9K is not set
# CONFIG_ATH9K_HTC is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
# CONFIG_IWL4965 is not set
# CONFIG_IWL3945 is not set
# CONFIG_IWLWIFI is not set
# CONFIG_IWLMEI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
# CONFIG_WLAN_VENDOR_MEDIATEK is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
CONFIG_RTL_CARDS=m
# CONFIG_RTL8192CE is not set
# CONFIG_RTL8192SE is not set
# CONFIG_RTL8192DE is not set
# CONFIG_RTL8723AE is not set
# CONFIG_RTL8723BE is not set
# CONFIG_RTL8188EE is not set
# CONFIG_RTL8192EE is not set
# CONFIG_RTL8821AE is not set
# CONFIG_RTL8192CU is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
# CONFIG_RTW89 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
# CONFIG_MAC80211_HWSIM is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=m
# CONFIG_IEEE802154_FAKELB is not set
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
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
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=m
CONFIG_MOUSE_ELAN_I2C=m
CONFIG_MOUSE_ELAN_I2C_I2C=y
CONFIG_MOUSE_ELAN_I2C_SMBUS=y
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
CONFIG_RMI4_SPI=m
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=64
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK_GT=m
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
# CONFIG_TCG_TIS_I2C_CR50 is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
CONFIG_I2C_DESIGNWARE_BAYTRAIL=y
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_CP2615 is not set
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
# CONFIG_I2C_VIRTIO is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y
# CONFIG_DP83640_PHY is not set
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
# CONFIG_GPIO_AGGREGATOR is not set
# CONFIG_GPIO_MOCKUP is not set
# CONFIG_GPIO_VIRTIO is not set
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_IP5XXX_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SAMSUNG_SDI is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX77976 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
# CONFIG_CHARGER_BQ256XX is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_BATTERY_GOLDFISH is not set
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
# CONFIG_BATTERY_UG3105 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AHT10 is not set
# CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_CORSAIR_PSU is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
# CONFIG_SENSORS_DELL_SMM is not set
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_I5500=m
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_MLXREG_FAN is not set
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_TPS23861 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_NZXT_KRAKEN2 is not set
# CONFIG_SENSORS_NZXT_SMART2 is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_BPA_RS600 is not set
# CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
# CONFIG_SENSORS_FSP_3Y is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_DPS920AB is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR36021 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
# CONFIG_SENSORS_MAX15301 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2888 is not set
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_MP5023 is not set
# CONFIG_SENSORS_PIM4328 is not set
# CONFIG_SENSORS_PLI1209BC is not set
# CONFIG_SENSORS_PM6764TR is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_Q54SJ108A2 is not set
# CONFIG_SENSORS_STPDDC60 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
# CONFIG_SENSORS_SBTSI is not set
# CONFIG_SENSORS_SBRMI is not set
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
# CONFIG_SENSORS_SY7636A is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP464 is not set
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
# CONFIG_SENSORS_ASUS_WMI is not set
# CONFIG_SENSORS_ASUS_WMI_EC is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=m
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_MLX_WDT is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=m
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SIMPLE_MFD_I2C is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_ATC260X_I2C is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_LIRC=y
CONFIG_RC_MAP=m
CONFIG_RC_DECODERS=y
CONFIG_IR_IMON_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_IR_SANYO_DECODER=m
# CONFIG_IR_SHARP_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_IR_ENE=m
CONFIG_IR_FINTEK=m
# CONFIG_IR_IGORPLUGUSB is not set
# CONFIG_IR_IGUANA is not set
# CONFIG_IR_IMON is not set
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_ITE_CIR=m
# CONFIG_IR_MCEUSB is not set
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SERIAL=m
CONFIG_IR_SERIAL_TRANSMITTER=y
# CONFIG_IR_STREAMZAP is not set
# CONFIG_IR_TOY is not set
# CONFIG_IR_TTUSBIR is not set
CONFIG_IR_WINBOND_CIR=m
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_RC_LOOPBACK is not set
# CONFIG_RC_XBOX_DVD is not set

#
# CEC support
#
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=m
CONFIG_MEDIA_SUPPORT_FILTER=y
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_PLATFORM_SUPPORT is not set
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
# end of Media drivers

CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=y

#
# Media ancillary drivers
#
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_INTEL_GTT=m
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_DP_HELPER=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_BUDDY=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=m

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
# CONFIG_DRM_I915_GVT_KVMGT is not set
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# CONFIG_DRM_VGEM is not set
# CONFIG_DRM_VKMS is not set
# CONFIG_DRM_VMWGFX is not set
CONFIG_DRM_GMA500=m
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_BOCHS=m
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_DRM_PANEL_MIPI_DBI is not set
# CONFIG_DRM_SIMPLEDRM is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9163 is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_GUD is not set
# CONFIG_DRM_SSD130X is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_NOMODESET=y
CONFIG_DRM_PRIVACY_SCREEN=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
# CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=m
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_CMEDIA=m
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=m
# CONFIG_HID_FT260 is not set
CONFIG_HID_GEMBIRD=m
CONFIG_HID_GFRM=m
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
# CONFIG_HID_UCLOGIC is not set
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
CONFIG_HID_JABRA=m
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LETSKETCH is not set
CONFIG_HID_LOGITECH=m
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=m
CONFIG_HID_MONTEREY=m
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NINTENDO is not set
CONFIG_HID_NTI=m
# CONFIG_HID_NTRIG is not set
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_RAZER is not set
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
# CONFIG_HID_SEMITEK is not set
# CONFIG_HID_SIGMAMICRO is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set
# end of USB HID support

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=m
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
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS_SUPPORT is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
# CONFIG_USB_SERIAL_ARK3116 is not set
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_CH341 is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
# CONFIG_USB_SERIAL_GARMIN is not set
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_METRO is not set
# CONFIG_USB_SERIAL_MOS7720 is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
# CONFIG_USB_SERIAL_MXUPORT is not set
# CONFIG_USB_SERIAL_NAVMAN is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_OTI6858 is not set
# CONFIG_USB_SERIAL_QCAUX is not set
# CONFIG_USB_SERIAL_QUALCOMM is not set
# CONFIG_USB_SERIAL_SPCP8X5 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
# CONFIG_USB_SERIAL_SYMBOL is not set
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_OPTION is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
# CONFIG_USB_SERIAL_UPD78F0730 is not set
# CONFIG_USB_SERIAL_XR is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_APPLE_MFI_FASTCHARGE is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HUB_USB251XB is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_RT1719 is not set
# CONFIG_TYPEC_STUSB160X is not set
# CONFIG_TYPEC_WUSB3801 is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_REALTEK_PCI is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
CONFIG_LEDS_LT3593=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
CONFIG_LEDS_MLXCPLD=m
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# Flash and Torch LED drivers
#

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_LEDS_TRIGGER_TTY is not set

#
# Simple LED drivers
#
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_GHES=y
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
# CONFIG_EDAC_IGEN6 is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

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
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
# CONFIG_RTC_DRV_RV3029_HWMON is not set
# CONFIG_RTC_DRV_RX6110 is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IDXD is not set
# CONFIG_INTEL_IDXD_COMPAT is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_AMD_PTDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set
# CONFIG_INTEL_LDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

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
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_DCA=m
# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_CORE=m
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
# CONFIG_VIRTIO_MEM is not set
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_COMEDI is not set
# CONFIG_STAGING is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_HUAWEI_WMI is not set
# CONFIG_UV_SYSFS is not set
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
# CONFIG_XIAOMI_WMI is not set
# CONFIG_GIGABYTE_WMI is not set
# CONFIG_YOGABOOK_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
# CONFIG_AMD_PMC is not set
# CONFIG_AMD_HSMP is not set
# CONFIG_ADV_SWBUTTON is not set
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
# CONFIG_ASUS_TF103C_DOCK is not set
# CONFIG_MERAKI_MX100 is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
# CONFIG_WIRELESS_HOTKEY is not set
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_PMC_CORE=m

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_INTEL_WMI=y
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m

#
# Intel Uncore Frequency Control
#
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
# end of Intel Uncore Frequency Control

CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_OAKTRAIL=m
# CONFIG_INTEL_ISHTP_ECLITE is not set
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=m
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_INTEL_TURBO_MAX_3=y
# CONFIG_INTEL_VSEC is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_SERIAL_MULTI_INSTANTIATE is not set
CONFIG_MLX_PLATFORM=m
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
# CONFIG_SIEMENS_SIMATIC_IPC is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=m
# CONFIG_MLXREG_IO is not set
# CONFIG_MLXREG_LC is not set
CONFIG_SURFACE_PLATFORMS=y
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_GPE is not set
# CONFIG_SURFACE_HOTPLUG is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_LMK04832 is not set
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
# CONFIG_AMD_IOMMU is not set
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
CONFIG_IRQ_REMAP=y
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

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

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
# CONFIG_NTB_AMD is not set
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
CONFIG_PWM_LPSS=m
CONFIG_PWM_LPSS_PCI=m
CONFIG_PWM_LPSS_PLATFORM=m
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
# CONFIG_BCM_KONA_USB2_PHY is not set
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=m
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
CONFIG_INTEL_TH_PCI=m
CONFIG_INTEL_TH_ACPI=m
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# CONFIG_PECI is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
# CONFIG_F2FS_FS_COMPRESSION is not set
CONFIG_F2FS_IOSTAT=y
# CONFIG_F2FS_UNFAIR_RWSEM is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_ERROR_INJECTION is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=y
# CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
CONFIG_SQUASHFS=m
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=y
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFS_V4_2_READ_PLUS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_V4_2_SSC_HELPER=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_USER_DECRYPTED_DATA is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
# CONFIG_IMA is not set
# CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
# CONFIG_ZERO_CALL_USED_REGS is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
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
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
# CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=m
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_SM3_AVX_X86_64 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_CHACHA20=m
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
CONFIG_CRYPTO_SM4=m
# CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=y
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
CONFIG_CRYPTO_USER_API_AEAD=y
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
CONFIG_CRYPTO_DEV_NITROX=m
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=m
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_MODULE_SIG_KEY_TYPE_RSA=y
# CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
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
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_CORDIC=m
# CONFIG_PRIME_NUMBERS is not set
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
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=m
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=m
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=m
# end of Crypto library routines

CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=m
# CONFIG_CRC4 is not set
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
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
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
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
CONFIG_SWIOTLB=y
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
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

CONFIG_ASN1_ENCODER=y

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
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# CONFIG_KCSAN is not set
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# end of Networking Debugging

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

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
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
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
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
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
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
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
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
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
# CONFIG_ASYNC_RAID6_TEST is not set
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
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_LIVEPATCH is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_HMM is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='stress-ng'
	export testcase='stress-ng'
	export category='benchmark'
	export nr_threads=128
	export testtime=60
	export job_origin='stress-ng-class-network.yaml'
	export queue_cmdline_keys=
	export queue='vip'
	export testbox='lkp-icl-2sp6'
	export tbox_group='lkp-icl-2sp6'
	export kconfig='x86_64-rhel-8.3'
	export submit_id='62650b300b9a934a3ff55c07'
	export job_file='/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-sock-60s-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-6b433275e3a3cf18a16c0d2afb7fbc7a43bd-20220424-84543-1anza9s-5.yaml'
	export id='0dea6e540ea80ab295875d9a41f96d74f8544ba9'
	export queuer_version='/lkp/xsang/.src-20220424-085458'
	export model='Ice Lake'
	export nr_node=2
	export nr_cpu=128
	export memory='128G'
	export nr_ssd_partitions=3
	export nr_hdd_partitions=6
	export hdd_partitions='/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA06X8DA-part*'
	export ssd_partitions='/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204002V800RGN-part*'
	export rootfs_partition='/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K8400NGN-part1'
	export kernel_cmdline_hw='acpi_rsdp=0x69ffd014'
	export brand='Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz'
	export need_kconfig=
	export commit='6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc'
	export ucode='0xd000331'
	export bisect_dmesg=true
	export enqueue_time='2022-04-24 16:32:49 +0800'
	export _id='62650b320b9a934a3ff55c0c'
	export _rt='/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc'
	export user='lkp'
	export compiler='gcc-11'
	export LKP_SERVER='internal-lkp-server'
	export head_commit='7ae259079a399b98b3b82e76def61f2e290d2396'
	export base_commit='b2d229d4ddb17db541098b83524d901257e93845'
	export branch='linux-review/Abel-Wu/introduece-sched-idle-balance/20220409-215303'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/3'
	export scheduler_version='/lkp/lkp/.src-20220424-161621'
	export arch='x86_64'
	export max_uptime=2100
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/3
BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/vmlinuz-5.18.0-rc1-00004-g6b433275e3a3
branch=linux-review/Abel-Wu/introduece-sched-idle-balance/20220409-215303
job=/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-sock-60s-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-6b433275e3a3cf18a16c0d2afb7fbc7a43bd-20220424-84543-1anza9s-5.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-rhel-8.3
commit=6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc
acpi_rsdp=0x69ffd014
max_uptime=2100
LKP_SERVER=internal-lkp-server
nokaslr
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
	export modules_initrd='/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220423.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220423.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-22da5264abf4-1_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20220216.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.18.0-rc3-wt-ath-06125-g7ae259079a39'
	export schedule_notify_address=
	export kernel='/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/vmlinuz-5.18.0-rc1-00004-g6b433275e3a3'
	export dequeue_time='2022-04-25 09:25:19 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-sock-60s-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-6b433275e3a3cf18a16c0d2afb7fbc7a43bd-20220424-84543-1anza9s-5.cgz'

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

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper uptime
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor lite_mode=1 $LKP_SRC/monitors/wrapper perf-sched
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor debug_mode=0 $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test class='network' test='sock' $LKP_SRC/tests/wrapper stress-ng
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	env class='network' test='sock' $LKP_SRC/stats/wrapper stress-ng
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper uptime
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	env lite_mode=1 $LKP_SRC/stats/wrapper perf-sched
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	env debug_mode=0 $LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time stress-ng.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
:#! jobs/stress-ng-class-network.yaml:
suite: stress-ng
testcase: stress-ng
category: benchmark
nr_threads: 100%
testtime: 60s
stress-ng:
  class: network
  test: sock
job_origin: stress-ng-class-network.yaml
:#! queue options:
queue_cmdline_keys: []
queue: vip
testbox: lkp-icl-2sp6
tbox_group: lkp-icl-2sp6
kconfig: x86_64-rhel-8.3
submit_id: 62650b300b9a934a3ff55c07
job_file: "/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-sock-60s-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-6b433275e3a3cf18a16c0d2afb7fbc7a43bd-20220424-84543-1anza9s-4.yaml"
id: dd598d80eece8a1bf6b91cfabdc1ed6903097ba8
queuer_version: "/lkp/xsang/.src-20220424-085458"
:#! hosts/lkp-icl-2sp6:
model: Ice Lake
nr_node: 2
nr_cpu: 128
memory: 128G
nr_ssd_partitions: 3
nr_hdd_partitions: 6
hdd_partitions: "/dev/disk/by-id/ata-WDC_WD20SPZX-08UA7_WD-WXE2EA06X8DA-part*"
ssd_partitions: "/dev/disk/by-id/ata-INTEL_SSDSC2BB800G4_PHWL4204002V800RGN-part*"
rootfs_partition: "/dev/disk/by-id/ata-INTEL_SSDSC2BA400G4_BTHV634503K8400NGN-part1"
kernel_cmdline_hw: acpi_rsdp=0x69ffd014
brand: Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz
:#! include/category/benchmark:
kmsg:
boot-time:
uptime:
iostat:
heartbeat:
vmstat:
numa-numastat:
numa-vmstat:
numa-meminfo:
proc-vmstat:
proc-stat:
meminfo:
slabinfo:
interrupts:
lock_stat:
perf-sched:
  lite_mode: 1
softirqs:
bdi_dev_mapping:
diskstats:
nfsstat:
cpuidle:
cpufreq-stats:
turbostat:
sched_debug:
perf-stat:
mpstat:
perf-profile:
  debug_mode: 0
:#! include/category/ALL:
cpufreq_governor: performance
:#! include/stress-ng:
need_kconfig:
:#! include/queue/cyclic:
commit: 6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc
:#! include/testbox/lkp-icl-2sp6:
ucode: '0xd000331'
bisect_dmesg: true
enqueue_time: 2022-04-24 16:32:49.063505101 +08:00
_id: 62650b320b9a934a3ff55c0b
_rt: "/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc"
:#! schedule options:
user: lkp
compiler: gcc-11
LKP_SERVER: internal-lkp-server
head_commit: 7ae259079a399b98b3b82e76def61f2e290d2396
base_commit: b2d229d4ddb17db541098b83524d901257e93845
branch: linux-review/Abel-Wu/introduece-sched-idle-balance/20220409-215303
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/0"
scheduler_version: "/lkp/lkp/.src-20220424-161621"
arch: x86_64
max_uptime: 2100
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- RESULT_ROOT=/result/stress-ng/network-performance-100%-sock-60s-ucode=0xd000331/lkp-icl-2sp6/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/0
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/vmlinuz-5.18.0-rc1-00004-g6b433275e3a3
- branch=linux-review/Abel-Wu/introduece-sched-idle-balance/20220409-215303
- job=/lkp/jobs/scheduled/lkp-icl-2sp6/stress-ng-network-performance-100%-sock-60s-ucode=0xd000331-debian-10.4-x86_64-20200603.cgz-6b433275e3a3cf18a16c0d2afb7fbc7a43bd-20220424-84543-1anza9s-4.yaml
- user=lkp
- ARCH=x86_64
- kconfig=x86_64-rhel-8.3
- commit=6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc
- acpi_rsdp=0x69ffd014
- max_uptime=2100
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/stress-ng_20220423.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/stress-ng-x86_64-0.11-06_20220423.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/mpstat_20200714.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/turbostat_20220316.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/turbostat-x86_64-56e337f2cf13-1_20220316.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/perf_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/perf-x86_64-22da5264abf4-1_20220424.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/sar-x86_64-34c92ae-1_20200702.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
:#! /cephfs/db/releases/20220418214553/lkp-src/include/site/inn:
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer:
watchdog:
:#! runtime status:
last_kernel: 5.9.0-2-amd64
schedule_notify_address:
kernel: "/pkg/linux/x86_64-rhel-8.3/gcc-11/6b433275e3a3cf18a16c0d2afb7fbc7a43bd3dbc/vmlinuz-5.18.0-rc1-00004-g6b433275e3a3"
dequeue_time: 2022-04-24 17:27:06.571458851 +08:00
:#! /cephfs/db/releases/20220424155601/lkp-src/include/site/inn:
job_state: finished
loadavg: 85.53 34.30 12.49 1/1048 9771
start_time: '1650792500'
end_time: '1650792562'
version: "/lkp/lkp/.src-20220424-161656:7127c892:246de96ff"

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "stress-ng" "--timeout" "60" "--times" "--verify" "--metrics-brief" "--sock" "128"

--Clx92ZfkiYIKRjnr--

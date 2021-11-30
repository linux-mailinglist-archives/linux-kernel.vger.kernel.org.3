Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B5462D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238782AbhK3Gtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:49:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:40287 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233099AbhK3Gta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:49:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="296960440"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="296960440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:46:11 -0800
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="499640480"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.155]) ([10.238.4.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 22:46:09 -0800
Message-ID: <96fa41bb-7e9f-ae47-bf34-accef5c36fa8@linux.intel.com>
Date:   Tue, 30 Nov 2021 14:46:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [LKP] Re: [xfs] bad77c375e: stress-ng.fallocate.ops_per_sec
 -10.0% regression
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     kernel test robot <oliver.sang@intel.com>,
        Dave Chinner <dchinner@redhat.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210902072704.GC8267@xsang-OptiPlex-9020>
 <36dc5f38-f8ec-591a-8efa-b3bd607ac06e@linux.intel.com>
In-Reply-To: <36dc5f38-f8ec-591a-8efa-b3bd607ac06e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

    Do you have time to look at this? It still existed in v5.16-rc3. Thanks

On 9/3/2021 3:40 PM, Xing Zhengjun wrote:
> Hi Dave,
> 
>     Do you have time to look at this? Thanks.
> 
> On 9/2/2021 3:27 PM, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -10.0% regression of stress-ng.fallocate.ops_per_sec 
>> due to commit:
>>
>>
>> commit: bad77c375e8de6c776c848e443f7dc2d0d909be5 ("xfs: CIL checkpoint 
>> flushes caches unconditionally")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: stress-ng
>> on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 
>> 2.10GHz with 512G memory
>> with following parameters:
>>
>>     nr_threads: 10%
>>     disk: 1HDD
>>     testtime: 60s
>>     fs: xfs
>>     class: filesystem
>>     test: fallocate
>>     cpufreq_governor: performance
>>     ucode: 0x5003006
>>
>>
>> In addition to that, the commit also has significant impact on the 
>> following tests:
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>>
>> Details are as below:
>> --------------------------------------------------------------------------------------------------> 
>>
>>
>>
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp install                job.yaml  # job file is 
>> attached in this email
>>          bin/lkp split-job --compatible job.yaml  # generate the yaml 
>> file for lkp run
>>          bin/lkp run                    generated-yaml-file
>>
>> ========================================================================================= 
>>
>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode: 
>>
>>    
>> filesystem/gcc-9/performance/1HDD/xfs/x86_64-rhel-8.3/10%/debian-10.4-x86_64-20200603.cgz/lkp-csl-2sp7/fallocate/stress-ng/60s/0x5003006 
>>
>>
>> commit:
>>    0431d926b3 ("xfs: async blkdev cache flush")
>>    bad77c375e ("xfs: CIL checkpoint flushes caches unconditionally")
>>
>> 0431d926b399d74f bad77c375e8de6c776c848e443f
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>      618.67           -10.0%     556.67 ±  2%  stress-ng.fallocate.ops
>>       10.31           -10.0%       9.28 ±  2%  
>> stress-ng.fallocate.ops_per_sec
>>      111618            -5.7%     105270        
>> stress-ng.time.voluntary_context_switches
>>      502.67 ±  2%     +52.0%     763.83 ± 47%  
>> interrupts.CPU44.CAL:Function_call_interrupts
>>        2.10 ±  2%     -25.1%       1.57        iostat.cpu.iowait
>>        2.16 ±  2%      -0.5        1.62        mpstat.cpu.all.iowait%
>>        0.09 ± 11%     +45.0%       0.14 ± 34%  
>> perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork
>>      151.00 ± 19%     +20.2%     181.50 ±  7%  
>> perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
>>        6749            +6.4%       7178        
>> perf-stat.i.context-switches
>>        6640            +6.4%       7063        
>> perf-stat.ps.context-switches
>>      353877            -1.4%     348924        proc-vmstat.pgfree
>>       39122           -15.1%      33221        proc-vmstat.pgpgout
>>        1225 ± 14%      -9.0%       1115        turbostat.Bzy_MHz
>>       86.82 ± 17%     -10.4%      77.83        turbostat.PkgWatt
>>      602.83           -15.1%     511.83        vmstat.io.bo
>>        6953            +6.1%       7376        vmstat.system.cs
>>        1.33 ±  6%      +0.4        1.70 ± 13%  
>> perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt 
>>
>>        0.08 ± 22%      +0.1        0.17 ± 23%  
>> perf-profile.children.cycles-pp.wait_for_completion
>>        0.07 ± 17%      +0.1        0.19 ± 64%  
>> perf-profile.children.cycles-pp.submit_bio
>>        0.07 ± 17%      +0.1        0.19 ± 64%  
>> perf-profile.children.cycles-pp.submit_bio_noacct
>>        1.40 ±  8%      +0.3        1.74 ± 12%  
>> perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
>>
>>
>>                           stress-ng.fallocate.ops_per_sec
>>    12 
>> +----------------------------------------------------------------------+
>>       
>> |                                                                      |
>>    10 |.+.++.+.+.+  
>> +.+.+.++.+.+.++.+.+.+.++.+.+.++.+.+.++.+.+.+.++.+.+.++.+.|
>>       | O        :  :                             O O   OO O O O 
>> OO          |
>>       |   OO O   :O :            O             O O    
>> O                      |
>>     8 |-+      O :  : O O OO O O  O O O O OO 
>> O                               |
>>       |          : 
>> :                                                         |
>>     6 |-+        : 
>> :                                                         |
>>       |           
>> ::                                                         |
>>     4 |-+         
>> ::                                                         |
>>       |           
>> ::                                                         |
>>       |           
>> ::                                                         |
>>     2 |-+         
>> :                                                          |
>>       |           
>> :                                                          |
>>     0 
>> +----------------------------------------------------------------------+
>> [*] bisect-good sample
>> [O] bisect-bad  sample
>>
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are 
>> provided
>> for informational purposes only. Any difference in system hardware or 
>> software
>> design or configuration may affect actual performance.
>>
>>
>> ---
>> 0DAY/LKP+ Test Infrastructure                   Open Source Technology 
>> Center
>> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel 
>> Corporation
>>
>> Thanks,
>> Oliver Sang
>>
> 

-- 
Zhengjun Xing

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3544858D6F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiHIJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiHIJ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 05:59:04 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08AE23BC5;
        Tue,  9 Aug 2022 02:59:02 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M27hR6XZ5z67xh9;
        Tue,  9 Aug 2022 17:54:31 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 11:59:00 +0200
Received: from [10.195.245.222] (10.195.245.222) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 9 Aug 2022 10:58:59 +0100
Message-ID: <3451fa5a-6229-073f-ae18-0c232cd48ed5@huawei.com>
Date:   Tue, 9 Aug 2022 10:58:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [ata] 0568e61225: stress-ng.copy-file.ops_per_sec -15.0%
 regression
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        <linux-ide@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>,
        <ying.huang@intel.com>, <feng.tang@intel.com>,
        <zhengjun.xing@linux.intel.com>, <fengwei.yin@intel.com>
References: <YuzPMMnnY739Tnit@xsang-OptiPlex-9020>
 <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <1f498d4a-f93f-ceb4-b713-753196e5e08d@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.195.245.222]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2022 15:52, Damien Le Moal wrote:
> On 2022/08/05 1:05, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed a -15.0% regression of stress-ng.copy-file.ops_per_sec due to commit:
>>
>>
>> commit: 0568e6122574dcc1aded2979cd0245038efe22b6 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: stress-ng
>> on test machine: 96 threads 2 sockets Ice Lake with 256G memory
>> with following parameters:
>>
>> 	nr_threads: 10%
>> 	disk: 1HDD
>> 	testtime: 60s
>> 	fs: f2fs
>> 	class: filesystem
>> 	test: copy-file
>> 	cpufreq_governor: performance
>> 	ucode: 0xb000280
> 
> Without knowing what the device adapter is, hard to say where the problem is. I
> suspect that with the patch applied, we may be ending up with a small default
> max_sectors value, causing overhead due to more commands than necessary.
> 
> Will check what I see with my test rig.

As far as I can see, this patch should not make a difference unless the 
ATA shost driver is setting the max_sectors value unnecessarily low.

> 
>>
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
>> To reproduce:
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          sudo bin/lkp install job.yaml           # job file is attached in this email
>>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>>          sudo bin/lkp run generated-yaml-file
>>
>>          # if come across any failure that blocks the test,
>>          # please remove ~/.lkp and /lkp dir to run from a clean state.
>>
>> =========================================================================================
>> class/compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime/ucode:
>>    filesystem/gcc-11/performance/1HDD/f2fs/x86_64-rhel-8.3/10%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp1/copy-file/stress-ng/60s/0xb000280
>>
>> commit:
>>    4cbfca5f77 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
>>    0568e61225 ("ata: libata-scsi: cap ata_device->max_sectors according to shost->max_sectors")
>>
>> 4cbfca5f7750520f 0568e6122574dcc1aded2979cd0
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>        1627           -14.9%       1385        stress-ng.copy-file.ops
>>       27.01           -15.0%      22.96        stress-ng.copy-file.ops_per_sec
>>     8935079           -11.9%    7870629        stress-ng.time.file_system_outputs
>>       14.88 ±  5%     -31.8%      10.14 ±  3%  stress-ng.time.percent_of_cpu_this_job_got
>>       50912           -14.7%      43413        vmstat.io.bo
>>       93.78            +1.4%      95.10        iostat.cpu.idle
>>        3.89           -31.6%       2.66        iostat.cpu.iowait
>>        4.01            -1.3        2.74        mpstat.cpu.all.iowait%
>>        0.23 ±  9%      -0.1        0.17 ± 11%  mpstat.cpu.all.sys%
>>        1.66 ± 37%      -1.2        0.51 ± 55%  perf-profile.calltrace.cycles-pp.f2fs_write_end.generic_perform_write.f2fs_buffered_write_iter.f2fs_file_write_iter.do_iter_readv_writev
>>        1.66 ± 37%      -1.1        0.59 ± 25%  perf-profile.children.cycles-pp.f2fs_write_end
>>        1.51 ± 40%      -1.1        0.45 ± 26%  perf-profile.children.cycles-pp.f2fs_dirty_data_folio
>>        1.21 ± 49%      -1.0        0.23 ± 33%  perf-profile.children.cycles-pp.f2fs_update_dirty_folio
>>        0.88 ± 56%      -0.8        0.04 ±111%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>>        0.14 ± 26%      +0.1        0.25 ± 28%  perf-profile.children.cycles-pp.page_cache_ra_unbounded
>>        0.88 ± 56%      -0.8        0.04 ±112%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>>     3164876 ±  9%     -20.2%    2524713 ±  7%  perf-stat.i.cache-misses
>>   4.087e+08            -4.6%  3.899e+08        perf-stat.i.dTLB-loads
>>      313050 ± 10%     -18.4%     255410 ±  6%  perf-stat.i.node-loads
>>      972573 ±  9%     -16.4%     812873 ±  6%  perf-stat.i.node-stores
>>     3114748 ±  9%     -20.2%    2484807 ±  7%  perf-stat.ps.cache-misses
>>   4.022e+08            -4.6%  3.837e+08        perf-stat.ps.dTLB-loads
>>      308178 ± 10%     -18.4%     251418 ±  6%  perf-stat.ps.node-loads
>>      956996 ±  9%     -16.4%     799948 ±  6%  perf-stat.ps.node-stores
>>      358486            -8.3%     328694        proc-vmstat.nr_active_file
>>     1121620           -11.9%     987816        proc-vmstat.nr_dirtied
>>      179906            -6.7%     167912        proc-vmstat.nr_dirty
>>     1151201            -1.7%    1131322        proc-vmstat.nr_file_pages
>>      100181            +9.9%     110078 ±  2%  proc-vmstat.nr_inactive_file
>>      846362           -14.6%     722471        proc-vmstat.nr_written
>>      358486            -8.3%     328694        proc-vmstat.nr_zone_active_file
>>      100181            +9.9%     110078 ±  2%  proc-vmstat.nr_zone_inactive_file
>>      180668            -6.8%     168456        proc-vmstat.nr_zone_write_pending
>>      556469            -3.5%     536985        proc-vmstat.pgactivate
>>     3385454           -14.6%    2889953        proc-vmstat.pgpgout
>>
>>
>>
>>
>> Disclaimer:
>> Results have been estimated based on internal Intel analysis and are provided
>> for informational purposes only. Any difference in system hardware or software
>> design or configuration may affect actual performance.
>>
>>
> 
> 


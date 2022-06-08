Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F294542B99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiFHJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFHJaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:30:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0130E11CA11
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:55:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3A8D1424;
        Wed,  8 Jun 2022 01:55:27 -0700 (PDT)
Received: from [192.168.1.11] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB8043F66F;
        Wed,  8 Jun 2022 01:55:26 -0700 (PDT)
Message-ID: <fe20591a-96bf-2ac5-c97f-442c2b36c455@arm.com>
Date:   Wed, 8 Jun 2022 10:55:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
Content-Language: en-US
To:     Bruno Goncalves <bgoncalv@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
 <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com>
 <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/3/22 17:32, Bruno Goncalves wrote:
> On Fri, 3 Jun 2022 at 17:24, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Bruno,
>> This looks like something we noticed on the PCC channel of the Tx2. Here was
>> the original message:
>> '''
>> It seems there is synchronization issue on the PCC channels of the ThunderX2.
>>
>> Some abbreviations first. References are always to ACPI 6.4:
>> Command Complete bit (CCb):
>> 1 means the OS owns the PCC channel, 0 means the firmware owns the channel,
>> cf s14.2.2 "Generic Communications Channel Status Field"
>>
>> Doorbell Write bits (DWb):
>> Write a mask (just one bit in our case) to the doorbell register to notify the
>> firmware of a message waiting in the channel,
>> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
>>
>> Minimum Request Turnaround Time (MRTT):
>> PCC channels have a 'Minimum Request Turnaround Time', being 'The minimum
>> amount of time that OSPM must wait after the completion of a command before
>> issuing the next command'.
>> cf s14.1.4 "HW-Reduced Communications Subspace Structure (type 1)"
>>
>> The scenario that seems to cause trouble is:
>> 1. The OS places a payload and clears the CCb bit
>> 2. The OS rings at the doorbell (sets the DWb)
>> 3. The firmware processes the message and then sets the CCb (the DWb seems to
>>      be still set)
>> 4. The OS continues (the DWb seems to be still set)
>> 5. The OS wants to send another command. The MRTT has elapsed. So the OS does
>>       1. again. (the DWb seems to be still set)
>> 6. The OS does 2. again, but the DWb are still set so the OS overwrites the DWb
>> 7. The firmware finally clears the DWb.
>>
>>    From 7.:
>> - The OS indefinitely waits for an answer, thinking the firmware needs
>>     to answer. The timeout of this request elapses, but the channel is still
>>     assumed to belong to the firmware, so the OS never rings the doorbell again.
>> - The firmware waits for the doorbell to ring (the DWb to be set), but the
>>     OS never rings again.
>>
>> This can be reproduced by running a big load (e.g. 60 tasks running at 5%
>> of the maximum CPU capacity). PCCT tables must have been published by
>> selecting the right option in UEFI.
>>
>> Doubling the MRTT (going from 5ms to 10ms) makes the synchronization issue
>> disappears, but it means decreasing the speed of all PCC channels.
>> '''
>>
>> If you get messages such as:
>> "PCC check channel failed for ss: XX. ret=X"
>> then this should be the same issue.
> 
> Thanks for your reply, on console.log we don't see the message above.
> 
> Bruno
> 
>>
>> What might be happening for you is that a stall is detected while the
>> sugov_work thread is trying to set a frequency. check_pcc_chan() waits for
>> 500 * 3000 us (the PCC channel nominal latency for the Tx2) = 1.5s, which
>> is quite long.
>>
>> Cf. the end of the original message, could you try increasing the mrtt value ?
>> (here it is doubled)
>> pcc_data[pcc_ss_idx]->pcc_mrtt = 2 * pcc_chan->min_turnaround_time;
>> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L547
>> (for info, where the cppc dirvers waits for the mrtt to elapse)
>> https://github.com/torvalds/linux/blob/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc/drivers/acpi/cppc_acpi.c#L263
>>
>> On 6/3/22 11:44, Bruno Goncalves wrote:
>>> Hello,
>>>
>>> We recently started to hit this problem on some of our aarch64
>>> machines. The stalls can happen even during boot.
>>>
>>> [ 1086.949484] rcu: INFO: rcu_sched detected expedited stalls on
>>> CPUs/tasks: { 23-... } 3 jiffies s: 3441 root: 0x2/.
>>> [ 1086.949510] rcu: blocking rcu_node structures (internal RCU debug):
>>> l=1:16-31:0x80/.
>>> [ 1086.949524] Task dump for CPU 23:
>>> [ 1086.949528] task:sugov:23        state:R  running task     stack:
>>>    0 pid: 2914 ppid:     2 flags:0x0000000a
>>> [ 1086.949543] Call trace:
>>> [ 1086.949546]  __switch_to+0x104/0x19c
>>> [ 1086.949568]  __schedule+0x410/0x67c
>>> [ 1086.949576]  schedule+0x70/0xa8
>>> [ 1086.949583]  schedule_hrtimeout_range_clock+0x144/0x1d8
>>> [ 1086.949592]  schedule_hrtimeout_range+0x20/0x2c
>>> [ 1086.949598]  usleep_range_state+0x5c/0x80
>>> [ 1086.949603]  check_pcc_chan+0x7c/0xf4
>>> [ 1086.949615]  send_pcc_cmd+0x130/0x2a8
>>> [ 1086.949619]  cppc_set_perf+0x12c/0x22c
>>> [ 1086.949624]  cppc_cpufreq_set_target+0xf8/0x15c [cppc_cpufreq]
>>> [ 1086.949645]  __cpufreq_driver_target+0x94/0xfc
>>> [ 1086.949658]  sugov_work+0x98/0xe0
>>> [ 1086.949675]  kthread_worker_fn+0x124/0x2b8
>>> [ 1086.949683]  kthread+0xd4/0x558
>>> [ 1086.949689]  ret_from_fork+0x10/0x20
>>>
>>> More logs:
>>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Storage_block_filesystem_fio_test/12073991_aarch64_1_dmesg.log
>>>
>>> https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/06/02/553734635/redhat:553734635_aarch64/tests/Boot_test/12073991_aarch64_1_test_console.log
>>>
>>> CKI issue tracker: https://datawarehouse.cki-project.org/issue/1259
>>>
>>> Thanks,
>>> Bruno Goncalves
>>>
>>
> 

Hello Bruno,

Some pointers first:
Build: https://datawarehouse.cki-project.org/kcidb/tests/3717528
Job: https://gitlab.com/redhat/red-hat-ci-tools/kernel/cki-internal-pipelines/cki-trusted-contributors/-/jobs/2536244504
Config file: https://gitlab.com/api/v4/projects/18194050/jobs/2536244462/artifacts/artifacts/kernel-mainline.kernel.org-clang-aarch64-d1dc87763f406d4e67caf16dbe438a5647692395.config

The config file has:
CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=20
Meaning that after 20ms (2 ticks at HZ=100), an expedited RCU stall will be
declared. I think for !ANDROID, this config value should be let unset/set to 0.
https://github.com/torvalds/linux/blob/1e57930e9f4083ad5854ab6eadffe790a8167fb4/kernel/rcu/Kconfig.debug#L85

If unset, the value (in ms) of
CONFIG_RCU_CPU_STALL_TIMEOUT=60
will be used before declaring an expedited RCU stall, so 60ms (6 jiffies at
100HZ). In your log, all the expedited RCU stalls were declared at 3 or 4
jiffies. So removing the CONFIG_RCU_EXP_CPU_STALL_TIMEOUT entry should make
the messages disappear.

Both timeout values can also be read/modified at runtime at:
/sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
/sys/module/rcupdate/parameters/rcu_exp_cpu_stall_timeout

Regards,
Pierre

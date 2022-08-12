Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035EF590AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 05:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiHLDYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 23:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237085AbiHLDYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 23:24:19 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F667A3D44;
        Thu, 11 Aug 2022 20:23:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VM04yDW_1660274624;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VM04yDW_1660274624)
          by smtp.aliyun-inc.com;
          Fri, 12 Aug 2022 11:23:45 +0800
Subject: Re: [PATCH V6 0/6] RISC-V fixups to work with crash tool
To:     Palmer Dabbelt <palmer@dabbelt.com>, Conor.Dooley@microchip.com
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, heiko@sntech.de, guoren@kernel.org,
        mick@ics.forth.gr, alexandre.ghiti@canonical.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
        Conor.Dooley@microchip.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <f4f82b84-d224-ed8d-d54d-a55f2eddeb31@linux.alibaba.com>
Date:   Fri, 12 Aug 2022 11:23:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <mhng-f5fdaa37-e99a-4214-a297-ec81f0fed0c1@palmer-mbp2014>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/8/12 上午12:17, Palmer Dabbelt 写道:
> On Thu, 11 Aug 2022 00:41:44 PDT (-0700), 
> xianting.tian@linux.alibaba.com wrote:
>> I ever sent the patch 1 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220708073150.352830-3-xianting.tian@linux.alibaba.com/ 
>>
>> And patch 2,3 in the link:
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-2-xianting.tian@linux.alibaba.com/ 
>>
>> https://patchwork.kernel.org/project/linux-riscv/patch/20220714113300.367854-3-xianting.tian@linux.alibaba.com/ 
>>
>>
>> This patch set just put these patches together, and with three new 
>> patch 4, 5, 6.
>> these six patches are the fixups for machine_kexec, kernel mode PC 
>> for vmcore
>> and improvements for vmcoreinfo, memory layout dump and fixup 
>> schedule out issue
>> in machine_crash_shutdown().
>>
>> The main changes in the six patchs as below,
>> Patch 1: Fixup use of smp_processor_id() in preemptible context, to 
>> cleanup
>>          the console prints.
>> Patch 2: Fixup to get correct kernel mode PC for kernel mode regs for 
>> vmcore.
>> Patch 3: Fixup schedule out issue in machine_crash_shutdown()
>> Patch 4: Add modules to virtual kernel memory layout dump.
>> Patch 5: Add VM layout, va bits, ram base to vmcoreinfo, which can 
>> simplify
>>          the development of crash tool as ARM64 already did
>>          (arch/arm64/kernel/crash_core.c).
>> Patch 6: Updates vmcoreinfo.rst for vmcoreinfo export for RISCV64.
>>
>> With these six patches(patch 2 is must), crash tool can work well to 
>> analyze
>> a vmcore. The patches for crash tool for RISCV64 is in the link:
>> https://lore.kernel.org/linux-riscv/20220801043040.2003264-1-xianting.tian@linux.alibaba.com/ 
>>
>>
>> ------
>> Changes v1 -> v2:
>>   1, remove the patch "Add a fast call path of crash_kexec()" from 
>> this series
>>      of patches, as it already applied to riscv git.
>> https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>   2, add 'Reviewed-by' based on the comments of v1.
>> Changes v2 -> v3:
>>   use "riscv" instead of "riscv64" in patch 5 subject line.
>> Changes v3 -> v4:
>>   use "riscv" instead of "riscv64" in the summary of patch 5 subject 
>> line.
>> Changes v4 -> v5:
>>   add a new patch "RISC-V: Fixup schedule out issue in 
>> machine_crash_shutdown()"
>> Changes v5 -> v6:
>>   1, move "fixup" patches to the start of the patch set.
>>   2, change patch 1, 2, 6's subject to make it tell more what it's 
>> about.
>>   3, add Fixes for patch 3.
>>   4, adjuest the changes format for patch 6.
>>
>>
>> Xianting Tian (6):
>>   RISC-V: kexec: Fixup use of smp_processor_id() in preemptible context
>>   RISC-V: Fixup get incorrect user mode PC for kernel mode regs
>>   RISC-V: Fixup schedule out issue in machine_crash_shutdown()
>>   RISC-V: Add modules to virtual kernel memory layout dump
>>   RISC-V: Add arch_crash_save_vmcoreinfo support
>>   Documentation: kdump: describe VMCOREINFO export for RISCV64
>>
>>  .../admin-guide/kdump/vmcoreinfo.rst          | 31 +++++++++++++++++++
>>  arch/riscv/kernel/Makefile                    |  1 +
>>  arch/riscv/kernel/crash_core.c                | 29 +++++++++++++++++
>>  arch/riscv/kernel/crash_save_regs.S           |  2 +-
>>  arch/riscv/kernel/machine_kexec.c             | 28 ++++++++++++++---
>>  arch/riscv/mm/init.c                          |  4 +++
>>  6 files changed, 89 insertions(+), 6 deletions(-)
>>  create mode 100644 arch/riscv/kernel/crash_core.c
>
> Thank.  I've taken the first 4 onto for-next, which is still targeted 
> for 5.20, as they're fixes.  I'm not opposed to taking the 
> documentation patch for this cycle as well, it just needs some 
> going-over as the wording looks very odd (or at least it does to me 
> right now, maybe I'm just still half asleep).  Patch 5 is a new 
> feature, and given that it's being spun during the merge window it's 
> too late.

Thank you Palmer, Conor.
I saw patch 5,6 already merged to Palmer's riscv-crash branch,
https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=riscv-crash
Looking forward to be merged to 6.1(?). thanks.


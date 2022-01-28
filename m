Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B23549F603
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347510AbiA1JJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:09:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4538 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347477AbiA1JJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:09:43 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlWlh0fLrz67xNW;
        Fri, 28 Jan 2022 17:06:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 10:09:41 +0100
Received: from [10.47.26.192] (10.47.26.192) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 28 Jan
 2022 09:09:40 +0000
Subject: Re: [PATCH 00/16] scsi: libsas and users: Factor out LLDD TMF code
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@cloud.ionos.com>,
        <chenxiang66@hisilicon.com>, <Ajish.Koshy@microchip.com>
CC:     <yanaijie@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>,
        <Viswas.G@microchip.com>
References: <1643110372-85470-1-git-send-email-john.garry@huawei.com>
 <1893d9ef-042b-af3b-74ea-dd4d0210c493@opensource.wdc.com>
 <14df160f-c0f2-cc9f-56d4-8eda67969e0b@huawei.com>
 <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a2de1656-b1ec-2fb7-caab-657e27dacb48@huawei.com>
Date:   Fri, 28 Jan 2022 09:09:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <a8fae323-1877-058a-b03e-d175a725213f@opensource.wdc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.26.192]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2022 06:37, Damien Le Moal wrote:

Hi Damien,

>> However using this same adapter type on my arm64 system has error
>> handling kick in almost straight away - and the handling looks sane. A
>> silver lining, I suppose ..
> I ran some more tests. In particular, I ran libzbc compliance tests on a
> 20TB SMR drives. All tests pass with 5.17-rc1, but after applying your
> series, I see command timeout that take forever to recover from, with
> the drive revalidation failing after that.
> 
> [  385.102073] sas: Enter sas_scsi_recover_host busy: 1 failed: 1
> [  385.108026] sas: sas_scsi_find_task: aborting task 0x000000007068ed73
> [  405.561099] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
> timeout.
> [  405.568236] sas: sas_scsi_find_task: task 0x000000007068ed73 is aborted
> [  405.574930] sas: sas_eh_handle_sas_errors: task 0x000000007068ed73 is
> aborted
> [  411.192602] ata21.00: qc timeout (cmd 0xec)
> [  431.672122] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
> timeout.
> [  431.679282] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  431.685544] ata21.00: revalidation failed (errno=-5)
> [  441.911948] ata21.00: qc timeout (cmd 0xec)
> [  462.391545] pm80xx0:: pm8001_exec_internal_task_abort  757:TMF task
> timeout.
> [  462.398696] ata21.00: failed to IDENTIFY (I/O error, err_mask=0x4)
> [  462.404992] ata21.00: revalidation failed (errno=-5)
> [  492.598769] ata21.00: qc timeout (cmd 0xec)
> ...
> 
> So there is a problem. Need to dig into this. I see this issue only with
> libzbc passthrough tests. fio runs with libaio are fine.

Thanks for the notice. I think that I also saw a hang, but, IIRC, it 
happened on mainline for me - but it's hard to know if I broke something 
if it is already broke in another way. That is why I wanted this card 
working properly...

Anyway, I will investigate more.

> 
>>> And sparse/make C=1 complains about:
>>>
>>> drivers/scsi/libsas/sas_port.c:77:13: warning: context imbalance in
>>> 'sas_form_port' - different lock contexts for basic block
>> I think it's talking about the port->phy_list_lock usage - it prob
>> doesn't like segments where we fall out a loop with the lock held (which
>> was grabbed in the loop). Anyway it looks ok. Maybe we can improve this.
>>
>>> But I have not checked if it is something that your series touch.
>>>
>>> And there is a ton of complaints about __le32 use in the pm80xx code...
>>> I can try to have a look at these if you want, on top of your series.
>> I really need to get make C=1 working for me - it segfaults in any env I
>> have:(
> I now have a 12 patch series that fixes*all*  the sparse warnings. Some
> of the fixes were trivial, but most of them are simply hard bugs with
> the handling of le32 struct field values. There is no way that this
> driver is working as-is on big-endian machines. Some calculations are
> actually done using cpu_to_le32() values !

Great, I'll have a look when you send them.

> 
> But even though these fixes should have essentially no effect on
> little-endian x86_64, with my series applied, I see the same command
> timeout problem as with your libsas update, and both series together
> result in the same timeout issue too.
> 
> So it looks like "fixing" the code actually is revealing some other bug
> that was previously hidden... This will take some time to debug.
> 
> Another problem I noticed: doing "rmmod pm80xx; modprobe pm80xx" result
> in a failure of device scans. I get loops of "link is slow to respond
> ->reset". For the above tests, I had to reboot every time I changed the
> driver module code. Another thing to look at.

Sounds odd, I would expect everything runs from afresh when insmod.

Thanks,
John

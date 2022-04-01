Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686C34EE6B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244530AbiDAD2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiDAD2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:28:18 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D91422475B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 20:26:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V8mHSk5_1648783586;
Received: from 30.225.28.173(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0V8mHSk5_1648783586)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 01 Apr 2022 11:26:26 +0800
Message-ID: <eb284c91-dbcf-d034-dce7-6eedaa055552@linux.alibaba.com>
Date:   Fri, 1 Apr 2022 11:26:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND] uio/uio_pci_generic: Introduce refcnt on
 open/release
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        alikernel-developer@linux.alibaba.com, gang.cao@intel.com
References: <1648693432-129409-1-git-send-email-yaohongbo@linux.alibaba.com>
 <20220331162952-mutt-send-email-mst@kernel.org>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20220331162952-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/1 4:30, Michael S. Tsirkin 写道:
> On Thu, Mar 31, 2022 at 10:23:52AM +0800, Yao Hongbo wrote:
>> If two userspace programs both open the PCI UIO fd, when one
>> of the program exits uncleanly, the other will cause IO hang
>> due to bus-mastering disabled.
> With two programs poking at the same device, how is this ever
> supposed to work even while both are alive?

When using dpdk/spdk, there may be one primary process with multiple
secondary processes while they can use same virtual address to access
the same hugepage memory and device BAR(the primary process mmap hugepge
and device BAR, record the relation between virtual and physical address,
then the multi secondary processes will do the MAP_FIXED mmap). With this
method, we can solve many troublesome problems. So there may be many
processes own the same deivce at the same time.

The SPDK links:
https://spdk.io/doc/app_overview.html

"Multi process mode
When --shm-id is specified, the application is started in multi-process 
mode.

Applications using the same shm-id share their memory and NVMe devices.

The first app to start with a given id becomes a primary process, with 
the rest,

called secondary processes, only attaching to it. When the primary 
process exits,

the secondary ones continue to operate, but no new processes can be 
attached

at this point. All processes within the same shm-id group must use the 
same --single-file-segments setting."

>> It's a common usage for spdk/dpdk to use UIO. So, introduce refcnt
>> to avoid such problems.
>>
>> Fixes: 865a11f("uio/uio_pci_generic: Disable bus-mastering on release")
>> Reported-by: Xiu Yang <yangxiu.yx@alibaba-inc.com>
>> Signed-off-by: Yao Hongbo <yaohongbo@linux.alibaba.com>
>> ---
>>   drivers/uio/uio_pci_generic.c | 16 +++++++++++++++-
>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/uio/uio_pci_generic.c b/drivers/uio/uio_pci_generic.c
>> index e03f9b5..8add2cf 100644
>> --- a/drivers/uio/uio_pci_generic.c
>> +++ b/drivers/uio/uio_pci_generic.c
>> @@ -31,6 +31,7 @@
>>   struct uio_pci_generic_dev {
>>   	struct uio_info info;
>>   	struct pci_dev *pdev;
>> +	atomic_t refcnt;
>>   };
>>   
>>   static inline struct uio_pci_generic_dev *
>> @@ -39,6 +40,14 @@ struct uio_pci_generic_dev {
>>   	return container_of(info, struct uio_pci_generic_dev, info);
>>   }
>>   
>> +static int open(struct uio_info *info, struct inode *inode)
>> +{
>> +	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
>> +
>> +	atomic_inc(&gdev->refcnt);
>> +	return 0;
>> +}
>> +
>>   static int release(struct uio_info *info, struct inode *inode)
>>   {
>>   	struct uio_pci_generic_dev *gdev = to_uio_pci_generic_dev(info);
>> @@ -51,7 +60,9 @@ static int release(struct uio_info *info, struct inode *inode)
>>   	 * Note that there's a non-zero chance doing this will wedge the device
>>   	 * at least until reset.
>>   	 */
>> -	pci_clear_master(gdev->pdev);
>> +	if (atomic_dec_and_test(&gdev->refcnt))
>> +		pci_clear_master(gdev->pdev);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -92,8 +103,11 @@ static int probe(struct pci_dev *pdev,
>>   
>>   	gdev->info.name = "uio_pci_generic";
>>   	gdev->info.version = DRIVER_VERSION;
>> +	gdev->info.open = open;
>>   	gdev->info.release = release;
>>   	gdev->pdev = pdev;
>> +	atomic_set(&gdev->refcnt, 0);
>> +
>>   	if (pdev->irq && (pdev->irq != IRQ_NOTCONNECTED)) {
>>   		gdev->info.irq = pdev->irq;
>>   		gdev->info.irq_flags = IRQF_SHARED;
>> -- 
>> 1.8.3.1

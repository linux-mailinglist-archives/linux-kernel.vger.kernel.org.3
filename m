Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFBE596A47
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiHQHU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQHUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:20:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BC86E888
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660720852; x=1692256852;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rzGWskO+7SbZcBTwGa/L5Pm0RSFGECEGooXJW/tWynE=;
  b=UtS10bxPi4Yqi/jvrwc8J1iLn8D2EJscLbemiSzpZfwIPC1JeAMRI589
   lLCDYRTd53wr67SkPquWRnyKUDaTQMjL40WNEs3Lz8E3cB2WF+uET9nY4
   ntUxHMPodwUhPi1VQ75a1J1yHbrT/T0tlBQ17SV9ezG/LlUQADpLq5HS0
   LWTbWaDAv6lpXBY69Amspf7pLxRx+p0azf6fyh0gxf5OR64I98FUP8ucd
   pDaeTG+/ZI1ZFla7KJnUq91Ocbz+6yyrB6u+xUKg5E0uVzMpFFe02F5GW
   68dx2Vs6ujwlp1JlNpm0sYfyM2KxUwl5rA7fTmR97zKGjFgrFNmvbJgkO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378716433"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378716433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 00:20:52 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667487039"
Received: from jzhan60-mobl1.ccr.corp.intel.com (HELO [10.254.209.228]) ([10.254.209.228])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 00:20:48 -0700
Message-ID: <37ba5f53-079f-c04b-5c3e-678c87bbe0ff@linux.intel.com>
Date:   Wed, 17 Aug 2022 15:20:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sashal@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org,
        Scarlett Gourley <scarlett@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Jack O'Sullivan <jack@arista.com>
Subject: Re: lockdep splat due to klist iteration from atomic context in Intel
 IOMMU driver
Content-Language: en-US
To:     Lennert Buytenhek <buytenh@wantstofly.org>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
 <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
 <YvpQ5M7//AlrpJGP@wantstofly.org>
 <94921c7a-778c-911d-4d72-d7815d95c46b@linux.intel.com>
 <YvyGNeIQTrM4w/fY@wantstofly.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YvyGNeIQTrM4w/fY@wantstofly.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/17 14:09, Lennert Buytenhek wrote:
> On Wed, Aug 17, 2022 at 12:04:10PM +0800, Baolu Lu wrote:
> 
>>>>> On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
>>>>> CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
>>>>> below when an I/O page fault occurs on a machine with an Intel
>>>>> IOMMU in it.
>>>>>
>>>>> The issue seems to be the klist iterator functions using
>>>>> spin_*lock_irq*() but the klist insertion functions using
>>>>> spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
>>>>> over klists from atomic (hardirq) context as of commit 8ac0b64b9735
>>>>> ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
>>>>> when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
>>>>> pci_get_domain_bus_and_slot() calls into bus_find_device() which
>>>>> iterates over klists.
>>>>>
>>>>> I found this commit from 2018:
>>>>>
>>>>> 	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
>>>>> 	Author: Bart Van Assche<bvanassche@acm.org>
>>>>> 	Date:   Fri Jun 22 14:54:49 2018 -0700
>>>>>
>>>>> 	    scsi: klist: Make it safe to use klists in atomic context
>>>>>
>>>>> This commit switched lib/klist.c:klist_{prev,next} from
>>>>> spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
>>>>> the spin_{,un}lock() calls in add_{head,tail}() untouched.
>>>>>
>>>>> The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
>>>>> over to use the IRQ-safe spinlock variants as well?
>>>> Another possibility would be to evaluate whether it is safe to revert commit
>>>> 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic context").
>>>> That commit is no longer needed by the SRP transport driver since the legacy
>>>> block layer has been removed from the kernel.
>>> And then to fix the 6.0-rc1 iommu/vt-d lockdep splat with
>>> CONFIG_INTEL_IOMMU_DEBUGFS enabled, we could convert the Intel DMAR
>>> IRQ handler to a threaded IRQ handler.  We (Arista) carry the patch
>>> below in our kernel tree, and the last two hunks of the patch do
>>> exactly that, for the same reason (having to call
>>> pci_get_domain_bus_and_slot() from the IRQ handler) but this is
>>> probably too big of a change for 6.0-rc.
>>>
>>>
>>>
>>> commit 90a8e7da0facf198692a641fcfe6f89c478608e0
>>> Author: Lennert Buytenhek<buytenh@wantstofly.org>
>>> Date:   Wed Jul 13 15:34:30 2022 +0300
>>>
>>>       iommu/vt-d: Use report_iommu_fault()
>>>       This patch makes iommu/vt-d call report_iommu_fault() when an I/O
>>>       page fault occurs, which has two effects:
>>>       1) It allows device drivers to register a callback to be notified
>>>          of I/O page faults, via the iommu_set_fault_handler() API.
>>>       2) It triggers the io_page_fault tracepoint in report_iommu_fault()
>>>          when an I/O page fault occurs.
>>>       The latter point is the main aim of this patch, as it allows
>>>       rasdaemon-like daemons to be notified of I/O page faults, and to
>>>       possibly initiate corrective action in response.
>>
>> The IOMMU subsystem already has a framework to handle I/O page faults:
>>
>>      commit fc36479db74e9 "iommu: Add a page fault handler"
>>
>> And below series,
>>
>> https://lore.kernel.org/linux-iommu/20220817012024.3251276-1-baolu.lu@linux.intel.com/
>>
>> is trying to make it more generic. It seems to be more suitable for your
>> case.
>>
>> The report_iommu_fault() probably will be replaced by
>> iommu_register_device_fault_handler() eventually. So I don't encourage
>> its usage in the VT-d driver.
> 
> We use the iommu/io_page_fault tracepoint from userspace to be notified
> of (non-ATS) I/O page faults so that we can detect malfunctioning PCIe
> devices, which in our systems are typically switch/router line cards,
> and take corrective action, such as restarting the offending line card.

Yes. Make sense.

> 
> Calling report_iommu_fault() causes the iommu/io_page_fault tracepoint
> to be invoked, which is why we made the AMD and Intel IOMMU drivers use
> report_iommu_fault() in our kernel tree.

Can iommu_register_device_fault_handler() also serve your case?
report_iommu_fault() is domain based, while the former is device based.

> 
> It seems that iommu_queue_iopf() is specific to the SVA use case, while
> we are not using SVA, in which case it would not address our use case.
> (We don't care about knowing about ATS translation faults, we just want
> to know when a non-ATS PCI device is malfunctioning.)

The iommu_queue_iopf() is for recoverable I/O page fault. Your case only
cares about unrecoverable DMA faults. So it's not suitable for you.
Sorry for the misunderstanding.

Best regards,
baolu

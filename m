Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576394FB9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbiDKKpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiDKKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:45:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 051C642EE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:43:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5B131692;
        Mon, 11 Apr 2022 03:43:30 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 888913F5A1;
        Mon, 11 Apr 2022 03:43:29 -0700 (PDT)
Message-ID: <97c6b2e1-3d9f-bf03-a14e-df3249d166dd@arm.com>
Date:   Mon, 11 Apr 2022 11:43:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] habanalabs: Stop using iommu_present()
Content-Language: en-GB
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
References: <8201946a5b8b26dab35738b87da24ff27a9f9270.1649166391.git.robin.murphy@arm.com>
 <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAFCwf10bwtpC=syFgcz8Ym5S797x3wmkGx3RFnUNkSsjdeyGgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-10 11:59, Oded Gabbay wrote:
> On Tue, Apr 5, 2022 at 4:46 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Even if an IOMMU might be present for some PCI segment in the system,
>> that doesn't necessarily mean it provides translation for the device
>> we care about. Replace iommu_present() with a more appropriate check.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/misc/habanalabs/gaudi/gaudi.c | 8 ++++----
>>   drivers/misc/habanalabs/goya/goya.c   | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
>> index 21c2b678ff72..5dc66dc7618e 100644
>> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
>> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
>> @@ -6133,7 +6133,7 @@ static int gaudi_debugfs_read32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>> @@ -6176,7 +6176,7 @@ static int gaudi_debugfs_write32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>> @@ -6223,7 +6223,7 @@ static int gaudi_debugfs_read64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>> @@ -6268,7 +6268,7 @@ static int gaudi_debugfs_write64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>
>>                  *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>> diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
>> index ec9358bcbf0b..0c455bf460f4 100644
>> --- a/drivers/misc/habanalabs/goya/goya.c
>> +++ b/drivers/misc/habanalabs/goya/goya.c
>> @@ -4309,7 +4309,7 @@ static int goya_debugfs_read32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *val = *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>>          } else {
>> @@ -4369,7 +4369,7 @@ static int goya_debugfs_write32(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *(u32 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>>          } else {
>> @@ -4418,7 +4418,7 @@ static int goya_debugfs_read64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *val = *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE);
>>
>>          } else {
>> @@ -4465,7 +4465,7 @@ static int goya_debugfs_write64(struct hl_device *hdev, u64 addr,
>>                          rc = -EIO;
>>
>>          } else if (addr >= HOST_PHYS_BASE && addr < host_phys_end &&
>> -                       user_address && !iommu_present(&pci_bus_type)) {
>> +                       user_address && !device_iommu_mapped(&hdev->pdev->dev)) {
>>                  *(u64 *) phys_to_virt(addr - HOST_PHYS_BASE) = val;
>>
>>          } else {
>> --
>> 2.28.0.dirty
>>
> 
> Hi Robin,
> Can you please rebase this over the latest habanalabs-next ?
> The code was totally changed, but I think your core change is
> definitely relevant.

Oh, lovely, that makes for a much nicer patch indeed! I'll spin a v2 
shortly.

Thanks,
Robin.

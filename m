Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BAA4DB3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356873AbiCPOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356875AbiCPOua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:50:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 175D43A73B;
        Wed, 16 Mar 2022 07:49:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE0221476;
        Wed, 16 Mar 2022 07:49:14 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37FB73F766;
        Wed, 16 Mar 2022 07:49:13 -0700 (PDT)
Message-ID: <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
Date:   Wed, 16 Mar 2022 14:49:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        mario.limonciello@amd.com, hch@lst.de
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjHb1xCx4UAmUjrR@lahna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-16 12:45, Mika Westerberg wrote:
> Hi Robin,
> 
> On Wed, Mar 16, 2022 at 11:25:51AM +0000, Robin Murphy wrote:
>> Even if an IOMMU might be present for some PCI segment in the system,
>> that doesn't necessarily mean it provides translation for the device
>> we care about. Furthermore, the presence or not of one firmware flag
>> doesn't imply anything about the IOMMU driver's behaviour, which may
>> still depend on other firmware properties and kernel options too. What
>> actually matters is whether an IOMMU is enforcing protection for our
>> device - regardless of whether that stemmed from firmware policy, kernel
>> config, or user control - at the point we need to decide whether to
>> authorise it. We can ascertain that generically by simply looking at
>> whether we're currently attached to a translation domain or not.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> I don't have the means to test this, but I'm at least 80% confident
>> in my unpicking of the structures to retrieve the correct device...
>>
>>   drivers/thunderbolt/domain.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
>> index 7018d959f775..5f5fc5f6a09b 100644
>> --- a/drivers/thunderbolt/domain.c
>> +++ b/drivers/thunderbolt/domain.c
>> @@ -257,13 +257,14 @@ static ssize_t iommu_dma_protection_show(struct device *dev,
>>   					 struct device_attribute *attr,
>>   					 char *buf)
>>   {
>> +	struct tb *tb = container_of(dev, struct tb, dev);
>> +	struct iommu_domain *iod = iommu_get_domain_for_dev(&tb->nhi->pdev->dev);
> 
> I wonder if this is the correct "domain"? I mean it's typically no the
> Thunderbolt controller (here tb->nhi->pdev->dev) that needs the
> protection (although in discrete controllers it does get it too) but
> it's the tunneled PCIe topology that we need to check here.
> 
> For instance in Intel with intergrated Thunderbolt we have topology like
> this:
> 
>    Host bridge
>        |
>        +--- Tunneled PCIe root port #1
>        +--- Tunneled PCIe root port #2
>        +--- Thunderbolt host controller (the NHI above)
>        +--- xHCI
> 
> and In case of discrete controllers it looks like this:
> 
>    Host bridge
>        |
>        +--- PCIe root port #x
>                  |
>                  |
>             PCIe switch upstream port
>                  |
> 	        +--- Tunneled PCIe switch downstream port #1
> 	        +--- Tunneled PCIe switch downstream port #2
>          	+--- Thunderbolt host controller (the NHI above)
>          	+--- xHCI
> 
> What we want is to make sure the Tunneled PCIe ports get the full IOMMU
> protection. In case of the discrete above it is also fine if all the
> devices behind the PCIe root port get the full IOMMU protection. Note in
> the integrated all the devices are "siblings".

Ah, OK, I wasn't aware that the NHI isn't even the right thing in the 
first place :(

Is there an easy way to get from the struct tb to a PCI device 
representing the end of its relevant tunnel, or do we have a circular 
dependency problem where the latter won't appear until we've authorised 
it (and thus the IOMMU layer won't know about it yet either)?

Thanks,
Robin.

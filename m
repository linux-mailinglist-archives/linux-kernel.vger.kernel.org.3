Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C34B568B62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbiGFOhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiGFOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:37:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17B8A237E0;
        Wed,  6 Jul 2022 07:37:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DD4106F;
        Wed,  6 Jul 2022 07:37:14 -0700 (PDT)
Received: from [10.57.86.2] (unknown [10.57.86.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D193F792;
        Wed,  6 Jul 2022 07:37:11 -0700 (PDT)
Message-ID: <71835610-7798-5fbe-556a-fc44dc9e168b@arm.com>
Date:   Wed, 6 Jul 2022 15:37:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
 <d6a8e85b-ab7d-f5c9-a8cb-79dd8e68c967@linux.intel.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <d6a8e85b-ab7d-f5c9-a8cb-79dd8e68c967@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-06 03:35, Baolu Lu wrote:
> On 2022/7/6 01:08, Robin Murphy wrote:
>> @@ -202,12 +210,32 @@ int iommu_device_register(struct iommu_device 
>> *iommu,
>>       spin_lock(&iommu_device_lock);
>>       list_add_tail(&iommu->list, &iommu_device_list);
>>       spin_unlock(&iommu_device_lock);
>> +
>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +        struct bus_type *bus = iommu_buses[i];
>> +        int err;
>> +
>> +        if (bus->iommu_ops && bus->iommu_ops != ops) {
>> +            err = -EBUSY;
>> +        } else {
>> +            bus->iommu_ops = ops;
>> +            err = bus_iommu_probe(bus);
>> +        }
>> +        if (err) {
>> +            iommu_device_unregister(iommu);
>> +            return err;
>> +        }
>> +    }
>> +
>>       return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_device_register);
> 
> With bus_set_iommu() retired, my understanding is that now we embrace
> the first-come-first-serve policy for bus->iommu_ops setting. This will
> lead to problem in different iommu_ops for different bus case. Did I
> overlook anything?

This is just formalising the de-facto situation that we don't actually 
have any combination of drivers that could load on the same system 
without already attempting to claim at least one bus in common. It's 
also only temporary until the bus ops are removed completely and we 
fully support multiple drivers coexisting, which only actually takes a 
handful more patches - I've realised I could even bring that change 
*ahead* of the big job of converting iommu_domain_alloc() (I'm not 
convinced that the tree-wide flag-day patch for that I currently have in 
the dev branch is really viable, nor that I've actually got the correct 
device at some of the callsites), although whether it's worth the 
potentially-surprising behaviour that might result I'm less sure.

If we already had systems where in-tree drivers successfully coexisted 
on different buses then I'd have split this up and done something a bit 
more involved to keep a vestigial bus_set_iommu() around until the final 
bus ops removal, but since we don't, it seemed neatest to do all the 
related work in one go.

Thanks,
Robin.

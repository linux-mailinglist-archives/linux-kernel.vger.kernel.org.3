Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB98156A093
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiGGK6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiGGK6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:58:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 793A94D4D7;
        Thu,  7 Jul 2022 03:58:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 946BC1063;
        Thu,  7 Jul 2022 03:58:40 -0700 (PDT)
Received: from [10.57.85.108] (unknown [10.57.85.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 524513F66F;
        Thu,  7 Jul 2022 03:58:38 -0700 (PDT)
Message-ID: <569e97f6-f78c-1eae-1023-2d5e2df2d40f@arm.com>
Date:   Thu, 7 Jul 2022 11:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 04/15] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Cc:     "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1657034827.git.robin.murphy@arm.com>
 <5b9b608af21b3c4353af042355973bac55397962.1657034828.git.robin.murphy@arm.com>
 <BN9PR11MB5276ECD0D25C09D6A3686A3B8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB5276ECD0D25C09D6A3686A3B8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-07 07:51, Tian, Kevin wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Wednesday, July 6, 2022 1:08 AM
>>
>> @@ -202,12 +210,32 @@ int iommu_device_register(struct iommu_device
>> *iommu,
>>   	spin_lock(&iommu_device_lock);
>>   	list_add_tail(&iommu->list, &iommu_device_list);
>>   	spin_unlock(&iommu_device_lock);
>> +
>> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +		struct bus_type *bus = iommu_buses[i];
>> +		int err;
>> +
>> +		if (bus->iommu_ops && bus->iommu_ops != ops) {
>> +			err = -EBUSY;
>> +		} else {
>> +			bus->iommu_ops = ops;
>> +			err = bus_iommu_probe(bus);
>> +		}
>> +		if (err) {
>> +			iommu_device_unregister(iommu);
>> +			return err;
>> +		}
>> +	}
>> +
> 
> Probably move above into a new function bus_iommu_probe_all():
> 
> 	/* probe all buses for devices associated with this iommu */
> 	err = bus_iommu_probe_all();
> 	if (err) {
> 		iommu_device_unregister(iommu);
> 		return err;
> 	}
> 
> Just  my personal preference on leaving logic in iommu_device_register()
> more relevant to the iommu instance itself.

On reflection I think it makes sense to pull the 
iommu_device_unregister() out of the loop anyway - I think that's really 
a left-over from between v1 and v2 when that error case briefly jumped 
to another cleanup loop, before I realised it was actually trivial for 
iommu_device_unregister() to clean up for itself.

However I now see I've also missed another opportunity, and the -EBUSY 
case should be hoisted out of the loop as well, since checking 
iommu_buses[0] is sufficient. Then it's hopefully much clearer that once 
the bus ops go away we'll be left with just a single extra line for the 
loop, as in iommu_device_unregister(). Does that sound reasonable?

> Apart from that:
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Thanks! (and for the others as well)

Robin.

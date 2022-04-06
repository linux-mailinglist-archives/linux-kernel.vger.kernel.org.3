Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0F54F634A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiDFPXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbiDFPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:23:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D010651FD6B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:32:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 832F81516;
        Wed,  6 Apr 2022 05:32:14 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97DBD3F718;
        Wed,  6 Apr 2022 05:32:12 -0700 (PDT)
Message-ID: <d0f6caea-0cd9-d839-c9fb-0fe49c2bad16@arm.com>
Date:   Wed, 6 Apr 2022 13:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Content-Language: en-GB
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220406012334.GZ2120790@nvidia.com>
 <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB52764E3DE16E19D1F1515D008CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-06 06:58, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> Sent: Wednesday, April 6, 2022 9:24 AM
>>
>> On Wed, Apr 06, 2022 at 01:00:13AM +0000, Tian, Kevin wrote:
>>
>>>> Because domains wrap more than just the IOPTE format, they have
>>>> additional data related to the IOMMU HW block itself. Imagine a SOC
>>>> with two IOMMU HW blocks that can both process the CPU IOPTE format,
>>>> but have different configuration.
>>>
>>> Curious. Is it hypothesis or real? If real can you help give a concrete
>>> example?
>>
>> Look at arm_smmu_attach_dev() - the domain has exactly one smmu
>> pointer which contains the base address for the SMMU IP block. If the
>> domain doesn't match the smmu pointer from the struct device it won't
>> allow attaching.
>>
>> I know of ARM SOCs with many copies of the SMMU IP block.
>>
>> So at least with current drivers ARM seems to have this limitation.
>>
> 
> I saw that code, but before this series it is used only for stage-2 instead
> of SVA. and I didn't see similar check in the old sva related paths (though
> it doesn't use domain):
> 
> arm_smmu_master_sva_enable_iopf()
> arm_smmu_master_enable_sva{}
> __arm_smmu_sva_bind()
> 
> If I didn't overlook some trick hiding in the call chain of those functions,
> is there a bug in the existing SMMU sva logic or is it conceptually correct
> to not have such check for SVA?

The current SVA APIs are all device-based, so implicitly reflect 
whichever SMMU instance serves the given device. Once domains come into 
the picture, callers are going to have to be more aware that a domain 
may be specific to a particular IOMMU instance, and potentially allocate 
separate domains for separate devices to represent the same address 
space, much like vfio_iommu_type1_attach_group() does.

It's not really worth IOMMU drivers trying to support a domain spanning 
potentially-heterogeneous instances internally, since they can't 
reasonably know what matters in any particular situation. That's 
primarily why we've never tried to do it in the SMMU drivers. It's a lot 
easier for relevant callers to look at what they get and figure out 
whether any mismatch in capabilities is tolerable or not.

Robin.

> If the former then yes we have to take SMMU IP block into consideration
> thus could have multiple domains per CPU page table. If the latter then
> this is not a valid example for that configuration.
> 
> Which one is correct?
> 
> Thanks
> Kevin

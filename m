Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44A850C2C6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiDVWNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbiDVWNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:13:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAEEB30A430
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:00:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D2B21FB;
        Fri, 22 Apr 2022 12:02:21 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CDF43F73B;
        Fri, 22 Apr 2022 12:02:18 -0700 (PDT)
Message-ID: <9da468bc-e6fd-1d7c-a6ce-69be87a7472a@arm.com>
Date:   Fri, 22 Apr 2022 20:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
Content-Language: en-GB
To:     Krishna Reddy <vdumpa@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "yong.wu@mediatek.com" <yong.wu@mediatek.com>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <PH0PR12MB56475FAF4A2E7DB0AE1C1217B3F79@PH0PR12MB5647.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <PH0PR12MB56475FAF4A2E7DB0AE1C1217B3F79@PH0PR12MB5647.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-22 19:37, Krishna Reddy wrote:
> Good effort to isolate bus config from smmu drivers.
> Reviewed-By: Krishna Reddy <vdumpa@nvidia.com>

Thanks!

> I have an orthogonal question here.
> Can the following code handle the case, where different buses have different type of SMMU instances(like one bus has SMMUv2 and another bus has SMMUv3)?
> If it need to handle the above case, can the smmu device bus be matched with specific bus here and ops set only for that bus?

Not yet, but that is one of the end goals that this is all working 
towards. I think the stuff that I've added to the dev branch[1] today 
should have reached the point where that becomes viable, but I'll need 
to rig up a system to test it next week.

Intermediate solutions aren't worth it because in practice you 
inevitably end up needing both IOMMU drivers to share the platform "bus" 
anyway.

Cheers,
Robin.

[1] https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus

> 
> 
>> +       for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
>> +               struct bus_type *bus = iommu_buses[i];
>> +               const struct iommu_ops *bus_ops = bus->iommu_ops;
>> +               int err;
>> +
>> +               WARN_ON(bus_ops && bus_ops != ops);
>> +               bus->iommu_ops = ops;
>> +               err = bus_iommu_probe(bus);
>> +               if (err) {
>> +                       bus_for_each_dev(bus, NULL, iommu,
>> remove_iommu_group);
>> +                       bus->iommu_ops = bus_ops;
>> +                       return err;
>> +               }
>> +       }
> 
> 
> -KR

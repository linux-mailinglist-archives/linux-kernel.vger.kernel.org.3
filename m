Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5180569EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiGGJ7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbiGGJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:59:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F7E94F197;
        Thu,  7 Jul 2022 02:59:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CC4E1063;
        Thu,  7 Jul 2022 02:59:04 -0700 (PDT)
Received: from [10.57.85.108] (unknown [10.57.85.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 883673F792;
        Thu,  7 Jul 2022 02:59:01 -0700 (PDT)
Message-ID: <f3a7143c-5e89-817a-a33d-7353d51a987d@arm.com>
Date:   Thu, 7 Jul 2022 10:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
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
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <BN9PR11MB5276B6689D88D3D5D57915908C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BN9PR11MB5276B6689D88D3D5D57915908C839@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022-07-07 07:31, Tian, Kevin wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Wednesday, July 6, 2022 1:08 AM
>>
>> The number of bus types that the IOMMU subsystem deals with is small and
>> manageable, so pull that list into core code as a first step towards
>> cleaning up all the boilerplate bus-awareness from drivers. Calling
>> iommu_probe_device() before bus->iommu_ops is set will simply return
>> -ENODEV and not break the notifier call chain, so there should be no
>> harm in proactively registering all our bus notifiers at init time.
>>
> 
> Suppose we miss a check on iommu ops in iommu_release_device():
> 
> 	if (!dev->iommu) <<<<<<<
> 		return;
> 
> 	iommu_device_unlink(dev->iommu->iommu_dev, dev);
> 
> 	ops = dev_iommu_ops(dev);
> 	ops->release_device(dev);
> 
> following the rationale in patch01 a device could be removed when
> it's associated with a known but not registered instance.

No, because at that point the instance is only known internally to the 
driver. As long as it isn't erroneously returned from 
->probe_device(dev), dev->iommu will remain NULL and the rest of the 
core code works as expected.

Thanks,
Robin.

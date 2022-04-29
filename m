Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B33B515357
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376873AbiD2SKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiD2SKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:10:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA3131539
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:06:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E18121063;
        Fri, 29 Apr 2022 11:06:50 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 872E03F73B;
        Fri, 29 Apr 2022 11:06:49 -0700 (PDT)
Message-ID: <1322706e-5905-433b-5bc5-ed44f881b510@arm.com>
Date:   Fri, 29 Apr 2022 19:06:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 03/14] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>, joro@8bytes.org,
        will@kernel.org
Cc:     jean-philippe@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
        gerald.schaefer@linux.ibm.com
References: <cover.1650890638.git.robin.murphy@arm.com>
 <1faba5b5c094379df3d99b8fec924ab50ad75482.1650890638.git.robin.murphy@arm.com>
 <0e459e6e-f236-7a58-970a-a47677a23b44@linux.intel.com>
 <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
In-Reply-To: <fa0d0663-5393-c533-105a-85bd2e9e0649@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 9:50 am, Robin Murphy wrote:
> On 2022-04-29 07:57, Baolu Lu wrote:
>> Hi Robin,
>>
>> On 2022/4/28 21:18, Robin Murphy wrote:
>>> Move the bus setup to iommu_device_register(). This should allow
>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU instances,
>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>
>> I re-fetched the latest patches on
>>
>> https://gitlab.arm.com/linux-arm/linux-rm/-/commits/iommu/bus
>>
>> and rolled back the head to "iommu: Cleanup bus_set_iommu".
>>
>> The test machine still hangs during boot.
>>
>> I went through the code. It seems that the .probe_device for Intel IOMMU
>> driver can't handle the probe replay well. It always assumes that the
>> device has never been probed.
> 
> Hmm, but probe_iommu_group() is supposed to prevent the 
> __iommu_probe_device() call even happening if the device *has* already 
> been probed before :/
> 
> I've still got an old Intel box spare in the office so I'll rig that up 
> and see if I can see what might be going on here...

OK, on a Xeon with two DMAR units, this seems to boot OK with or without 
patch #1, so it doesn't seem to be a general problem with replaying in 
iommu_device_register(), or with platform devices. Not sure where to go 
from here... :/

Cheers,
Robin.

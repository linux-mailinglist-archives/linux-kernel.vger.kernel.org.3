Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D8A4F6067
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbiDFNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbiDFNds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:33:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFAA7273807;
        Wed,  6 Apr 2022 03:33:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EAB223A;
        Wed,  6 Apr 2022 03:32:23 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 923B13F718;
        Wed,  6 Apr 2022 03:32:21 -0700 (PDT)
Message-ID: <0c9a1581-728c-6a5c-b65d-80a4f0948d19@arm.com>
Date:   Wed, 6 Apr 2022 11:32:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] iommu: Introduce device_iommu_capable()
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com,
        iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com
References: <cover.1649089693.git.robin.murphy@arm.com>
 <37ec2f9f67098d0caf60dcec558fbe1756ea2621.1649089693.git.robin.murphy@arm.com>
 <20220406052812.GA10507@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220406052812.GA10507@lst.de>
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

On 2022-04-06 06:28, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 11:41:01AM +0100, Robin Murphy wrote:
>> iommu_capable() only really works for systems where all IOMMU instances
>> are completely homogeneous, and all devices are IOMMU-mapped. Implement
>> the new variant which can give an accurate answer for whichever device
>> the caller is actually interested in.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> v3: New patch; now that the dev_iommu_ops() work has landed we can go
>>      straight to a proper implementation. Also s/dev/device/ to match
>>      the precedent of device_iommu_mapped() for the public API.
> 
> I'm a little worrited about a method with a parameter than can be
> NULL.

FWIW, the intent is that that's only temporary.

> Also usnic, vmd, and vdpa really want to use your new
> device_iommu_capable as they check based on a device.  Just VFIO
> is special as usual..

Indeed, I have those patches in my stack already, I'm just waiting for 
this to land before I think about posting them. Once the DMA ownership 
series lands in parallel, VFIO can also get converted and 
iommu_capable() goes away entirely. At that point I have a patch for the 
Arm SMMU drivers to start actually using the new device argument, but 
Jason's new proposal now puts a twist on that...

On reflection, there's no real need for the internal method to change in 
lock-step with the external interface. I've no objection to holding off 
on adding that new parameter until it's reliably useful, and indeed now 
that I'm looking at it outside the context of the entire cleanup 
mission, that does sound like the right thing to do anyway :)

(also it turns out I need to respin this patch regardless since I 
generated it from the wrong point in my branch, where iommu_present() 
was already gone from the context in iommu.h...)

Cheers,
Robin.

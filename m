Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3529D5ACF1A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiIEJq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiIEJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:46:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E55352089;
        Mon,  5 Sep 2022 02:46:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33595D6E;
        Mon,  5 Sep 2022 02:46:58 -0700 (PDT)
Received: from [10.57.15.199] (unknown [10.57.15.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C99B3F7B4;
        Mon,  5 Sep 2022 02:46:49 -0700 (PDT)
Message-ID: <ca1ba9d8-8d68-5869-9905-fce431ca14f8@arm.com>
Date:   Mon, 5 Sep 2022 10:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     iommu@lists.linux.dev,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-s390@vger.kernel.org, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, joro@8bytes.org,
        will@kernel.org, linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <3b065fb5-3ca7-8f48-bdf7-daf7604312df@arm.com>
 <369ad331-8bdc-d385-a227-f674bd410599@linux.ibm.com>
 <YxEYAcFK0EdahXzJ@nvidia.com>
 <273fdd58-549c-30d4-39a9-85fe631162ba@linux.ibm.com>
 <YxI7kzuchcJz8sRX@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxI7kzuchcJz8sRX@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-02 18:21, Jason Gunthorpe wrote:
> On Fri, Sep 02, 2022 at 01:11:09PM -0400, Matthew Rosato wrote:
>> On 9/1/22 4:37 PM, Jason Gunthorpe wrote:
>>> On Thu, Sep 01, 2022 at 12:14:24PM -0400, Matthew Rosato wrote:
>>>> On 9/1/22 6:25 AM, Robin Murphy wrote:
>>>>> On 2022-08-31 21:12, Matthew Rosato wrote:
>>>>>> With commit fa7e9ecc5e1c ("iommu/s390: Tolerate repeat attach_dev
>>>>>> calls") s390-iommu is supposed to handle dynamic switching between IOMMU
>>>>>> domains and the DMA API handling.  However, this commit does not
>>>>>> sufficiently handle the case where the device is released via a call
>>>>>> to the release_device op as it may occur at the same time as an opposing
>>>>>> attach_dev or detach_dev since the group mutex is not held over
>>>>>> release_device.  This was observed if the device is deconfigured during a
>>>>>> small window during vfio-pci initialization and can result in WARNs and
>>>>>> potential kernel panics.
>>>>>
>>>>> Hmm, the more I think about it, something doesn't sit right about this whole situation... release_device is called via the notifier from device_del() after the device has been removed from its parent bus and largely dismantled; it should definitely not still have a driver bound by that point, so how is VFIO doing things that manage to race at all?
>>>>>
>>>>> Robin.
>>>>
>>>> So, I generally have seen the issue manifest as one of the calls
>>>> into the iommu core from __vfio_group_unset_container
>>>> (e.g. iommu_deatch_group via vfio_type1_iommu) failing with a WARN.
>>>> This happens when the vfio group fd is released, which could be
>>>> coming e.g. from a userspace ioctl VFIO_GROUP_UNSET_CONTAINER.
>>>> AFAICT there's nothing serializing the notion of calling into the
>>>> iommu core here against a device that is simultaneously going
>>>> through release_device (because we don't enter release_device with
>>>> the group mutex held), resulting in unpredictable behavior between
>>>> the dueling attach_dev/detach_dev and the release_device for
>>>> s390-iommu at least.
>>>
>>> Oh, this is a vfio bug.
>>
>> I've been running with your diff applied today on s390 and this
>> indeed fixes the issue by preventing the detach-after-release coming
>> out of vfio.
> 
> Heh, I'm shocked it worked at all
> 
> I've been trying to understand Robin's latest remarks because maybe I
> don't really understand your situation right.

That was really just me thinking out loud to guess at how it must be 
happening - I wasn't sure whether VFIO is actually intended to allow 
that or not, so if not then by all means let's look at fixing that, but 
as I say I think we're only seeing it provoke a problem at the driver 
level because of 9ac8545199a1, and fixing VFIO doesn't fix that in 
general. And conversely if we *can* fix that properly at the IOMMU API 
level then the current VFIO behaviour should become benign again anyway.

> IMHO this is definately a VFIO bug, because in a single-device group
> we must not allow the domain to remain attached past remove(). Or more
> broadly we shouldn't be holding ownership of a group without also
> having a driver attached.

FWIW I was assuming it might be fine for a VFIO user to hold the group 
open if they expect the device to come back again and re-bind (for 
example, perhaps over some reconfiguration that requires turning SR-IOV 
off and on again?)

Cheers,
Robin.

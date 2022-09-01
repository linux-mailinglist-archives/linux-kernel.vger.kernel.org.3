Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A335A9DA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiIARBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbiIARBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:01:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E3726B647;
        Thu,  1 Sep 2022 10:00:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BC00D6E;
        Thu,  1 Sep 2022 10:01:04 -0700 (PDT)
Received: from [10.57.15.167] (unknown [10.57.15.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A9DC3F7B4;
        Thu,  1 Sep 2022 10:00:54 -0700 (PDT)
Message-ID: <31269d99-5ffc-7060-2af2-ce1f5bc33de2@arm.com>
Date:   Thu, 1 Sep 2022 18:00:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
 <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
 <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
 <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com> <YxDDD2DF9KFDQ+Yk@nvidia.com>
 <58d14cfc-f8ba-777b-a975-371ff2b29e5a@arm.com> <YxDUlQprVaZp1RF1@nvidia.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YxDUlQprVaZp1RF1@nvidia.com>
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

On 2022-09-01 16:49, Jason Gunthorpe wrote:
> On Thu, Sep 01, 2022 at 04:03:36PM +0100, Robin Murphy wrote:
>> On 2022-09-01 15:34, Jason Gunthorpe wrote:
>>> On Thu, Sep 01, 2022 at 03:29:16PM +0100, Robin Murphy wrote:
>>>
>>>> Right, the next step would be to bridge that gap to iommu-dma to dump the
>>>> flush queue when IOVA allocation failure implies we've reached the
>>>> "rollover" point, and perhaps not use the timer at all. By that point a
>>>> dedicated domain type, or at least some definite internal flag, for this
>>>> alternate behaviour seems like the logical way to go.
>>>
>>> At least on this direction, I've been thinking it would be nice to
>>> replace the domain type _FQ with a flag inside the domain, maybe the
>>> ops, saying how the domain wants the common DMA API to operate. If it
>>> wants FQ mode or other tuning parameters
>>
>> Compare the not-necessarily-obvious matrix of "strict" and "passthrough"
>> command-line parameters with the nice understandable kconfig and sysfs
>> controls for a reminder of why I moved things *from* that paradigm in the
>> first place ;)
> 
> I'm looking at it from a code perspective, where the drivers don't
> seem to actually care about DMA_FQ. eg search for it in the drivers
> and you mostly see:
> 
> 	    (type != IOMMU_DOMAIN_DMA && type != IOMMU_DOMAIN_DMA_FQ))
> 
> The exception is domain_alloc which fails in cases where the domain
> doesn't 'support' FQ.
> 
> But support FQ or not can be cast as a simple capability flag in the
> domain. We don't need a whole type for the driver to communicate it.

Right, since the rest of DMA domain setup got streamlined into the core 
code this one remaining vestige of the old world order is ripe for 
cleanup, I've just had bigger fish to fry. Or as the case may be, bigger 
chunks of repetitive boilerplate to remove from elsewhere in the drivers :)

> The strictness level belongs completely in the core code, it shouldn't
> leak into the driver.

It's already not about drivers having any influence on strictness, it's 
about there being good reason to treat these as distinct domain types 
through the core code, and as things stand those domain types are 
exposed to drivers, so drivers need to not freak out at seeing them. 
Indeed Any driver can "support" IOMMU_DOMAIN_DMA now, so if you've got 
time to come up with a way of making that completely transparent to 
drivers then please go ahead, though IIRC there were one or two cases 
where folks explicitly *didn't* want it being used, so those might need 
proper IOMMU_DOMAIN_IDENTITY support and a def_domain_type override adding.

The thing with IOMMU_DOMAIN_DMA_FQ is that drivers *do* need to somehow 
indicate that they implement the relevant optimisations in their unmap 
path, otherwise using a flush queue is objectively worse in every 
respect than not using a flush queue. Given the status quo, rejecting 
the domain type at allocation was by far the simplest and most obvious 
way to achieve that. Once again, please do propose moving it to a more 
explicit "I can support deferred unmap" driver capability if you'd like, 
otherwise I'll get there eventually.

Thanks,
Robin.

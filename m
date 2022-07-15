Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA59257629B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGONMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:12:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF9BD71BE3;
        Fri, 15 Jul 2022 06:12:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7E271474;
        Fri, 15 Jul 2022 06:12:43 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629253F70D;
        Fri, 15 Jul 2022 06:12:41 -0700 (PDT)
Message-ID: <f0374374-1f3b-6beb-b7e9-f8071d48bf4d@arm.com>
Date:   Fri, 15 Jul 2022 14:12:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 00/15] iommu: Retire bus_set_iommu()
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>
References: <cover.1657034827.git.robin.murphy@arm.com>
In-Reply-To: <cover.1657034827.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-05 18:08, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1650890638.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> Here's v3, now with working x86! Having finally made sense of how I
> broke Intel, I've given AMD the same fix by inspection. I'm still not
> 100% sure about s390, but it looks like it should probably be OK since
> it seems to register an IOMMU instance for each PCI device (?!) before
> disappearing into PCI hotplug code, wherein I assume we should never see
> a PCI device appear without its IOMMU already registered.
> 
> Otherwise, the only other updates are hooking up the new host1x context
> bus (noting that it now takes all of 4 lines to support a whole new bus,
> yay!), and a slight tweak to make sure we keep rejecting registration of
> conflicting iommu_ops rather than needlessly change that just yet.

FWIW I've prepared v4, including Matt's s390 patch and some nice extra 
cleanups thanks to Kevin's suggestions, but have now decided to wait to 
rebase and send it after the upcoming merge window. If anyone's 
interested in the meantime, there's a preliminary branch here:

https://gitlab.arm.com/linux-arm/linux-rm/-/commits/bus-set-iommu-v4

(temporarily including the host1x patch from -next to avoid breakage on 
arm64 as well)

Thanks,
Robin.

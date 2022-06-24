Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F9559CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiFXOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiFXOyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:54:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 052218894E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:49:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5317F1042;
        Fri, 24 Jun 2022 07:49:52 -0700 (PDT)
Received: from [10.57.84.111] (unknown [10.57.84.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35F0D3F534;
        Fri, 24 Jun 2022 07:49:51 -0700 (PDT)
Message-ID: <809b0d12-c5ce-2364-268f-f0c4564414c9@arm.com>
Date:   Fri, 24 Jun 2022 15:49:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org> <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
 <YrRPfhXvdPo0Y6Cx@8bytes.org> <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
 <YrW76PPKadbZuN/3@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YrW76PPKadbZuN/3@8bytes.org>
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

On 2022-06-24 14:28, Joerg Roedel wrote:
> On Thu, Jun 23, 2022 at 12:41:00PM +0100, Robin Murphy wrote:
>> On 2022-06-23 12:33, Joerg Roedel wrote:
>>> On Wed, Jun 22, 2022 at 02:12:39PM +0100, Robin Murphy wrote:
>>>> Thanks for your bravery!
>>>
>>> It already starts, with that patch I am getting:
>>>
>>> 	xhci_hcd 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xff00ffffffefe000 flags=0x0000]
>>>
>>> In my kernel log. The device is an AMD XHCI controller and seems to
>>> funciton normally after boot. The message disappears with
>>> iommu.forcedac=0.
>>>
>>> Need to look more into that...
>>
>> Given how amd_iommu_domain_alloc() sets the domain aperture, presumably the
>> DMA address allocated was 0xffffffffffefe000? Odd that it gets bits punched
>> out in the middle rather than simply truncated off the top as I would have
>> expected :/
> 
> So even more weird, as a workaround I changed the AMD IOMMU driver to
> allocate a 4-level page-table and limit the DMA aperture to 48 bits. I
> still get the same message.

Hmm, in that case my best guess would be that somewhere between the 
device itself and the IOMMU input it's trying to sign-extend the address 
from bit 47 or lower, but for whatever reason bits 55:48 get lost.

Comparing the PCI xHCI I have to hand, mine (with nothing plugged in) 
only has 6 pages mapped for its command ring and other stuff. Thus 
unless it's sharing that domain with other devices, to be accessing 
something down in the second MB of IOVA space suggests that this 
probably isn't the very first access it's made, and therefore it would 
almost certainly have to be the endpoint emitting a corrupted address, 
but only for certain operations.

FWIW I'd be inclined to turn on DMA debug and call 
debug_dma_dump_mappings() from the IOMMU fault handler, and/or add a bit 
of tracing to all the DMA mapping/allocation sites in the xHCI driver, 
to see what the offending address most likely represents.

Robin.

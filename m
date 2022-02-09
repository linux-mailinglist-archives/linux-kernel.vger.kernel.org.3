Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614494AFF68
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbiBIVry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:47:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbiBIVru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:47:50 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51B01C1DC2FD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 13:47:52 -0800 (PST)
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id AD64920B9133;
        Wed,  9 Feb 2022 13:47:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD64920B9133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644443271;
        bh=ytV1hXsi6yCY6jSagexbs/gi9N3Tlue4dbEUj+BNvyY=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Ux2uA+KpylogqqibdjPbAEGu3pvyp0rpwP02e2ByJaPlisVc7Gr2S1ir4KLFQdJFP
         Z3QeskZ88vkYvJvSGalcJ9Z4YDJnG4Ouf/YbsmikuVIprGdNkU1rLJQNLuStzb5ZSe
         ILqe8lONrB+9KR6UBmeSCT/1N59Z8UuKULNF14Ls=
Message-ID: <9436d033-579b-55fa-9b00-6f4b661c2dd7@linux.microsoft.com>
Date:   Wed, 9 Feb 2022 13:47:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [arm64] kernel boot slowdown in v5.10.19 -> v5.10.42 update
Content-Language: en-US
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
References: <9a34ee9b-0ede-30a6-0898-d32fe81d5b0c@linux.microsoft.com>
 <YfPcNy3JcnwuJNMx@arm.com>
 <7e43a7e9-f299-1d6d-8b61-425793abcc3e@linux.microsoft.com>
In-Reply-To: <7e43a7e9-f299-1d6d-8b61-425793abcc3e@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2022 10:03 AM, Vijay Balakrishna wrote:
> 
> 
> On 1/28/2022 4:06 AM, Catalin Marinas wrote:
>> On Mon, Jan 24, 2022 at 03:03:48PM -0800, Vijay Balakrishna wrote:
>>> We noticed 150ms kernel boot slowdown back in June, 2021, when moving 
>>> from
>>> v5.10.19 to v5.10.42.  This on a 8GB SoC.  Only recently we investigated
>>> this issue and found the regression is introduced by a change in 
>>> map_mem()
>>> (paging_init() -> map_mem() -> __map_memblock(), in particular "map 
>>> all the
>>> memory banks" for loop) by patch
>>>
>>> 2687275a5843d1089687f08fc64eb3f3b026a169
>>> arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
>>>
>>> above is a follow up to
>>>
>>> 0a30c53573b07d5561457e41fb0ab046cd857da5
>>> arm64: mm: Move reserve_crashkernel() into mem_init())
>>>
>>> which deferred crashkernel reservation into mem_init().
>>>
>>> The ~150ms slowdown disappears on booting without "crashkernel=.." on 
>>> kernel
>>> command-line.
>>
>> Is CONFIG_RODATA_FULL_DEFAULT_ENABLED set in your config file? It may
>> cause the same slowdown. I suspect it's because we end up mapping the
>> RAM at the page granularity so more loops and slightly higher TLB
>> pressure. Not sure we can do much about >
> 
> Catalin,
> 
> Thanks for your reply.
> 
> CONFIG_RODATA_FULL_DEFAULT_ENABLED is not set in our config for boot 
> time performance reasons.

 From following patches, the main source of deferring crash kernel 
reservation is for Raspberry Pi 4, which has no IOMMU.

1a8e1cef7603e218339ac63cb3178b25554524e5
arm64: use both ZONE_DMA and ZONE_DMA32

8424ecdde7df99d5426e1a1fd9f0fb36f4183032
arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges

0a30c53573b07d5561457e41fb0ab046cd857da5
arm64: mm: Move reserve_crashkernel() into mem_init())

2687275a5843d1089687f08fc64eb3f3b026a169
arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required

However above changes introduced slow boot (regression) for platforms 
with IOMMU, for example as I mentioned earlier ~150ms for us.  We don't 
have following configs set for our SoC --

# CONFIG_ZONE_DMA is not set
# CONFIG_ZONE_DMA32 is not set

Can we restore crash kernel reservation (no deferring to mem_init()) for 
platforms with no DMA memory zones?

I can submit a patch.

Thanks,
Vijay



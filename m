Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7564B802E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbiBPFYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:24:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBPFYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:24:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 03E8F7A9A9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:24:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33F7113E;
        Tue, 15 Feb 2022 21:24:24 -0800 (PST)
Received: from [10.163.47.182] (unknown [10.163.47.182])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D5813F66F;
        Tue, 15 Feb 2022 21:24:22 -0800 (PST)
Subject: Re: [PATCH] mm/pages_alloc.c: Don't create ZONE_MOVABLE beyond the
 end of a node
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, jhubbard@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com
References: <20220215025831.2113067-1-apopple@nvidia.com>
 <7b752e06-f345-cbb2-d05c-57e5fc5d8e5a@arm.com>
 <87bkz8d6nc.fsf@nvdebian.thelocal>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <370f7851-98b9-5812-7e3d-fea8053fb82c@arm.com>
Date:   Wed, 16 Feb 2022 10:54:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87bkz8d6nc.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 10:46 AM, Alistair Popple wrote:
> Anshuman Khandual <anshuman.khandual@arm.com> writes:
> 
>> Hi Alistair,
>>
>> On 2/15/22 8:28 AM, Alistair Popple wrote:
>>> ZONE_MOVABLE uses the remaining memory in each node. It's starting pfn
>>> is also aligned to MAX_ORDER_NR_PAGES. It is possible for the remaining
>>> memory in a node to be less than MAX_ORDER_NR_PAGES, meaning there is
>>> not enough room for ZONE_MOVABLE on that node.
>>
>> How plausible is this scenario on normal systems ?
> 
> Probably not very. I happened to run into this on my development/test x86 VM
> which has 8GB and was booted with `numa=fake=4 kernelcore=60%` but in theory I
> guess any system that has a node with less than MAX_ORDER_NR_PAGES left over for
> ZONE_MOVABLE may be susceptible.
> 
> This was the RAM map:
> 
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffddfff] usable
> [    0.000000] BIOS-e820: [mem 0x000000007ffde000-0x000000007fffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fffffff] usable
> 
> [...]
> 
> [    0.065897] Early memory node ranges
> [    0.065898]   node   0: [mem 0x0000000000001000-0x000000000009efff]
> [    0.065900]   node   0: [mem 0x0000000000100000-0x000000007ffddfff]
> [    0.065902]   node   1: [mem 0x0000000100000000-0x000000017fffffff]
> [    0.065904]   node   2: [mem 0x0000000180000000-0x00000001ffffffff]
> [    0.065906]   node   3: [mem 0x0000000200000000-0x000000027fffffff]
> 
> Note the reserved range from 0x000000007ffde000 to 0x000000007fffffff resulting
> in node-0 ending at 0x000000007ffddfff.
> 
>> Should not the node always contain MAX_ORDER_NR_PAGES aligned pages ? Also all
>> zones which get created from that node should also be MAX_ORDER_NR_PAGES
>> aligned ?
> 
> I'm not sure why that would be case given page size and MAX_ORDER_NR_PAGES can
> be set via a kernel configuration parameter. Obviously it wasn't the case here

I assumed that in general that would be the case.

> or this situation would not arise. That said I don't know this code well, and
> this was where I decided to stop shaving this yak so it's possible there is an
> even deeper underlying issue.
> 
> Either way I don't *think* the fix should introduce any problems as it shouldn't
> do anything unless you were going to hit this issue anyway (which took sometime
> to track down as the cause wasn't obvious).

Fair enough.

> 
>> I am just curious how a node could end up being like this.
> 
> - Anshuman
> 

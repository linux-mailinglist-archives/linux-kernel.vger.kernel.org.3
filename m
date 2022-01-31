Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415C64A3CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 04:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiAaDft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 22:35:49 -0500
Received: from foss.arm.com ([217.140.110.172]:54302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbiAaDfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 22:35:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA62BED1;
        Sun, 30 Jan 2022 19:35:47 -0800 (PST)
Received: from [10.163.44.9] (unknown [10.163.44.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6B53F774;
        Sun, 30 Jan 2022 19:35:45 -0800 (PST)
Subject: Re: [RFC V1 00/31] mm/mmap: Drop protection_map[] and platform's
 __SXXX/__PXXX requirements
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
 <YfKSXXTZOa9FYug8@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <45a5562d-9eaa-b9ea-62e0-4518e5a09046@arm.com>
Date:   Mon, 31 Jan 2022 09:05:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YfKSXXTZOa9FYug8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/22 6:08 PM, Mike Rapoport wrote:
> Hi Anshuman,
> 
> On Mon, Jan 24, 2022 at 06:26:37PM +0530, Anshuman Khandual wrote:
>> protection_map[] is an array based construct that translates given vm_flags
>> combination. This array contains page protection map, which is populated by
>> the platform via [__S000 .. __S111] and [__P000 .. __P111] exported macros.
>> Primary usage for protection_map[] is for vm_get_page_prot(), which is used
>> to determine page protection value for a given vm_flags. vm_get_page_prot()
>> implementation, could again call platform overrides arch_vm_get_page_prot()
>> and arch_filter_pgprot(). Some platforms override protection_map[] that was
>> originally built with __SXXX/__PXXX with different runtime values.
>>
>> Currently there are multiple layers of abstraction i.e __SXXX/__PXXX macros
>> , protection_map[], arch_vm_get_page_prot() and arch_filter_pgprot() built
>> between the platform and generic MM, finally defining vm_get_page_prot().
>>
>> Hence this series proposes to drop all these abstraction levels and instead
>> just move the responsibility of defining vm_get_page_prot() to the platform
>> itself making it clean and simple.
>>
>> This first introduces ARCH_HAS_VM_GET_PAGE_PROT which enables the platforms
>> to define custom vm_get_page_prot(). This starts converting platforms that
>> either change protection_map[] or define the overrides arch_filter_pgprot()
>> or arch_vm_get_page_prot() which enables for those constructs to be dropped
>> off completely. This series then converts remaining platforms which enables
>> for __SXXX/__PXXX constructs to be dropped off completely. Finally it drops
>> the generic vm_get_page_prot() and then ARCH_HAS_VM_GET_PAGE_PROT as every
>> platform now defines their own vm_get_page_prot().
>
> I generally like the idea, I just think the conversion can be more straight
> forward. Rather than adding ARCH_HAS_VM_GET_PAGE_PROT and then dropping it,
> why won't me make the generic vm_get_page_prot() __weak, then add per-arch
> implementation and in the end drop the generic one?
>  

Is not the ARCH_HAS_ config based switch over a relatively better method ?
IIUC some existing platform overrides could have been implemented via __weak
identifier, although ARCH_HAS_ method was preferred. But I might be missing
something here.

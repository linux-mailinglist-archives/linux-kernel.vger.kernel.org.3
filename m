Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2C649FFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbiA1SDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:03:12 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39850 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbiA1SDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:03:10 -0500
Received: from [192.168.4.54] (cpe-70-95-196-11.san.res.rr.com [70.95.196.11])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4682F20B6C61;
        Fri, 28 Jan 2022 10:03:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4682F20B6C61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1643392990;
        bh=/9TOwSAoGVbx8hS7SR2Oi23UapkFcqkZvPEYeZBtjEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lXu/KJtLZ+9037LJ+S/f+kdDYD/lMoxKjUrZW1DVsRKRHvJv1b6PAm50IFehDQl0a
         DlbI/JcXX0VsJeeiXAb06XWJFveXF/NYBn0HcnUTDeuyLRTo896NCGxi4Fv60/iUlM
         rnGVN3XBsb5ibhRlC2cBlElHLY+jV8q2kHgcgTU8=
Message-ID: <7e43a7e9-f299-1d6d-8b61-425793abcc3e@linux.microsoft.com>
Date:   Fri, 28 Jan 2022 10:03:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [arm64] kernel boot slowdown in v5.10.19 -> v5.10.42 update
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
References: <9a34ee9b-0ede-30a6-0898-d32fe81d5b0c@linux.microsoft.com>
 <YfPcNy3JcnwuJNMx@arm.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <YfPcNy3JcnwuJNMx@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/2022 4:06 AM, Catalin Marinas wrote:
> On Mon, Jan 24, 2022 at 03:03:48PM -0800, Vijay Balakrishna wrote:
>> We noticed 150ms kernel boot slowdown back in June, 2021, when moving from
>> v5.10.19 to v5.10.42.  This on a 8GB SoC.  Only recently we investigated
>> this issue and found the regression is introduced by a change in map_mem()
>> (paging_init() -> map_mem() -> __map_memblock(), in particular "map all the
>> memory banks" for loop) by patch
>>
>> 2687275a5843d1089687f08fc64eb3f3b026a169
>> arm64: Force NO_BLOCK_MAPPINGS if crashkernel reservation is required
>>
>> above is a follow up to
>>
>> 0a30c53573b07d5561457e41fb0ab046cd857da5
>> arm64: mm: Move reserve_crashkernel() into mem_init())
>>
>> which deferred crashkernel reservation into mem_init().
>>
>> The ~150ms slowdown disappears on booting without "crashkernel=.." on kernel
>> command-line.
> 
> Is CONFIG_RODATA_FULL_DEFAULT_ENABLED set in your config file? It may
> cause the same slowdown. I suspect it's because we end up mapping the
> RAM at the page granularity so more loops and slightly higher TLB
> pressure. Not sure we can do much about >

Catalin,

Thanks for your reply.

CONFIG_RODATA_FULL_DEFAULT_ENABLED is not set in our config for boot 
time performance reasons.

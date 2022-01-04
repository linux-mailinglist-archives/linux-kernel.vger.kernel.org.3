Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3FF483B3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 05:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbiADEQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 23:16:10 -0500
Received: from foss.arm.com ([217.140.110.172]:55094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbiADEQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 23:16:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB8C1FB;
        Mon,  3 Jan 2022 20:16:08 -0800 (PST)
Received: from [10.163.72.72] (unknown [10.163.72.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3B673F66F;
        Mon,  3 Jan 2022 20:16:06 -0800 (PST)
Subject: Re: [PATCH V2] arm64/mm/hotplug: Warn when memory limit has been
 reduced
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <1641190916-24751-1-git-send-email-anshuman.khandual@arm.com>
 <bd3f2157-858c-b091-0982-12c425b2029a@redhat.com>
 <c4104b5d-45b8-732a-45e9-0a1cb4954dde@arm.com>
 <d8753c88-95f3-75ec-d6b6-27105a9a5968@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <749bfac7-00b9-0350-18b7-2c3388646853@arm.com>
Date:   Tue, 4 Jan 2022 09:46:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d8753c88-95f3-75ec-d6b6-27105a9a5968@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/22 6:27 PM, David Hildenbrand wrote:
> 
>>> Via which mechanism would the unplug of that memory happen? On arm64,
>>> this should only be possible via ACPI, when unplugging a DIMM that was
>>> available since boot.
>>>
>>> But won't acpi_memory_enable_device() try adding that memory while
>>> ignoring the memory limit? And adding should work, no?
>>
>> Adding that memory via hotplug into the kernel first ? In that case
>> removal would still go via the kernel and user would know about it.
> 
> Can we please add details on how to actually trigger it (below) to the
> patch description? Otherwise it's really hard to get about which senario
> we do care, and about which we don't care.

Sure, will try and add those details in the commit message.

> 
>>
>>>
>>> Can you share some details on how to trigger this on arm64?
>>
>> The primary scenario this proposal is targeted towards is when boot
>> memory is set aside from the host, hot-plugged back into the kernel
>> and repurposed (via hotplug-hotremove path) for guest kernel usage.
>> This new warning would reassert that "mem=" cmdline option is debug
>> only on arm64 platform, and should not be used for production.
> Let me get this straight:
> 
> 1. Restrict physical memory to use via "mem="
> 
> -> Some boot memory is !present and, therefore !early
> 
> 2. Hotplug that memory to the kernel
> 
> -> How?
> 
> a) dax/kmem? Does not apply I think.
> b) DIMM? Does not apply I think.
> c) CONFIG_ARCH_MEMORY_PROBE ?
> 
> 3. Trigger physical hotunplug and actually remove the memory
> 
> -> How?
> 
> 4. kexec; will try using hotunplugged memory
> 
> 

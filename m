Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084154830F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 13:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiACMWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 07:22:31 -0500
Received: from foss.arm.com ([217.140.110.172]:39924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbiACMWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 07:22:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D720C1FB;
        Mon,  3 Jan 2022 04:22:29 -0800 (PST)
Received: from [10.163.71.229] (unknown [10.163.71.229])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C61ED3F5A1;
        Mon,  3 Jan 2022 04:22:27 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2] arm64/mm/hotplug: Warn when memory limit has been
 reduced
To:     David Hildenbrand <david@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
References: <1641190916-24751-1-git-send-email-anshuman.khandual@arm.com>
 <bd3f2157-858c-b091-0982-12c425b2029a@redhat.com>
Message-ID: <c4104b5d-45b8-732a-45e9-0a1cb4954dde@arm.com>
Date:   Mon, 3 Jan 2022 17:52:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bd3f2157-858c-b091-0982-12c425b2029a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/22 3:25 PM, David Hildenbrand wrote:
> On 03.01.22 07:21, Anshuman Khandual wrote:
>> If the max memory limit has been reduced with 'mem=' kernel command line
>> option, there might be UEFI memory map described memory beyond that limit
>> which could be hot removed. This might be problematic for subsequent kexec
>> kernel which could just access such removed memory.
>>
>> Memory offline notifier exists because there is no other way to block the
>> removal of boot memory, only the offlining (which isn't actually a problem)
>> But with 'mem=', there is no chance to stop such boot memory being offlined
>> as it where never in use by the kernel. As 'mem=' is a debug only option on
>> arm64 platform, just warn for such a situation and move on.
>>
> 
> Hi,
> 
> but why warn on the offlining path?

The proposed change is just a one shot warning which is triggered during
the first memory offlining attempt, explaining potential kexec problems
as the kernel is already running on a trimmed boot memory.

> 
> IIUC, you'd have a layout like
> 
> 
> [ boot memory ][ unused memory ]
>                ^memory_limit

s/unused memory/unused boot memory/ instead as it is present during boot.

> 
> Let's assume "unused memory" corresponds to exactly one DIMM that can
> get hotunplugged. The complete DIMM isn't added to Linux and not online,
> so the offline notifier will never trigger.

Right, it will not trigger the warning. This proposal does not cover such
scenarios, where "unused memory" can just be "hotunplugged" without the
kernel knowing about it. But as the warning is not really dependent on
which exact memory is being offlined, user would still come to know if
there is an offlining attempt for any memory.

We probably might require another patch adding an warning when the boot
memory is trimmed with "mem=" cmdline, irrespective of hotplug support
in the kernel. It would ensure that the user is still warned about any
potential kexec problems, above scenario (i.e "unused memory" getting
"hotunplugged" without kernel knowing about it) might cause.

This patch just adds an warning in case there is an offlining attempt
on a hot-remove enabled kernel.

> 
> Via which mechanism would the unplug of that memory happen? On arm64,
> this should only be possible via ACPI, when unplugging a DIMM that was
> available since boot.
> 
> But won't acpi_memory_enable_device() try adding that memory while
> ignoring the memory limit? And adding should work, no?

Adding that memory via hotplug into the kernel first ? In that case
removal would still go via the kernel and user would know about it.

> 
> Can you share some details on how to trigger this on arm64?

The primary scenario this proposal is targeted towards is when boot
memory is set aside from the host, hot-plugged back into the kernel
and repurposed (via hotplug-hotremove path) for guest kernel usage.
This new warning would reassert that "mem=" cmdline option is debug
only on arm64 platform, and should not be used for production.

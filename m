Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4B4D1F5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbiCHRsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiCHRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:48:16 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5998554A5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:47:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E7E139F;
        Tue,  8 Mar 2022 09:47:19 -0800 (PST)
Received: from [10.57.41.254] (unknown [10.57.41.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A2293FA45;
        Tue,  8 Mar 2022 09:47:17 -0800 (PST)
Message-ID: <8336bc6e-0f11-9cfe-b513-b30858d01cc6@arm.com>
Date:   Tue, 8 Mar 2022 17:47:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Content-Language: en-GB
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, joey.gouly@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
 <87h78a178u.wl-maz@kernel.org>
 <a31431bf-24bb-71ac-8f3c-f9ca19f5c4f0@linux.alibaba.com>
 <87bkyi0x53.wl-maz@kernel.org> <1b94af8b-a294-5765-4e1e-896f70db621f@arm.com>
 <CAK8P3a3zA25=iZkVGPc=V+9tqqsWgQjoD9BSS60foGZtDwsujA@mail.gmail.com>
 <9296f97c-f894-001c-53e6-41bbfe36ce71@arm.com> <YiePz/KpcE/S1+RR@arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YiePz/KpcE/S1+RR@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-08 17:18, Catalin Marinas wrote:
> On Mon, Mar 07, 2022 at 08:05:06PM +0000, Robin Murphy wrote:
>> On 2022-03-07 19:30, Arnd Bergmann wrote:
>>> On Mon, Mar 7, 2022 at 5:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>>
>>>> And arguably it's not even too late, because 10 years ago this *did* say
>>>> "AArch64". I don't remember all the exact details behind commit
>>>> 44b82b7700d0 ("arm64: Fix up /proc/cpuinfo") - this just tickled enough
>>>> of a memory to go and look up the git history - but I don't think we
>>>> changed any of those fields without a real reason.
>>>>
>>>
>>> The patch description does state that this was done for compatibility with
>>> 32-bit architectures, which does make some sense. I suppose for similar
>>> reasons, the arch/arm/ version of /proc/cpuinfo is now stuck at
>>> 'CPU architecture: 7', even for ARMv8 or higher in aarch32 mode.
>>>
>>> The part that I find more annoying is how we leave out the one bit
>>> of information that people are generally looking for in /proc/cpuinfo:
>>> the name of the processor. Even though we already know the
>>> exact processor type in order to handle the CPU errata, this is
>>> always "model name\t: ARMv7 Processor rev %d (v7l)" on 32-bit,
>>> and "model name\t: ARMv8 Processor rev %d (%s)" on 64-bit,
>>> with the revision being the least important bit of information here...
>>
>> Eh, it's hardly impossible to recompose a MIDR value from the implementer,
>> part, variant and revision fields if one actually needs to. Maybe we could
>> null-terminate the raw MIDR value and print it as a string of
>> largely-unprintable characters in the "model name" field... I guess that
>> might satisfy the crowd who want parity* with x86 CPUID, at least :)
> 
> You can get the MIDR from
> /sys/devices/system/cpu/cpu*/regs/identification/midr_el1.
> 
> As for printing the actual names, we thought we'd leave it to tools like
> lscpu. I'm not keen on maintaining a dictionary of MIDR to CPU marketing
> names in the kernel, deal with rebranding and so on. For x86 you can get
> the name from the CPU itself IIUC, that's not the case for arm.

Yes, CPUID reads a string out of the hardware which is the name for the 
*physical product*, which among other things is allegedly useful to 
dissuade unscrupulous people from grinding the markings off and 
re-etching them to fake a higher-spec chip. We obviously can't maintain 
a whole database of SoC names in Linux.

In fact on my x86 box, even lscpu still doesn't tell me what the actual 
CPU cores are other than family 6 model 79, so in that respect Arm 
support is already ahead! :D

Robin.

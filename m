Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBECE4D0483
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiCGQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240721AbiCGQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:50:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6E4824590
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:49:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E206153B;
        Mon,  7 Mar 2022 08:49:14 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4247B3FA45;
        Mon,  7 Mar 2022 08:49:13 -0800 (PST)
Message-ID: <1b94af8b-a294-5765-4e1e-896f70db621f@arm.com>
Date:   Mon, 7 Mar 2022 16:48:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Content-Language: en-GB
To:     Marc Zyngier <maz@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
 <87h78a178u.wl-maz@kernel.org>
 <a31431bf-24bb-71ac-8f3c-f9ca19f5c4f0@linux.alibaba.com>
 <87bkyi0x53.wl-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <87bkyi0x53.wl-maz@kernel.org>
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

On 07/03/2022 12:23 pm, Marc Zyngier wrote:
> On Mon, 07 Mar 2022 12:13:50 +0000,
> Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 3/7/22 4:45 PM, Marc Zyngier wrote:
>>> On Mon, 07 Mar 2022 03:04:17 +0000,
>>> Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
>>>>
>>>> Now, it is unsuitable for both ARMv8 and ARMv9 to show a
>>>> fixed string "CPU architecture: 8" in /proc/cpuinfo.
>>>
>>> Please read the various threads that have been going on over the past
>>> 10+ years about *why* we don't allow this sort of change (TL;DR: it
>>> breaks userspace, and we don't do that).
>>>
>>> Also, there is no material difference between v8 and v9 that would be
>>> observable from userspace outside of the "Features:" line. And if that
>>> doesn't convince you, just think of '8' as the number of bytes
>>> used by
> 
>> I got your point. It seems that we can regard '8' as the number of
>> bytes. But what make me do this is that 'CPU architecture: 8' is
>> confusing, especially those responsible for testing.
>> And I believe that most people regard this '8' as ARMv8, maybe not.
> 
> That was the original intention. But given that there is no userspace
> visible difference between v8, v9 and  whatever comes after it, this
> is a pointless change. My comment about the size of a VA was just a
> joke, and not something to be taken seriously.
> 
>> In fact, I'm not sure it has potential ABI implications, so seek your
>> advice.
> 
> Plenty of userspace programs parse /proc/cpuinfo. If you replace '8'
> with anything else, they will fail. Which is why although your patch
> makes sense, it comes 10 years too late, and we can't change this
> anymore.

And arguably it's not even too late, because 10 years ago this *did* say 
"AArch64". I don't remember all the exact details behind commit 
44b82b7700d0 ("arm64: Fix up /proc/cpuinfo") - this just tickled enough 
of a memory to go and look up the git history - but I don't think we 
changed any of those fields without a real reason.

Robin.

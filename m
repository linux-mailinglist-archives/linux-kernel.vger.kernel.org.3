Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF994E25AF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346976AbiCULyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347040AbiCULyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:54:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC24F165BB1;
        Mon, 21 Mar 2022 04:52:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8915F1042;
        Mon, 21 Mar 2022 04:52:33 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DDD73F66F;
        Mon, 21 Mar 2022 04:52:31 -0700 (PDT)
Message-ID: <44f3abe1-09a2-657f-7637-afa34781709b@arm.com>
Date:   Mon, 21 Mar 2022 11:52:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/3] dt-bindings: timer: Document arm, cortex-a7-timer
 in arch timer
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220317191527.96237-1-singh.kuldeep87k@gmail.com>
 <20220317191527.96237-3-singh.kuldeep87k@gmail.com>
 <558f0c92-c499-daca-e1ad-2b16137f8c06@arm.com>
 <20220317212508.GB99538@9a2d8922b8f1> <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yjd23Gro6B6zWCrO@robh.at.kernel.org>
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

On 2022-03-20 18:47, Rob Herring wrote:
> On Fri, Mar 18, 2022 at 02:55:08AM +0530, Kuldeep Singh wrote:
>> On Thu, Mar 17, 2022 at 08:25:12PM +0000, Robin Murphy wrote:
>>> On 2022-03-17 19:15, Kuldeep Singh wrote:
>>>> Renesas RZ/N1D platform uses compatible "arm,cortex-a7-timer" in
>>>> conjugation with "arm,armv7-timer". Since, initial entry is not
>>>> documented, it start raising dtbs_check warnings.
>>>>
>>>> ['arm,cortex-a7-timer', 'arm,armv7-timer'] is too long
>>>> 'arm,cortex-a7-timer' is not one of ['arm,armv7-timer', 'arm,armv8-timer']
>>>> 'arm,cortex-a7-timer' is not one of ['arm,cortex-a15-timer']
>>>>
>>>> Document this compatible to address it. The motivation to add this
>>>> change is taken from an already existing entry "arm,cortex-a15-timer".
>>>> Please note, this will not hurt any arch timer users.
>>>
>>> Eh, if it's never been documented or supported, I say just get rid of it.
>>> The arch timer interface is by definition part of a CPU, and we can tell
>>> what the CPU is by reading its ID registers. Indeed that's how the driver
>>> handles the non-zero number of CPU-specific errata that already exist - we
>>> don't need compatibles for that.
>>>
>>> In some ways it might have been nice to have *SoC-specific* compatibles
>>> given the difficulty some integrators seem to have had in wiring up a stable
>>> count *to* the interface, but it's not like they could be magically added to
>>> already-deployed DTs after a bug is discovered, and nor could we have
>>> mandated them from day 1 just in case and subsequently maintained a binding
>>> that is just an ever-growing list of every SoC. Oh well.
>>
>> Robin, A similar discussion was already done on v1 thread. Please see
>> below for details:
>> https://lore.kernel.org/linux-devicetree/20220317065925.GA9158@9a2d8922b8f1/
>> https://lore.kernel.org/linux-devicetree/726bde76-d792-febf-d364-6eedeb748c3b@canonical.com/
>>
>> And final outcome of discussion turns out to add this compatible string.
> 
> I agree with Robin on dropping. More specific here is not useful. If
> we're going to add some cores, then we should add every core
> implementation.

Yeah, what I was trying to convey is that a compatible like 
"arm,cortex-a76-timer" has the problem of being both too specific *and* 
not specific enough to be genuinely useful *for the particular case of 
the arch timer*. It's an architectural interface, where the actual 
functional features are described through the interface itself, so the 
purpose of the DT entry is really just to indicate that the standard 
interface is present and describe how its externally-routed interrupts 
are wired up.

However, it's also true that implementations of standard functionality 
sometimes have bugs that software needs to know about, but in order for 
specific DT compatibles to be useful in that respect they really need to 
identify the *exact* implementation, e.g. to know that 
"arm,cortex-a76-r0p0-timer" has a bug which needs working around, but 
"arm,cortex-a76-r4p0-timer" does not. There might be cases where every 
known version of a CPU is equally affected (e.g. Cortex-A73), but it 
doesn't hold as a general assumption. Furthermore as mentioned, the 
other class of bugs which affect this interface are not in the CPU's 
implementation of the interface at all, but in the external SoC logic 
that provides the counter value, and therefore it can be identification 
of the overall SoC that matters regardless of which CPU IP(s) may be 
present.

If we'd had the benefit of 10 years worth of hindsight 10 years ago, we 
probably wouldn't have defined "arm,cortex-a15-timer" either. However 
the fact that we can't erase the legacy of that decision doesn't make an 
argument for repeating it now.

> If one has a big.LITTLE system with A15/A7 what would be the right
> compatible value?
> 
>>
>> I see people with different set of perspective in regard to whether keep
>> compatible string or not. We should have some sort of evidences to
>> support claims so that next time when similar situation arises, we'll be
>> aware beforehand how to proceed.
> 
> Every situation tends to be different.

Indeed, I certainly don't have a personal perspective of "delete all the 
bindings!" in general - only when they're truly redundant (functionally, 
any driver that can touch the arch timer registers can also read the CPU 
ID registers, but even in the DT there should already be compatibles for 
the CPUs themselves).

Robin.

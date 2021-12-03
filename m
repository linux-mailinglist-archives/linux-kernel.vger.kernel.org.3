Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3545467C22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 18:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbhLCREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 12:04:32 -0500
Received: from foss.arm.com ([217.140.110.172]:51628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhLCREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 12:04:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71C801435;
        Fri,  3 Dec 2021 09:01:06 -0800 (PST)
Received: from [10.57.0.218] (unknown [10.57.0.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B0203F73B;
        Fri,  3 Dec 2021 09:01:04 -0800 (PST)
Subject: Re: [PATCH] ARM: Kconfig: improve ARM_SINGLE_ARMV7M description with
 Cortex M7
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20211202222002.33456-1-giulio.benetti@benettiengineering.com>
 <db427a15-231b-957e-3690-73373fec55ea@arm.com>
 <170aea55-44f3-9cf0-fd88-adf8c66efeb4@benettiengineering.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <ea2679ec-9bfd-6a78-a82d-7b160350ddfb@arm.com>
Date:   Fri, 3 Dec 2021 17:01:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <170aea55-44f3-9cf0-fd88-adf8c66efeb4@benettiengineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/21 4:41 PM, Giulio Benetti wrote:
> Hi Vladimir,
> 
> On 03/12/21 10:30, Vladimir Murzin wrote:
>> On 12/2/21 10:20 PM, Giulio Benetti wrote:
>>> ARM_SINGLE_ARMV7M implies Arm Cortex M7 too, so let's add it to
>>> description with M0/M3/M4.
>>
>> Well it also implies M33 and M55. I'd suggest drop specific implementations
>> from description - so we do not need to update it each time new compatible
>> core is released. To account newest cores like M33 and M55 you can rephrase
>> to:
>> - ARMv7-M/v8-M
> 
> This ^^^ is ok for me. Also, I don't see any M0 used at the moment so no ARMv6-M makes sense, if any in the future we can update. I see M3,M4,M7 for the moment, so ARMv7-M. But at the moment no ARMv8-M, or am I wrong?

We already support PMSAv8 which is ARMv8-M, M33/M55 is in flight [1].

> Maybe it would be better to add ARMv8-M when there will really be the support, considering also that ARM_SINGLE_ARMV7M is a bit ambiguous to be used with ARMv8-M. So maybe that could be modified too when an ARMv8-M is added.
> 
> What do you think about this?

Well, I prefer to touch this as rare as possible, and if we touch
it then ensure we do not need to touch it for a long time ;)

Look at A-class cores, 

config ARCH_MULTI_V7
        bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"

it doesn't mention ARMv8, yet it is pretty much possible to run it
on some cores either bare-metal or as a guest (just look under
arch/arm/include/asm/cputype.h)

These are just config options, not a legal deeds...

[1] https://lore.kernel.org/linux-arm-kernel/20211201132908.106711-1-vladimir.murzin@arm.com/T/

Cheers
Vladimir

> 
> Best regards


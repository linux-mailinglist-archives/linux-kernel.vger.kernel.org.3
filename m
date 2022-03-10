Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0C4D49D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbiCJO1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbiCJOXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:23:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E380158D89
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:21:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0720C1691;
        Thu, 10 Mar 2022 06:21:07 -0800 (PST)
Received: from [10.57.43.53] (unknown [10.57.43.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7B03FA20;
        Thu, 10 Mar 2022 06:21:04 -0800 (PST)
Message-ID: <39f8d67f-dd0b-e8de-e007-619eee86c98e@arm.com>
Date:   Thu, 10 Mar 2022 14:21:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
Content-Language: en-GB
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220309144138.360482-1-arnd@kernel.org>
 <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com>
 <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
 <CACRpkdbxico4SDottfB9Z8PHsXKG4fNA6G0XNyuaY+LObOovuw@mail.gmail.com>
 <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAK8P3a02a-+k=ChdT_Lg=xvHYZ4WTb-Efu7aQq-yBP1Gn37TgA@mail.gmail.com>
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

On 2022-03-10 09:23, Arnd Bergmann wrote:
> On Thu, Mar 10, 2022 at 2:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Wed, Mar 9, 2022 at 5:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
>>> Robin
>>>> In that case, it would probably make sense to garbage-collect all the
>>>> configs, setup code and other stuff relating to older MMU-less CPU cores
>>>> like ARM1156, ARM940, etc. at the same time.
>>>
>>> Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
>>> but that in turn doesn't build for CONFIG_MMU=n because it depends on
>>> ARCH_MULTIPLATFORM. I'll send a patch for these.
>>
>> Just delete these, I do have these CPU tiles around but they are so obscure
>> and I never got around to even testing to boot them.
> 
> Right, of course you couldn't boot test them because it has been
> impossible to even select them in Kconfig for years. I've added
> a patch to completely remove the five v4/v5 NOMMU cores now,
> will send that later.
> 
> There are five more cores that are only referenced by mach-integrator
> that are supposed to work (922T, 1020, 1020E, 1022, 1026). Have you
> ever tested those, or should we consider removing them as well?
> 
> At some point, there was a proposal to add an arm10 based SoC
> to mainline, but that never happened and I'm fairly sure it won't
> come back now.

FWIW I have an Integrator/CM1026 that I'd love to play with purely for 
giggles, but it needs some serious archaeology to find and flash some 
firmware for it first.

I also have a couple of "real" ARM1026s in the form of Conexant 
Solos-based routers[1] which I've done a little hacking on, but don't 
see myself ever realistically having enough time or motivation to 
actually upstream anything. And at this point I don't see OpenWRT having 
any more interest in boards with only 15MB of RAM (yes, they really do 
boot with "mem=15M" to reserve 1MB for the modem...)

Cheers,
Robin.

[1] https://openwrt.org/toh/linksys/wag54g2

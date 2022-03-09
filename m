Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A4D4D35F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiCIQdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235490AbiCIQXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:23:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7F0C3DA74
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:21:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D154168F;
        Wed,  9 Mar 2022 08:21:45 -0800 (PST)
Received: from [10.1.29.144] (e121487-lin.cambridge.arm.com [10.1.29.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 573453F7F5;
        Wed,  9 Mar 2022 08:21:42 -0800 (PST)
Subject: Re: [PATCH 2/2] ARM: remove support for NOMMU ARMv4/v5
To:     Arnd Bergmann <arnd@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220309144138.360482-1-arnd@kernel.org>
 <20220309144138.360482-2-arnd@kernel.org>
 <27250b4e-cf04-0dab-d658-bb472face5ea@arm.com>
 <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
Message-ID: <08232117-7444-55d8-e13c-b49828c8f3e9@arm.com>
Date:   Wed, 9 Mar 2022 16:21:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a20ccBbAwgVkq3n6tMehFH4YEyzquTkF3V=nJ46Tk4ePg@mail.gmail.com>
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

On 3/9/22 4:17 PM, Arnd Bergmann wrote:
> On Wed, Mar 9, 2022 at 4:48 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2022-03-09 14:40, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> It is possible to build MMU-less kernels for Cortex-M base
>>> microcrontrollers as well as a couple of older platforms that
>>> have not been converted to CONFIG_ARCH_MULTIPLATFORM,
>>> specifically ep93xx, footbridge, dove, sa1100 and s3c24xx.
>>>
>>> It seems unlikely that anybody has tested those configurations
>>> in recent years, as even building them is frequently broken.
>>> A patch I submitted caused another build time regression
>>> in this configuration. I sent a patch for that, but it seems
>>> better to also remove the option entirely, leaving ARMv7-M
>>> as the only supported Arm NOMMU target for simplicity.
>>
>> In that case, it would probably make sense to garbage-collect all the
>> configs, setup code and other stuff relating to older MMU-less CPU cores
>> like ARM1156, ARM940, etc. at the same time.
> 
> Right, good idea. These are only selected by CONFIG_ARCH_INTEGRATOR,
> but that in turn doesn't build for CONFIG_MMU=n because it depends on
> ARCH_MULTIPLATFORM. I'll send a patch for these.
> 
> I also went back and forth between removing the #ifdefs in
> arch/arm/mm/proc-*.S for this patch, though I did not do that in the end.
> We may still want them at least for proc-v7.S because that is a small
> chance that someone will want to support Cortex-R.
> 

I'd appreciate if you keep them since I run Cortex-R52...

Cheers
Vladimir

>         Arnd
> 


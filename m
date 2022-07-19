Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964CD57A2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiGSP20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbiGSP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:27:55 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2789B550B7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:27:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AC39442EDA7;
        Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IXgZueiyUcPX; Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3528642EDA6;
        Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3528642EDA6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1658244469;
        bh=E+HNW7nLIJW7fqYUl35eUhixtlC12tTJEei4Y9f6WpE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qu1umvtyI46GzTgjlr2pD0AFmK+ILT0VCBgDF9Uyi5bF4VwohulKo89ys59veaTia
         WEQ1wuQglAJm8ASKv61YdP+XkkH3GyVJC1Vu7pb9dflN3ugCrZ05ylvjLrUjyZFw3/
         U65G2fnCvde1G+atnaMa+wIj6VVl2ffDuLpDQQdT39RnfbkizgZAU/KMqwETrFpbbr
         QZKSSAHblal+MXhl1VqiThZhVwt5UF6Q7sH9olA1VWVnZS4JahcXtX7lBJggsSmFvY
         axyRjAMwaSm7PXzxp5bzzt5PzEg5mmfjQZcFTXzha/iw96AUy3jhaG14jln0YeDfRj
         EyofOIYl9LyNg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D3U26s2JfJvr; Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2007742EDA5;
        Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
Date:   Tue, 19 Jul 2022 11:27:49 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Jeanson <mjeanson@efficios.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Message-ID: <1084959304.73550.1658244469031.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAK8P3a2hd5KDBSH1=23_+Qz+t2LUC6kcc+9_Z_xc-Zdy7N-FAQ@mail.gmail.com>
References: <20220718145150.3344778-1-mathieu.desnoyers@efficios.com> <CAK8P3a2hd5KDBSH1=23_+Qz+t2LUC6kcc+9_Z_xc-Zdy7N-FAQ@mail.gmail.com>
Subject: Re: [RFC PATCH] arm: i.MX6 Cortex-A9: Fix memory ordering
 inconsistency by disabling prefetch instructions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: i.MX6 Cortex-A9: Fix memory ordering inconsistency by disabling prefetch instructions
Thread-Index: vgjoUGf1wRMavO2U2/A+b9jreVv3/g==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 19, 2022, at 10:33 AM, Arnd Bergmann arnd@arndb.de wrote:

> On Mon, Jul 18, 2022 at 4:51 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> 
>> Request for Feedback
>> ====================
>>
>> This fix targets all i.MX configurations, but it is likely too broad (or
>> too narrow). It would be great if people with access to different
>> Freescale i.MX test boards, and test boards from other vendors, could try
>> to reproduce the issue to figure out what would be the right scope for
>> this fix.
>>
>> It would also be great if people with knowledge of the ARM CPU internals
>> could help understanding whether this fix really fixes an issue between
>> prefetch and memory barriers, or just happens to hide the issue. It
>> would be good to understand whether this issue only affects PLDW or if
>> it also affects the PLD instruction.
> 
> I don't have any relevant hardware at hand, but looked at this for a few
> hours today, unfortunately without any notable success. Just documenting
> what I did here:
> 
> - looked at the errata lists for cortex-a9 r2, for pl310 and for
> imxq6q to see if
>  anything stuck out. I assume you've already done the same, but I can confirm
>  that the errata that would match the symptom are listed as fixed in r2p10
>  or earlier.

Yes, I've spent some quality time reading through those errata in the past 2 weeks,
and did not find anything relevant for the r2p10.

> 
> - looked at objdump output from
>  linux-image-5.18.0-0.bpo.1-armmp_5.18.2-1~bpo11+1_armhf.deb
>  (not the same version, but hopefully be close enough), and compared that
>  to v5.18.2 built with the same config using gcc-7.5 and gcc-10.3 to
>  see if I could tell what is different. The output looks very similar, though
>  my own gcc-10 apparently fails to inline arch_futex_atomic_op_inuser()
>  and futex_atomic_op_inuser(). This looks like something we may want
>  to force-inline in principle, but it seems unrelated to the bug you found
>  since the debian vmlinux has these functions inlined and I don't think
>  they are actually part of the broken code path.

Indeed, those op_inuser did not appear to be used in FUTEX_WAKE, FUTEX_WAIT
AFAIR, so I don't think the delta is relevant here.

> 
> - looked for other quad-core Cortex-A9 SoCs to find someone with a
>  similar revision to check if they have the same bug. The closest I
>  can  think of is the OMAP4 that uses an A9 r1p2.

Good to know.

> 
> - Looked at the disabled errata handling in arch/arm/Kconfig.
>  Unfortunately a couple of the workarounds we have there are
>  now always disabled because of a dependency on
>  ARCH_MULTIPLATFORM. It's a long shot, but you could try
>  removing the dependencies and enabling all the Cortex-A9
>  fixes like ARM_ERRATA_742230, ARM_ERRATA_742231,
>  ARM_ERRATA_743622, ARM_ERRATA_751472, and
>  ARM_ERRATA_754327.

I already attempted this, but ended up understanding that
handling of those errata workarounds were simply moved to U-Boot,
so it can set the relevant bits in the Diagnostic Control Register
at boot-time when allowed by the current privilege level, before
loading a secure boot Linux kernel. That being said, my test
system does not use secure boot.

U-Boot 2021.01+dfsg-4 has:

/usr/share/doc/u-boot-imx/configs/config.wandboard.gz :

CONFIG_ARM_ERRATA_743622=y
CONFIG_ARM_ERRATA_751472=y
CONFIG_ARM_ERRATA_761320=y
CONFIG_ARM_ERRATA_794072=y
CONFIG_ARM_ERRATA_845369=y

About errata 742230 ("ARM errata: DMB operation may be faulty"), it only
applies to Cortex-A9 r1p0..r2p2, which explains why the wandboard U-Boot
config has it =n. Nevertheless, I attempted modifying the Linux kernel code
to explicitly change the implementation of smp_mb() from dmb to dsb, but
it did not solve the issue.

About errata 754327 ("ARM errata: no automatic Store Buffer drain"), it
applies prior to r2p0, and is enabled in my Debian kernel configuration
already, because it does not depend on !ARCH_MULTIPLATFORM. The issue
reproduces with this work-around enabled.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

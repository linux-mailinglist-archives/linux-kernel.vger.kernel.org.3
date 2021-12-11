Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD1471479
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhLKPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 10:31:09 -0500
Received: from 49-237-179-185.static.tentacle.fi ([185.179.237.49]:48268 "EHLO
        bitmer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhLKPbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 10:31:08 -0500
Received: from 88-114-185-38.elisa-laajakaista.fi ([88.114.185.38] helo=[192.168.1.42])
        by bitmer.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jarkko.nikula@bitmer.com>)
        id 1mw4L1-0005wU-GF; Sat, 11 Dec 2021 17:31:03 +0200
Message-ID: <ef843afa-c99d-328d-853a-00ef293a47f2@bitmer.com>
Date:   Sat, 11 Dec 2021 17:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] ARM: dts: Fix timer regression for beagleboard revision c
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc:     =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
References: <20211125144834.52457-1-tony@atomide.com>
From:   Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20211125144834.52457-1-tony@atomide.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony

On 11/25/21 16:48, Tony Lindgren wrote:
> Commit e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> caused a timer regression for beagleboard revision c where the system
> clockevent stops working if omap3isp module is unloaded.
> 
> Turns out we still have beagleboard revisions a-b4 capacitor c70 quirks
> applied that limit the usable timers for no good reason. This also affects
> the power management as we use the system clock instead of the 32k clock
> source.
> 
> Let's fix the issue by adding a new omap3-beagle-ab4.dts for the old timer
> quirks. This allows us to remove the timer quirks for later beagleboard
> revisions. We also need to update the related timer quirk check for the
> correct compatible property.
> 
> Fixes: e428e250fde6 ("ARM: dts: Configure system timers for omap3")
> Cc: linux-kernel@vger.kernel.org
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reported-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

>  .../devicetree/bindings/arm/omap/omap.txt     |  3 ++
>  arch/arm/boot/dts/Makefile                    |  1 +
>  arch/arm/boot/dts/omap3-beagle-ab4.dts        | 47 +++++++++++++++++++
>  arch/arm/boot/dts/omap3-beagle.dts            | 33 -------------
>  drivers/clocksource/timer-ti-dm-systimer.c    |  2 +-
>  5 files changed, 52 insertions(+), 34 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap3-beagle-ab4.dts
> 
I must have some error in my methodology since I cannot see the issue
being fixed with your patch :-(

Testing at commit 6f513529296f ("Merge tag 'for-5.16-rc4-tag' of
git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux")

alias ma='nice make -j `getconf _NPROCESSORS_ONLN` ARCH=arm
CROSS_COMPILE="ccache arm-linux-gnueabihf-"'

make ARCH=arm omap2plus_defconfig
ma
cat arch/arm/boot/dts/omap3-beagle.dtb >>arch/arm/boot/zImage
ma LOADADDR=0x80008000 uImage

-> copy uImage & modules, boot
# rmmod omap3_isp
# sleep 1
-> This is the regression. Sleep is blocked until I hit keys over serial
console

rm vmlinux arch/arm/boot/zImage
patch -p1 </tmp/your-mail.eml

ma
cat arch/arm/boot/dts/omap3-beagle-ab4.dtb >>arch/arm/boot/zImage
ma LOADADDR=0x80008000 uImage

-> copy uImage & modules to µSD, boot
# rmmod omap3_isp
# sleep 1
-> is still blocked until I hit keys over serial console

When I compare the dmesg this is the only difference (along with "linux
version" line) before user space starts. I.e. timer configuration is the
same in both.

[    0.000000] OF: fdt: Machine model: TI OMAP3 BeagleBoard
->
[    0.000000] OF: fdt: Machine model: TI OMAP3 BeagleBoard A to B4

Jarkko

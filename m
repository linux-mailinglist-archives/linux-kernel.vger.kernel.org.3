Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42746B263
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 06:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbhLGFe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 00:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbhLGFeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 00:34:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A27C061746;
        Mon,  6 Dec 2021 21:30:55 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A87FF41EF0;
        Tue,  7 Dec 2021 05:30:49 +0000 (UTC)
Subject: Re: [PATCH v3 00/11] Apple SoC PMGR device power states driver
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211124073419.181799-1-marcan@marcan.st>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <8fdf7a68-1a24-89eb-96d6-93c3f334621c@marcan.st>
Date:   Tue, 7 Dec 2021 14:30:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211124073419.181799-1-marcan@marcan.st>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2021 16.34, Hector Martin wrote:
> This series adds the driver for the Apple PMGR device power state
> registers. These registers can clockgate and (in some cases) powergate
> specific SoC blocks. They also control the reset line, and can have
> additional features such as automatic power management.
> 
> The current driver supports only the lowest/highest power states,
> provided via the genpd framework, plus reset support provided via
> the reset subsystem.
> 
> Apple's PMGRs (there are two in the T8103) have a uniform register
> bit layout (sometimes with varying features). To be able to support
> multiple SoC generations as well as express pd relationships
> dynamically, this binding describes each PMGR power state control
> as a single devicetree node. Future SoC generations are expected to
> retain backwards compatibility, allowing this driver to work on them
> with only DT changes.
> 
> #1: MAINTAINERS updates, to go via the SoC tree to avert merge hell
> #2-#5: Adds power-domains properties to existing device bindings
> #6-#7: Adds the new pmgr device tree bindings
> #8: The driver itself.
> #9: Instantiates the driver in t8103.dtsi. This adds the entire PMGR
>      node tree and references the relevant nodes from existing devices.
> #7: Adds runtime-pm support to the Samsung UART driver, as a first
>      working consumer.
> #8: Instantiates a second UART, to more easily test this.
> 
> There are currently no consumers for the reset functionality, so
> it is untested, but we will be testing it soon with the NVMe driver
> (as it is required to allow driver re-binding to work properly).
> 
> == Changes since v2 ==
> - DT schema review comments & patch order fix
> - Added the power-domains properties to devices that already mainlined
> - Now adds the entire PMGR tree. This turns off all devices we do not
>    currently instantiate, and adds power-domains to those we do. The
>    nodes were initially generated with [1] and manually tweaked. all
>    the labels match the ADT labels (lowercased), which might be used
>    by the bootloader in the future to conditionally disable nodes
>    based on hardware configuration.
> - Dropped apple,t8103-minipmgr, since I don't expect we will ever need
>    to tell apart multiple PMGR instances within a SoC, and added
>    apple,t6000-pmgr{-pwrstate} for the new SoCs.
> - Driver now unconditionally enables auto-PM for all devices. This
>    seems to be safe and should save power (it is not implemented for
>    all devices; if not implemented, the bit just doesn't exist and is
>    ignored).
> - If an always-on device is not powered on at boot, turn it on and
>    print a warning. This avoids the PM core complaining. We still
>    want to know if/when this happens, but let's not outright fail.
> - Other minor fixes (use PS names instead of offsets for messages,
>    do not spuriously clear flag bits).
> 
> On the way the parent node is handled: I've decided that these syscon
> nodes will only ever contain pwrstates and nothing else. We now size
> them based on the register range that contains pwrstate controls
> (rounded up to page size). t6000 has 3 PMGRs and t6001 has 4, and
> we shouldn't have to care about telling apart the multiple instances.
> Anything else PMGR does that needs a driver will be handled by
> entirely separate nodes in the future.
> 
> Re t6001 and t6000 (and the rumored t6002), t6000 is basically a
> cut-down version of t6001 (and t6002 is rumored to be two t6001
> dies), down to the die floorplan, so I'm quite certain we won't need
> t6001/2-specific compatibles for anything shared. The t6000 devicetree
> will just #include the t6001 one and remove the missing devices.
> Hence, everything for this SoC series is going to have compatibles
> named apple,t6000-* (except the extra instances of some blocks in
> t6001 which look like they may have differences; PMGR isn't one of
> them, but some multimedia stuff might).
> 
> [1] https://github.com/AsahiLinux/m1n1/blob/main/proxyclient/tools/pmgr_adt2dt.py
> 
> Hector Martin (11):
>    MAINTAINERS: Add PMGR power state files to ARM/APPLE MACHINE
>    dt-bindings: i2c: apple,i2c: Add power-domains property
>    dt-bindings: iommu: apple,dart: Add power-domains property
>    dt-bindings: pinctrl: apple,pinctrl: Add power-domains property
>    dt-bindings: interrupt-controller: apple,aic: Add power-domains
>      property
>    dt-bindings: power: Add apple,pmgr-pwrstate binding
>    dt-bindings: arm: apple: Add apple,pmgr binding
>    soc: apple: Add driver for Apple PMGR power state controls
>    arm64: dts: apple: t8103: Add PMGR nodes
>    tty: serial: samsung_tty: Support runtime PM
>    arm64: dts: apple: t8103: Add UART2
> 
>   .../bindings/arm/apple/apple,pmgr.yaml        |  134 ++
>   .../devicetree/bindings/i2c/apple,i2c.yaml    |    3 +
>   .../interrupt-controller/apple,aic.yaml       |    3 +
>   .../devicetree/bindings/iommu/apple,dart.yaml |    3 +
>   .../bindings/pinctrl/apple,pinctrl.yaml       |    3 +
>   .../bindings/power/apple,pmgr-pwrstate.yaml   |   71 ++
>   MAINTAINERS                                   |    3 +
>   arch/arm64/boot/dts/apple/t8103-j274.dts      |    5 +
>   arch/arm64/boot/dts/apple/t8103-pmgr.dtsi     | 1136 +++++++++++++++++
>   arch/arm64/boot/dts/apple/t8103.dtsi          |   36 +
>   drivers/soc/Kconfig                           |    1 +
>   drivers/soc/Makefile                          |    1 +
>   drivers/soc/apple/Kconfig                     |   21 +
>   drivers/soc/apple/Makefile                    |    2 +
>   drivers/soc/apple/apple-pmgr-pwrstate.c       |  317 +++++
>   drivers/tty/serial/samsung_tty.c              |   93 +-
>   16 files changed, 1798 insertions(+), 34 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
>   create mode 100644 Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
>   create mode 100644 arch/arm64/boot/dts/apple/t8103-pmgr.dtsi
>   create mode 100644 drivers/soc/apple/Kconfig
>   create mode 100644 drivers/soc/apple/Makefile
>   create mode 100644 drivers/soc/apple/apple-pmgr-pwrstate.c
> 

Applied everything except the samsung_tty change to asahi-soc/dt (DT 
changes) and asahi-soc/pmgr (just the driver). Thanks everyone for the 
reviews!

Krzysztof: feel free to take that patch through tty if you think it's in 
good shape. I'm not sure how much power UART runtime-pm will save us, 
but at least it's a decent test case, so it's probably worth having.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

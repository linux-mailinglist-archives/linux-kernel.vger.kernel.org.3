Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01E44A82A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiBCKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:47:23 -0500
Received: from foss.arm.com ([217.140.110.172]:38186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbiBCKrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:47:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FD98113E;
        Thu,  3 Feb 2022 02:47:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434513F774;
        Thu,  3 Feb 2022 02:47:21 -0800 (PST)
Date:   Thu, 3 Feb 2022 10:47:13 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Broadcom STB PM PSCI extensions
Message-ID: <YfuysSBnZbnMF4OC@FVFF77S0Q05N>
References: <20220122035421.4086618-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122035421.4086618-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 07:54:17PM -0800, Florian Fainelli wrote:
> Hi all,

Hi Florian,

> This patch series contains the Broadcom STB PSCI extensions which adds
> some additional functions on top of the existing standard PSCI interface
> which is the reason for having the driver implement a custom
> suspend_ops.

I *really* don't like the idea of having non-standard PSCI extensions, because
it somewhat defeats the point of PSCI being a standard, and opens the door for
the zoo of mechanisms we had on 32-bit.

I think this needs a fair amount more explanation and justification.

> These platforms have traditionally supported a mode that is akin to
> ACPI's S2 with the CPU in WFI and all of the chip being clock gated
> which is entered with "echo standby > /sys/power/state". Additional a
> true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
> mem > /sys/power/state".

Why isn't a combination of CPU_SUSPEND and SYSTEM_SUSPEND sufficient here?

What specifically *can't* you do with standard PSCI calls?

> These platforms also may have an external Broadcom PMIC chip which can
> cause the SoC to be powercycled assuming that we communicate that intent
> via a vendor specific PSCI SYSTEM_RESET2.
> 
> Since it is desirable to get any new functionality added to the kernel
> to be loadable as a module as part of shipping said products in a Google
> Kernel Image (GKI) environment, we need to export a couple of symbols from
> drivers/firmware/psci/psci.c.

I really don't want to export the guts of psci.c.

Thanks,
Mark.

> Thanks for your feedback.
> 
> Florian Fainelli (4):
>   firmware: psci: Export a couple of suspend symbols
>   soc: bcm: brcmstb: Make legacy PM code depend on !ARM_PSCI_FW
>   soc: bcm: brcmstb: Added support for PSCI system suspend operations
>   Documentation: ABI: Document Broadcom STB PSCI firmware files
> 
>  .../ABI/testing/sysfs-firmware-brcmstb        |  16 +
>  drivers/firmware/psci/psci.c                  |   9 +-
>  drivers/soc/bcm/brcmstb/Kconfig               |   4 +-
>  drivers/soc/bcm/brcmstb/pm/Makefile           |   3 +
>  drivers/soc/bcm/brcmstb/pm/pm-psci.c          | 315 ++++++++++++++++++
>  include/linux/psci.h                          |   2 +
>  include/linux/soc/brcmstb/brcmstb-smccc.h     |  84 +++++
>  7 files changed, 430 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-firmware-brcmstb
>  create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-psci.c
>  create mode 100644 include/linux/soc/brcmstb/brcmstb-smccc.h
> 
> -- 
> 2.25.1
> 

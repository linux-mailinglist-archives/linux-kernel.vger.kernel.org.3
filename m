Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD6850FEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiDZN1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbiDZN1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:27:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF00218C466;
        Tue, 26 Apr 2022 06:24:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B0FD23A;
        Tue, 26 Apr 2022 06:24:23 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF543F774;
        Tue, 26 Apr 2022 06:24:21 -0700 (PDT)
Date:   Tue, 26 Apr 2022 14:24:19 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Diego Sueiro <diego.sueiro@arm.com>,
        Laurent Vivier <lvivier@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] arm64: dts: fvp: Add virtio-rng support
Message-ID: <20220426142419.34f815a2@donnerap.cambridge.arm.com>
In-Reply-To: <ac3be672c636091ee1e079cadce776b1fb7e0b2e.1650543392.git.diego.sueiro@arm.com>
References: <ac3be672c636091ee1e079cadce776b1fb7e0b2e.1650543392.git.diego.sueiro@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 15:35:21 +0100
Diego Sueiro <diego.sueiro@arm.com> wrote:

Hi,

> The virtio-rng is available from FVP_Base_RevC-2xAEMvA version 11.17, so add
> the devicetree node to support it.

The change looks good, although it probably deserves to mention the reason
for keeping it "disabled" by default (older FVP versions not having the
device, so they throw an SError on probe).

But when testing it, I discovered that there is some problem with later
kernels. It works fine up to v5.15, but breaks later on. I bisected it
down to:

=============
commit 9a4b612d675b03f7fc9fa1957ca399c8223f3954
Author: Laurent Vivier <lvivier@redhat.com>
Date:   Thu Oct 28 12:11:11 2021 +0200
    
    hwrng: virtio - always add a pending request

    If we ensure we have already some data available by enqueuing
    again the buffer once data are exhausted, we can return what we
    have without waiting for the device answer.
=============

The effect is that any access to /dev/hwrng hangs, it looks like it's
waiting for an interrupt to fire (core goes to WFI). The process reading
the char dev can be Ctrl-C'ed, but there will be no output, and the
interrupt counter in /proc/interrupts does not increase.
It works fine with any kernel under QEMU, but definitely breaks the FVP
usage (reverting that patch makes it work again on mainline).

I didn't have a closer look yet (and have limited knowledge about the
internals of virtio and virtio-rng in particular), but was wondering if
someone could give a hint at what could be the issue or the direction to
debug that?

Cheers,
Andre

> Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
> ---
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts            | 3 ++-
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi | 7 +++++++
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi     | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index 269b649934b5..a496e39e6204 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -241,6 +241,7 @@ bus@8000000 {
>  				<0 0 41 &gic 0 0 GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 42 &gic 0 0 GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
>  				<0 0 43 &gic 0 0 GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>,
> -				<0 0 44 &gic 0 0 GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +				<0 0 44 &gic 0 0 GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
> +				<0 0 46 &gic 0 0 GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> index 33182d9e5826..1b6326514c97 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi
> @@ -21,6 +21,13 @@ virtio-net@150000 {
>  					reg = <0x150000 0x200>;
>  					interrupts = <44>;
>  				};
> +
> +				virtio-rng@200000 {
> +					compatible = "virtio,mmio";
> +					reg = <0x200000 0x200>;
> +					interrupts = <46>;
> +					status = "disabled";
> +				};
>  			};
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> index 5f6cab668aa0..a999e7f52d8b 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
> @@ -110,7 +110,7 @@ iofpga-bus@300000000 {
>  				compatible = "simple-bus";
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				ranges = <0 3 0 0x200000>;
> +				ranges = <0 3 0 0x210000>;
>  
>  				v2m_sysreg: sysreg@10000 {
>  					compatible = "arm,vexpress-sysreg";


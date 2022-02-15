Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57964B7A55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 23:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiBOWQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 17:16:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiBOWQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:16:57 -0500
X-Greylist: delayed 24574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Feb 2022 14:16:45 PST
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ABA29800;
        Tue, 15 Feb 2022 14:16:45 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D0BC240002;
        Tue, 15 Feb 2022 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644963401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fdlEzyM6wV1U+RwGyQK9WmkMI5mhDJdmK2glPQLND8k=;
        b=PZbPwJgwrtf0MbAXbKC/ZGhSkjZPn+1Ph7P9YrP6UByMDHYK9Ox9Ed3riiim95aPtCzUvg
        OsR1svKQug1ksFzzDa8wIezWiBEj4Qj0zzEAsPUFVUYmL2/E5ptK/KQbpmvm6ntNvpV8NM
        5ySJrTfxnnCy01hO1vnbrB0lhkHL9wfinR0WvEGG3Rw2sTz3hTvp8MIjjhtwN1k/ZJrg4w
        43QqcKrBMyRXTXqiSxdWPFUa7MSiL50Q2M/3KpaownXvw0MrC5IHL7sEvlup7EFslkNFAT
        tQpBEcoGIq6h8MnT5X5Nrjs7rK4DWjlGKjljq0wX109XIAM7nVdLDufvSDXK1g==
Date:   Tue, 15 Feb 2022 23:16:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 0/6] clk: sunxi-ng: Add a RTC CCU driver
Message-ID: <YgwmR9LHYSFdZl+5@piout.net>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 02/02/2022 20:17:30-0600, Samuel Holland wrote:
> This patch series adds a CCU driver for the RTC in the H616, R329 and
> D1. The extra patch at the end of this series shows how it would be
> explanded to additional hardware variants.
> 
> The driver is intended to support the existing binding used for the H6,
> but also an updated binding which includes all RTC input clocks.
> 
> A future patch series could add functionality to the driver to manage
> IOSC calibration at boot and during suspend/resume.
> 
> It may be possible to support all of these hardware variants without
> adding this new driver, by adding them to the existing RTC clock
> provider, but I'm concerned about the complexity there, without any of
> the CCU abstraction.
> 
> Changes in v3:
>  - Add/fix several maxItems attributes for clocks and clock-items
>  - Drop the SUNXI_CCU_MUX_HW_WITH_KEY macro, since it is no longer used.
>  - Also drop the patch adding the SUNXI_CCU_MUX_DATA_WITH_GATE macro.
>  - Rebase on v5.17-rc2 (CCU module support series was merged).
>  - Move IOSC calibration control to prepare/unprepare operations.
>  - Declare several `struct clk_init_data`s as static variables (instead
>    of as anonymous) so they can be modified from the probe function
>    without casting away const.
>  - Instead of creating two copies of clocks which may or may not have
>    muxes, change the number of parents to 1 in the non-mux case.
>  - Use a single CCU description for all variants.
>  - Use IS_REACHABLE to guard the call to sun6i_rtc_ccu_probe.
>  - Allow the driver to be built on !ARM64 (i.e. RISCV).
>  - Rebase example on top of driver changes, and drop the second example.
> 
> Changes in v2:
>  - Combine "const"s to "enum" in the DT binding compatible property.
>  - Properly update the DT binding clocks and clock-names properties.
>  - Rebase on v2 of the CCU module support series.
>  - Load the CCU driver from the RTC driver, not as an OF provider.
> 
> Samuel Holland (6):
>   dt-bindings: rtc: sun6i: Clean up repetition
>   dt-bindings: rtc: sun6i: Add H616, R329, and D1 support
>   rtc: sun6i: Enable the bus clock when provided

I've now applied 1-3/6, thanks!

>   clk: sunxi-ng: mux: Allow muxes to have keys
>   clk: sunxi-ng: Add support for the sun6i RTC clocks
>   [DO NOT MERGE] clk: sunxi-ng: sun6i-rtc: Add support for H6
> 
>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |  84 +++-
>  drivers/clk/sunxi-ng/Kconfig                  |   5 +
>  drivers/clk/sunxi-ng/Makefile                 |   2 +
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.c          | 393 ++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun6i-rtc.h          |  15 +
>  drivers/clk/sunxi-ng/ccu_common.h             |   1 +
>  drivers/clk/sunxi-ng/ccu_mux.c                |   7 +
>  drivers/rtc/rtc-sun6i.c                       |  48 ++-
>  include/dt-bindings/clock/sun6i-rtc.h         |  10 +
>  include/linux/clk/sunxi-ng.h                  |   2 +
>  10 files changed, 538 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun6i-rtc.h
>  create mode 100644 include/dt-bindings/clock/sun6i-rtc.h
> 
> -- 
> 2.33.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

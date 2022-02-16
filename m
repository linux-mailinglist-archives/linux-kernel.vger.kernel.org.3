Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25F4B91D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbiBPTxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:53:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiBPTxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:53:54 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62062B0B0F;
        Wed, 16 Feb 2022 11:53:41 -0800 (PST)
Received: from g550jk.localnet (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id C8517C3E9E;
        Wed, 16 Feb 2022 19:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645041220; bh=W3gVUgcU/OTVyEAEJ6EdabcIZ9I2bCwWK8lOeD2BH9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iStu35P26Rt0zu05xfrVXPLGIcP6dlbY6qX9lYz9BhDj5lAi6ebbHleFI1C8wqrCk
         7M/zvMM3AoUO/Ol432qonVTINCGzQGybQrvW+4UoReP/prbWcC4zQ/mB1rXDJwDZnr
         ELMaEdsEEWI0w6TzC1aOeVe1McZ/FxgnbWqD3SY4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Satya Priya Kakitapalli <c_skakit@qti.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v12 2/2] leds: Add driver for Qualcomm LPG
Date:   Wed, 16 Feb 2022 20:53:39 +0100
Message-ID: <8036183.EvYhyI6sBW@g550jk>
In-Reply-To: <20220216045620.1716537-2-bjorn.andersson@linaro.org>
References: <20220216045620.1716537-1-bjorn.andersson@linaro.org> <20220216045620.1716537-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Mittwoch, 16. Februar 2022 05:56:20 CET Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
> 
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
> 
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
> 
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver supports multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
> 
> The idea of modelling this as a LED driver ontop of a PWM driver was
> considered, but setting the properties related to patterns does not fit
> in the PWM API. Similarly the idea of just duplicating the lower bits in
> a PWM and LED driver separately was considered, but this would not allow
> the PWM channels and LEDs to be configured on a per-board basis. The
> driver implements the more complex LED interface, and provides a PWM
> interface on the side of that, in the same driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Works great on pm8941 / msm8974-fairphone-fp2!

Tested-by: Luca Weiss <luca@z3ntu.xyz>

Regards
Luca

> ---
> 
> Changes since v11:
> - Extended commit message to cover decision to put pwm_chip in the LED
> driver - Added Documentation, in particular for the hw_pattern format
> - Added a lock to synchronize requests from LED and PWM frameworks
> - Turned out that the 9bit selector differs per channel in some PMICs, so
>   replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
> - Fixed kerneldoc for the struct device pointer in struct lpg
> - Rewrote conditional in lut_free() to make it easier to read
> - Corrected and deduplicated max_period expression in lpg_calc_freq()
> - Extended nom/dom to numerator/denominator in lpg_calc_freq()
> - Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
> - Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for reading
> the same in get_state()
> - Cleaned up the pattern format, to allow specifying both low and high pause
> with and without pingpong mode.
> - Only update frequency and pwm_value if PWM channel is enabled in
> lpg_pwm_apply - Make lpg_pwm_get_state() read the hardware state, in order
> to pick up e.g. bootloader backlight configuration
> - Use devm_bitmap_zalloc() to allocate the lut_bitmap
> - Use dev_err_probe() in lpg_probe()
> - Extended Kconfig help text to mention module name and satisfy checkpatch
> 
>  Documentation/leds/leds-qcom-lpg.rst |   76 ++
>  drivers/leds/Kconfig                 |    3 +
>  drivers/leds/Makefile                |    3 +
>  drivers/leds/rgb/Kconfig             |   18 +
>  drivers/leds/rgb/Makefile            |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c     | 1401 ++++++++++++++++++++++++++
>  6 files changed, 1504 insertions(+)
>  create mode 100644 Documentation/leds/leds-qcom-lpg.rst
>  create mode 100644 drivers/leds/rgb/Kconfig
>  create mode 100644 drivers/leds/rgb/Makefile
>  create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c




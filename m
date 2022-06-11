Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA454770B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbiFKSH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiFKSHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0DD1929E;
        Sat, 11 Jun 2022 11:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4466120B;
        Sat, 11 Jun 2022 18:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C115C34116;
        Sat, 11 Jun 2022 18:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654970841;
        bh=if2s9G1Ax2BNvHiItUquxbYsizofOQR/sGlUL2Ao4no=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nHoyyDhxr1VW9+AdFXDn4Zjtwxxo+8HxEJKJKwfVr8otx6sRmwlhDGEX8VPEAiyKa
         T6ADzGPhOgxJsZRpSDdBGLXTyVMsYU/b4FQ1VBty6Y2O398CPl4vJX6lSALmWfHcPo
         6CDVGVr0qrVGQ24EM0UjAwgSYHp47M+6x+7koLL+5aM1/IPRIwc/Y/cJtmdU4QmYAL
         iGAXMK1+EwKFmnH6nsD6aUqecdl5cr1iIL/nJeY5RJxV9chn9PITM5Qdkz0HpEp6pM
         kKswRq9Ymi0s23s6IS8EccCJeVTMg+qU9tnAl2azjD2B/+8xTZxLuAVYaF0xDktAHO
         dDwnV/xIS+WxQ==
Date:   Sat, 11 Jun 2022 19:16:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <eugen.hristev@microchip.com>, <lars@metafoo.de>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/16] iio: adc: at91-sama5d2_adc: add support for
 temperature sensor
Message-ID: <20220611191629.2a0f6d2f@jic23-huawei>
In-Reply-To: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jun 2022 11:31:57 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Hi,
> 
> The following series add support for temperature sensor available on
> SAMA7G5.
> 
> Temperature sensor available on SAMA7G5 provides 2 outputs VTEMP and VBG.
> VTEMP is proportional to the absolute temperature voltage and VBG is a
> quasi-temperature independent voltage. Both are necessary in computing
> the temperature (for better accuracy). Also, for better accuracy the
> following settings were imposed when measusing the temperature:
> oversampling rate of 256, sampling frequency of 10MHz, a startup time of
> 512 ticks, MR.tracktim=0xf, EMR.trackx=0x3.
> 
> For computing the temperature measured by ADC calibration data is
> necessary. This is provided via OTP memory available on SAMA7G5.
> 
> Patches 1/16-3/16 provides some fixes.
> Patches 3/16-12/16 prepares for the addition of temperature sensor
> support.
> Patch 13/16 adds the temperature sensor support.
> 
> Along with temperature sensor support I took the chance and added
> runtime PM support in this series, too (handled in patch 15/16).
> 
> The rest of patches in this series are minor cleanups.
> 
> Thank you,
> Claudiu Beznea

Hi CLaudiu,

Those patches I haven't replied to individually look good to me.

Thanks,

Jonathan

> 
> Claudiu Beznea (16):
>   iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
>   iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
>   iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are
>     enabled
>   iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw
>     versions
>   iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
>   iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
>   iio: adc: at91-sama5d2_adc: simplify the code in
>     at91_adc_read_info_raw()
>   iio: adc: at91-sama5d2_adc: move oversampling storage in its function
>   iio: adc: at91-sama5d2_adc: update trackx on emr
>   iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for
>     at91_adc_setup_samp_freq()
>   iio: adc: at91-sama5d2_adc: add locking parameter to
>     at91_adc_read_info_raw()
>   dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature
>     channel
>   iio: adc: at91-sama5d2_adc: add support for temperature sensor
>   iio: adc: at91-sama5d2_adc: add empty line after functions
>   iio: adc: at91-sama5d2_adc: add runtime pm support
>   iio: adc: at91-sama5d2_adc: use pm_ptr()
> 
>  drivers/iio/adc/at91-sama5d2_adc.c            | 633 +++++++++++++++---
>  .../dt-bindings/iio/adc/at91-sama5d2_adc.h    |   3 +
>  2 files changed, 548 insertions(+), 88 deletions(-)
> 


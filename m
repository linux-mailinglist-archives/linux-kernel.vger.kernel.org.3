Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A9C5AD60B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiIEPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 11:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236173AbiIEPR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 11:17:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021EE1FCE7;
        Mon,  5 Sep 2022 08:17:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 853E96126A;
        Mon,  5 Sep 2022 15:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA5AC433D6;
        Mon,  5 Sep 2022 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662391076;
        bh=+1JZVikczD6oMQstBHmmQ6IUy+FzfgWRuCZFth/S+Dw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yqo0TLPTEI46myyss+uHeRcfU8jMlNl/nWSkBHabM+hWfliZo8rDKXYcZM1EFORBW
         oD0h5vJio83AnqAsoUp8raLAV7S1JNFk86UJc2drDU5jNz6D4QksFJPm/f7l6Zaj9w
         /fBzFW3F8yu+Kqb4oHJvOaXpu2JJ1o6Z0/d9wjL8x2M2Cp2zaRDjoxZmc2hvauq7jy
         gBsa3txjSmNd6aJDnmHFR2ofz3hBDJFO8M10YVzOVofQrrusETDUOUv2Cza8FqJrdh
         Si5ltT72oPZY9MFr1MpNovq3zDX+hjQjm0iNUCfzwMnBeqLFXZy5HfPaWRiHQqZ+SN
         BGexnGAQEKK7Q==
Date:   Mon, 5 Sep 2022 16:17:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, jic23@kernel.org,
        lars@metafoo.de, deller@gmx.de, broonie@kernel.org,
        mazziesaccount@gmail.com, andriy.shevchenko@linux.intel.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v9 10/10] video: backlight: mt6370: Add MediaTek MT6370
 support
Message-ID: <YxYR2/knZTsy9Uh8@google.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
 <20220830034042.9354-11-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830034042.9354-11-peterwu.pub@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022, ChiaEn Wu wrote:

> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> MediaTek MT6370 is a SubPMIC consisting of a single cell battery charger
> with ADC monitoring, RGB LEDs, dual channel flashlight, WLED backlight
> driver, display bias voltage supply, one general purpose LDO, and the
> USB Type-C & PD controller complies with the latest USB Type-C and PD
> standards.
> 
> Add support for the MediaTek MT6370 backlight driver.
> It controls 4 channels of 8 series WLEDs in
> 2048 (only for MT6370/MT6371) / 16384 (only for MT6372)
> current steps (30 mA) in exponential or linear mapping curves.
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> 
> v9
> - Revise the format of the comments.
> ---
>  drivers/video/backlight/Kconfig            |  13 ++
>  drivers/video/backlight/Makefile           |   1 +
>  drivers/video/backlight/mt6370-backlight.c | 351 +++++++++++++++++++++++++++++
>  3 files changed, 365 insertions(+)
>  create mode 100644 drivers/video/backlight/mt6370-backlight.c

Applied, thanks.

-- 
Lee Jones [李琼斯]

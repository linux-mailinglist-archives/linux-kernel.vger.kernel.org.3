Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43811577D87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiGRIaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiGRI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:29:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E6917AB4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:29:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j1so11474608wrs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pvrgndmmn8YktJ8T281XpjP9LliHnMlSYEnEf1KWrn8=;
        b=w/VI4XpE1c0gfAglNbNRXAhqPaRGANN0H3VlIihlDxCg0AFssRZyH9JH2CMhjh+m16
         r9kx4cxZCwdPZHxM0QdTBdRa5GCRRy41dnLXaFC6kIw9J1f5Ud1bVQRDVEUOu+LjUtdS
         0y0tP5IbD4pC0v7bW4NL3pvVOPG6p3ApdqDU1kFlB76VT7bI00QQ0lrVHyUiX7XOGp7o
         j1sVgLaVztKSzwMJSZyw6MYGaI14FICoLPBg+neREy/8xVc3QW7pyhn80waPTWnR9x2t
         9XNnDuiZm3q7jQ/GPmcSMQk6KrtZeHHA+RqZ7x6QBYgKE/kYnQPnRe2srklOqQJOWrb7
         icHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pvrgndmmn8YktJ8T281XpjP9LliHnMlSYEnEf1KWrn8=;
        b=V0UfPg0lSnL9y5QlhQ0ZiLLmuvVS3ZkbxxStVNt26/ZW91vCBFjfd04Gwb5bGCgWa7
         K2jlCupCPzV3mLATtUDgTnggvxYtZ9EHWRkvrGEWGVEZy0bKSTjKsdXDMwnbqzg4BJ39
         UtBrzNErrs/LChlHJbjgxOeNyuzRUzMWcVugE63X6cTyeMQ692j8rpLuWWybyl4QKHRE
         SNbAQEeehvZ00KzAL7Ng3s2Crl+c1ZuAjk6b2zsOgqiV+8eHVUkBdl5DoVA355xFO70s
         Y54wZu7hPxaw3bHCsaML/W6OEAxERN2dzkpW15n5xr8/U5s6iMvSx4fAQhp5GM09jevk
         HgoQ==
X-Gm-Message-State: AJIora8nSHqiKtzP4ucc3Z/EcI8Iwl1RA6X1nPS7075ZqjlFQCpgOLUy
        89FSPt5soir/qcu7PplKK5FsbA==
X-Google-Smtp-Source: AGRyM1veFFWv0Q5z9BYX2jyf571R7JB8ReLTZNwWeeEEwHqF1qW4UQ6d0Kq8k4zFKqezBHF1hXY/XQ==
X-Received: by 2002:a5d:64a3:0:b0:21d:adaa:ce4c with SMTP id m3-20020a5d64a3000000b0021dadaace4cmr21808418wrp.161.1658132992989;
        Mon, 18 Jul 2022 01:29:52 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003a2ed2a40e4sm17076668wms.17.2022.07.18.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:29:52 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:29:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH RESEND v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YtUZ/ojZjcPlzTHi@google.com>
References: <20220714215334.78226-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714215334.78226-1-mairacanal@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022, Maíra Canal wrote:

> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>

Nit: This should be chronological.

> ---
> V1 -> V2: Initialize variable and simplify conditional loop
> V2 -> V3: Fix assignment of NULL variable
> V3 -> V4: Replace division for pwm_set_relative_duty_cycle
> V4 -> V5: Fix overwrite of state.period
> V5 -> V6: Fix duty cycle rounding and set period outside conditional loop
> ---
>  drivers/video/backlight/lp855x_bl.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

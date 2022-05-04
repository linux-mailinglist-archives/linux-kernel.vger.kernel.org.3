Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D051A4DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 18:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353040AbiEDQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244190AbiEDQFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 12:05:46 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1863E140C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 09:02:09 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7A2233F876;
        Wed,  4 May 2022 18:02:08 +0200 (CEST)
Date:   Wed, 4 May 2022 18:02:06 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-leds@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: ledtrig-pattern: Use last_repeat when applying hw
 pattern
Message-ID: <20220504160206.2xczi5lobk5z7vsh@SoMainline.org>
References: <20210418213427.220638-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210418213427.220638-1-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,

On 2021-04-18 23:34:26, Marijn Suijten wrote:
> `last_repeat` holds the actual value requested by the user whereas
> `repeat` is a software iteration variable that is unused in hardware
> patterns.
> 
> Furthermore `last_repeat` is the field returned to the user when reading
> the `repeat` sysfs property.  This field is initialized to `-1` which is
> - together with `1` - the only valid value in the upcoming Qualcomm LPG
> driver.  It is thus unexpected when `repeat` with an initialization
> value of `0` is passed into the the driver, when the sysfs property
> clearly presents a value of `-1`.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Thanks for picking up Bjorn's LPG patch into your tree!  Will you also
be able to pick up this patch to accompany it?

- Marijn

> ---
>  drivers/leds/trigger/ledtrig-pattern.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-pattern.c b/drivers/leds/trigger/ledtrig-pattern.c
> index 4d138d5317e9..2853b75df338 100644
> --- a/drivers/leds/trigger/ledtrig-pattern.c
> +++ b/drivers/leds/trigger/ledtrig-pattern.c
> @@ -126,7 +126,8 @@ static int pattern_trig_start_pattern(struct led_classdev *led_cdev)
>  
>  	if (data->is_hw_pattern) {
>  		return led_cdev->pattern_set(led_cdev, data->patterns,
> -					     data->npatterns, data->repeat);
> +					     data->npatterns,
> +					     data->last_repeat);
>  	}
>  
>  	/* At least 2 tuples for software pattern. */
> -- 
> 2.31.1
> 

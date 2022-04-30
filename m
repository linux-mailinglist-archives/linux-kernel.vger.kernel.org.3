Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7627515E70
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382897AbiD3Oz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242575AbiD3OzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:55:12 -0400
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [5.144.164.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3A33E0C;
        Sat, 30 Apr 2022 07:51:49 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id E34F23F685;
        Sat, 30 Apr 2022 16:51:46 +0200 (CEST)
Date:   Sat, 30 Apr 2022 16:51:45 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220430145145.2zlxahmtjwyzezkg@SoMainline.org>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
 <20220430123502.7od55knvxkw3sv6s@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220430123502.7od55knvxkw3sv6s@SoMainline.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-30 14:35:04, Marijn Suijten wrote:
[..]
> > +static int lpg_add_led(struct lpg *lpg, struct device_node *np)
> > +{
> > +	struct led_init_data init_data = {};
> > +	struct led_classdev *cdev;
> > +	struct device_node *child;
> > +	struct mc_subled *info;
> > +	struct lpg_led *led;
> > +	const char *state;
> > +	int num_channels;
> > +	u32 color = 0;
> > +	int ret;
> > +	int i;
> > +
> > +	ret = of_property_read_u32(np, "color", &color);
> > +	if (ret < 0 && ret != -EINVAL) {
> > +		dev_err(lpg->dev, "failed to parse \"color\" of %pOF\n", np);
> > +		return ret;
> > +	}
> > +
> > +	if (color == LED_COLOR_ID_RGB)
> > +		num_channels = of_get_available_child_count(np);
> > +	else
> > +		num_channels = 1;
> > +
> > +	led = devm_kzalloc(lpg->dev, struct_size(led, channels, num_channels), GFP_KERNEL);
> > +	if (!led)
> > +		return -ENOMEM;
> > +
> > +	led->lpg = lpg;
> > +	led->num_channels = num_channels;
> > +
> > +	if (color == LED_COLOR_ID_RGB) {
> > +		info = devm_kcalloc(lpg->dev, num_channels, sizeof(*info), GFP_KERNEL);
> > +		if (!info)
> > +			return -ENOMEM;
> > +		i = 0;
> > +		for_each_available_child_of_node(np, child) {
> > +			ret = lpg_parse_channel(lpg, child, &led->channels[i]);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			info[i].color_index = led->channels[i]->color;
> > +			info[i].intensity = 0;
> 
> This struct also has a "channel" field that doesn't seem to be used
> anywhere.  Should we still initialize it to something sensible, or is it
> better reported upstream for removal?

Never mind the second bit: lp552[13] uses the `channel` field internally
to store a custom index.  This LPG driver simply iterates over all the
led channels (stored in the LPG struct, with all necessary info) in the
same order as the subleds in the multicolor led device, so it's most
likely of no use for us.

- Marijn

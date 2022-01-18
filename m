Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE49D492817
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbiARON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:13:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37714 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiARONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:13:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21B6E614BC;
        Tue, 18 Jan 2022 14:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CBEC00446;
        Tue, 18 Jan 2022 14:13:21 +0000 (UTC)
Message-ID: <2f82dbe8-50d6-d905-9065-d3869948aa06@xs4all.nl>
Date:   Tue, 18 Jan 2022 15:13:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [BUG] pinctrl: reg-fixed-voltage usb0-vbus: error -EINVAL: can't
 get GPIO
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        zhangn1985@gmail.com
References: <Yea3rBmY+MO4AhhV@Red>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <Yea3rBmY+MO4AhhV@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/22 13:50, Corentin Labbe wrote:
> Hello
> 
> As reported on old googlegroup sunxi mainling list, on linux-next-20220118, USB storage fail to bring up on orangepiPC.
> We can see some error logs in dmesg:
> reg-fixed-voltage usb0-vbus: error -EINVAL: can't get GPIO
> reg-fixed-voltage: probe of usb0-vbus failed with error -22
> 
> This is bisected to: 8df89a7cbc63c7598c00611ad17b67e8d5b4fad3 pinctrl-sunxi: don't call pinctrl_gpio_direction()
> 
> Reverting this commit lead to a working USB storage being setuped.

Hmm, I'll bet it's EPROBE_DEFER related.

The original call (pre that commit) of pinctrl_gpio_direction_output() checks
if the pin controller could find the pin (pinctrl_get_device_gpio_range()).

That doesn't happen in the new code.

The sunxi appears to have two pincontrollers in the device tree (&pio and &r_pio),
that might be part of the reason this is an issue here.

Linus, should there be a check somewhere for a missing pincontroller in
gpiod_get_index()? I suspect that before my commit it was the gpiod_configure_flags
call in that function that returned -EPROBE_DEFER, but I'm not completely certain.

If someone can give me a hint about what should be done, then I can make a patch.

The alternative is to revert this sunxi patch, but perhaps this is a deeper
problem with these pincontroller drivers that set the direction directly
instead of going through pinctrl_gpio_direction_output().

Corentin, it would help me if you can figure out where the EPROBE_DEFER is
returned (pre-commit) in drivers/pinctrl/core.c. Probably pinctrl_get_device_gpio_range().

And I'd love to have the WARN_ON(1) output from just before the 'return -EPROBE_DEFER'.

Regards,

	Hans

> 
> Regards

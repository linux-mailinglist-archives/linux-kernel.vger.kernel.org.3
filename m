Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2B49FF85
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350710AbiA1RXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350997AbiA1RVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:21:52 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF0BC0613A7;
        Fri, 28 Jan 2022 09:20:05 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id d18-20020a9d51d2000000b005a09728a8c2so6359563oth.3;
        Fri, 28 Jan 2022 09:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UwbQPftUNn9yAB4yzqKeQDB/pWC4kXl5NucfopNQ3ag=;
        b=PWuAAkFkDtJVYG819y6ifto/NACTzta68iof02lYXGK4TQCZ6YMwgpN6x9wGagpTkD
         i0EsTVdeo+F/4UtWOICMnSpByL4d8E2QtiDXKxRyVNS23Ik15kjtMaH5bsNQ8KZCBR7I
         a0d+7BEf2jH6K+izh54gYOll0z3ec2q43de18V1jcr1UPlgSxdSC4l+dmcThpwizmIq4
         w0EYEQFz1T1zElGgk8xJ7KRPprPSoDGttAyOnXaxCp8Ze2AC4WE9ije+JsSVAn82xuFK
         uweG/N5/k6zc4rYLV0ib3U4euYOuQOvLVaqCDK7o1M7eGyF+94uMF1V8xB/t0cXov9ju
         HYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UwbQPftUNn9yAB4yzqKeQDB/pWC4kXl5NucfopNQ3ag=;
        b=VlJCHt3bLnn5Q8so5UtvXO4uB1jetm9y6GrF4tLnNw2NyQA2P+Wjb8j3R17V3WXkFT
         sZOyXi4Qh/Jphixj9j0bRD6gzxVs4q8qrSQvFiTuv8U/stj34G8NiLnCt4F+9zs1El3y
         FUPS7PvUj0R5OXhZ/qb2NiABBQXjaeD+cqFPC9iHNnrweRZraPXwRHN9hz2XPJxjX+HW
         sA/6OqWDnB2FguyBAEX7plK8pHsquMJ94WtB2qNnYlMUhM9ilsMG8e2jeQuw8agJauu8
         gG0gfPWOjXw//4OGD+QKtBLQqIazva48yeh4Ie3kHRNk1NWGeNRUJ1ApzddX3kn/4Awb
         HwcQ==
X-Gm-Message-State: AOAM5331xnxEFsLmwr/lOJiaPzv0xFCOcHT1DYHKb18zlayHOaNkzpMv
        KAunmngZKoYJ2Qb0Ut9AyW8=
X-Google-Smtp-Source: ABdhPJyvhy6GpcH81DShxWe8ImoRoO9OShyxokZ7SwtkWzv+0GKqFn3QzOSGVNutpWMxaWa4rky3xQ==
X-Received: by 2002:a9d:7e88:: with SMTP id m8mr5100388otp.123.1643390405340;
        Fri, 28 Jan 2022 09:20:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21sm3983087otq.81.2022.01.28.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:20:04 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Jan 2022 09:20:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangn1985@gmail.com
Subject: Re: [BUG] pinctrl: reg-fixed-voltage usb0-vbus: error -EINVAL: can't
 get GPIO
Message-ID: <20220128172003.GA2666058@roeck-us.net>
References: <Yea3rBmY+MO4AhhV@Red>
 <2f82dbe8-50d6-d905-9065-d3869948aa06@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f82dbe8-50d6-d905-9065-d3869948aa06@xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:13:20PM +0100, Hans Verkuil wrote:
> On 1/18/22 13:50, Corentin Labbe wrote:
> > Hello
> > 
> > As reported on old googlegroup sunxi mainling list, on linux-next-20220118, USB storage fail to bring up on orangepiPC.
> > We can see some error logs in dmesg:
> > reg-fixed-voltage usb0-vbus: error -EINVAL: can't get GPIO
> > reg-fixed-voltage: probe of usb0-vbus failed with error -22
> > 
> > This is bisected to: 8df89a7cbc63c7598c00611ad17b67e8d5b4fad3 pinctrl-sunxi: don't call pinctrl_gpio_direction()
> > 
> > Reverting this commit lead to a working USB storage being setuped.
> 
> Hmm, I'll bet it's EPROBE_DEFER related.
> 

No. For me the problem is only seen if I try to boot from the second usb
interface with the orangepi-pc qemu emulation, but not when I try to boot
from the first usb interface. That alone makes it unlikely to be an
EPROBE_DEFER related problem.

Some debugging with your code in the tree:

[    7.076227] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=10, input=0
[    7.076567] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pinctrl_gpio_direction_output: offset=10, value=1, ret=-22
[    7.076992] leds-gpio: probe of leds failed with error -22
[    7.081645] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=2, input=0
[    7.081887] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pinctrl_gpio_direction_output: offset=2, value=0, ret=-22
[    7.082424] reg-fixed-voltage usb0-vbus: error -EINVAL: can't get GPIO
[    7.082793] reg-fixed-voltage: probe of usb0-vbus failed with error -22
[    7.129355] sun8i-h3-pinctrl 1c20800.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=166, input=1
[    7.129844] sun8i-h3-pinctrl 1c20800.pinctrl: ######### sunxi_pinctrl_gpio_direction_input: offset=166, ret=0
[    7.130788] sunxi-mmc 1c0f000.mmc: Got CD GPIO
[    7.169391] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=3, input=1
[    7.169663] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ######### sunxi_pinctrl_gpio_direction_input: offset=3, ret=-22
[    7.170054] gpio-keys r_gpio_keys: failed to get gpio: -22
[    7.170262] gpio-keys: probe of r_gpio_keys failed with error -22

And after reverting it:

[    6.138097] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=362, input=0
[    6.138375] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pinctrl_gpio_direction_output: offset=10, value=1, ret=0
[    6.140762] sun8i-h3-pinctrl 1c20800.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=15, input=0
[    6.140918] sun8i-h3-pinctrl 1c20800.pinctrl: ########### sunxi_pinctrl_gpio_direction_output: offset=15, value=0, ret=0
[    6.142808] sun8i-h3-pinctrl 1c20800.pinctrl: supply vcc-pf not found, using dummy regulator
[    6.148879] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=354, input=0
[    6.149086] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pinctrl_gpio_direction_output: offset=2, value=0, ret=0
[    6.154485] sun8i-h3-pinctrl 1c20800.pinctrl: supply vcc-pg not found, using dummy regulator
[    6.155657] sun8i-h3-pinctrl 1c20800.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=204, input=1
[    6.155853] sun8i-h3-pinctrl 1c20800.pinctrl: ######### sunxi_pinctrl_gpio_direction_input: offset=204, ret=0
[    6.174411] ehci-platform 1c1b000.usb: EHCI Host Controller
[    6.174737] ehci-platform 1c1b000.usb: new USB bus registered, assigned bus number 3
[    6.188776] sun8i-h3-pinctrl 1c20800.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=166, input=1
[    6.189149] sun8i-h3-pinctrl 1c20800.pinctrl: ######### sunxi_pinctrl_gpio_direction_input: offset=166, ret=0
[    6.189720] sunxi-mmc 1c0f000.mmc: Got CD GPIO
...
[    6.674660] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ########### sunxi_pmx_gpio_set_direction: offset=355, input=1
[    6.674796] sun8i-h3-r-pinctrl 1f02c00.pinctrl: ######### sunxi_pinctrl_gpio_direction_input: offset=3, ret=0

In other words, there is some offset translation missing with your patch,
causing -EINVAL returns.

Guenter

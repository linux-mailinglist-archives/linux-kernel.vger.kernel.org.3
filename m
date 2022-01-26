Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985BB49C83B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbiAZLDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:03:11 -0500
Received: from ewsoutbound.kpnmail.nl ([195.121.94.168]:52635 "EHLO
        ewsoutbound.kpnmail.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbiAZLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:03:10 -0500
X-KPN-MessageId: 8b98a59c-7e97-11ec-8f5a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 8b98a59c-7e97-11ec-8f5a-005056aba152;
        Wed, 26 Jan 2022 12:03:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:to:from:subject:mime-version:date:message-id;
        bh=hpRXVYQAeLF7Lzo7fENLhR+NrCXnkhg6vrFNrU9sDzQ=;
        b=lPF2MKr43JmTbMmOoxI2HRZKq5NhW7XaLhGLt+Jqdn1RrWVV4s77+65+ZD3i9Bw/C/xeFY0YHg7wQ
         H0y2noosmHOeMhG5sAxReoxMzDUgTD5/cNanfhjLe7pBJTQgt9hoLicdZkmWfsFJe7lrAE0a9OlS6N
         O2JFmFos6jvPtGK7YWao37ysGRmDB++ufsNpQgdJdXNNfidwJB0ZY2YXCnYZpbGnKJH5eXu/rp+Nbs
         HyJfKelp9Frw6DPx/O/5L+S6qNHkr3zMTxj1Q5td/1r4PP3/wvtV9Kh6nnwPV9DDetM/BA0Dh6kTjB
         qpj+ilkSAJkozm2I/jJVe03xdWyMc6g==
X-KPN-VerifiedSender: No
X-CMASSUN: 33|/C7XuEzgB9S8L3t+I4MsWICp/jGohKOA2pwymdZ5uESaHf3NzAUuYLgF9I8xf7/
 xPkgeAeLQPSfzogGGyB5cUQ==
X-Originating-IP: 80.101.105.217
Received: from [192.168.1.10] (marune.xs4all.nl [80.101.105.217])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 8af0249c-7e97-11ec-a3ee-005056abf0db;
        Wed, 26 Jan 2022 12:03:08 +0100 (CET)
Message-ID: <ef2317a5-d9a7-a663-2477-b435b777d4e0@xs4all.nl>
Date:   Wed, 26 Jan 2022 12:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [BUG] pinctrl: reg-fixed-voltage usb0-vbus: error -EINVAL: can't
 get GPIO
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        zhangn1985@gmail.com
References: <Yea3rBmY+MO4AhhV@Red>
 <2f82dbe8-50d6-d905-9065-d3869948aa06@xs4all.nl>
In-Reply-To: <2f82dbe8-50d6-d905-9065-d3869948aa06@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2022 15:13, Hans Verkuil wrote:
> On 1/18/22 13:50, Corentin Labbe wrote:
>> Hello
>>
>> As reported on old googlegroup sunxi mainling list, on linux-next-20220118, USB storage fail to bring up on orangepiPC.
>> We can see some error logs in dmesg:
>> reg-fixed-voltage usb0-vbus: error -EINVAL: can't get GPIO
>> reg-fixed-voltage: probe of usb0-vbus failed with error -22
>>
>> This is bisected to: 8df89a7cbc63c7598c00611ad17b67e8d5b4fad3 pinctrl-sunxi: don't call pinctrl_gpio_direction()
>>
>> Reverting this commit lead to a working USB storage being setuped.

Hopefully this is resolved by this patch:

https://patchwork.linuxtv.org/project/linux-media/patch/0f536cd8-01db-5d16-2cec-ec6d19409a49@xs4all.nl/

Please test!

Regards,

	Hans

> 
> Hmm, I'll bet it's EPROBE_DEFER related.
> 
> The original call (pre that commit) of pinctrl_gpio_direction_output() checks
> if the pin controller could find the pin (pinctrl_get_device_gpio_range()).
> 
> That doesn't happen in the new code.
> 
> The sunxi appears to have two pincontrollers in the device tree (&pio and &r_pio),
> that might be part of the reason this is an issue here.
> 
> Linus, should there be a check somewhere for a missing pincontroller in
> gpiod_get_index()? I suspect that before my commit it was the gpiod_configure_flags
> call in that function that returned -EPROBE_DEFER, but I'm not completely certain.
> 
> If someone can give me a hint about what should be done, then I can make a patch.
> 
> The alternative is to revert this sunxi patch, but perhaps this is a deeper
> problem with these pincontroller drivers that set the direction directly
> instead of going through pinctrl_gpio_direction_output().
> 
> Corentin, it would help me if you can figure out where the EPROBE_DEFER is
> returned (pre-commit) in drivers/pinctrl/core.c. Probably pinctrl_get_device_gpio_range().
> 
> And I'd love to have the WARN_ON(1) output from just before the 'return -EPROBE_DEFER'.
> 
> Regards,
> 
> 	Hans
> 
>>
>> Regards


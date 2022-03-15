Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB324D9410
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344878AbiCOFoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiCOFoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:44:00 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AF542EC8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:42:44 -0700 (PDT)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nTzx9-00020F-RU; Tue, 15 Mar 2022 06:42:39 +0100
Message-ID: <e5302bda-ba48-4308-2b3a-a686e9430055@leemhuis.info>
Date:   Tue, 15 Mar 2022 06:42:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Linux 5.17-rc8
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marcelo Roberto Jimenez <marcelo.jimenez@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Michael Walle <michael@walle.cc>
References: <CAHk-=wiHa0vsZseZES=1T0rJ4Z_bC5cwHMUJfqFL9hVpvB283g@mail.gmail.com>
 <20220314192522.GA3031157@roeck-us.net>
 <CAHk-=wiEhs+4P1TNh2sNnk04D1FFdNThk6XLOMxzkRL72PEXFw@mail.gmail.com>
 <CACjc_5paC=X4znTty8LBtobqBW2nq4mbQYnw_TMgVEFb1A7mhA@mail.gmail.com>
 <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <CAHk-=wh0QBksyaTEn4gk=mn6hgAhp3e8i9mRsr657Dd-kQ3MKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1647322964;af7b6a34;
X-HE-SMSGID: 1nTzx9-00020F-RU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing regressions list and Michael Walle]

FWIW, I was a bit surprised to see this, I had assumed the revert that
causing trouble (fc328a7d1fcc) would go in the next merge window. Seems
my regression tracking work did more harm then good here. :-/ Whatever:

On 15.03.22 02:47, Linus Torvalds wrote:
> On Mon, Mar 14, 2022 at 5:45 PM Marcelo Roberto Jimenez
> <marcelo.jimenez@gmail.com> wrote:
>>
>> At a certain point, I tried Thorsten's suggestion to add a gpio-ranges
>> property in a way similar to another patch, but the kernel went into
>> an EPROBE_DEFER deadlock. Thierry Reding made some comments about this
>> in the sequence.
> 
> Hmm. The problem does sound like that particular driver doesn't use
> the pin_ranges thing, so then the tests for an empty pin_ranges will
> always be true.
>
> [...]
>
> IOW, it looks like either a gpio controller has to implement that
> 'add_pin_ranges()' function (only tegra), or it needs to always add
> the pin ranges at probe time.
> 
> Am I guessing right that the driver that you use does neither?
> 
> LinusW/Bartoz - this all really sounds strange to me. Maybe I'm
> misreading the situation entirely. Should there be some sanity-test
> that any gpio/pinctrl driver that uses gpiochip_generic_request()
> would either have to have that add_pin_ranges() callback, or a
> successful probe needs to always populate that 'gpiodev->pin_ranges'
> list?
> 
> Or maybe I'm misreading the situation entirely. I don't know the code
> - I'm just grepping for things and trying to make sense of how that
> '->pin_ranges' list is supposed to work.
> 
> But for now, I think that patch has to be reverted.

There is a another reason to do so: Michael Walle reported that the
revert is causing a regression for him:
https://lore.kernel.org/stable/20220314155509.552218-1-michael@walle.cc/

To quote:

```
> This breaks the pinctrl-microchip-sgpio driver as far as I can see.
> 
> I tried to debug it and this is what I have discovered so far:
>  (1) the sgpio driver will use the gpio_stub_drv for its child nodes.
>      Looks like a workaround, see [1].
>  (2) these will have an empty gpio range
>  (3) with the changes of this patch, pinctrl_gpio_request() will now
>      be called and will fail with -EPROBE_DEFER.
> 
> I'm not exactly sure what to do here. Saravana Kannan once suggested
> to use devm_of_platform_populate() to probe the child nodes [2]. But
> I haven't found any other driver doing that.
> 
> Also, I'm not sure if there are any other other driver which get
> broken by this. I.e. ones falling into the gpio_stub_drv category.
> 
> [1] https://lore.kernel.org/lkml/20210122193600.1415639-1-saravanak@google.com/
> [2] https://lore.kernel.org/lkml/CAGETcx9PiX==mLxB9PO8Myyk6u2vhPVwTMsA5NkD-ywH5xhusw@mail.gmail.com/
> 
> -michael
> 
> NB. this patch doesn't contain a Fixes tag. Was this on purpose?
```

Ciao, Thorsten

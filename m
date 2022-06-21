Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C9B553D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353783AbiFUVW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355893AbiFUVW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 17:22:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBCDC45;
        Tue, 21 Jun 2022 14:11:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i10so16879012wrc.0;
        Tue, 21 Jun 2022 14:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=5jGRxWa+Hik2xXu28OZInbUMDSK1LmZ28o9a5C6ustA=;
        b=dBkR+OXnEaZPr9uoaZB+DI5wT1AXufYbc+9qN44d74R1jy7oOaP5glLLgc/hzh3E8m
         VEYB0O8O8TiK3K0KU8aR4nbUvWWFGE7uePKS5PELYCU4SnEeJA8EVcTkrM2DoduTme8M
         T2w+A4Oj1CabUPV/iQcD8tJhe3/0P4UoInCNfQd2pdDiq/qrgQ6JtX7yLUUFdykN73bM
         NtCtwLELefp/0JcgOX6hIfK1mCyMbjfNrGysmUUfiSDKIuEdhMG6diRPWKvISTwtHa9N
         kgrC4FpslcP3XTRRhPHg48OrMHfSCIL2fPrOOeRY9LvrBNjg8LF3SLUYHP6wXsVMRurd
         LPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=5jGRxWa+Hik2xXu28OZInbUMDSK1LmZ28o9a5C6ustA=;
        b=GRmD+rEmXrMnUtW7IfBoAGKKPPN+YVnROxzkNjrqTB/oz9pEbFht7AMknO1tjHabtH
         TyfGnnqPnVsO6X4PwWyabx59vfmnikZO7mq5isr6P+Zj0wiV0y0EE1IVRIcdjKAV/8x+
         9IZQGI937lernsAAO5yuRjtIADETJF2BYtVShBsoH+k1pugq8/sdslg+3ZFOlqPs43iQ
         44gKlfi++UfxdSIX5JU/d5d/eVhqdLeuYCGDE/VFeBg39klm7YBpg6GSNmJrphlF53D5
         izCsU0mkxRSqxFnLWYIhXd9mYl656kdoT/MhptGVBbddFG0H66mT0VHttGBIanHBLbl+
         2Ffg==
X-Gm-Message-State: AJIora9I2C5lWwottjfOMj0YGN8+wtusm1f1iLN/FZ6qin5yVDs3/Fk7
        rfUByHCKM4FIdpQwygRl+3Q=
X-Google-Smtp-Source: AGRyM1uWGscZnGaavVg/uIQYsRslzM5t54de/BLxZBl+KXB10CZYw57ndf/q8EV3SUZ+AQYy58rh1w==
X-Received: by 2002:adf:fb10:0:b0:207:af88:1eb9 with SMTP id c16-20020adffb10000000b00207af881eb9mr30853557wrr.238.1655845918233;
        Tue, 21 Jun 2022 14:11:58 -0700 (PDT)
Received: from localhost (92.40.168.122.threembb.co.uk. [92.40.168.122])
        by smtp.gmail.com with ESMTPSA id bv27-20020a0560001f1b00b0021b84ac7a05sm7979960wrb.0.2022.06.21.14.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:11:57 -0700 (PDT)
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-16-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vd7Sq9RMqin_y-8qUEAJLaGfuqxAbe+qcMB22=bqkyZqg@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, tharvey@gateworks.com,
        rjones@gateworks.com, Matti Vaittinen <mazziesaccount@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-actions@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 15/49] regmap-irq: Change the behavior of mask_writeonly
In-reply-to: <CAHp75Vd7Sq9RMqin_y-8qUEAJLaGfuqxAbe+qcMB22=bqkyZqg@mail.gmail.com>
Date:   Tue, 21 Jun 2022 22:13:03 +0100
Message-ID: <FQHPnJKuXUHf8vLiZoXidpoim5RtEYUC@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>>
>> No drivers currently use mask_writeonly, and in its current form
>> it seems a bit misleading. When set, mask registers will be
>> updated with regmap_write_bits() instead of regmap_update_bits(),
>> but regmap_write_bits() still does a read-modify-write under the
>> hood. It's not a write-only operation.
>>
>> Performing a simple regmap_write() is probably more useful, since
>> it can be used for chips that have separate set & clear registers
>> for controlling mask bits. Such registers are normally volatile
>> and read as 0, so avoiding a register read minimizes bus traffic.
>
> Reading your explanations and the code, I would rather think about
> fixing the regmap_write_bits() to be writeonly op.

That's impossible without special hardware support.

> Otherwise it's unclear what's the difference between
> regmap_write_bits() vs. regmap_update_bits().

This was not obvious to me either. They're the same except in how they
issue the low-level write op -- regmap_update_bits() will only do the
write if the new value differs from the current one. regmap_write_bits()
will always do a write, even if the new value is the same.

I think the problem is lack of documentation. I only figured this out
by reading the implementation.

>>         if (d->chip->mask_writeonly)
>> -               return regmap_write_bits(d->map, reg, mask, val);
>> +               return regmap_write(d->map, reg, val & mask);
>>         else
>>                 return regmap_update_bits(d->map, reg, mask, val);

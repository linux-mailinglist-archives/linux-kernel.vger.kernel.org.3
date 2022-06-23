Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69797558A61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiFWUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFWUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:53:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745660C71;
        Thu, 23 Jun 2022 13:53:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so384932wmb.5;
        Thu, 23 Jun 2022 13:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uR19dUJmcNaxBwdM2oTyzNVaO2KBzPX6s9JgcdgMii0=;
        b=ij55DIpBjm/hJbjc0ntL8Q2eWnzNJC2eDhKfxvV1EykMihvHpPJDo3uD/32lOcvKvF
         +Nub1SNXWszsbsqNrrOZywFANBPl6ZQxpN+ByL6OCsk5SheLF4ClaATXOY2xs7A0cBlg
         JAh8CpZNLrm1wTf/ZyU42B38HdJvGMfVTdfI7NPHrngS9uVghyow7eDum8QPsJURP/lm
         nGsgFVuP5u+Sj/fy1JQvRyFUTWu4ChJBQh70+mErYPMicSVDCWeFZv0Qmp42+DP8RQWH
         37PqXCX0mjI5Ww40jRdGzUjybml3+Zz/VJod3AczUP5t0Ncdc/pVDM3foOeWPsbmZdmU
         YUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uR19dUJmcNaxBwdM2oTyzNVaO2KBzPX6s9JgcdgMii0=;
        b=tepO17FqAE8NY/PDvLHksCYL6RRXUHIv/emEobJO2JgQME7GVyjWfhDvIhvMH2aRop
         H0AxOoU2yyLjqZeKfdzEChM48np+A7PhhE4/YlHZOCnDM4+vYNqJ/qEjiZxpNzHB05Oa
         gBJRcqdL2p8WsuLxoarTPkkvcA6lOW86HOkkAGHekr4l2ZdjbuLqm8QT2UowtLmfvAdT
         mifECCjiX/OFCVyQfKDPUv6cXtgXmU78ws1cl7bGFWFU+p54q4/7aPDoRP6IXVq8kYSt
         1xsqcBmHFv0VLZO76hkurfRuP6dTpNpg/UzFauDIPZisdnhiWEBqDjtrUom1yjFxEVg2
         V3/Q==
X-Gm-Message-State: AJIora/XVYDrkb5rcCmhwyQgrSqU/tB06XvQcs73KxP7LSfIajUHC9ut
        V7MhE5aWlEncx+c4oDE5b90=
X-Google-Smtp-Source: AGRyM1tIBcbqqjiLWicrbHaR6vX8/2L6/5uVJuB9R6VbK4sR7Y33O50Sc4VbODYyYuYA5cMC0BoYeA==
X-Received: by 2002:a05:600c:4f15:b0:39c:7eaf:97e7 with SMTP id l21-20020a05600c4f1500b0039c7eaf97e7mr6415694wmq.199.1656017612752;
        Thu, 23 Jun 2022 13:53:32 -0700 (PDT)
Received: from localhost (92.40.171.44.threembb.co.uk. [92.40.171.44])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d67ce000000b0021b89c07b6asm406757wrw.108.2022.06.23.13.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 13:53:32 -0700 (PDT)
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
 <20220620200644.1961936-16-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vd7Sq9RMqin_y-8qUEAJLaGfuqxAbe+qcMB22=bqkyZqg@mail.gmail.com>
 <FQHPnJKuXUHf8vLiZoXidpoim5RtEYUC@localhost>
 <CAHp75VfoMKo9-_OTF1AAC0KyNJOb5qvYPTgHxmkYwOfTJFSLkg@mail.gmail.com>
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
        Chen-Yu Tsai <wens@csie.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-actions@lists.infradead.org" 
        <linux-actions@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 15/49] regmap-irq: Change the behavior of mask_writeonly
In-reply-to: <CAHp75VfoMKo9-_OTF1AAC0KyNJOb5qvYPTgHxmkYwOfTJFSLkg@mail.gmail.com>
Date:   Thu, 23 Jun 2022 21:54:37 +0100
Message-ID: <8qRxwIYmbvte9HM2KVfkdhwPpeZ7oY9s@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On Tuesday, June 21, 2022, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>=
 wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>>
>> > On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
>> > <aidanmacdonald.0x0@gmail.com> wrote:
>> >>
>> >> No drivers currently use mask_writeonly, and in its current form
>> >> it seems a bit misleading. When set, mask registers will be
>> >> updated with regmap_write_bits() instead of regmap_update_bits(),
>> >> but regmap_write_bits() still does a read-modify-write under the
>> >> hood. It's not a write-only operation.
>> >>
>> >> Performing a simple regmap_write() is probably more useful, since
>> >> it can be used for chips that have separate set & clear registers
>> >> for controlling mask bits. Such registers are normally volatile
>> >> and read as 0, so avoiding a register read minimizes bus traffic.
>> >
>> > Reading your explanations and the code, I would rather think about
>> > fixing the regmap_write_bits() to be writeonly op.
>>
>> That's impossible without special hardware support.
>>
>> > Otherwise it's unclear what's the difference between
>> > regmap_write_bits() vs. regmap_update_bits().
>>
>> This was not obvious to me either. They're the same except in how they
>> issue the low-level write op -- regmap_update_bits() will only do the
>> write if the new value differs from the current one. regmap_write_bits()
>> will always do a write, even if the new value is the same.
>
> Okay, it makes a lot of sense for W1C type of bits in the register.
> Also, =E2=80=9Creading=E2=80=9D might imply to restore last value from ca=
che, no?

Maybe there needs to be some explanation of what the typical use case is
and why you'd choose write_bits() over update_bits(), because the more I
think about it the less clear it is. You're right that the read could be
served from a cache. But I'm not sure if a cache would be safe if even
one bit in the register is volatile, and I can't really see a use case
for write_bits() that doesn't involve volatile behavior of some sort.

In any event, I'm just going to drop this patch and the related driver
patches in favor of removing mask_writeonly entirely, since it looks
like it was never used, and after thinking about it I'm not sure what
I did helps much. If some driver needs write_bits() for mask registers
down the road it's not a big deal to add this back.

>> I think the problem is lack of documentation. I only figured this out
>> by reading the implementation.
>>
>> >>         if (d->chip->mask_writeonly)
>> >> -               return regmap_write_bits(d->map, reg, mask, val);
>> >> +               return regmap_write(d->map, reg, val & mask);
>> >>         else
>> >>                 return regmap_update_bits(d->map, reg, mask, val);


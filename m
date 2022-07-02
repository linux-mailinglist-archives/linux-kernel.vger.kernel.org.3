Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE231564277
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiGBTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:21:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A9DFBF;
        Sat,  2 Jul 2022 12:21:54 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r14so1927802wrg.1;
        Sat, 02 Jul 2022 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=ShPrvMVvs0iuePdOh13YlEW0US0KOGLiiTqD4zGCiNY=;
        b=h+Qdn99o3gPmJiMNYJ8IJgMULL3Pew0pTISs4L2CeQQnyvSsIZ8aznyCoGBS9BGYi2
         FxoO0AWZPRTt6nxQGAahmwr7IMbhBVnRJnEMhHkqtBMLFQqsvvwM4Y+V7FeGyZOeeYBl
         mU9ZNByXO/UBhWkBUwLVlvM3AZ9KDIVq3CgNvYnaAkQPdPJXkC7mWyoTOb6y3VVcwhZK
         gpUYPWYZA5ChcrdsKSH7aQlCviSaRTFlOtm51v28waZ83qHW/aOEV30Sr/+RCL4Dxrdg
         T0V+G3YJHKHvZascKcwihEUX5TYVWMoK5B1QPlLHldc0QlJrbWuKZQ72ONJF7YtLldPs
         TZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ShPrvMVvs0iuePdOh13YlEW0US0KOGLiiTqD4zGCiNY=;
        b=rqeYQ0D/XcZ5vRXDdiJR9ByRan5mx9TANWyWLU+XkC9SdYH/AmwxN5R5HKrAzonOk8
         Ol/DLlZz4fv8zcBaeqXhkx4P+Zjq9KQHj2yP2az6sac04jCxA/durDumvKuip+iWpXEY
         p2PEQCdh+ZdeG9YL7Th8CVcaD3EvevEnJorNB/wt0LVfi4l1AVXTnodEbo9FqPcL/b5i
         BTKk9boaJE2QgkeTuuClKcaiMpv2GrClA4C1Y/Mzx+pLmPh11B6oOTFe+iFl3Bf4l4S9
         PmkJk5FKH4KH1qcK4dMM8b+Hpz35tOrzRq+GQSV7Fyf7dki+75ILJcIBn+zoSIrqm2BU
         F/qQ==
X-Gm-Message-State: AJIora8zXiEqmlA5WPZGBkY2Z8/WGMDHjyP98oatXj5na517CwUowOJG
        MNUVzdqQBVb7Ov6aP3C5DaA=
X-Google-Smtp-Source: AGRyM1tg3/+hgf9pDL8NRFCAQ4YOA7tn10T6UX7ijpnLqcxSD9+RqrDkEV/swdnxAMA8gwuref6OPw==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr18660614wro.603.1656789712614;
        Sat, 02 Jul 2022 12:21:52 -0700 (PDT)
Received: from localhost (92.40.203.19.threembb.co.uk. [92.40.203.19])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b0021b9c520953sm25806153wrs.64.2022.07.02.12.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:21:52 -0700 (PDT)
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com>
 <20220629143046.213584-13-aidanmacdonald.0x0@gmail.com>
 <CAHp75Vduv_fN=2DKbOwReRoPeAYjGqSANT7UhDaRifUJ4zf5XQ@mail.gmail.com>
 <oMIjFujkw4ZeuMGoTkWq64BbfEejJF12@localhost>
 <CAHp75VdVyJyOZCkLQgbDNC9bSWwF0ksLOvMG=96fH8dzmukE5g@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 12/15] pinctrl: Add AXP192 pin control driver
In-reply-to: <CAHp75VdVyJyOZCkLQgbDNC9bSWwF0ksLOvMG=96fH8dzmukE5g@mail.gmail.com>
Date:   Sat, 02 Jul 2022 20:22:58 +0100
Message-ID: <YhW7o8WJ6ptv6cU8GzuiBWbZt3kmczIL@localhost>
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

> On Fri, Jul 1, 2022 at 5:36 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>> Andy Shevchenko <andy.shevchenko@gmail.com> writes:
>> > On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
>> > <aidanmacdonald.0x0@gmail.com> wrote:
>
> ...
>
>> >> +struct axp192_pctl_function {
>> >> +       const char              *name;
>> >> +       /* Mux value written to the control register to select the function (-1 if unsupported) */
>> >> +       const u8                *muxvals;
>> >> +       const char * const      *groups;
>> >> +       unsigned int            ngroups;
>> >> +};
>> >
>> > Can it be replaced by struct function_desc?
>> > https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/pinmux.h#L130
>>
>> That'd work, but using the generic infrastructure doesn't allow me to
>> simplify anything -- I can eliminate three trivial functions, but the
>> generic code is higher overhead (extra allocations, radix trees, ...)
>
> I really don't see how it gets into extra allocations. Either way you
> have a pointer to opaque data or in your current code it's called
> muxvals. Other fields seem 1:1 what is in struct function_desc. The
> code will be probably the same.
>
> I.o.w. I'm talking of eliminating data type, and not about simplifying
> the code by fully switching to generic infrastructure.

struct function_desc is hidden behind an #ifdef, so I can't use it
without enabling the generic pinmux helpers. It doesn't make a lot
of sense to enable them if they're not going to be used.

More generally, why would I use a type from an API I'm not using just
because it happens to look like a type I defined locally? That would
be misleading. Given that the code is the same either way, a local type
is preferable because it clearly communicates that I'm not using the
generic API, and guarantees that the type isn't referenced elsewhere.

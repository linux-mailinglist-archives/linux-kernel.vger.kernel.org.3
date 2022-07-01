Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9631563736
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiGAPu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGAPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:50:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD254BC1B;
        Fri,  1 Jul 2022 08:50:53 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l68so1555459wml.3;
        Fri, 01 Jul 2022 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=wPj9N9qu4aq/UnSUzvPL7u5RGFCXg6RhipCMWPPUP+E=;
        b=qmHvFC4W+7jzt+PKswn0v+gJneeYa1y7Ec62t1euR7kRN13Ei7OpySs3CxTmkQff1m
         zqeHqN/e0VOGFfy6yS5zikdIcmri4FYdF68pthJ/RLi6l6NbR8yCOfiN09sfFGN7vu+3
         0KXLAWlF2w2IEJ5ZfZfNGpcnmnhVQ2cWXzUw7XO3zn0yzqBPy7DQOJNtAJLTHhOTZP1B
         lJWVLHwkbuSFTgseY8v+vDKmIBf05vVJNZAO5ooUy3+6C8weWR4QmxLX7pS92Br7NADr
         jWM6d20s5etMuPUjszIMPXCIBK3JVnAsR1be9EPBIz0pnu46stNF1u+RY/ZP8FRCslEa
         R4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=wPj9N9qu4aq/UnSUzvPL7u5RGFCXg6RhipCMWPPUP+E=;
        b=L74duYgqDL4/iyx2GlLz+UNEfjuvxJ8DtSXm0kOeYLvgfsCErRC6AXN57s7r/vBk+o
         FfGMJX1MaNJFUW1MZ7fP6JTmu9vPnDHeOsbhvXcNRHTR0hXcK/SqE0SeQzimYINgLLBY
         VSo6afEU9RjhMreQo+SAatMTLUc12/D2BqWjW5dQERIwTNWKItlrX7w1qzmf/sGnm3rX
         3xm0iTeNs3Q9/2X2/e9507a3+xUDqoS2FNsJYNWM9/6ukBqMbZT3OHKyDKGDn41Q5PER
         0KhmBLbSZlsEiF4QjrXtmWb/U3cT1UHkGu76AFa94c/wuYMqMtlwBlg0o0MlYAGrChZW
         VnNQ==
X-Gm-Message-State: AJIora+3N5eVxzhTya9gk/HUjiyu0JAz5cQDYteNTkWYqi9JtIPXHoah
        Kcgw0ZOgGWA7e+n0vB4Ct08=
X-Google-Smtp-Source: AGRyM1uvy66G1WQ/BJmadW36XZ6pD9gBgGsl38zD24GbCOyBZz9Hio0Gl/3/pUtmFDNPIFZza75obQ==
X-Received: by 2002:a05:600c:2246:b0:3a0:4d14:e9d5 with SMTP id a6-20020a05600c224600b003a04d14e9d5mr17113722wmm.70.1656690652283;
        Fri, 01 Jul 2022 08:50:52 -0700 (PDT)
Received: from localhost (92.40.202.200.threembb.co.uk. [92.40.202.200])
        by smtp.gmail.com with ESMTPSA id m123-20020a1ca381000000b003942a244f47sm7488681wme.32.2022.07.01.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:50:51 -0700 (PDT)
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
 <cafd8a40ad35dcf8a35350261af6031c@walle.cc>
 <me4ummrWKIPseIG4ay7yCfrumN8sIdvc@localhost>
 <01a338e8f94b077df3fe2c4f13d4da28@walle.cc>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com, lars@metafoo.de,
        rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
In-reply-to: <01a338e8f94b077df3fe2c4f13d4da28@walle.cc>
Date:   Fri, 01 Jul 2022 16:51:59 +0100
Message-ID: <HVuKY4uz71KVTEQCbjewrX6SufiowzOP@localhost>
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


Michael Walle <michael@walle.cc> writes:

> Am 2022-06-27 15:12, schrieb Aidan MacDonald:
>
>>> I *think* what is needed for gpio-regmap to support this is:
>>>  - support values and masks for the direction, for now, we
>>>    only support single bits.
>>>  - support the pinctrl_gpio_direction_{input,output} calls
>>> -michael
>> That sounds about right, thanks for taking a look.
>
> I thought you were trying to add these to gpio-regmap? Unless
> I'm missing something, that should be easy enough.
>
> -michael

Yeah, I can send patches this weekend. One detail I missed was the
to_irq() part, so I'm going to add a hook for that too.

The alternative is using hierarchical IRQ domains, but that seems
like a lot of added complication when to_irq() works just as well.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321EA5733F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiGMKP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiGMKPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:15:20 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF9E7AFF;
        Wed, 13 Jul 2022 03:15:16 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31cf1adbf92so107542267b3.4;
        Wed, 13 Jul 2022 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYDOSgJ5NnZWQaiNiMMrpM7JfcdIK7GvasjcwWRXaTc=;
        b=Vs9KktZrNStk7Gb+Q53QQHAx25Obv0AT++AQan+rXKOPJKW/9utoZ0luYdqMShPdGo
         +iI663FR/w2xxsIdlbSXYGEQLspqaKb62rucUmZcYSNput22YEEk+T+KnWHIMrP/8Ehm
         w79BD+PzInzZfui+DtnS2hCVsDSRvKjpOrZph+Wp9prdGr370SJCBA7HK6mD0tMLfwNp
         Y+mLiO7nnmGn/UMt6JiEGHa6WgLh4zrlOc0jl6LSJ0JtyPYANk3vSgbPeZOyLszAiv54
         Q7vMpmpCfR3vWaCS/557XKTBeBeVcl0qd4Z5RMBDSg+JKdLfS63boOWifporZ8KOKTg6
         R+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYDOSgJ5NnZWQaiNiMMrpM7JfcdIK7GvasjcwWRXaTc=;
        b=xP/hIyDTmAbib0hXokgkpBcKuevXHlM6Z7Oscv/F+2JyguB5PRduLxxgjoR1hdgxkP
         2GyP4SZ/GSd5XL+RoXLE7C9aSIshJ8pO5PuReU/Q/yHRhHSb08d3V58VSv0wtrpTjzxV
         QJq+USHCPOvZt2Bsxu/tymEBz7/ZpzcQ+H3lUI55ICKOY5/RSEdhbUd0uZmyQSSjJENp
         p9AlfhMf1X2c43ie7IZdak2e0dG7BlTYel2AgPl1UxU7bNhZ/Ca2BVxB5eEeI7Dr++Gr
         uLEy7JIZkLDOMrPStJg5QZ55l72AdQ67RchyfRVx3Rgo52a9ZGWjqvEgSHOFU5Q49jED
         L4Ow==
X-Gm-Message-State: AJIora8My3bh1RFKJBjcouFJiGRDY0Md01imtiMIJlSAASGZFuEDB4SZ
        JLCragw+BVNTEzlDt83q5QeIzHnSTvLJrWUF15KEPhF8Ai0MtA==
X-Google-Smtp-Source: AGRyM1sQXRfigyKAuelhDXMbGkqWFtkCmYoj5dAwRd8ziMquql5BHqHo/TFXo8YxnVXNKf8I1chgJXedUPi/ksvtqDk=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr3282416ywf.486.1657707315877; Wed, 13
 Jul 2022 03:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220713070517.172852-1-tmaimon77@gmail.com> <20220713070517.172852-3-tmaimon77@gmail.com>
In-Reply-To: <20220713070517.172852-3-tmaimon77@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 12:14:39 +0200
Message-ID: <CAHp75Vcx_G-b2GHLmNcs1AUOzchOQHbvKhq=2FZJyLdAPWunVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: npcm: Add NPCM8XX support
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        zhengbin13@huawei.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 9:07 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Adding ADC NPCM8XX support to NPCM ADC driver.
> ADC NPCM8XX uses a different resolution and voltage reference.
>
> As part of adding NPCM8XX support:
> - Add NPCM8XX specific compatible string.
> - Add data to handle architecture-specific ADC parameters.

...

> +       struct npcm_adc_info *data;

Can it be const?

...

> +       info->data = (struct npcm_adc_info *)device_get_match_data(dev);

...and hence no dropping qualifier is needed here, i.e. remove the casting.

-- 
With Best Regards,
Andy Shevchenko

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34D353FCDC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiFGLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiFGLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F4D240AD;
        Tue,  7 Jun 2022 03:57:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b8so5781550edj.11;
        Tue, 07 Jun 2022 03:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=yPufLHAHmFZwiernSymaEB3w3KO3bi6vBnV8PeUhLxI=;
        b=hnKKSGjrNlED/ZlKz+Mk3ptadzuBrA4J1vL8VD7NRqCFW31W644HRaVQWmcraWSz71
         5dMMJhQ+BcrWbNn2bCO8fTqN5+WThdkCsK5+8qkojv9mzGUNfRJSpSKT+5aUzYU7AriE
         N7h2CR0qwrfJOvOIgBnFh1Ojle66VSa4bdCOAgWpyASOVWzfksdaV8BbDK99daFoltnx
         9sKL5RHXz4+K+NTOK/9S5RP0flCJurYELlgQNxb44NTX2PeREFNp8IFqImXVcc7UKaUX
         41e5IN3X4u4zJ6l/4WTvjR7NZhLpY5SRHCdxpyg9Mzyz377bI/qPH89bq5szta5I48YR
         Z6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=yPufLHAHmFZwiernSymaEB3w3KO3bi6vBnV8PeUhLxI=;
        b=Gm/qfIlm1hviu7MYzhjE+rrnBeh601A0YerY2pCujipZ0abE1y1Swy3TE0vNNOgFCQ
         AaSZRx4qn1ijiwSXHv2BhS40OsoylEaWAuG5PPoXUKhNTdG3tdnGjHA0jPqupFD/VH5C
         K0mkxeaNlzHdM1b3P46c4NUjGlC6vHVC4CYpoLQ2qFcSCXBswNVZkPG9mE/U+105kbSp
         19VGjvSqpamoDZsIpwIOROfA+608iF5RgLX3+SECq6SAS5hMnhGDpFN2F5M9f8RhSuIA
         BFN4h5+WAWu7ePzIJwnzrUHYXK+tLwgUVa596lJGqBVZJ0e1RPfGDit8GjIUky0hgmml
         wsxw==
X-Gm-Message-State: AOAM532SuHrQTDBoIDzvmtT+yTPoesAb4fqNRiotBw41rHuejdG5pH+C
        KSlCWgxwE/y0AwAoUjHZAjs=
X-Google-Smtp-Source: ABdhPJyQ0oBf+aAihrAexYG8itdUihorYdbcNhw5dal9/wGkAvJYiJHkpOylC6RmzGwUA7Fxg7qaow==
X-Received: by 2002:a05:6402:23a3:b0:42e:251a:c963 with SMTP id j35-20020a05640223a300b0042e251ac963mr27606354eda.173.1654599464256;
        Tue, 07 Jun 2022 03:57:44 -0700 (PDT)
Received: from localhost (92.40.203.141.threembb.co.uk. [92.40.203.141])
        by smtp.gmail.com with ESMTPSA id gj12-20020a170906e10c00b006fed8dfcf78sm7396457ejb.225.2022.06.07.03.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:57:43 -0700 (PDT)
References: <20220603135714.12007-1-aidanmacdonald.0x0@gmail.com>
 <20220603135714.12007-9-aidanmacdonald.0x0@gmail.com>
 <20220603174744.642157d8@jic23-huawei>
 <e9ABtmBNzztlyRcJD5f36OmAYZW4i7KH@localhost>
 <20220604152711.22268711@jic23-huawei>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lee.jones@linaro.org, sre@kernel.org,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        lgirdwood@gmail.com, rafael@kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] iio: adc: axp20x_adc: Add support for AXP192
Date:   Tue, 07 Jun 2022 11:49:58 +0100
In-reply-to: <20220604152711.22268711@jic23-huawei>
Message-ID: <9Ju6ijQ68x8e8Es1zhzsVMZHprvKy16b@localhost>
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


Jonathan Cameron <jic23@kernel.org> writes:

> On Sat, 04 Jun 2022 12:47:38 +0100
> Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
>> Jonathan Cameron <jic23@kernel.org> writes:
>> 
>> > On Fri,  3 Jun 2022 14:57:12 +0100
>> > Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>> >  
>> >> The AXP192 is identical to the AXP20x, except for the addition of
>> >> two more GPIO ADC channels.
>> >> 
>> >> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>  
>> > Hi Aidan,
>> >
>> > A few minor questions and comments inline.
>> >
>> > Thanks,
>> >
>> > Jonathan
>> >
>> > Unless I missed a previous patch adding labels to the other devices supported,
>> > this is the first driver to use these.  Why do they make sense here but not
>> > to add to existing supported devices?
>> >
>> > I don't particularly mind this addition, just looking for an explanation.
>> >  
>> 
>> That'd be because 1d4ef9b39ebecca8 ("iio: core: Add optional symbolic
>> label to a device channel") added read_label in 2020, while the AXP
>> driver was introduced in 2017. I could add read_label for the other
>> chips while I'm here, for consistency.
>
> Thanks, I don't really mind either way on adding support for additional parts.
>
>> 
>> One question I have is why read_label exists when the kernel already has
>> unique names for IIO channels. Why not just expose the datasheet_name to
>> userspace from the IIO core instead of making drivers do it?
>
> In general, datasheet_name refers to the name of the pin on a datasheet for this
> device, whereas label can refer to how it is used.
> There are dt bindings to allow a per channel label letting a driver (where it
> makes sense) provide them for each individual ADC channel.
> (e.g. the ad7768-1 driver does this).
>
> On other devices they come from entirely different sources such as the hardcoded
> choices in hid-sensor-custom-intel-hinge.
>
> I vaguely recall that we've talked in the past about exposing datasheet name directly
> but for many devices it's not that useful (the user doesn't care if a channel is
> aux channel 1 or 7, but rather what it is wired up to).
>
> At the moment this driver just exposes all channels rather than having
> per channel bindings, so we don't have the option to use labeling in the device
> tree to assign the names.   If it's particularly useful to you to have labels
> that are datasheet names that's fine.
>
> Jonathan

Thanks for the explanation, makes sense that "gpio0_v" is probably not
all that useful. I was thinking mainly of channels like battery charge
current where the channel usage is fixed by hardware. The labels aren't
terribly useful to me so I'll just leave them out, I'd rather not bother
with adding dt labels.

Regards,
Aidan

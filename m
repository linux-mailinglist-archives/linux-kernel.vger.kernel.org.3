Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB125A1A02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiHYUGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiHYUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:06:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B23CB99F3;
        Thu, 25 Aug 2022 13:06:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id l6so1634985qvu.2;
        Thu, 25 Aug 2022 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8iLLYSuwBsbFWNazD+YcxhnwcQwqu+V8M6v90VJ9A5Q=;
        b=fO7t9suauyj8lDl/f4fu7cDnrnaQrxisyd/vrE400f3nJhsLD3qJuBdvXxnOZ6VJQG
         VTX5n4SJAG1RIy5Elir11IzoHnI1iCDKMFTbddPumRfT8Y+fho7P3af5h+CRPpMCvCEe
         VfT/s+SLdgt8XrIY1Qp4AEb/pZOm7/Bd+9TwzGS/tn4kKBwOaG0ZBfA2XdJflgHWZssQ
         NGfXNTX6hIGwSOW7tJA7+gdyvq8rz5Q11ZkNcr81m9Gsg71e1LEgjuKN6cH4F1E6rDfZ
         OCnAZ1KKhPd3qqLfktbtfogoyC9mTDBRTsJ5GcKgwbSRsKMO2CdQns9laiLIF7arAoFW
         Vzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8iLLYSuwBsbFWNazD+YcxhnwcQwqu+V8M6v90VJ9A5Q=;
        b=gDTkRiaiTOyhZTAaOO0MUXw55A6c+URvEKSL0bzIETiQUkVLOoTVebqmRR4PTPE9jh
         wykvxb6QjQqfIs6wJDcP7uRbtmacMT157NcnwTpEppZw56WZvnhFYRbSoTUQjwWuEyyf
         8MUNJeih0Xpch2hEeALlUY4kozYu1+As4fwNTEZ/W1MoXuYkjpAlIRvQiaPXU8nqsqkX
         bpKYxYKGRxO4KbNj8IHZ1WWjeKOhu6M0YQLH0WJxjuMzsQ0umFUyCjmf9gsfGU+ZVSzr
         W8OgoP/yoAud8Jb0wYS7bL21HoDSHPRStR50K+2eYLg4gqhpcOwiTjbxy+IzZGaw33+J
         Ey6g==
X-Gm-Message-State: ACgBeo317IewB8RRIONsrFibpTZT0cK20wikx5JKffmnJFEwNeBeyKnz
        pC2BVFa4Edos28gyz5MciL80vFxusbYfRj7Ydu7r63j1UlU=
X-Google-Smtp-Source: AA6agR4zvx9c6kvAtJ92VrRswCTUivG0i7b+sC4LBKbEuKiKCI1yAqPApWPlKMCZxtWX3c540hEHvGEtS69OwnH0k+0=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr5088744qvd.48.1661457997423; Thu, 25 Aug
 2022 13:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220824104002.2749075-1-vincent.whitchurch@axis.com> <20220824104002.2749075-3-vincent.whitchurch@axis.com>
In-Reply-To: <20220824104002.2749075-3-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 23:06:01 +0300
Message-ID: <CAHp75Vda3bbsRw+mftXjrH445UqSkxcB7q9kXUc+-ODUE+VQ9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: mcp320x: add triggered buffer support
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>, axel.jonsson@axis.com,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Aug 24, 2022 at 1:46 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> From: Axel Jonsson <axel.jonsson@axis.com>
>
> Add support for triggered buffers.  Just read the channels in a loop to
> keep things simple.

...

>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
> +#include <linux/interrupt.h>

Ordering?

But honestly, I prefer the linux/iio/* to be split in a separate group...

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
>  #include <linux/regulator/consumer.h>
>

...and be put here.

...

> +       device_index = spi_get_device_id(adc->spi)->driver_data;

Hmm... Wondering if this can be derived from channel number or alike.

-- 
With Best Regards,
Andy Shevchenko

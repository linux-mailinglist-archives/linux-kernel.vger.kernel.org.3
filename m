Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928035A1A35
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiHYUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiHYUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:23:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E1C04C5;
        Thu, 25 Aug 2022 13:23:41 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id h27so16099112qkk.9;
        Thu, 25 Aug 2022 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i7uig6GCW5G9OShhUBzKaHOCH3kWh8nqS6+A+Fz4ITg=;
        b=DJ7FjzNsyEs25UOe2Q6dHtgNhM+184PUi9EbLwHuxuMOaLr9zwf1ucWuonZP/J+BwF
         sVTqyPH2NJoUbSpZZRjYyCVY+tZHGnWyiOXwjVhRYMqYEQfIFw4ckcSX/+mCjJuDEoGt
         5peE4JVMEjxXlGAxPIA/BwfJQsCnVuh5ouvy4q9po+HRvKW+Bo/tdzR/skgWMqh7Wu7V
         BbrrufeFw3gJWVrYyRD9QNglm/3OIWrGY3+/1nIJTF+HS1KtnclNoxyn33cS+R6Qjl0a
         rLFtEkU6G/a7I07VcoxNFnYwhOmq7mF5UHrZHb/t0n83Ry67fPE3Y/4xSlkerqwTMJD2
         0fXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i7uig6GCW5G9OShhUBzKaHOCH3kWh8nqS6+A+Fz4ITg=;
        b=0jVV4QKN5hHgH6uC82+l9sOnxgbiy7bm5pkD/ixuLxaf0hQncTrcPWu9V2YxTydcmH
         y3SinpKLL980vqb7Mbw63LwT8RWZmiUk4NLkPb1XCnypVjuVsMUwTB5ufyheJJ85wxqU
         lCVuXNdx502OvGzxw/UeIfvZidX9Hq/snm9WJopOzCNlyAD2H+NhrVmfjj3ybRdKtPfB
         jieVjr16ofZyw3n+0weOtwVYO9YSPgwibbO/BZBXtxGoDTAVIJM0cdPtlUseJBOcd9cD
         Ul6ROffHVuH0fUYlsrfjCkxlMvmPYSUS3tDjFwidKC2akITbrHNXL3TCEBonBudA8pgk
         Dazg==
X-Gm-Message-State: ACgBeo0/J+AyH71rCQBBgZfk26xkuW4tJLnccbsAGBFfNUQl/Ld+803t
        4ROqrXmJOHNjw7I+PtypQW/gMRPpDOsvcnCsVr0=
X-Google-Smtp-Source: AA6agR6AnxxjhypK6PyzKAtAaLJs6U1kJZj+wkJriceugjIVJAJXajNYh1S7iFmnfRj0wSBzv9Sz94UxEJciEp/FqGk=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr4371427qko.734.1661459020971; Thu, 25
 Aug 2022 13:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220825194604.15645-1-jagathjog1996@gmail.com> <20220825194604.15645-3-jagathjog1996@gmail.com>
In-Reply-To: <20220825194604.15645-3-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 25 Aug 2022 23:23:05 +0300
Message-ID: <CAHp75Vc5048aQL5cLy-OfBfnH6tz_7z24sFX2H1oGRz+JUyq9Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] iio: accel: bma400: Add support for single and
 double tap events
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
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

On Thu, Aug 25, 2022 at 10:46 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Add support for single and double tap events based on the tap threshold
> value, minimum quiet time before and after the tap and minimum time
> between the taps in the double tap. The INT1 pin is used to interrupt
> and the event is pushed to userspace.

...

> +static int tap_reset_timeout[] = {
> +       300000,
> +       400000,
> +       500000,
> +       600000

+ Comma and so on for the rest of the similar cases.

> +};

...

> +static int usec_to_tapreg_raw(int usec, const int *time_list)
> +{
> +       int index;
> +
> +       for (index = 0; index < 4; index++) {

Magic. Shouldn't be defined?

Also you may add it to each data structure in question.

> +               if (usec == time_list[index])
> +                       return index;
> +       }
> +       return -EINVAL;
> +}

...

> +       int ret;
> +       unsigned int mask, field_value;

Reversed xmas tree order?

...

> +       /*
> +        * Tap interrupts are operating with the data rate of 200Hz.

a data

> +        * See section 4.7 "Tap sensing interrupt" in datasheet v1.2.
> +        */

-- 
With Best Regards,
Andy Shevchenko

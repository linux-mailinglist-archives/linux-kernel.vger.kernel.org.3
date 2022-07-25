Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42B580653
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiGYVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiGYVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:20:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1637323BFF;
        Mon, 25 Jul 2022 14:20:05 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ss3so22727728ejc.11;
        Mon, 25 Jul 2022 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDE3NwBwTuDpjLuPQ61t5UcNlhjZmXhZy7wVD92KeX8=;
        b=cu4WEAq7h2e1+ldcFCGnBTJ+mfSuTH2VJNmhtt3PQIkX72AflLf5U4kNMqpw1v4qPT
         cqtZyd9hCZfbPwm95nB2S4Q8FzMfNof5i8u7LO3CygpwhXGm7rqdopYDzTb6ANsodHNz
         GuJQ/zvYEajd/p4Cup9t9kpXE37+iAl2BIA5HnrOdwpHulERUxz5/rF2H446vmnKGMwL
         lX/gjDcUlVK7WJ7a7qH2YH4c1npXvnTXAALx6nOwowSMH/Jp5GVbBx1mWwAlppt5sgAP
         Sr3N3stGUBkNrRgFM1hN0TysM5LJiCu0h60o2kWfBjnrb3rhkSurkgt08BiQuY4082bP
         R9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDE3NwBwTuDpjLuPQ61t5UcNlhjZmXhZy7wVD92KeX8=;
        b=tqfDQ3/9Av6qP/BLWfXO4JpuwTph/y8TGG5x1rBW1EaQWZ232F87uvTgUeLO8Q9kGU
         hKxp9VvdoKqduzGuzcSbe/LE6A8OCMqUhAkBFvsNjoERMoRfSdGaMdWu3e7LI+U7TG8c
         RfsU5AaytqH1Uard1g4Sqb+7FzHXmR3hd8xxA72hIL6HZdP083o+3RIWt6RmJoJpVjYk
         ThJ5jt/HoLGiN1SAJIJVRaqjl9tqFGuNVe9iVsuH9glgKMuqKmRTCX/sFlc0GboDJTjV
         CDOYqByR1iEFCFgIdyubzbIn693rBsJNxbwBvwr6T4OWDRZ8CdRLC3OJIRqFYBul4bLp
         v5NA==
X-Gm-Message-State: AJIora/MBY8NIFceqZr1x5ulDMC9AKlPpXjsQQInmmLq74aEpW/e75Mv
        getbg5/PZGbhsxus92dGsf/VZeirWB3z0+6uVN4=
X-Google-Smtp-Source: AGRyM1vPOOCrOy3oEP6mcBL2JOZtLqFofph1a2RNAjbdxo04+kZfaOc5cXbNNwTcKf5CrgJxfcvCvV/K7wE6ay3k1uU=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr11289338ejc.161.1658784003634; Mon, 25
 Jul 2022 14:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658597501.git.ang.iglesiasg@gmail.com> <0a99be89263c5e747d541360feede21b0f77e0a5.1658597501.git.ang.iglesiasg@gmail.com>
In-Reply-To: <0a99be89263c5e747d541360feede21b0f77e0a5.1658597501.git.ang.iglesiasg@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:19:27 +0200
Message-ID: <CAHp75Vc+VzfTMJBv-eyYTENKuMGw=m4mpDvCXmKmVwcnnnz5Ag@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] iio: pressure: bmp280: Add more tunable config
 parameters for BMP380
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 7:40 PM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
>
> Allows sampling frequency and IIR filter coefficients configuration
> using sysfs ABI.
>
> The IIR filter coefficient is configurable using the sysfs attribute
> "filter_low_pass_3db_frequency".
>
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com> # uninit var

Bugs in new features can't have Reported-by tag.

If you wish to give credit, use a cover letter / changelog.

...

> +               /*
> +                * Configuration errors are detected on the fly during a measurement

The configurations

> +                * cycle. If the sampling frequency is too low, it's faster to reset
> +                * measurement loop than wait until next measurement is due.

the measurement
the next

> +                * Resets sensor measurement loop toggling between sleep and normal
> +                * operating modes.
> +                */

-- 
With Best Regards,
Andy Shevchenko

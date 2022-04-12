Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4054FDC52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359604AbiDLKTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359459AbiDLJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8671FCFC;
        Tue, 12 Apr 2022 02:03:46 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l7so30543765ejn.2;
        Tue, 12 Apr 2022 02:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70TMPjs2G4Sxbi1aiGiAsrrAufNW6Ksdkcybh7WxoB8=;
        b=GEzmKtdFUICh2CcidOrecNvoQEhsKuI67kkEbuc2hczZVN+u1r9PUNfPWi92xi92F+
         xSJvwV7bQQZCXInvJ2F0nu6byEHBsLzHS69h85zYV34uRkWAk7NTodkr36aBYKXnA0aq
         VI2Sel8DvstfsyD+ocJToMyCcp4jCIBtHHouJRHQmjQgMmigUEgZtPiJglCKIL2dYqRI
         ruo2jsuVfnUG/ocsSOY+crhkjsOJpAxwT2xbVekJ6iV6ZSrljy3vFwvDagpwiGpOpLiw
         k9dI4sZ97e1nJrjFKwMTu9OMVeMMIhQzZZvSkSmOY7r8lcx6o8ULmVrsIW1Bp+wLpJ9a
         9cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70TMPjs2G4Sxbi1aiGiAsrrAufNW6Ksdkcybh7WxoB8=;
        b=zPV1NN0SiWNuzjemTzFSrrmxI85Zcy6q9fiNUKxwJlmhXbumEHgRPitov1rFxY8U55
         9ewuKugrqOymdmzmvtv7M1zxVDcHNhJxDweS0x/F4qpMi1ZrDlg/5eWToC9BZzQnQ3xR
         jskIwKEtpA6EX0QIwvG74Z9x++Dk9mmTA96Gg0sfjxvtP1mH93c2eIZKGGBbQgTwZuLx
         uU42m+F9quje4GpgWtSr5gVic/FAc++LQWTeKCVSLO+XQ0DLaSI4thtCgPMP3otGEwti
         dFx2CCI4Gl9mNLYVp1mzo1szGc4x+NNDnX1k/6heKLLtIIPf3Gep+X5l+g6lLZrgGmsV
         jNLw==
X-Gm-Message-State: AOAM533rZpxE0BhmsyTCW/YxTbnjuGKqtp5qneHC/Vc/6eLU7Iye9ngH
        Wyldp11+oyFGSOqFsXNcMl9h2CJPw8WzW9LN0Rs=
X-Google-Smtp-Source: ABdhPJzLoY7VZJrAuBDBL4jnbvvPHu5VHjiARPtktQLW6/PHvVE7xQZqjuQStZkyjWLmt6MSRGiK/7kVLjioOAqxfOw=
X-Received: by 2002:a17:907:8a05:b0:6e8:441c:358d with SMTP id
 sc5-20020a1709078a0500b006e8441c358dmr20635472ejc.77.1649754224895; Tue, 12
 Apr 2022 02:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220411203133.19929-1-jagathjog1996@gmail.com> <20220411203133.19929-2-jagathjog1996@gmail.com>
In-Reply-To: <20220411203133.19929-2-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 11:59:32 +0300
Message-ID: <CAHp75Vf8X4b2jeNKFcOLP+0XGcFbk0aS-_iN5vqAQOBf+e1VqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] iio: accel: bma400: Fix the scale min and max
 macro values
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
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

On Mon, Apr 11, 2022 at 11:31 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Changing the scale macro values to match the bma400 sensitivity
> for 1 LSB of all the available ranges.

Shouldn't this carry a Fixes tag?

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index c4c8d74155c2..5d6a1976503f 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -83,8 +83,27 @@
>  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
>  #define BMA400_ACC_ODR_MIN_HZ       12
>
> -#define BMA400_SCALE_MIN            38357
> -#define BMA400_SCALE_MAX            306864
> +/*
> + * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> + * converting to micro values for +-2g range.
> + *
> + * For +-2g - 1 LSB = 0.976562 milli g = 0.009576 m/s^2
> + * For +-4g - 1 LSB = 1.953125 milli g = 0.019153 m/s^2
> + * For +-16g - 1 LSB = 7.8125 milli g = 0.076614 m/s^2
> + *
> + * The raw value which is used to select the different ranges is determined
> + * by the first bit set position from the scale value, so BMA400_SCALE_MIN
> + * should be odd.
> + *
> + * Scale values for +-2g, +-4g, +-8g and +-16g is populated into bma400_scales

are populated

> + * array by left shifting BMA400_SCALE_MIN.
> + * eg:

e.g.:

> + * To select +-2g = 9577 << 0 = raw value to write is 0.
> + * To select +-8g = 9577 << 2 = raw value to write is 2.
> + * To select +-16g = 9577 << 3 = raw value to write is 3.
> + */
> +#define BMA400_SCALE_MIN            9577
> +#define BMA400_SCALE_MAX            76617
>
>  #define BMA400_NUM_REGULATORS       2
>  #define BMA400_VDD_REGULATOR        0


-- 
With Best Regards,
Andy Shevchenko

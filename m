Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FF34E226B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbiCUIsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbiCUIr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:47:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC37A5E98;
        Mon, 21 Mar 2022 01:46:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b24so16904183edu.10;
        Mon, 21 Mar 2022 01:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIXaXRe6fXniSeUMQJNT+Y5fVee3c9bLU6mP2FbFMEI=;
        b=HPEi+s6WHuEIucuNESN+56exbAgTPW/IyPFiMDR2Nw8O9wqz9unVp50uQEeTWtZuhw
         s0C8zfIUrdD+qRqYGEB/VT/kINCHD4Gsxnq70tFlohTshaid8zE3/0JI28LcE+FhwJai
         Tjt+7PP7Rk1OBL5T/4J4Wk9WJN5X5mNJmMAROYxbm6Ryl5uog5EaiHgWi2CU/clspExU
         NPeLJZ3lrPI7mpdmyDxTDW3vl2NBu6AgKbDDRM1f2GUOQsHt2hwd7CKmyx1M6ysI1Vhd
         4AVhxqAEnlIDKMP8A+RSO7iNDm95sM9AIpdBSTAeolrhsl6uH0fUQyv+DvMBhJEqBefY
         CzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIXaXRe6fXniSeUMQJNT+Y5fVee3c9bLU6mP2FbFMEI=;
        b=5D29EnHZS+K/SRcxR+o0Znlaj/aDhsRHDH3TYV9wQioB/rlkjNMHC5gUCnODmLvLiE
         0OIIUwHJPMjoG1CJdgUAyYCYF03W8GJ91q/2gEgUxTPf/HJuctGT9SBUKEIMLafyUYZo
         x2cLS5icD1Swt42FM92exAkrUeAeMY202YTLNIyvS4FjZBhhzftKQHbDST97OoU1SodI
         PUW4h5twjltFiQz8BWcD45nb4/iz7pnUKh+Q+xXro+jG6IdTeM4URlBGJ1iyRFlLCKyY
         d3BrvuR4xtAT2M3j5S7jhYk+oXzCHRUoKzIw7lMYRzGEWWE7PdKLJQgfwklkNmns26wA
         Wrkw==
X-Gm-Message-State: AOAM531Dh6WcVGxvQCwWDpB7Is2peR8kIGseE9mpXBUR8khbbPX8/VD4
        hlEjY/FaNY7XCjfyeWzpL8EyCaGOSRQbTWyg8Yc=
X-Google-Smtp-Source: ABdhPJzGrrpF8+dvvOula2t4S/9UqiIemKjG4DATGdQN7z4LgmbXUHAt4N/jlvzNXegmK/U6INqdrAcQX5VkfvYc4cQ=
X-Received: by 2002:aa7:d1ce:0:b0:419:19ed:725a with SMTP id
 g14-20020aa7d1ce000000b0041919ed725amr12734450edp.270.1647852393881; Mon, 21
 Mar 2022 01:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com> <20220319181023.8090-6-jagathjog1996@gmail.com>
In-Reply-To: <20220319181023.8090-6-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:45:23 +0200
Message-ID: <CAHp75VeKDpiLo9eJ+578XSqsoRx3YyKuJ4AJJJ3jTQLaENo=Lw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] iio: accel: bma400: Add step change event
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

On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Added support for event when there is a detection of single step
> or double step change. INT1 pin is used to interrupt and event
> is pushed to userspace.

...

>  #include <linux/iio/trigger.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/events.h>

Keep this block ordered,

...

> +       switch (chan->type) {
> +       case IIO_STEPS:
> +               switch (type) {
> +               case IIO_EV_TYPE_CHANGE:
> +                       return data->steps_enabled;
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }

> +       return 0;

Dead code.

...

> +       case IIO_STEPS:
> +               switch (type) {
> +               case IIO_EV_TYPE_CHANGE:
> +                       mutex_lock(&data->mutex);
> +                       ret = regmap_update_bits(data->regmap,
> +                                                BMA400_INT12_MAP_REG,
> +                                                BMA400_STEP_INT_MSK,
> +                                                FIELD_PREP(BMA400_STEP_INT_MSK,
> +                                                           state));
> +                       mutex_unlock(&data->mutex);
> +                       if (ret)
> +                               return ret;
> +                       data->steps_enabled = state;
> +                       return 0;
> +               default:
> +                       return -EINVAL;
> +               }
> +       default:
> +               return -EINVAL;
> +       }

> +       return 0;

Ditto.

-- 
With Best Regards,
Andy Shevchenko

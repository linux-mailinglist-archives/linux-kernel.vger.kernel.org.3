Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762444E2256
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345353AbiCUImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244556AbiCUIl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:41:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC60A0BD9;
        Mon, 21 Mar 2022 01:40:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qx21so28228719ejb.13;
        Mon, 21 Mar 2022 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0T1DFi3YvaPuxckua7QaVBMphJ9LBbQAkY4vD+4O8Hw=;
        b=XF6Mx1WGGfI49hR3SkziNiVObmVgNdDc6gvs/6Mk6RaZeRNCIJI0k/It0NC88nTx7K
         T9YfkicpaEim0L6LwOxlNArBqVAp72YuaThUQXnzCiQcnRBEbfNtAyc4RTORJ9dZhNr5
         DTHB4iMzYJt4P6O/5k+pdSlKlKGz9iqx0alZifrF7WJmuO5RHI1sFZvqp+GDrKVdN1CT
         u6pM/ePd15wl/hZ3tf6kA4OrBqrE6RZikjaFvsMZdJ85T9/Qv/Yz4KO7NkbDCaRzQXSs
         2RG1IxspOBuZIxHa+p5kCGGXGYxj257TfN96kB97PTke9N7ra0bWCkzQ2ahsJ9RVaVJ4
         KQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0T1DFi3YvaPuxckua7QaVBMphJ9LBbQAkY4vD+4O8Hw=;
        b=nSCgY08yKaaK6X5ZeWPg8tvT/vBSoZEZbIm+W8wLdKlF7OQyjBP2INQwN5NJZQBYKx
         E1Sq03es2ztFFGJUS1ce2gVxl86WjuoXzHtc4ivh5VTLP4sHytSo8neIchmHCBV83DVr
         LAzkZrS0h5JdKXG07r+PjTy8IvhsBxYcmKUs6c1CnX/Hzm6UOU9xGoaFtaBYb5vOKpgx
         Y7cM6La6rFMhG1Y6EMeehet69mG3QoXy3HTuU8HIb6Z6eHG3UeJ6s8xiOaKrUd4EwSVx
         w7rL/InREpI9ywFnHxLIMqozfx5ZA+mBxTmLiXqE7MrZUsqOG5wjU9NTqfnrhxjCKuu/
         2Q7w==
X-Gm-Message-State: AOAM530Kvk9sv5+Uxt+Gls/UglORNlLUYaLDqXcG86hrqatpZvxGRz1W
        lB+O7wyU8aUZ0NwVeY8CSNfCSp0dNzzpQvn0rqL0/JxdALc=
X-Google-Smtp-Source: ABdhPJyWXhAc5G784KNKjg20aw8U2AbVwMJniU0wYbqSmADml3xwxLADPRQj1KukNb2BhOgwpGyGLBB8NgIIs6z7nyY=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr19815300ejc.132.1647852032784; Mon, 21
 Mar 2022 01:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220319181023.8090-1-jagathjog1996@gmail.com> <20220319181023.8090-4-jagathjog1996@gmail.com>
In-Reply-To: <20220319181023.8090-4-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 21 Mar 2022 10:39:22 +0200
Message-ID: <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
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
> Added trigger buffer support to read continuous acceleration
> data from device with data ready interrupt which is mapped
> to INT1 pin.

...

>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>

It would be nice to keep the above in order.

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>

These ones, possibly including iio headers from the above piece, are
good to be grouped together here with a blank line in between the
above part and iio/*.

...

> +static const unsigned long bma400_avail_scan_masks[] = {
> +       GENMASK(3, 0),

> +       0,

No need to have a comma in terminator entry.

> +};

...

> +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> +                              &data->buffer.buff, 3 * sizeof(__be16));

sizeof(buff)

...

> +out:

A useless label. Moreover this raises a question: why is it okay to
always mark IRQ as handled?

> +       return IRQ_HANDLED;

...

> +                       dev_err(dev, "iio trigger register failed\n");
> +                       return ret;

return dev_err_probe();

...

> +                       dev_err(dev, "request irq %d failed\n", irq);
> +                       return ret;

Ditto.

...

> +               dev_err(dev, "iio triggered buffer setup failed\n");
> +               return ret;

Ditto.

-- 
With Best Regards,
Andy Shevchenko

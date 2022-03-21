Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5424E3363
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiCUWvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiCUWuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:50:50 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4B38F732;
        Mon, 21 Mar 2022 15:30:39 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-de48295467so209439fac.2;
        Mon, 21 Mar 2022 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fd0ioVJnCUxmBqE5v/1CktP1XfO1ct0lyiZbE7j35V8=;
        b=JPbAJMKIYbgC77xWESrjn/RacBD6J3iRT8AHohuSQ5gNjCihvenph23+NrpNOEwu23
         fPCOh4WFVaCtXprRY1+RoyESnxJHObyb3e7zwlzQlYoUxWD8FHJi6I8iZ2o/tt8seIDU
         4nIQwRqYQtohiDBBUOWlgDQWgjE4V4hJEdtowkSEVAdKm95uEwcq0N5uN1xcj6py3ZPz
         BLhvCVi/hfkUOm5lwjHvODcUlvous1XOim6kczc+LPjHJO7V0AKP5N1a6xbKQyd2csvb
         48cV81fo25s6sCrryb8VX35V8a9ku+yauFAL9EFR7buUWgj7OdF+/03okeAHnJCCM5C2
         Nxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fd0ioVJnCUxmBqE5v/1CktP1XfO1ct0lyiZbE7j35V8=;
        b=ALmCKxooUO1TR3I8C6PU53UPFOFOJLhl6GDA9bIZ4AZFJEQyKhQjDHY8PlaLwYlojG
         Um0hm6453mxYP6TvXd2AGkzSIC1GDgihI6P3ZJx1K1HNO65IgwZ/C+3QqGiiAH0jcHjv
         3Tk2eonbWn+zXcfOslZAo8Ga6DBAa+VVpGAbtoljCV4XpGgFU5sBIbm1+HqEBzpQMLnM
         sMyG0RzHBbl/dmUYQvomQTMsXyjlkKQdxnObsd5rpjEbhkVBp8KImK3UAEJZz8Dd9gNQ
         dK/sC8KnH6fVWiAREcY+VxV58/MCK5a3fd4xv3S+ceplyy6/ZIgFRVi0SdjPWmQqXZEN
         xVWg==
X-Gm-Message-State: AOAM533c2VgKHBXdGqVdEPkDhHn1V1xKilU7NkgP9stlNVMjZUlN3dnw
        x8NVQTgIHFT5uqpBt8wW3g0TM7I4Nwyr5dG4
X-Google-Smtp-Source: ABdhPJx9PqwCNkYnhrgCr9dl47xOE1L03ITPFHLHegqf7Cg046EHXDpNqRAOoGssllJToGvQO1sgow==
X-Received: by 2002:a17:90a:5ae2:b0:1c6:7168:1164 with SMTP id n89-20020a17090a5ae200b001c671681164mr1354065pji.119.1647901282882;
        Mon, 21 Mar 2022 15:21:22 -0700 (PDT)
Received: from jagath-PC ([115.99.184.169])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00125600b004fa3aec7f89sm16017098pfi.75.2022.03.21.15.21.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Mar 2022 15:21:22 -0700 (PDT)
Date:   Tue, 22 Mar 2022 03:51:18 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220321222117.GD10058@jagath-PC>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-4-jagathjog1996@gmail.com>
 <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VdB5q+Y2R46OO-kCKCkPY58YzyLNjN3PjJiQhTOgV4n2w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Mon, Mar 21, 2022 at 10:39:22AM +0200, Andy Shevchenko wrote:
> On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added trigger buffer support to read continuous acceleration
> > data from device with data ready interrupt which is mapped
> > to INT1 pin.
> 
> ...
> 
> >  #include <linux/mutex.h>
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> 
> It would be nice to keep the above in order.
> 
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> 
> These ones, possibly including iio headers from the above piece, are
> good to be grouped together here with a blank line in between the
> above part and iio/*.
> 
> ...
> 
> > +static const unsigned long bma400_avail_scan_masks[] = {
> > +       GENMASK(3, 0),
> 
> > +       0,
> 
> No need to have a comma in terminator entry.
> 
> > +};
> 
> ...
> 
> > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > +                              &data->buffer.buff, 3 * sizeof(__be16));
> 
> sizeof(buff)
> 
> ...
> 
> > +out:

Just to skip the below "if()" if error occurs in previous regmap read,
I used this label.
       if (status & BMA400_INT_DRDY_MSK)
             iio_trigger_poll_chained(data->trig);

I will remove the label in next patch
> 
> A useless label. Moreover this raises a question: why is it okay to
> always mark IRQ as handled?
> 
> > +       return IRQ_HANDLED;

Since I was not using top-half of the interrupt so I marked IRQ as handled
even for error case in the handler.

> 
> ...
> 
> > +                       dev_err(dev, "iio trigger register failed\n");
> > +                       return ret;
> 
> return dev_err_probe();
> 
> ...
> 
> > +                       dev_err(dev, "request irq %d failed\n", irq);
> > +                       return ret;
> 
> Ditto.
> 
> ...
> 
> > +               dev_err(dev, "iio triggered buffer setup failed\n");
> > +               return ret;
> 
> Ditto.

I will change this in the next patch version.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

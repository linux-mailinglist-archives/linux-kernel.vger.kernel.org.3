Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11A747FABB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 08:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbhL0HRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 02:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhL0HRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 02:17:46 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE4C06173E
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:17:45 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 8so13012266pfo.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Dec 2021 23:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=51TQZrbAr29VM3nF2YtE6nyRB4aXNbjVM1xbcF9OUAY=;
        b=KXtqnDHbSIOTlX11zxBJ+S8d0ZXbxFFxzwbc1V9XGt4mbqjRAZ0Jg1GMmAttvJFPRZ
         HpGP7GvCC/xw8NaXTXFUWLH7/KYDqp/5vEQmog9RmxlgBERGi3KYi4jVmqjOcN/4974+
         2d6+t7EZZSEOtFluMjQiT6DWRnP6leKlMUFFLEHSE2zIAY0C6MVe1WAOzAR5QH6yAwCA
         Gol4NiLk5EyWZMkv++2+xOKST8YpEgDHy1UvEwl9YUMwrVWKO5xIUyOjVtZoi6lLAKCd
         1FRQybVcH1qAD8r0zAKXfXoBIEMM2h4tyJoWcCo/jGbgUE4hiZPREVdoUYlNR7iM9dHM
         n78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=51TQZrbAr29VM3nF2YtE6nyRB4aXNbjVM1xbcF9OUAY=;
        b=BejhQKerB5tt8ZWVxIxB6LEEsm7c96MrYl43cnWlOfLqrfpa53hnhUWhf6Vd7eeY/k
         UgrSRBlrGi63GcJipN0kZIsqkyW3VmG4X1pSMND8wB4U/TFXKBvoCaRpSQV8zLNI4jn/
         IwJZCnjiE40qN4+dhXAvJ4aISiRuBuKCa17T96zNb9eFWYtZCXAqqOxMk2oJpX9r1e4T
         F532c8dyNzCsMtdYnzTJsDBqQ+IjSTgUDwTZOrSwIL4Uh3a/9zpG0m0G9A5Q6tFJ2DN2
         xd6kadIS3j5HiiF4clWdvLP83Khm5o8oONuYg1Rc6wtUHLQTOGH7oMp+fKdx19x4XUNh
         4afw==
X-Gm-Message-State: AOAM532XhRzHPFgMgAV+jlS/aNbHeoN32WAFHZevNxRqwETyNyX3GB7B
        AyUDWi394lAeXzd5CTQH3g6Ju9cQuBmpVIjnos52Rw==
X-Google-Smtp-Source: ABdhPJw+mm+m/51GzYmgxWwUmEoMGE/JTJH9EQCOqzc+3sxPyO3BXA3PS6zibJIL7x4OhYtXgI5tFt+0J/G2pzfoPhM=
X-Received: by 2002:a63:1e46:: with SMTP id p6mr14653288pgm.18.1640589465437;
 Sun, 26 Dec 2021 23:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20211222094558.2098791-1-jsd@semihalf.com> <20211222094558.2098791-2-jsd@semihalf.com>
 <YcSaqmlI7l4H1lsN@smile.fi.intel.com>
In-Reply-To: <YcSaqmlI7l4H1lsN@smile.fi.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Mon, 27 Dec 2021 08:17:34 +0100
Message-ID: <CAOtMz3NTLXYiFg6xYbpVU2rd=YWGCUhG2ekFqxHwFF0XFA6orQ@mail.gmail.com>
Subject: Re: [RFC 1/2] i2c: designware: Add missing locks
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 23 gru 2021 o 16:51 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Wed, Dec 22, 2021 at 10:45:57AM +0100, Jan Dabros wrote:
> > All accesses to controller's registers should be protected on
> > probe, disable and xfer paths. This is needed for i2c bus controllers
> > that are shared with but not controlled by kernel.
>
> ...
>
> > +     ret =3D i2c_dw_acquire_lock(dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       ret =3D regmap_read(dev->map, DW_IC_COMP_PARAM_1, &param);
> >       if (ret)
> >               return ret;
> > +     i2c_dw_release_lock(dev);
>
> Not sure this part is fully correct. Please, fix the leakage.

Correct, I will move release() right below regmap_read() call, before
checking return code.

>
> ...
>
> > +     ret =3D i2c_dw_acquire_lock(dev);
> > +     if (ret)
> > +             return;
> >
> >       /* Disable controller */
> >       __i2c_dw_disable(dev);
> > @@ -614,6 +624,8 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
> >       /* Disable all interrupts */
> >       regmap_write(dev->map, DW_IC_INTR_MASK, 0);
> >       regmap_read(dev->map, DW_IC_CLR_INTR, &dummy);
>
> > +     i2c_dw_release_lock(dev);
>
> Not enough context here, bu I believe there is the same issue(s).

Since we are ignoring values returned by regmap_write()/read() and
also __i2c_dw_disable() returns void I don't see a leakage here. Don't
have more function calls here.

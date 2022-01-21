Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CD04963B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379053AbiAURXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351585AbiAURXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:23:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FDC06173B;
        Fri, 21 Jan 2022 09:23:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id o12so1943780eju.13;
        Fri, 21 Jan 2022 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8NXAiWtMIfeUxiSKSX8KITUpdvgnK1eV2MyEqdhz4Tw=;
        b=Yn+aa26mkRWKYicHrBF9lv87j17KpEy8yL4Xezg1BnxKgY7jDRRv5fAYktUdU2YoIn
         S7y4rkc43EhraYHBpAHXj86eIwxiNIUNL9koznpqvpwhdqvKSvzRGfG1Fn5VuPPRioGs
         P33+rL5rTgiVdt8+gMnzUxWBEQBjR8IVNBlxMXJEBAXDapsZQGyiUJXNScsd0bv7mS4o
         6Cbyfo96WmRwj9is//o8+v4DkQkf3dDJqLdJ36yFJbG/6Z8K2zckz54LwFe2aYQqhc0W
         rPfNJ0ib54IN7tC2Jf8eiFuXckAeMkB9Nf8l7ogbH1dzZlA8NdU7D57WzJ1Cxuafoq3W
         HS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NXAiWtMIfeUxiSKSX8KITUpdvgnK1eV2MyEqdhz4Tw=;
        b=VMefmzxsn4xpwzS/YEY6xgeaQkSdEvKU6ltTkPTf6acHnce2X3z7gdPuDOoh3T5RZW
         5EEBOiw8GpsG9VPBkPV/RI1LpEkuXMk+amopxSHpdKxIw++gmemPXJ7bk8m784GIUI06
         wDQsHxzGMGBrgHhuGscZaeS4ypsZ59EjvYPUJ7EJHDHWtFyBLQnW85wFYmmJ8PysR4VG
         I7y7L5p7aLvC2wAr+2SLiHIQXd1KQ8QeVhb7Nkn0KXAUhQ5EgY9DPgbUcD9MZYEIUcz4
         bJcBgCBZ1W34OZaow9vHdIkVcCO3I/qWi8eaqVapupRkf3VX3KtgSMs0pOhdwS7TPzya
         QzHg==
X-Gm-Message-State: AOAM5332Qo0lRM8h67+xfEJdUxvlYWLlEQonhO31GoGTigOXFs3PN+im
        UEHiJqZVRfENQqHQVy+hoSuDk//Zj+rB/02l9nw=
X-Google-Smtp-Source: ABdhPJxiMuqJI6e97nmWPPdBUq6TS6UCdQgeJ/EHh7s4SfFiRe1tWU9lTjaKe6WX7nZESIBAH+Gz03gyJOr6dOvI2o4=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr4024576ejc.639.1642785814310;
 Fri, 21 Jan 2022 09:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
In-Reply-To: <20220118194857.26546-1-julianmarcusschroeder@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 21 Jan 2022 19:22:57 +0200
Message-ID: <CAHp75VdFGC5yXSmR_uNOv4=aEseMzWdJ=xNqqo1KKuGkajhb3g@mail.gmail.com>
Subject: Re: [PATCH] fix serdev bind/unbind
To:     julian schroeder <julianmarcusschroeder@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, bhanumaiya@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 8:55 AM julian schroeder
<julianmarcusschroeder@gmail.com> wrote:
>
> On some chromebooks, the serdev is used to communicate with

Chromebooks ?

> an embedded controller. When the controller is updated, the
> regular ttyS* is needed. Therefore unbind/bind needs to work
> to be able to switch between the two modes without having to
> reboot. In the case of ACPI enabled platforms, the underlying
> serial device is marked as enumerated but this is not cleared
> upon remove (unbind). In this state it can not be bound as
> serdev.

Seems legit (we do this for i2c and spi serial buses in ACPI case).
After addressing the following nit-pick
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

...

>  void serdev_device_remove(struct serdev_device *serdev)
>  {
>         struct serdev_controller *ctrl = serdev->ctrl;
> +       struct acpi_device *adev;

> +       adev = ACPI_COMPANION(&serdev->dev);
> +       if (adev)
> +               acpi_device_clear_enumerated(adev);

As I mentioned i2c and SPI cases, I think it would be nice to use same
pattern of this code, i.e.


  if (ACPI_COMPANION(&serdev->dev))
    acpi_device_clear_enumerated(ACPI_COMPANION(&serdev->dev));

drivers/i2c/i2c-core-base.c, line 1007
drivers/spi/spi.c, line 779

>         device_unregister(&serdev->dev);
>         ctrl->serdev = NULL;
>  }


-- 
With Best Regards,
Andy Shevchenko

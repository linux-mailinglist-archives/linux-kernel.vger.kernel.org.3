Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9D4820A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 23:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242259AbhL3W3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 17:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242253AbhL3W3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 17:29:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3832C061574;
        Thu, 30 Dec 2021 14:29:07 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so103020384edv.1;
        Thu, 30 Dec 2021 14:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqXfFLNZe3MOTkxHA6XZpTvA+blOj1sbzkN2OP2yLa4=;
        b=S6TWvNpu10nutY4a2KKlJZMh0dVrAIhjd4EK54By56V602c2Kg95O+vqw2w+hLGbRd
         9gkvZmq927SOl4r6XBcV6j1gNe1lp6amB5SMMhSZx4ORemzkQ6W+WPQml782Kc2medvH
         +aInmvXHyhuWr3PJMqinwFPfSSdqowhchDqksg+/1wW91pkRqlfgYpg2scLceKcjw8Ed
         CHIN5zj80lUuVc+uaUnyRuCbPy7PwHdqUDkD6uPGT+p0CyAOm1JItFQv5cj3wXMNR7G/
         O/41ecs1/626dH1cgg3Ksuzkhr2drt6dkDRHm6wMJnXEqY958pr0k8ofAXFeKN1ph2zN
         giJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqXfFLNZe3MOTkxHA6XZpTvA+blOj1sbzkN2OP2yLa4=;
        b=zK1yJ0ZkFhz6z2SdxSVunGzzeI7rtpwm1vB1yLDLpgunu0K2sDv7TlyFQ0HQZCv08x
         JvzIWSB0fiH+cae0L4UGxoh7KX6xdFe/KpvbbkXHxylI/fgmH6RNVUGiZmk2DD4jME5V
         Ctxf2rjsWdU+cH8CIcC4AZdqAjrA5nFnBZXvKub4y4QZxlWPER5RouhsyUrk4W2qeUeS
         eUTz++6HahfNr6ueX4v1i74Tu7g37l4cCcGy71rZCO7stMrFk8KAZQNLWdRZNCrw1Z5+
         wExr5e5SCAfVJg2xffl5dVqbhY9hexJNwqoAisUubsa8lm3B72HntIXly84TRNDnS9/5
         1RGw==
X-Gm-Message-State: AOAM531Fflwmzg7aUqg3hXJ6k8yLxaVPkZ83qxI2MPCXEX+ZVFMnthm0
        Ztb0ZQHAPlugqphhgd2pcrWl7F3HEXLv+kRWo6s=
X-Google-Smtp-Source: ABdhPJwD82JfES0vIiNxaZx2DTK40l5Zfi8AgVI5WeY9/2N0NvgfN7gt9wTmaQxgPyd4hiCUd2GBeZZH9ejXImSQvhI=
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr26739120ejb.302.1640903346171;
 Thu, 30 Dec 2021 14:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20211230102110.3861-1-yu.tu@amlogic.com> <20211230102110.3861-3-yu.tu@amlogic.com>
 <Yc2mHOT4WwgUrrhG@kroah.com>
In-Reply-To: <Yc2mHOT4WwgUrrhG@kroah.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 30 Dec 2021 23:28:55 +0100
Message-ID: <CAFBinCBtye7KiEqFbUeNDeRGSQkhnQ-XH-Gr-KMUWYupvioP1g@mail.gmail.com>
Subject: Re: [PATCH V3 2/6] tty: serial: meson: Request the register region in meson_uart_probe()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Vyacheslav <adeep@lexina.in>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 30, 2021 at 1:29 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
[...]
> >  static void meson_uart_release_port(struct uart_port *port)
> >  {
> > -     devm_iounmap(port->dev, port->membase);
> > -     port->membase = NULL;
> > -     devm_release_mem_region(port->dev, port->mapbase, port->mapsize);
> > +     /* nothing to do */
> >  }
>
> Are you sure a release call like this can be "empty"?  That goes against
> the normal way the driver model works.  If it is empty, why have it at
> all?
In patch #4 from this series some logic is added here again.
I can think of three options here (in no particular order):
- keep this patch as-is
- remove the empty function from this patch and it back in patch #4
from this series
- try to split some of the logic from patch #4 so the relevant
clk_prepare_enable/clk_disable_unpepare calls are added here (meaning
that this function has logic inside it at all times throughout this
series)
- (if you have another suggestion then please let us know)


Best regards,
Martin

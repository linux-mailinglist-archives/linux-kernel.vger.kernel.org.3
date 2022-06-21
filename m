Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03026553AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354035AbiFUTeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352672AbiFUTes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:34:48 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239752D1ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:34:41 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v81so26281533ybe.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXndJbSr9Ys4cj6udGMJGPkAdQ+tLqQg3olnN64ieEQ=;
        b=hs0LBDjDT9OlV72N7fBe49gCxiWYUZOxcBIws2Wgn8BN3WqTsnKUdVz0Q6ampLmXSV
         5NkiSMbN9ezJtAmWUjyXVIOyvmB3tJWzCQSXBR+AO4tHEKCswdhBhhSG3vkBJZtJUVht
         3JKyU0RJ2Ra5mCUJKBEJL8bG3wIYavBkn/AC2/Ch3FvXau57I9pfQARkPbGSgaJEoyGe
         lTYcqa0zN/847nKzFl1WJjYqvmR1XHqpgkTYKwx4e2Qa8R6Ns1pVO3swtmqqCxrKN2V9
         Bfty4fIeIEEKkVxTaMUi8q3bxkgjiWSJm0iXnvkRaHi2W0O9dPMwDc0y+T+TfR/UJ6Ei
         2AEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXndJbSr9Ys4cj6udGMJGPkAdQ+tLqQg3olnN64ieEQ=;
        b=BdW5TsgX1nuRi9SAgBVl4FNBg98jijHkVfyviwSf8LESMtqsHYpXWD0TXlW0QDDzvh
         pduJugxWFSZbvVKOGaBb54Ql5bdYRNAf8a4e1z3tCpsHNn9gmuUTfy3m4Tx7OzOtWWZ1
         nXAzjO+6YawBA8d6bEOsMNFCBN8c+IuoPIIGErnyzN144GGXJeBcpki8dxRiujGFl2Kj
         MnCdaKlS17p0/g91LXL7RHSOa9nyzll5z23daL5TYKcyGI/r4GJHPQpvc1cOxiiLCSLa
         ymYiNbcabkGGxIinL4ff+MoK1Fogqwyo0L961d/+RJPzsWtgRa+gpAO+buiBZBZYZXqY
         7Ffg==
X-Gm-Message-State: AJIora9xME2Oyd1lQ5TR3McTGB6fBQWYsLVm+ftI0bxBDHfbAUkl4pKh
        2uBDL5vycyNATK6XU+BlxQWTa3+h6EeMmGhBug4cCg==
X-Google-Smtp-Source: AGRyM1u+tZKGrSW1cGi362mrQj+GEMsoaxrv0rYK4Hl9mC2GWlTK9NyKv5qqlRv1HupVfSdChNkUORkFSlefFHsLXRY=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr32241009ybo.115.1655840080076; Tue, 21
 Jun 2022 12:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
In-Reply-To: <YrFzK6EiVvXmzVG6@atomide.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 21 Jun 2022 12:34:03 -0700
Message-ID: <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 12:28 AM Tony Lindgren <tony@atomide.com> wrote:
>
> Hi,
>
> * Saravana Kannan <saravanak@google.com> [700101 02:00]:
> > Now that fw_devlink=on by default and fw_devlink supports
> > "power-domains" property, the execution will never get to the point
> > where driver_deferred_probe_check_state() is called before the supplier
> > has probed successfully or before deferred probe timeout has expired.
> >
> > So, delete the call and replace it with -ENODEV.
>
> Looks like this causes omaps to not boot in Linux next.

Can you please point me to an example DTS I could use for debugging
this? I'm assuming you are leaving fw_devlink=on and not turning it
off or putting it in permissive mode.

> With this
> simple-pm-bus fails to probe initially as the power-domain is not
> yet available.

Before we get to late_initcall(), I'd expect this series to not have
any impact because both fw_devlink and
driver_deferred_probe_check_state() should be causing the device's
probe to get deferred until the PM domain device comes up.

To double check this, without this series, can you give me the list of
"supplier:*" symlinks under a simple-pm-bus device's sysfs folder
that's having problems with this series? And for all those symlinks,
cat the "status" file under that directory?

In the system where this is failing, is the PM domain driver loaded as
a module at a later point?

Couple of other things to try (with the patches) to narrow this down:
* Can you set driver_probe_timeout=0 in the command line and see if that helps?
* Can you set it to something high like 30 or even larger and see if it helps?

> On platform_probe() genpd_get_from_provider() returns
> -ENOENT.

This error is with the series I assume?

> Seems like other stuff is potentially broken too, any ideas on
> how to fix this?

I'll want to understand the issue first. It's not yet clear to me why
fw_devlink isn't blocking the probe of the simple-pm-bus device until
the PM domain device shows up. And if it is not blocking, then why and
at what point in boot it's giving up and letting the probe get to this
point where there's an error.

-Saravana

>
>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/domain.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba..3e86772d5fac 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >               mutex_unlock(&gpd_list_lock);
> >               dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
> >                       __func__, PTR_ERR(pd));
> > -             return driver_deferred_probe_check_state(base_dev);
> > +             return -ENODEV;
> >       }
> >
> >       dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

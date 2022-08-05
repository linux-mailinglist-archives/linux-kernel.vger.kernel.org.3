Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958BB58AF44
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241579AbiHER4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbiHER4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:56:08 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDEF5B1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:56:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 21so4921438ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 10:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8916SUyyqTqNo7u54CGnm6EORd6rK5vVg8avg/3xTNc=;
        b=A+Ehbri1H2UWrHBCfRBXNlFKBrEQLHm2LCX0V16hkcc0MBtpLWlBkLVMu0i9+hC2en
         JF1jD3ClJOI6pMsvegFtq/BYnw5OLdh2FhbRvgTbn8p7h2vt/1R8DGfx5+2gZaod83de
         xDg/2vlI9zCzxoMFWjpcUkGtzmyJ6h2oOo++fpK0M5g5x59K4D3NrXmithB9kMsKMd3a
         2rjpCI5gA9OEEpDNFblJO1z70c2rHKh0X8pKJgmaQHlrY0qwaKJXQK6xRPbJYwKPKC3o
         iwI02lSG9PklDSzKOExk055Pjp4WMACpG75LGOmN6fQtPhpsbiMbMz0btXvtgnD5COlY
         k22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8916SUyyqTqNo7u54CGnm6EORd6rK5vVg8avg/3xTNc=;
        b=1cnGhkS3tcROTrpO5VQG7xaNM37jez6cgt+2RrijL5wEPu21zFeawAWZKJ5aTvKOcM
         NV2peW1u6pEbmcXXBfIm0886wz3c4uvhwEhBEG1D+DhHUhdZtP+x1btVZp067LHlvlpj
         7BnAhWqMCc41f+6f/fPtk/Z1THyrxZWoRSWTc9hQHQowC+DKjTWIukQ4TSjQM8f7emiO
         NMP6gYfdRt/aJGEtICEEthqBk2okRNJjFi1sEUCZtIcxCVzHXPl+2DOn9/eXv48dQQXM
         HEDBWbZhQxwqvCiCP97/JzZvm7lMuTYXUyEw8QE0amLXkUX7jONak8Mf83s7KwYQSkJN
         VVtw==
X-Gm-Message-State: ACgBeo2duld31KHqZN9MGO0KWnAyK7mw+HHqlvGHqHtKQY0+EnP96Ghj
        xVb8bYwIFeoB9h2hD9tYflvr3qjAS2N1uqmShKq/SA==
X-Google-Smtp-Source: AA6agR7MxoD1YHIEjuGK22ZVHqTLZVQ6jsH+mC1r1OYLgq9j+Inj/MA6Mf2/lDA4t7OlrzG6jh7MtWPsh64kWhzVDK4=
X-Received: by 2002:a05:6902:1348:b0:671:78a4:471f with SMTP id
 g8-20020a056902134800b0067178a4471fmr6315089ybu.242.1659722159994; Fri, 05
 Aug 2022 10:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220804061133.4110734-1-victor.liu@nxp.com> <20220804061133.4110734-2-victor.liu@nxp.com>
 <CAL_Jsq+B5PMOmZO4hz5DyEsA4V=UkrNn-6b58h8VbcPa2iaQ1g@mail.gmail.com>
 <CAGETcx94De-wofRjtPgNxa+YQoU3+j+we+4K9Evm=vtzhopX8g@mail.gmail.com> <dbafe424aa9b4cdb79397476c1c4085ea2f0d242.camel@nxp.com>
In-Reply-To: <dbafe424aa9b4cdb79397476c1c4085ea2f0d242.camel@nxp.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 5 Aug 2022 10:55:23 -0700
Message-ID: <CAGETcx_QVaYYHsD9HZmBu404K-oXRCPm4N4GRrYu4pGyw2DHbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drivers: bus: simple-pm-bus: Populate simple MFD
 child devices
To:     Liu Ying <victor.liu@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 3:07 AM Liu Ying <victor.liu@nxp.com> wrote:
>
> On Thu, 2022-08-04 at 11:26 -0700, Saravana Kannan wrote:
> > On Thu, Aug 4, 2022 at 5:18 AM Rob Herring <robh+dt@kernel.org>
> > wrote:
> > >
> > > On Thu, Aug 4, 2022 at 12:10 AM Liu Ying <victor.liu@nxp.com>
> > > wrote:
> > > >
> > > > There could be simple MFD device(s) connected to a simple PM bus
> > > > as child
> > > > node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child
> > > > match
> > > > table as an argument to of_platform_populate() function call to
> > > > specify
> > > > the simple MFD devices so that they can be populated.
> > >
> > > There could be a simple-bus under it as well. You should just use
> > > of_platform_default_populate() instead.
> >
> > I'm confused why we even need this patch. Wouldn't this driver
> > automatically probe simple-mfd buses and populate its child devices?
> > We already have it in simple_pm_bus_of_match.
>
> First of all, this driver doesn't populate simple-mfd bus's child
> devices because "ONLY_BUS" is set in simple_pm_bus_of_match[] for
> simple-mfd.
>
> The device tree I'm working with is something like this:
>
> bus@560000000 {
>         compatible = "fsl,aips-bus", "simple-bus";
>         ...
>
>         bus@562000000 {
>                 compatible = "fsl,imx8qm-display-pixel-link-msi-bus", "simple-
> pm-bus";
>                 ...
>
>                 syscon@56241000 {
>                         compatible = "fsl,imx8qm-lvds-csr", "syscon", "simple-mfd";
>                         ...
>
>                         syscon_child {};
>                 };
>
>                 /* more regular mmap devices */
>         };
> };
>
> IIUC, default buses listed in of_default_bus_match_table[], including
> simple-bus and simple-mfd, are populated by
> of_platform_default_populate() in a recursive fashion, when
> of_platform_default_populate_init() is called.  However, simple-pm-bus
> is not listed in that table.  So, bus@562000000 (simple-pm-bus) is the
> last one to be populated successfully and syscon@56241000 (simple-mfd)
> is not populated (recursion stops).

Ok, it's working as intended so far.

> Then, this patch adds a match table to populate syscon@56241000 (simple
> -mfd) _and_ it's child nodes when bus@562000000 (simple-pm-bus) is
> probed.  of_platform_populate() will populate syscon@56241000 (simple-
> mfd) and it's child devices (sycon_child) together. Hence, sycon_child
> devices will be probed ok.

I think of_platform_default_populate() is the right solution here
instead of spinning up a new table. Because a tree of simple-bus
children of simple-pm-bus would have the same problem you are facing
with simple-mfd's children not being populated.

> The problem is that syscon@56241000 (simple-mfd) fails to be probed
> with return code -ENODEV as "ONLY_BUS" is set and "simple-mfd" is the
> 3rd compatible string.

Ah, thanks for the example of your DT. My bad, I had forgotten the
"simple-mfd" is one of the default populate busses and can be a 2nd or
later entry in the compatible string and still have its children
populated by default by OF platform code.

> Even if it's probed ok, syscon@56241000 (simple-
> mfd) is not power managed, which means syscon_child devices' PM
> operations won't be propagated to bus@562000000 (simple-pm-bus) (?).
> Anyway, somehow, syscon_child devices do work, based on my test.

Aren't you seeing this propagation issue even with your current patches?

> With regard to PM, simple-bus is the same if it sits at simple-mfd's
> place.  So, maybe, simple-mfd and simple-bus should be power managed as
> well?  Or, simple-pm-bus should have no simple-mfd and simple-bus child
> nodes at all?

The problem is that there are cases of devices with real drivers that
also list simple-bus as their secondary compatible string. So we can't
really remove any of the existing ONLY_BUS as that could cause
simple-pm-bus driver to probe them instead of the real driver.

In your case, why even list this as "fsl,imx8qm-lvds-csr"? Can't you
just change your compatible string from:
"fsl,imx8qm-lvds-csr", "syscon", "simple-mfd";
To:
"simple-pm-bus", "syscon", "simple-mfd";

You are treating it exactly as a simple-pm-bus. So I don't see what
this extra "fsl,imx8qm-lvds-csr" distinction brings. Or make it if you
really want the "fsl,imx8qm-lvds-csr" in there:
"fsl,imx8qm-lvds-csr", "simple-pm-bus", "syscon", "simple-mfd";

If you are actually going to write a driver for "fsl,imx8qm-lvds-csr"
then you need to have that driver bind to this device of yours and do
PM management and populate the child devices if they aren't already.

Long story short, with what I understand so far, I think what you need
to do are:
1. Patch to manage clock.
2. Patch to use of_platform_default_populate()
3. Fix up the compatible string to list simple-pm-bus in it.

>
> >
> > I'm wondering if you are trying to workaround the behavior of having
> > "ONLY_BUS" set in simple_pm_bus_of_match for "simple-mfd". Have you
> > tried deleting that field and see if it does what you want?
>
> Without this patch, deleting "ONLY_BUS" works for me, as syscon_child
> devices are populated when syscon@56241000 (simple-mfd) is probed.
> Deleting "ONLY_BUS" may make simple-mfd a power managed device. Is it a
> right thing to do?

Ignore my point about deleting ONLY_BUS. That's wrong because then the
simple-pm-bus driver can end up probing any device that lists
simple-mfd even if there's another driver that could (like
"fsl,imx8qm-lvds-csr") and we don't want that.

-Saravana



>
> Regards,
> Liu Ying
>
> >
> > And we wouldn't need to use of_platform_default_populate() because
> > this driver would take care of doing that recursively. Especially
> > when
> > you need the clocks and power domain to be able to access the child
> > devices, you want the driver to probe and do that at each level
> > before
> > automatically recursively adding all the grand-children devices.
> >
> > -Saravana
> >
> > >
> > > >
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > > ---
> > > > v1->v3:
> > > > * No change.
> > > >
> > > >  drivers/bus/simple-pm-bus.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
> > > > bus.c
> > > > index 6b8d6257ed8a..ff5f8ca5c024 100644
> > > > --- a/drivers/bus/simple-pm-bus.c
> > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > @@ -13,6 +13,11 @@
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_runtime.h>
> > > >
> > > > +static const struct of_device_id simple_pm_bus_child_matches[] =
> > > > {
> > > > +       { .compatible = "simple-mfd", },
> > > > +       {}
> > > > +};
> > > > +
> > > >  static int simple_pm_bus_probe(struct platform_device *pdev)
> > > >  {
> > > >         const struct device *dev = &pdev->dev;
> > > > @@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct
> > > > platform_device *pdev)
> > > >         pm_runtime_enable(&pdev->dev);
> > > >
> > > >         if (np)
> > > > -               of_platform_populate(np, NULL, lookup, &pdev-
> > > > >dev);
> > > > +               of_platform_populate(np,
> > > > simple_pm_bus_child_matches, lookup, &pdev->dev);
> > > >
> > > >         return 0;
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
>

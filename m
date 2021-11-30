Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DA0462912
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhK3A3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:29:01 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:35365 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhK3A27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:28:59 -0500
Received: by mail-qt1-f171.google.com with SMTP id j17so18500344qtx.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmZ6yrLmHwc8oKXeav6AR62kh5AMJR8Zb4JZJaz0P08=;
        b=DBEkx795Uw6fLNqGYRAJVtlZkCRGhXBdFMyUXeEPpWqIb0RbyoU6zJvV/tiK5rlx0Z
         o/pc5XRqkdNH9++SuLAqP8OoU1NWAhT5R+XH/EpVNuNZGKD4kB3eq3E6aZ2xqrnFE9xW
         UZw8m+mQ3cP99xYuZqAb2vUV0nJy6eej/Pck3ah/DfB+VnVeRsCpGVPcOg+B4O6OEqYP
         7kK9Vmut6rztoi676Ra+YzSHb8MzTnpXVtEfT+TkqwU2qltJTH2CRqX3xOf0RDLpQHsK
         OGnSUs3xGLFWJ7Mimb/g2ao3npiKtRre6wLQNpaz678kLoaOM9Lo/nlWTcHr9UO7bsTi
         yUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmZ6yrLmHwc8oKXeav6AR62kh5AMJR8Zb4JZJaz0P08=;
        b=0CQQvkP/xjb+2dTMI7R1vFDl679KJlk+GMDq08xquNHR65pVrA0OnOkhpUrtbs9LpK
         m9plHyCRGSTqkpw468kNzfEzeQnkeP/jbsDoQ9ok5byEoohoXpb2SA27bcI5ktUvujYg
         OidThxxpjAgcsAcX+rmSlkxn2ZcrzOg0a3iLAMuzRUhD+Sxh55ceLZ+iYaPrG09IK2mn
         ZQ3mPxFmALTVm1XE7f895CXPhFejrNVeLNAr8Nvy76Y79G96PO49HZRR5db9qnwcloxR
         ANlU3wX9ekB4uGtbFSXtbhVlzCmx9isU81dpUzx1j9/OPFloGr9RgPwuS5/JUkc9/Q9v
         19bg==
X-Gm-Message-State: AOAM5337DMKZ4AOkNgosgQJhN3wY8kneCk37expmmWAHaz4l3UPsvr7p
        NiMRB9JcGIu8n2sBThoApGJ2HI4B8/ZtClCsqma04w==
X-Google-Smtp-Source: ABdhPJwuErsaT5p6jX4BOEb7NrgrXWKD2lSqqGnHf0k7Irhr5BOzwSiJBNdUTkXJxVX8QU247dtoj2Z/Wf5u6TZUnN8=
X-Received: by 2002:a05:622a:15c6:: with SMTP id d6mr38396525qty.439.1638231880398;
 Mon, 29 Nov 2021 16:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20211125183622.597177-1-dmitry.baryshkov@linaro.org>
 <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com> <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com>
In-Reply-To: <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 30 Nov 2021 03:24:29 +0300
Message-ID: <CAA8EJpr4+B1Q3voOr__3M37jxxBRi0g3avzE1Y8CDLkZB+rSGg@mail.gmail.com>
Subject: Re: [PATCH] of: property: do not create clocks device link for clock controllers
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 at 02:53, Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Nov 29, 2021 at 3:48 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Nov 25, 2021 at 10:36 AM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > Do not create device link for clock controllers.
> >
> > Nak.
> >
> > > Some of the clocks
> > > provided to the device via OF can be the clocks that are just parents to
> > > the clocks provided by this clock controller. Clock subsystem already
> > > has support for handling missing clock parents correctly (clock
> > > orphans). Later when the parent clock is registered, clocks get
> > > populated properly.
> > >
> > > An example of the system where this matters is the SDM8450 MTP board
> > > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > > etc. With just dsi0_phy in place devlink is able to break the
> > > dependency,
> >
> > Right, because I wrote code to make sure we handle these clock
> > controller cases properly. If that logic isn't smart enough, let's fix
> > that.

As I said, devlink was delaying dispcc probing ,waiting for the second
DSI PHY clock provider.
Thus came my proposal to let clock orphans handle the case (which it
does perfectly).

> >
> > > but with two PHYs, dispcc doesn't get probed at all, thus
> > > breaking display support.
> >
> > Then let's find out why and fix this instead of hiding some
> > dependencies from fw_devlink. You could be breaking other cases/boards
> > with this change you are making.
>
> Btw, forgot to mention. I'll look into this one and try to find the
> reason why it wasn't handled automatically. And then come up with a
> fix.
>
> If you want to find out why fw_devlink didn't notice the cycle
> correctly for the case of 2 PHYs vs 1 PHY, I'd appreciate that too.
>
> Btw, same comment for remote-endpoint. I'll look into what's going on
> in that case. Btw, I'm assuming all the code and DT you are testing
> this on is already upstream. Can you please confirm that?

All the code and basic DT is upstreamed. The DT part I
referenced/posted was written for the custom extender for the
qrb5165-rb5 board that I use here to test MSM DRM driver, but the
result DT should be more or less the same as smd845-mtp.

>
> -Saravana
>
> >
> > -Saravana
> >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Stephen Boyd <swboyd@chromium.org>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  drivers/of/property.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index a3483484a5a2..f7229e4030e3 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1264,7 +1264,6 @@ struct supplier_bindings {
> > >         bool node_not_dev;
> > >  };
> > >
> > > -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> > >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> > >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> > >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > > @@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
> > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > >
> > > +static struct device_node *parse_clocks(struct device_node *np,
> > > +                                       const char *prop_name, int index)
> > > +{
> > > +       /*
> > > +        * Do not create clock-related device links for clocks controllers,
> > > +        * clock orphans will handle missing clock parents automatically.
> > > +        */
> > > +       if (!strcmp(prop_name, "clocks") &&
> > > +           of_find_property(np, "#clock-cells", NULL))
> > > +               return NULL;
> > > +
> > > +       return parse_prop_cells(np, prop_name, index, "clocks",
> > > +                                      "#clock-cells");
> > > +}
> > > +
> > >  static struct device_node *parse_gpios(struct device_node *np,
> > >                                        const char *prop_name, int index)
> > >  {
> > > --
> > > 2.33.0
> > >



-- 
With best wishes
Dmitry

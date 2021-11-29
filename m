Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970454628A4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhK2X4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhK2X4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:56:20 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED957C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:53:01 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id v203so47166228ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/NqQPRNvUZU+0JCCk7H1tIikjeN2hJL0ywpfLSeC3A=;
        b=TkEax+J0bmDp+JZ1p+gK7Ddy3ukqn5PKlRVbahmc8OO8xw4OygaukebcomL6UBH4zl
         3zVQ+upp+tk9io+DfWXBOWa66VhPX+yZohE9cfeT2IEclCIeM6LBi2k68JVX0RYqA7YR
         NLTtvpq+AtgaHw6DChA47rnIMqojcQ/pxgPCs2ai5FYCg9Y8kesYImR++fYtsNbaeWWp
         nBlUMbrJE4vstivGG+0/mDeHHKaCT9MEDFeETmyG+8VifiOre6xdonXXogLUBKsRmJyu
         ebXQr3F2T8inIBMTlL6w/eC/Redlxr14icmXGlrBKODijT9jbGT2X8A0+66SEqKVRGSh
         4xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/NqQPRNvUZU+0JCCk7H1tIikjeN2hJL0ywpfLSeC3A=;
        b=136UGBub6hwKJhM5LVsPd5e2DGjKiFCCleJaCmn8J6mM5JqGKHrxqjU5kYHzulWfL2
         08/kmbCdihacN5FyEYyfzRyoOIl5ibT8GFJf0M3uCukaJeR/0gIcKJKyjUVELEgsKPbq
         5sWEQzjjcM2XstBYlj1jSGmooetkQRTwqwACNLDDLVnXLdgx4FHCk0EsxWDIuK19bJeh
         3D8KC1lczLrsuKjSDcQEwvL2peG3Z4LdfeFkp980Kju3Pmr78ePVpnTZJvleoqLjZEtc
         J1DVTO2sbG1ca9g+QZofEMMd+FzCHuil7YzVIXMAEqR4ND2mbalBACWijJ1wWM8bVT/I
         YY4w==
X-Gm-Message-State: AOAM532co77hkV8/9Mqs42V6uKZ6qEsr+VbcZMa1HHVS4UuM5QCshkSI
        TfBbxsNfGEvzq0Dshdp71F3+8nIl8NHEBa48xi9KYw==
X-Google-Smtp-Source: ABdhPJzLGkscmACsLBxU/CcE3gRHToupkDUY7Fb+tdemWE/3/jA9m+2MAnq/P0ziJocyYBFSLjYNX7809g7ZSqzzpgI=
X-Received: by 2002:a25:2d67:: with SMTP id s39mr39943320ybe.140.1638229980878;
 Mon, 29 Nov 2021 15:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20211125183622.597177-1-dmitry.baryshkov@linaro.org> <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com>
In-Reply-To: <CAGETcx-_6OvcJM1nAoX3pxE3Rard5CRxEuEsmhfLANOzOS1BSQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 29 Nov 2021 15:52:25 -0800
Message-ID: <CAGETcx86iFm04PxnmrRQhooxtd4_kv87rAu=T0RauqFXmRLKNA@mail.gmail.com>
Subject: Re: [PATCH] of: property: do not create clocks device link for clock controllers
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

On Mon, Nov 29, 2021 at 3:48 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Nov 25, 2021 at 10:36 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Do not create device link for clock controllers.
>
> Nak.
>
> > Some of the clocks
> > provided to the device via OF can be the clocks that are just parents to
> > the clocks provided by this clock controller. Clock subsystem already
> > has support for handling missing clock parents correctly (clock
> > orphans). Later when the parent clock is registered, clocks get
> > populated properly.
> >
> > An example of the system where this matters is the SDM8450 MTP board
> > (see arch/arm64/boot/dts/qcom/sdm845-mtp.dts). Here the dispcc uses
> > clocks provided by dsi0_phy and dsi1_phy device tree nodes. However the
> > dispcc itself provides clocks to both PHYs, to the PHY parent device,
> > etc. With just dsi0_phy in place devlink is able to break the
> > dependency,
>
> Right, because I wrote code to make sure we handle these clock
> controller cases properly. If that logic isn't smart enough, let's fix
> that.
>
> > but with two PHYs, dispcc doesn't get probed at all, thus
> > breaking display support.
>
> Then let's find out why and fix this instead of hiding some
> dependencies from fw_devlink. You could be breaking other cases/boards
> with this change you are making.

Btw, forgot to mention. I'll look into this one and try to find the
reason why it wasn't handled automatically. And then come up with a
fix.

If you want to find out why fw_devlink didn't notice the cycle
correctly for the case of 2 PHYs vs 1 PHY, I'd appreciate that too.

Btw, same comment for remote-endpoint. I'll look into what's going on
in that case. Btw, I'm assuming all the code and DT you are testing
this on is already upstream. Can you please confirm that?

-Saravana

>
> -Saravana
>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/of/property.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index a3483484a5a2..f7229e4030e3 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1264,7 +1264,6 @@ struct supplier_bindings {
> >         bool node_not_dev;
> >  };
> >
> > -DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> >  DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
> >  DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
> >  DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
> > @@ -1294,6 +1293,21 @@ DEFINE_SIMPLE_PROP(backlight, "backlight", NULL)
> >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> >
> > +static struct device_node *parse_clocks(struct device_node *np,
> > +                                       const char *prop_name, int index)
> > +{
> > +       /*
> > +        * Do not create clock-related device links for clocks controllers,
> > +        * clock orphans will handle missing clock parents automatically.
> > +        */
> > +       if (!strcmp(prop_name, "clocks") &&
> > +           of_find_property(np, "#clock-cells", NULL))
> > +               return NULL;
> > +
> > +       return parse_prop_cells(np, prop_name, index, "clocks",
> > +                                      "#clock-cells");
> > +}
> > +
> >  static struct device_node *parse_gpios(struct device_node *np,
> >                                        const char *prop_name, int index)
> >  {
> > --
> > 2.33.0
> >

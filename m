Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B34A9711
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357680AbiBDJoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357552AbiBDJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:44:32 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E4FC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:44:32 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id o17so7733768ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s3hoNqkHm8uABs8bA5GkGd4u8pf+9SvyozF/PnFazzA=;
        b=iQ1GwxAN6QzhF77ngrDL5IUqqH/qnq2wnuA15gyhCr63Ob42nAFu+SOlLp4gMNRLg/
         gOOH9xR6sFPXc/69PwTAxghKL2IIclwXvduszgWH+PKoCDG9C2hRCYwuCGRkr61BRklh
         YHq6UG0+YUIMxo4vXxCgecOZQ14MjdZZDY9gTbRAyClssRYH77caNmpuwqW7Tu/dhnbD
         tY397u7RcGu8CPhjoXolUm0dy5Yg1hWtCkhWPjy6SEwZAOO5yrL1/z4Ix1BcBVKx7BOU
         3tTmIH0B9vl7PJjJDySU9WmHF1ajTTuufg5iou88ZLtwoBwXCLb6ytR5HzorTbrenadO
         TBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s3hoNqkHm8uABs8bA5GkGd4u8pf+9SvyozF/PnFazzA=;
        b=JYr5loJ7hVdYmvzF+ERDDSxFOZ+00XGah0C0ngjRlz2FRoqxVky0p9he9fKbTt4pr/
         AfHmL0pw6JSupy3IIIu9wVi0cXDsiZW/Z9dnlxSfN78Ocz14h9zIVXaprQ04X76ck3eZ
         Ir9nIfx4OLas3A0yOyYzR/Sk+7ctNnf9I4CsZHum5zk0GOceqSBRTlqRBMTIIzvUzHbF
         5Sh2kpLJ6C5SWz7bvBNATqkpJtL7zWLqjyBlXnWvF3KOcfRMZo5Q6qV4A1bcmNGnyEba
         aBTQ3BU0bBa4s8MKyPKIK7L9Ao0hETtz3wgW+hAYKvBbxXRai9OZms7A4hlclsGPKxE3
         9rfA==
X-Gm-Message-State: AOAM530a5jKrhnsfn0zTUyTwUqfQ2JcaXfdiz8acrnA1XHGjQgkLHQ0O
        RGFDOCVhAcOtflsN4jDBja5zouy04uQCvPQ4kHZr0ZNzTvQ=
X-Google-Smtp-Source: ABdhPJxvuguFzra5GtzuztPGthoos7qcHGERlZxk4EZGk0b2aj/xM9XE+MZ0Xq7aG/g/jk60nFQ0MnRng8vFmigaIto=
X-Received: by 2002:a05:651c:179c:: with SMTP id bn28mr1320707ljb.4.1643967870698;
 Fri, 04 Feb 2022 01:44:30 -0800 (PST)
MIME-Version: 1.0
References: <20220131113743.52265-1-ulf.hansson@linaro.org> <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
In-Reply-To: <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Feb 2022 10:43:54 +0100
Message-ID: <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: Prevent power off for parent unless child is
 in deepest state
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jan 2022 at 19:29, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 31.01.2022 14:37, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > A PM domain managed by genpd may support multiple idlestates. During
> > genpd_power_off() a genpd governor may be asked to select one of the
> > idlestates based upon the dev PM QoS constraints, for example.
> >
> > However, there is a problem with the behaviour around this in genpd. Mo=
re
> > precisely, a parent-domain is allowed to be powered off, no matter of w=
hat
> > idlestate that has been selected for the child-domain.
> >
> > So far, we have not received any reports about errors, possibly because
> > there might not be platform with this hierarchical configuration, yet.
> > Nevertheless, it seems reasonable to change the behaviour into preventi=
ng
> > the parent-domain from being powered off, unless the deepest idlestate =
has
> > been selected for the child-domain, so let's do that.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 5db704f02e71..7f97c5cabdc2 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_domai=
n *genpd, bool one_dev_on,
> >                       atomic_read(&genpd->sd_count) > 0)
> >               return -EBUSY;
> >
> > +     /*
> > +      * The children must be in their deepest states to allow the pare=
nt to
> > +      * be powered off. Note that, there's no need for additional lock=
ing, as
> > +      * powering on a child, requires the parent's lock to be acquired=
 first.
> > +      */
> > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > +             struct generic_pm_domain *child =3D link->child;
> > +             if (child->state_idx < child->state_count - 1)
> > +                     return -EBUSY;
> > +     }
> > +
> >       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >               enum pm_qos_flags_status stat;
> >
> > @@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generic_=
pm_domain *genpd, bool use_lock,
> >           || atomic_read(&genpd->sd_count) > 0)
> >               return;
> >
> > +     /* Check that the children are in their deepest state. */
> > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > +             struct generic_pm_domain *child =3D link->child;
> > +             if (child->state_idx < child->state_count - 1)
> > +                     return;
> > +     }
> > +
> >       /* Choose the deepest state when suspending */
> >       genpd->state_idx =3D genpd->state_count - 1;
> >       if (_genpd_power_off(genpd, false))
>
> Hello Ulf,

Hi Dmitry,

>
> Is this needed by a concrete SoC? It needs to be clarified in the commit
> message, otherwise looks like this patch wasn't tested and it's unclear
> whether this change is really needed.

It's needed on a STMicro SoC that I have been working on. However,
it's difficult for me to test on that platform, as some SoC specific
pieces are missing upstream (the power domain deployment in
particular). Anyway, let me add some information about this in the
commit log for the next version.

When it comes to testing, I am using a couple of local test dummy
drivers. One that manages devices that gets attached to a genpd,
mostly to execute runtime PM and dev PM QoS calls - and another that
manages the PM domains with genpd. I have been thinking of a way to
share these "tools" to let other people use them for testing too, but
I haven't just got to it yet.

Besides the above, do you see any issues from Nvidia platforms point
of view with $subject patch?

Kind regards
Uffe

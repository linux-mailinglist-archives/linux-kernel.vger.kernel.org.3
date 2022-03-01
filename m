Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88034C8E67
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiCAO50 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Mar 2022 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbiCAO5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:57:24 -0500
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F10A252C;
        Tue,  1 Mar 2022 06:56:43 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id y189so27705991ybe.4;
        Tue, 01 Mar 2022 06:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXZ6ThxTiXXN8hNTJoySMR/9n+H4s9P6qNdmGcFsy2Q=;
        b=MdUQUBRsDNA+wOEUTzWxtUuCU3uL4lpd53OVuv1yCclnphxELJ3fPI/g+GvvRLY0Eh
         rHnYp60s11hbvCdDn4XTsL++LK0V/St28Q8oRvhM78PK42Iq1BrXlOntonRL1DybaGyN
         vliqg6/Iq9Ku05Q0AQlVcrgeHxvsSnRTCHctT8beiNvtTcOCh+efIh9hP9wnl5z7Q+IB
         cu+umm8HoHI9HhDCFnDOwAJMAQ8hKR7PuA1EuGVqifYrJu/nzdv03AKPpQ0ha5zWATIR
         Th3v35UFEXms2qsheFem4nDxtDF9ON0rBJkPJBUwSfM0R70wN2sliCCY6+uLGVsUN14l
         oTEA==
X-Gm-Message-State: AOAM530f9rXkNyzqqOfWOMQiShZcEaiLbKmHsFPOlwLCWCM55UnLrCaJ
        OJLBOD8pTA93kdCxxg7QCg6Nlr5h8sPb+R3JVOA=
X-Google-Smtp-Source: ABdhPJxOxZDg/z4+yOvRSE2GIfKAM9ttbUGwmE+czyz7QMTljipip4WOM+CAr2fRVo3eZ/JtuqmUKUBjUStKeJKRoPQ=
X-Received: by 2002:a25:24d7:0:b0:628:79dc:1250 with SMTP id
 k206-20020a2524d7000000b0062879dc1250mr2985360ybk.153.1646146602616; Tue, 01
 Mar 2022 06:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20220217124950.211354-1-ulf.hansson@linaro.org>
 <a869b705-c10e-ed0b-4119-35ef0a028311@gmail.com> <CAPDyKFrBxVry=yh8m+OSaq+xnzDmVqhFXQ0QN1F9WR3KB=2MGg@mail.gmail.com>
In-Reply-To: <CAPDyKFrBxVry=yh8m+OSaq+xnzDmVqhFXQ0QN1F9WR3KB=2MGg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 15:56:31 +0100
Message-ID: <CAJZ5v0guqv=A_kBQSiq03zuiR-6VPy7gthppTPJX5hiHRjC2Sg@mail.gmail.com>
Subject: Re: [PATCH v2] PM: domains: Prevent power off for parent unless child
 is in deepest state
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 9:56 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 18 Feb 2022 at 00:11, Dmitry Osipenko <digetx@gmail.com> wrote:
> >
> > 17.02.2022 15:49, Ulf Hansson пишет:
> > > A PM domain managed by genpd may support multiple idlestates (power-off
> > > states). During genpd_power_off() a genpd governor may be asked to select
> > > one of the idlestates based upon the dev PM QoS constraints, for example.
> > >
> > > However, there is a problem with the behaviour around this in genpd. More
> > > precisely, a parent-domain is allowed to be powered off, no matter of what
> > > idlestate that has been selected for the child-domain.
> > >
> > > For the stm32mp1 platform from STMicro, this behaviour doesn't play well.
> > > Instead, the parent-domain must not be powered off, unless the deepest
> > > idlestate has been selected for the child-domain. As the current behaviour
> > > in genpd is quite questionable anyway, let's simply change it into what is
> > > needed by the stm32mp1 platform.
> > >
> > > If it surprisingly turns out that other platforms may need a different
> > > behaviour from genpd, then we will have to revisit this to find a way to
> > > make it configurable.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >
> > > Changes in v2:
> > >       - Clarified commit message - based upon discussions with Dmitry.
> > >       - Updated a comment in the code, suggested by Dmitry.
> > >
> > > ---
> > >  drivers/base/power/domain.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index 5db704f02e71..c87588c21700 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -636,6 +636,18 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
> > >                       atomic_read(&genpd->sd_count) > 0)
> > >               return -EBUSY;
> > >
> > > +     /*
> > > +      * The children must be in their deepest (powered-off) states to allow
> > > +      * the parent to be powered off. Note that, there's no need for
> > > +      * additional locking, as powering on a child, requires the parent's
> > > +      * lock to be acquired first.
> > > +      */
> > > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > > +             struct generic_pm_domain *child = link->child;
> > > +             if (child->state_idx < child->state_count - 1)
> > > +                     return -EBUSY;
> > > +     }
> > > +
> > >       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> > >               enum pm_qos_flags_status stat;
> > >
> > > @@ -1073,6 +1085,13 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
> > >           || atomic_read(&genpd->sd_count) > 0)
> > >               return;
> > >
> > > +     /* Check that the children are in their deepest (powered-off) state. */
> > > +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> > > +             struct generic_pm_domain *child = link->child;
> > > +             if (child->state_idx < child->state_count - 1)
> > > +                     return;
> > > +     }
> > > +
> > >       /* Choose the deepest state when suspending */
> > >       genpd->state_idx = genpd->state_count - 1;
> > >       if (_genpd_power_off(genpd, false))
> >
> > Thank you, looks good. Although, this should be v3.
> >
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
>
> Thanks Dmitry! I think v2 should be correct. At least I haven't sent a
> v2 before. :-)
>
> Rafael, I think this is ready to go, can please pick it up?

Applied as 5.18 material, thanks!

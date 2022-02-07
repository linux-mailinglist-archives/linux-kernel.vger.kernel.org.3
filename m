Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABFB4AB6DC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346935AbiBGIpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiBGIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:44:12 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286FC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:44:10 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id c15so18422394ljf.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iV9+wsyfUcoW/CmR74trefYkab9ZaA0MJl8TccvkpxA=;
        b=fqB0sUl89xvVMJzuFktZmc/xLp21fIZ6V56NLPiVLb9Uww8w6ImIdxClcUslefyuPn
         S2F/Mhkk6nsF4h1ky4NCN1mB9VXbj5ih7KokULjll67LTGb4+uQY73fSSrhrrABW0Oci
         OG0CEwYVzYxvHlrxJTJ4GbHZBJV7l1ZnmrSLH5CtimQO1FWKuS7G6HBHbju6sxzDTwNC
         fS1UYXgY7nAp2pWwCWN8KlmekeD/3jw9NKwfAkxAf2YEqCVALpH17K7fxR4xEgTr7MKj
         OYdmTAGZw2qoLsqIvWWKC7V40+JrpIviGe5vYb7/MBWZ2ZhjkSAiXNiYuzKSd6i/V4Ia
         DFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iV9+wsyfUcoW/CmR74trefYkab9ZaA0MJl8TccvkpxA=;
        b=nzk0oKwHSyIUztS5/i6zKkXp1Iy1/H9bj7hKMhZt699jMyBd/zJthbU0oEW4g959hH
         huTF8Tn2nsGlZH2umCYFQeU3Lrih6aCpyRbaw4WaTlKraMONghImDTTeso9UXHLpfbhQ
         2PCfIFkxpKB5gqeU5PVDpal4hH2dHyMG1Qdtx/tnkwOmXkaty2GPk/ntHyRESf8nmbi8
         pRtJPlN9XcWrP6CrWmlReq29+5pWboEEV0KuOs7D9AR/481BgFR/CL+RQaD14y7SiIup
         IIi5VHynaol7LW9YSpmCUIm5Ev7KVDQVmBXQC2CzBEqx1K261K97ai0DmKpLf4v6zrD3
         QwUg==
X-Gm-Message-State: AOAM531egXdw3qdAPoMuhrPZNELR60P4M9WwzZgt+9LOi6pcfnQVPhL5
        tH/BzxhniS1g6zwZ7AbGkj6FspIdjMgbxDJhs2V0iw==
X-Google-Smtp-Source: ABdhPJxijT6MHex4bqgY6LoldBW85wOtJU7/upx1oWMkfqzHyF0lKD8+g8zAWNzBSJRF+FvSmiCwkEC1iYh0SoLCoMQ=
X-Received: by 2002:a05:651c:1787:: with SMTP id bn7mr8423349ljb.16.1644223449112;
 Mon, 07 Feb 2022 00:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20220131113743.52265-1-ulf.hansson@linaro.org>
 <b33ceac4-506a-65c8-7c80-b1b0a67ce65e@gmail.com> <CAPDyKFqsvF=Pm-vMXSUwPMPnjCr7nSYuy5AH+8rwLYm_NUPKww@mail.gmail.com>
 <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com>
In-Reply-To: <400e45da-837a-c8ad-84b3-285e35f8462c@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 7 Feb 2022 09:43:32 +0100
Message-ID: <CAPDyKFpLX0Jpz-tzYx3-g0YBZZNh6Bw731gQEFQub1SviLGoYg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2022 at 20:10, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 04.02.2022 12:43, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Mon, 31 Jan 2022 at 19:29, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 31.01.2022 14:37, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> A PM domain managed by genpd may support multiple idlestates. During
> >>> genpd_power_off() a genpd governor may be asked to select one of the
> >>> idlestates based upon the dev PM QoS constraints, for example.
> >>>
> >>> However, there is a problem with the behaviour around this in genpd. =
More
> >>> precisely, a parent-domain is allowed to be powered off, no matter of=
 what
> >>> idlestate that has been selected for the child-domain.
> >>>
> >>> So far, we have not received any reports about errors, possibly becau=
se
> >>> there might not be platform with this hierarchical configuration, yet=
.
> >>> Nevertheless, it seems reasonable to change the behaviour into preven=
ting
> >>> the parent-domain from being powered off, unless the deepest idlestat=
e has
> >>> been selected for the child-domain, so let's do that.
> >>>
> >>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>> ---
> >>>  drivers/base/power/domain.c | 18 ++++++++++++++++++
> >>>  1 file changed, 18 insertions(+)
> >>>
> >>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.=
c
> >>> index 5db704f02e71..7f97c5cabdc2 100644
> >>> --- a/drivers/base/power/domain.c
> >>> +++ b/drivers/base/power/domain.c
> >>> @@ -636,6 +636,17 @@ static int genpd_power_off(struct generic_pm_dom=
ain *genpd, bool one_dev_on,
> >>>                       atomic_read(&genpd->sd_count) > 0)
> >>>               return -EBUSY;
> >>>
> >>> +     /*
> >>> +      * The children must be in their deepest states to allow the pa=
rent to
> >>> +      * be powered off. Note that, there's no need for additional lo=
cking, as
> >>> +      * powering on a child, requires the parent's lock to be acquir=
ed first.
> >>> +      */
> >>> +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> >>> +             struct generic_pm_domain *child =3D link->child;
> >>> +             if (child->state_idx < child->state_count - 1)
> >>> +                     return -EBUSY;
> >>> +     }
> >>> +
> >>>       list_for_each_entry(pdd, &genpd->dev_list, list_node) {
> >>>               enum pm_qos_flags_status stat;
> >>>
> >>> @@ -1073,6 +1084,13 @@ static void genpd_sync_power_off(struct generi=
c_pm_domain *genpd, bool use_lock,
> >>>           || atomic_read(&genpd->sd_count) > 0)
> >>>               return;
> >>>
> >>> +     /* Check that the children are in their deepest state. */
> >>> +     list_for_each_entry(link, &genpd->parent_links, parent_node) {
> >>> +             struct generic_pm_domain *child =3D link->child;
> >>> +             if (child->state_idx < child->state_count - 1)
> >>> +                     return;
> >>> +     }
> >>> +
> >>>       /* Choose the deepest state when suspending */
> >>>       genpd->state_idx =3D genpd->state_count - 1;
> >>>       if (_genpd_power_off(genpd, false))
> >>
> >> Hello Ulf,
> >
> > Hi Dmitry,
> >
> >>
> >> Is this needed by a concrete SoC? It needs to be clarified in the comm=
it
> >> message, otherwise looks like this patch wasn't tested and it's unclea=
r
> >> whether this change is really needed.
> >
> > It's needed on a STMicro SoC that I have been working on. However,
> > it's difficult for me to test on that platform, as some SoC specific
> > pieces are missing upstream (the power domain deployment in
> > particular). Anyway, let me add some information about this in the
> > commit log for the next version.
> >
> > When it comes to testing, I am using a couple of local test dummy
> > drivers. One that manages devices that gets attached to a genpd,
> > mostly to execute runtime PM and dev PM QoS calls - and another that
> > manages the PM domains with genpd. I have been thinking of a way to
> > share these "tools" to let other people use them for testing too, but
> > I haven't just got to it yet.
> >
> > Besides the above, do you see any issues from Nvidia platforms point
> > of view with $subject patch?
>
> I've two main concerns:
>
> 1. This is a patch for something (STMicro SoC) that isn't fully
> supported by upstream kernel and it's not clear whether it will be ever
> supported at all.

The upstream work is ongoing, it's the stm32mp1 platform, which is
already supported upstream.

>
> 2. It's not clear why behaviour of a very specific SoC should be applied
> to all SoCs, especially given that the specific SoC itself isn't going
> to use to this feature right now. I guess it could be okay to put this
> behaviour into the core code until any other SoC will require a
> different behaviour, but the commit message doesn't clarify this.

The point with the commit message is to question the current default
behaviour. If we have a QoS constraint that causes the genpd governor
to select a shallow state for a child, it seems wrong to allow the
parent to be turned off, in my opinion.

If a platform with a PM domain hierarchy would need a different
behaviour from genpd, then we need to look into that, of course.
However, the current *uncontrolled* behaviour is most likely not going
to be suitable for any platform anyway.

>
> To my knowledge all NVIDIA Tegra SoCs are indifferent to this patch
> because they don't have such kind of dependency between power domains.

Great, thanks for confirming!

>
> In general, such changes usually are deferred from being upstreamed
> until there is a real user, otherwise there is a risk of cluttering the
> code with unused features. Do you have a time estimation in regards to
> when STMicro may start to benefit from this change?

The STMicro folkz are working on it right now, but I can't give you
any estimates for their work.

Moreover, I think the important point in this regard, is that the
$subject patch doesn't really hurt anything else, so then what's the
point of holding this back?

Kind regards
Uffe

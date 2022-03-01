Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73D04C8E36
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbiCAOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbiCAOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:50:12 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76BF340D4;
        Tue,  1 Mar 2022 06:49:30 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id e186so3525114ybc.7;
        Tue, 01 Mar 2022 06:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4U0iuFvcp7ujNscgy9HWinVgMJBUfxF78O2+/sgxqws=;
        b=CMUPJpGKvr3VRoQQvPQyzEsAzLDTj34vgFV5ES1+5Nu15WcUM+u0NDaq/u5h2wT5EF
         xA0SxExyPZ5A3+PfU5CznkcMfWJ34LGBbyWZjXf45jZF3BHFwDNznx9vGtJACZAoRCM+
         gpEoI17azZ4V/VgCOnobUjySB62ZOhRALn1ftTxgp+8FCIitE2kf0vkpFOEnYdlSwN1m
         P8JWKP0/aSxFVKqHEoxPEAalT+J13PmU4q1FPuCQ4gjpHePy8RJC/iYWJaOdj9UCbyXi
         zVB4bQ0JVb+9o/ZTHu93yddixmVHx3ASVka+DdA2TsuRCOYIni0OacRqlqDxnnPC2M4Y
         e0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4U0iuFvcp7ujNscgy9HWinVgMJBUfxF78O2+/sgxqws=;
        b=WLrT3IRamRY4BuEa8IM+ete7nlINSXKmK9Ylo7Hm0zQA+Pp/P/SnAmo+IwSkRrkPTD
         ftkhbOfhuNNeKTRkd8+tMJEKw2Kva7pSkDdECc0c+IfgXOkVyohigbxDWYgWEIZ4wHAh
         cAGuTwMabHVJ6MXayfX27L7Y034x6vAcuflvbqcPf7DB/NZbJRMVfTcuMlXR3jvLSCcP
         ugskGuXAGCyGebhAtxhlLt/rDwrtLqnN7vde606EY0W7gvKCshhsAxasrwD7F3deBlmC
         2EbHHf/HIEGEZ3HFxnXCm4Kc0GMlc4w/l9HGVfy+5yjRhXmA4CYPgJ0sGInP5HwaraG8
         bLiQ==
X-Gm-Message-State: AOAM53236XwvzlKNfRs7qHI27ZWbnaBs9lDTE7yfg5BzhX88YniZmkk1
        ISKIh2IW8qahLeu66nUKPNlLePXmJBYTDyn/U4A=
X-Google-Smtp-Source: ABdhPJyWo86SQbAsOm+jG2RskwR28LgIWL5XKSlmF2OvZVF3QyQ1JM2DddFW07h88pUDilmGCDkPhF5MsIjLBwEte8s=
X-Received: by 2002:a25:5145:0:b0:61d:ad99:6e5a with SMTP id
 f66-20020a255145000000b0061dad996e5amr23834211ybb.228.1646146169969; Tue, 01
 Mar 2022 06:49:29 -0800 (PST)
MIME-Version: 1.0
References: <20220228223642.1136229-1-pgwipeout@gmail.com> <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
 <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com>
 <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com> <CAMdYzYp=Po08pap9w5s8PV0mKfFZSPSOhM1U1AUdrRkYV-FRZQ@mail.gmail.com>
In-Reply-To: <CAMdYzYp=Po08pap9w5s8PV0mKfFZSPSOhM1U1AUdrRkYV-FRZQ@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 1 Mar 2022 09:49:19 -0500
Message-ID: <CAMdYzYoF6eO3mBZD=PtOPL3atdA3kH4UzV++6wB0pirW-7h_9A@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 7:46 AM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Tue, Mar 1, 2022 at 7:38 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2022-03-01 11:49, Peter Geis wrote:
> > > On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >>
> > >> On 2022-02-28 22:36, Peter Geis wrote:
> > >>> The dw_mmc-rockchip driver drops a large amound of logspam constantly
> > >>> when the cd-broken flag is enabled.
> > >>> Set the warning to be debug ratelimited in this case.
> > >>
> > >> Isn't this just papering over some fundamental problem with the clock?
> > >> If it's failing to set the expected rate for communicating with a card,
> > >> then presumably that's an issue for correct operation in general? The
> > >> fact that polling for a card makes a lot more of that communication
> > >> happen seems unrelated :/
> > >
> > > Good Morning,
> > >
> > > This only happens when a card is not inserted, so communication cannot happen.
> >
> > Well, I suppose there's a philosophical question in there about whether
> > shouting into the void counts as "communication", but AFAIR what the
> > polling function does is power up the controller, send a command, and
> > see if it gets a response.
> >
> > If the clock can't be set to the proper rate for low-speed discovery,
> > some or all cards may not be detected properly. Conversely if it is
> > already at a slow enough rate for discovery but can't be set higher once
> > a proper communication mode has been established, data transfer
> > performance will be terrible. Either way, it is not OK in general for
> > clk_set_rate() to fail, hence the warning. You have a clock driver problem.
>
> Alright, I'll look into this.
> It seems only extremely low clock speeds fail and I know rockchip
> chips have a hard time with extremely low clock rates.
> I'll trace out where the failure is happening.

Okay, I hope you can provide me a direction to go from here, because
it looks like it's doing exactly what it should do in this situation.
mmc core is requesting a rate (200k/100k).
clk core tries to find a parent to provide a clock that low and fails,
because the lowest possible parent is 750k.
clk_sdmmc(x) is listed as no-div, so it can't go any lower.

It seems to me that this error is sane, because other results of
einval you want to catch.
But einval in this case is fine, because
The thing that strikes me weird is currently clk_core thinks the
lowest possible freq here is 0, when in actuality it should be 750k,
am I correct here?
The mmc controller has an internal divider, so if my line of thinking
is correct here we should be more flexible here and request a rate
that's acceptable rather than just failing if it doesn't work.
But that's based on my limited understanding of how mmc core is
requesting this and what it expects in return.

>
> Thanks!
>
> >
> > Cheers,
> > Robin.
> >
> > > I found it while lighting off the SoQuartz module.
> > > As it is pin compatible with the RPi CM4, and the CM4 does not have a
> > > card detect line, sdmmc is non functional without cd-broken.
> > > This led to the fun spew when there wasn't a card inserted as this
> > > function is called every poll tick.
> > >
> > > Thanks,
> > > Peter
> > >
> > >>
> > >> Robin.
> > >>
> > >>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > >>> ---
> > >>>    drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
> > >>>    1 file changed, 7 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > >>> index 95d0ec0f5f3a..d0ebf0afa42a 100644
> > >>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > >>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > >>> @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > >>>                cclkin = ios->clock * RK3288_CLKGEN_DIV;
> > >>>
> > >>>        ret = clk_set_rate(host->ciu_clk, cclkin);
> > >>> -     if (ret)
> > >>> -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > >>> +     if (ret) {
> > >>> +             /* this screams when card detection is broken */
> > >>> +             if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> > >>> +                     dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
> > >>> +             else
> > >>> +                     dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > >>> +     }
> > >>>
> > >>>        bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> > >>>        if (bus_hz != host->bus_hz) {

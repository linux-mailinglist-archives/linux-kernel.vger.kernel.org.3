Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535154C8BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 13:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiCAMrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbiCAMrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 07:47:22 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBC898F75;
        Tue,  1 Mar 2022 04:46:41 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2d07ae0b1c4so143018507b3.11;
        Tue, 01 Mar 2022 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNYxb0caqFJflVe0lFiSRpMQbq4T7re3mr98tPyMuVo=;
        b=DORDBK+OJopp5XZDr6HfOMo/j0vGvwW4iR9plo/nRoxkVlxirWPLuod9CUyzZQEfYF
         QMp1jPOB0BiN9GnnNUvbfjIzr2UGb7gAt/OVaq3eeIIUPFMlqGmNXcHtmoPpz6YjqBhU
         v1HKfQiLle1O4AS5KSpGMAP4rD5pFcdVW7aP0+1LB80mPoedNOXL78WsxvkXUFTsAgFG
         kk5TqxfCnOq3wo9oxr3ZnNho3lyZtt/lIBRtgKCt7KkhoEZPxhQVYwrn9RYAyFsTOxfx
         RMwJ27OFEewB1EF02ls7lRGfvPvOoG48KpJjL8dBgd/6gaBpqb2rzPGDiDrQw1YTwH2E
         YGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNYxb0caqFJflVe0lFiSRpMQbq4T7re3mr98tPyMuVo=;
        b=u8IqJm/TuJU7QEcR/HN/Eq3k5Ci46kYyVHkb09iLWTJmCRf7srNYqn2Rxds8P5mmM0
         rma5uuGoylu3v0H4Nd5SR8fmPOY+OEXaMzYjjCCzhCD2XTEjyMm61DvaxG2coDRxFpkS
         OxcUrDdUYdt9aHrrGYcrvbON7dzsmBbtPbvgy6dhYeEQuee8okfdxKOoIX9U6btAqFKi
         ttGO/rFswn1QzIbPkwk8L3sl3L852tudxKpLlSxy2RAQZXE/nrWun3/wSAoCBl034IpG
         UDOCvVONRupLpuJFDWrXyZrrYcpD9g1p0q8NURwoAspfKcG1Y8f3igBgvBoOveHOpRRQ
         34Gg==
X-Gm-Message-State: AOAM531f+8BQAiXDgFuglR4SnDtLdcP1NjqW5GiE0OCJPT0yh7FGWUE3
        il9sBkqnE0jghyxoVTxWryp2K6gogVsQZubnIKk=
X-Google-Smtp-Source: ABdhPJxf5FpLziaFlmJ5Pr6hxG+fTN8jkthHfFVs81qUqpxpu+9OJnZ6uScFADTXcxf0WK0pd0r+PCOvNd9GvTdLEaI=
X-Received: by 2002:a81:3807:0:b0:2d8:2ed:1d19 with SMTP id
 f7-20020a813807000000b002d802ed1d19mr24305957ywa.519.1646138800565; Tue, 01
 Mar 2022 04:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20220228223642.1136229-1-pgwipeout@gmail.com> <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
 <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com> <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com>
In-Reply-To: <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 1 Mar 2022 07:46:29 -0500
Message-ID: <CAMdYzYp=Po08pap9w5s8PV0mKfFZSPSOhM1U1AUdrRkYV-FRZQ@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 7:38 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-03-01 11:49, Peter Geis wrote:
> > On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2022-02-28 22:36, Peter Geis wrote:
> >>> The dw_mmc-rockchip driver drops a large amound of logspam constantly
> >>> when the cd-broken flag is enabled.
> >>> Set the warning to be debug ratelimited in this case.
> >>
> >> Isn't this just papering over some fundamental problem with the clock?
> >> If it's failing to set the expected rate for communicating with a card,
> >> then presumably that's an issue for correct operation in general? The
> >> fact that polling for a card makes a lot more of that communication
> >> happen seems unrelated :/
> >
> > Good Morning,
> >
> > This only happens when a card is not inserted, so communication cannot happen.
>
> Well, I suppose there's a philosophical question in there about whether
> shouting into the void counts as "communication", but AFAIR what the
> polling function does is power up the controller, send a command, and
> see if it gets a response.
>
> If the clock can't be set to the proper rate for low-speed discovery,
> some or all cards may not be detected properly. Conversely if it is
> already at a slow enough rate for discovery but can't be set higher once
> a proper communication mode has been established, data transfer
> performance will be terrible. Either way, it is not OK in general for
> clk_set_rate() to fail, hence the warning. You have a clock driver problem.

Alright, I'll look into this.
It seems only extremely low clock speeds fail and I know rockchip
chips have a hard time with extremely low clock rates.
I'll trace out where the failure is happening.

Thanks!

>
> Cheers,
> Robin.
>
> > I found it while lighting off the SoQuartz module.
> > As it is pin compatible with the RPi CM4, and the CM4 does not have a
> > card detect line, sdmmc is non functional without cd-broken.
> > This led to the fun spew when there wasn't a card inserted as this
> > function is called every poll tick.
> >
> > Thanks,
> > Peter
> >
> >>
> >> Robin.
> >>
> >>> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> >>> ---
> >>>    drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
> >>>    1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> >>> index 95d0ec0f5f3a..d0ebf0afa42a 100644
> >>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> >>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> >>> @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >>>                cclkin = ios->clock * RK3288_CLKGEN_DIV;
> >>>
> >>>        ret = clk_set_rate(host->ciu_clk, cclkin);
> >>> -     if (ret)
> >>> -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> >>> +     if (ret) {
> >>> +             /* this screams when card detection is broken */
> >>> +             if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> >>> +                     dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
> >>> +             else
> >>> +                     dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> >>> +     }
> >>>
> >>>        bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> >>>        if (bus_hz != host->bus_hz) {

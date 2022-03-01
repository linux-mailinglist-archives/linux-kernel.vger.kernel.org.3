Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124A84C8B19
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 12:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiCALuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 06:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCALuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 06:50:13 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DFF5BE50;
        Tue,  1 Mar 2022 03:49:31 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id w16so755204ybi.12;
        Tue, 01 Mar 2022 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJxq8hFGZ7YgUPO3gAshsHAMHYt7CVLZZRFS388ANNA=;
        b=V6AVmqeZy1f/bTbL+s+DaCq0O/FOGV/CDQvTklr01/wY5ZrZUroJIa+XfUinfbjw4/
         XeZO+f9uCJ7TMIspvtknhohs2+2HYoP5cvUcjWdxHLKI8smpO1DXKcgbASWzOsSDcZYg
         PS0mGbWLvWNFIVaLBT0sSGSujHx365wu0Ar86+m1F6cvG5s6FZsnBHs6blRmb8GXdMaE
         G0G3fvICzeMgST8T+ZNlFgRcsxJX2fljF7JMqQ2xRMiKDK/dgwDCprHzmh16Jh2pWurG
         sGI2FXp/lDXpnqHxdzaVu+/01dxTAPMyTiRYx3Wuh3jbKcBFuwxppjo9KFGU6bwtLEXS
         5MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJxq8hFGZ7YgUPO3gAshsHAMHYt7CVLZZRFS388ANNA=;
        b=3muaUX1PrStMqauH4yHNq1bZB6vMKB+MtaoH0IMRNm4Z97L4De/h8ofZCRtkcHGuTb
         GAOsKMkr99S9znnTtHXegF9aiOJ4lX79SwuiK245FaqkUtEbzUvHG7Uj4oBixBWMw17i
         eDOU7gpSAk26GRo05lCtpnx2mTr2OigYNURsHhWYZJNUa8MJnFawpRqq6widVc7nk0fb
         00rGMPxeTPHLvtGWBr18klSvPh4h5rCklGXfoWE8M+bVirJbGbE8cOZwswzcrgTwZsLT
         +D1Lss+UAeDThWVzO8iG8ezxIk18C36AgzWpn3SfDR98s2bFBk3y1AC7lWUGd4CFW+PK
         S8LQ==
X-Gm-Message-State: AOAM531xpSDvdI3XXVxflEUdO2z5z24VvlwgoZVWqnO2Krw+q88MpGG0
        5jesCRuN8RJ+E+UyAIKfC2fNSlurDLtz/u9Q0vk=
X-Google-Smtp-Source: ABdhPJw7T5LznYqNo8yoWuelEscL8WQZsOdXOT5tE/hEZodPnEUKYv2ihEe5yfueKVrP+yKitWhMA5wCI58gim5O+6w=
X-Received: by 2002:a05:6902:143:b0:628:7cf1:f2a9 with SMTP id
 p3-20020a056902014300b006287cf1f2a9mr1723551ybh.51.1646135371065; Tue, 01 Mar
 2022 03:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20220228223642.1136229-1-pgwipeout@gmail.com> <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
In-Reply-To: <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 1 Mar 2022 06:49:20 -0500
Message-ID: <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com>
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

On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2022-02-28 22:36, Peter Geis wrote:
> > The dw_mmc-rockchip driver drops a large amound of logspam constantly
> > when the cd-broken flag is enabled.
> > Set the warning to be debug ratelimited in this case.
>
> Isn't this just papering over some fundamental problem with the clock?
> If it's failing to set the expected rate for communicating with a card,
> then presumably that's an issue for correct operation in general? The
> fact that polling for a card makes a lot more of that communication
> happen seems unrelated :/

Good Morning,

This only happens when a card is not inserted, so communication cannot happen.
I found it while lighting off the SoQuartz module.
As it is pin compatible with the RPi CM4, and the CM4 does not have a
card detect line, sdmmc is non functional without cd-broken.
This led to the fun spew when there wasn't a card inserted as this
function is called every poll tick.

Thanks,
Peter

>
> Robin.
>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >   drivers/mmc/host/dw_mmc-rockchip.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> > index 95d0ec0f5f3a..d0ebf0afa42a 100644
> > --- a/drivers/mmc/host/dw_mmc-rockchip.c
> > +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> > @@ -50,8 +50,13 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> >               cclkin = ios->clock * RK3288_CLKGEN_DIV;
> >
> >       ret = clk_set_rate(host->ciu_clk, cclkin);
> > -     if (ret)
> > -             dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > +     if (ret) {
> > +             /* this screams when card detection is broken */
> > +             if (host->slot->mmc->caps & MMC_CAP_NEEDS_POLL)
> > +                     dev_dbg_ratelimited(host->dev, "failed to set rate %uHz\n", ios->clock);
> > +             else
> > +                     dev_warn(host->dev, "failed to set rate %uHz\n", ios->clock);
> > +     }
> >
> >       bus_hz = clk_get_rate(host->ciu_clk) / RK3288_CLKGEN_DIV;
> >       if (bus_hz != host->bus_hz) {

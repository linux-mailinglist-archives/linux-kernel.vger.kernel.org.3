Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86514CA214
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 11:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240829AbiCBKYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 05:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiCBKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 05:24:08 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21918AC91C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 02:23:22 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l12so1530750ljh.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tjY3EnNamNFx1y3oddYNE+8HtUaH9EZY+luGZxUhsM=;
        b=mnACc6XQaE5xdOpPVbWeU0j4lqYfqsAhH0pnsiQ4s+1ZtVjntpL/OwJLMrmI7Sytrc
         3tRtsEdE5mIug5N/dLj9wICfoEUbgNXaTnVTJzTbN/TkNBEuoYsBjmpPXQhSJ/Zw98oK
         eakd9g9hwgta4vGWdNpsV6UQ/1ds7PYgJFpX8Ixx4BsbfdOrslso9neJdZOh8o+Zx0OP
         hqtdM8INXeh0EMeBV7tNYMtDgmHyl8xBrjCR2OJqPBJaeUv9a76kEZQ5oae3z5q9mD8M
         oPrJbl/dzH5LDyF/lhbY1pMfpYZ6RT1A7fixM7PSNAHPA76l8HsURnbmHIjlGSJGN6Tt
         K8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tjY3EnNamNFx1y3oddYNE+8HtUaH9EZY+luGZxUhsM=;
        b=Yrka9d+Hr0WfUePV/lmSWgvfyamEXglTKuBAuJ2zas7p4Pu3M1biHHw0Y/7Iqq94B1
         quM3AgS1XoZBH8CUur6uP3uwPIUL7wkuL/Jaud5Bkh18692+2Xj4hd5C+5IOBQypO6tK
         A/OTN0K/VRqkLLpJIIdmcbvPcF1ejxV+kXektm8bFrFE+Zn0Pad5tfOYwtWOyc5OcUty
         sc6DmEBh3T45RGdqI3BrP4eFWtWfKQLsOzbBN2797IsRscZgUlUr54DLLVg3GvjGNcw7
         aS4z0njSx4uP4hWAxd9/Kz5wi7Z95i2s8rZ2GJSeZCNYRxGy/wFTcsdmU6cLGe7h+B3c
         PWtw==
X-Gm-Message-State: AOAM5332O4DiHoSX/wFCulaYldLE8L+MBymHO4RtF6s/XKsRmt1UbXIZ
        eqDaDTe7g+9WI5NiXsk4DDn9u+tNDvZCvwL1jrOYZQ==
X-Google-Smtp-Source: ABdhPJx6nuXDD4MZhP/3f28Fey4JB+n8W3ScZ0gwTpP8FwMhxThtjLQlKJCOe42eXVCgQa5QoPE3HwhN4Gy4WpG9dkU=
X-Received: by 2002:a05:651c:201b:b0:246:34b5:155e with SMTP id
 s27-20020a05651c201b00b0024634b5155emr18803688ljo.273.1646216600403; Wed, 02
 Mar 2022 02:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20220228223642.1136229-1-pgwipeout@gmail.com> <c12e74b7-0bef-ac7a-20c1-2a17ddd050dd@arm.com>
 <CAMdYzYq0A4FitRGe49fxvjbwLUCi_KGwCtfz7pmayt_dK=r32w@mail.gmail.com>
 <54b24f3d-3762-abbd-5ac4-dc5728f2fe4e@arm.com> <CAMdYzYp=Po08pap9w5s8PV0mKfFZSPSOhM1U1AUdrRkYV-FRZQ@mail.gmail.com>
 <CAMdYzYoF6eO3mBZD=PtOPL3atdA3kH4UzV++6wB0pirW-7h_9A@mail.gmail.com>
In-Reply-To: <CAMdYzYoF6eO3mBZD=PtOPL3atdA3kH4UzV++6wB0pirW-7h_9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 11:22:44 +0100
Message-ID: <CAPDyKFqYWK9WnzHsM1vwnUBRM1YofjMd9+9-MPZvvs=1K=51bg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: dw-mmc-rockchip: avoid logspam when cd-broken
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 at 15:49, Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Tue, Mar 1, 2022 at 7:46 AM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Tue, Mar 1, 2022 at 7:38 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2022-03-01 11:49, Peter Geis wrote:
> > > > On Tue, Mar 1, 2022 at 6:23 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >>
> > > >> On 2022-02-28 22:36, Peter Geis wrote:
> > > >>> The dw_mmc-rockchip driver drops a large amound of logspam constantly
> > > >>> when the cd-broken flag is enabled.
> > > >>> Set the warning to be debug ratelimited in this case.
> > > >>
> > > >> Isn't this just papering over some fundamental problem with the clock?
> > > >> If it's failing to set the expected rate for communicating with a card,
> > > >> then presumably that's an issue for correct operation in general? The
> > > >> fact that polling for a card makes a lot more of that communication
> > > >> happen seems unrelated :/
> > > >
> > > > Good Morning,
> > > >
> > > > This only happens when a card is not inserted, so communication cannot happen.
> > >
> > > Well, I suppose there's a philosophical question in there about whether
> > > shouting into the void counts as "communication", but AFAIR what the
> > > polling function does is power up the controller, send a command, and
> > > see if it gets a response.
> > >
> > > If the clock can't be set to the proper rate for low-speed discovery,
> > > some or all cards may not be detected properly. Conversely if it is
> > > already at a slow enough rate for discovery but can't be set higher once
> > > a proper communication mode has been established, data transfer
> > > performance will be terrible. Either way, it is not OK in general for
> > > clk_set_rate() to fail, hence the warning. You have a clock driver problem.
> >
> > Alright, I'll look into this.
> > It seems only extremely low clock speeds fail and I know rockchip
> > chips have a hard time with extremely low clock rates.
> > I'll trace out where the failure is happening.
>
> Okay, I hope you can provide me a direction to go from here, because
> it looks like it's doing exactly what it should do in this situation.
> mmc core is requesting a rate (200k/100k).
> clk core tries to find a parent to provide a clock that low and fails,
> because the lowest possible parent is 750k.
> clk_sdmmc(x) is listed as no-div, so it can't go any lower.
>
> It seems to me that this error is sane, because other results of
> einval you want to catch.
> But einval in this case is fine, because
> The thing that strikes me weird is currently clk_core thinks the
> lowest possible freq here is 0, when in actuality it should be 750k,
> am I correct here?
> The mmc controller has an internal divider, so if my line of thinking
> is correct here we should be more flexible here and request a rate
> that's acceptable rather than just failing if it doesn't work.
> But that's based on my limited understanding of how mmc core is
> requesting this and what it expects in return.

The important point from the eMMC/SD/SDIO spec point of view, is that
the initialization of the cards starts at a maximum of 400KHz for the
bus interface clock.

In many cases, that requires a combination of the provided source
clock for the mmc controller to be decreased with some kind of an
internal divider managed by the controller itself.

Moreover, the mmc host driver shall set mmc->f_min in its
corresponding struct mmc_host during ->probe(), to inform the core
about its lowest possible rate that can be set - and this must not be
higher than 400KHz.

Hope that clarifies how things should work.

[...]

Kind regards
Uffe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C378582841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiG0OJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiG0OJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:09:35 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343ED3B953
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:09:34 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m9so19894168ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=QtFRrHm4vMqcg+bk4tWbQr1CbqO5/aviSsSa28f21tc=;
        b=d8fxrLFnDtTqO02Phnf6U+WdtMr5FTtXzSl7ipt4oli55Pv7HQQy7jwtjzdkR3NHoO
         r+l2EvhuSBjmLFvosAEUE2S1RhWSgdDF1k6pJNRlyCSdImbttMNcbEvjSl0fqEX/1gqC
         AnxfJKP9S1I++lCPHC4C3f6kYQHE8oekZmucA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=QtFRrHm4vMqcg+bk4tWbQr1CbqO5/aviSsSa28f21tc=;
        b=StMnUAKkLrmuRW45RLsUqZlGeobssP6FOK9Z+tb35PuezFtw3Vdon3Z+dQS3QUOej7
         h0edI0OeIQHwECU5Qpm1sSxsiN0WaLins+Z8qneFNupQInC0CMVSntXpALsQ2FVmuHyA
         hLTZgFHovEjQdTr8mc+bV8IGRMb5DSsriFwQSa5/fzi8CIHprKC6UNOTQkj8YVMJTTmq
         6lQns3e57EP6yDgZzFhSlvUnH3gIZQahtinHAGRuIwV9RzYfRKVR8ej5jgYJhnE9A9fu
         ROjcegwGqpm5OwRKiOHWBnq0n6NgMEHXt/odeu8pd1HAMhS9pZlbD2a2K9LWrn87A+xe
         rCIQ==
X-Gm-Message-State: AJIora+BkCW+saG6KVyS3gqdSgrC/dC5AtYaa5VuhbWZKMzmOBqTIFNQ
        JvPwHteDXVVRNq5xWPqVKB6piTo+CPKOIPtQ
X-Google-Smtp-Source: AGRyM1shDrWb84JwVvRme+KlXq7dYkDNdDmK7XH+By9eNEuOxOdw5pvC7lsECbZVxmnITPzZ3/kWdw==
X-Received: by 2002:a2e:9cd1:0:b0:25d:f617:f531 with SMTP id g17-20020a2e9cd1000000b0025df617f531mr7266433ljj.380.1658930972300;
        Wed, 27 Jul 2022 07:09:32 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id f19-20020a056512361300b00480fdbc1b01sm921964lfs.64.2022.07.27.07.09.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 07:09:31 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id m12so26199333lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:09:31 -0700 (PDT)
X-Received: by 2002:a05:6000:178f:b0:21e:98ee:f1e6 with SMTP id
 e15-20020a056000178f00b0021e98eef1e6mr6847820wrg.405.1658930960744; Wed, 27
 Jul 2022 07:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220725174810.1.If1f94fbbdb7c1d0fb3961de61483a851ad1971a7@changeid>
 <661fa514-cd37-e062-3294-c844b7f0b894@quicinc.com> <CAD=FV=UHhfLn+S8F60EPoC0ip6YzmrihfTz=KmmauXHCxof2QQ@mail.gmail.com>
 <CAA8EJppHr7GjcvqRqXAgjw9mf+ObzCi58-VYSdO_JMfk1-4ifA@mail.gmail.com>
In-Reply-To: <CAA8EJppHr7GjcvqRqXAgjw9mf+ObzCi58-VYSdO_JMfk1-4ifA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Jul 2022 07:09:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WEK-CrFjSrs7ADfkQmoz=xOmppzyZtsEQGv0ga83i3CQ@mail.gmail.com>
Message-ID: <CAD=FV=WEK-CrFjSrs7ADfkQmoz=xOmppzyZtsEQGv0ga83i3CQ@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH] drm/msm/dsi: Don't set a load before
 disabling a regulator
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sean Paul <sean@poorly.run>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 6:59 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 27 Jul 2022 at 16:57, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Tue, Jul 26, 2022 at 4:53 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >
> > > On 7/25/2022 5:49 PM, Douglas Anderson wrote:
> > > > As of commit 5451781dadf8 ("regulator: core: Only count load for
> > > > enabled consumers"), a load isn't counted for a disabled
> > > > regulator. That means all the code in the DSI driver to specify and
> > > > set loads before disabling a regulator is not actually doing anything
> > > > useful. Let's remove it.
> > > >
> > > > It should be noted that all of the loads set that were being specified
> > > > were pointless noise anyway. The only use for this number is to pick
> > > > between low power and high power modes of regulators. Regulators
> > > > appear to do this changeover at loads on the order of 10000 uA. You
> > > > would a lot of clients of the same rail for that 100 uA number to
> > >
> > > I guess you meant "you would need a lot of clients"
> >
> > Yeah, sorry. :( I'll fix it up if I need a v3.
> >
> >
> > > > @@ -259,15 +259,7 @@ static inline struct msm_dsi_host *to_msm_dsi_host(struct mipi_dsi_host *host)
> > > >   static void dsi_host_regulator_disable(struct msm_dsi_host *msm_host)
> > > >   {
> > > It seems like now we can drop this function dsi_host_regulator_disable()
> > > entirely and just call regulator_bulk_disable() ?
> >
> > Sure, if you want. One could still argue that it provides a tiny bit
> > of abstraction and avoids the caller from having to know where to find
> > the number of regulators and all that, but I can go either way. Is
> > this worth a v3, do you think? If so, I might tack it on at the end of
> > the series.
>
> I'd say, drop it. Having extra single-call wrappers doesn't seem to add a lot.

Sounds good. I'll wait a little bit of time for feedback on the larger
series and then send a v3, probably next week.

-Doug

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3214C03BE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiBVVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbiBVVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:25:49 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B698F10F20A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:25:22 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bq11so18787654edb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncH9c7SiYmN6itdECS9f8vr7OT3dx9aRl+ruQf7+yUg=;
        b=bie/EqstQq7cMH+SvIyYScs9hMbdl5FmT1j31NstckurYsN72clBvZSAs4si7yh9wD
         r/miD7WgoTgKOsFCyHBeU2c8gQTdgqSJy1y26X892UgDwNWsMNYp9/ub7c2lCI6GZ3co
         KlMSphSYJYjvpWZcfeXWn0GgJ+1a1Y3QNMTE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncH9c7SiYmN6itdECS9f8vr7OT3dx9aRl+ruQf7+yUg=;
        b=6o7tb+hbFaRzySNGMcN2+c6wB93NE9kfzEKp8oSz2iuCJEQNHQApNr/q62owJo0wBn
         c8BtfNoJuvj/BUE1lPNIG+AL/rgipcnp8QD45Hgcqn2fniwMVnTBwbRTDcLa2bd09Plh
         X7BheSegFv5yTN2ZtMfY6T68veg5ETz81eq8OWx6MEozvS4uBhNtxD/OWuhmASOKVwv8
         te2qPvm8gqKUHM0FdwHRD5SRzEkM+FUrnBBY9ExZxSROt9RNCcgCT38GA5J+rXb9xRRL
         KCzWg61T+JVzehIzzLsjaMSiayI7BmMHOVh0XBVJ4eyAwO9NcwV5tc500HVrBaX8idfu
         OwVg==
X-Gm-Message-State: AOAM533y20s4QBktS4aQ0am4iO5hYrjUbIUl8Fjsz5e9j/vxf5TOHH9A
        QVpzXcF886X8UeUowT49j8BbH+I4doYUIhuGsRI=
X-Google-Smtp-Source: ABdhPJzsMkl6uVuHBAYV703O8UPRN0VONEUcZpKatA7PIEnRP35tcuFpFV8ah6sw7Gg+xS3CJKjS3w==
X-Received: by 2002:a50:fd16:0:b0:410:82ea:7911 with SMTP id i22-20020a50fd16000000b0041082ea7911mr28040178eds.315.1645565121067;
        Tue, 22 Feb 2022 13:25:21 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id u27sm6614694ejc.220.2022.02.22.13.25.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 13:25:19 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso2846455wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:25:19 -0800 (PST)
X-Received: by 2002:a05:600c:228e:b0:37c:2eef:7bf with SMTP id
 14-20020a05600c228e00b0037c2eef07bfmr4792688wmf.73.1645565118969; Tue, 22 Feb
 2022 13:25:18 -0800 (PST)
MIME-Version: 1.0
References: <1645449126-17718-1-git-send-email-quic_vpolimer@quicinc.com> <CAE-0n507XcYRz4=Uw-K37kPsLRqi_gN2L9y1wcu_X-UJP+6ySg@mail.gmail.com>
In-Reply-To: <CAE-0n507XcYRz4=Uw-K37kPsLRqi_gN2L9y1wcu_X-UJP+6ySg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 13:25:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WvstZkDJcHJPAT0aez3X=uSKzDX0paQRHYD4DEktkMEQ@mail.gmail.com>
Message-ID: <CAD=FV=WvstZkDJcHJPAT0aez3X=uSKzDX0paQRHYD4DEktkMEQ@mail.gmail.com>
Subject: Re: [v1] arm64/dts/qcom/sc7280: update mdp clk to max supported value
 to support higher refresh rates
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_kalyant@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 12:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Vinod Polimera (2022-02-21 05:12:06)
> > Panels with higher refresh rate will need mdp clk above 300Mhz.
> > Select max frequency for mdp clock during bootup, dpu driver will
> > scale down the clock as per usecase when first update from the framework is received.
> >
> > Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
>
> Please add a Fixes tag.
>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index baf1653..7af96fc 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -2895,7 +2895,7 @@
> >                                 assigned-clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>,
> >                                                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
> >                                                 <&dispcc DISP_CC_MDSS_AHB_CLK>;
> > -                               assigned-clock-rates = <300000000>,
> > +                               assigned-clock-rates = <506666667>,
>
> Why not simply remove the clock assignment and set the rate based on the
> OPP when the driver probes?

I was curious so I dug. It turns out that it _is_ using the OPP. It's
just that the kernel driver currently assumes that the initial rate is
the max rate. :-P You can actually see in msm_dss_parse_clock() that
it walks through each of its clocks at boot and records the boot rate
and stashes it as the "max_rate". That's not a scheme I've seen done
commonly, so if nothing else it deserves a comment in the commit
message.

One other note is that I think there are _two_ places in the dtsi that
are setting this same clock rate, right? The parent node `mdss`, which
you're not touching, and the child `mdss_mdp`, which you are touching.
Seems like you should just do it in one place. If it needs to be done
by the parent then the child could just assume that the clock has
already been set by the parent.

-Doug

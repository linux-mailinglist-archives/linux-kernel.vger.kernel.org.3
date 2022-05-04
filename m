Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C30F51AC8C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376800AbiEDSTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376796AbiEDSSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:18:45 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E948BF2F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:39:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id m23so2606095ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29ruKVriy2g3lqz65t1H7qVG6banp+GDlpPZFrL2iUc=;
        b=gF9qfuK094RIWE4ckvIjXHamdtau6Old+ZMLvhHQGM/jmWVdnoEtdDj9wuwAQdCn5h
         EN/s6w0wLYchhFEQ9Fd9x0JOQ1TjEockG/YeQyz2oJ1YAbjyXrsLW0YOSe65+7bfkYlF
         /bM15nq7BKavjFDEnmkc5+uKpYArSpbky/rXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29ruKVriy2g3lqz65t1H7qVG6banp+GDlpPZFrL2iUc=;
        b=s7O6vBih68eRNx5UdV2FvhhU2rdKDkhLw+g+GSlDGBkx6/1rQNk7e1iwHKGXiC3NNo
         A/F1PGV+Hb9MF/zM8jT4lIxBp/6riPhC+nvzM1Uh+mxnxUE8/WpipB0huiso0AyBAbCf
         fzk2DwR5HFkx1jxn1jpM60cvqMiGpRQavTzCIqAAq1Ru1Q5ZQgZUi5iuqJG3iQTz+F6F
         DQXqFvlMzRVCGWwy0RUjQaNOExPNhCgE5+1/LfSmQ0sdldV6MVTCcV1C3YbUCGT01A8a
         CdHTgDojf6y+T99gODSNsuDfRGYJn4QppWXdVaAMgIJssQPAfz4npemzfMNDFyqW9vM9
         mqBw==
X-Gm-Message-State: AOAM532zOvQFaE7Jg39ujIIMB7PvjfaIBhdCrz39mXjMrw3EqBRloeri
        u8Hvd9+2xvFY718mrtAByhh+5iSj2fsdaL9ptLk=
X-Google-Smtp-Source: ABdhPJxh4lr3Ab748GfRHzIIO/vfCGjfyknx2tAMdCrvFo1rff/EIW/tuSNtxtKVA9e6ESU0sycPXQ==
X-Received: by 2002:a05:651c:2cd:b0:24f:1731:ee09 with SMTP id f13-20020a05651c02cd00b0024f1731ee09mr12709798ljo.253.1651685956441;
        Wed, 04 May 2022 10:39:16 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r1-20020a056512102100b0047255d21171sm1266345lfr.160.2022.05.04.10.39.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 10:39:16 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id s27so2587618ljd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:39:16 -0700 (PDT)
X-Received: by 2002:a05:6000:c7:b0:20a:d8c1:d044 with SMTP id
 q7-20020a05600000c700b0020ad8c1d044mr17464094wrx.422.1651685538029; Wed, 04
 May 2022 10:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
In-Reply-To: <20220426124053.v2.1.Iedd71976a78d53c301ce0134832de95a989c9195@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 May 2022 10:32:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UUTVZPzJvC-S6=p_xRpoW+7EtupDYobgu7aQPWvR6XmA@mail.gmail.com>
Message-ID: <CAD=FV=UUTVZPzJvC-S6=p_xRpoW+7EtupDYobgu7aQPWvR6XmA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: eDP for herobrine boards
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,,

On Tue, Apr 26, 2022 at 12:41 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> Add eDP support to herobrine boards, splitting up amongst the
> different files as makes sense. Rationale for the current split of
> things:
> * The eDP connector itself is on qcard. However, not all devices with
>   a qcard will use an eDP panel. Some might use MIPI and, presumably,
>   someone could build a device with qcard that had no display at all.
> * The qcard provides a PWM for backlight that goes to the eDP
>   connector. This PWM is also provided to the board and it's expected
>   that it would be used as the backlight PWM even for herobrine
>   devices with MIPI displays.
> * It's currently assumed that all herobrine boards will have some sort
>   of display, either MIPI or eDP (but not both).
> * We will assume herobrine-rev1 has eDP. The schematics allow for a
>   MIPI panel to be hooked up but, aside from some testing, nobody is
>   doing this and most boards don't have all the parts stuffed for
>   it. The two panels would also share a PWM for backlight, which is
>   weird.
> * herobrine-villager and herobrine-hoglin (crd) also have eDP.
> * herobrine-hoglin (crd) has slightly different regulator setup for
>   the backlight. It's expected that this is unique to this board. See
>   comments in the dts file.
> * There are some regulators that are defined in the qcard schematic
>   but provided by the board like "vreg_edp_bl" and
>   "vreg_edp_3p3". While we could put references to these regulators
>   straight in the qcard.dtsi file, this would force someone using
>   qcard that didn't provide those regulators to provide a dummy or do
>   an ugly /delete-node/. Instead, we'll add references in
>   herobrine.dtsi.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch most directly depends on ("arm64: dts: qcom: pm8350c: Add
> pwm support") [1] and it won't even compile without that. To be
> functional, of course, we also need the driver support for the PWM to
> land.
>
> In order for this patch to function we also need Sankeerth's eDP
> series [2] to land.
>
> To be schema happy, this patch also relies on my patch to add
> regulators into the schema for the PHY an the eDP controller [3].
> Several other device tree files reference these supplies without being
> in the schema, though, so we'll have to decide whether to block on
> those bindings landing. It does sound as if the regulator names may
> not be exactly correct right now, though. :(
>
> In theory, I could break this patch up into separate patches adding
> the basic support to the qcard, then to herobrine.dtsi, and then one
> patch each for herobrine-r1, villager, and crd. Doing so didn't seem
> to make sense to me--I think it's easier to make sense of the change
> as one patch. However, if someone feels strongly that it should be
> broken up I'm happy to do so.
>
> I've managed to get the display on my herobrine-rev1 up and running on
> today's linuxnext (next-20220422) with this series. For whatever
> reason the eDP PHY wouldn't probe unless I hacked `fw_devlink=off` in
> the config. I don't believe that problem is related to this patch,
> though.
>
> [1] https://lore.kernel.org/r/1645509309-16142-4-git-send-email-quic_c_skakit@quicinc.com
> [2] https://lore.kernel.org/r/1650887072-16652-1-git-send-email-quic_sbillaka@quicinc.com/
> [3] https://lore.kernel.org/r/20220425210643.2420919-1-dianders@chromium.org
>
> Changes in v2:
> - Commit message and comment cleanups from Stephen.
>
>  .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 40 ++++++++++++++
>  .../qcom/sc7280-herobrine-herobrine-r1.dts    |  8 +++
>  .../dts/qcom/sc7280-herobrine-villager-r0.dts |  8 +++
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 24 +++++++++
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    | 54 +++++++++++++++++++
>  5 files changed, 134 insertions(+)

Since you're landing patches, I'm curious what you think about this
one. I believe that the dependencies have all landed except for [3],
but we the drivers are already expecting these regulators and other
dts files provide them despite the fact that they're not in the
bindings.

Thanks!

-Doug

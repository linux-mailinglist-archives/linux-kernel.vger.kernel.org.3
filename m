Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330FD50B974
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448311AbiDVOG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiDVOG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:06:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AB5A165
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:04:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i27so16570308ejd.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+w/lFm+gTC9eW9lBYMMnUgARDTN948ashX6/88jSSk=;
        b=ghMiyWVM5DKXsssoViKphQIWceZP/fjd3ty8ZXt7WVjJwP3cN3O9IT7qFAE/Jj/Qdw
         cR9jYLzNJMz5r3gE7L5BLvMguTvA0g7jVmzMc9rN0pTwKYDEQo4/M8O2xgTv2G8CrHaT
         U2LEsQ4bPR/y/gfgsnT9qyWh/kRicE14xKEec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+w/lFm+gTC9eW9lBYMMnUgARDTN948ashX6/88jSSk=;
        b=GgFxeG0Q5NKUluG5zr13KWH6KSPKNZy5nX5uZUfnym+9/vjSjgKwsLdBK/siyG0GRW
         rB1zISYVT3/TopD3Mac3I/WbxEVfCoUZV9VmFJkGoAPa90FH4MWSqWiUM6nZYdFg6V55
         tGOwDtHnKtJDp8c/o6APBkl9oLZVadljM4DgZw8Fq5bBmlRU2zLrBKIIPXsAMQq1sLh7
         +XRuncwW2G9m2cH8e9XKO9rMES59It/4+s2HumhDmg22aRjV5VAofauG3ZLPnjZ9ludn
         Y+MX25Zo7rPjrHOFu7S/1JrZXtFPGWCyfhR8dLMTAUmfftcKDj0QtLqU/MuBvS0sbnDX
         gN8Q==
X-Gm-Message-State: AOAM532cCv+ckCgBaRzk7AGbo06Yr2ArQPLCmKeIxmvS58MzDSKyV9c8
        bVxVwF3EpDUNrlP6krkqdqERY8UhWnwnJnlJbKQ=
X-Google-Smtp-Source: ABdhPJxyviR3lD0VhENfDB/mM7Xw3acDJkKzvaFUOOzHZEt8sqxXd3jJ2oDTKCZnTNss5eQiKnXJmA==
X-Received: by 2002:a17:906:730c:b0:6f0:f69:b2e with SMTP id di12-20020a170906730c00b006f00f690b2emr4285276ejc.276.1650636232627;
        Fri, 22 Apr 2022 07:03:52 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id bn19-20020a170906c0d300b006efe245d03csm779478ejb.151.2022.04.22.07.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:03:49 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so5431806wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:03:49 -0700 (PDT)
X-Received: by 2002:a05:600c:502b:b0:38f:f7c6:3609 with SMTP id
 n43-20020a05600c502b00b0038ff7c63609mr4367415wmr.15.1650636228521; Fri, 22
 Apr 2022 07:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <1650618666-15342-1-git-send-email-quic_sbillaka@quicinc.com> <1650618666-15342-3-git-send-email-quic_sbillaka@quicinc.com>
In-Reply-To: <1650618666-15342-3-git-send-email-quic_sbillaka@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 22 Apr 2022 07:03:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XhznD3Nuiku9mS5YKFVX0GB8qxQZe8m8AgGCQz=a2chQ@mail.gmail.com>
Message-ID: <CAD=FV=XhznD3Nuiku9mS5YKFVX0GB8qxQZe8m8AgGCQz=a2chQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] drm/msm/dp: Support only IRQ_HPD and REPLUG
 interrupts for eDP
To:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        quic_kalyant <quic_kalyant@quicinc.com>,
        "Abhinav Kumar (QUIC)" <quic_abhinavk@quicinc.com>,
        "Kuogee Hsieh (QUIC)" <quic_khsieh@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        quic_vproddut <quic_vproddut@quicinc.com>,
        "Aravind Venkateswaran (QUIC)" <quic_aravindh@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>
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

On Fri, Apr 22, 2022 at 2:11 AM Sankeerth Billakanti
<quic_sbillaka@quicinc.com> wrote:
>
> The panel-edp enables the eDP panel power during probe, get_modes
> and pre-enable. The eDP connect and disconnect interrupts for the eDP/DP
> controller are directly dependent on panel power. As eDP display can be
> assumed as always connected, the controller driver can skip the eDP
> connect and disconnect interrupts. Any disruption in the link status
> will be indicated via the IRQ_HPD interrupts.
>
> So, the eDP controller driver can just enable the IRQ_HPD and replug
> interrupts. The DP controller driver still needs to enable all the
> interrupts.
>
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> ---
> Changes in v9:
>   - add comment explaining the interrupt status register
>
> Changes in v8:
>   - add comment explaining the interrupt status return
>
> Changes in v7:
>   - reordered the patch in the series
>   - modified the return statement for isr
>   - connector check modified to just check for eDP
>
>  drivers/gpu/drm/msm/dp/dp_catalog.c | 16 ++++++++++------
>  drivers/gpu/drm/msm/dp/dp_display.c | 22 +++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 7 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

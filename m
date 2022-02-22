Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC154C03EA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiBVVdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiBVVdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:33:40 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB0A36157
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:33:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bg10so46913203ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2mHyuXRZ8I3kYyoLE5Iu8QS0sxIBaqpluj4s82tM14=;
        b=XU8m9oP18Bpix//+UfSCTLIeU0VonowaQlKnTBNjXvrf7Sh63zBVsvoj6iNCdjssqx
         sOLjMKD1S+Q9lPtN1ITHaXj2KgS6DfyohVrHjXxgbWst8I1vZfKJZ+uE6Zffys1MgxIg
         gsMi91m2uVrFrWU/GnUevsMXhSnRsE9nBQ254=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2mHyuXRZ8I3kYyoLE5Iu8QS0sxIBaqpluj4s82tM14=;
        b=rAiFf5R6caDsy/gHZMs6ej5HrLKdDQMlzXfzDRfETzxMA7dH/K4lcVV4Ut7TAUpVKE
         DQr4xf9lZizChKOT2earpg5/05s8BXsN0XxZnJcWrkbthdmBzwhANJE9aDBJUQ1jlUMY
         zm6hz3wAICykEO65G4uRBLARr6dtW58wyWfBLFFGQpRKrW7Za3xonFloHYuAHNeWetMd
         cowz5GjmHex0/FrHit01asiXxQ75qHJHAFpCC50qRVsoQil80S0SVFQljO1KYbxi9IM/
         z3YrHj0hMsgdv48V5wNFK8HfAnsh861U/e5Up2qa0B+d0gsGw0ZZ7v8NbBLbKxQoDeEo
         41/g==
X-Gm-Message-State: AOAM530ejDfFO6Z0f+/4aa/E6n6+tiaeMjGpT/69BBNcmqJT9ktJnS/q
        QMHDnx25ZhUiHQws4FCGO68tgkT6+5w9M3PaYmw=
X-Google-Smtp-Source: ABdhPJzLjD6X6KkYSh+gORvhax+D6VrIW1tU+QSsISWKgBlVw0CrKaelzktaVCox1tN3NzJvpVSPXw==
X-Received: by 2002:a17:906:3e90:b0:6b6:829b:577c with SMTP id a16-20020a1709063e9000b006b6829b577cmr21759838ejj.711.1645565593399;
        Tue, 22 Feb 2022 13:33:13 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id x12sm10369505edv.57.2022.02.22.13.33.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 13:33:13 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso153554wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:33:13 -0800 (PST)
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id
 s1-20020a7bc381000000b0037be01fc1c0mr4877434wmj.98.1645565592614; Tue, 22 Feb
 2022 13:33:12 -0800 (PST)
MIME-Version: 1.0
References: <1645455086-9359-1-git-send-email-quic_vpolimer@quicinc.com>
 <1645455086-9359-2-git-send-email-quic_vpolimer@quicinc.com>
 <CAA8EJppRUZ5OHSMS1NdFXDDvRXJFNsdoJDWgU7ZPUoAW9OD+eQ@mail.gmail.com>
 <CAD=FV=W2wi47egKmWDS+BZGSy85K+A8jX0gvi6CYhmFgoBBRmw@mail.gmail.com> <c388d91c-ea00-8fa8-3fcf-4ce754edb1b4@linaro.org>
In-Reply-To: <c388d91c-ea00-8fa8-3fcf-4ce754edb1b4@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 13:32:59 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WJdcVEmnUvFfkJY3V2eWF2t4xkfCKNwaFHY+FwORg4VA@mail.gmail.com>
Message-ID: <CAD=FV=WJdcVEmnUvFfkJY3V2eWF2t4xkfCKNwaFHY+FwORg4VA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/msm/dp: Add basic PSR support for eDP
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, quic_kalyant@quicinc.com,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 22, 2022 at 1:23 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 22/02/2022 22:25, Doug Anderson wrote:
> > Hi,
> >
> > On Mon, Feb 21, 2022 at 7:12 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >>> +static int dp_link_psr_status(struct dp_link_private *link)
> >>> +{
> >>> +       u8 status[2];
> >>> +
> >>> +       drm_dp_dpcd_read(link->aux, DP_PSR_ERROR_STATUS, status, 2);
> >>> +
> >>> +       if (status[0] & DP_PSR_LINK_CRC_ERROR)
> >>> +               DRM_ERROR("PSR LINK CRC ERROR\n");
> >>> +       else if (status[0] & DP_PSR_RFB_STORAGE_ERROR)
> >>> +               DRM_ERROR("PSR RFB STORAGE ERROR\n");
> >>> +       else if (status[0] & DP_PSR_VSC_SDP_UNCORRECTABLE_ERROR)
> >>> +               DRM_ERROR("PSR VSC SDP UNCORRECTABLE ERROR\n");
> >>> +       else if (status[1] & DP_PSR_CAPS_CHANGE)
> >>> +               DRM_INFO("PSR Capability Change\n");
> >>
> >> DRM_DEBUG_DP
> >
> > Not sure I'll have time to go back and review the series, but one
> > thing that caught my eye as this flashed through my inbox is that I
> > think all of these "shouting" are deprecated. It's even officially
> > documented now as of commit d2f0a8afc1be ("UPSTREAM: drm/print: Add
> > deprecation notes to DRM_...() functions").
>
> Agreed. But not the DRM_INFO too.

You're saying that DRM_INFO _isn't_ deprecated? I was pretty sure that
it was, too. If not, can you please submit a patch to `drm_print.h`
clarifying since my patch (which folks Acked) marked it as deprecated:

+/* NOTE: this is deprecated in favor of pr_info(). */
 #define DRM_INFO(fmt, ...)                                             \
        _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)

My understanding (also in the description of my patch) was that
DRM_INFO() by itself didn't add much so we should just use the
standard pr_info(). If pr_info() wasn't to your liking then it was
better to do drm_info(drmdev, ...) or drm_info(NULL, ...);

-Doug
